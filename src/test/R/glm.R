library("caret")
library("plyr")

source("util.R")

audit = loadAuditCsv("Audit")

predictGeneralRegressionAudit = function(audit.glm){
	probabilities = predict(audit.glm, newdata = audit, type = "response")

	result = data.frame("Adjusted" = as.integer(probabilities > 0.5), "probability(0)" = (1 - probabilities), "probability(1)" = probabilities, check.names = FALSE)

	return (result)
}

generateGeneralRegressionFormulaAudit = function(){
	audit.glm = glm(Adjusted ~ ., data = audit, family = binomial)
	print(audit.glm)

	storeRds(audit.glm, "GeneralRegressionFormulaAudit")
	storeCsv(predictGeneralRegressionAudit(audit.glm), "GeneralRegressionFormulaAudit")
}

generateGeneralRegressionCustFormulaAudit = function(){
	audit.glm = glm(Adjusted ~ . - Education + plyr::revalue(Education, c(Yr1t4 = "Yr1t6", Yr5t6 = "Yr1t6", Yr7t8 = "Yr7t9", Yr9 = "Yr7t9", Yr10 = "Yr10t12", Yr11 = "Yr10t12", Yr12 = "Yr10t12")) - Income + base::cut(Income, breaks = c(100, 1000, 10000, 100000, 1000000)) + Gender:Age + Gender:Marital, data = audit, family = binomial)
	print(audit.glm)

	storeRds(audit.glm, "GeneralRegressionCustFormulaAudit")
	storeCsv(predictGeneralRegressionAudit(audit.glm), "GeneralRegressionCustFormulaAudit")
}

generateGeneralRegressionFormulaAudit()
generateGeneralRegressionCustFormulaAudit()

generateTrainGeneralRegressionFormulaAuditMatrix = function(){
	audit.train = train(Adjusted ~ ., data = audit, method = "glm")
	print(audit.train)

	adjusted = predict(audit.train, newdata = audit)
	probabilities = predict(audit.train, newdata = audit, type = "prob")

	storeRds(audit.train, "TrainGeneralRegressionFormulaAuditMatrix")
	storeCsv(data.frame(".outcome" = adjusted, "probability(0)" = probabilities[, 1], "probability(1)" = probabilities[, 2], check.names = FALSE), "TrainGeneralRegressionFormulaAuditMatrix")
}

generateTrainGeneralRegressionFormulaAuditMatrix()

auto = loadAutoCsv("Auto")

generateGeneralRegressionFormulaAuto = function(){
	auto.glm = glm(mpg ~ ., data = auto)
	print(auto.glm)

	mpg = predict(auto.glm, newdata = auto)

	storeRds(auto.glm, "GeneralRegressionFormulaAuto")
	storeCsv(data.frame("mpg" = mpg), "GeneralRegressionFormulaAuto")
}

generateGeneralRegressionCustFormulaAuto = function(){
	auto.glm = glm(mpg ~ (. - horsepower - weight - origin) ^ 2 + base::cut(horsepower, breaks = 10, dig.lab = 4) + I(log(weight)) + I(weight ^ 2) + I(weight ^ 3) + plyr::revalue(origin, replace = c("1" = "US", "2" = "Non-US", "3" = "Non-US")), data = auto)
	print(auto.glm)

	mpg = predict(auto.glm, newdata = auto)

	storeRds(auto.glm, "GeneralRegressionCustFormulaAuto")
	storeCsv(data.frame("mpg" = mpg), "GeneralRegressionCustFormulaAuto")
}

generateGeneralRegressionFormulaAuto()
generateGeneralRegressionCustFormulaAuto()

auto.caret = auto
auto.caret$origin = as.integer(auto.caret$origin)

generateTrainGeneralRegressionFormulaAuto = function(){
	auto.train = train(mpg ~ ., data = auto.caret, method = "glm")
	print(auto.train)

	mpg = predict(auto.train, newdata = auto.caret)

	storeRds(auto.train, "TrainGeneralRegressionFormulaAuto")
	storeCsv(data.frame(".outcome" = mpg), "TrainGeneralRegressionFormulaAuto")
}

generateTrainGeneralRegressionFormulaAuto()

visit = loadVisitCsv("Visit")

generateGeneralRegressionFormulaVisit = function(){
	visit.glm = glm(docvis ~ ., data = visit, family = poisson(link = "sqrt"))
	print(visit.glm)

	docvis = predict(visit.glm, newdata = visit, type = "response")

	storeRds(visit.glm, "GeneralRegressionFormulaVisit")
	storeCsv(data.frame("docvis" = docvis), "GeneralRegressionFormulaVisit")
}

generateGeneralRegressionFormulaVisit()

wine_quality = loadWineQualityCsv("WineQuality")

generateGeneralRegressionFormulaWineQuality = function(){
	wine_quality.glm = glm(quality ~ ., data = wine_quality)
	print(wine_quality.glm)

	quality = predict(wine_quality.glm, newdata = wine_quality)

	storeRds(wine_quality.glm, "GeneralRegressionFormulaWineQuality")
	storeCsv(data.frame("quality" = quality), "GeneralRegressionFormulaWineQuality")
}

generateGeneralRegressionCustFormulaWineQuality = function(){
	wine_quality.glm = glm(quality ~ base::cut(fixed.acidity, breaks = 10, dig.lab = 6) + base::cut(volatile.acidity, breaks = c(0, 0.5, 1.0, 1.5, 2.0)) + I(citric.acid) + I(residual.sugar) + I(chlorides) + base::cut(free.sulfur.dioxide / total.sulfur.dioxide, "breaks" = c(0, 0.2, 0.4, 0.6, 0.8, 1.0)) + + I(density) + I(pH) + I(sulphates) + I(alcohol), data = wine_quality)
	print(wine_quality.glm)

	quality = predict(wine_quality.glm, newdata = wine_quality)

	storeRds(wine_quality.glm, "GeneralRegressionCustFormulaWineQuality")
	storeCsv(data.frame("quality" = quality), "GeneralRegressionCustFormulaWineQuality")
}

generateGeneralRegressionFormulaWineQuality()
generateGeneralRegressionCustFormulaWineQuality()
