Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792444095;
	b=nscbJKgJepnmUE5mDx58Y8xqvAlemL3t207l7wGGIm+wCsf5oHr2lKXa0vIIOA3FR3uz
	 oxhBCm3wOodH1t7Ij91Oa1YUSI67BDq/IoP9BQgBh2840uVIeFO6CymD9MCnP81bdOMBw
	 KW4eAxej2JKic1C+6vz0fiqMMV18NAB0kbDLJsqiIW5O+EFkPDCYY92hYHIMNJwl0zSLJ
	 GgYLE+NueD2CfGMHfZCknroey1R0SPFZj+u0xvkCSgTiF8zdA1pnXUgQJ5TuwvaeBGEHa
	 Fr6vleaQHxaNRPRIWRDNjKl6+m+r/beaMaHWbgMjw562ptKGofA+TdJvH8p1Rt/xyZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444095;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Dp6eyYTPR9txQKChG5u/2hYuIliqy1qAoFh4McUQVuU=;
	b=KjyIWqDZ3hMe/7AsOTY4YTIc7RliFO/3ApwZgPhkuUUvr0fc5G0KPqwBPQEy+LHhBXf2
	 6ZQheZQuJkiRebjTWJybRx2tixGdJz8emTJX0b5149Nn6KKy1yrcy9YDnJvDozfIQb1iz
	 vYhLfM+S4/qo0EqJ+VAUZq11OJT/jXyu5ZgLTjQOqN1w5Wk+DSBxlYGCaOhEdHZt8wwwB
	 0BdZZ8cPFfcZNmrorSMGHUIkKwB8ISMUhayM5alHzSM0ELWNBBIMBLKd0n+5I0zm/gSUV
	 oCcEryrLREJjuAXUALIDdVCvjUy06R5C9U6+Dj+yy4TR5qcY6HubUB9IgdLqq89BTsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p2vQCZZ6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.4
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14289606A31A
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14289606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p2vQCZZ6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0/zGd0ALvfr31gesItCkitIckTfEFGAc4c4wbnzoNwthJeYBG1D3ox21hpbyfoN8GYaiJHGGqEKGHPNDKqOHI6y9/EcduGXqX5D8A2T7OwxSREoGCb87Rv6TxJ89Ztz6IdRaOqADW82JNT/MDkFuFtuArBmZwMsBuDk6Eqzkv+HPFrKMbxUegsuEocKcEBYYqATBsa4e+yeJeapEpjvZSWxRaq2U28dYpf8oZIVJE1c3v4B+YCkwfIIpvw0Cn5MBaOrXWELRWzUD+8NNUhq9/2O2tegMHcJ2isZw7Q2CaFxg/DQbShSfiO3cm38yr9MLAQm1baZOzb/NYeMCcLs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dp6eyYTPR9txQKChG5u/2hYuIliqy1qAoFh4McUQVuU=;
 b=W7prixzbBvkjnrRtVON47L4vsGL8I9koc/QJs2W/Z5Z6mqg3nnARJ6f9AlkT0rELUzXxdxAKqk08XW0prklpmUM0Nj5PtxlU65jTn4N+Pl8zUAG2/EvcF9EklAsX6qsI+TnxS0Yi2bJzNAM0be4P4y8PVzC9vqdQlnWJA/J8YeddKfxNvsr6BIbrOKHiDAoTj1dBUVKCj7jWr7LwqQCttcKq3Sv4GV0NJmrwXFVsZ07Q09d++47mgyxZ9p/YMo6NcTP5QVHaAzx+xiGSCOYc7dlC+qYviKEsKLb1++NIcm9w1j2JsOoPwYnIRIdn7eJj6TspaNe0l0dXxiEUmLmDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp6eyYTPR9txQKChG5u/2hYuIliqy1qAoFh4McUQVuU=;
 b=p2vQCZZ6f0AVIlYH4yIpjnA62K54xDwx9AkH6hlYdhv5reQdF9JmHAwtsh24TaqKts5zxvRlxlod0m1m+iBjZV2icoABzjgs3tfPrHUe3m8xgvfyiOpOjtRoA746Ak1ANejrojU6ttla3EplH6/vsYOgTCGyuGfACOzDWhfR2gY=
Received: from DS2PEPF00004567.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::509) by FT1PR12MB777854.namprd12.prod.outlook.com
 (2603:10b6:170:24::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 21:07:29 +0000
Received: from CY6PEPF0000004E.namprd03.prod.outlook.com
 (2603:10b6:93f:fff6::eb) by DS2PEPF00004567.outlook.office365.com
 (2603:10b6:f:fc00::509) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.0 via Frontend Transport; Mon, 19
 Oct 2026 21:07:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004E.mail.protection.outlook.com (10.167.247.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:07:28 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 16:07:26 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <peterz@infradead.org>, <acme@kernel.org>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <yosry@kernel.org>, <jmattson@google.com>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 05/12] KVM: x86: Add support for Live Migration
Date: Mon, 19 Oct 2026 21:05:25 +0000
Message-ID: <20261019210532.378628-6-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019210532.378628-1-shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004E:EE_|FT1PR12MB777854:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b87cc31-3521-43cc-694f-08df2e24fbc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|18002099003|10067099003|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	MHuGMwKOP7RdiVZZDS+wcrVIRvJVx1HGzbFgO+V4T6wL1mBTu6S5Y4gLVGsLtX8bp7cpJQawbuvWzz+FyP+oZou866Y5tMpk0B4CnI/eVRP4EtMXkj4XAeq+osD0cBMdQ0o2RTAiPyRJzE7O+/YjPqj81zvYPsoKwlqR/av+aGwd/RqjVJSsKbINMTM7sLU74jmrCVtu41Qjzu616b9vuAd9SCBMuIEZzTwPdkX7VIK0Hpwnfb+e+7xrjcDVfmb+2XXkOhsn+EhfFuSwvHo/wC2haVTL9GdwCez7BMYsrTXj2NzwDyVFKy5eSOdgipOLBVUc1x2RUp031gHWOB8HEX/fLAsXqVFxt+i7LrL7pl1uSPh4GMndw2F0/1zdGKuX6nSPa9efhFNOjcORjVB+QfCcsQ/YPrhqm4se/mjhoTa6YNhdrj7mMgWBNEE5nbpTbRdcLgZJIuApaJuIcq2kO373ubTLWkyACKa6aO1dg4Kx4VfgeJr924LRSER8ps1aMhPBRUf4S7nFTi37ebBFHqKyrinIbSwCOTpJPtKuZKwtuujHD7k6puDoDtK0wUomK4kaoD9yhn4f/C3N7dZ5tXTM739OKVC4JbQQYyMlrTBrDZhFQdXz9aK8eOzP2djntkVAj0Lvdqr5S98jnvNv3Cq3+Qdv3UlYXMdq8/n43X0LbCamrGU2AGPHoRdeKKUxFV87pAMaSM4kikTInU8EBQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(18002099003)(10067099003)(22082099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JrQqrqTq+a+a0nVsmxVqeIj8TlvBzmueoyqr/1D6q4O9Z9Z99UQ8FznipC1UQSLOYB8J+wwzYnBXFmC3WG+KWx+Cg9W3Bt8lxYy1ZJv0LENEjvrW1X/dMb3ZQEK8nTo6M4QAX5ms4tk54p19T5zV8NqaZNJS2Qw/3w0jnQZVBsPcRq9gDbeRG/2JJSrtZqI3LtllTD224I5MiedQ3/4V3uFbrT1/rpXlXntwgZ1T8ogsX3YuDK3gVRY6quHRNglUyaKppya8Ayq8exIrazZrlgb4fUg06fh5/qSbo4+I/IEcbOujHcv488rnDwERIdQa/EoZf3Io8t1VN6jaBPKxuZAmcGujppr/IHF/Gk2cLMcdPU3RTOLElCaYilt5QN4/Kmya32UT4EGXbTwg9f9raf0uwfg7R3VZW8aD8IQqqJq2sb4HFz+JOyxmW4oIJcEl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:07:28.6792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b87cc31-3521-43cc-694f-08df2e24fbc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB777854

Report the LBRv2 MSRs through KVM_GET_MSR_INDEX_LIST so that userspace
can save and restore them across live migration.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* New patch.
* Lets userspace save/restore the LBRv2 MSRs through
  KVM_{GET,SET}_MSRS.

---
 arch/x86/kvm/msrs.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index e91650af44c2..e392e3ac928f 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -245,6 +245,26 @@ static const u32 msrs_to_save_pmu[] = {
 	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
 	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
 	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
+
+	MSR_AMD_DBG_EXTN_CFG, MSR_AMD64_LBR_SELECT,
+
+	/* This part of MSRs should match SVM_LBR_V2_STACK_SIZE * 2. */
+	MSR_AMD_SAMP_BR_FROM + 0, MSR_AMD_SAMP_BR_FROM + 1,
+	MSR_AMD_SAMP_BR_FROM + 2, MSR_AMD_SAMP_BR_FROM + 3,
+	MSR_AMD_SAMP_BR_FROM + 4, MSR_AMD_SAMP_BR_FROM + 5,
+	MSR_AMD_SAMP_BR_FROM + 6, MSR_AMD_SAMP_BR_FROM + 7,
+	MSR_AMD_SAMP_BR_FROM + 8, MSR_AMD_SAMP_BR_FROM + 9,
+	MSR_AMD_SAMP_BR_FROM + 10, MSR_AMD_SAMP_BR_FROM + 11,
+	MSR_AMD_SAMP_BR_FROM + 12, MSR_AMD_SAMP_BR_FROM + 13,
+	MSR_AMD_SAMP_BR_FROM + 14, MSR_AMD_SAMP_BR_FROM + 15,
+	MSR_AMD_SAMP_BR_FROM + 16, MSR_AMD_SAMP_BR_FROM + 17,
+	MSR_AMD_SAMP_BR_FROM + 18, MSR_AMD_SAMP_BR_FROM + 19,
+	MSR_AMD_SAMP_BR_FROM + 20, MSR_AMD_SAMP_BR_FROM + 21,
+	MSR_AMD_SAMP_BR_FROM + 22, MSR_AMD_SAMP_BR_FROM + 23,
+	MSR_AMD_SAMP_BR_FROM + 24, MSR_AMD_SAMP_BR_FROM + 25,
+	MSR_AMD_SAMP_BR_FROM + 26, MSR_AMD_SAMP_BR_FROM + 27,
+	MSR_AMD_SAMP_BR_FROM + 28, MSR_AMD_SAMP_BR_FROM + 29,
+	MSR_AMD_SAMP_BR_FROM + 30, MSR_AMD_SAMP_BR_FROM + 31,
 };
 
 static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_base) +
@@ -2644,6 +2664,12 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		if (!kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
 			return;
 		break;
+	case MSR_AMD_DBG_EXTN_CFG:
+	case MSR_AMD64_LBR_SELECT:
+	case MSR_AMD_SAMP_BR_FROM ... MSR_AMD_SAMP_BR_FROM + 31:
+		if (!kvm_cpu_cap_has(X86_FEATURE_AMD_LBR_V2))
+			return;
+		break;
 	case MSR_IA32_XFD:
 	case MSR_IA32_XFD_ERR:
 		if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
-- 
2.43.0

