# @version ^0.3.7

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

posts: HashMap[String[100], Post]

@external
def __init__():
    self.owner = msg.sender
    
@external
def postDownloadLink(dlLink: String[100]):
    assert msg.sender == self.owner, "Solo puede ser ejecutada por owner."
    postToCheck: Post = self.posts[dlLink]
    assert postToCheck.status == PostStatus.UNAVAILABLE, "El sprite ya esta disponible a la venta."
    postToCheck.status = PostStatus.AVAILABLE
    self.posts[dlLink] = postToCheck
    
@external
def savePost(post: Post):
    self.posts[post.downloadLink] = post

@view    
@external
def viewPost(link: String[100]) -> Post: 
    post: Post = self.posts[link]
    assert post.downloadLink != empty(String[100]), "No existe tal post."
    return post