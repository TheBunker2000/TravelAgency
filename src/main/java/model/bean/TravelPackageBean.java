package model.bean;

import java.time.*;

public class TravelPackageBean {
	
	private int codice;
	private LocalDateTime dataCreazione;
	private double costo;
	private String nome;
	private String descrizione;
	private String città;
	private String nazione;
	private int durata;
	private boolean voloIncluso;
	private String dettagliVolo;
	private String dettagliPernottamento;
	private String pensione;
	private boolean valido;
	
	public boolean isVoloIncluso() {
		return voloIncluso;
	}

	public void setVoloIncluso(boolean voloIncluso) {
		this.voloIncluso = voloIncluso;
	}

	public String getDettagliVolo() {
		return dettagliVolo;
	}

	public void setDettagliVolo(String dettagliVolo) {
		this.dettagliVolo = dettagliVolo;
	}

	public String getDettagliPernottamento() {
		return dettagliPernottamento;
	}

	public void setDettagliPernottamento(String dettagliPernottamento) {
		this.dettagliPernottamento = dettagliPernottamento;
	}

	public String getPensione() {
		return pensione;
	}

	public void setPensione(String pensione) {
		this.pensione = pensione;
	}

	public TravelPackageBean() {
		
	};
	
	public int getCodice() {
		return codice;
	}
	public void setCodice(int codice) {
		this.codice = codice;
	}
	public double getCosto() {
		return costo;
	}
	public void setCosto(double costo) {
		this.costo = costo;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getCittà() {
		return città;
	}
	public void setCittà(String città) {
		this.città = città;
	}
	public String getNazione() {
		return nazione;
	}
	public void setNazione(String nazione) {
		this.nazione = nazione;
	}
	public int getDurata() {
		return durata;
	}
	public void setDurata(int durata) {
		this.durata = durata;
	}

	public LocalDateTime getDataCreazione() {
		return dataCreazione;
	}

	public void setDataCreazione(LocalDateTime dataCreazione) {
		this.dataCreazione = dataCreazione;
	}

	public boolean isValido() {
		return valido;
	}

	public void setValido(boolean valido) {
		this.valido = valido;
	}

}
