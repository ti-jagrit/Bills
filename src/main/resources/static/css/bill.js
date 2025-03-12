$(document).ready(function() {
    // Initialize select2 for product selection
    $('#productSelect').select2({
        placeholder: 'Select a product',
        allowClear: true,
        width: '90%'
    });

    // Handle product selection change
    $('#productSelect').on('change', function() {
        const selectedOptions = $(this).val();
        $('#productRows').empty(); // Clear previous rows

        // Add rows for selected products
        selectedOptions.forEach(function(productId) {
            const productName = $('#productSelect option[value="' + productId + '"]').data('name');
            const row = `
                <tr data-product-id="${productId}">
                    <td>${productId}</td>
                    <td>${productName}</td>
                    <td><input type="number" name="quantity[${productId}]" class="form-control" value="1" min="1" /></td>
                    <td><button type="button" class="btn btn-danger btn-sm remove-row">Remove</button></td>
                </tr>
            `;
            $('#productRows').append(row);
        });
    });

    // Handle row removal
    $('#productRows').on('click', '.remove-row', function() {
        const row = $(this).closest('tr');
        row.remove();

        const productId = row.data('product-id');
        $('#productSelect option[value="' + productId + '"]').prop('selected', false);
        $('#productSelect').trigger('change');
    });

    // Submit the form
    $('form').submit(function(event) {
        // Dynamically add selected products to hidden inputs in the form
        const selectedOptions = $('#productSelect').val();
        const form = $(this);

        // Remove previous hidden inputs to avoid duplicates
        $('input[name="productId[]"]').remove();
        $('input[name="quantity[]"]').remove();

        // Append selected product IDs and quantities as hidden inputs
        selectedOptions.forEach(function(productId) {
            const quantity = $('input[name="quantity[' + productId + ']"]').val();
            form.append('<input type="hidden" name="productId[]" value="' + productId + '">');
            form.append('<input type="hidden" name="quantity[]" value="' + quantity + '">');
        });
    });
});
