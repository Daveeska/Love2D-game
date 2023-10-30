function collideWith(p1, p2)
    return p1.x < p2.x + p2.width and
           p1.x + p1.width > p2.x and
           p1.y < p2.y + p2.height and
           p1.y + p1.height > p2.y
end
