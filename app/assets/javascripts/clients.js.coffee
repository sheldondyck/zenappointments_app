#app = angular.module("ZenAppointmentsApp", ["ngResource"])
#
#app.factory "Client", ["$resource", ($resource) ->
#  $resource("/clients/:id", {id: "@id"}, {update: {method: "PUT"}})
#]
#
#@ClientCtrl = ["$scope", "Client", ($scope, Client) ->
#  $scope.clients = Client.query()
#]
