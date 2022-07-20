package model.bean;

import java.time.LocalDate;

public class OrdineBean {

	private int codice;
	private String cliente;
	private LocalDate dataPrenotazione;
	private Double costoTotale;
	
	public OrdineBean() {

	}
	public int getCodice() {
		return codice;
	}
	public void setCodice(int codice) {
		this.codice = codice;
	}
	public String getCliente() {
		return cliente;
	}
	public void setCliente(String cliente) {
		this.cliente = cliente;
	}
	public LocalDate getDataPrenotazione() {
		return dataPrenotazione;
	}
	public void setDataPrenotazione(LocalDate dataPrenotazione) {
		this.dataPrenotazione = dataPrenotazione;
	}
	public Double getCostoTotale() {
		return costoTotale;
	}
	public void setCostoTotale(Double costoTotale) {
		this.costoTotale = costoTotale;
	}
	
}
