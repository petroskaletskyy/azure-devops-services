const { add, subtract, greet } = require("../src/app");

describe("Math Function", () => {
    it("should add two numbers correctly [Test Case 1001]", () => {
        expect(add(2, 3)).toBe(5);
    });

    it("should subtract two numbers correctly [Test Case 1002]", () => {
        expect(subtract(5, 2)).toBe(3);
    });
});

describe("Greet Function", () => {
    it("should greet a person by name [Test Case 1003]", () => {
        expect(greet("Alice")).toBe("Hello, Alice");
    });

    it("should greet a person by name [Test Case 1004]", () => {
        expect(() => greet()).toThrow("Name is required");
    });

    it("should greet a person by name [Test Case 1005]", () => {
        expect(greet("Bob")).toBe("Hi, Bob");
    });
});