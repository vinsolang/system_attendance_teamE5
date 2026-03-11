import React, { useState } from "react";

const AlertNotifications = () => {
  const [filter, setFilter] = useState("All");

  const notifications = [
    { id: 1, type: "Attendance", title: "Late Arrival", msg: "Sreyna Paul arrived 45 mins late (08:45 AM)", time: "10 mins ago", priority: "High" },
    { id: 2, type: "Security", title: "New Login", msg: "Admin access from unrecognized IP: 192.168.1.45", time: "2 hours ago", priority: "Critical" },
    { id: 3, type: "System", title: "Backup Successful", msg: "Daily database backup completed successfully.", time: "5 hours ago", priority: "Low" },
    { id: 4, type: "Attendance", title: "Leave Request", msg: "Vichea Vy requested 2 days of annual leave.", time: "Yesterday", priority: "Medium" },
  ];

  const getPriorityColor = (priority) => {
    switch (priority) {
      case "Critical": return "bg-red-500 text-white";
      case "High": return "bg-orange-500 text-white";
      case "Medium": return "bg-blue-500 text-white";
      default: return "bg-gray-400 text-white";
    }
  };

  return (
    <div className="p-8 bg-[#D1D5DB] min-h-screen rounded-tl-[40px] space-y-8">
      
      {/* Header & Broadcast Action */}
      <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-800 tracking-tight">Alert Center</h1>
          <p className="text-sm text-gray-500 font-medium">Real-time system monitoring and staff notifications</p>
        </div>
        <button className="bg-gray-800 text-white px-6 py-3 rounded-2xl flex items-center gap-2 hover:bg-black shadow-lg shadow-gray-400/40 transition-all">
          <i className="fas fa-bullhorn text-sm"></i>
          <span className="text-sm font-bold">New Broadcast</span>
        </button>
      </div>

      {/* Filter Chips */}
      <div className="flex gap-3 overflow-x-auto pb-2">
        {["All", "Attendance", "Security", "System", "Leave"].map((cat) => (
          <button
            key={cat}
            onClick={() => setFilter(cat)}
            className={`px-6 py-2 rounded-full text-xs font-bold transition-all whitespace-nowrap ${
              filter === cat ? "bg-white text-gray-800 shadow-md" : "bg-white/40 text-gray-500 hover:bg-white/60"
            }`}
          >
            {cat}
          </button>
        ))}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        
        {/* Main Feed */}
        <div className="lg:col-span-2 space-y-4">
          {notifications.map((item) => (
            <div key={item.id} className="bg-white p-6 rounded-[32px] shadow-sm border border-gray-100 flex gap-5 group hover:shadow-md transition-all">
              <div className={`w-14 h-14 rounded-2xl flex items-center justify-center shrink-0 ${
                item.type === 'Security' ? 'bg-red-50 text-red-500' : 'bg-gray-50 text-gray-400'
              }`}>
                <i className={`fas ${item.type === 'Attendance' ? 'fa-user-clock' : item.type === 'Security' ? 'fa-shield-alt' : 'fa-server'} text-lg`}></i>
              </div>
              
              <div className="flex-1">
                <div className="flex justify-between items-start">
                  <div>
                    <span className={`text-[10px] font-black uppercase tracking-widest px-2 py-0.5 rounded-md ${getPriorityColor(item.priority)}`}>
                      {item.priority}
                    </span>
                    <h3 className="font-bold text-gray-800 mt-2">{item.title}</h3>
                  </div>
                  <span className="text-[10px] font-bold text-gray-400 uppercase">{item.time}</span>
                </div>
                <p className="text-sm text-gray-500 mt-1">{item.msg}</p>
              </div>

              <div className="flex flex-col justify-center opacity-0 group-hover:opacity-100 transition-opacity">
                <button className="p-2 hover:bg-gray-50 rounded-xl text-gray-400 hover:text-gray-800 transition-all">
                  <i className="fas fa-check-circle"></i>
                </button>
              </div>
            </div>
          ))}
          <button className="w-full py-4 text-xs font-bold text-gray-500 uppercase tracking-[0.2em] hover:text-gray-800 transition-colors">
            Load Older Notifications
          </button>
        </div>

        {/* Sidebar Summary */}
        <div className="space-y-6">
          <div className="bg-white p-8 rounded-[40px] shadow-sm border border-gray-100">
            <h2 className="font-bold text-gray-800 mb-6">Status Overview</h2>
            <div className="space-y-6">
              <div>
                <div className="flex justify-between text-xs font-bold mb-2">
                  <span className="text-gray-400 uppercase">System Health</span>
                  <span className="text-green-500 font-black">99.8%</span>
                </div>
                <div className="w-full h-1.5 bg-gray-100 rounded-full overflow-hidden">
                  <div className="w-[99.8%] h-full bg-green-500"></div>
                </div>
              </div>
              <div>
                <div className="flex justify-between text-xs font-bold mb-2">
                  <span className="text-gray-400 uppercase">Daily Attendance</span>
                  <span className="text-blue-500 font-black">188/200</span>
                </div>
                <div className="w-full h-1.5 bg-gray-100 rounded-full overflow-hidden">
                  <div className="w-[94%] h-full bg-blue-500"></div>
                </div>
              </div>
            </div>
          </div>

          {/* Quick Config Card */}
          <div className="bg-gray-800 p-8 rounded-[40px] text-white shadow-xl shadow-gray-400">
            <i className="fas fa-magic text-yellow-400 mb-4 text-xl"></i>
            <h3 className="font-bold text-lg leading-tight">Smart Alerts are active</h3>
            <p className="text-xs opacity-60 mt-2 leading-relaxed">System is automatically filtering low-priority logs for you.</p>
            <button className="mt-6 w-full py-3 bg-white/10 hover:bg-white/20 rounded-2xl text-[10px] font-black uppercase tracking-widest transition-all">
              Modify Filters
            </button>
          </div>
        </div>

      </div>
    </div>
  );
};

export default AlertNotifications;