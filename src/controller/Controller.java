package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Map<String, String> actionMap = new HashMap<String, String>();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
    	// Build a Map of action parameters to pages
		actionMap.put("image", "/image.jsp");
		actionMap.put("rate", "/image.jsp");
		actionMap.put("home", "/home.jsp");
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doForward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doForward(request, response);
	}

	private void doForward(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//PrintWriter writer = response.getWriter();
		
		//get the action parameter
		String action = request.getParameter("action");
		
		System.out.println(action);
		System.out.println(actionMap);
		
		//if action parameter is null, or the map doesn't contain a parameter
		//set the action to the home page
		if (action == null || !actionMap.containsKey(action)) {
			System.out.println("null");
			action = "home";
		}
		
		// forward to home page
		//request.getRequestDispatcher("/home.jsp").forward(request, response);
		// forward to requested page
		System.out.println(actionMap.get(action));
		request.getRequestDispatcher(actionMap.get(action)).forward(request, response);
		
	}

}




//
//OLD CLASS
//
//package controller;
//
//import java.io.IOException;
//import java.util.HashMap;
//import java.util.Map;
//
//import javax.naming.Context;
//import javax.naming.InitialContext;
//import javax.naming.NamingException;
//import javax.servlet.Servlet;
//import javax.servlet.ServletConfig;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.sql.DataSource;
//
///**
// * Servlet implementation class Controller
// */
//@WebServlet("/Controller")
//public class Controller extends HttpServlet {
//	private static final long serialVersionUID = 1L;	
//    
//	private DataSource ds;
//       
//    /**
//     * @see HttpServlet#HttpServlet()
//     */
//    public Controller() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//	/**
//	 * @see Servlet#init(ServletConfig)
//	 */
//	public void init(ServletConfig config) throws ServletException {
//		try{
//			
//			InitialContext initContext = new InitialContext();
//			
//			Context env = (Context)initContext.lookup("java:comp/env");
//			
//			
//			ds = (DataSource)env.lookup("jdbc/webshop"); 
//			
//			
//			}
//			catch (NamingException e) {
//				throw new ServletException();
//			}
//	}
//
//	/**
//	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
//	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		//request.getRequestDispatcher("/home.jsp").forward(request,	response);
//		
//		//Get the action parameter
//		String action = request.getParameter("action");
//
//		
//		//Build a Map of action parameter to page
//		Map<String, String> actionMap = new HashMap<String, String>();
//		actionMap.put("image", "/image.jsp");
//		actionMap.put("home", "/home.jsp");
//		
//		//Prints to console
//		System.out.println(action);
//		System.out.println(actionMap);
//		
//		//if the action parameter is null or the map does not contain
//		//a page for this action, set the action to the home page
//		if (action == null || !actionMap.containsKey(action)) action="home";
//		
//		//Forward to the requested page
//		request.getRequestDispatcher(actionMap.get(action)).forward(request, response);
//		
//		
//	}
//
//	/**
//	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
//	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//	}
//
//}
