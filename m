Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C04F41BA75
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 04:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829880; cv=fail; b=U0lMqQg/X1QBInAmy8VCZoPeZEqd8mUbWCA3ADfIO4opJRkPTGfx9SXV7zqvMmk+y0kcKXSrM5PfM8QtlFkopWkvGO15k+Op629DrmFl3byP56gpx8HIlFt0cJsQTBzJKqmFrI94VbcTXiWKl/cudOJI9CgjrXDESv09u/oaWSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829880; c=relaxed/simple;
	bh=bzeL/2NTN2Xms2Yz2zaKJAzIW/y6Vfi2+IZLBPppPc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXLl31Qa8XnzdsoSOmpRThpKbPlUKFc1b135lXr90CNlg0J+qGfwOGNuy2MrsnQCzEG4Dckt2VhIcEVHfVTLP20kJBoNaIQBFSJ6hfXc4X+umy/q2gSvEyosLSeFR0hQKph8IX4XPIM8/buivBNSJ7Ysc2D3zsodwsi3hhRbOIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JftXt/+U; arc=fail smtp.client-ip=52.101.61.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JftXt/+U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9xeYQviDzrcfoqolacat9Hfu31vIyY6ESxEEl3olCE14nkC6wF18G2m5tkf0jekUPSmKxZu8WHyihtXvaMkTadfeTQrbqLYCsEIhNxieGAL7VpasBUcz40G9ty+bo6HSNEqrnlfwpQafN7t/71tf9XFfR2ZBEYnSYQzVjaAXjY3oGzRyRboSFSn/AVYk7CXFSLHG0EHspcRf3l3PN4A+eftALMlrbK2dCtNyWz5OFjroFdmbeUkwxm9jxAx1zihdW54OBra0d7+PlUmvSqIQZgBupxx61ILzA+NmpEPHMsPcD5zwlj/gtXq+T8Nj6xZemfpmtLuHamPSk9d4DFurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMojB0RCWPg8YB7fGEYWG4/y60Haa2jRsqmaI2nWvq4=;
 b=xb6Sn5fLrXMA/R7yb8tSQC3eBezEw2byVIrkeA0ddFwSmjF5ytWKzpZa12f6nCYl5AMfB6J3V1xUgcARE59ByXhyw9bdB5PXVeb4128oxbSXimpJAE/l58Sw5LvSAIE9KOLliaLp/oEEJM6Pn2yEP8AovNSLuWN2uFNiYIXKepjA9eZ77hqKBzkykF8yaGFEpa1BZWmrL+JnHIfi5TMBRr4b6syDb+3teaKcZ7bu7WBfM1hOxcx+6U5f1KOsTjPPDI8F38snXyEC5kyYcE+SVvc2HFy6S5NtLFF0ti0IkbZRcy3q1vkECNcovTJ0miSiTVRwRX0oliCUnnt2ciH74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMojB0RCWPg8YB7fGEYWG4/y60Haa2jRsqmaI2nWvq4=;
 b=JftXt/+UQ7O4OZk36uIoqBojRdAolTTJutMBsckdAcaDM/NJCfJBKQdGol7ySDJzLuarVUgO35RWa2iCfTz+p43OyxPPwfQu2tRuEDuRf6jHNxkaXVN5F72fOh8BlWs4bY8yPlce9I1+/ec64TmuOOxq/ZcwzzqQFWRxCdPR7Gg=
Received: from BN9PR03CA0326.namprd03.prod.outlook.com (2603:10b6:408:112::31)
 by IA1PR12MB8224.namprd12.prod.outlook.com (2603:10b6:208:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 04:44:17 +0000
Received: from BN1PEPF00018546.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::5e) by BN9PR03CA0326.outlook.office365.com
 (2603:10b6:408:112::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.22 via Frontend Transport; Thu, 1
 Oct 2026 04:44:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018546.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 04:44:16 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 23:44:13 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sandipan Das <sandipan.das@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 1/7] x86/cpufeatures: Add hardware-assisted PMC filtering feature bit
Date: Thu, 1 Oct 2026 04:43:45 +0000
Message-ID: <20261001044351.50535-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001044351.50535-1-manali.shukla@amd.com>
References: <20261001044351.50535-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018546:EE_|IA1PR12MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a2851e-a835-4662-ab90-08df1f76a681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vMCCaj6lwyvtqIuPvllI0Q/EuhNcn46JHl5jgiOZneqhYKLjaKFUVU73QBSuAGFxNHyw2v/jCKelUR+iJzynlM/QfGSf7Kc9EFt6ipxZACHnlP4MfyTJfkrbVMBIIYyFowU4d/2emAuwC5Sej3i5tERZvTyCDPvv9cXRciutHSTr2SAkKfe+YsHsijjFUJtWkUNy5iXtaFNHulfGa3SWBYSJPxDrT16+4/rcG5RRmRqsmJhtYFq1eFG8F4hRavcQbwXq4+5Zhdyt4Bl3RQfMhEEJO3h88WZeROgK/WAmX3TOs3xCzgXwWgEAiaiLZt+Oc5WHRu6pKVah2NLg0FzxgBmw3OwOgfJ6/n+2cli+Fl0Lz2djaPjKtwLPaLId9JU4O7fd75Qte1OrSrJn13tfncCwfICY7RsCHr1OZ65E4o0Kv2QUnHxvayovHP3i7nZN+CxAcWp0rV7n3bS5GKTnJJKQPvpM0xuNxhtOhwgo1sI0pxUUKJLlBBbFybJd4MaNJfHQPeG7PAD+5m+Je9Px264X69RZeevzLlVuyRrWe7jLjBHjshWU4f9OJKaYcX3nToG/KfWavXxSIL9j1xuHDQFZ3mQ0O3ecZCqE5snVr9BydU2XjcRvNjBOGielxckQRfQbf+PZC13a0ia1h7+uvb17INZgebO/v2LSTUp51oBv5QtH62b4cEVHPGedxRKDR7W4k4KOgZdlMtR3rIrysw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ScfigCFynpG0lqt/oxjmwPI16Lt97Qc6RKGur3NQa/6y/Ho4qg2Be74dfVxeVzpcOMv+47O3czQT3xKrPNMF9DS5b0E6D+gnDV7rGv4iDMGIwRmMLd7n5k69OBU6oQrz4WQvUgCf5R5QlNrF8fj2yHRFLXv9hFTwu7g9OW+yrop+usq6wXIkXKLSv/iTUvrmoPp8ze/6V8rEkMWPXrg2XswssM3s5OMDSBsv5HLG7eFPcFhJjEkr1/L8enc4lt8Z0fjYkSPHg5VnB6xlrn6+JjAX7TxUVoe48A6lra/txuNVTIWL745FpZu7h9WPpu2bY2s8UiZBOjH+D58BAjAVpl88zO5TyI8e767paEkB5ZNmHorjOhMyg9TdOh1wGTjTLwo5aLsiDNqU3HqHdf+8KMmlRR8/UZZX66PLUgeEhixcm+9XmkVn1D+XHqnhDZMN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 04:44:16.9595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a2851e-a835-4662-ab90-08df1f76a681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018546.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8224

Upcoming AMD CPUs can enforce a hypervisor's PMU event filter in
hardware, which lets KVM pass the guest's event-selects through instead
of intercepting every write.  Enumerate the feature, CPUID 0x8000000A
ECX[3], so that KVM can use it.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b551ba381b6e2..379c9f8b9fe1b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -238,6 +238,7 @@
 #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
 #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
+#define X86_FEATURE_PMCFILTER		( 8*32+24) /* AMD PMC filtering */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* "fsgsbase" RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 937129ce6a964..e71d9604033a7 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -55,6 +55,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_AMD_FAST_CPPC,		CPUID_EDX, 15, 0x80000007, 0 },
 	{ X86_FEATURE_CPPC_PERF_PRIO,		CPUID_EDX, 16, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,			CPUID_EBX,  6, 0x80000008, 0 },
+	{ X86_FEATURE_PMCFILTER,		CPUID_ECX,  3, 0x8000000a, 0 },
 	{ X86_FEATURE_X2AVIC_EXT,		CPUID_ECX,  6, 0x8000000a, 0 },
 	{ X86_FEATURE_COHERENCY_SFW_NO,		CPUID_EBX, 31, 0x8000001f, 0 },
 	{ X86_FEATURE_SMBA,			CPUID_EBX,  2, 0x80000020, 0 },
-- 
2.43.0

