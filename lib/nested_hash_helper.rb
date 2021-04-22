# frozen_string_literal: true

require 'nested_hash_helper/version'

class Hash # :nodoc:
  def deep_except(*excluded_keys)
    current_class = self.class
    each do |current_keys, current_value|
      if excluded_keys.include?(current_keys)
        delete(current_keys)
        next
      end
      current_value.deep_except(*excluded_keys) if current_value.is_a?(current_class)
    end
  end

  def deep_delete_empty
    current_class = self.class
    each do |current_keys, current_value|
      if current_value.nil? || current_value.empty?
        delete(current_keys)
        next
      end
      current_value.deep_delete_empty if current_value.is_a?(current_class)
    end
  end

  def find_depth
    max_depth = 1
    current_depth = 1
    _find_depth(max_depth, current_depth)
  end

  def _find_depth(max_depth, current_depth)
    current_class = self.class
    each do |_current_keys, current_value|
      max_depth = current_value._find_depth(max_depth, current_depth + 1) if current_value.is_a?(current_class)
    end
    max_depth = max_depth > current_depth ? max_depth : current_depth
  end

  def find_deep_intersection(compare_hash)
    current_class = self.class
    final_hash = current_class.new
    each do |current_keys, current_value|
      if compare_hash.key?(current_keys)
        if current_value.is_a?(current_class) && compare_hash.fetch(current_keys).is_a?(current_class)
          final_hash[current_keys] = current_value.find_deep_intersection(compare_hash.fetch(current_keys))
        elsif !current_value.is_a?(current_class) && !compare_hash.fetch(current_keys).is_a?(current_class) && (current_value == compare_hash.fetch(current_keys))
          final_hash[current_keys] = current_value
        end
      end
    end
    final_hash
  end

  def find_deep_keys(value)
    current_class = self.class
    deep_keys = []
    each do |current_keys, current_value|
      if !current_value.is_a?(current_class) && current_value == value
        deep_keys.push(current_keys)
      elsif current_value.is_a?(current_class)
        future_deep_keys = current_value.find_deep_keys(value)
        if future_deep_keys.size >= 1
          deep_keys.push(current_keys)
          deep_keys += future_deep_keys
          return deep_keys
        end
      end
    end
    deep_keys
  end

  def hash_to_array
    current_class = self.class
    final_array = []
    each do |current_keys, current_value|
      temp_array = []
      if current_value.is_a?(current_class)
        temp_array.push(current_keys)
        temp_array += current_value.hash_to_array
        final_array.push(temp_array)
      else
        temp_array.push(current_keys)
        temp_array.push(current_value)
        final_array.push(temp_array)
      end
    end
    final_array
  end

  def find_all_values(key)
    current_class = self.class
    values = []
    each do |current_keys, current_value|
      if current_value.is_a?(current_class)
        values += current_value.find_all_values(key)
      elsif current_keys == key
        values.push(current_value)
      end
    end
    values
  end

  def deep_delete(key)
    current_class = self.class
    each do |current_keys, current_value|
      if current_keys == key
        delete(current_keys)
      elsif current_value.is_a?(current_class)
        current_value.deep_delete(key)
      end
    end
  end
end
