local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local menuBackground

local practiceButton

function goPractice(event)
    --local phase = event.phase
    if event.phase == "ended" then
        composer.gotoScene("practice", "fade")
    end
    return true
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
--
--

-- create()
function scene:create( event )
    
    local sceneGroup = self.view
    menuBackground = display.newImageRect(sceneGroup, rutaAssets.."menu.jpg",CW, CH )
    menuBackground.x, menuBackground.y = CW/2, CH/2

    practiceButton = display.newRoundedRect(CW/2+46, CH/2+92, 81, 20, 2)
    practiceButton:setFillColor( 0,0,0,0.01 )
    --practice.alpha = 0.001
    practiceButton.isVisible = false
end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
    print("Ejecucion del show")
    if ( phase == "will" ) then
        practiceButton:addEventListener( "touch", goPractice )
        practiceButton.isVisible = true
        print("Dentro del will de la funcion show")

    elseif ( phase == "did" ) then
        print("Dentro del did de la funcion show")
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        practiceButton:removeEventListener( "touch", goPractice )
        practiceButton.isVisible = false

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
