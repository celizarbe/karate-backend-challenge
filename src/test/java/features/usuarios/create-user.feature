@crear-usuario
Feature: Crear usuario

  Background:
    * url baseUrl

  @smoke-test
  Scenario: Crear usuario exitosamente
    * def requestBody =
    """
    {
      "firstName": "Cesar",
      "lastName": "QA",
      "age": 32,
      "email": "cesar.qa@test.com"
    }
    """

    Given path 'users', 'add'
    And request requestBody
    When method POST
    Then status 201
    And match response contains read('classpath:features/schemas/user-schema.json')
    And match response.id == '#number'
    And match response.firstName == requestBody.firstName
    And match response.email == requestBody.email
    And assert responseTime < 3000

  @negative-test
  Scenario: Crear usuario inválido

    Given path 'users', 'add'
    And request "{ invalid-json }"
    When method POST
    Then status 400
