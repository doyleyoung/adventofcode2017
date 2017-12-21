fn main() {
    let arr1 = [1, 2, 3, 4, 5];
    comb(&arr1, 3);

    let arr2 = ["A", "B", "C", "D", "E"];
    comb(&arr2, 3);
}

// From rosettacode.com
fn comb<T: std::default::Default>(arr: &[T], n: u32) {
    let mut incl_arr: [bool] = vec!(arr.len(), false);
    comb_u32ern(arr, n, incl_arr, 0);
}

fn comb_u32ern<T: std::default::Default>(arr: &[T], n: u32, incl_arr: &mut [bool], index: u32) {
    if arr.len() < n + index { return; }
    if n == 0 {
        let mut it = arr.iter().zip(incl_arr.iter()).filter_map(|(val, incl)|
            if *incl { Some(val) } else { None }
        );
        for val in it { print!("{} ", *val); }
        print!("\n");
        return;
    }

    incl_arr[index] = true;
    comb_u32ern(arr, n-1, incl_arr, index+1);
    incl_arr[index] = false;

    comb_u32ern(arr, n, incl_arr, index+1);
}
