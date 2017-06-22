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

/**
 * A utility class providing OCL-aligned extension methods for Classes
 * 
 */
class ClassXOCLExtensions {
	/** Utility classes should not have a public or default constructor. */
	private new() {
	}
	
	/**.
	 * OCL-equivalent returning all instances of the classifier and the classifiers 
	 * specializing it (see OCL v2.4, section 8.3.8)
	 */
	@Deprecated
	@Pure
	def static <T> Iterable<T> allInstances(Class<T> type) {
		// TODO MK implement allInstances(EClass)?
		throw new UnsupportedOperationException("Cannot use allInstances")
	}
}