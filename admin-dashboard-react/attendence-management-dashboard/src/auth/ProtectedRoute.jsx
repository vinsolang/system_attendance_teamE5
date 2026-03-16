import { Navigate } from "react-router-dom";

function ProtectedRoute({ children }) {

  const token = localStorage.getItem("token");
  const role = localStorage.getItem("userRole");

  if (!token) {
    return <Navigate to="/signin" replace />;
  }

  if (role !== "Admin" && role !== "ADMIN") {
    return <Navigate to="/signin" replace />;
  }

  return children;
}

export default ProtectedRoute;