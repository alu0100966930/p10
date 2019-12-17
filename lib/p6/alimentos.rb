Nodo = Struct.new(:val, :sig, :ant)

class Alimentos
	include Comparable

	attr_accessor :alimento, :gei, :terreno, :proteina, :carbohidrato, :lipido
	def initialize(alim, prot, carbo, lipi, gases, terre)
		@alimento = alim
		@proteina = prot
		@carbohidrato = carbo
		@lipido = lipi
		@gei = gases
		@terreno = terre
	end

	def get_alimento
		nombre = @alimento
		return nombre
	end

	def get_gases
		return @gei
	end

	def get_terreno
		return @terreno
	end

	def get_proteina
		return @proteina
	end

	def get_carbohidrato
		return @carbohidrato
	end

	def get_lipido
		return @lipido
	end

	def to_s
		"#{@alimento}: #{@proteina}, #{@carbohidrato}, #{@lipido}, #{@gei}, #{@terreno}"
	end

	def val_energetico
		return ((@proteina * 4) + (@carbohidrato * 4) + (@lipido * 9))
	end

	def ef_energetica()
		eficiencia #TODO:CALCULARLA
		return eficiencia
	end

	def <=>(toCompare)
		@alimento <=> toCompare.alimento
	end

end
class Lista
	include Enumerable
	
	attr_accessor :head, :tail, :size, :node

	def initialize()
		@head = Nodo.new(nil,nil,nil)
		@tail = Nodo.new(nil,nil,nil)
		@size = 0
	end
	
	def push(valor)
		nodo = Nodo.new(valor,nil,nil)
		if(@size==0)
			@tail = nodo
			nodo.sig = nil
		else
			@head.ant = nodo
			nodo.sig = @head
		end

		@head = nodo
		nodo.ant = nil
		@size = @size+1
	end

	def pop_head()
		if(size==0)
			puts "Lista vacía, no hay nada que extraer"
		else
			drop = @head.val
			(@head.sig).ant = nil
			@head = @head.sig
			@size = @size - 1
			return drop
		end
	end

	def pop_tail()
		if(size==0)
			puts "Lista vacía, no hay nada que extraer"
		else
			drop = @tail.val
			(@tail.ant).sig = nil
			@tail = @tail.ant
			@size = @size - 1
			return drop
		end

	end

	def each
		node = @head
		while (node != nil)
			yield node.val
			node = node.sig
		end
	end

end

class Plato
	attr_accessor :nombre, :listaAl

	def initialize(name)
		@nombre = name
		@listaAl = Lista.new
		@listaGr = Lista.new
	end

	def insert_alimento(alimento)
		@listaAl.push(alimento)
	end

	def insert_gramos(gramos)
		@listaGr.push(gramos)
	end

	def get_alimentos
		return @listaAl
	end

	def get_gramos
		return @listaGr
	end
	
	def por_proteinas
		p = 0
		i = 0
		j = 0
		@listaGr.each do |gramos|
			gr = gramos
			i = i +1
			@listaAl.each do |element|
				j = j + 1
				if (i == j)
					p = p +gr*element.get_proteina/100
				end
			end
			j = 0
		end
		return p
	end

	def por_lipidos
		l = 0
		i = 0
		j = 0
		@listaGr.each do |gramos|
			gr = gramos
			i = i + 1
			@listaAl.each do |element|
				j = j +1
				if (i == j)
					l = l + gr*element.get_lipido/100
				end
			end
			j = 0
		end
		return l
	end

	def por_carbohidratos
		c = 0
		i = 0
		j = 0
		@listaGr.each do |gramos|
			gr = gramos
			i = i + 1
			@listaAl.each do |element|
				j = j + 1
				if (i == j)
					c = c + gr*element.get_carbohidrato/100
				end
			end
			j = 0
		end
		return c
	end

	def get_VCT
		total = 0
		@listaGr.each do |gramos|
		total = total + gramos
		end
		prot = (por_proteinas*total)/100
		lip = (por_lipidos*total)/100
		car = (por_carbohidratos*total)/100
		return ((prot*4)+(lip*9)+(car*4))
	end

	def to_s
		alimentos = "El plato contiene : "
		@listaAl.each do |element|
			alimentos = alimentos + element.alimento
			alimentos = alimentos + " "
		end
		return alimentos
	end
end

class Ambiental < Plato 
	include Comparable

	attr_accessor :gas, :ter

	def get_terreno
		t = 0
		i = 0
		j = 0
		@listaGr.each do |gramos|
			gr = gramos
			i = i + 1
			@listaAl.each do |element|
				j = j + 1
				if (i == j)
					t = t + gr*element.terreno/100
				end
			end
			j = 0
		end
		@ter = t
		return t
	end

	def get_gas
		co = 0
		i = 0
		j = 0
		@listaGr.each do |gramos|
			gr = gramos
			i = i + 1
			@listaAl.each do |element|
				j = j + 1
				if (i == j)
					co = co + gr*element.gei/100
				end
			end 
			j = 0
		end
		@gas = co
		return co 
	end

	def to_s
		form = "Gases: "
		form = form + get_gas.to_s
		form = form + " Terreno: "
		form = form + get_terreno.to_s
		return form
	end

	def indice_energia
		if(get_gas < 800)
			return 1
		elsif (get_gas < 1200)
			return 2
		else 
			return 3
		end
	end

	def huella_carbono
		if (get_VCT < 670)
			return 1
		elsif (get_VCT < 830)
			return 2
		else 
			return 3
		end
	end

	def huella_nutricional
		return (indice_energia + huella_carbono)/2
	end


	def <=>(compara)
		#nombre <=> compara.nombre
		huella_nutricional <=> compara.huella_nutricional
	end

	def incrementar_precio (v)
		p = Array.new
		v.each do |element|
			p.push(element * huella_nutricional)
		end 
		return p
	end

end
