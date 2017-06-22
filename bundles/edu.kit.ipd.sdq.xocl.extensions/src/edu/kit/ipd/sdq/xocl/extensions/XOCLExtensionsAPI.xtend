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

import edu.kit.ipd.sdq.mdsd.xtend.activeannotations.StaticDelegate

/**
 * A utility class providing many OCL-aligned extension methods, especially identical 
 * collection operators (ISO/IEC 19507:2012 pp.156-168) and collection iterators (ISO/IEC 19507:2012 pp. 168-174)
 */
@StaticDelegate(delegationTargets=#[BooleanXOCLExtensions,ClassXOCLExtensions,IterableXOCLExtensions,ListXOCLExtensions,NumberXOCLExtensions,ObjectXOCLExtensions,SetXOCLExtensions])
class XOCLExtensionsAPI {
	/** Utility classes should not have a public or default constructor. */
	private new() {
	}
}