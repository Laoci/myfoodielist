import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const element = document.createElement('i');
    element.classList.add("marker", "fas", "fa-map-pin")

    if (marker.info_window) {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window);

      new mapboxgl.Marker(element)
        .setLngLat([marker.longitude, marker.latitude])
        .setPopup(popup)
        .addTo(map);
    } else {
      new mapboxgl.Marker(element)
        .setLngLat([marker.longitude, marker.latitude])
        .addTo(map);
    }
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach((marker) => {
    bounds.extend([marker.longitude, marker.latitude])});
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const initMapbox = () => {
  const listMapElement = document.getElementById('listmap');
  const restoMapElement = document.getElementById('restomap');

  // For List Map
  if (listMapElement) { // only build a map if there's an element to inject into
    mapboxgl.accessToken = listMapElement.dataset.mapboxApiKey;
    const listMap = new mapboxgl.Map({
      container: 'listmap',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    const markers = JSON.parse(listMapElement.dataset.markers)
    addMarkersToMap(listMap, markers)
    fitMapToMarkers(listMap, markers);
  }

  // For Resto Map
  if (restoMapElement) { // only build a map if there's an element to inject into
    mapboxgl.accessToken = restoMapElement.dataset.mapboxApiKey;
    const restoMap = new mapboxgl.Map({
      container: 'restomap',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    const markers = JSON.parse(restoMapElement.dataset.markers)
    addMarkersToMap(restoMap, markers)
    fitMapToMarkers(restoMap, markers);
  }
};

export { initMapbox };
