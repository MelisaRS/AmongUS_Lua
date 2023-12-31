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

local botonGasolina
local llenarGasolina


function tocar_botonMenu(event)
  if event.phase == "ended" then
    --self.isVisible = false

  end
  return true
end


function tocar_botonGasolina(event)
    if event.phase == "ended" then
        transition.to(llenarGasolina, {time = 10500, height = 140} )
    end
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
    -- Code here runs when the scene is first created but has not yet appeared on screen
    fondo = display.newImageRect(sceneGroup, rutaAssets.. "gasolina.jpg",CW, CH )
    fondo.x, fondo.y = CW/2, CH/2

    -----------------------------
    botonMenu = display.newRoundedRect(CW/2-120, CH/2-50, 81, 33, 4 )
    botonMenu:setFillColor( 0,0,0 )
    textoMenu = display.newText( "MENU", botonMenu.x, botonMenu.y , "Comic Sans MS", 10 )
    botonMenu.isVisible=false
    textoMenu.isVisible=false

    botonGasolina=display.newRect( CW-114, CH-60, 30, 34 )
    botonGasolina:setFillColor( 1,85/255,85/255,0.9 )
    botonGasolina.isVisible = false

    llenarGasolina = display.newRoundedRect( CW/2, CH/2+67, 90, 34, 10 )
    llenarGasolina.anchorY = 1
    llenarGasolina:setFillColor(1,0,0,0.3 )
    llenarGasolina.isVisible=false
    -----------------------------
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

        botonGasolina.isVisible = true
        llenarGasolina.isVisible = true


    elseif ( phase == "did" ) then
        botonMenu:addEventListener("touch", irMenu)
        botonGasolina:addEventListener( "touch", tocar_botonGasolina )

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

        botonGasolina.isVisible = false
        llenarGasolina.isVisible=false
        
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