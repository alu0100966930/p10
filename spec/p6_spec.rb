RSpec.describe P6 do
	before (:all) do 
		@carne_vaca = Alimentos.new("carne de vaca",21.1,0.0,3.1,50.0,164.0)
		@carne_cordero = Alimentos.new("carne de cordero",18.0,0.0,17.0,20.0,185.0)
		@camarones = Alimentos.new("camarones",17.6,1.5,0.6,18.0,2.0)
		@chocolate = Alimentos.new("chocolate",5.3,47.0,30.0,2.3,3.4)
		@salmon = Alimentos.new("salmon",19.9,0.0,13.6,6.0,3.7)
		@cerdo = Alimentos.new("cerdo",21.5,0.0,6.3,7.6,11.0)
		@pollo = Alimentos.new("pollo",20.6,0.0,5.6,5.7,7.1)
		@queso = Alimentos.new("queso",25.0,1.3,33.0,11.0,41.0)
		@cerveza = Alimentos.new("cerveza",0.5,3.6,0.0,0.24,0.22)
		@leche = Alimentos.new("leche",3.3,4.8,3.2,3.2,8.9)
		@huevos = Alimentos.new("huevos",13.0,1.1,11.0,4.2,5.7)
		@cafe = Alimentos.new("cafe",0.1,0.0,0.0,0.4,0.3)
		@tofu = Alimentos.new("tofu",8.0,1.9,4.8,2.0,2.2)
		@lentejas = Alimentos.new("lentejas",23.5,52.0,1.4,0.4,3.4)
		@nuez = Alimentos.new("nuez",20.0,21.0,54.0,0.3,7.9)
			
		@lista1 = Lista.new()
		@lista1.push(@chocolate)

		@plato1 = Plato.new("plato1")
		@plato1.insert_alimento(@chocolate)
		@plato1.insert_gramos(200)
		@plato1.insert_alimento(@carne_vaca)
		@plato1.insert_gramos(500)

		@ambiental1 = Ambiental.new("ambiental1")
		@ambiental1.insert_alimento(@chocolate)
		@ambiental1.insert_gramos(200)
		@ambiental1.insert_alimento(@carne_vaca)
		@ambiental1.insert_gramos(500)

		@ambiental2 = Ambiental.new("ambiental2")
		@ambiental2.insert_alimento(@lentejas)
		@ambiental2.insert_gramos(400)
		@ambiental2.insert_alimento(@queso)
		@ambiental2.insert_gramos(200)

		#menú con diferentes platos
		@menu1 = Array.new
		@menu1.push(@ambiental1)
		@menu1.push(@ambiental2)
		
		@precio1 = Array.new
		@precio1.push(9.95)
		@precio1.push(5.5)

		@plate1 = PlatoDSL.new("lentejas") do 
			lentejas = Alimentos.new("lentejas", 23.5, 52.0, 1.4, 0.4, 3.4)
			ingredient @lentejas
			quantity 500
		end

		@plate2 = Plato.new("salmón con tofu") do
			salmon = Alimentos.new("salmon", 19.9, 0.0, 13.6, 6.0, 3.7)
			tofu = Alimentos.new("tofu", 8.0, 1.9, 4.8, 2.0, 2.2)	
			ingredient @salmon
			quantity 150
			ingredient @tofu
			quantity 150
		end

		@menu2 = Menu.new("Primer menú") do 
			primerPlato = PlatoDSL.new("lentejas") do
			lentejas = Alimentos.new("lentejas", 23.5, 52.0, 1.4, 0.4, 3.4)
			ingredient lentejas
			quantity 300
			end

			segundoPlato = Plato.new("salmón con tofu") do 
				salmon = Alimentos.new("salmon", 19.9, 0.0, 13.6, 6.0, 3.7)
				tofu = Alimentos.new("tofu", 8.0, 1.9, 4.8, 2.0, 2.2)
				
				ingredient @salmon
				quantity 200
				ingredient @tofu
				quantity 150
			end

			component primerPlato
			precio 5.00

			component segundoPlato
			precio 9.90
		end

	end

	context "Que el DSL funcione" do 
		it "con los platos" do 
			expect(@plate1.nombre).to eq("lentejas")
			expect(@plate1.get_VCT).to eq(25)
		end

		it "con los menus" do 
			expect(@menu2.nombre).to eq("Primer menú")
			expect(@menu2.to_s).to eq("Primer menú = 14.9€Contiene: lentejas = 5.0€salmón con tofu = 9.9€")
		end
	end	


	context "Los alimentos deben" do
		it "tener un nombre" do
			expect(@chocolate.alimento).to eq("chocolate")
		end
		it "ser comparables con mixin" do
			expect(@chocolate <=> @chocolate).to eq(0)
			expect(@chocolate < @huevos).to eq(true)
			expect(@chocolate > @nuez).to eq(false)
			expect(@chocolate == @chocolate).to eq(true)
		end
	end

	context "Existe un metodo para" do
		it "obtener el nombre del alimento" do
			expect(@cafe.get_alimento).to eq("cafe")
		end

		it "obtener la emision de gases de efecto invernadero" do
			expect(@lentejas.get_gases).to eq(0.4)
		end
		it "obtener el terreno utilizado" do
			expect(@lentejas.get_terreno).to eq(3.4)
		end

		it "obtener el alimento formateado" do
			expect(@salmon.to_s).to eq('salmon: 19.9, 0.0, 13.6, 6.0, 3.7')
		end

		it "obtener el valor energético de un alimento" do 
			expect(@salmon.val_energetico).to eq(202)
		end

	end

	context "Se calcula correctamente el impacto ambiental diario" do
		it "de un hombre de 20-39 años" do
			expect(@carne_vaca.val_energetico + @salmon.val_energetico + @cerveza.val_energetico + @queso.val_energetico + 2* @huevos.val_energetico).to eq(1043.7)

		end

		it "de una mujer de 20-39 años" do
			expect(@lentejas.val_energetico + @camarones.val_energetico + @chocolate.val_energetico).to eq(875.6)
		end

	end
	context "Las listas deben " do 
		it "ser enumerables" do 
			expect(@lista1.count).to eq(1)
		end
		it "tener tamaño" do 
			expect(@lista1.size).to eq(1)
		end

	end


	context "Los platos deben" do 
		it "tener nombre" do 
			expect(@plato1.nombre).to eq("plato1")
		end

		it "tener un conjunto de alimentos" do 
			expect(@plato1.get_alimentos.size).to eq(2)
		end

		it "tener un conjunto de gramos" do 
			expect(@plato1.get_gramos.size).to eq(2)
		end
		
		it "porcentaje de proteinas" do 
			expect(@plato1.por_proteinas).to eq(116.1)
		end

		it "porcetaje de lípidos" do 
			expect(@plato1.por_lipidos).to eq(75.5)
		end

		it "porcentaje de carbohidratos" do 
			expect(@plato1.por_carbohidratos).to eq(94.0)
		end

		it "el valor calórico total" do
			expect(@plato1.get_VCT).to eq(10639.3)
		end

		it "plato formateado" do 
			expect(@plato1.to_s).to eq("El plato contiene : carne de vaca chocolate ")
		end
	end

	context "La clase heredada" do 
		it " emisiones diarias de gases"  do
			expect(@ambiental1.get_gas).to eq(254.6)
		end

		it "terreno" do 
			expect(@ambiental1.get_terreno).to eq(826.8)
		end

		it "eficiencia energética formateada" do
			expect(@ambiental1.to_s).to eq("Gases: 254.6 Terreno: 826.8")
		end

		it "clase, tipo y jerarquía" do 
			expect(@ambiental1.class.to_s).to eq("Ambiental")
			expect(@ambiental1.instance_of? Ambiental).to eq(true)
		end

		#it "Es comparable" do 
		#	expect(@ambiental1 <=> @ambiental2).to eq(-1)
		#end
	end

	context "Para la huella nutricional" do 
		it "calculamos el índice de impacto de energía" do
			expect(@ambiental1.indice_energia).to eq(1)
		end
		it "calculamos el índice de huella de carbono" do 
			expect(@ambiental1.huella_carbono).to eq(3)
		end
		it "la HUELLA NUTRICIONAL" do 
			expect(@ambiental1.huella_nutricional).to eq(2)
		end
	end

	context "Para el array de platos (menú)" do 
		it "mayor huella nutricional" do 
			expect(@menu1.max).to eq(@ambiental1)
		end
		it "incrementar el precio" do 
			expect(@menu1.max.incrementar_precio(@menu1.max, @precio1)).to eq([19.9, 11.0])
		end
	end
end
