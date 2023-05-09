# @version ^0.3.7

interface Holder: 
    def postDownloadLink(dlLink: String[100]): nonpayable
    def savePost(post: Post): nonpayable
    def viewPost(link: String[100]) -> Post: nonpayable
    
enum PostStatus:
    AVAILABLE 
    UNAVAILABLE 

struct Sprite:
    name: String[35]
    linkIcon: String[50]
    pixelSizeWidth: uint256
    pixelSizeHeight: uint256
    fileSize: uint256
    
struct Post: #estructura que postea el sprite en un link
    sprite: Sprite
    sender: address
    receiver: address
    downloadLink: String[100]
    uploadDate: uint256
    price: uint256
    status: PostStatus
    
owner: address

sprites: HashMap[String[35], Sprite]
posts: HashMap[String[100], Post]

@external
def __init__():
    self.owner = msg.sender
    
@external
def postSprite(name: String[35], receiverAddress: address, dlLink: String[100], pr: uint256):
    assert msg.sender == self.owner, "Solo puede ser ejecutada por owner."
    spriteToPost: Sprite = self.sprites[name]
    assert spriteToPost.name != empty(String[35]), "No existe tal sprite."
    post: Post = Post({sprite: spriteToPost, sender: self.owner, receiver: receiverAddress, downloadLink: dlLink, uploadDate: block.timestamp, price: pr, status: PostStatus.UNAVAILABLE})
    holder: Holder = Holder(receiverAddress)
    holder.savePost(post)
    
@external
def createSprite(newName: String[35], newLinkIcon: String[50], pixelW: uint256, pixelH: uint256, size: uint256):
    assert msg.sender == self.owner, "Solo ejecutable por owner."
    newSprite: Sprite = Sprite({name: newName, linkIcon: newLinkIcon, pixelSizeWidth: pixelW, pixelSizeHeight: pixelH, fileSize: size})
    self.sprites[newName] = newSprite

@view
@external
def viewSprite(viewName: String[35]) -> Sprite:
    assert msg.sender == self.owner, "Solo ejecutable por owner."
    viewSprite: Sprite = self.sprites[viewName]
    assert viewSprite.name != empty(String[35]), "No existe tal sprite."
    return viewSprite