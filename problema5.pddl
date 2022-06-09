(define (problem ExtraerGas)
    (:domain ejer5)
    (:objects
        VCE1 VCE2 VCE3 Marine1 Marine2 Soldado1 - Unidades
        BahiaDeEngenieria1 CentroDeMando1 Extractor1 Barracones1 - Edificios
        Minerales1 Minerales2 Gas1 - Recursos
        SoldadoUniversal1 - Investigacion
        LOC44 LOC43 LOC42 LOC41 - Localizacion
        LOC34 LOC33 LOC32 LOC31 - Localizacion
        LOC24 LOC23 LOC22 LOC21 - Localizacion
        LOC14 LOC13 LOC12 LOC11 - Localizacion
    )
    (:init
        ;; Posiciones
        (edificioEn CentroDeMando1 LOC11)
        (unidadeEn VCE1 LOC11)

        (recursoEn Minerales1 LOC22)
        (recursoEn Minerales2 LOC32)
        (recursoEn Gas1 LOC44)

        ;; Tipos de Unidades
        (esUnidad VCE1 VCE)
        (esUnidad VCE2 VCE)
        (esUnidad VCE3 VCE)
        (esUnidad Marine1 Marines)
        (esUnidad Marine2 Marines)
        (esUnidad Soldado1 Soldados)
        (esInvestigacion SoldadoUniversal1 SoldadoUniversal)

        ;; Tipo de Recurso
        (esRecurso Minerales1 Mineral)
        (esRecurso Minerales2 Mineral)
        (esRecurso Gas1 Gas)

        ;; Tipo de Edificio
        (esEdificio Extractor1 Extractor)
        (esEdificio CentroDeMando1 CentroDeMando)
        (esEdificio Barracones1 Barracones)
        (esEdificio BahiaDeEngenieria1 BahiaDeEngenieria)
        ;; Recurso utiliza edificio
        (utiliza Gas Extractor)

        ;; Necesidades
        (necesita Extractor Mineral)
        (necesita Barracones Mineral)
        (necesita Barracones Gas)
        (necesita BahiaDeEngenieria Mineral)
        (necesita BahiaDeEngenieria Gas)
        (requiere VCE Mineral)
        (requiere Marines Mineral)
        (requiere Soldados Mineral)
        (requiere Soldados Gas)
        (requiereUI Soldados SoldadoUniversal)

        ;; GeneradoEn
        (generadoEn VCE CentroDeMando)
        (generadoEn Marines Barracones)
        (generadoEn Soldados Barracones)

        ;; Conexiones verticales y sus simétricos
        (caminoEntre LOC11 LOC21)
        (caminoEntre LOC21 LOC11)
        (caminoEntre LOC21 LOC31)
        (caminoEntre LOC31 LOC21)

        (caminoEntre LOC12 LOC22)
        (caminoEntre LOC22 LOC12)
        (caminoEntre LOC22 LOC32)
        (caminoEntre LOC32 LOC22)

        (caminoEntre LOC13 LOC23)
        (caminoEntre LOC23 LOC13)
        (caminoEntre LOC23 LOC33)
        (caminoEntre LOC33 LOC23)
        ;; Últimas Conexiones Verticales y sus simétricos
        (caminoEntre LOC14 LOC24)
        (caminoEntre LOC24 LOC14)
        (caminoEntre LOC24 LOC34)
        (caminoEntre LOC34 LOC24)
        (caminoEntre LOC34 LOC44)
        (caminoEntre LOC44 LOC34)
        ;;Conexiones horizontales Centro
        (caminoEntre LOC22 LOC23)
        (caminoEntre LOC23 LOC22)
        ;; Conexiones horizontales arriba
        (caminoEntre LOC11 LOC12)
        (caminoEntre LOC12 LOC11)
        (caminoEntre LOC13 LOC14)
        (caminoEntre LOC14 LOC13)
        ;; Conexiones Horizontales abajo
        (caminoEntre LOC31 LOC32)
        (caminoEntre LOC32 LOC31)
        (caminoEntre LOC33 LOC34)
        (caminoEntre LOC34 LOC33)

    )
    (:goal
        (and
            (edificioEn BahiaDeEngenieria1 LOC12)
            (edificioEn Barracones1 LOC14)
            (unidadeEn Marine1 LOC14)
            (unidadeEn Marine2 LOC14)
            (unidadeEn Soldado1 LOC14)
        )
    )
)
