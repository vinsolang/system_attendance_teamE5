import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Sidebar from './layout/Sidebar';
import Navbar from './components/Navbar';
import DashboardHome from './page/DashboardHome';
import AttendanceStatus from './page/AttendanceStatus';
import ManualAdjustments from './page/ManualAdjustments';
import Employee from './page/Employee';
import AlertNotifications from './page/AlertNotifications';
import SettingPanel from './page/SettingPanel';
import SignIn from './auth/SignIn';
import SignUp from './auth/SignUp';
import ProtectedRoute from './auth/ProtectedRoute';

function App() {
  return (
    <>
     <div className='hidden lg:block'>
       <Router>
      <Routes>
        {/* Public Routes */}
        <Route path="/signin" element={<SignIn />} />
        <Route path="/signup" element={<SignUp />} />

        {/* Protected Admin Routes */}
        <Route
          path="/admin/*"
          element={
            <ProtectedRoute>
              <div className="flex bg-gray-50 font-['Inter'] min-h-screen">
                <Sidebar />
                <div className="flex-1 flex flex-col">
                  <Navbar />
                  <main className="ml-64 mt-20 p-8">
                    <Routes>
                      <Route path="dashboard" element={<DashboardHome />} />
                      <Route path="employee" element={<Employee />} />
                      <Route path="manualadjustments" element={<ManualAdjustments />} />
                      <Route path="notification" element={<AlertNotifications />} />
                      <Route path="setting" element={<SettingPanel />} />
                      <Route path="attendence/status" element={<AttendanceStatus />} />
                      <Route path="/" element={<Navigate to="dashboard" />} />
                    </Routes>
                  </main>
                </div>
              </div>
             </ProtectedRoute>
          }
        />

        {/* Redirect unknown paths */}
        <Route
          path="*"
          element={
            <div className="flex items-center justify-center h-screen">
              <h1 className="text-3xl font-bold text-red-600">404 Not Found</h1>
            </div>
          }
        />
      </Routes>
    </Router>
     </div>
     <div className='lg:hidden flex justify-center items-center min-h-screen'>
      <h1 className='text-blue-800 font-bold'>Is Not Allow on your device this</h1>
     </div>
    </>
  );
}

export default App;