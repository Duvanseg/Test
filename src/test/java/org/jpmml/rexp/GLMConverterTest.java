/*
 * Copyright (c) 2016 Villu Ruusmann
 *
 * This file is part of JPMML-R
 *
 * JPMML-R is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * JPMML-R is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with JPMML-R.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.jpmml.rexp;

import com.google.common.base.Predicates;
import org.dmg.pmml.FieldName;
import org.jpmml.evaluator.Batch;
import org.junit.Test;

public class GLMConverterTest extends ConverterTest {

	@Test
	public void evaluateFormulaAudit() throws Exception {
		evaluate("GeneralRegressionFormula", "Audit");
	}

	@Test
	public void evaluateCustFormulaAudit() throws Exception {
		evaluate("GeneralRegressionCustFormula", "Audit");
	}

	@Test
	public void evaluateCaretFormulaAuditMatrix() throws Exception {
		evaluate("TrainGeneralRegressionFormula", "AuditMatrix");
	}

	@Test
	public void evaluateFormulaAuto() throws Exception {
		evaluate("GeneralRegressionFormula", "Auto");

		try(Batch batch = createBatch("GeneralRegressionFormula", "Auto", Predicates.<FieldName>alwaysTrue(), LMConverter.class)){
			evaluate(batch, null);
		}
	}

	@Test
	public void evaluateCustFormulaAuto() throws Exception {
		evaluate("GeneralRegressionCustFormula", "Auto");

		try(Batch batch = createBatch("GeneralRegressionCustFormula", "Auto", Predicates.<FieldName>alwaysTrue(), LMConverter.class)){
			evaluate(batch, null);
		}
	}

	@Test
	public void evaluateCaretFormulaAuto() throws Exception {
		evaluate("TrainGeneralRegressionFormula", "Auto");
	}

	@Test
	public void evaluateFormulaVisit() throws Exception {
		evaluate("GeneralRegressionFormula", "Visit");
	}

	@Test
	public void evaluateFormulaWineQuality() throws Exception {
		evaluate("GeneralRegressionFormula", "WineQuality");
	}

	@Test
	public void evaluateCustFormulaWineQuality() throws Exception {
		evaluate("GeneralRegressionCustFormula", "WineQuality");
	}
}