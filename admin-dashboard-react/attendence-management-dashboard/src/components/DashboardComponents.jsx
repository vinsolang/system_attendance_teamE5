import React from 'react';
import { Doughnut, Bar } from 'react-chartjs-2';
import { 
  CheckSquare, 
  AlertTriangle, 
  Shield, 
  Maximize, 
  Eye, 
  User, 
  Users as UsersIcon 
} from 'lucide-react';
import { 
  Chart as ChartJS, 
  ArcElement, 
  Tooltip, 
  Legend, 
  CategoryScale, 
  LinearScale, 
  BarElement 
} from 'chart.js';

// Register all necessary components for both Doughnut and Bar charts
ChartJS.register(
  ArcElement, 
  Tooltip, 
  Legend,
  CategoryScale, 
  LinearScale, 
  BarElement
);
// 1. Overview Component (Doughnut Chart)
export const Overview = ({ total = 458 }) => {
  const data = {
    datasets: [{
      data: [342, 93, 23],
      backgroundColor: ['#3B82F6', '#EF4444', '#84A98C'],
      borderWidth: 0,
      hoverOffset: 4
    }],
  };

  return (
    <div className="col-span-3 bg-[#E5E5E5] p-6 rounded-[2.5rem] shadow-sm flex flex-col items-center">
      <h3 className="w-full text-left text-xl font-bold text-gray-800 mb-4">Overview</h3>
      <div className="relative w-40 h-40">
        <Doughnut data={data} options={{ cutout: '75%', plugins: { legend: { display: false } } }} />
        <div className="absolute inset-0 flex flex-col items-center justify-center pointer-events-none">
          <span className="text-[10px] text-gray-500 font-bold uppercase">Total Employees</span>
          <span className="text-3xl font-bold">{total}</span>
        </div>
      </div>
    </div>
  );
};

// 2. Attendance Stats Component
export const AttendanceStats = () => (
  <div className="col-span-9 bg-[#E5E5E5] p-8 rounded-[2.5rem] shadow-sm">
    <h3 className="text-xl font-bold text-gray-800 mb-6">Attendance</h3>
    <div className="grid grid-cols-3 gap-6">
      <StatCard count="342" label="Checked In" color="text-gray-800" subColor="text-gray-500" bgColor="bg-blue-500" icon={<CheckSquare />} />
      <StatCard count="93" label="Not Checked In" color="text-gray-800" subColor="text-red-500" bgColor="bg-red-500" icon={<AlertTriangle />} />
      <StatCard count="23" label="On Leave" color="text-gray-800" subColor="text-green-600" bgColor="bg-[#84A98C]" icon={<Shield />} />
    </div>
  </div>
);

const StatCard = ({ count, label, subColor, bgColor, icon }) => (
  <div className="bg-white/60 backdrop-blur-sm p-6 rounded-3xl flex justify-between items-center">
    <div>
      <p className="text-4xl font-bold text-gray-800">{count}</p>
      <p className={`text-sm font-bold ${subColor}`}>{label}</p>
    </div>
    <div className={`${bgColor} p-4 rounded-2xl text-white`}>
      {React.cloneElement(icon, { size: 32 })}
    </div>
  </div>
);

// 3. Daily Records Component (New Bar Chart)
export const DailyRecords = () => {

  const options = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: { legend: { display: false } },
    scales: {
      x: { grid: { display: false }, border: { display: false } },
      y: {
        beginAtZero: true,
        grid: { color: "#D1D5DB", drawTicks: false },
        border: { display: false }
      }
    }
  };

  const data = {
    labels: ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"],
    datasets: [
      {
        data: [280,320,310,342,290,150,80],
        backgroundColor: "#3B82F6",
        borderRadius: 12,
        barThickness: 20
      }
    ]
  };

  return (
    <div className="col-span-4 bg-[#E5E5E5] p-8 rounded-[2.5rem] shadow-sm flex flex-col h-full">
      <h3 className="text-2xl font-bold text-gray-800 mb-8">
        Daily Records
      </h3>

      <div className="flex-1 min-h-50">
        <Bar options={options} data={data} />
      </div>
    </div>
  );
};

// 4. Attendance Source Component
export const AttendanceSource = () => {
  const sources = [
    { label: 'App Scan', count: 148, icon: <Maximize /> },
    { label: 'Fingerprint', count: 49, icon: <Eye /> },
    { label: 'Face ID', count: 67, icon: <User /> },
    { label: 'Team lead', count: 78, icon: <UsersIcon /> },
  ];

  return (
    <div className="col-span-8 bg-[#E5E5E5] p-8 rounded-[2.5rem] shadow-sm">
      <h3 className="text-xl font-bold text-gray-800 mb-6">Attendance source</h3>
      <div className="grid grid-cols-2 gap-6">
        {sources.map((s, idx) => (
          <div key={idx} className="bg-white p-6 rounded-3xl flex justify-between items-center">
            <div>
              <p className="text-sm font-bold text-gray-600 mb-2">{s.label}</p>
              <p className="text-5xl font-bold text-blue-500">{s.count}</p>
            </div>
            <div className="text-gray-700">{React.cloneElement(s.icon, { size: 48, strokeWidth: 1.5 })}</div>
          </div>
        ))}
      </div>
    </div>
  );
};