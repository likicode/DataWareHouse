package edu.tongji.anna.model;

public class MovieResult {
	private String movieName;
	private String productId;
	private String version;
	public MovieResult(String movieName,String productId,String version){
		this.movieName = movieName;
		this.productId = productId;
		this.version = version;
		
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}



}
