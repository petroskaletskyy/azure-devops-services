function add(a, b) {
    return a + b;
}

function subtract(a, b) {
    return a - b;
}

function greet(name) {
    if (!name) throw new Error('Name is required');
    return `Hello, ${name}`;
}
module.exports = { add, subtract, greet };