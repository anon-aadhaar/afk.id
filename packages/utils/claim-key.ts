// @ts-ignore
import { keccak256 } from "@ethersproject/keccak256";

export function getClaimKeyFromName(name: string) {
  return BigInt(keccak256(Buffer.from(name))).toString().slice(0, 8);
}

