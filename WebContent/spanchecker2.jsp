
<%
	Object span = (null == session.getAttribute("st_span")) ? "" : session.getAttribute("st_span");
	if (span != null && (span.toString()).equalsIgnoreCase("month")) {
%>

<div class="btn-group colors" data-toggle="buttons">
	<label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="day" autocomplete="off" onchange="spanChanged()"> Day
	</label> <label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="week" autocomplete="off" onchange="spanChanged()"> Week
	</label> <label class="btn btn-default btn-sm active"> <input type="radio"
		name="options" value="month" autocomplete="off" checked onchange="spanChanged()">
		Month
	</label> <label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="year" autocomplete="off" onchange="spanChanged()"> Year
	</label>
</div>
<%
	} else if (span != null && (span.toString()).equalsIgnoreCase("day")) {
%>
<div class="btn-group colors" data-toggle="buttons">
	<label class="btn btn-default btn-sm active"> <input type="radio"
		name="options" value="day" autocomplete="off" checked onchange="spanChanged()">
		Day
	</label> <label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="week" autocomplete="off" onchange="spanChanged()"> Week
	</label> <label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="month" autocomplete="off" onchange="spanChanged()"> Month
	</label> <label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="year" autocomplete="off" onchange="spanChanged()"> Year
	</label>
</div>
<%
	} else if (span != null && (span.toString()).equalsIgnoreCase("year")) {
%>
<div class="btn-group colors" data-toggle="buttons">
	<label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="day" autocomplete="off" onchange="spanChanged()"> Day
	</label> <label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="week" autocomplete="off" onchange="spanChanged()"> Week
	</label> <label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="month" autocomplete="off" onchange="spanChanged()"> Month
	</label> <label class="btn btn-default btn-sm active"> <input type="radio"
		name="options" value="year" autocomplete="off" checked onchange="spanChanged()">
		Year
	</label>
</div>
<%
	} else if (span != null && (span.toString()).equalsIgnoreCase("week")) {
%>

<div class="btn-group colors" data-toggle="buttons">
	<label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="day" autocomplete="off" onchange="spanChanged()"> Day
	</label> <label class="btn btn-default btn-sm active"> <input type="radio"
		name="options" value="week" autocomplete="off" checked onchange="spanChanged()">
		Week
	</label> <label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="month" autocomplete="off" onchange="spanChanged()"> Month
	</label> <label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="year" autocomplete="off" onchange="spanChanged()"> Year
	</label>
</div>
<%
	} else {
%>
<div class="btn-group colors" data-toggle="buttons">
	<label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="day" autocomplete="off" onchange="spanChanged()"> Day
	</label> <label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="week" autocomplete="off" onchange="spanChanged()"> Week
	</label> <label class="btn btn-default btn-sm active"> <input type="radio" name="options"
		value="month" autocomplete="off" onchange="spanChanged()"> Month
	</label> <label class="btn btn-default btn-sm"> <input type="radio" name="options"
		value="year" autocomplete="off" onchange="spanChanged()"> Year
	</label>
</div>

<%
	}
%>