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
		
		
		@nodo1 = Nodo.new(@chocolate,nil,nil)
		@nodo2 = Nodo.new(@leche,nil,nil)
		@nodo3 = Nodo.new(@queso,@nodo1,nil)
		@nodo4 = Nodo.new(@camarones,@nodo2,@nodo3)
		@nodo5 = Nodo.new(@lentejas,nil,@nodo4)
		@nodo6 = Nodo.new(@nuez,nil,nil)
		
		@lista = Lista.new()

		@española = Lista.new()
		@vasca = Lista.new()
		@vegetaria = Lista.new()
		@vegetaliana = Lista.new()
		@lo_carne = Lista.new()

	end

		context "Debe existir" do
		it "un nombre para cada alimento" do
			expect(@carne_vaca.alimento).to eq("carne de vaca")
			expect(@salmon.alimento).to eq("salmon")
			expect(@chocolate.alimento).to eq("chocolate")
		end
		it "la cantidad de emisión de gases de efecto invernadero" do
			expect(@carne_cordero.gei).to eq(20.0)
			expect(@cerdo.gei).to eq(7.6)
			expect(@queso.gei).to eq(11.0)
		end
		it "la cantidad de terreno utilizado" do
			expect(@camarones.terreno).to eq(2.0)
			expect(@cerveza.terreno).to eq(0.22)
			expect(@huevos.terreno).to eq(5.7)
		end
	end


	context "Existe un metodo para" do
		it "obtener el nombre del alimento" do
			expect(@cafe.get_alimento).to eq("cafe")
			expect(@tofu.get_alimento).to eq("tofu")
		end

		it "obtener la emision de gases de efecto invernadero" do
			expect(@lentejas.get_gases).to eq(0.4)
			expect(@nuez.get_gases).to eq(0.3)
		end
		it "obtener el terreno utilizado" do
			expect(@lentejas.get_terreno).to eq(3.4)
			expect(@nuez.get_terreno).to eq(7.9)
		end

		it "obtener el alimento formateado" do
			expect(@salmon.to_s).to eq('salmon: 19.9, 0.0, 13.6, 6.0, 3.7')
			expect(@queso.to_s).to eq('queso: 25.0, 1.3, 33.0, 11.0, 41.0')
		end

		it "obtener el valor energético de un alimento" do 
			expect(@salmon.val_energetico).to eq(202)
			expect(@queso.val_energetico).to eq(402.2)
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
	context "Debe existir" do 
		it "un nodo de la lista con sus datos, su siguiente, y su previo" do 
			expect(@nodo1.val).to eq(@chocolate)
			expect(@nodo4.sig).to eq(@nodo2)
			expect(@nodo1.ant).to eq nil
		end
		it "una lista con su cabeza y su cola (Se inserta un nodo en la lista" do 
			@lista.push(@nodo3)
			expect(@lista.head).to eq(@nodo3)
			expect(@lista.tail).to eq(@nodo3)
		end

	end
	context "Se puede insertar" do
		it "un elemento en la lista" do
			expect(@lista.size).to eq(1)
			@lista.push(@nodo6)
			expect(@lista.size).to eq(2)
		end
		it "varios elementos en una lista" do
			expect(@lista.size).to eq(2)
			@lista.push(@nodo5)
			@lista.push(@nodo4)
			expect(@lista.size).to eq(4)
		end
	end
	context "Se puede extraer" do
		it "el primer elemento de la lista" do 
			expect(@lista.size).to eq(4)
			expect(@lista.head).to eq(@nodo4)
			@lista.pop_head()
			expect(@lista.size).to eq(3)
			expect(@lista.head).to eq(@nodo5)

		end
		it "el último elemento de la lista" do
			expect(@lista.size).to eq(3)
			expect(@lista.tail).to eq(@nodo3)
			@lista.pop_tail()
			expect(@lista.size).to eq(2)
			expect(@lista.tail).to eq(@nodo6)
		end
	end


end
