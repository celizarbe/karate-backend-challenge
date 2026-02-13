@listar-usuario
Feature: Obtener lista de usuarios

  Background:
    * url baseUrl

  @smoke-test
  Scenario: Obtener usuarios exitosamente
    Given path 'users'
    When method GET
    Then status 200
    And match response.users == '#[]'
    And match response.total == '#number'
    And match each response.users contains read('classpath:features/schemas/user-schema.json')
    And assert responseTime < 3000

  @negative-test
  Scenario: Obtener usuario inexistente
    Given path 'users', 999999
    When method GET
    Then status 404
