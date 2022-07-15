library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ram is
  port(
       DATA_IN : in std_logic_vector(7 downto 0);
       ADDRESSES : in std_logic_vector(7 downto 0);
       W_R : in std_logic;
       DATA_OUT : out std_logic_vector(7 downto 0)
       );
end entity;

architecture behavior of ram is

type MEM is array (255 downto 0) of std_logic_vector(7 downto 0);
signal MEMORY : MEM;
signal ADDRESS : integer range 0 to 255;

begin

  process(ADDRESSES, DATA_IN, W_R)
  begin

    ADDRESS <= conv_integer(ADDRESSES);
    if(W_R = '0') then
      MEMORY(ADDRESS) <= DATA_IN;
    elsif(W_R = '1') then
      DATA_OUT <= MEMORY(ADDRESS);
    else
      DATA_OUT <= "ZZZZZZZZ";
    end if;
  end process;

end behavior;
