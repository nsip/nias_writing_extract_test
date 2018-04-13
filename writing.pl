open F, "<writing_tests.csv";
while(<F>) {
  chomp;
  next unless /\S/;
  $writingtest{$_}++
}
close F;
@out = ();
%out1 = ();
open F, "<no_rsp_events.csv";
while(<F>) {
  chomp;
  next unless /\S/;
  ($id, $participation, $psi) = split /,/, $_;
  next unless $writingtest{$id};
  push @out, "$psi,$participation,\n";
}
close F;
open F, "<rsp_events.csv";
while(<F>){
  chomp;
  ($id, $participation, $psi) = split /,/, $_;
  next unless $writingtest{$id};
  next unless /\S/;
  $out1{$psi} = ();
  $out1{$psi}{"participation"} = $participation;
}
close F;
open F, "<responses.csv";
while(<F>) {
  chomp;
  next unless /\S/;
  ($id, $psi, $response) = /^([^,]+),([^,]+),(.*)$/;
  next unless $writingtest{$id};
  $response =~ s/,/\\,/g;
  $response = '"' . $response . '"' if $response =~ /\S/ and $response !~ /^"/;
  # to match output from perl csv manipulation
  $out1{$psi}{"response"} = $response;
}
foreach $psi (keys %out1) {
  push @out, sprintf("%s,%s,%s\n", $psi, $out1{$psi}{"participation"}, $out1{$psi}{"response"});
}
@out = sort @out;
foreach $x (@out) {
  print $x;
}

