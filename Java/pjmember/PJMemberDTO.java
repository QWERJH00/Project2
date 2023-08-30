package pjmember;

public class PJMemberDTO {
	private String id;
	private String pass;
	private String name;
	private String phone;
	private String email;
	private String gender;
 
	public String getId () {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	@Override
	public String toString() {
		return "PJMemberDTO [id=" + id + ", pass=" + pass + ", name=" + name + ", phone=" + phone + ", email=" + email
				+ ", gender=" + gender + "]";
	}
	
}
