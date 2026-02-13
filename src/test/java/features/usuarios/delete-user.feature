@eliminar-usuario
Feature: Eliminar usuario

  Background:
    * url baseUrl

  @smoke-test
  Scenario: Eliminar usuario existente
    Given path 'users', 1
    When method DELETE
    Then status 200
    And match response.id == 1
    And assert responseTime < 3000

  @negative-test
  Scenario: Eliminar usuario inexistente
    Given path 'users', 999999
    When method DELETE
    Then status 404
