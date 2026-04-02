Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E37738423B;
	Thu,  2 Apr 2026 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155418; cv=fail; b=NCoPyBUTUe/2MxcF5bJV8msqxJBPQ+56SNoNDkS3gflAf+qFxdnrV++NC2qnp6liTWDEuCkD1Tf6hisk2Wfoc27VvTRSmz1oo65Bj76nij01mmMLLn7pyFJRZDgq0M3ycGYZI4Z7eQh3MUFhQ7TwmE4hLXfPheNZH+pN07TD/HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155418; c=relaxed/simple;
	bh=xptJA6YCAOK05+KTXYIX3BPhFXBhIhld1/VGYRoahRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/KLN3ydu+BTiFKESOluXKBEStLxpYpqRTmgZ21+q3oWPIpCJLKPLPhBzwdUxeUbXoichgWa8MGZiWX00opKdbhwJn/eowv+meLOXVxWS84SyGDB7jhQxp9qm/filDCEPfmtMsHAGosbBd2JLil40k4sH67WNRgihYRChrpiSI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SJjn/RuI; arc=fail smtp.client-ip=52.101.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SJjn/RuI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5KaxwdhPYNW/BW1zcgI3qGy77Jm7AFG9aqoUx0dFsfi11AR3pfXzaRaUptur9ftFI2ZKaGmH8QqO5h32bO2Vf2bg3zZcrjLnjcdeDGSPu3mCEn37E35ayWeZfPVtQZZ8ocnc0jxHNBdANluX3b0crva52r8O6d24NxEJaKfioPxRtdtESz5l+6M+Lq04y6NpNlBByyJNJgRPR4cGfk4/LqQMfFEIiMmAHFOFNguo2gbDUahXNJnUoJxlvvmTuTaOQ8JD9LxppmtvKm75Y3oWXPuDgobXYbwEyZb3LmNDEvINnWDFYZoTD98Z0nkoesUfqufrJzy379EBuCw5pvM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GEfblXECCoFQb/KyDYOhhZWb3lLUZXYUa6uTfKjWKE=;
 b=Lto9vEhOQcIzU4byZMgMESZvuctrYhuWmOM5TS3hAqkz297SzuhHNs4eZ5ukgpQtffqr1jK/PlPTLGUYatpJ1VHSrJRjS5exqhpOTWlYHabUBRRtR1tiKNN2pRa55k3mvZVCrXZkPNT3+KBw9CeHzl1NLpILpE4p2K4OFgJqZ92TCPKZAgsa0RknnXW0jv7kKyVfnW3NRsZuTGRyH1ZWV144Pbh9/1egffe79aMkyz+XcJx6NyPHKeaPqFNbWMcn+G2woreKsUaqyLB4EtgihmTPoLaEtyk+3aEKsId+zNx0gcBAG/isZu6+5LYFhdR7s3dPWqBPRjTX8X1X5F0GZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GEfblXECCoFQb/KyDYOhhZWb3lLUZXYUa6uTfKjWKE=;
 b=SJjn/RuIkgqhd6LLhazkBxgZchDI71xcVxQPLjC8Ze34YUKCwV10Yps5FzX3iIrf/WFbEKc5kYZ6tgGvmsk++81d692riPyOfVsgGky6ovkAyLceBlPiiZZd7lT8Oh9BTeUR8jDz6U04HrBx7HIumjI3xPWgM69vDo06kBgcOu4=
Received: from BN9PR03CA0683.namprd03.prod.outlook.com (2603:10b6:408:10e::28)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 18:43:31 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::e3) by BN9PR03CA0683.outlook.office365.com
 (2603:10b6:408:10e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Thu,
 2 Apr 2026 18:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:43:30 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:43:27 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 2/7] KVM: SVM: Disable interception of FRED MSRs for FRED supported guests
Date: Thu, 2 Apr 2026 18:42:35 +0000
Message-ID: <20260402184240.1939480-3-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402184240.1939480-1-shivansh.dhiman@amd.com>
References: <20260402184240.1939480-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: fead42bc-ac1e-49ae-31a7-08de90e7bcab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	h0e3LhD1kUyGsPZnGLKEGM+RjPQrXlVQ28RaIRr1ZcCDucLM5zrGd3raoStRBKW3K0zGHpS88QWfnlyscfiRSE2BOJRldMkGiJSpDWRmOwdV1vYrKAt3PxncKUdY7duABSqM3wIIAOtWEEU3yLQ8xQWb6wdd5trnQi6G59a2XdAA5JIpt9VlzfNLrzCIHWJcBjhyXcGbD3LS6yR3ZNf/b1zkHkovTAOlDn6vJXEktkqxA0VfdiGeSd93XPEOCxZLmj9uyGoqEn9qBN2AvUdr7boywfDUWTtsbAYua7/QUHthw5XHhBFUU1+3OJ8SGSyobam1qJad9QHNKNS69Qc9eI0Sy4TdejmsnlodI57PMzkiTNKquU0jKjraLHWtPkn2e+VWXt2kAC6jCIE1fwuNtseYT/6J8oW1xs/TEwLvPVNgZrqQ7lWF9vTwaBb0HQXO+OFBQmUP3oMWjDjISx+GDM7veo2X5q35UxI7iHC19ElV45H1IVQfZI032Y9+UghMiJAbf3uFKMWjrY4q94GdKLNBXiHF/XMO+RIqr/28M1YCJMeTwRvoQVWFafT9PPnB6IGEbxL8SlQ+hNnLdEHhZpDXjvioRB/nH1YJ51vxJtYPcGXSuMIHxj73MZClOQtwXsQUDVx2J86UK8CmLbAaHBy1OorC5wQEbcIddNKGsBUOqDHXSBDlbhnP2wLgmy4eOdAaertHOpL4CB0a8ZxqyKynfT1T6x7DDrcdGr4MDjpXsiLxA1VU76eZaozgS4Gaufiq1v6HVi5Xf4ljeXly0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0iKWFcYBhcirQq9K1BZgtBNpPEn3Sc8NzbxlIhvjEA3lzvZAF0NDS31T9jDCJaamnvL8RsfNlz9xDfdmcOCy8l/S1V0tnzC38guW5682r/k9yzx19VFJ7YRri1dU8E7EbhnQm3aT0kSHEr2BVgN+T19khLvRloJQccnNIQwfa6MeYE3hJJF5aGzrfRl8kCB/33tGhG6xu0P+ncedyFuRXqpVA7D0wenwo9BUs1vFlX83aVm6I9YNSw9UUd+h1StvWIaewtwaB5KCNjuEc9Jjw8e4JcAjYq5lA/SPDPK5K8ulzR3GeIGhWA+9wxDJdbugaDFH3oreptHXi3cTw0AX1qjwLZkBDKVmLjCAjVG1MLCtxC3XFNCwdADVOifZ4GeZBf6Ct69bLteHPIBvLKqPRxphPFrkGUUyRzOrSgU+lW5vbaQ0EWjMKI6x4ecSIZY9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:43:30.9940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fead42bc-ac1e-49ae-31a7-08de90e7bcab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222

The FRED (Flexible Return and Event Delivery) feature introduces a new set
of MSRs for managing its state, such as MSR_IA32_FRED_CONFIG and the
various stack pointer MSRs.

For a guest that has FRED enabled via its CPUID bits, the guest OS
expects to be able to directly read and write these MSRs. Intercepting
these accesses would cause unnecessary VM-Exits and performance overhead.
In addition, the state of the MSRs at any point should always correspond
to the context (host or guest) which is running. Otherwise, the event
delivery could refer to wrong MSR values.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Co-developed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
- Used guest_cpu_cap_has() instead of checking VMCB bit (Sean Christopherson).
- Variable rename from 'fred_enable' to 'intercept' (Sean Christopherson).

---
 arch/x86/kvm/svm/svm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index cf6ba59d6d1e..5e85b2853ad6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -727,6 +727,21 @@ void svm_vcpu_free_msrpm(void *msrpm)
 	__free_pages(virt_to_page(msrpm), get_order(MSRPM_SIZE));
 }
 
+static void svm_recalc_fred_msr_intercepts(struct kvm_vcpu *vcpu)
+{
+	bool intercept = guest_cpu_cap_has(vcpu, X86_FEATURE_FRED);
+
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP0, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP1, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP2, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP3, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_STKLVLS, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP1, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP2, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_SSP3, MSR_TYPE_RW, !intercept);
+	svm_set_intercept_for_msr(vcpu, MSR_IA32_FRED_CONFIG, MSR_TYPE_RW, !intercept);
+}
+
 static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -795,6 +810,8 @@ static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 	if (sev_es_guest(vcpu->kvm))
 		sev_es_recalc_msr_intercepts(vcpu);
 
+	svm_recalc_fred_msr_intercepts(vcpu);
+
 	/*
 	 * x2APIC intercepts are modified on-demand and cannot be filtered by
 	 * userspace.
-- 
2.43.0

