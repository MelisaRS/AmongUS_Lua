local composer = require( "composer" )
 
local scene = composer.newScene()

local physics = require "physics"

-------------------------------------------------

local practiceBackground
local among
local amongB
local botonDer
local botonIzq
local botonArr
local botonAb
local botonKill
local botonKillCuchillo
local knife
local velocidad = 5
local stage = 1


local groupStage = display.newGroup( )
local groupBackground = display.newGroup( )
local groupAnimated = display.newGroup( )
local groupInterface = display.newGroup( )


groupStage:insert( groupBackground )
groupStage:insert( groupInterface )
groupStage:insert( groupAnimated )

local cables
local mesa1
local mesa2
local mesa3


-----SPRITES-----------------------------------------

local optionsIzqDer = {
	width = 82/4,
    height = 54/2,
    numFrames = 8
}

local optionsAbArr = {
	width = 75/4,
    height = 54/2,
    numFrames = 8
}

local optionsKill = {
	width = 82/4,
    height = 54/2,
    numFrames = 8
}

local optionsKillCuchillo = {
	width = 81/4,
    height = 36/2,
    numFrames = 8
}

local amongIzqDer_sprite = graphics.newImageSheet( rutaAssets.."amongIzqDer.png", optionsIzqDer )
local amongArrAb_sprite = graphics.newImageSheet( rutaAssets.."amongAbArr.png", optionsAbArr )
local amongKill_sprite = graphics.newImageSheet( rutaAssets.."impostor.png", optionsKill )
local amongCuchillo_sprite = graphics.newImageSheet( rutaAssets.."espada.png", optionsKillCuchillo )

local sequence = {
	{
		name = "caminarDer",
        frames = {5,6,7,8},
        time = 600,
        loopCount = 0,
        sheet = amongIzqDer_sprite
	},
	{
		name = "caminarIzq",
		frames = {1,2,3,4},
		time = 600,
		loopCount = 0,
		sheet = amongIzqDer_sprite
	},
	{
		name = "caminarArr",
		frames = {5,6,7,8},
		time = 600,
		loopCount = 0,
		sheet = amongArrAb_sprite
	},
	{
		name = "caminarAb",
		frames = {1,2,3,4},
		time = 600,
		loopCount = 0,
		sheet = amongArrAb_sprite
	},
	{
		name = "matar",
		frames = {1,2,3,5,3,2,1},
		time = 800,
		loopCount = 1,
		sheet = amongKill_sprite
	},
	{
		name = "cuchillo",
		frames = {1,2,3,4,5,6,5,4,3,2,1},
		time = 1000,
		loopCount = 1,
		sheet = amongCuchillo_sprite
	}

}



-----SPRITES AZUL-----------------------------------------

local optionsIzqDerB = {
	width = 81/4,
    height = 54/2,
    numFrames = 8
}


local amongIzqDer_spriteB = graphics.newImageSheet( rutaAssets.."amongIzqDerA.png", optionsIzqDerB )

local sequenceB = {
	{
		name = "caminarDerB",
        frames = {5,6,7,8},
        time = 600,
        --loopCount = 0,
        sheet = amongIzqDer_spriteB
	},
	{
		name = "caminarIzqB",
		frames = {1,2,3,4},
		time = 600,
		--loopCount = 0,
		sheet = amongIzqDer_spriteB
	}

}
----------AMONGB------------------------------------------------
function crearAmongB()
	amongB = display.newSprite( groupAnimated, amongIzqDer_spriteB, sequenceB )
	amongB.x = 10; amongB.y = CH-40
	amongB:scale( 1, 1.4 )
	--amongB:play()
	amongB.name = "amongBlue"

	--caminarDerAmongB()

	physics.addBody( amongB, "static",{radius=20})
	amongB.isFixedRotation = true
	amongB.gravityScale = 0
end
-------FUNCIONES MOVIMIENTO AMONG BLUE----------------------
local caminarIzq
local caminarDer

--local moverDerAmongB, mover
function caminarDerAmongB()
	
	if amongB ~= nil then
		amongB:setSequence( "caminarDerB" )
		amongB:play()
		caminarDer = transition.to(amongB,{x=130, 
			time=2000, 
			onComplete = caminarIzqAmongB})
	end
end

function caminarIzqAmongB()
	if amongB ~= nil then
		amongB:setSequence( "caminarIzqB" )
		amongB:play()
		caminarIzq = transition.to(amongB,{x=-20, 
			time=2000, 
			onComplete = caminarDerAmongB})
	end
end

--[[

3. El personaje deberá tener animaciones

]]
-------FUNCIONES DIRECCIONES--------------------------------

--se utilizara para saber si esta en movimiento o no y asi poder hacer que se mueva o deje de moverse
local enMovimiento = false


--para las siguientes funciones de botones se usa el began y el ended para hacer que se mueva mientras 
--se presiona el boton y dejar de hacerlo cuando dejamos de tocar

function botonCaminarDer( e )
	if (e.phase == "began") then
		enMovimiento = true
		print("muevo derecha")
		among:setSequence( "caminarDer" )
		among:play()

	elseif (e.phase == "ended") then
		enMovimiento = false
		among:pause( )

	end
	return true
end

function botonCaminarIzq( e )
	if (e.phase == "began") then
		enMovimiento = true
		print("muevo izquierda")
		among:setSequence( "caminarIzq" )
		among:play()

	elseif (e.phase == "ended") then
		enMovimiento = false
		among:pause( )

	end
	return true
end

function botonCaminarArr (e)
	if (e.phase == "began") then
		enMovimiento = true
		print("muevo arriba")
		among:setSequence( "caminarArr" )
		among:play()

	elseif (e.phase == "ended") then
		enMovimiento = false
		among:pause( )

	end
	return true
end

function botonCaminarAb (e)
	if (e.phase == "began") then
		enMovimiento = true
		print("muevo abajo")
		among:setSequence( "caminarAb" )
		among:play()

	elseif (e.phase == "ended") then
		enMovimiento = false
		among:pause( )

	end
	return true
end

-- este moviendoAmong ayuda a cambiar los tralate de cada among y asi poder utilizarlo luego en el Runtime
local function moviendoAmong(event)
    if enMovimiento then
        local dx, dy = 0, 0
        local dxi, dyi = 0,0
        
        if among.sequence == "caminarDer" then
            dx = 1*velocidad
        elseif among.sequence == "caminarIzq" then
            dx = -1*velocidad
        elseif among.sequence == "caminarArr" then
            dy = -1*velocidad
        elseif among.sequence == "caminarAb" then
            dy = 1*velocidad
        end
        
        among:translate(dx, dy)
    end
end

------FUNCIONES MATANZA---------------------------------------------
local estaMatando = false

function volverAcaminar()
	--among:scale(0.9,0.9)
	among.xScale = 1; among.yScale = 1.4
	among:setSequence("caminarDer")
	among:play()
	among:pause()
	estaMatando = false
end

function animarMatanza(e)
	if e.phase == "ended" then
		if estaMatando == false then
			estaMatando = true
			among:setSequence( e.target.animacion) 
			if e.target.animacion == "cuchillo" then
				among.xScale = 2; among.yScale = 3
			end
			among:play( )
			print("La accion que esta realizando es: " .. e.target.animacion)
			timer.performWithDelay( 2000, volverAcaminar )
      	else
			print("ya esta matando y debo esperar a que termine para ejecutar de nuevo")
		end
	end
	return true
end

--[[

1. Tener un personaje que se mueva

]]
------FUNCIONES CAMARA----------------------------------------

function camara(e)
	groupStage.x = -among.x + CW/2
    groupStage.y = -among.y + CH/2
    groupInterface.x = -groupStage.x 
    groupInterface.y = -groupStage.y
end

--[[

 2. Debe haber 5 lugares que al estar en contacto

]]
------FUNCIONES COLISION----------------------------------------
local amongB_x
local amongB_y

function checkCollision(self, event)
	--print(event.target.name)
	--print(event.other)


	if event.other.name == "meteoro" then
		meteoros:setFillColor( 1,0,0,0.5 )
		display.remove(buttonUse)
		buttonUse_meteoros.isVisible = true

	elseif event.other.name == "gasolinaGal" then
		gasolinaGalon:setFillColor( 1,0,0,0.5 )
		display.remove( buttonUse )
		buttonUse_gasolina.isVisible = true

	elseif event.other.name == "escanerTable" then
		scanTable:setFillColor( 1,0,0,0.5 )
		display.remove(buttonUse)
		buttonUse_escaner.isVisible = true

	elseif event.other.name == "cable" then
		cables:setFillColor( 1,0,0,0.5 )
		display.remove(buttonUse)
		buttonUse_cables.isVisible = true

	elseif event.other.name == "amongBlue" then
		if estaMatando == true then
			if amongB ~= nil then

				amongB_x = amongB.x
				amongB_y = amongB.y
				transition.cancel(amongB)
				amongMuerto.x = amongB_x; amongMuerto.y = amongB_y
				display.remove(amongB)
				amongB = nil
				amongMuerto.alpha = 1
				--[[
				physics.addBody( amongMuerto, "static",{radius=20})
				amongB.isFixedRotation = true
				amongB.gravityScale = 0
				]]
			end
		end
	end
end

local colision = true

function verificarColision()

    if colision then

        among:addEventListener( "collision" )
    else

		buttonUse_meteoros.isVisible = false
		buttonUse_gasolina.isVisible = false
		buttonUse_escaner.isVisible = false
		buttonUse_cables.isVisible = false

    end
end

------FUNCIONES TAREAS----------------------------------------

function irCables(event)
    if event.phase == "ended" then
        composer.gotoScene("cables", "fade")
    end
    return true
end

function irMeteoros(event)
    if event.phase == "ended" then
        composer.gotoScene("meteoros", "fade")
    end
    return true
end

function irGasolina(event)
    if event.phase == "ended" then
        composer.gotoScene("gasolina", "fade")
    end
    return true
end

function irEscaner(event)
    if event.phase == "ended" then
        composer.gotoScene("escaner", "fade")
    end
    return true
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	physics.start( )
	physics.setDrawMode( "normal" )

	local sceneGroup = self.view

    ------- FONDO ------------------------------------
    practiceBackground = display.newImageRect(groupBackground,rutaAssets.."Skeld.png", CW, CH )
    practiceBackground.x = CW/2-170; practiceBackground.y = CH/2+475
    practiceBackground:scale( 4.5, 4.5 )

    --------PERSONAJE----------------------------------
	among = display.newSprite( groupStage, amongIzqDer_sprite, sequence )
	among.x = CW/2; among.y = CH/2
	among:scale( 1, 1.4 )
	among.name = "amongRed"
	--[[
	local among_body = {
		halfWidth = ((82/4)*1)/2,
		halfHeight = ((54/2)*1.4)/2,
		x = 0,
		y = 0,
		angle = 0
	}]]
	physics.addBody( among, "dynamic",{radius=20}) --{box=among_body} )
	--print(among.sequence, among.frame)
	among.isFixedRotation = true
	among.gravityScale = 0
	print(physics.getGravity( ) )

	---------ESCENARIO-----------------------------------------------------------

	------mesas--------
	mesa1 = display.newCircle( groupBackground, CW/4-28, CH/4+24, 57)
	mesa1.alpha = 0
	physics.addBody( mesa1,"static",{radius=57} )

	mesa2 = display.newCircle( groupBackground, CW/4+200, CH/4+21, 57)
	mesa2.alpha = 0
	physics.addBody( mesa2,"static",{radius=57} )

	mesa3 = display.newCircle( groupBackground, CW/2-32, CH/2+84, 57)
	mesa3.alpha = 0
	physics.addBody( mesa3,"static",{radius=57} )

	mesa4 = display.newCircle( groupBackground, CW/4-28, CH+65, 57)
	mesa4.alpha = 0
	physics.addBody( mesa4,"static",{radius=57} )

	mesa5 = display.newCircle( groupBackground, CW/4+200, CH+65, 57)
	mesa5.alpha = 0
	physics.addBody( mesa5,"static",{radius=57} )

	------paredes---------

	pared1 = display.newRect( groupBackground, 100,-70,CW-70,5 )
	pared1.alpha = 0
	local pared1_body = {
		halfWidth = CW-70/2,
		halfHeight = 5/2,
		x = 0,
		y = 0,
		angle = 0
	}
	physics.addBody( pared1, "static",{box=pared1_body})

    --------BOTONES DIRECCION--------------------------

	botonIzq = display.newImageRect(groupInterface, rutaAssets.."izquierda.png", 488/30, 511/30)
	botonIzq.x = 15; botonIzq.y = CH - 30
	botonIzq.alpha = 0.7
	botonIzq.animacion = "caminarIzq"

	botonDer = display.newImageRect( groupInterface, rutaAssets.."derecha.png", 488/30, 511/30 )
	botonDer.x = botonIzq.x+25; botonDer.y = botonIzq.y
	botonDer.alpha = 0.7
	botonDer.animacion = "caminarDer"

	botonArr = display.newImageRect( groupInterface, rutaAssets.."arriba.png", 520/30, 480/30 )
	botonArr.x = botonIzq.x + 12; botonArr.y = CH - 45
	botonArr.alpha = 0.7
	botonArr.animacion = "caminarArr"

	botonAb = display.newImageRect( groupInterface, rutaAssets.."abajo.png", 508/30, 491/30  )
	botonAb.x = botonArr.x; botonAb.y = botonArr.y + 30
	botonAb.alpha = 0.7
	botonAb.animacion = "caminarAb"

    --------BOTONES ACCIONES--------------------------
	botonKill = display.newImageRect( groupInterface, rutaAssets.."kill.png", 2772/100, 2818/100 )
	botonKill.x = CW - 30; botonKill.y = CH - 20
	botonKill.animacion = "matar"

	botonKillCuchillo = display.newImageRect( groupInterface, rutaAssets.."kill.png", 2772/100, 2818/100 )
	botonKillCuchillo.animacion = "cuchillo"
	botonKillCuchillo.x = botonKill.x; botonKillCuchillo.y = botonKill.y - 30

	knife = display.newText(groupInterface, "KNIFE", botonKillCuchillo.x, botonKillCuchillo.y+5,"Comic Sans MS", 5)
	knife:setTextColor( 0, 0,1 )

	--------PERSONAJE 2----------------------------------

	amongMuerto = display.newImageRect( groupAnimated, rutaAssets.."amongAMuerto.png",24,25 )
	amongMuerto.alpha = 0

    --------------------------------------------------------------------------------------------------------------------------
    --[[

	4. Incluir los botones en pantalla que permitan realizar las interacciones

    ]]

    ---------ICONO USE PARA TAREAS------------------
	buttonUse = display.newImageRect( groupInterface, rutaAssets.."use.png", 263/10, 272/10 )
	buttonUse.x = botonKill.x - 50; buttonUse.y = botonKill.y
	buttonUse.alpha = 0.5
	buttonUse.name = "use"

	buttonUse_meteoros = display.newImageRect( groupInterface, rutaAssets.."use.png", 263/10, 272/10 )
	buttonUse_meteoros.x = botonKill.x - 50; buttonUse_meteoros.y = botonKill.y
	buttonUse_meteoros.isVisible = false
	buttonUse_meteoros.name = "useMeteoros"

	buttonUse_gasolina = display.newImageRect( groupInterface, rutaAssets.."use.png", 263/10, 272/10 )
	buttonUse_gasolina.x = botonKill.x - 50; buttonUse_gasolina.y = botonKill.y
	buttonUse_gasolina.isVisible = false
	buttonUse_gasolina.name = "useGasolina"

	buttonUse_escaner = display.newImageRect( groupInterface, rutaAssets.."use.png", 263/10, 272/10 )
	buttonUse_escaner.x = botonKill.x - 50; buttonUse_escaner.y = botonKill.y
	buttonUse_escaner.isVisible = false
	buttonUse_escaner.name = "useEscaner"

	buttonUse_cables = display.newImageRect( groupInterface, rutaAssets.."use.png", 263/10, 272/10 )
	buttonUse_cables.x = botonKill.x - 50; buttonUse_cables.y = botonKill.y
	buttonUse_cables.isVisible = false
	buttonUse_cables.name = "useCables"

    --------BOTONES TAREAS-----------------------------

    cables = display.newImageRect( groupBackground, rutaAssets.."cables.png", 41/3, 67/3 )
    cables.x = 7; cables.y = 7
    cables.rotation = -1
    cables.name = "cable"

    local cables_body = {
		halfWidth = (41/3)/2+5,
		halfHeight = (67/3)/2+5,
		x = 0,
		y = 0,
		angle = 0
	}
    physics.addBody( cables, "static", {box=cables_body} )

    meteoros = display.newImageRect( groupBackground, rutaAssets.."sillaMeteoros.png", 142/3-2, 143/3-2 )
    meteoros.x = CW+180; meteoros.y = CH/2+35
    meteoros.rotation = -2
    meteoros.name = "meteoro"

    local meteoros_body = {
		halfWidth = (142/3)/2,
		halfHeight = (143/3)/2,
		x = 0,
		y = 0,
		angle = 0
	}
    physics.addBody( meteoros, "static", {box=meteoros_body} )

    gasolinaGalon = display.newImageRect( groupBackground, rutaAssets.."gasolina.png", 66/3-3, 89/3 )
    gasolinaGalon.x = CW/2-121; gasolinaGalon.y = CH*3+82
    gasolinaGalon.name = "gasolinaGal"

    local gasolinaGal_body = {
		halfWidth = (66/3)/2,
		halfHeight = (89/3)/2,
		x = 0,
		y = 0,
		angle = 0
	}
    physics.addBody( gasolinaGalon, "static", {box=gasolinaGal_body} )

    scanTable = display.newImageRect( groupBackground, rutaAssets.."escaner.png", 276/3-10, 179/3 )
    scanTable.x = -CW+395; scanTable.y = CH*2-67.5
    scanTable.name = "escanerTable"

    local scanTable_body = {
		halfWidth = (276/3)/2,
		halfHeight = (179/3)/2,
		x = 0,
		y = 0,
		angle = 0
	}
    physics.addBody( scanTable, "static", {box=scanTable_body} )


end
 
-- show()
function scene:show( event )
	--physics.setDrawMode( "hybrid" )

 
    local sceneGroup = self.view

    local phase = event.phase
 
    if ( phase == "will" ) then
        groupStage.isVisible = true


        if amongB == nil then
        	crearAmongB()
        end

    elseif ( phase == "did" ) then
    
    	--groupStage.isVisible = true
    	--transition.resume()

    	if amongB ~= nil then
        	caminarDerAmongB()
        end

	    physics.start( )
	    physics.setDrawMode( "normal" )
	    among.collision = checkCollision
	    --------LISTENERS-----------------------------------
	    Runtime:addEventListener( "enterFrame", camara )
		botonKill:addEventListener( "touch", animarMatanza )
		botonKillCuchillo:addEventListener( "touch", animarMatanza )
		botonDer:addEventListener( "touch", botonCaminarDer )
		botonIzq:addEventListener( "touch", botonCaminarIzq )
		botonArr:addEventListener( "touch", botonCaminarArr )
		botonAb:addEventListener( "touch", botonCaminarAb )
		Runtime:addEventListener("enterFrame", moviendoAmong)
		--among:addEventListener( "collision" )
		Runtime:addEventListener( "enterFrame", verificarColision )
		buttonUse_cables:addEventListener("touch", irCables)
		buttonUse_meteoros:addEventListener("touch", irMeteoros)
		buttonUse_gasolina:addEventListener("touch", irGasolina)
		buttonUse_escaner:addEventListener("touch", irEscaner)

    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
	    Runtime:removeEventListener( "enterFrame", camara )
		botonKill:removeEventListener( "touch", animarMatanza )
		botonKillCuchillo:removeEventListener( "touch", animarMatanza )
		botonDer:removeEventListener( "touch", botonCaminarDer )
		botonIzq:removeEventListener( "touch", botonCaminarIzq )
		botonArr:removeEventListener( "touch", botonCaminarArr )
		botonAb:removeEventListener( "touch", botonCaminarAb )
		Runtime:removeEventListener("enterFrame", moviendoAmong)
		--among:removeEventListener( "collision" )
		buttonUse_cables:removeEventListener("touch", irCables)
		buttonUse_meteoros:removeEventListener("touch", irMeteoros)
		buttonUse_gasolina:removeEventListener("touch", irGasolina)
		buttonUse_escaner:removeEventListener("touch", irEscaner)

	
		transition.cancel( )
		--transition.pause( )
		groupStage.isVisible = false
		physics.pause( )
        
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