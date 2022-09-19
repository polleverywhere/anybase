# Anybase

## Arbitrary number bases

So often, I need to create random number bases, with random digits, to satisfy
some crazy requirement.

Here is an example of how you'd do hex in Anybase.

```ruby
base = Anybase.new('0123456789abcdef')
base.to_i('f0a')
=> 3850
base.to_native(123450)
=> "1e23a"
```

As well, you can tell Anybase to ignore case.

```ruby
base = Anybase.new('0123456789abcdef', :ignore_case => true)
base.to_i('F0A')
=> 3850
```

Anybase can also have synonyms.

```ruby
base = Anybase.new('0123456789abcdef', :synonyms => {'0' => 'oO'}, :ignore_case => true)
base.to_i('FoA')
=> 3850
base.to_i('FOA')
=> 3850
```

If you just want to translate the number to look at it you can use #normalize

```ruby
base = Anybase.new('0123456789abcdef', :synonyms => {'0' => 'oO'}, :ignore_case => true)
base.normalize('FoA')
=> 'f0a'
```

If you want to use negative numbers, assign the sign character using the sign
option

```ruby
base = Anybase.new('0123456789abcdef', :sign => '-')
base.to_native(-12345)
=> '-3039'
```

Anybase can also zeropad your output with whatever your "zero" character is.

```ruby
Anybase.new("012345678").to_native(1234, :zero_pad => 8)
=> '00001621'
```

Anybase also lets you create random numbers of any number of digits

```ruby
Anybase.new("012345678").random(20)
=> '62400274212676317317'
```

Anybase gives you a few built-in: `Anybase::Hex`, `Anybase::Base64`,
`Anybase::Base64ForURL` and `Anybase::Base62` (should all be pretty
self-explanatory)

As well, there is an `AnyBase::Base73ForURL`. This includes the characters:
`ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$-_.+!*\'(),`
