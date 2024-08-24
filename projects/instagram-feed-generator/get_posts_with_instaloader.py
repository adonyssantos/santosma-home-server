import instaloader

def get_posts(profile_name: str, limit=10):
    loader = instaloader.Instaloader()
    profile = instaloader.Profile.from_username(loader.context, profile_name)
    posts = profile.get_posts()
    result = []
    
    for i, post in enumerate(posts, start=1):
        result.append(post)
        if i == limit:
            break
    
    return result
