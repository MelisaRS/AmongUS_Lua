local composer = require( "composer" )
 
local scene = composer.newScene()

local physics = require "physics"

local fondo 

local botonMenu
local textoMenu 



function irMenu(event)
    if event.phase == "ended" or event.phase == "cancelled" then
        print(" Cambiando al menu")
        composer.gotoScene("practice", "fade", 500)
    end
    return true
end

-------------------------------------
local meteoritosAll = {}
--local transitions = {}


function onTouch(event)
    if event.phase == "ended" then
        display.remove( event.target )
        for i = #meteoritosAll, 1, -1 do
            if meteoritosAll[i] == event.target then
                table.remove( meteoritosAll, i)
                break
            end
        end
    end
    return true
end

local numMeteoros = 10
--------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    physics.start( )
    physics.pause( )
    physics.setDrawMode( "normal" )
    -- Code here runs when the scene is first created but has not yet appeared on screen
    fondo = display.newImageRect(sceneGroup, rutaAssets.. "meteoros.jpg",CW, CH )
    fondo.x, fondo.y = CW/2, CH/2
    ------------------------------------
    botonMenu = display.newRoundedRect(CW/2-48, CH/2-50, 81, 33, 4 )
    botonMenu:setFillColor( 0,0,0 )
    textoMenu = display.newText( "MENU", botonMenu.x, botonMenu.y , "Comic Sans MS", 10 )
    botonMenu.isVisible = false
    textoMenu.isVisible = false

        ---------------------------------------------------------------------
        --creacion de los meteoritos
        for i=1, numMeteoros do
            local meteoritos = display.newImageRect(rutaAssets.. "meteoro1.png", 72/3, 50/3 )
            meteoritos.x, meteoritos.y = math.random(CW), math.random(CH)
            meteoritos:addEventListener("touch", onTouch)

            table.insert( meteoritosAll, meteoritos ) --agregamos el meteoro a la tabla

            transition.to(meteoritos, 
                {
                    time= 10000, 
                    x = math.random(CW), 
                    y = math.random(CH), 
                    onComplete = function()
                        display.remove(meteoritos)
                        for i = #meteoritosAll, 1, -1 do
                            if meteoritosAll[i] == meteoritos then
                                table.remove( meteoritosAll, i)
                                break
                            end
                        end
                    end
                }
            )
        end
        ----------------------------------------------------------------------- 


end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        physics.start( )
        physics.pause( )    
        physics.setDrawMode( "normal" )
        botonMenu.isVisible = true
        textoMenu.isVisible = true

    elseif ( phase == "did" ) then
        botonMenu:addEventListener("touch", irMenu)


    end

end


-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        botonMenu.isVisible=false
        textoMenu.isVisible=false

    
        for i=#meteoritosAll, 1, -1 do
            meteoritosAll[i]:removeEventListener("touch", onTouch)
            meteoritosAll[i].isVisible = false
        end
        
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