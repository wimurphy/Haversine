require 'spec_helper'
require_relative '../haversine'

describe 'haversine' do
  it 'verifies all coordinates are valid' do
    expect(Haversine.valid_coords(90, 180)).to be true
    expect(Haversine.valid_coords(9, 18)).to be true
    expect(Haversine.valid_coords(-90, 180)).to be true
    expect(Haversine.valid_coords(9, -18)).to be true
    expect(Haversine.valid_coords(900, -18)).to be false
    expect(Haversine.valid_coords(9, 800)).to be false
    expect(Haversine.valid_coords(0, 0)).to be true
  end

  it 'ignores invalid coordinates' do
    expect(Haversine.within_radial_distance(900, 180, 90, 180, 100)).to be false
    expect(Haversine.within_radial_distance(9, 180, 9, 180, 100)).to be true
  end

  it 'handles negative distances' do
    expect(Haversine.within_radial_distance(9, 180, 9, 180, -100)).to be true
    expect(Haversine.within_radial_distance(9, 180, 9, 180, 100)).to be true
  end

  it 'handles non-integer distances' do
    expect(Haversine.within_radial_distance(9, 180, 9, 180, 99.9)).to be true
  end

end