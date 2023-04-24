#===============================================================================
# Change egg picture - by FL (Credits will be apreciated)
#===============================================================================
#
# This script is for Poccil Pokémon Essentials, to install put it above main,
# put one picture for each egg in YourGameFolder\Graphics\Pictures. Put the
# pictures for each Egg Group (15) like egg1, egg2, egg3... and  iconEgg1,
# iconEgg2, iconEgg3... for icons. 
# Change a line in PokemonUtilities. The line 
# return AnimatedBitmap.new(sprintf("Graphics/Pictures/egg"))
# change it for 
# return AnimatedBitmap.new(sprintf(EggType.EggPicture(pokemon.species,false)))
# If you want change the icons too, change other line in the same script. 
# The line 
# return sprintf("Graphics/Pictures/iconEgg")
# change it for
# return sprintf(EggType.EggPicture(pokemon.species,true))
#
#===============================================================================
#
# This script changes the egg picture for each pokémon that they contains.
# I put one for each Egg Group, but in a way to Igglybuff (a pokémon that
# cannot breed and have Egg Group 15) to have they evolution (Jigglypuff) Egg
# Group (6).
# You can add special egg pictures like Togepi if you follow the instructions
# in specialcases. Name the special cases eggs+specialcasepokémon number, like
# eggs175 for Togepi. I recommend to use this.
# You can uncomment a line to change it to put one egg for EACH pokémon species
# instead one for each Egg Group. Use a picture for each pokémon species that
# can be in a egg, use the specie number in a picture, like egg100 for Voltorb,
# but the egg101 isn't necessary because that Electrode cannot be in a egg.
#
#===============================================================================

module EggType
  
  def self.EggPicture(specie,isIcon)
    compat=EggType.getCompat(specie) # picks the Compatibility
    if(compat==15) # if the Compatibility is 15, checks for evo (for babies)
      ret=pbGetEvolvedFormData(specie)
      compat=EggType.getCompat(ret[0][2]) if (ret[0]!=nil)
    end
    resultnumber=compat.to_s
#   resultnumber=EggType.specialcases(specie,compat)
#   UNCOMMENT THE ABOVE LINE TO USE SPECIAL CASES
#   resultnumber=specie.to_s
#   UNCOMMENT THE ABOVE LINE TO PUT ONE EGG PICTURE FOR EACH POKÉMON SPECIES
    if isIcon
      eggstring="Graphics/Pictures/iconEgg"+resultnumber
    else
      eggstring="Graphics/Pictures/egg"+resultnumber
    end  
    # use the egg picture, plus a number, like egg3 for Caterpie
    return eggstring
  end
  
  def self.specialcases(specie,compat)
    case specie
    when 175 # Togepi Number
      return ("s"+specie.to_s) # Use eggs175 to Togepi Egg Picture
    #when ? 
    #  return ("s"+specie.to_s)
    # Copy the two above lines, uncomment and change the "?" for a special
    # case pokémon number. Do this for each special case pokémon 
    else
      return (compat.to_s)
    end
  end
  
  def self.getCompat(specie) # Returns the first Compatibility.
    dexdata=pbOpenDexData
    pbDexDataOffset(dexdata,specie,31)
    compat1=dexdata.fgetb
    compat2=dexdata.fgetb
    dexdata.close
    return compat1
  end
end