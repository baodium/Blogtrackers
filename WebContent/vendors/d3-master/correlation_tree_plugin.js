(function(window, undefined) {
    window.$.fn.correlationTree = function(derivedData, settingInput) {
        var container = d3.select(this[0]);
        draw(derivedData);

        function draw(derivedData) {
                // Data settings
                var setting = initSetting(settingInput, derivedData),
                    data = _.sortBy(derivedData, function(num) {
                        return -num;
                    }).slice(0, setting.quantity);

                var dataSizeSet = _.sortBy(
                    _.uniq(
                        _.map(data, function(d) {
                            return d[2];
                        })),
                    function(num) {
                        return num;
                    });

                var width = setting.size,
                    height = setting.size,
                    margin = setting.margin,
                    centralRadius = setting.size / 6,
                    centralColor = setting.centralColor,
                    nomColor = setting.marginBlockColor,
                    corNum = ~~((1 - setting.correlation) * dataSizeSet.length);



                // Scale
                var groupScale = function(num) {
                        for (var i = dataSizeSet.length - 1; i >= 0; i--) {
                            if (num === dataSizeSet[i]) {
                                return i + 1;
                            }
                        }
                    },
                    sideScale = d3.scale.linear()
                    .domain(d3.extent(dataSizeSet))
                    .range([centralRadius * 0.2, centralRadius * 0.7]);



                var centralData = getCentralData(data),
                    forceTreeDataNodes = setForceTreeDataNodes(data),
                    forceTreeDataLinks = setForceTreeDataLinks(forceTreeDataNodes);

                var distanceScale = d3.scale.linear()
                    .domain(d3.extent(dataSizeSet))
                    .range([2.8 * centralRadius, 1.75 * centralRadius]);
                // Copy and Paste

                var color = setting.color;

                var force = d3.layout.force()
                    .charge(setting.charge)
                    .linkDistance(function(d) {
                        return distanceScale(d.value);

                    })
                    .size([width, height])
                    .gravity(setting.gravity)
                    .friction(setting.friction);
                // .theta(setting.theta);

                var svg = container.append("svg")
                    .attr("width", width)
                    .attr("height", height);


                force
                    .nodes(forceTreeDataNodes)
                    .links(forceTreeDataLinks)
                    .start();

                var lineAttrs = {
                    "class": function(d, i) {
                        return 'link ' + "line-" + (i + 1);
                    },
                    "stroke-width": 1,
                    'stroke': 'lightgray'
                };
                var link = svg.selectAll(".link")
                    .data(forceTreeDataLinks)
                    .enter()
                    .append("line")
                    .attr(lineAttrs);


                var nodes = svg.selectAll(".nodes")
                    .data(forceTreeDataNodes)
                    .enter().append("g").attr('class', 'nodes')
                    .attr('id', function(d, i) {
                        if (i === 0) {
                            return 'centralNode';
                        }
                    });


                rects = nodes.append("rect").style("fill", function(d, i) {
                    if (i === 0) {
                        return centralColor;
                    } else if (i <= corNum) {
                        if (typeof(color) === 'function') {
                            return color(d.group);
                        } else if (_.isArray(color) === true) {
                            return color[(i % color.length)];
                        } else {
                            return d3.rgb(color);
                        }

                    } else {
                        return nomColor;
                    }
                });

                var texts = nodes.append("text")
                    .attr("width", function(d) {
                        return d.group;
                    })
                    .text(function(d) {
                        return d.name;
                    });

                force.on("tick", function() {

                    var rectAttrs = {
                        'x': function(d, i) {
                            return d.x;
                        },
                        'y': function(d, i) {
                            return d.y;
                        },
                        'rx': '3',
                        'ry': '3',

                        'class': function(d, i) {
                            return 'rect-' + i;
                        }
                    };
                    rects.attr(rectAttrs);

                    var textsWidth = [];
                    var textAttrs = {
                        "text-anchor": "middle",
                        "font-size": function(d, i) {
                            if (i === 0) {
                                return centralRadius / 4;
                            } else if (i <= corNum) {
                                return centralRadius / 5;
                            } else {
                                return centralRadius / 8;
                            }
                        },
                        "x": function(d, i) {
                            textWidth = this.getComputedTextLength();
                            textsWidth[i] = textWidth;
                            if (i === 0) {
                                return d.x + textWidth / 2 + 5;
                            } else {

                                return d.x + textWidth / 2 + 5;
                            }

                        },
                        "y": function(d, i) {
                            if (i === 0) {
                                return d.y + centralRadius / 2;
                            } else if (i <= corNum) {
                                return d.y + centralRadius / 6 + 5;
                            } else {
                                return d.y + 10;
                            }
                        }
                    };

                    texts.attr(textAttrs);
                    rectSizeAttrs = {
                        "width": function(d, i) {
                            return textsWidth[i] + 10;
                        },
                        "height": function(d, i) {
                            if (i === 0) {
                                return centralRadius;
                            } else if (i <= corNum) {
                                return centralRadius / 4 + 10;
                            } else {
                                return 14;
                            }
                        }
                    };

                    var linkAttrs = {
                        'x1': function(d, i) {

                            return d.source.x + centralRadius / 2;
                        },
                        'y1': function(d, i) {

                            return d.source.y + centralRadius / 2;
                        },
                        'x2': function(d, i) {
                            return d.target.x + textsWidth[i] / 2 + 5;
                        },
                        'y2': function(d, i) {
                            if (i === 0) {
                                return d.target.y;
                            } else if (i <= corNum) {
                                return d.target.y + centralRadius / 8 + 5;
                            } else {
                                return d.target.y + 7;
                            }
                        }
                    };
                    link.attr(linkAttrs);
                    rects.attr(rectSizeAttrs);

                });


                // View adjust
                var rectsStyle = {
                    'z-index': 2,
                    'cursor': 'pointer',
                    'opacity': function(d, i) {
                        if (i <= corNum) {
                            return 0.4;
                        } else {
                            return 0.2;
                        }
                    },
                    'stroke-width': 3,
                    'stroke': function(d, i) {
                        if (i === 0) {
                            return centralColor;
                        } else if (i <= corNum) {
                            var c;
                            if (typeof(color) === 'function') {
                                c = color(d.group);
                            } else if (_.isArray(color) === true) {
                                c = color[(i % color.length)];
                            } else {
                                c = color;
                            }
                            return d3.rgb(c).darker(0.6);

                        } else {
                            return d3.rgb(nomColor).darker(2);
                        }
                    }
                };
                rects.style(rectsStyle);


                var textsStyle = {
                    'cursor': 'pointer'
                };

                texts.style(textsStyle);



                // event
                if (setting.draggable === true) {
                    nodes.call(force.drag);
                }


                nodes.on('mouseover', function() {
                    rect = d3.select(this).selectAll('rect');
                    rect.transition().duration(300)
                        .style('opacity', 1);
                    if (d3.select(this).select('.rect-0')[0][0] === null) {
                        var idNum = rect.attr('class').replace(/rect-/, '');
                        d3.select('.line-' + idNum).transition()
                            .duration(500)
                            .style('stroke', 'black')
                            .style('stroke-width', '2');
                        d3.select('.rect-0').transition()
                            .duration(500).style('opacity', 1);


                    }
                });

                nodes.on('mouseout', function() {
                    rect = d3.select(this).selectAll('rect');
                    rect.transition().duration(300)
                        .style('opacity', 0.6);
                    if (d3.select(this).select('.rect-0')[0][0] === null) {
                        var idNum = rect.attr('class').replace(/rect-/, '');
                        d3.select('.line-' + idNum).transition()
                            .duration(500)
                            .style('stroke', 'lightgray')
                            .style('stroke-width', '1');
                        d3.select('.rect-0').transition()
                            .duration(500).style('opacity', 0.6);

                    }

                });

                nodes.on('click', function(){

                });



                function getCentralData(dataSet) {
                    return dataSet[0][0];
                }

                function setForceTreeDataNodes(dataSet) {
                    var result = [{
                        'x': width / 2 - centralRadius / 2,
                        'y': height / 2 - centralRadius / 2,
                        'name': centralData,
                        'group': 0,
                        'fixed': true
                    }];
                    _.each(dataSet, function(d) {
                        var obj = {
                            'name': d[1],
                            'group': groupScale(d[2])
                        };
                        result.push(obj);
                    });
                    return result;
                }

                function setForceTreeDataLinks(dataNodeSet) {
                    var result = [];
                    _.each(dataNodeSet, function(d, i) {
                        if (i !== 0) {
                            var obj;

                            obj = {
                                "source": 0,
                                "target": i,
                                "value": dataSizeSet[d.group - 1]
                            };
                            result.push(obj);

                        }
                    });
                    return result;
                }
        }

        function initSetting(setting, data) {
            setting.size = setting.size ? setting.size : 480;
            setting.quantity = setting.quantity ? setting.quantity : data.length;
            setting.centralColor = setting.centralColor ? setting.centralColor : 'tomato';
            setting.textColor = setting.textColor ? setting.textColor : 'black';
            setting.marginBlockColor = setting.marginBlockColor ? setting.marginBlockColor : '#ddd';
            setting.correlation = (setting.correlation >= 0 && setting.correlation <= 1) ? setting.correlation : 0.95;
            if (setting.draggable !== true) {
                setting.draggable = false;
            }
            setting.gravity = (setting.gravity >= 0 && setting.gravity <= 1) ? setting.gravity : 0.2;
            setting.charge = setting.charge ? setting.charge : -120;
            setting.friction = setting.friction ? setting.friction : 0.9;
            setting.theta = setting.theta ? setting.theta : 0.8;
            setting.color = setting.color ? setting.color : d3.scale.category20();
            setting.margin = setting.margin ? setting.margin : 10;
            return setting;
        }
        return this;
    };

})(window);
