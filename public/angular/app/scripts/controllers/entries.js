'use strict';

angular.module('angularArenaApp')
  
  .controller('EntriesCtrl', function ($scope, $resource){

    $scope.testText = "Entries";

    var apiEntries = $resource( "http://localhost:3000/api/v1/entries/:id", { id: "@id" }, { update: {method: 'PUT'} } );
    $scope.entries = apiEntries.query();

    $scope.addEntry = function(entry){
      entry = apiEntries.save(entry);
      //$scope.entry.createdOn = Date.now();
      $scope.entries.unshift(entry);
      $scope.entry = {};
    };

    $scope.deleteEntry = function(entry){
      apiEntries.remove({ id:entry._id["$oid"] },entry);
      var index = $scope.entries.indexOf(entry);
      $scope.entries.splice(index, 1);
    };

    $scope.updateEntry = function(entry){
      apiEntries.update({ id:entry._id["$oid"] },entry);
      var index = $scope.entries.indexOf(entry);
      $scope.entries[index] = entry;
    };

    $scope.flagEntry = function(entry){
      entry.flag = (entry.flag === true) ? false : true ;
    };

  });