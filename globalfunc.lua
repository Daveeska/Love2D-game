function loadpurpleimg(file, w, h)
    local dat = love.image.newImageData(file)
    dat:mapPixel(function(x,y,r,g,b,a)
        if r==1 and g==0 and b==1 then
            return 0,0,0,0
        else
            return r,g,b,a
        end
    end, 0,0, w,h)
    return love.graphics.newImage(dat)
end

function boxToPolygon(box)
    return {
        box.x, box.y,
        box.x + box.width, box.y,
        box.x + box.width, box.y + box.height,
        box.x, box.y + box.height
    }
end
