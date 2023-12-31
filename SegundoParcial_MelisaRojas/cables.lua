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
    print("funciono menu")
    print(event.x, event.y)
    --self.isVisible = false

  end
  return true
end

local cables = {}
local puntosLinea = {}  -- Almacenar los puntos de la línea
local colores = {
    {1, 0, 1},     -- Rosado
    {1, 0, 0},     -- Rojo
    {0, 0, 1},     -- Azul
    {1, 1, 0},     -- Amarillo
}
local colorActualIndex = 1  -- Índice del color actual

local function dibujar(event)
    local fase = event.phase

    if fase == "began" then
        display.getCurrentStage():setFocus(event.target)
        event.target.isFocus = true

        -- Crear la cable inicial
        local cable = display.newLine(event.x, event.y, event.x, event.y)
        cable:setStrokeColor(unpack(colores[colorActualIndex]))  -- Color rosado inicial
        cable.strokeWidth = 5
        table.insert(cables, cable)

        -- Almacenar el punto inicial en la tabla
        puntosLinea = {
            {x = event.x, y = event.y}
        }

    elseif event.target and event.target.isFocus then
        if fase == "moved" then
            -- Actualizar la línea rosada mientras se mueve el mouse
            --lineaRosada:append(event.x, event.y)

            -- Almacenar el punto en la tabla
            table.insert(puntosLinea, {x = event.x, y = event.y})

            -- Actualizar la línea roja con los puntos de la tabla
            local cable = cables[#cables]
            cable:removeSelf()  -- Eliminar la línea roja anterior
            cable = display.newLine(puntosLinea[1].x, puntosLinea[1].y, puntosLinea[#puntosLinea].x, puntosLinea[#puntosLinea].y)
            cable:setStrokeColor(unpack(colores[colorActualIndex]))  -- Color actual
            cable.strokeWidth = 5
            table.insert(cables, cable)

        elseif fase == "ended" or fase == "cancelled" then
            display.getCurrentStage():setFocus(nil)
            event.target.isFocus = false

            -- Cambiar al siguiente color en cada clic
            colorActualIndex = colorActualIndex + 1
            if colorActualIndex > #colores then
                colorActualIndex = 1
            end
            -- Reiniciar la tabla de puntos para la próxima línea
            puntosLinea = {}
        end
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
    fondo = display.newImageRect(sceneGroup, rutaAssets.. "cables.jpg",CW, CH )
    fondo.x, fondo.y = CW/2, CH/2
    ----------------------------
    botonMenu = display.newRoundedRect(CW/2-180, CH/2-50, 81, 33, 4 )
    botonMenu:setFillColor( 0,0,0 )
    textoMenu = display.newText( "MENU", botonMenu.x, botonMenu.y , "Comic Sans MS", 10 )
    botonMenu.isVisible = false
    textoMenu.isVisible = false
    -------------------------

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

        display.getCurrentStage():addEventListener("touch", dibujar)

    elseif ( phase == "did" ) then
        botonMenu:addEventListener("touch", irMenu)
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

        display.getCurrentStage():removeEventListener("touch", dibujar)

        for i = 1, #cables do
            cables[i].isVisible = false
        end

        puntosLinea = {}


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