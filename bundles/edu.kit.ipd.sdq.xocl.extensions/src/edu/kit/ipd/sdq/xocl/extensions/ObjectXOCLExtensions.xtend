 /*******************************************************************************
 * Copyright (c) 2015-2017 Sebastian Fiss, Max Kramer.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * 
 * Contributors:
 *    Max Kramer - extension methods
 *    Sebastian Fiss - initial API and implementation and/or initial documentation of OCL extensions
 *******************************************************************************/
package edu.kit.ipd.sdq.xocl.extensions

import java.util.Set
import com.google.common.collect.Sets

/**
 * A utility class providing OCL-aligned extension methods for Objects
 * 
 */
class ObjectXOCLExtensions {
	/** Utility classes should not have a public or default constructor. */
	private new() {
	}
	
	/**
	 * OCL-equivalent converting a non-collection to a collection value (see OCL v2.4, section 11.3.1)
	 */
	@Pure
	def static <T> Set<T> oclAsSet(T element) {
		return Sets.newHashSet(element)
	}
	
	/**
	 * OCL-equivalent returning the given element as the type identified by T (see OCL v2.4, section 11.3.1)
	 */
	@Pure
	def static <T> T oclAsType(Object object, Class<T> type) {
		return object as T
	}
	
	/**
	 * OCL-equivalent evaluating to true if the given object is of the given type
	 * but not a subtype of it (see OCL v2.4, section 11.3.1)
	 */
	@Pure
	def static boolean oclIsTypeOf(Object object, Class<?> type) {
		return object?.class?.equals(type)
	}

	/**
	 * OCL-equivalent evaluating to true if the type of the given object conforms to the given type.
	 * That is, object is of the given type or a subtype of it. (see OCL v2.4, section 11.3.1)
	 */	
	@Pure
	def static boolean oclIsKindOf(Object object, Class<?> type) {
		return type.isInstance(object)
	}
	
	/**
	 * OCL-equivalent returning the type of which the given object is an instance (see OCL v2.4, section 11.3.1)
	 */	
	@Pure
	def static Class<?> oclType(Object object) {
		return object.class
	}
}