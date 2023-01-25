
var FoodTruck = function (arg) {
  this.city_id = arg.city_id
  this.dayorder = arg.dayorder
  this.dayofweekstr = arg.dayofweekstr
  this.starttime = arg.starttime
  this.endtime = arg.endtime
  this.permit = arg.permit
  this.location = arg.location
  this.locationdesc = arg.locationdesc
  this.optionaltext = arg.optionaltext
  this.locationid = arg.locationid
  this.start24 = arg.start24
  this.end24 = arg.end24
  this.cnn = arg.cnn
  this.block = arg.blocks
  this.lot = arg.lot
  this.coldtruck = arg.coldtruck
  this.applicant = arg.applicant
  this.x = arg.x
  this.y = arg.y
  this.latitude = arg.latitude
  this.longitude = arg.longitude
  this.location_2 = arg.location_2
}

var LatLng = function (arg) {
  this.lat = arg["lat"]
  this.lng = arg["lng"]
}
var Hooks = {}
Hooks.Map = {
  // Initializes the Google Map
  initMap() {
    const myLatLng = new LatLng({ lat: 37.7749, lng: -122.4194 })
    const map = new google.maps.Map(document.getElementById("map"), {
      zoom: 12,
      center: myLatLng,
    })
    this.placeFoodTruckMarkers(map)
  },

  foodTrucks() {
    let trucks = this.el.dataset.food_trucks;
    let parsed = JSON.parse(trucks).map(data => new FoodTruck(data))
    return parsed;
  },

  placeFoodTruckMarkers(map) {
    this.foodTrucks().forEach((foodTruck) => {

      const marker = new google.maps.Marker({
        position: { lat: parseFloat(foodTruck.latitude), lng: parseFloat(foodTruck.longitude) },
        map,
        icon: (foodTruck.coldtruck == "N") ? "images/icon-green-48.png" : "images/icon-blue-48.png",
        // icon: "https://icons.iconarchive.com/icons/icons-land/vista-map-markers/16/Map-Marker-Ball-Azure-icon.png"
      })

      const infowindow = new google.maps.InfoWindow({ content: this.genInfo(foodTruck) })

      marker.addListener("click", () => {
        infowindow.open({
          anchor: marker,
          map,
          shouldFocus: true,
        })
      })

    })
  },

  genInfo(foodTruck) {
    const c = foodTruck
    const str = [
      `<h2>${c.applicant}</h2>`,
      `<ul>`,
      `<li>Lan/Lon: <button>${c.longitude}, ${c.latitude}</button> </li>`,
      `<li> Open: ${c.starttime}</li>`,
      `<li> Close: ${c.endtime} </li>`,
      `<li> ColdTruck: ${c.coldtruck} </li>`,
      `<li> Day of Week: ${c.dayofweekstr} </li>`,
      "</ul>"
    ].join("")

    return str;
  },


  //  Returns a latitude and longitude geocoded from the search address bar
  //  @returns {LatLng}
  searchAddressLatLng() { return new LatLng(JSON.parse(this.el.dataset.search_address_lat_lng)) },


  //  Updates the Google Map when some address is searched

  searchMap() {
    const myLatLng = this.searchAddressLatLng();
    const map = new google.maps.Map(document.getElementById("map"), {
      zoom: 18,
      center: myLatLng,
    })
    this.addSearchedAddressMarker(map, myLatLng)
    this.placeFoodTruckMarkers(map)
  },

  //  Adds marker for an address entered in the search
  addSearchedAddressMarker(map, myLatLng) {
    const searchedInfoWindow = new google.maps.InfoWindow({
      content: `Food nearby?`,
    })
    const searchedAddress = new google.maps.Marker({
      position: myLatLng,
      map,
      icon: "/images/icon-green.48.png"
    })
    searchedInfoWindow.open({
      anchor: searchedAddress,
      map,
      shouldFocus: false,
    })
    searchedAddress.addListener("click", () => {
      searchedInfoWindow.open({
        anchor: searchedAddress,
        map,
        shouldFocus: false,
      })
    })
  },


  // Update 
  updateMapMarker() {
    // this.initMap()
    const myLatLng = new LatLng({ lat: 37.7622, lng: - 122.412531 })
    const map = new google.maps.Map(document.getElementById("map"), {
      zoom: 14,
      center: myLatLng,
    })
    this.placeFoodTruckMarkers(map)
  },

  //  Built in mounted method used to initilize the map
  //  Docs: https://hexdocs.pm/phoenix_live_view/js-interop.html#client-hooks-via-phx-hook

  mounted() {
    window.initMap = this.initMap()
  },

  //  Built in updated method used when updating map
  //  Docs: https://hexdocs.pm/phoenix_live_view/js-interop.html#client-hooks-via-phx-hook
  updated() {
    // this.searchMap()
    this.updateMapMarker()
  },

  beforeUpdate() {
    this.placeFoodTruckMarkers()
  }
}
export default Hooks;