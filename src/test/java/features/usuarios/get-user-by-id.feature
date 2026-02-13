@obtener-usuario-por-id
Feature: Obtener usuario por ID

  Background:
    * url baseUrl

  @smoke-test
  Scenario: Obtener usuario existente
    Given path 'users', 1
    When method GET
    Then status 200
    And match response contains read('classpath:features/schemas/user-schema.json')
    And assert responseTime < 3000

  @negative-test
  Scenario: Obtener usuario inexistente
    Given path 'users', 999999
    When method GET
    Then status 404
