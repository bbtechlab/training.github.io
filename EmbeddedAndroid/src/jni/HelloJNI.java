public class HelloJNI {  // Save as HelloJNI.java
	static {
	   System.loadLibrary("HelloJNI"); 	// Load native library HelloJNI.dll (Windows) or libHelloJNI.so (Unixes)
										// at runtime. This library contains a native method called sayHello()
	}
	
	// Instance variables
	private int number = 8888;
	private String message = "Hello from Java";
	// Static variables
	private static double dNumber = 88.88;
	
	// Declare an instance native method sayHello() which receives no parameter and returns void
	private native void sayHello();
	// Passing Primitives
	private native double average(int n1, int n2);
	// Passing Strings
	private native String stringJNI(String msg);
	// Passing array of primitives
	private native double[] sumAndAverage(int[] numbers);
	// Declare a native method that modifies the instance variables
	private native void modifyInstanceVariable();
	// Declare a native method that modifies the static variable
	private native void modifyStaticVariable();

	// Test Driver
	public static void main(String[] args) {
	  // Create an instance and invoke the native method
	   HelloJNI thisObj = new HelloJNI();
	  
	  // Test Hello World
	  thisObj.sayHello();
	  
	  // Test Average
	  System.out.println("In JAVA, the average is: " + thisObj.average(4, 5)); 
	  
	  // Test Passing Strings
	  System.out.println("In JAVA, the returned string is: " + thisObj.stringJNI("How to pass Strings"));
	  
	  // Test Passing array of primitives
	  int[] numbers = {4, 7, 9};
	  double[] results = thisObj.sumAndAverage(numbers);
	  System.out.println("In JAVA, the sum is " + results[0]);
	  System.out.println("In JAVA, the average is " + results[1]);
	  
	  // Test modifying the instance variables
	  thisObj.modifyInstanceVariable();
	  System.out.println("In Java, int is " + thisObj.number);
	  System.out.println("In Java, String is " + thisObj.message);
	  
	  // Test modifying the static variables
	  thisObj.modifyStaticVariable();
	  System.out.println("In Java, the static double is " + dNumber);
	}
}
