#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;
use feature 'say';
use lib 'lib';
use Person::Employee;

my $employee = new Person::Employee();

## Use Cases

### SAVE EMPLOYEE RECORD
sub add_employee {
    my %employee_hash = (
        first_name => 'John', 
        last_name => 'Doe', 
        email => 'johndoe@gmail.com', 
        date_of_birth => '1994-02-03', 
        gender => 'Male', 
        race => 'Mixed'
    );
    my $payload_ref = \%employee_hash;
    my $add = $employee->add_employee($payload_ref);
    print("$add\n");
}

# &add_employee();

### DISPLAY ALL EMPLOYEES 
sub find_employees {
    my $results_ref = $employee->find_employees();
    my @results = @{ $results_ref };
    foreach my $r (@results) {
        print($r);
    }
}

# &find_employees();

### PROMOTE AN EMPLOYEE

### Update Employee Record
sub update_employee {
    #
}
### Search for an employee

### Delete an employee
