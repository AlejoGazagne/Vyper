import pytest
import brownie
import uuid

@pytest.fixture
def spriteCreator_contract(spriteCreator, accounts):
    yield spriteCreator.deploy({'from': accounts[0]})

def test_create_sprite(spriteCreator_contract): 
    newName = "mati"
    newLinkIcon = "http://niIdeaComoEraEsto.com"
    pixelW = 123
    pixelH = 325
    size = pixelW*pixelH
    spriteCreator_contract.createSprite(newName, newLinkIcon, pixelW, pixelH, size)
    Sprite = spriteCreator_contract.viewSprite(newName)
    assert(Sprite[0] == newName)

def test_view_sprite(spriteCreator_contract):
    newName = "mati"
    newLinkIcon = "http://niIdeaComoEraEsto.com"
    pixelW = 123
    pixelH = 325
    size = pixelW*pixelH
    spriteCreator_contract.createSprite(newName, newLinkIcon, pixelW, pixelH, size)
    name = "mati"
    #name = "Alejo"
    Sprite = spriteCreator_contract.viewSprite(name)
    assert(Sprite[0] == name)