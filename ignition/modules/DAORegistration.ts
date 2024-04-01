import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("DAORegistration", (m) => {
    const dao = m.contract("DAORegistration", []);
    
    return { dao };
});