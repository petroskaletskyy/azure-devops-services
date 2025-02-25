module.exports = {
    reporters: [
        "default",
        ["jest-junit", {
            outputDirectory: "./test-results",
            outputName: "jest-results.xml"
        }]
    ],
    testMatch: ["**/tests/**/*.test.js"]
}