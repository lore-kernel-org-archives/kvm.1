Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5B840489A
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763189; cv=fail; b=qZT2frpl/4HCNkjQXV1atEGN9H/rf3QrD5MTxVyxnsKM9H+px2Sb38UUAwYsUv9SKLBNs759KbMSNi10t3Wnnx06XGB4tUJ700SnpbkDL6JgGnniHFRJ6/NvMvEO7WTjlzSYtKQgp1mQn9Bha3LhvusFOpNJIVUggUByNWybirs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763189; c=relaxed/simple;
	bh=IBKV4IQIH8fhze9e4sDpEh7Kll0MasGPqQSg5kKAu/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtr4T5k8EmBOI+9LWNz6DQrnfdcbZNkuSPjRj1JXMQ+qB8G1TYNeXElz4IO7jiNzTJs+il8M+/BdcoK3/tXHuJZEN6EEErUZdLlsVRb/Q0uQMcjwT23viD6UUrPF0IGS9lF6nGqA6XNuk+9whDwp7rj5e4vUxnvpcdAeFa284Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EgwEhS1d; arc=fail smtp.client-ip=40.107.209.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EgwEhS1d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2rlp99lXd3Q59wXmfUi2OWKtK9IHuwcjdraICgL5z6mS2XbcJvp7+vwN5BtArBm3nNd9/tJR6FOPGIXh9njzRQUEHBKjarEW+6z5tYNrQaDdFBEnrVO13MBmn/tL6ERqH9Yp/BVmQAUl36NsXNWCMPJVC1VGZf90aEgku6sk9Uq6tLSxcQsDCgO26zr0Tp/E0zbjOWAGXgGJvLzBuPS1UXWxaZn8WJ/j5hjsXcawT2+yaOyA9q6R3OqC7Rz7vyLu9r/KLqYR4LIqUOCsJseDLza6vOn2M2HZYqbp717K4piuQvmL1hXx0vMfS6apu9bnXiJ/PEW2miVGYBRP2O4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8V3ez/ci/MHSP8CoDHbe+vbbHratGFUIRdgvzVzvZiU=;
 b=efJfbOrRAKH2LffYlN6vVDPhloFG6V39VR4+a5Q+Fk2QxBRMZLUWKQTQfbYJwRzVWb5WKK5DM439or58o2LhWTyOGBXqU8w4QGnAnN91Gk72Jl0aNlAjYaSBtuzMGTnbwrQXJptFZ2djRVrfTtGfTFAvmFuABYyTCF7TcOmeAwoMjGqWM4D5wejzv9oSIJd3owgBYYoJH2R8FRWhS+GMi50g1mGL4eXTqRPVP2035xtlZJaZ+BsLgPaLsglYEfBF5WwnxbErMWtLmkm0ikDlww6XYcNacOolgTTsepZD1bI3KtvtmM2QMXxgWuGlldkxsVEMR+5sFJU6BjCfzhm8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V3ez/ci/MHSP8CoDHbe+vbbHratGFUIRdgvzVzvZiU=;
 b=EgwEhS1deWOxlwq5lteIvQDWvpqV/NZkdlW9rPEm0O9y960ekuu5tOouqKLFDYHljv4uTNqPqaxo9PZV8skuaJyLwxhvOTHyJ1BdIhXq00cSyL8QQliAy2YepWfOpblU1gF5UEST8y7wRp+u7cVZ5LwLk8ZvHkSCIXdVEKmYwDQ=
Received: from SJ0PR13CA0117.namprd13.prod.outlook.com (2603:10b6:a03:2c5::32)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:39:44 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::73) by SJ0PR13CA0117.outlook.office365.com
 (2603:10b6:a03:2c5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Mon, 7
 Sep 2026 06:39:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 06:39:44 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 01:39:40 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v8 6/8] x86/cpufeatures: Add Page modification logging
Date: Mon, 7 Sep 2026 06:39:04 +0000
Message-ID: <20260907063906.1964557-7-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907063906.1964557-1-nikunj@amd.com>
References: <20260907063906.1964557-1-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 1024605e-796b-44a3-6a21-08df0caacd87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xI2Usl4q7si4dWBsDaSfF8PXhz23hf4lb6J49516aeXxqAJf/dpfUnG9+SRZxF28OaS3CGIo5prg4//sj76QSCEmLgvVUjt704YAc5FCqlu0PoVIv+Bpt4fTU1NhYeZ4xny6mbTowJPF5mZ2wSGEpXCUrhAW7BGUzvieS6RVUlYdtZSChggry7pxsf9/SrcD0jff7EQfIT99DbxHDsLTc7A/9hJXYx4teYp1/r5M+W1zYRc7XLWPWLjahjQxWjAnv8a3I1yJPHk/pc6AndJlljn5hUJuLTR7WrK2dn11thU9CzWhvlr1kGBrqR0QBXUs7MaYY+ejviCF9ZdCmTKa42WPl0G73luOupBnE3QdequuhF9q0aoYg99v6P7oqaln/4BrkO4H8bekBZWrBkCvF9UPVbaTrGdnQWcrCecEdgDfFX4R3ATN5vFzhS9/y1Wa1fUDTvJFToBEUKmD4XGyS4EX1DL3H2WoxjhTQr41yD5lfftHBPZgaRZQ0Xs1NX1aMn6n92MyToxTQ/pyOu2ivOrlEg8F0JbK7eR7Dz423nqePo83fPQsNm/OuXNDyBXJHw24898WtL0rwP1naIINAgR/eVHfxEBhWwq9tt2Mzc2OW62GWz/G6nubXO42V04V+tjV3Vcl3HtAjg2iAHswQ2hmT/THlm+I4ndifam6rMMoyVToPC+R3Ut1D8fXtwR+49/TcxFoP3uVNb0Frd1Vww==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FrVFrXfEsBD55JDhDrb45qemLV+6YINMUSVrBJEn8Rk21ZPLYIte3LVHTSotJRW7Q1WRHVcSr9Flb9dnt2+n1xDv6YrSyJUIIt7mMCbdt7BiY/BZB0cOaVmLaw1xtEjzJCQWwYVVmtvDMdkpPzTnDd+34RL4v/xYPTyEeCfrm9qo3oW6cpcCklFK/YtTFpJf9Ax+qt2b+yXv3bxVBbK2T4i99m4c0n3x5Qzpv6UpUbkKj5WbxluF9qkZ7HuSuBWt2lEUEALRHh5Xo1JOOGKTN/8e3rl3jEplXDYBZOIIi8CRLhd80CcZOByx4W5lTd3vgMpIoDnCMueeq7wKoq3DW6HWPuH7JeXudM7DU1NXYaDv02GCYFSxIBifLYy1d8GWhqDrqSk1jpVfCsWQwrYs61Hl/bR0j4yOHbfHdPJWfVkNP7xQfka0FHZ7nK23T4BP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:39:44.0805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1024605e-796b-44a3-6a21-08df0caacd87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091

Page modification logging(PML) is a hardware feature designed to track
guest modified memory pages. PML enables the hypervisor to identify which
pages in a guest's memory have been changed since the last checkpoint or
during live migration.

The PML feature is advertised via CPUID leaf 0x8000000A ECX[4] bit.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f70ee74b5f92..cbfcc66a18e9 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -238,6 +238,7 @@
 // free: was #define X86_FEATURE_PVUNLOCK               ( 8*32+20) /* PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
 #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
+#define X86_FEATURE_PML			( 8*32+23) /* AMD Page Modification logging */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* "fsgsbase" RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 8665a6474806..b18cc9c88dd5 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -55,6 +55,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_AMD_FAST_CPPC,		CPUID_EDX, 15, 0x80000007, 0 },
 	{ X86_FEATURE_CPPC_PERF_PRIO,		CPUID_EDX, 16, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,			CPUID_EBX,  6, 0x80000008, 0 },
+	{ X86_FEATURE_PML,			CPUID_ECX,  4, 0x8000000a, 0 },
 	{ X86_FEATURE_X2AVIC_EXT,		CPUID_ECX,  6, 0x8000000a, 0 },
 	{ X86_FEATURE_COHERENCY_SFW_NO,		CPUID_EBX, 31, 0x8000001f, 0 },
 	{ X86_FEATURE_SMBA,			CPUID_EBX,  2, 0x80000020, 0 },
-- 
2.48.1

