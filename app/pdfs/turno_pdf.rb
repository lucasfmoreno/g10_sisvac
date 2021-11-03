class TurnoPdf < Prawn::Document
    def initialize(turno)
        super(top_margin: 70)
        @turno=turno
        turno_number
        tabla_certifica
    end

    def turno_number
        text "Certificado de Vacunacion",size:30,style: :bold
    end

    def tabla_certifica
        move_down 20
        text "Certifica que el paciente ha sido vacunado con:\n\ #{@turno.tipovacuna}"
        text "\nCon las siguientes observaciones:\n\ #{@turno.observacion}"
    end

end
