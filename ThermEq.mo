within ;
package TermEq "Excercise in thermodynamic equilibrium"
  extends Modelica.Icons.Library2;
  package Interfaces
    extends Modelica.Icons.Library;
    connector ThermalNode "Thermal connector"
      Modelica.SIunits.Temp_K T(start = 300);
      flow Modelica.SIunits.HeatFlowRate Q;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics={  Rectangle(extent = {{-80,80},{80,-80}}, lineColor = {135,135,135},
                fillPattern =                                                                                                    FillPattern.Backward, fillColor = {255,255,255})}));
    end ThermalNode;
  end Interfaces;

  package Boundaries
    model FixedTemperature
      parameter Modelica.SIunits.Temp_K T = 300 "Fixed Temperature";
      Interfaces.ThermalNode thermalNode annotation(Placement(transformation(extent = {{60,-10},{80,10}}), iconTransformation(extent = {{60,-10},{80,10}})));
    equation
      T = thermalNode.T;
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={  Ellipse(extent = {{70,80},{-90,-80}}, lineColor = {135,135,135}, fillColor = {255,0,0},
                fillPattern =                                                                                                    FillPattern.Sphere),Text(extent = {{-90,80},{70,-80}}, lineColor = {135,135,135},
                fillPattern =                                                                                                    FillPattern.Sphere, fillColor = {255,0,0}, textString = "T"),Text(extent = {{-80,-80},{60,-100}}, lineColor = {0,0,0},
                lineThickness =                                                                                                    0.5, fillColor = {215,215,215},
                fillPattern =                                                                                                    FillPattern.CrossDiag, textString = "%name")}));
    end FixedTemperature;

    model FixedHeatFlowRate
      parameter Modelica.SIunits.HeatFlowRate Q = 10 "Fixed Temperature";
      Interfaces.ThermalNode thermalNode annotation(Placement(transformation(extent = {{60,-10},{80,10}}), iconTransformation(extent = {{60,-10},{80,10}})));
    equation
      Q = -thermalNode.Q;
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={  Ellipse(extent = {{70,80},{-90,-80}}, lineColor = {135,135,135}, fillColor = {255,0,0},
                fillPattern =                                                                                                    FillPattern.Sphere),Text(extent = {{-90,80},{70,-80}}, lineColor = {135,135,135},
                fillPattern =                                                                                                    FillPattern.Sphere, fillColor = {255,0,0}, textString = "Q"),Text(extent = {{-80,-80},{60,-100}}, lineColor = {0,0,0},
                lineThickness =                                                                                                    0.5, fillColor = {215,215,215},
                fillPattern =                                                                                                    FillPattern.CrossDiag, textString = "%name")}));
    end FixedHeatFlowRate;
  end Boundaries;

  package Components
    model Weight "Weight with a thermal inertia"
      extends ThermalCapacitance;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics={  Rectangle(extent = {{-60,60},{40,-80}}, lineColor = {135,135,135},
                fillPattern =                                                                                                    FillPattern.VerticalCylinder, fillColor = {199,169,0},
                lineThickness =                                                                                                    0.5),Ellipse(extent = {{-30,100},{10,60}}, lineColor = {135,135,135},
                fillPattern =                                                                                                    FillPattern.Sphere, fillColor = {199,169,0}),Text(extent = {{-60,-80},{40,-100}}, lineColor = {0,0,0},
                fillPattern =                                                                                                    FillPattern.Sphere, fillColor = {199,169,0}, textString = "%name"),Text(extent = {{-60,20},{40,-40}}, lineColor = {0,0,0},
                fillPattern =                                                                                                    FillPattern.Sphere, fillColor = {199,169,0}, textString = "kg")}));
    end Weight;

    model GlasOfWater
      "Cylindrical glass of water filled to the top and some displacement some of the water"
      extends ThermalCapacitance;
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics={  Rectangle(rotation = 0, lineColor = {175,175,175}, fillColor = {240,255,252}, pattern = LinePattern.Solid,
                fillPattern =                                                                                                    FillPattern.Solid,
                lineThickness =                                                                                                    0.25, extent = {{-74,78},{54,-74}}),Text(rotation = 0, lineColor = {0,0,0}, fillColor = {199,169,0}, pattern = LinePattern.Solid,
                fillPattern =                                                                                                    FillPattern.Sphere,
                lineThickness =                                                                                                    0.25, extent = {{-60,-80},{40,-100}}, textString = "%name"),Rectangle(rotation = 0, lineColor = {175,175,175}, fillColor = {170,213,255}, pattern = LinePattern.Solid,
                fillPattern =                                                                                                    FillPattern.Sphere,
                lineThickness =                                                                                                    0.25, extent = {{-80,80},{-74,-74}}),Rectangle(rotation = 0, lineColor = {175,175,175}, fillColor = {170,213,255}, pattern = LinePattern.Solid,
                fillPattern =                                                                                                    FillPattern.Sphere,
                lineThickness =                                                                                                    0.25, extent = {{54,80},{60,-74}}),Rectangle(rotation = 0, lineColor = {175,175,175}, fillColor = {170,213,255}, pattern = LinePattern.Solid,
                fillPattern =                                                                                                    FillPattern.Sphere,
                lineThickness =                                                                                                    0.25, extent = {{-74,-68},{54,-74}})}));
    end GlasOfWater;

    model ThermalCapacitance "Thermal capacitance"
      parameter Modelica.SIunits.Volume V = 0.000005 "Volume";
      parameter Modelica.SIunits.Density rho = 7000 "Density";
      parameter Modelica.SIunits.SpecificHeatCapacity cp = 2000
        "Specific heat capacity";
      parameter Modelica.SIunits.Temp_K T_init = 300 "Initial temperature";
      Interfaces.ThermalNode tn(T(start = T_init)) annotation(Placement(transformation(extent = {{28,-20},{48,0}}), iconTransformation(extent = {{30,-20},{50,0}})));
    equation
      rho * V * cp * der(tn.T) = tn.Q;
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
    end ThermalCapacitance;

    model Convection "Convective heat transfer"
      parameter Modelica.SIunits.CoefficientOfHeatTransfer U = 1
        "Heat transfer coefficient";
      parameter Modelica.SIunits.Area A = 0.04 "Surface area";
      Interfaces.ThermalNode a annotation(Placement(transformation(extent = {{-10,40},{10,60}}), iconTransformation(extent = {{-10,38},{10,58}})));
      Interfaces.ThermalNode b annotation(Placement(transformation(extent = {{-10,-60},{10,-40}}), iconTransformation(extent = {{-10,-58},{10,-38}})));
    equation
      a.Q = -b.Q;
      a.Q = U * A * (a.T - b.T);
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics={  Rectangle(extent = {{-80,40},{80,20}}, lineColor = {127,0,0}, fillColor = {215,215,215},
                fillPattern =                                                                                                    FillPattern.CrossDiag),Rectangle(extent = {{-80,-20},{80,-40}}, lineColor = {127,0,0}, fillColor = {215,215,215},
                fillPattern =                                                                                                    FillPattern.CrossDiag),Line(points = {{0,18},{0,-18}}, color = {255,0,0}, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}, thickness = 0.5),Line(points = {{20,18},{20,-18}}, color = {255,0,0}, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}, thickness = 0.5),Line(points = {{60,18},{60,-18}}, color = {255,0,0}, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}, thickness = 0.5),Line(points = {{40,18},{40,-18}}, color = {255,0,0}, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}, thickness = 0.5),Line(points = {{-20,18},{-20,-18}}, color = {255,0,0}, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}, thickness = 0.5),Line(points = {{-40,18},{-40,-18}}, color = {255,0,0}, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}, thickness = 0.5),Line(points = {{-60,18},{-60,-18}}, color = {255,0,0}, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}, thickness = 0.5)}));
    end Convection;
  end Components;

  package Examples
    model ConvectiveHeatLoss
      extends Modelica.Icons.Example;
      Components.Convection convection annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 90, origin = {10,10})));
      Boundaries.FixedTemperature ambientTemperature(T = 293.15) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 180, origin = {50,10})));
      Components.GlasOfWater glasOfHotWater(T_init = 373.15) annotation(Placement(transformation(extent = {{-78,-16},{-20,42}})));
    equation
      connect(glasOfHotWater.tn,convection.a) annotation(Line(points = {{-37.4,10.1},{-18.1,10.1},{-18.1,10},{5.2,10}}, color = {135,135,135}, thickness = 0.5, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}));
      connect(convection.b,ambientTemperature.thermalNode) annotation(Line(points = {{14.8,10},{43,10}}, color = {135,135,135}, thickness = 0.5, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}));
      annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics), experiment(StopTime = 5000), experimentSetupOutput);
    end ConvectiveHeatLoss;

    model OneWeight "One hot weight placed in a glass of water"
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Length dW = 0.03 "Weight diameter";
      parameter Modelica.SIunits.Length hW = 0.06 "Weight height";
      parameter Modelica.SIunits.Length dG = 0.1 "Glass diameter";
      parameter Modelica.SIunits.Length hG = 0.12 "Glass height";
      parameter Modelica.SIunits.Area sW = 2 * Modelica.Constants.pi * dW ^ 2 / 4 + Modelica.Constants.pi * dW * hW
        "Surface area of weight";
      parameter Modelica.SIunits.Area sG = Modelica.Constants.pi * dG ^ 2 / 4 + Modelica.Constants.pi * dG * hG
        "Surface area of glass interfacing water";
      parameter Modelica.SIunits.Volume vG0 = Modelica.Constants.pi * dG ^ 2 / 4 * hG
        "Volume of empty glass";
      parameter Modelica.SIunits.Volume vW = Modelica.Constants.pi * dW ^ 2 / 4 * hW
        "Volume of weight";
      Components.Weight weight(V = vW, T_init = 373.15) annotation(Placement(transformation(extent = {{-80,-22},{-40,18}})));
      Components.GlasOfWater glasOfColdWater(V = vG0 - vW, T_init = 293.15) annotation(Placement(transformation(extent = {{80,-40},{0,40}})));
      Components.Convection convectionToAmbient(A = sG, U = 500) annotation(Placement(transformation(extent = {{-24,-48},{-4,-28}})));
      Components.Convection convectionToWeight(U = 1000, A = sW) annotation(Placement(visible = true, transformation(origin = {-32,-4}, extent = {{10,-10},{-10,10}}, rotation = 90)));
      Boundaries.FixedTemperature ambientTemperature(T = 293.15) annotation(Placement(visible = true, transformation(origin = {-14,-64}, extent = {{10,-10},{-10,10}}, rotation = 270)));
    equation
      connect(glasOfColdWater.tn,convectionToAmbient.a) annotation(Line(points = {{24,-4},{-14,-4},{-14,-33.2}}, color = {135,135,135}, thickness = 0.5, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}));
      connect(weight.tn,convectionToWeight.a) annotation(Line(points = {{-52,-4},{-36.8,-4}}, color = {135,135,135}, thickness = 0.5, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}));
      connect(convectionToWeight.b,glasOfColdWater.tn) annotation(Line(points = {{-27.2,-4},{24,-4}}, color = {135,135,135}, thickness = 0.5, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}));
      connect(ambientTemperature.thermalNode,convectionToAmbient.b) annotation(Line(points = {{-14,-57},{-14,-42.8}}, color = {135,135,135}, thickness = 0.5, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}));
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), experiment(StopTime = 1800), experimentSetupOutput, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics));
    end OneWeight;

    model TwoWeights "Two hot weights placed in a glass of cold water"
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Length dW = 0.03 "Weight diameter";
      parameter Modelica.SIunits.Length hW = 0.06 "Weight height";
      parameter Modelica.SIunits.Length dG = 0.1 "Glass diameter";
      parameter Modelica.SIunits.Length hG = 0.12 "Glass height";
      parameter Modelica.SIunits.Area sW = 2 * Modelica.Constants.pi * dW ^ 2 / 4 + Modelica.Constants.pi * dW * hW
        "Surface area of weight";
      parameter Modelica.SIunits.Area sG = Modelica.Constants.pi * dG ^ 2 / 4 + Modelica.Constants.pi * dG * hG
        "Surface area of glass interfacing water";
      parameter Modelica.SIunits.Volume vG0 = Modelica.Constants.pi * dG ^ 2 / 4 * hG
        "Volume of empty glass";
      parameter Modelica.SIunits.Volume vW = Modelica.Constants.pi * dW ^ 2 / 4 * hW
        "Volume of weight";
      Components.Weight weight2(V = vW, T_init = 373.15) annotation(Placement(transformation(extent = {{-80,-22},{-40,18}})));
      Components.GlasOfWater glasOfColdWater(V = vG0 - vW,
        rho=1100,
        cp=4186,
        T_init=293.15)                                                      annotation(Placement(transformation(extent = {{80,-40},{0,40}})));
      Components.Convection convectionToAmbient(A = sG, U = 500) annotation(Placement(transformation(extent = {{-24,-48},{-4,-28}})));
      Components.Weight weight1(V = weight2.V, T_init = 473.15) annotation(Placement(transformation(extent = {{-72,50},{-50,68}})));
      Components.Convection convection2(U = 1000, A = sW) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 90, origin = {-34,58})));
      Components.Convection convection1(U = 1000, A = sW) annotation(Placement(visible = true, transformation(origin = {-32,-4}, extent = {{10,-10},{-10,10}}, rotation = 90)));
      Boundaries.FixedTemperature ambientTemperature(T = 293.15) annotation(Placement(visible = true, transformation(origin = {-14,-64}, extent = {{10,-10},{-10,10}}, rotation = 270)));
    equation
      connect(glasOfColdWater.tn,convectionToAmbient.a) annotation(Line(points = {{24,-4},{-14,-4},{-14,-33.2}}, color = {135,135,135}, thickness = 0.5, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}));
      connect(weight2.tn,convection1.a) annotation(Line(points = {{-52,-4},{-36.8,-4}}, color = {135,135,135}, thickness = 0.5, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}));
      connect(convection1.b,glasOfColdWater.tn) annotation(Line(points = {{-27.2,-4},{24,-4}}, color = {135,135,135}, thickness = 0.5, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}));
      connect(ambientTemperature.thermalNode,convectionToAmbient.b) annotation(Line(points = {{-14,-57},{-14,-42.8}}, color = {135,135,135}, thickness = 0.5, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}));
      connect(convection2.b,glasOfColdWater.tn) annotation(Line(points = {{-29.2,58},{0,58},{0,-4},{24,-4}}, color = {135,135,135}, thickness = 0.5, smooth = Smooth.None, arrow = {Arrow.None,Arrow.Filled}));
      connect(weight1.tn,convection2.a) annotation(Line(points = {{-56.6,58.1},{-36,58.1},{-36,58},{-38.8,58}}, color = {135,135,135}, smooth = Smooth.None));
      annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), experiment(StopTime = 1800), experimentSetupOutput, Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics));
    end TwoWeights;
  end Examples;
  annotation(uses(Modelica(version = "3.2")), Documentation(info = "<html>
<p>This is an example of component oriented modeling of a thermal system.</p>

<p>The system consists of hot weights being placed in a glass of (cold) water and a thermal equilibrium being reached after some time.</p>
</html>"));
end TermEq;

