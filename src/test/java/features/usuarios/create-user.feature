@crear-usuario
Feature: Crear usuario

  Background:
    * url baseUrl

  @smoke-test
  Scenario Outline: Crear usuario exitosamente
    * def requestBody =
    """
    {
      "firstName": "<firstName>",
      "lastName": "<lastName>",
      "age": <age>,
      "email": "<email>"
    }
    """

    Given path 'users', 'add'
    And request requestBody
    When method POST
    Then status 201
    And match response contains read('classpath:features/schemas/user-schema.json')
    And match response.id == '#number'
    And match response.firstName == '<firstName>'
    And match response.email == '<email>'
    And assert responseTime < 3000

    Examples:
      | firstName | lastName | age | email                  |
      | Cesar     | QA       | 32  | cesar.qa@test.com      |
      | Ana       | PO       | 38  | ana.po@test.com        |
      | Luis      | Dev      | 25  | luis.dev@test.com      |

  @negative-test
  Scenario: Crear usuario inválido

    Given path 'users', 'add'
    And request "{ invalid-json }"
    When method POST
    Then status 400
