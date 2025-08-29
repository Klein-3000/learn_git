# linux note contribute graph
```contributionGraph
title: Contributions
graphType: default
dateRangeValue: 180
dateRangeType: FIXED_DATE_RANGE
startOfWeek: 1
showCellRuleIndicators: true
titleStyle:
  textAlign: center
  fontSize: 15px
  fontWeight: normal
dataSource:
  type: PAGE
  value: ""
  dateField: {}
  filters: []
fillTheScreen: true
enableMainContainerShadow: false
cellStyleRules:
  - id: Ocean_a
    color: "#8dd1e2"
    min: 1
    max: 2
  - id: Ocean_b
    color: "#63a1be"
    min: 2
    max: 3
  - id: Ocean_c
    color: "#376d93"
    min: 3
    max: 5
  - id: Ocean_d
    color: "#012f60"
    min: 5
    max: 9999
fromDate: 2025-04-02
toDate: 2025-07-05

```
# colorful clock
```dataviewjs
// --- 1. 定义时钟的 HTML 结构 ---
const clockHTML = `
<div id="clock" class="progress-clock">
    <button class="progress-clock__time-date" data-group="d" type="button">
        <small data-unit="w">星期四</small><br>
        <span data-unit="mo">六月</span>
        <span data-unit="d">20</span>
    </button>
    <button class="progress-clock__time-digit" data-unit="h" data-group="h" type="button">12</button>
    <span class="progress-clock__time-colon">:</span>
    <button class="progress-clock__time-digit" data-unit="m" data-group="m" type="button">30</button>
    <span class="progress-clock__time-colon">:</span>
    <button class="progress-clock__time-digit" data-unit="s" data-group="s" type="button">55</button>
    <span class="progress-clock__time-ampm" data-unit="ap">pm</span>
    <svg class="progress-clock__rings" width="256" height="256" viewBox="0 0 256 256">
        <g data-units="d">
            <circle class="progress-clock__ring" cx="128" cy="128" r="74" fill="none" opacity="0.1" stroke="#e13e78" stroke-width="12"></circle>
            <circle class="progress-clock__ring-fill" data-ring="mo" cx="128" cy="128" r="74" fill="none" stroke="#e13e78" stroke-width="12" stroke-dasharray="465 465" stroke-dashoffset="0" stroke-linecap="round" transform="rotate(-90,128,128)"></circle>
        </g>
        <g data-units="h">
            <circle class="progress-clock__ring" cx="128" cy="128" r="90" fill="none" opacity="0.1" stroke="#e79742" stroke-width="12"></circle>
            <circle class="progress-clock__ring-fill" data-ring="d" cx="128" cy="128" r="90" fill="none" stroke="#e79742" stroke-width="12" stroke-dasharray="565.5 565.5" stroke-dashoffset="0" stroke-linecap="round" transform="rotate(-90,128,128)"></circle>
        </g>
        <g data-units="m">
            <circle class="progress-clock__ring" cx="128" cy="128" r="106" fill="none" opacity="0.1" stroke="#4483ec" stroke-width="12"></circle>
            <circle class="progress-clock__ring-fill" data-ring="h" cx="128" cy="128" r="106" fill="none" stroke="#4483ec" stroke-width="12" stroke-dasharray="666 666" stroke-dashoffset="0" stroke-linecap="round" transform="rotate(-90,128,128)"></circle>
        </g>
        <g data-units="s">
            <circle class="progress-clock__ring" cx="128" cy="128" r="122" fill="none" opacity="0.1" stroke="#8f30eb" stroke-width="12"></circle>
            <circle class="progress-clock__ring-fill" data-ring="m" cx="128" cy="128" r="122" fill="none" stroke="#8f30eb" stroke-width="12" stroke-dasharray="766.5 766.5" stroke-dashoffset="0" stroke-linecap="round" transform="rotate(-90,128,128)"></circle>
        </g>
    </svg>
</div>
`;

// 将 HTML 渲染到 Dataview 容器中
dv.container.innerHTML = clockHTML;

// --- 2. JavaScript 逻辑 ---
// DataviewJS 内置了 moment.js
const dateElements = {
    week: dv.container.querySelector('[data-unit="w"]'),
    month: dv.container.querySelector('[data-unit="mo"]'),
    day: dv.container.querySelector('[data-unit="d"]'),
};
const timeElements = {
    hour: dv.container.querySelector('[data-unit="h"]'),
    minute: dv.container.querySelector('[data-unit="m"]'),
    second: dv.container.querySelector('[data-unit="s"]'),
    ampm: dv.container.querySelector('[data-unit="ap"]'),
};
const ringFills = {
    day: dv.container.querySelector('[data-ring="mo"]'),
    hour: dv.container.querySelector('[data-ring="d"]'),
    minute: dv.container.querySelector('[data-ring="h"]'),
    second: dv.container.querySelector('[data-ring="m"]'),
};

// 主更新函数
function updateClock() {
    moment.locale('zh-cn');
    const now = moment();
    const formatDate = now.format("dddd-MMMM-D-H-mm-ss-a").split("-");
    const [week, month, day, hour, minute, second, ampm] = formatDate;

    if (dateElements.week) dateElements.week.textContent = week;
    if (dateElements.month) dateElements.month.textContent = month;
    if (dateElements.day) dateElements.day.textContent = day;
    
    if (timeElements.hour) timeElements.hour.textContent = hour;
    if (timeElements.minute) timeElements.minute.textContent = minute;
    if (timeElements.second) timeElements.second.textContent = second;
    if (timeElements.ampm) timeElements.ampm.textContent = ampm;

    const daysInMonth = now.daysInMonth(); 
    const secProgress = second / 60;
    const minProgress = (parseInt(minute) + secProgress) / 60;
    const hourProgress = (parseInt(hour) + minProgress) / 24;
    const dayProgress = (parseInt(day) - 1 + hourProgress) / daysInMonth;

    const circumferences = { day: 465, hour: 565.5, minute: 666, second: 766.5 };

    if (ringFills.second) ringFills.second.setAttribute('stroke-dashoffset', (1 - secProgress) * circumferences.second);
    if (ringFills.minute) ringFills.minute.setAttribute('stroke-dashoffset', (1 - minProgress) * circumferences.minute);
    if (ringFills.hour) ringFills.hour.setAttribute('stroke-dashoffset', (1 - hourProgress) * circumferences.hour);
    if (ringFills.day) ringFills.day.setAttribute('stroke-dashoffset', (1 - dayProgress) * circumferences.day);
}

// 首次加载时立即执行一次
updateClock();

// 设置定时器，每秒更新一次
const intervalId = window.setInterval(updateClock, 1000);

// 当 Dataview 块卸载时清除定时器
dv.container.onunload = () => {
    window.clearInterval(intervalId);
}
````

# dataview
```dataview
calendar file.ctime
```


出链 引用
入链 被引用
```query
包管理
```
## 入链数最多的文档
```dataview
table without id
	file.link as 名称,
	length(file.outlinks) as "出链数",
	length(flie.inlinks) as "入链数"
sort length(file.inlinks) DESC
limit 5
```
## 出链数最多的文档
```dataview
table without id
	file.link as 名称,
	length(file.outlinks) as "出链数",
	length(flie.inlinks) as "入链数"
sort
	length(file.outlinks) DESC
limit 5
```
## orphan笔记
```dataview
table without id 
	file.link as "名称"
	,join(file.etags) as "标签"
where
	length(file.inlinks) = 0
	and length(file.outlinks) = 0
sort
	length(file.etags)
```
