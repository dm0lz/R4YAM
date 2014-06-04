'use strict';

angular.module('angularArenaApp')

  .controller('TabsCtrl', function ($scope){

    $scope.tab = 1;

    $scope.setTab = function(tab){
      $scope.tab = tab;
    };

    $scope.isSelected = function(tab){
      return $scope.tab === tab;
    };
  
  });
