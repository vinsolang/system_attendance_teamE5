import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { Bell, Home, Settings, ShoppingBag, Users } from 'lucide-react';

const Sidebar = () => {
  const location = useLocation();

  // Example notification count
  const notificationCount = 3; // <-- you can get this from state or props

  const navItems = [
    { icon: <Home size={20} />, label: 'Today Summary', href: '/admin/dashboard' },
    { icon: <Users size={20} />, label: 'Employee', href: '/admin/employee' },
    { icon: <ShoppingBag size={20} />, label: 'Live Attendance Status', href: 'admin/manualadjustments' },
    { icon: <Users size={20} />, label: 'Manual Adjustments', href: '/admin/manualadjustments' },
    { 
      icon: <Bell size={20} />, 
      label: 'Alert & Notifications', 
      href: '/admin/notification',
      badge: notificationCount, // add badge property
    },
    { icon: <Settings size={20} />, label: 'Setting Panel', href: '/admin/setting' },
  ];

  return (
    <div className="w-64 bg-gray-900 text-gray-200 h-screen fixed top-0 left-0 flex flex-col z-50 shrink-0">
      <div className="p-6 text-2xl font-bold border-b border-gray-700">Admin Panel</div>
      <nav className="flex-1 mt-4 space-y-2 uppercase text-xs font-semibold tracking-wide">
        {navItems.map((item, idx) => {
          const isActive = location.pathname === item.href;
          return (
            <Link
              key={idx}
              to={item.href}
              className={`flex items-center gap-3 px-6 py-4 transition-colors relative ${
                isActive ? 'bg-gray-800 text-white border-r-4 border-blue-500' : 'hover:bg-gray-800'
              }`}
            >
              {/* Icon with badge */}
              <div className="relative">
                {item.icon}
                {item.badge && (
                  <span className="absolute -top-3 -right-2 bg-red-500 text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center">
                    {item.badge}
                  </span>
                )}
              </div>

              <span>{item.label}</span>
            </Link>
          );
        })}
      </nav>
    </div>
  );
};

export default Sidebar;