#!/usr/bin/perl
use DBI;
use strict;
use warnings;
package Database::Database;

sub new {
    my $class = shift;
    my $self = {
        _dsn => shift,
        _user => shift,
        _password => shift,
    };
    bless $self, $class;
    return $self;
}

sub connect {
    my ($self) = @_;
    my $dbn = DBI->connect($self->{_dsn}, $self->{_user}, $self->{_password} ) or die $DBI::errstr;
    return $dbn;
}

sub add_employee {
    my ($self, $employee_ref) = @_;
    my $conn = $self->connect();
    my $sth = $conn->prepare("INSERT INTO employees (first_name, last_name, email, date_of_birth, gender, race ) values (?,?,?,?,?,?)");
   
    my %employee = %{ $employee_ref };
    my $last_name = $employee{'last_name'};
    my $first_name = $employee{'first_name'};
    my $email = $employee{'email'};
    my $date_of_birth = $employee{'date_of_birth'};
    my $gender =  $employee{'gender'};
    my $race = $employee{'race'};
   
    $sth->execute($first_name, $last_name, $email, $date_of_birth, $gender, $race) or die $DBI::errstr;
   
    $sth->finish();
      
    return "employee has been added!";
}

sub find_employees {
    my ($self) = @_;
    my $conn = $self->connect();
    my $statement = $conn->prepare("SELECT * FROM employees");
    $statement->execute() or die $DBI::errstr;
    print "Number of rows found :". $statement->rows ."\n";
    my @results = {};
    while (my @row = $statement-> fetchrow_array()) {
        my ($id, $first_name, $last_name, $age, $gender, $date_of_birth, $email) = @row;
        my %val = (
            id => $id, 
            first_name => $first_name, 
            last_name => $last_name, 
            age => $age, 
            gender => $gender, 
            date_of_birth => $date_of_birth, 
            email => $email
        );
        push(@results, \%val);
    }
    $statement->finish();
    return \@results;
}


1;