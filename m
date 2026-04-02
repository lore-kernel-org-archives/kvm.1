Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F8338423B;
	Thu,  2 Apr 2026 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155461; cv=fail; b=bOw/CveSilB1puPTq6pX5CUGy/HujBI3yMvLiDNkDuqapv9NQbg3W8zCBrKya0aIm5aZgJSAwtSP85X+zhjzhtmB1XT2aGC8j11URUTW+2ZMvABB53LmbhkcR89M6X2Prgb4gwP9tM3W2c2IoSdqJp3Vdc0L+YT2UNc/f7rTWC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155461; c=relaxed/simple;
	bh=ttlbXiz7Q9+Ofk4/b7x9ODSwZ+kRLnq64iF6+EDJRtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mom1r0mBgS9og97JrVa638P5RrmuajtLZiOs3ZYXpoOvyCNwgsoaEuwsdSoE/sFbUvjU8Vmi520i0hs2tefnJJkOO0R9mZqJPm/PwD7cDHt799e+S46W/K/h3lov1DttyrnT2lfVxhQPCMj5BpLQ8DGyk2iRjvulr7caQ+D9Tdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XREWjcXa; arc=fail smtp.client-ip=52.101.52.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XREWjcXa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsz9YR4GSxnbaTxswqcaIngmVMoPML9Gl9LZlgacpsnDxa9lwurDeQJ6FTwBmr4+yDJqAFrBn+otUgI76odzgwH3SYebFQuXRuBbgv7zJR00tisphFP0pOJ01H1lhGjSjL1+vBXH6arhuG0iuxr385blXh9gOlUs5pRCAr8FXZCzecfWTzqok18G8mk29r/KZxPjTwS57oeVI4KAkBY+ZLfcTtZxTFwFQQeys++vmpF7v45DN24LFbRv+M40L466yGGHVnFOZOFM5J6hDKbr0Da1Cvx2jCojxb/T1QGt7EkkXAqFb8yFJznx9c4CLDFf5E7g2vvZoXocarseSLzvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pHAxWC+0/Smdk24hnBKFK9DeNMCRQLvkrTUASW3dqs=;
 b=VDZwkdcBDaxDDq7ZpcafNwAQl5j6+g5fhelEBTysQndtkZi/fZeiySn+I5490dHKpvt8KFPpOmy7Liy7+byc2ulL9XiWN9HEsSLdz0KVGZSF7D+z1DolGW5OxJCUaPCq/A4J3PBRCu1SE+0O1ubs/axtvb1Hi9/H1UZro2Zc9A+8voaOv0Ss3oC1C4GZc9gKAlDHp8NWj37hpOKrM7CEJPRZpQJ3Lsy/rzW5881zcrebT3Yl3/IiVpXP+SD4HuhDgoiQ8r2F9Bsr/H31jY3j5VNERaMScwYiRjSyLMkk/HX1VVVcQpv5AljZSIaD/DlXNJ4zLcmsEfDwOlw4lCPJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pHAxWC+0/Smdk24hnBKFK9DeNMCRQLvkrTUASW3dqs=;
 b=XREWjcXaSCcKivl3aDYFq7B3GKulC17ld50qEyoo61atSbAJObjQZ2hea6Y0zF43Z/etDkS5qHcS0tLQ+vANy8f96uI21jqVImtCFfF9oAlGwmINH/QiM0FYqGQum33bWEUhUJhQE0I7/ckB4I1Gdo6vig9D4aN0h9GEqeSL3ps=
Received: from BN0PR04CA0099.namprd04.prod.outlook.com (2603:10b6:408:ec::14)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 18:44:14 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::78) by BN0PR04CA0099.outlook.office365.com
 (2603:10b6:408:ec::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 18:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:44:13 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:44:10 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 4/7] KVM: SVM: Populate FRED event data on event injection
Date: Thu, 2 Apr 2026 18:42:37 +0000
Message-ID: <20260402184240.1939480-5-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: f3965e08-7746-419d-91a2-08de90e7d63b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	z+aHkMkSMtraJvrn9RgP+BIrWaTdsvTbfsON9IukmdxgoJCxGd96qRY7BJ9e87zHUqZ6P059aGRwvxEV4RGIYlRqiBk8w61afEDyLXbDc2zL3jgxJjydhrjb/i5yltpOUicLRwdAyVto3f+oLqLWr6g7Arfw+rdZneh4Av7/omf1Mu+ASj0MOLZ2GTVF9nBHrquOKDhaMMiPZHlwo206t5llAyaLPU2yNodTFMQT9zVs3P1UBt4inlTOBXlaVMbpFWB1Buy7nK4hBHMHrrQqL3G3g3+88wJtTuH0NMt+YZi6Dii9VlF6/RIwyZSYBJeLKRAA2HV4pC0HRTX4NzWTgdyoe2TwMzbtvggJvl1DY09B/5FBI6HauXaiROp4m91LGkwvJsXoFi6fzZ8rX1msOZAXOSW5Modzvb+ijvY10xHGpIsVt2glqMtpdCNL1LpjUe0gzwv13L1itbU7s/U4+n//VUJcTAN/QG7MsYdrhtu/fnetxs15t7DYxDMmhoe1j8dQWkgFAlBQh1SbVioPvtiWA1maxTG9GT592Es9cZKsH2NuCVaw2ooyVRJSuAs7V0wGxLEP/dZ2Kqa5MmeMJSUnTA6LAf0X7LLudX7fe0fB9gYcuq+cU2NhIt95+p3Cl1jN3T1U4DZohhPT0EULzIMoiy0qBpNI+H7H3tLOjdSnLqRhizrco51hH8J6UjyWfVL0qD/Tk9RdOi/rqqwKxlMgBlmv/BHzOd5IV9E1xoS19Eq3KNa6VeszdKJmSX1e+hkvEyfwW0Rb4lLxnwXhWA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JkTr/E61nTNSZ4ObDvgaEBJxYfecaXicQWxO+AsfhT85DT7lF2yOopyWs2t1n8M3/JrC8si8zZ2kNSR/jgeHGqjoCT2NGu9mPaP+3T0iJO9tfCldeb4kmgKmEDWup/pt5dRwMNIwtuQdMpjvmzY6UR2d3Lbt/Ld35sIli6PJH5Gjtqlk1yUGVAzI+5CRuA/54o7r+WL2hMbn/WzLfnveBzYeRZhf8tziLC60/BJFxawnEONPHMw410FHz1eDOO7i9SdFP88gTtTUFmR3KIgLt1exQT/BjC6yVc6ITr5dLuV3dC3UIcswH3y16xntRpkyvG3zVzWVRp+E7sMXE2IsFY2f0kLRpELorekyAOf2txBHuV47x8GrsWgkU5qHzBNZ1+cELr14gAJ1Tssznip8ij/MXmj2bl+gzQGHImkgZf5sQYT0wafwpGVeLVAtAp1s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:44:13.8823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3965e08-7746-419d-91a2-08de90e7d63b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

Set injected-event data (in EVENTINJDATA) when injecting an event,
use EXITINTDATA for populating the injected-event data during
reinjection.

Unlike IDT using some extra CPU register as part of an event
context, e.g., %cr2 for #PF, FRED saves a complete event context
in its stack frame, e.g., FRED saves the faulting linear address
of a #PF into the event data field defined in its stack frame.

Populate the EVENTINJDATA during event injection. The event data
will be pushed into a FRED stack frame for VM entries that inject
an event using FRED event delivery.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Co-developed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
- Removed the need for a new function parameter 'reinject_on_vmexit' in 
  svm_complete_interrupts() (Paolo Bonzini).

---
 arch/x86/kvm/svm/svm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3f7f8fb0dfac..2da493f9dd8b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -374,6 +374,10 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
 		| SVM_EVTINJ_VALID
 		| (ex->has_error_code ? SVM_EVTINJ_VALID_ERR : 0)
 		| SVM_EVTINJ_TYPE_EXEPT;
+
+	if (is_fred_enabled(vcpu))
+		svm->vmcb->control.event_inj_data = ex->event_data;
+
 	svm->vmcb->control.event_inj_err = ex->error_code;
 }
 
@@ -4134,6 +4138,7 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 		break;
 	case SVM_EXITINTINFO_TYPE_EXEPT: {
 		u32 error_code = 0;
+		u64 event_data = 0;
 
 		/*
 		 * Never re-inject a #VC exception.
@@ -4144,9 +4149,16 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 		if (exitintinfo & SVM_EXITINTINFO_VALID_ERR)
 			error_code = svm->vmcb->control.exit_int_info_err;
 
+		/*
+		 * FRED requires an additional field to pass injected-event
+		 * data to the guest.
+		 */
+		if (is_fred_enabled(vcpu) && (vector == PF_VECTOR || vector == DB_VECTOR))
+			event_data = svm->vmcb->control.exit_int_data;
+
 		kvm_requeue_exception(vcpu, vector,
 				      exitintinfo & SVM_EXITINTINFO_VALID_ERR,
-				      error_code, false, 0);
+				      error_code, false, event_data);
 		break;
 	}
 	case SVM_EXITINTINFO_TYPE_INTR:
@@ -4168,6 +4180,7 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 
 	control->exit_int_info = control->event_inj;
 	control->exit_int_info_err = control->event_inj_err;
+	control->exit_int_data = control->event_inj_data;
 	control->event_inj = 0;
 	svm_complete_interrupts(vcpu);
 }
-- 
2.43.0

