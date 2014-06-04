'use strict';

angular
  .module('angularArenaApp', [
    'ngResource',
    'ngRoute'
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .when('/entries', {
        templateUrl: 'views/entries.html',
        controller: 'EntriesCtrl'
      })
      .when('/tabs', {
        templateUrl: 'views/tabs.html',
        controller: 'TabsCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
