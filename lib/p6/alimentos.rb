#Creando la estructura del nodo
Nodo = Struct.new(:val, :sig, :ant)
#CLASE ALIMENTOS
class Alimentos
	include Comparable

	attr_accessor :alimento, :gei, :terreno, :proteina, :carbohidrato, :lipido
	
	#Función para incializar todas las variables de la clase
	def initialize(alim, prot, carbo, lipi, gases, terre)
		@alimento = alim
		@proteina = prot
		@carbohidrato = carbo
		@lipido = lipi
		@gei = gases
		@terreno = terre
	end

	#Devuelve el nombre del alimento
	def get_alimento
		nombre = @alimento
		return nombre
	end
	
	#Devuelve la cantidad de CO2
	def get_gases
		return @gei
	end
	
	#Devuelve la cantidad de M2 de terreno
	def get_terreno
		return @terreno
	end
	
	#Devuelve las proteínas
	def get_proteina
		return @proteina
	end
	
	#Devuelve los carbohidratos
	def get_carbohidrato
		return @carbohidrato
	end
	
	#Devuelve los lípidos
	def get_lipido
		return @lipido
	end

	#Devuelve una cadena con el nombre del alimento y la cantidad de cada componente que lo forma
	def to_s
		"#{@alimento}: #{@proteina}, #{@carbohidrato}, #{@lipido}, #{@gei}, #{@terreno}"
	end

	#Devuelve el valor energético
	def val_energetico
		return ((@proteina * 4) + (@carbohidrato * 4) + (@lipido * 9))
	end

	#Devuelve la eficiencia energética
	def ef_energetica()
		eficiencia #TODO:CALCULARLA
		return eficiencia
	end

	#Compara el nombre de un alimento con el de otro que le hayas pasado
	def <=>(toCompare)
		@alimento <=> toCompare.alimento
	end

end

#CLaSE LISTA
class Lista
	include Enumerable
	
	attr_accessor :head, :tail, :size, :node

	#Inicializamos el nodo head, tail y el tamaño a 0
	def initialize()
		@head = Nodo.new(nil,nil,nil)
		@tail = Nodo.new(nil,nil,nil)
		@size = 0
	end
	
	#Inserta un nodo en la lista
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

	#Extrae un nodo por la cabecera de la lista
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

	#Extrae un nodo por la cola de la lista
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

	#Método para iterar la lista
	def each
		node = @head
		while (node != nil)
			yield node.val
			node = node.sig
		end
	end

end

#CLASE PLATP
class Plato
	attr_accessor :nombre, :listaAl, :listaGr, :v

	#Inicializa tanto la lista de alimentos como de gramos de cada para cada plato
	def initialize(name, &block)
		@nombre = name
		@listaAl = Lista.new
		@listaGr = Lista.new
		@v = 0

		if block_given? 
			if block.arity == 1
				yield self
			else
				instance_eval(&block)
			end
		end
	end

	def ingredient(aliment, options = {})
		insert_alimento(aliment)
		insert_gramos("#{options[:amount]}")
	end


	#Inserta un alimento al plato
	def insert_alimento(alimento)
		@listaAl.push(alimento)
	end

	#Inserta los gramos de un alimento a un plato
	def insert_gramos(gramos)
		@listaGr.push(gramos)
	end

	#Devuelve la lista de alimentos
	def get_alimentos
		return @listaAl
	end

	#Devuelve la lista de gramos de cada alimento
	def get_gramos
		return @listaGr
	end
	
	#Devuelve el porcentaje de proteínas
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

	#Devuelve el porcentaje de lípidos
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

	#Devuelve el porcentaje de carbohidratos
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

	#Devuelve el valor calórico total
	def get_VCT
		total = 0
		@listaGr.each do |gramos|
			total = total + gramos
		end
		prot = (por_proteinas*total)/100
		lip = (por_lipidos*total)/100
		car = (por_carbohidratos*total)/100
		@v = ((prot*4)+(lip*9)+(car*4))
		#return ((prot*4)+(lip*9)+(car*4))
		return @v
	end

	#Devuelve la lista de alimentos de cada plato 

	def to_s
		alimentos = "El plato contiene : "
		@listaAl.each do |element|
			alimentos = alimentos + element.alimento
			alimentos = alimentos + " "
		end
		return alimentos
	end
end

#CLASE AMBIENTAL HEREDADA DE PLATO
class Ambiental < Plato 
	include Comparable

	attr_accessor :gas, :ter, :huella
	
	#Devuelve la cantidad de M2 de cada plato de un menú
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

	#Devuelve la cantidad de CO2 de cada plato de cada menú
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

	#Formatea la saluda de los gases (CO2) y el terreno (M2) utilizado para cada plato
	def to_s
		form = "Gases: "
		form = form + get_gas.to_s
		form = form + " Terreno: "
		form = form + get_terreno.to_s
		return form
	end

	#Devuelve el índice de energía
	def indice_energia
		if(get_gas < 800)
			return 1
		elsif (get_gas < 1200)
			return 2
		else 
			return 3
		end
	end

	#Devuelve el índice de huella de carbono
	def huella_carbono
		if (get_VCT < 670)
			return 1
		elsif (get_VCT < 830)
			return 2
		else 
			return 3
		end
	end

	#Devuelve la huella nutricional
	def huella_nutricional
		return (indice_energia + huella_carbono)/2
	end

	#Compara la huella nutricional de dos menus
	def <=>(other)
		#nombre <=> compara.nombre
		huella_nutricional <=> other.huella_nutricional
	end

	#Método para incrementar el precio de un plato según su huella nutricional
	def incrementar_precio (v, p)
		p.collect {|x| x*(v.huella_nutricional)}
	end

end

class Menu
	attr_accessor :nombre, :platos, :precios

	def initialize(name, &block)
		@nombre = name
		@platos = Array.new
		@precios = Array.new

		if block_given?
			if block.arity == 1
				yield self
			else
				instance_eval(&block)
			end
		end
	end

	def component(platoNuevo)
		@platos.push(platoNuevo)
	end

	def precio(price)
		@precios.push(price)
	end

	def to_s
		@platos.collect { |x| x.to_s}
	end
end
