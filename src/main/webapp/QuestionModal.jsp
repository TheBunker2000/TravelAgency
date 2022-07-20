<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- QUESTION MODAL DA TESTARE -->
<div id="questionModal" class="modal fade">
	<div class="modal-dialog modal-question">
		<div class="modal-content">
			<div class="modal-header flex-column">
				<div class="icon-box">
					<i class="material-icons">&#xE5CD;</i>
				</div>						
				<h4 class="modal-title w-100">Sei sicuro?</h4>	
			</div>
			<div class="modal-body">
				<p id="question-modal-text">>...</p>
			</div>
			<div class="modal-footer justify-content-center">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				<button type="button" class="btn btn-danger" id="question-modal-submit">Delete</button>
			</div>
		</div>
	</div>
</div>   