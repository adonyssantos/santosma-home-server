from feedgen.feed import FeedGenerator
from datetime import datetime, timezone

def generate_feed(account: str, posts: list):
    fg = FeedGenerator()
    fg.title(account)
    fg.link(href=f"https://www.instagram.com/{account}/", rel="alternate")
    fg.description(f"Instagram feed for {account}")
    fg.language("en")
    fg.lastBuildDate(datetime.now(timezone.utc).strftime("%a, %d %b %Y %H:%M:%S %z"))

    for post in posts:
        fe = fg.add_entry()
        fe.title(post["caption"][:100] + "...")
        fe.description(post["caption"])
        fe.link(href=post["url"])
        fe.pubDate(post["date"])
        fe.author(name=post["author"])
        fe.enclosure(url=post["cover_image"], type="image/jpeg")

    return fg.rss_str(pretty=True)

def instaloader_to_dict(post):
    return {
        "id": post.mediaid,
        "shortcode": post.shortcode,
        "caption": post.caption,
        "cover_image": post.url,
        "date": post.date_utc.replace(tzinfo=timezone.utc).strftime("%a, %d %b %Y %H:%M:%S %z"),
        "url": f"https://www.instagram.com/p/{post.shortcode}/",
        "author": post.owner_username,
    }
