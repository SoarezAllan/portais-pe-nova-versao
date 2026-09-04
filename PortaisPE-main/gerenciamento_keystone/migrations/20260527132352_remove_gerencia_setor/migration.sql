/*
  Warnings:

  - You are about to drop the column `gerencia` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `setor` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Gerencia` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Setor` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Setor" DROP CONSTRAINT "Setor_gerencia_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_gerencia_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_setor_fkey";

-- DropIndex
DROP INDEX "User_gerencia_idx";

-- DropIndex
DROP INDEX "User_setor_idx";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "gerencia",
DROP COLUMN "setor";

-- DropTable
DROP TABLE "Gerencia";

-- DropTable
DROP TABLE "Setor";
