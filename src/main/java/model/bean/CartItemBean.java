package model.bean;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class CartItemBean {
    private Integer codicePacchetto;
    private LocalDateTime dataCreazionePacchetto;
    private String nomePacchetto;
    private String cittàPacchetto;
    private LocalDate dataPartenza;
    private Integer numPersone;
    private Double totale; 
    
    public Integer getCodicePacchetto() {
        return this.codicePacchetto;
    }

    public void setCodicePacchetto(Integer codicePacchetto) {
        this.codicePacchetto = codicePacchetto;
    }


    public Integer getNumPersone() {
        return this.numPersone;
    }

    public void setNumPersone(Integer numPersone) {
        this.numPersone = numPersone;
    }

    public Double getTotale() {
        return this.totale;
    }

    public void setTotale(Double totale) {
        this.totale = totale;
    }

	public String getCittàPacchetto() {
		return cittàPacchetto;
	}

	public void setCittàPacchetto(String cittàPacchetto) {
		this.cittàPacchetto = cittàPacchetto;
	}

	public String getNomePacchetto() {
		return nomePacchetto;
	}

	public void setNomePacchetto(String nomePacchetto) {
		this.nomePacchetto = nomePacchetto;
	}

	public LocalDate getDataPartenza() {
		return dataPartenza;
	}

	public void setDataPartenza(LocalDate dataPartenza) {
		this.dataPartenza = dataPartenza;
	}
	
	public boolean isSamePackage(CartItemBean otherItem) {
		if(this.codicePacchetto == otherItem.codicePacchetto) {
			return true;
		}else {
			return false;
		}
	}

	public LocalDateTime getDataCreazionePacchetto() {
		return dataCreazionePacchetto;
	}

	public void setDataCreazionePacchetto(LocalDateTime dataCreazionePacchetto) {
		this.dataCreazionePacchetto = dataCreazionePacchetto;
	}

}
