import React, { useState } from 'react';

const SettingPanel = () => {
    const [activeTab, setActiveTab] = useState('General');

    const tabs = [
        { name: 'General', icon: 'fas fa-cog' },
        { name: 'Attendance Rules', icon: 'fas fa-clock' },
        { name: 'Geofencing', icon: 'fas fa-map-marker-alt' },
        { name: 'Notifications', icon: 'fas fa-bell' },
        { name: 'Security', icon: 'fas fa-shield-alt' }
    ];

    return (
        <div className="p-8 bg-[#D1D5DB] min-h-screen rounded-tl-[40px] space-y-8">

            {/* Header with Save Status */}
            <div className="flex justify-between items-end">
                <div>
                    <h1 className="text-2xl font-bold text-gray-800 tracking-tight">System Settings</h1>
                    <p className="text-sm text-gray-500 font-medium">Configure company-wide attendance protocols</p>
                </div>
                <div className="hidden md:flex items-center gap-2 text-[10px] font-bold text-green-600 bg-green-50 px-3 py-1 rounded-full">
                    <span className="w-1.5 h-1.5 bg-green-500 rounded-full animate-pulse"></span>
                    ALL SYSTEMS OPERATIONAL
                </div>
            </div>

            <div className="flex flex-col lg:flex-row gap-8">

                {/* Left Sidebar Navigation */}
                <div className="w-full lg:w-72 space-y-3">
                    <div className="bg-white/40 backdrop-blur-md p-4 rounded-[32px] border border-white/50 shadow-sm">
                        {tabs.map((tab) => (
                            <button
                                key={tab.name}
                                onClick={() => setActiveTab(tab.name)}
                                className={`w-full flex items-center gap-4 px-5 py-4 rounded-2xl text-sm font-bold transition-all duration-300 ${activeTab === tab.name
                                    ? 'bg-gray-800 text-white shadow-xl translate-x-2'
                                    : 'text-gray-500 hover:bg-white/60 hover:text-gray-800'
                                    }`}
                            >
                                <div className={`w-8 h-8 rounded-lg flex items-center justify-center ${activeTab === tab.name ? 'bg-gray-700' : 'bg-gray-200/50'}`}>
                                    <i className={`${tab.icon} text-xs`}></i>
                                </div>
                                {tab.name}
                            </button>
                        ))}
                    </div>

                    {/* Quick Info Card */}
                    <div className="p-6 bg-gray-800 rounded-[32px] text-white space-y-2 shadow-lg shadow-gray-400">
                        <p className="text-[10px] font-bold opacity-50 uppercase tracking-widest">Server Version</p>
                        <p className="text-xs font-medium">v2.4.0-production</p>
                        <button className="text-[10px] font-black text-blue-400 hover:text-blue-300 transition-colors uppercase">Check Updates</button>
                    </div>
                </div>

                {/* Right Content Area */}
                <div className="flex-1 bg-white rounded-[40px] shadow-sm border border-gray-100 flex flex-col min-h-[600px]">
                    
                    <div className="p-10 flex-1">
                        {/* Tab Content Logic */}
                        <div className="max-w-3xl">
                            {activeTab === 'General' && (
                                <div className="space-y-8 animate-in fade-in slide-in-from-bottom-4">
                                    <section className="space-y-6">
                                        <div className="flex items-center gap-3 border-b border-gray-50 pb-4">
                                            <div className="w-10 h-10 bg-gray-100 rounded-xl flex items-center justify-center text-gray-500">
                                                <i className="fas fa-building"></i>
                                            </div>
                                            <h2 className="text-lg font-bold text-gray-800">Company Profile</h2>
                                        </div>
                                        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                                            <div className="space-y-2">
                                                <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">Company Name</label>
                                                <input type="text" defaultValue="CNP Company Co.Ltd" className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm focus:ring-2 focus:ring-gray-200 transition-all" />
                                            </div>
                                            <div className="space-y-2">
                                                <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">Support Email</label>
                                                <input type="email" defaultValue="admin@cnp-company.com" className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm focus:ring-2 focus:ring-gray-200 transition-all" />
                                            </div>
                                        </div>
                                    </section>

                                    <section className="space-y-6">
                                        <div className="flex items-center gap-3 border-b border-gray-50 pb-4 pt-4">
                                            <div className="w-10 h-10 bg-gray-100 rounded-xl flex items-center justify-center text-gray-500">
                                                <i className="fas fa-calendar-alt"></i>
                                            </div>
                                            <h2 className="text-lg font-bold text-gray-800">Work Schedule</h2>
                                        </div>
                                        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                                            <div className="space-y-2">
                                                <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">Office Start</label>
                                                <input type="time" defaultValue="08:00" className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm" />
                                            </div>
                                            <div className="space-y-2">
                                                <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">Office End</label>
                                                <input type="time" defaultValue="17:00" className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm" />
                                            </div>
                                            <div className="space-y-2">
                                                <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">Grace Period</label>
                                                <div className="relative">
                                                    <input type="number" defaultValue="15" className="w-full bg-gray-50 border-none rounded-2xl px-5 py-4 text-sm" />
                                                    <span className="absolute right-5 top-4 text-[10px] font-bold text-gray-400">MINS</span>
                                                </div>
                                            </div>
                                        </div>
                                    </section>
                                </div>
                            )}

                            {activeTab === 'Attendance Rules' && (
                                <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4">
                                    <h2 className="text-lg font-bold text-gray-800">Rules & Logic</h2>
                                    <div className="space-y-4">
                                        {[
                                            { title: 'Auto Clock-Out', desc: 'Force logout after 6:00 PM', enabled: true },
                                            { title: 'Overtime Pay', desc: 'Calculate extra hours automatically', enabled: false },
                                            { title: 'Weekend Access', desc: 'Allow check-ins on Sat/Sun', enabled: false }
                                        ].map((rule, i) => (
                                            <div key={i} className="flex items-center justify-between p-6 bg-gray-50 rounded-3xl">
                                                <div>
                                                    <p className="text-sm font-bold text-gray-800">{rule.title}</p>
                                                    <p className="text-xs text-gray-400">{rule.desc}</p>
                                                </div>
                                                <div className={`w-12 h-6 rounded-full relative cursor-pointer transition-colors ${rule.enabled ? 'bg-green-500' : 'bg-gray-200'}`}>
                                                    <div className={`absolute top-1 bg-white w-4 h-4 rounded-full transition-all ${rule.enabled ? 'right-1' : 'left-1'}`}></div>
                                                </div>
                                            </div>
                                        ))}
                                    </div>
                                </div>
                            )}

                            {/* Geofencing Tab */}
                            {activeTab === 'Geofencing' && (
                            <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-300">
                                <div className="flex justify-between items-center">
                                <h2 className="text-lg font-bold text-gray-800">Radius Settings</h2>
                                <span className="px-3 py-1 bg-blue-50 text-blue-600 text-[10px] font-bold rounded-lg uppercase tracking-wider">GPS Active</span>
                                </div>
                                
                                {/* Integrated Map */}
                                <div className="w-full h-72 rounded-[32px] overflow-hidden border-4 border-white shadow-inner relative group">
                                <iframe 
                                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3908.77066221535!2d104.8885!3d11.5678!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zMTHCsDM0JzA0LjEiTiAxMDTCsDUzJzE4LjYiRQ!5e0!3m2!1sen!2skh!4v1647000000000!5m2!1sen!2skh" 
                                    className="w-full h-full"
                                    style={{ border: 0 }} 
                                    allowFullScreen="" 
                                    loading="lazy" 
                                    referrerPolicy="no-referrer-when-downgrade"
                                ></iframe>
                                <div className="absolute inset-0 pointer-events-none border-[12px] border-white/20 rounded-[32px]"></div>
                                </div>

                                <div className="space-y-4 bg-gray-50 p-6 rounded-[32px]">
                                <div className="flex justify-between items-end">
                                    <label className="text-[11px] font-bold text-gray-400 uppercase">Detection Range</label>
                                    <span className="text-xl font-black text-gray-800">200<span className="text-sm font-medium">m</span></span>
                                </div>
                                <input type="range" min="50" max="1000" defaultValue="200" className="w-full h-1.5 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-gray-800" />
                                <p className="text-[10px] text-gray-400 font-medium">Employees must be within this radius of the pinned location to check in.</p>
                                </div>
                            </div>
                            )}

                            {/* Notifications Tab */}
                            {activeTab === 'Notifications' && (
                            <div className="space-y-8 animate-in fade-in slide-in-from-bottom-4 duration-300">
                                <h2 className="text-lg font-bold text-gray-800">Broadcast & Alerts</h2>
                                
                                <div className="space-y-3">
                                {[
                                    { title: 'Late Arrival Alert', desc: 'Notify admin when staff is late > 15 mins', icon: 'fa-clock' },
                                    { title: 'Leave Request', desc: 'Push notification for new leave applications', icon: 'fa-envelope-open-text' },
                                    { title: 'Monthly Report', desc: 'Send automated PDF summary to email', icon: 'fa-file-alt' },
                                    { title: 'System Maintenance', desc: 'Alerts for planned server downtime', icon: 'fa-server' }
                                ].map((note, i) => (
                                    <div key={i} className="flex items-center gap-4 p-5 bg-gray-50 hover:bg-white hover:shadow-md rounded-[24px] border border-transparent hover:border-gray-100 transition-all cursor-pointer group">
                                    <div className="w-12 h-12 bg-white rounded-2xl flex items-center justify-center text-gray-400 group-hover:text-gray-800 transition-colors">
                                        <i className={`fas ${note.icon}`}></i>
                                    </div>
                                    <div className="flex-1">
                                        <p className="text-sm font-bold text-gray-800">{note.title}</p>
                                        <p className="text-[11px] text-gray-400 font-medium">{note.desc}</p>
                                    </div>
                                    <div className="w-12 h-6 bg-gray-200 rounded-full relative">
                                        <div className="absolute left-1 top-1 bg-white w-4 h-4 rounded-full"></div>
                                    </div>
                                    </div>
                                ))}
                                </div>
                            </div>
                            )}

                            {/* Security Tab */}
                            {activeTab === 'Security' && (
                            <div className="space-y-8 animate-in fade-in slide-in-from-bottom-4 duration-300">
                                <h2 className="text-lg font-bold text-gray-800">Access Control</h2>
                                
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div className="p-6 bg-gray-800 rounded-[32px] text-white space-y-4">
                                    <div className="w-10 h-10 bg-white/10 rounded-xl flex items-center justify-center">
                                    <i className="fas fa-fingerprint"></i>
                                    </div>
                                    <div>
                                    <h3 className="font-bold text-sm">Two-Factor Auth (2FA)</h3>
                                    <p className="text-[10px] opacity-60">Add an extra layer of security to Admin accounts.</p>
                                    </div>
                                    <button className="w-full py-3 bg-white text-gray-800 rounded-xl text-[11px] font-black uppercase tracking-wider">Enable Now</button>
                                </div>

                                <div className="p-6 bg-white border border-gray-100 rounded-[32px] shadow-sm space-y-4">
                                    <div className="w-10 h-10 bg-gray-100 rounded-xl flex items-center justify-center text-gray-500">
                                    <i className="fas fa-history"></i>
                                    </div>
                                    <div>
                                    <h3 className="font-bold text-sm text-gray-800">Login History</h3>
                                    <p className="text-[10px] text-gray-400">Review recent active sessions and IP addresses.</p>
                                    </div>
                                    <button className="w-full py-3 bg-gray-100 text-gray-500 rounded-xl text-[11px] font-black uppercase tracking-wider hover:bg-gray-200">View Logs</button>
                                </div>
                                </div>

                                <div className="space-y-4">
                                <label className="text-[11px] font-bold text-gray-400 uppercase ml-1">Password Policy</label>
                                <div className="p-5 bg-gray-50 rounded-[24px] flex justify-between items-center">
                                    <span className="text-sm font-semibold text-gray-700">Require special characters</span>
                                    <div className="w-12 h-6 bg-green-500 rounded-full relative">
                                    <div className="absolute right-1 top-1 bg-white w-4 h-4 rounded-full"></div>
                                    </div>
                                </div>
                                </div>
                            </div>
                            )}
                        </div>
                    </div>

                    {/* Fixed Footer for Save Action */}
                    <div className="p-8 bg-gray-50/50 border-t border-gray-50 rounded-b-[40px] flex justify-between items-center">
                        <p className="text-xs text-gray-400 font-medium italic">Unsaved changes will be lost if you switch pages.</p>
                        <div className="flex gap-4">
                            <button className="px-8 py-4 rounded-2xl text-sm font-bold text-gray-400 hover:bg-gray-100 transition-all">Reset</button>
                            <button className="px-10 py-4 bg-gray-800 text-white rounded-2xl text-sm font-bold hover:bg-black shadow-lg shadow-gray-400 transition-all">Save Changes</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default SettingPanel;

