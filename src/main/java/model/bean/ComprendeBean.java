package model.bean;

import java.time.LocalDateTime;
import java.time.LocalDate;

public class ComprendeBean {
    private Integer codiceOrdine;
    private LocalDateTime dataCreazione;
    private Integer codicePacchetto;
    private Double costo;
    private LocalDate dataPartenza;
    private Integer numPersone;

    public Integer getCodicePacchetto() {
        return this.codicePacchetto;
    }

    public void setCodicePacchetto(Integer codicePacchetto) {
        this.codicePacchetto = codicePacchetto;
    }

    public Integer getCodiceOrdine() {
        return this.codiceOrdine;
    }

    public void setCodiceOrdine(Integer codiceOrdine) {
        this.codiceOrdine = codiceOrdine;
    }

    public LocalDate getDataPartenza() {
        return this.dataPartenza;
    }

    public void setDataPartenza(LocalDate dataPartenza) {
        this.dataPartenza = dataPartenza;
    }

    public Integer getNumPersone() {
        return this.numPersone;
    }

    public void setNumPersone(Integer numPersone) {
        this.numPersone = numPersone;
    }

	public Double getCosto() {
		return costo;
	}

	public void setCosto(Double costo) {
		this.costo = costo;
	}

	public LocalDateTime getDataCreazione() {
		return dataCreazione;
	}

	public void setDataCreazione(LocalDateTime dataCreazione) {
		this.dataCreazione = dataCreazione;
	}


}
