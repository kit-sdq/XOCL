package edu.kit.ipd.sdq.xocl.extensions

import static extension edu.kit.ipd.sdq.xocl.extensions.XOCLExtensionsAPI.*

class Test {
	def static void main(String[] args) {
		val a = true
		val b = false
		a.implies(b)
	}
}