#!/usr/bin/perl
package Person::Employee;

use lib 'lib';
use DBI;
use strict;
use warnings;
use Database::Database;


my $database = new Database::Database($dsn, $user, $password);

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}

sub add_employee {
    my ($self, $payload_ref) = @_;
    my %payload =  %{ $payload_ref } ;
    my %employee = (
        first_name => $payload{'first_name'},
        last_name => $payload{'last_name'},
        email => $payload{'email'},
        date_of_birth => $payload{'date_of_birth'},
        gender => $payload{'gender'},
        race => $payload{'race'},
    );
    my $employee_ref = \%employee;
    return $database->add_employee($employee_ref);
}

sub find_employees {
    my ($self) = @_;
    my $results = $database->find_employees();
    my @employees = @{ $results };
    my @results = ();
    foreach my $employee (@employees) {
        my %hash_ref = %{ $employee };
        my $row_str = $self->pritty_str(\%hash_ref);
        push(@results, $row_str);
    }
    return \@results;
}

sub pritty_str {
    my ($self, $payload) = @_;
    my %hash_ref = %{ $payload };
    my $lower = "|--------------------------------------------------------------------------------------------------------------------------------------|\n";
    if (!$hash_ref{'id'}) {
        return "";
    }
    my $results = "| ID => ".$hash_ref{'id'}. " First_Name => ".$hash_ref{'first_name'}." Last_Name => ".$hash_ref{'last_name'}." Email => ". $hash_ref{email} ." Gender => ". $hash_ref{'gender'} ." DATE_OF_BIRTH => ". $hash_ref{'date_of_birth'} ." |\n";
    return $results . $lower;
}

1;