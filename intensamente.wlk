const intensidadElevada = 50

class Persona {
    var edad
    var emociones = []

method esAdolescente() {
    edad >= 12 && edad <= 19
}

method agregarEmocion(unaEmocion) {
    emociones.add(unaEmocion)
}

method estaPorExplotar() {
    emociones.all([{e=>e.puedeLiberarse()}])
}

method vivirEvento(unEvento) {
    emociones.forEach([{e=>e.vivirEvento(unEvento)}])
}

method vivirEventoEnGrupo(unEvento, grupoDePersonas) {
    grupoDePersonas.forEach([{p=>p.vivirEvento(unEvento)}])
}

}

class Emocion {
    var intensidad = 0
    var eventosVividos = 0

method puedeLiberarse() {
    intensidad >= intensidadElevada
}

method vivirEvento(unEvento) {
    eventosVividos = eventosVividos + 1
}

}

class Furia inherits Emocion {
    var palabrotas = []

override method puedeLiberarse() {
    super().puedeLiberarse() && palabrotas.any([{pa=>pa.length() > 7}])
}

override method vivirEvento(unEvento) {

    if (self.PuedeLiberarse()) {
        intensidad -= unEvento.impacto
        if (palabrotas.size() > 0) palabrotas.removeAt(0)
        }
}
}

class Alegria inherits Emocion {
override method puedeLiberarse() {
    super().puedeLiberarse() && eventosVividos % 2 == 0
}

override method vivirEvento(unEvento) {

    if (self.puedeLiberarse()) {
        intensidad -= unEvento.impacto
        if (intensidad < 0) intensidad = intensidad.abs()
    }
}

}

class Tristeza inherits Emocion {
    var causa = "melancolía"
override method puedeLiberarse() {
        super().puedeLiberarse() && causa != "melancolía"
}

override method vivirEvento(unEvento) {

    if (self.puedeLiberarse()) {
        causa = unEvento.descripcion
        intensidad -= unEvento.impacto
    }
}

}

class Desagrado inherits Emocion {
override method puedeLiberarse() {
    super().puedeLiberarse() && eventosVividos > intensidad
}

override method vivirEvento(unEvento) {

    if (self.puedeLiberarse()) {
    intensidad -= unEvento.impacto
    }
}

}

class Temor inherits Emocion {

    override method puedeLiberarse() {
    super().puedeLiberarse() && eventosVividos > intensidad
    }

override method vivirEvento(unEvento) {
    super(eventosVividos)
    if (self.puedeLiberarse()) {
        intensidad -= unEvento.impacto
    }
}

}

class Ansiedad inherits Emocion {
    var nivelDeAlerta = 0

override method puedeLiberarse() {
    super().puedeLiberarse() && nivelDeAlerta > intensidad
}

override method vivirEvento(unEvento) {

        if (self.puedeLiberarse()) {
        nivelDeAlerta -= unEvento / 2
        intensidad -= unEvento.impacto
    }
}

}

class Evento {
    var descripcion
    var impacto
}

/*
Polimorfismo y Herencia:
Las emociones comparten comportamiento común como puedeLiberarse() y vivirEvento(),
pero tienen implementaciones específicas dependiendo de la subclase.
Esto facilita agregar nuevas emociones como Ansiedad, con comportamiento único sin modificar el código existente.
Grupo de personas y eventos:
Se encapsuló la lógica para que un grupo completo viva un evento, reutilizando el método de vivirEvento de cada persona
*/
