load("encoding/base64.star", "base64")
load("http.star", "http")
load("render.star", "render")
load("secret.star", "secret")

API_URL = "https://www.drivebc.ca/data/dms.json"
sign_number = "DMS 11_4"
lane_forward = base64.decode("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")
lane_closed = base64.decode("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")
lane_back = base64.decode("iVBORw0KGgoAAAANSUhEUgAAAJAAAACQCAYAAADnRuK4AAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAkKADAAQAAAABAAAAkAAAAAA/PwqIAAAOaElEQVR4Ae2dWYwcRxnHq7p79gAHC+zYzkVie727ISRB2iOOr8yicCR2fMQHCQpSeAAJHiKk5AGJh0Qo4gEhJQgeAXFEeTAoJDi2k4A9s2M79tprCDx5dhcSJBMCiATFdrzHdBf/6jk0O5mZ7Zmq6u6Z+VpaTR/Vdfzrt199dXQ3Z7SRAgUFBs+PfQG7X8ef/P1o4fS8ECLFPPZc9kj6efYU9so2XrZPux2qwPpTm1Ylurt/xTj7fD0JANIbws09OnXXyT8XwxFARSU69HfD2eRnLIsd4pzfGEwCcVm4bH92NP2KDE8ABVOtLUMNnNl6B3ec46BgRUMFFOwD1xObp0fTbxBADSnXPoGbhqcgAZqzC9lL7Ha7fSShkgRVoH9iy52wPMfQbK0Mek9lOHnvygR7mwCqVKbNjwuWRwmeMolWUhNWpka776o2W5X6CCYEAVSpSpseS3iYY+uyPCWVCKCSFO27Mzi57XbBrOMqPk8tdaxaF+h8eyggLY8peGQT5rSHTFSKagoULI/2ZquUlmCvUxNWUqO9dkw2W0WlPCEeJYCKarTRbxjwyHmx7MvpIWrC2ggcWRQfHm4d46z5QcKlJRHv5ebZfjkzTwAtrVbLhFh/Lvlpwdhxw/BcFh5/4K+bUjNSGGrCWgaP+hmV8DiWD8+19UOqXBWXPcHumxpOnyzGQgAVlWjh36jgkZIRQC0Mjsx6lPDI9AkgqUKLbqHBw8T9U0PjJ6rJRABVU6UFzsUBHikT9cJaAJbKLPad3XybbdxhZle8OpanmCcCqKhEi/z68Nhd6Kozg70tCY93X61mq1wqasLK1Yj5fhk8qwxmNTA8Mg80G2+wJnRGHRY8ruvWdJirlYcsUDVVYnYuTHimRzOZRopPADWiVgRh4wyPlKMqQP7yx4R9ABe3IMz1TLA5/P7d4+yod8U9OLPtxH/kzbSZVSAPTyKFuS2DDjOmJwL0tmqVdBFAt5xNrum2+A85Zwdq3YBp/EtM8Kezh1M/YBXPSde6h843rkBYlidob6tWCUoAFdaQHMa62ZtqBS4/D5BeujI/9/DFTaevlp+nfXUFwoFHXM65fMfMaGpcJcd+L0w+XI91s4HhkQkCtF3Lunp+qpI43fthBfrObP2UnR/nMdpV1wGPzL0PkNPd/eOglmdRkTl7eOBs8pFF5+igaQV8eBIOfB5mGB62XdXyFAtpybczMC72FU80+stt/jQ7yOgJ10aFqwgv4XHwogPT8EifRxc8sggWXu3xELz8ki9UUa4ghzcPrk1uDRKQwlRXYMPpbbdKeNAnXl09hIazeKNGzmXbg0xPNJKaBXg+18gN1cIKzj9b7TydW1oBaXmsLjttGh7Xc7VanmLJHMHFTYCoeNzULx4wC9RzayryNr5JWh7bsY+jiOZ8HlgePP+3vdER5qCyYzaeN/ZyoSoxW5x/rMppOlVHAQmPb3kMw5Pz2P0zo+nxOllRuuTA9vg9MaVY6OaGFPAtT8JO4SbjlsckPLLQBE9DVa8euASPYYdZNlsXRtJp9RzXj8HJv+NFqRdWPwW6WlKgfzI5iP9Y470twbwd2ZHxdClhgztkgQyKWx51AZ4URkzWlJ/Xug+H2YdneFw2j6FsBFAIMrcrPFI6AsgwQO0MTwEgjsepaTOhQLvDIzWjpzJMkIM4Q4OHuw9khzKh+TyVchFAlYpoOB44t3kA42vmHeY8PHIkO7KNANIsvQ8PT2Buy1xvC4v5rjLuScsTKTxSOgvrnckH0gRRAR6jlqcAz444wJMHSJN4nR5NGTzXmdIibvAQQJpqOix45JvB4mJ5itLROFBRiSZ/w4RnajR1rMlsGrsNC8oE+UBNytvp8EjZqBfWJDzrJrb0c+5Ih9mozyObrThanqJs1IQVlWjgV8LTZTuyq97R8EjJCKAGwJFBQ4NHsJ1xtjxF2WQTRj5QUY0lfiU8CSchpw3MWh4Jz0j6D0tkJxaXyQIFrIYiPJiiuD7gLQ0Hk+M86NK0DDyygARQgGomeGqLRL2w2tr4V9ad2bYh4djycWOyPFW0ctCTIB+oijDylA9Pwk4bhmcWn03aNT0y3hI+T6VU1IRVKlI4DhGenYDn9zWyEfvTBFCVKiJ4qohS4xQBVCEMwVMhyBKHFhwg8oEKIhXgMe0wS5+npZutcqaoF/ZheG4oF0jnPsZ5Zl3m7ZoZybSsz1OpBwEERda/nuxzElxaHvPwDGdeq6yEVj7ueB/Ih6eby646wdMEyVgT3bnrgQieJoipuKVjm7Cw4MHLS3fPDLVXs1XOUEc2YWHCc2Eo9Wq54O2233EA+fB0MeMOs7Q87Q6P/GeQAHXMOFAJHs5vNGUJZFe9U+CRGmrxgeCGz5qqEF3x9k1uWo+XWadQuQSPLlERj6YmDI/axnjLw9OVNgoPwxeNPLanE5qt8qrWApBg/IPySOO0Hxo8rtidHU2/Eqeyh5EX+aJxZR8Iz5bFEiCCxzxCbWuBCB7z8MgUtACE4exYWSCCJxx4ZCpaemFejHyg/nNb1nGGTyaZ7G3BYRaet2dqdLzjfJ5KNC18JkPdB/K8WPTCfHi4I3tbxr7dAbHy8IyMH60UsxOPtTRhceiFETzR4KsFoKh9IIInGnhkqloA8pgVmRNN8EQHTwEg9fVAnvAiASg8eNwHp8jnqUqqFgsEpzV0JzpceDJHqqpHJ/V0412RC9UCDUxsW8s5vrfFmeHelrQ8BE+9/xMtFsgSTmgA+fDY/jdGP1mvYCrX8l11gieIhhY8IOVxoFlvLhSAwoAHos17gu0lyxMEH029MGeu2zhAYcHjCvbg9HDqcDD5KJRyEya/ePjWWHrOpJQEj0l11eJWBogLvwem3AzWKgbBU0uZeJwHQGrrgWCBjDVfBE88IKmXC+XZeCxIMwLQ4OnkLczmeJUuM9bbgjDzLhN7p4fT5PPUo6TONWWATFggH54uwMNCgGco/XIdfejSEgqo+0CaLVAZPDcvkXeVy3nLQ/CoaOjfKwFScoBhgbRNYxA8yvUZegQaLBDT4gOFBQ9zvX3TZHm0gaYMEMyXMkBhwnNhdPyQNvUoIvX1QKq9MIKntSnEmmi19UAqvbC+M8kbWb63ZdRhls0WWR4zoCp34zlnTTnR6yaHluNZ9SMoFsFjpm5DiVUZoKYs0MHbuhLsmt9iIdrtBks5Lzx3f3Y0Qz6PQZE1ANTwSDQfXH/tLzCFMmawXHl4RjK/M5gGRQ0FHLxcUmkcqNHn4gcmk98HPA8ZU1+IBSG8/VmCx5jE5RGHaoEGJsceg8/0RHkGtO7n4dlH8GhVtW5kyuNAPOBTqYPnxvZiYvSZurlRuUjwqKjX9L3KAIkAz4T1Tya3CC6eQ3OpnF7VkvrwcGq2qopj9qTDULOwDE1vnNV/JmzD6W234iVEcGZ5T9OJ1LuxBE/qpXrB6JoZBTT4QLWfSr15cut1NrPlGyw+biT7BI8RWRuJVBkgq8ZTqQMnN1/DuCPfYGFmQRjB00g9GwurDJBbzQeaHEpwnngBub7TSM4Bj8fYgakRaraM6NtApNKpVRoHsvhC5VQGH+DX/Aw+z70N5CN40CI8w+kXg99EIU0poNwrygl70XKOwcnk9zBD/4iZDIvLwsN31QkeM/I2EatyEzYrZksA9U+OfRM9um83kY+lbxHinRxzt8+Mnvjj0oEpRFgKKFsg7uYtEMZ6dmOU+UcmMo7PB1xgC+zumWGCx4S+KnE6mE0XaHKaikPee3HT6dm+iXvuRgzPmxgoBDwnr8zP7UI67zaVSbrJqAJqFgjfyBg4t7nfsa1DWJrRqzunWOr2a/ffF+8leHQrqy8+JR8IlgvmK3EUBmyFviyVYnomO5x6HEdKvcRSbLRjRAElgADORwDRWp05Ay0Y4hGPZ4fSz+qMl+Iyo4ADCGLzHy6/tYXcfCU7kv6NmeJSrLoVULNAOnMj2LuY2N2ZHUmd0hktxWVWgVgAhN7cW0wsfDE7ciprtrgUu24F4gDQ+fmFq9vf3DjxL92Fo/jMK4BuvNr7gVSyCMtz9L/viyTBo6JitPdGZoHgMP8ke4l9g42lc9FKQKmrKBAJQHgL6pOYEP2uSsbp3ngoEC5AQuQwbPA1wPPzqIrfd6Sv21u1vEfknJ5u0dvrJVgPPtXQyzzeY9usB5axFyPgPbYl961egV9LsF7GeZfwMOsT8SbkVwE88Q/PY6dmNqYvRpwdPBcGRwSVanxDxVxymbdvZijzGjvI7NXL7+hZvuITvV4OFci83i4Hv6hEZMevNBuVKCsQy/B7kD1UoDxGZcrr2EeucR4V7O+LXoTpKYTpxbSKfx0DXP59GOryoZDXMfCZL20iX2Q5l2NxPGRdmNQpXPUvyn0/cP4OxrG4O+rNz4GNUthC4Bm7k1jS/p2pofETUeWLD06OvQOVVpvOACpzDnOv8xBA/jeHa/lMFy7i+GEZn82+mX6CHWBu2Fkp/N+ZTxbgdMMyYJ00waNbbVjGbw2sG/ul7niDxBcaQEEyQ2GaVwDN7ZexGtTcU781sgaA1N4PVCNeOh2FApw9ecvZ5JowkyYLFKbaxtPiy7os9qjxZMoSIIDKxGiHXXQUd4ZZDgvjClh/Q1u7KIAxmfVhlsXCONB7YSZIaZlVAPW5zGwKi2OXL9n85+JTdNTKCmC87Z0w82+h/ToZZoKUllkFMN42YTaFxbFbnufRewQXa9LSR67nhroc2JoZyfwJ80/yFSy0tbgCaL7+Mn0kE+o7A/xu/MKC9xgg+l+L69fR2cdk9VV8fv2r7Cn5VEt4mw/Q3zZmpoXL92FM+v3wkqaUNCpwhXviS1E8+l0aSJwaTR2DFboLhcpoLBhFZVoBISa83MLmqD7l4C8vqSxj//l7tlrM2oNpsiQGGm/A2psVmKzDohnaolZAuhpYDfQ28iF7zy9cGEq9GmWe/g+d6P3wxZRbAgAAAABJRU5ErkJggg==")
ARROWS_API_URL = "https://b60n09kp22.execute-api.us-west-2.amazonaws.com/prod/getarrows"
ARROWS_API_KEY = secret.decrypt("AV6+xWcEjAB6ZacmRADoIGkvOwLus8+PfPTFHmkQRkwAa581Du8eIsNYWUwMkuK9epGXh9wmfhfoBKGsY/pN2PCtRVHgeZawcXk5+UOG57CjyFm1jftqzJPFIhtebnRYBmb5wRgwXnGgS8e79Mg9DWs6fzRtaLQb1f8Fz9PZiPtYCvLDd9Srfa8EUqeRHQ==")

def fetch_arrow_directions():
    headers = {"x-api-key": ARROWS_API_KEY}
    r = http.get(ARROWS_API_URL, headers = headers, ttl_seconds = 30)
    if r.status_code == 200:
        return r.json().get("arrow_directions", [])
    else:
        return []

def fetch_dms_data():
    r = http.get(API_URL)
    if r.status_code == 200:
        return r.json()
    else:
        return None

def get_sign_by_signNo(dms_data, sign_number):
    for sign in dms_data:
        if sign["location"]["signNo"] == sign_number:
            return sign
    return None

def get_image_src_for_direction(direction):
    """Return the appropriate image src based on arrow direction."""
    if direction == "back":
        return lane_back
    elif direction == "forward":
        return lane_forward
    elif direction == "closed":
        return lane_closed
    else:
        return lane_closed  # default, can be changed as per requirement

def render_dms():
    dms_data = fetch_dms_data()
    arrow_directions = fetch_arrow_directions()
    dms_sign = get_sign_by_signNo(dms_data, sign_number)
    decoded_text = base64.decode(dms_sign["location"]["content"]["pages"][0]["lines"][0]["text"])
    decoded_text = decoded_text.replace("[nl]  ", " - ")
    sign_text = decoded_text.replace("[pt30o2]  ", "")

    lane_icons = []
    if arrow_directions:
        for direction in arrow_directions:
            lane_icons.append(render.Image(src = get_image_src_for_direction(direction), width = 10))
            lane_icons.append(render.Box(width = 11))

        # Remove the last gap after the last icon
        lane_icons.pop()
    else:
        lane_icons.append(render.Marquee(width = 64, child = render.Text("Lane status unavailable", font = "tb-8", color = "#B84")))

    return render.Root(
        child = render.Column(
            children = [
                render.Box(height = 1),
                render.Marquee(width = 64, child = render.Text(sign_text, font = "tb-8", color = "#B84")),
                render.Box(height = 1),
                render.Box(height = 1, color = "#666"),
                render.Box(height = 1),
                render.Text("Lane Status", font = "tom-thumb"),
                render.Box(height = 2),
                render.Row(
                    children = [
                        render.Box(width = 6),  # Initial gap
                    ] + lane_icons + [
                        render.Box(width = 8),  # End gap
                    ],
                ),
            ],
        ),
    )

def main():
    # special case for CI
    if ARROWS_API_KEY == None:
        return []

    return render_dms()
