const API = "http://localhost:8080/api/employees";

export const getEmployees = async (page=0) => {
  const res = await fetch(`${API}?page=${page}&size=10`);
  return res.json();
};

export const addEmployee = async (formData) => {
  const res = await fetch(API, {
    method: "POST",
    body: formData
  });
  return res.json();
};

export const deleteEmployee = async (id) => {
  return fetch(`${API}/${id}`, {
    method: "DELETE"
  });
};