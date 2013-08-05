var $d = $(document);
$d.bind('deck.init',
    function() {
        var map = new OpenLayers.Map('mnr-demo-map', {
            projection: new OpenLayers.Projection("EPSG:900913"),
            displayProjection: new OpenLayers.Projection("EPSG:4326"),
            units: 'm',
            fractionalZoom: true
        });

        var lbs = new OpenLayers.Layer.XYZ("TomTom Sydney LBS",
                ["http://a.routes.tomtom.com/lbs/map/1/basic/${z}/${x}/${y}/1e2099c7-eea9-476b-aac9-b20dc7100af1;v=3;l=nl;m=png"],
                {
                    layers:'basic',
                    resolutions: [156543.03390625, 78271.516953125, 39135.7584765625,
                          19567.87923828125, 9783.939619140625, 4891.9698095703125,
                          2445.9849047851562, 1222.9924523925781, 611.4962261962891,
                          305.74811309814453, 152.87405654907226, 76.43702827453613,
                          38.218514137268066, 19.109257068634033, 9.554628534317017,
                          4.777314267158508, 2.388657133579254, 1.194328566789627,
                          0.5971642833948135, 0.25, 0.1, 0.05],
                    serverResolutions: [156543.03390625, 78271.516953125, 39135.7584765625,
                                        19567.87923828125, 9783.939619140625,
                                        4891.9698095703125, 2445.9849047851562,
                                        1222.9924523925781, 611.4962261962891,
                                        305.74811309814453, 152.87405654907226,
                                        76.43702827453613, 38.218514137268066,
                                        19.109257068634033, 9.554628534317017,
                                        4.777314267158508, 2.388657133579254],
                    transitionEffect: 'resize'
                }
        );

        /* Note: beware of same-origin-policy. */
        info = new OpenLayers.Control.WMSGetFeatureInfo({
            url: 'http://bekka-desktop:8080/geoserver/mnr-pilot/wms', 
            title: 'Identify features by clicking',
            queryVisible: true,
            eventListeners: {
                getfeatureinfo: function(event) {
                    map.addPopup(new OpenLayers.Popup.FramedCloud(
                        "chicken", 
                        map.getLonLatFromPixel(event.xy),
                        null,
                        event.text,
                        null,
                        true
                    ));
                }
            }
        });
        
        var mousePositionCtrl = new OpenLayers.Control.MousePosition();

        /* DIFF demo */
        registerLayer("02 Added JUNCTIONS", "mnr-pilot:ADDED_Junction", map);
        registerLayer("02 Added NETW_ROUTE_LINK", "mnr-pilot:ADDED_Netw_Route_Link", map);
        registerLayer("02 Added NETW_GEO_LINK", "mnr-pilot:ADDED_Netw_Geo_Link", map);
        registerLayer("02 Updated JUNCTIONS", "mnr-pilot:UPDATED_Junction", map);
        registerLayer("02 Updated NETW_ROUTE_LINK", "mnr-pilot:UPDATED_Netw_Route_Link", map);
        registerLayer("02 Updated NETW_GEO_LINK", "mnr-pilot:UPDATED_Netw_Geo_Link", map);
        registerLayer("02 Removed JUNCTIONS", "mnr-pilot:REMOVED_Junction", map);
        registerLayer("02 Removed NETW_ROUTE_LINK", "mnr-pilot:REMOVED_Netw_Route_Link", map);
        registerLayer("02 Removed NETW_GEO_LINK", "mnr-pilot:REMOVED_Netw_Geo_Link", map);

        registerLayer("03 Added JUNCTIONS", "mnr-pilot:ADDED_Junction_2", map);
        registerLayer("03 Added NETW_ROUTE_LINK", "mnr-pilot:ADDED_Netw_Route_Link_2", map);
        registerLayer("03 Added NETW_GEO_LINK", "mnr-pilot:ADDED_Netw_Geo_Link_2", map);
        registerLayer("03 Updated JUNCTIONS", "mnr-pilot:UPDATED_Junction_2", map);
        registerLayer("03 Updated NETW_ROUTE_LINK", "mnr-pilot:UPDATED_Netw_Route_Link_2", map);
        registerLayer("03 Updated NETW_GEO_LINK", "mnr-pilot:UPDATED_Netw_Geo_Link_2", map);
        registerLayer("03 Removed JUNCTIONS", "mnr-pilot:REMOVED_Junction_2", map);
        registerLayer("03 Removed NETW_ROUTE_LINK", "mnr-pilot:REMOVED_Netw_Route_Link_2", map);
        registerLayer("03 Removed NETW_GEO_LINK", "mnr-pilot:REMOVED_Netw_Geo_Link_2", map);

        registerLayer("MNSHAPE nw_updated", "mnr-pilot:nw_updated", map);
        registerLayer("MNSHAPE nw_removed", "mnr-pilot:nw_removed", map);
        registerLayer("MNSHAPE nw_added", "mnr-pilot:nw_added", map);
        registerLayer("MNSHAPE jc_updated", "mnr-pilot:jc_updated", map);
        registerLayer("MNSHAPE jc_removed", "mnr-pilot:jc_removed", map);
        registerLayer("MNSHAPE jc_added", "mnr-pilot:jc_added", map);

        map.addLayer(lbs);

        map.addControl(new OpenLayers.Control.LayerSwitcher());
        map.addControl(info);
        info.activate();

        var lonlat = new OpenLayers.LonLat(1.56, 42.54);
        lonlat.transform( new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject() );
        map.setCenter(lonlat, 12);

        var toolbar = $("#mnr-demo-map-zones");
        addZone(toolbar, "Andorra", 1.56, 42.54, map);
        addZone(toolbar, "Ghent", 3.72, 51.05, map);
});

function addZone(toolbar, name, lon, lat, map) {
    $('&lt;a&gt;',{
            text: name,
            title: name,
            href: '#',
            click: function() {
                var lonlat = new OpenLayers.LonLat(lon, lat);
                lonlat.transform( new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject() );
                map.setCenter(lonlat, 12); }
        }).appendTo(toolbar);
    $('&lt;span /&gt;', {style: 'padding-left: 10px'}).appendTo(toolbar);
}

function registerLayer(title, name, map) {
    var layer = new OpenLayers.Layer.WMS(title, "http://bekka-desktop:8080/geoserver/mnr-pilot/wms",
                    {
                        layers: name,
                        srs: 'EPSG:4326',
                        styles: '',
                        tiled: true,
                        transparent: true,
                        format: "image/png",
                        tilesOrigin : map.maxExtent.left + ',' + map.maxExtent.bottom,
                        displayInLayerSwitcher: true
                    },
                    {
                        buffer: 0,
                        displayOutsideMaxExtent: false,
                        isBaseLayer: false,
                        yx : {'EPSG:4326' : true},
                        visibility: false,
                    }
                );
    map.addLayer(layer);
}

