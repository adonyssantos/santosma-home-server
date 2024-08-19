from fastapi import FastAPI, Response
from generate_feed_with_feedgenerator import generate_feed, instaloader_to_dict as post_adapter
from get_posts_with_instaloader import get_posts

app = FastAPI()

@app.get("/feed/{account}")
async def read_feed(account: str):
    posts = get_posts(account)
    adapted_posts = [post_adapter(post) for post in posts]
    feed = generate_feed(account, adapted_posts)
    return Response(content=feed, media_type="application/xml")
