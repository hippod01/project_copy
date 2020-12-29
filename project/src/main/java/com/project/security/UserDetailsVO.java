package com.project.security;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class UserDetailsVO implements UserDetails {

	private static final long serialVersionUID = 1L;
	
	private String username; //id
	private String password; //password
	private String authority; // 권한 (,)
	private List<GrantedAuthority> authorities;
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	public void setAuthorities(String authority) {
		
		String[] auth = authority.split(","); 
		List<String> authlist = new ArrayList<>();
		authlist = Arrays.asList(auth);
		
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		
		for(int i=0; i<authlist.size(); i++) {
			authorities.add(new SimpleGrantedAuthority(authlist.get(i)));
		}
		
		this.authorities = authorities;
	}
	
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		
		return authorities;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return password;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return username;
	}

	//계정이 만료되었는지
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	//계정이 잠기지 않았는지 
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	
	//패스워드가 만료되지 않았는지
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	//계정이 활성화 되었는지
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public String toString() {
		return "UserDetailsVO [username=" + username + ", password=" + password + ", authority=" + authority
				+ ", authorities=" + authorities + "]";
	}
	
	

}
