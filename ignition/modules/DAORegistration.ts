import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("DAORModule", (m) => {
    const daoContract = m.contract("DAORegistration", []);
    
    return { daoContract };
});