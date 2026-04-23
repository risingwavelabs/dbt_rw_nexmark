export async function http_get_todo_name_js(id) {
    const response = await fetch('http://127.0.0.1:18080/todo/' + id);
    const data = await response.json();
    return data.name;
}
