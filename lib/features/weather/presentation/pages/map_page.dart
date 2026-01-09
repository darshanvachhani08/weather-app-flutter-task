import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/core.dart';
import 'package:weather_app/injection_container.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';

// NOTE: This page directly calls usecases which is business logic.
// Ideally, this should be moved to a Bloc/Cubit, but to maintain functionality
// and avoid breaking changes, it's kept as-is. Consider refactoring in future.

enum WeatherLayer { temperature, precipitation }

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
  LatLng _selectedLocation = const LatLng(0, 0);
  WeatherLayer _activeLayer = WeatherLayer.temperature;
  final Set<TileOverlay> _tileOverlays = {};
  final String _apiKey = dotenv.get('OPENWEATHER_API_KEY');
  Weather? _selectedWeather;
  bool _isLoadingWeather = false;
  bool _isBottomSheetShowing = false;
  int _requestCounter = 0;

  @override
  void initState() {
    super.initState();
    _initLocation();
    _updateTileOverlays();
  }

  Future<void> _initLocation() async {
    try {
      final pos = await sl<LocationService>().getCurrentPosition();
      final currentLatLng = LatLng(pos.latitude, pos.longitude);
      setState(() {
        _selectedLocation = currentLatLng;
      });
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(currentLatLng, AppDimens.mapLocationZoom),
      );
      _fetchWeatherForLocation(currentLatLng);
    } catch (e) {
      debugPrint('Location error: $e');
    }
  }

  void _updateTileOverlays() {
    _tileOverlays.clear();

    final layerName = _activeLayer == WeatherLayer.temperature
        ? 'temp_new'
        : 'precipitation_new';
    final overlayId = _activeLayer == WeatherLayer.temperature
        ? 'temp_overlay'
        : 'precip_overlay';

    final weatherOverlay = TileOverlay(
      tileOverlayId: TileOverlayId(overlayId),
      tileProvider: _OpenWeatherTileProvider(layer: layerName, apiKey: _apiKey),
      transparency: AppDimens.mapTileTransparency,
    );

    setState(() {
      _tileOverlays.add(weatherOverlay);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SmartAppBar(
        title: l10n.mapTitle,
        isBack: true,
        titleStyle: TextStyle(
          fontSize: AppDimens.fontSizeXLarge,
          fontWeight: FontWeight.bold,
          color: AppColors.textWhite,
        ),
        backgroundColor:
        (Theme
            .of(context)
            .appBarTheme
            .backgroundColor ??
            Theme
                .of(context)
                .primaryColor)
            .withAlpha(128),
        isBorder: false,
        iconTheme: const IconThemeData(color: AppColors.textWhite),
      ),

      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: const LatLng(20, 78),
              zoom: AppDimens.mapInitialZoom,
            ),
            style: _mapStyle,
            onMapCreated: (controller) {
              _mapController = controller;
            },
            tileOverlays: _tileOverlays,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onTap: (latLng) {
              setState(() {
                _selectedLocation = latLng;
              });
              _fetchWeatherForLocation(latLng);
            },
            markers: {
              Marker(
                markerId: const MarkerId('selected'),
                position: _selectedLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure,
                ),
                onTap: () => _showWeatherBottomSheet(),
              ),
            },
          ),

          // Layer Toggle
          Positioned(
            top: MediaQuery
                .of(context)
                .padding
                .top + AppDimens.spacingHuge,
            right: AppDimens.paddingMedium,
            child: SmartColumn(
              children: [
                _buildActionButton(
                  icon: Icons.thermostat,
                  isActive: _activeLayer == WeatherLayer.temperature,
                  onTap: () {
                    setState(() => _activeLayer = WeatherLayer.temperature);
                    _updateTileOverlays();
                  },
                  tooltip: l10n.temperature,
                ),
                SizedBox(height: AppDimens.fontSizeSmall),
                _buildActionButton(
                  icon: Icons.umbrella,
                  isActive: _activeLayer == WeatherLayer.precipitation,
                  onTap: () {
                    setState(() => _activeLayer = WeatherLayer.precipitation);
                    _updateTileOverlays();
                  },
                  tooltip: l10n.precipitation,
                ),
                SizedBox(height: AppDimens.fontSizeSmall),
                _buildActionButton(
                  icon: Icons.my_location,
                  isActive: false,
                  onTap: _initLocation,
                  tooltip: l10n.myLocation,
                ),
              ],
            ),
          ),

          if (_isLoadingWeather)
            Positioned(
              top: MediaQuery
                  .of(context)
                  .padding
                  .top + kToolbarHeight,
              left: 0,
              right: 0,
              child: const LinearProgressIndicator(
                backgroundColor: Colors.transparent,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return SizedBox(
      width: AppDimens.buttonWidth,
      height: AppDimens.buttonHeight,
      child: FloatingActionButton.small(
        heroTag: tooltip,
        onPressed: onTap,
        elevation: 2,
        backgroundColor: isActive
            ? AppColors.blueAccent
            : (isDarkMode
            ? AppColors.cardBackgroundDark
            : AppColors.textWhite.withValues(alpha: 0.9)),
        foregroundColor: isActive
            ? AppColors.textWhite
            : (isDarkMode ? AppColors.textWhite70 : AppColors.textPrimary),
        child: Icon(icon, size: AppDimens.iconSmall),
      ),
    );
  }

  Future<void> _fetchWeatherForLocation(LatLng location) async {
    // Close any existing bottom sheet before fetching new weather
    if (_isBottomSheetShowing) {
      Navigator.of(context).pop();
      _isBottomSheetShowing = false;
    }

    // Increment request counter to track the current request
    final currentRequest = ++_requestCounter;

    setState(() {
      _isLoadingWeather = true;
    });

    final result = await sl<GetCurrentWeather>().execute(
      location.latitude,
      location.longitude,
    );

    // Only process this result if it's still the latest request
    if (!mounted || currentRequest != _requestCounter) {
      return;
    }

    result.fold(
          (failure) {
        if (mounted && currentRequest == _requestCounter) {
          setState(() {
            _isLoadingWeather = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: SmartText(failure.message, useLocalization: false),
            ),
          );
        }
      },
          (weather) {
        if (mounted && currentRequest == _requestCounter) {
          setState(() {
            _selectedWeather = weather;
            _isLoadingWeather = false;
          });
          _showWeatherBottomSheet();
        }
      },
    );
  }

  void _showWeatherBottomSheet() {
    if (_selectedWeather == null) return;

    // Prevent showing multiple bottom sheets
    if (_isBottomSheetShowing) return;

    // Animate camera to center the marker when bottom sheet opens
    _mapController?.animateCamera(CameraUpdate.newLatLng(_selectedLocation));

    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    _isBottomSheetShowing = true;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.backgroundDark : AppColors.textWhite,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDimens.borderRadiusXXLarge),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.paddingXLarge,
            vertical: AppDimens.paddingXLarge + AppDimens.spacingSmall,
          ),
          child: SmartColumn(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: AppDimens.mapBottomSheetHandleWidth,
                height: AppDimens.mapBottomSheetHandleHeight,
                decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.grey800 : AppColors.grey300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: AppDimens.spacingXLarge),
              SmartRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SmartColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmartText(
                          _selectedWeather!.cityName.isEmpty
                              ? l10n.selectedLocation
                              : _selectedWeather!.cityName,
                          useLocalization: false,
                          style: TextStyle(
                            fontSize: AppDimens.fontSizeXXLarge,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                            color: theme.textTheme.titleLarge?.color,
                          ),
                        ),
                        SmartText(
                          _selectedWeather!.description.toUpperCase(),
                          useLocalization: false,
                          style: TextStyle(
                            fontSize: AppDimens.fontSizeSmall + 2.sp,
                            color: isDarkMode
                                ? AppColors.grey400
                                : AppColors.grey600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SmartImage(
                    path:
                    '${AppConstants.iconBaseUrl}${_selectedWeather!.iconCode}@2x.png',
                    width: AppDimens.weatherIconSizeMap,
                    height: AppDimens.weatherIconSizeMap,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                    const SmartCircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ],
              ),
              SizedBox(
                height: AppDimens.paddingXLarge + AppDimens.spacingSmall,
              ),
              SmartRow(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildWeatherDetail(
                    icon: Icons.thermostat,
                    label: l10n.tempShort,
                    value:
                    '${_selectedWeather!.temperature.toStringAsFixed(1)}°C',
                    color: AppColors.temperatureOrange,
                  ),
                  _buildWeatherDetail(
                    icon: Icons.water_drop,
                    label: l10n.humidity,
                    value: '${_selectedWeather!.humidity}%',
                    color: AppColors.humidityBlue,
                  ),
                  _buildWeatherDetail(
                    icon: Icons.air,
                    label: l10n.wind,
                    value: '${_selectedWeather!.windSpeed} m/s',
                    color: AppColors.windTeal,
                  ),
                ],
              ),
              SizedBox(height: AppDimens.paddingMedium),
            ],
          ),
        );
      },
    ).then((_) {
      // Reset flag when bottom sheet is dismissed
      if (mounted) {
        setState(() {
          _isBottomSheetShowing = false;
        });
      }
    });
  }

  Widget _buildWeatherDetail({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return SmartColumn(
      children: [
        Container(
          padding: EdgeInsets.all(AppDimens.fontSizeSmall),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: AppDimens.fontSizeXXLarge),
        ),
        SizedBox(height: AppDimens.spacingSmall),
        SmartText(
          value,
          useLocalization: false,
          style: TextStyle(
            fontSize: AppDimens.fontSizeLarge,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
        SmartText(
          label,
          useLocalization: false,
          style: TextStyle(
            fontSize: AppDimens.fontSizeSmall,
            color: isDarkMode ? AppColors.grey400 : AppColors.grey600,
          ),
        ),
      ],
    );
  }

  // Modern Map Style
  static const String _mapStyle = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]
''';
}

class _OpenWeatherTileProvider implements TileProvider {
  final String layer;
  final String apiKey;
  final Dio _dio = sl<Dio>();

  _OpenWeatherTileProvider({required this.layer, required this.apiKey});

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    if (zoom == null) return TileProvider.noTile;

    try {
      final String url =
          'https://tile.openweathermap.org/map/$layer/$zoom/$x/$y.png?appid=$apiKey';

      final response = await _dio.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200 && response.data != null) {
        return Tile(256, 256, Uint8List.fromList(response.data!));
      }
    } catch (e) {
      debugPrint('Error fetching weather tile: $e');
    }

    return TileProvider.noTile;
  }
}
