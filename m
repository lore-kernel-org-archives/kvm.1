Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012053.outbound.protection.outlook.com [40.107.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4643D3CEC
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122455; cv=fail; b=jl1Bz71cMn8s6EIpXEEBPskb0CcFhM0XvdYY4EH4Uicg6e+uDLOlWQ7/Xju3k3gL31Kbj/oVdYEYqqv4FEeSfNyQY+RVQPvd4O2vY2IJp+i+EiK1iF/LoBnlV3MxdrG6BPjW1s/vbz6hef3e73H3zp5RjUidMotE+TH4CEkc8u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122455; c=relaxed/simple;
	bh=IlUYtD7YYhkonOCqxN8GSba1PemYAzp6poScZUUhmD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOO/C2HEuPr0xh8kzaQ58QgrSGyM29ZBVDzZUrlr3ccyf89bqy/YIt3hyHq1iddO+MbvW+fO2I0ROQyKZCDOqkOyWYkUVBlJfZ/7tyGPNpJY38/f520oLSi3jivqXYMgySWG5XiHIOSVtDPY+VerU37xoqSs7+DEYOjZKbw+tKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RefFTNgo; arc=fail smtp.client-ip=40.107.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RefFTNgo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PePECg2IFIWkp41VS6DXt8OH1+Z2H234psx0NZGc2kZSv0gYvfuFBzPkuhYktRfYAl99rbR94VVaQYXTpcE9Wr2DxoVegWKiJiZcfmZYIouGWPKB4FUB9yoR10gCVQpMK4lHaRkKhlgpPkuWNmL9oTcoDzDPZuEwVAZus8Gu768lzPN3o1vSYUlAW/BfKOrPtiWQJGBy29xZ1EZKwIMOxKmUimh1vy4A6ac4qIw7ia2sUJAyviTU0c4ZYAP0laZRLcHJ+omFnvK0ykrPi7qmGWjFvNVW55zFmoeODdmOYjSX1xl10WU9nGAghSuLfZhtDa7A0MqjWNwQeKDzkTYBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k365Gxkha12ySt0ZbiJAee5HGXD3CpC57dnhvwc5x3U=;
 b=GaxoYMsf4mfYoCONUFpoQxDV+0aPQubVfS0jcEb+17CKPr9IAs55exN1nDboB1807x5q72yKz1gjUz0C78wvC/hcC+I7IBlT1Qf1yYDFTn9GdzGAFO5UkZUU2xKc/TVf5F4v2ZjYnUepZv0CSw1qNjc4IfIlZSKpFuM+a6GjEusOIuoMFR4+DKuvxwW2OrzUeo2LgHy6so87aD8TOtoutBbQanchqv0jvgkLr7jgauyc3N5p74Zctm3VN4Gi+JR/SpgZSLkVc1R2aVpVQsC8+QPHamVvjsrjV3jSCiFSTjXR62LRhCI7xp6h9BG/jCSkznPXR5Kb8tgIMB8AXSjt/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k365Gxkha12ySt0ZbiJAee5HGXD3CpC57dnhvwc5x3U=;
 b=RefFTNgoZzXZmYcCF/Waz4555RsxbeXRFDUMTm3PxZiOBe3r9iiEgtFBXU2U4/aTkNEd5uOis2NPT0MDxeKURsjJMxvOPextNTJJ544fQKrVCWkJ8BTkLkbSXb2Wv3UzCE+8WzcXzshFPj2Zk2pWryzqskIb8eICd0iKRvhRVcg=
Received: from MN2PR14CA0001.namprd14.prod.outlook.com (2603:10b6:208:23e::6)
 by SJ5PPFA5F0E981D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Tue, 10 Mar
 2026 06:00:44 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:23e:cafe::2) by MN2PR14CA0001.outlook.office365.com
 (2603:10b6:208:23e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 06:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 06:00:44 +0000
Received: from volcano-f23bhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 01:00:42 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>,
	<Naveen.Rao@amd.com>, <dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>
Subject: [PATCH v3 9/9] KVM: SVM: Add newly added IBS capabilities and MSRs
Date: Tue, 10 Mar 2026 06:00:21 +0000
Message-ID: <20260310060022.15120-10-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310060022.15120-1-manali.shukla@amd.com>
References: <20260310060022.15120-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SJ5PPFA5F0E981D:EE_
X-MS-Office365-Filtering-Correlation-Id: d651a49b-cc08-4f0a-fd7a-08de7e6a5df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026;
X-Microsoft-Antispam-Message-Info:
	xHTIghfgdOTkTPl9eUahVzWFfwUO9fJ4Gm2D6A92EVvgbETnuQcXzTBQhyBdCNeMFnXuMCOLU3xRRXYpvsgg8ZbWS9GDGABAU3mS5xgX7liDswqTf6n1NFBUfQav8wAL3AuR+iQHDbbR6avBE1+rDSpjhIggATQ83axVKCfG4Z1zTXmF9DjJ8PQH+azk5+NrP64NyYeFLfq++s5E14UMuLn/z3Z+/JPA6FojheuQd0sJPtjYmwFV58SiPGmytqe6dBjd6POaDgDN648ZeiLmXxVhfVIW9XUUPIQkdwsGs0ojUIi498xEVqKa6MJNsSJGwp8G+tHGJ649oRLKnY0mueaVclO8PUzTsF1BNo36t+lqyu+zwcNb5pRa1GnwuEPQ17fY97SjkLEabYOKE1Ktc4Dc1qg7tyrWV7esajjuSu+BZOgGaN/ZfQr1i6W/qRO5NIMvmfdBXml7SJwJeru3+LJJlQpikl3O7A6WP9UCucp8RRENHPTluM7dVfgXKSq6svdfCG4gt2qu4s+YA2T8YeNrcRNyU0zLMIbi1NpvdgiLp/1XZJIytJL+JP/Fuv8nW1SkyyQftOlFjAM0DSQlT8IBGrCVrgdiAxEOJDbV0CLG9MQCLA3kRHF8u8WjJGsIDyK4+l9h9d00jj4xiZRO1Yklw3LFQhCOEX5zKaFCEIzK79lHL2lRM0b31RmaF28T/wP8IjxU1g5zoHlj+BtbxrGctQ4sq6ZyU5e+SS1hqx/4PfO0W4NPCTwNIV/nxrd43P4d3Jg5A/0XEBfybwPdoA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Oh5ezvFzJXRre+8/2IGB+hcHU0liu5sU8ogeSQ1GbN4kmu+BxDml12NSAr1mc3wjrCEXw1lkPmPuNioxxEnr7cN7v287SDaxEy2l1nU6qHcH0E6lAW5egVhlAOgzuy1Pv0Krtae8pK8t8B9nRwblxsg6ExtKbk4n1zxu9ZRD9vv2MuJH0n8F2QJfNIACWYLVUAJ/GiyAYt6f0xgiRFmgUO5xn5nJ2UW6GqCTY5kHtx3V/dl+w6BtN6FO3X9jKRj451rrms7mwXNA/yNYrKO5tMOi+brbSBFsEzOVwXFsVojmOGtY8Iys5FD4c4PWwbMxleqe/GTODk1SYcB2w2R/LZYuZo9dwBfOtQE6EQNbBmfKCbkbIi7PJWK9NWKOqBCwr2nKcVo6CuvFrOKUroAzeeKofe6JngHMdfWZtXbJShTLtdYYc/3D05ha17PrbFem
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:00:44.0977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d651a49b-cc08-4f0a-fd7a-08de7e6a5df8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA5F0E981D

IBS on upcoming microarch introduced two new control MSRs and a couple of
new features. Define macros for them. Add these newly added IBS
capabilities to KVM-only leaf 0x8000001b, so that when IBS feature bit
is enabled on the guest, these newly added features can be used by
guests if the hardware and guest os supports it.

 - X86_FEATURE_IBS_DISABLE: Independent IBS disable capability to
   avoid RMW race
 - X86_FEATURE_IBS_FETCHLATFIL: Fetch Latency filtering
 - X86_FEATURE_IBS_ADDRFILTER: Address Bit 63 based filtering
 - X86_FEATURE_IBS_STRMST_RMTSOCKET: Streaming store filter and
   indicator. Remote socket indicator.
 - X86_FEATURE_IBS_BUFFER1: IBS buffering v1
 - X86_FEATURE_IBS_MEMPROFILER: IBS memory profiler

Extend VMCB save area to include to the newly added MSRs:
MSR_AMD64_IBSFETCHCTL2 and MSR_AMD64_IBSOPCTL2.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/svm.h   | 4 +++-
 arch/x86/kvm/cpuid.c         | 6 ++++++
 arch/x86/kvm/reverse_cpuid.h | 6 ++++++
 arch/x86/kvm/svm/svm.c       | 7 +++++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 17aa6bf76bce..88833db2e739 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -382,6 +382,8 @@ struct vmcb_save_area {
 	u64 ibs_dc_linear_addr;
 	u64 ibs_br_target;
 	u64 ibs_fetch_extd_ctl;
+	u64 ibs_fetch_ctl2;
+	u64 ibs_op_ctl2;
 } __packed;
 
 /* Save area definition for SEV-ES and SEV-SNP guests */
@@ -564,7 +566,7 @@ struct vmcb {
 	};
 } __packed;
 
-#define EXPECTED_VMCB_SAVE_AREA_SIZE		1992
+#define EXPECTED_VMCB_SAVE_AREA_SIZE		2008
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
 #define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 4e626e77e6a6..e8a664cb0bb8 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1239,6 +1239,12 @@ void kvm_initialize_cpu_caps(void)
 		F(IBS_FETCHCTLEXTD),
 		F(IBS_ZEN4_EXT),
 		F(IBS_LOADLATFIL),
+		F(IBS_DISABLE),
+		F(IBS_FETCHLATFIL),
+		F(IBS_ADDRFILTER),
+		F(IBS_STRMST_RMTSOCKET),
+		F(IBS_BUFFER1),
+		F(IBS_MEMPROFILER),
 		F(IBS_ZEN4_DTLBSTAT),
 	);
 
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 22cfdb331e9e..1af2ba207b8a 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -89,6 +89,12 @@
 #define X86_FEATURE_IBS_FETCHCTLEXTD		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 9)
 #define X86_FEATURE_IBS_ZEN4_EXT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 11)
 #define X86_FEATURE_IBS_LOADLATFIL		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 12)
+#define X86_FEATURE_IBS_DISABLE			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 13)
+#define X86_FEATURE_IBS_FETCHLATFIL		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 14)
+#define X86_FEATURE_IBS_ADDRFILTER		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 15)
+#define X86_FEATURE_IBS_STRMST_RMTSOCKET	KVM_X86_FEATURE(CPUID_8000_001B_EAX, 16)
+#define X86_FEATURE_IBS_BUFFER1			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 17)
+#define X86_FEATURE_IBS_MEMPROFILER		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 18)
 #define X86_FEATURE_IBS_ZEN4_DTLBSTAT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 19)
 
 struct cpuid_reg {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 421a929398da..9bf0d5f66239 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -800,6 +800,13 @@ static void svm_recalc_ibs_msr_intercepts(struct kvm_vcpu *vcpu)
 	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSDCLINAD, MSR_TYPE_RW, intercept);
 	svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSBRTARGET, MSR_TYPE_RW, intercept);
 	svm_set_intercept_for_msr(vcpu, MSR_AMD64_ICIBSEXTDCTL, MSR_TYPE_RW, intercept);
+
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_IBS_DISABLE)) {
+		svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSFETCHCTL2, MSR_TYPE_RW,
+				intercept);
+		svm_set_intercept_for_msr(vcpu, MSR_AMD64_IBSOPCTL2, MSR_TYPE_RW,
+				intercept);
+	}
 }
 
 static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
-- 
2.43.0

