@regression
Feature: Regresión de ciclo de vida completo de usuario

  Background:
    * url baseUrl

  Scenario: Validar actualización y eliminación sobre usuario existente

    # Crear usuario
    * def createBody =
    """
    {
      "firstName": "Regression",
      "lastName": "Test",
      "age": 31,
      "email": "regression@test.com"
    }
    """

    Given path 'users', 'add'
    And request createBody
    When method POST
    Then status 201
    And match response contains read('classpath:features/schemas/user-schema.json')

    # Usar un ID existente para evitar inconsistencias del mock
    * def userId = 1

    # Actualizar usuario existente
    * def updateBody =
    """
    {
      "age": 35
    }
    """

    Given path 'users', userId
    And request updateBody
    When method PUT
    Then status 200
    And match response.id == userId
    And match response.age == updateBody.age

    # Eliminar usuario existente
    Given path 'users', userId
    When method DELETE
    Then status 200
    And match response.id == userId
