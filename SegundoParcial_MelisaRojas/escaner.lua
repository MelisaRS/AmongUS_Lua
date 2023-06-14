local composer = require( "composer" )
 
local scene = composer.newScene()

local physics = require "physics"

local fondo 

 function irMenu(event)
    if event.phase == "ended" or event.phase == "cancelled" then
        print(" Cambiando a practice")
        composer.gotoScene("practice", "fade", 500)
    end
    return true
 end


local botonMenu
local textoMenu 

function tocar_botonMenu(event)
  if event.phase == "ended" then
    --self.isVisible = false

  end
  return true
end

function mov_escaner(event)
    if event.phase == "ended" then
        protector.isVisible = true
        protector.alpha = 0.5
        transition.to(scanner, {time = 1000, y=165, onComplete=mov_escanerCabeza})
    end
    return true
end

function mov_escanerCabeza(event)
    --if event.phase == "ended" then
    scanner.isVisible = false
    scannerCabeza.x = scanner.x; scannerCabeza.y = scanner.y
    scannerCabeza.isVisible = true
    transition.to(scannerCabeza, {time = 1000, y=155, onComplete=mov_escanerCabezaAbajo})
    --endonComplete=
    return true
end

function mov_escanerCabezaAbajo(event)
    transition.to(scannerCabeza, {time = 1000, y=165,onComplete=mov_escanerAbajo})
    return true
end

function mov_escanerAbajo(event)
    scannerCabeza.isVisible = false
    scanner.x = scannerCabeza.x; scanner.y = scannerCabeza.y
    scanner.isVisible = true
    transition.to(scanner, {time = 1000, y=CH/2+25, onComplete=mov_fin})
    return true
end

function mov_fin(event)
    scanner.isVisible = false
    protector.isVisible = false
    transition.to(scanner, {time = 2000})
    
    return true
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    physics.start( )
    physics.pause( )
    physics.setDrawMode( "normal" )

    local sceneGroup = self.view

    fondo = display.newImageRect(sceneGroup, rutaAssets.. "escaner.jpg",CW, CH )
    fondo.x, fondo.y = CW/2, CH/2
    --------------------------------
    botonMenu = display.newRoundedRect(CW/2-180, CH/2-50, 81, 33, 4 )
    botonMenu:setFillColor( 0,0,0 )
    textoMenu = display.newText( "MENU", botonMenu.x, botonMenu.y , "Comic Sans MS", 11 )
    botonMenu.isVisible = false
    textoMenu.isVisible = false

    protector = display.newImageRect( rutaAssets.. "protectorAmong.png", 40, 45 )
    protector.x, protector.y = CW/2, CH/2+2
    protector:setFillColor( 0,0,1 )
    protector.isVisible = false
    protector.alpha = 0

    scanner = display.newImageRect( rutaAssets.. "escaner1.png", 75/2+10, 40/2+5 )
    scanner.x = CW/2; scanner.y = CH/2+25
    scanner.anchorY = 1
    --scanner.alpha=0.7 
    scanner.isVisible = false

    scannerCabeza = display.newImageRect( rutaAssets.. "escaner6.png", 75/2+10, 40/2+5 )
    scannerCabeza.x = scanner.x; scannerCabeza.y = scanner.y+50
    scannerCabeza.anchorY = 1
    --scanner.alpha=0.7 
    scannerCabeza.isVisible = false
end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then

        physics.start( )
        physics.pause( )
        physics.setDrawMode( "normal" )

        botonMenu:addEventListener("touch", tocar_botonMenu)
        botonMenu.isVisible = true
        textoMenu.isVisible = true
        protector.isVisible = true
        scanner.isVisible = true


    elseif ( phase == "did" ) then
        botonMenu:addEventListener("touch", irMenu)
        scanner:addEventListener( "touch", mov_escaner )

    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        botonMenu:removeEventListener("touch", tocar_botonMenu)
        botonMenu.isVisible=false
        textoMenu.isVisible=false
        protector.isVisible = false
        scanner:removeEventListener( "touch", mov_escaner )
        scanner.isVisible = false
        scannerCabeza.isVisible = false
        
    elseif ( phase == "did" ) then

    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene