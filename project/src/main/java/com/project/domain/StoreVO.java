package com.project.domain;

public class StoreVO {
	
	int store_no;
	String store_name;
	String store_add;
	String store_cont;
	
	public int getStore_no() {
		return store_no;
	}
	public void setStore_no(int store_no) {
		this.store_no = store_no;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	public String getStore_add() {
		return store_add;
	}
	public void setStore_add(String store_add) {
		this.store_add = store_add;
	}
	public String getStore_cont() {
		return store_cont;
	}
	public void setStore_cont(String store_cont) {
		this.store_cont = store_cont;
	}
	
	@Override
	public String toString() {
		return "StoreVO [store_no=" + store_no + ", store_name=" + store_name + ", store_add=" + store_add
				+ ", store_cont=" + store_cont + "]";
	}
	
	
	

}
