class Alimentos
	attr_reader :alimento, :gei, :terreno
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

	def to_s
		"#{@alimento}: #{@proteina}, #{@carbohidrato}, #{@lipido}, #{@gei}, #{@terreno}"
	end

	def val_energetico
		return ((@proteina * 4) + (@carbohidrato * 4) + (@lipido * 9))
	end
end
