Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328694A5C45
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860867; cv=fail; b=smSy/ITN6CxM6aOY8vbvb5vHIWxrU8QCukCNqaNLgVTpcw5seSHpgmLP6v7MYRxwnUR+de/iy0RMWaGX3K8izImK4QQmQOGTPXU8H9ndWZMWJxiax/m4cKs/cMO7urQbsRaT+DY3Amtx3fL2fIEWL5SCJ5HMRhsWAnHpKaBj8nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860867; c=relaxed/simple;
	bh=n61VUiH7PNHAdy2QigAhnM30Mvnx7PPi/NIrf/CpZrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXoeTBqBbt+mVIWG1jUXyNiOLp399SlXprQO9CnYZ1g3KEDKEUv2G81e2TGeMb71EufDaf+hUQsvCpXaPVIhWGQXnJa6bvFWGt/G23qXS2NVOOq/JbHGmq1cOobcHiHuG81ARZqu8BTWsMGIxPGHtEdVJuF6kuz7+y6pTC7h4CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fukT8hdF; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fukT8hdF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4Tz8k3DXxNurVOt18bEnzUj+jgirW9Lbhjmj4hQUGZBaKCrxxlGaj4ofGO0FrtHCcvpc1C8YP6X8BEVsE/7o/S9DbSkSavlyPQujHFyElIf2jU0phCMqyD4mspV7y+PF3spBzO9F3hBRr3B2HWxvdlvhYzSku7+4BCU7o/RiL2yOIJnfwzRKoVuagSFCSm+AOXlt09kuoHiiuFIsZH4lqpdiMujsiCSFVwbyyZW3234lHCWEKTLU1aTHA19SEQIlSFPekl009kDqYN4M6nFcqxzhKv+HYfE0w6m6SfYFlcoxtPjEcEbCE5UHQGbWhyX+bbLpHD2vg3Aa9IvZxo3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5tlvwX5C9h///7veJMPsrgGP2qjq1/Cv4O7A3Q4VPw=;
 b=vr2RyNCH/jYM4NSrxj0s7Rd+yngaY+5F/3Rv193zbDABMWZpMppsRCX/InspuRd6x7Q9cCM9RpYn+1Anx/sFksw/bqQKT6olBZj7SkbGbzBYAAxIXTCe9LyennHrlXv4omDu2k5DpkOC5cMs4B31tY9sG+4RB8nXBOLp01HPrsRi7Rniq1yGzPcVl4M9ONu1A8LrrSHiob4FolqcAidrG5J54IGg15mSHK3HbzRVTabkIN6NJIrgRmKMDXxOgPMvb+ZnMAnFqIAJyr/6ysiy6/OmCuGobMicViMABBcSRKPbthApMl+UB9DGDQD2QprQZG6eFyBw50oDPg88tPuzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5tlvwX5C9h///7veJMPsrgGP2qjq1/Cv4O7A3Q4VPw=;
 b=fukT8hdF+WL60iRxSQh7gx0CbMhhE/UGf3klkXIK3SGbABt65qPU09UKVtWGdHuZ/absjfQTWxgz6OlipBEswXzKjqpnYaV8UAq4cyWLoyCTS1nQGBsoQF2o4oUp0q9/r3kn3MLliDsR+RLcR0EaVC1CVsXo9rmaVdpgnjasr+4=
Received: from BL1P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::27)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 1 Oct
 2026 13:21:00 +0000
Received: from BN3PEPF00022BCF.namprd03.prod.outlook.com
 (2603:10b6:208:2c5:cafe::68) by BL1P221CA0026.outlook.office365.com
 (2603:10b6:208:2c5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 13:20:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCF.mail.protection.outlook.com (10.167.248.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 13:20:59 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 08:20:55 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
	<michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Sandipan Das
	<sandipan.das@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 1/9] x86/cpufeatures: Add SevPerfCtrVirt feature bit
Date: Thu, 1 Oct 2026 13:20:13 +0000
Message-ID: <20261001132021.254270-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001132021.254270-1-manali.shukla@amd.com>
References: <20261001132021.254270-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCF:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: a0539fde-da99-4194-0c22-08df1fbed592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|56012099006|3023799007|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qwsaqMlnaXivXA2h5hDnLXOOci6e6siUKEQc6KCpGIy+KJmDfzRKaOdDqMWcJXAq+pEhsoftXeipPl5V7E9HrcyRxOp1Mt+/unsgYEJNvXTkQ2pcg/xTFSYk/rF/u5KCQ5n0T7cPi4mltBirpeXnu9605X5Tof4AJEOrCrOqaqjsuVnrh+EhwA1iNIaiFNMkmGnxFOPTRVh5oqpViZdOYIm1MBo37G2zJsKLF7kpvL9X+LKPKoXzCzzMJdFNunOrvdTWSGmu1ioVjSERvC5sCtI7RXJMeM2HbJW6jf2u6SOcGFDy9HhDLKlM1x2LJ2oK5qwe6IVGpVMC9C/iJFeAWTCT9fgD65aWoQHkUcpgSoNw7AqJuUUzobfcj8GJMHZzZ+/PZ2svrjAilTZMyR5frzTr+EQnGppWAZmkQODyUPKgAnyHkHcOEVNMULaJhVrxddwJyHoeM1BPrDzGYnvE6nOp6jZLGdGxmP1Xjt/mUmAmGL6tXM4mhw5MIjZ8KLCZPf1x2vs9nZHkQzAVJeikHqO6tN+vxBXDIADAkgKTqXDeEPegS/53Ad3S0bYUvfgYoQCzPy/e7w7G2E7vRrOjMEVlmI1LyxywmDUB/EJZ5pV1ZeRaMDxMpdv6FigyPgiznmLd7mdcKIMst/m3/RCRYBv2gVA3+81eIybLi64ToVnwMVnq83JRku/h0TpnZflF4zzdV9SnwKRklKW26dgvzQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(3023799007)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PTIrDZfcpRA7Qhqgd4j2aMvBYhCKf3fVyWyIOZJEq+I2jT3FgMA6ELmJciVbuceDOO+VAEhbv0n6KYWnG2dw5Op3NE92Mk41rj4pFbqwguOKdrRH/pemiZUweqL1Z7j51K3heezZzNiUQA0koHnC2zT8vr8uCYLTUzWK/3xvwEjQTMBgagJq74zkvZYyaWwlXlFPClmwgIMhEBOKKkqaPoq7szw20rdFaFw/8RC0d/n+Pq1ugosro1OLZ3n/lRhMkaEXTM7Dd1lOXBKY7a0jxNY9GkPmPNnFftDubynQwaxoOTHQy0qGGVviAVG5F6MlrriOM9f8tnDqRm33AK+YlHWoA1DuYxqny2eWxm4IWJYPHziIy8wE2bl7pq6fBXz0Dh8IHuR/XSUH7JIiGmbnoov1m2Ww1CwBJNWplz83qRfTi51xI02EwxU1JzZ9Qhg7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:20:59.6669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0539fde-da99-4194-0c22-08df1fbed592
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BCF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870

From: Sandipan Das <sandipan.das@amd.com>

Define a feature flag for bit 20 of CPUID leaf 0x8000001F EAX which
indicates support for PMC virtualization in SEV-ES and SEV-SNP guests.
This is an extension of X86_FEATURE_PERFCTR_VIRT meant for use with
confidential guests that do not want the hypervisor to have visibility
into the guest PMU state.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 379c9f8b9fe1b..337beb9dfa3a5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -467,6 +467,7 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" SEV-ES full debug state swap support */
+#define X86_FEATURE_SEV_PERFCTR_VIRT	(19*32+20) /* SEV-ES PMC virtualization support */
 #define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
 #define X86_FEATURE_SEGMENTED_RMP	(19*32+23) /* Segmented RMP support */
 #define X86_FEATURE_ALLOWED_SEV_FEATURES (19*32+27) /* Allowed SEV Features */
-- 
2.43.0

