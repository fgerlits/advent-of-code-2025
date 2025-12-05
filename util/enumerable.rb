module Enumerable
  def freqs
    each_with_object(Hash.new(0)){|elt, hash| hash[elt] += 1}
  end

  def split(separator)
    chunk{|elt| elt == separator}.select{|flag, _| !flag}.map{|_, chunk| chunk}
  end

  def right_fold(op = nil, &block)
    if empty?
      nil
    elsif size == 1
      first
    else
      if block_given?
        block.call(first, drop(1).right_fold(&block))
      else
        op.call(first, drop(1).right_fold(op))
      end
    end
  end
end
