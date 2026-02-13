@actualizar-usuario
Feature: Actualizar usuario

  Background:
    * url baseUrl

  @smoke-test
  Scenario: Actualizar usuario existente
    * def updateBody =
    """
    {
      "firstName": "New Name",
      "age": 33
    }
    """

    Given path 'users', 1
    And request updateBody
    When method PUT
    Then status 200
    And match response.id == 1
    And match response.firstName == updateBody.firstName
    And match response.age == updateBody.age
    And assert responseTime < 3000

  @negative-test
  Scenario: Actualizar usuario inexistente
    * def updateBody =
    """
    {
      "firstName": "QA"
    }
    """

    Given path 'users', 999999
    And request updateBody
    When method PUT
    Then status 404
