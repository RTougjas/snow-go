<?php $this->lang->load('tekst_lang', 'estonian')?>
<?php echo form_open("User/login");?>
<div class="container">
	<div class="row">
		<div class="col lg-6 col-md-6 col-sm-6 col-xs-12">
			<h1>
				<?php if ( strlen($title) > 0) { ?>
					<span class="label label-info"><?php echo $title; ?></span>
				<?php } ?>
			</h1>
			<br>
			<table class="table">
				<tr>
					<th>No.</th>
					<th>Korrektne kood</th>
					<th>Sisestatud koodid</th>
					<th>Kulunud aeg</th>
				</tr>
				
				<?php for( $i = 0; $i < sizeOf($observations); $i++) { ?>
					<tr>
						<td><?php echo sizeOf($observations) - $i; ?></td>
						<td><?php echo $observations[$i]->correctCode; ?></td>
						<td>
							<table>
									<?php for ( $j = 0; $j < sizeOf($wrong_codes); $j++ ) { ?>
										<?php if( $wrong_codes[$j]->observation == $observations[$i]->ID ) {?>
											<tr>
												<td><?php echo $wrong_codes[$j]->wrongCode; ?></td>
											</tr>
										<?php } ?>
									<?php } ?>
							</table>
						</td>
						<td><?php echo $observations[$i]->time; ?></td>
				
				<?php } ?>
				
			</table>
			
		</div>
		<div class="col lg-3 col-md-3 col-sm-3 col-xs-12"></div>
	</div>
</div>