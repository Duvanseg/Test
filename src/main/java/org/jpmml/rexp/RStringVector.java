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

import java.util.List;

import org.dmg.pmml.DataType;

public class RStringVector extends RVector<String> {

	private List<String> values = null;


	public RStringVector(List<String> values, RPair attributes){
		super(attributes);

		setValues(values);
	}

	@Override
	public DataType getDataType(){
		return DataType.STRING;
	}

	@Override
	public int size(){
		return this.values.size();
	}

	@Override
	public String getValue(int index){
		return this.values.get(index);
	}

	@Override
	public List<String> getValues(){
		return this.values;
	}

	private void setValues(List<String> values){
		this.values = values;
	}
}