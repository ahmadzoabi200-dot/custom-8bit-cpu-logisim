--------------------------------------------------------------------------------
-- Project :
-- File    :
-- Autor   :
-- Date    :
--
--------------------------------------------------------------------------------
-- Description :
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity T_FSM is
  port (
    clk, rst  : in  std_logic;
    needs2    : in  std_logic;
    t_out     : out std_logic_vector(1 downto 0);
    fetch     : out std_logic;
    ph2       : out std_logic;
    ph3       : out std_logic
  );
end entity;

architecture rtl of T_FSM is
  signal t_reg     : std_logic_vector(1 downto 0) := "00";
  signal n_latched : std_logic := '0';
begin
  process(clk, rst)
  begin
    if rst='1' then
      t_reg <= "00";
      n_latched <= '0';
    elsif rising_edge(clk) then
      case t_reg is
        when "00" => n_latched <= needs2; t_reg <= "01";
        when "01" => if n_latched='1' then t_reg <= "10"; else t_reg <= "00"; end if;
        when "10" => t_reg <= "00";
        when others => t_reg <= "00";
      end case;
    end if;
  end process;

  t_out <= t_reg;

  -- decoded phase outputs
  fetch <= (not t_reg(1)) and (not t_reg(0));
  ph2   <= (not t_reg(1)) and t_reg(0);
  ph3   <= t_reg(1) and (not t_reg(0));
end architecture;

