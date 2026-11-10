Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299378;
	b=1g7EQlPS8ue97cg1Fs4koCPzX3gPZCXsHesFnEKDeKaSaOums3J1H7TZu2ZLCST/mOV6
	 NIOr2Ppnr6d5+9phEDz1hI081K0WutG1rc+oazoKCCbSt4wermHbBaKoe1QNgdChQ03LJ
	 PdDjY+b09qN7lEEvPrrQGdMt95It0hdr5nBKD826vSkgrUHByXhoXJpoyXETE2AXSdOZA
	 whSEGTaHe73hdQ4EhquN4oefX+XvGFtYjPbI45zgXMM/5faoO4rJJvbKaBEwrm72iA24M
	 gbihIGX1NeMqrgAGiv9jZ/PJ9o814UCDHmUiWlehhvThg86BTmZy7kwo867oaqyUEYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299378;
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
	bh=P2Q+NEjTGGRtgTYwlU/xRst4WIfCPvlKiJkvZscRWGg=;
	b=wPD6Zp5iMGWJD54mn/L2AljpugMx8WQjHcrwo4mXpuLoPB8W8pu7XmPwhqhtG1AzHnWd
	 2q4ZZl5kP15AQJ4OFssWZHMZxk4InCKxUD08H/OWgDHdjrqvAmCpIB/Tgwwe0okW4OEXY
	 9aEiAGFRiZz/8V8UCQHgj1uVM51lr9myJgPXcjJMWbxUMImTqArMROgsvjqULLJiVRjzS
	 wdkyOYs+ftypkQGZCVLf83e+Gqxk6ShgKtR3MmSA+k827ZE4W607bYcX06iFvSIHns6AM
	 Q18L2dO5kTJRycGFbsgkH8AclEyt5AiEXRt8ojZ7cugRF0xBCeB/ZcyQ41bonbnIJvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Fl4mESu9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.53
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3058060A5BE8;
	Tue, 10 Nov 2026 08:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3058060A5BE8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Fl4mESu9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiKYFWgX8aw7cuvaANF9+A0v74dx8SKURm6fkDMsFsYMKQBKA8O0aAiFwpIAdYjZ5unsuMR5Ko+wrnNrDE0nOSbHbyHWcqO1WktbQsNmDorvT5+Y1Q2Fzc27N5OislQo2V2y0ZR2X8gJ3L2kqRqPRL/P6O1SxxIGk847cp3peTEptnPP5NUVUiOaXT51G27Xs1v1oEvxksVZNIH/amCerPAL/rj+2MPRVbmKQZ9C98q82JdfqWlhD6DF1bXRsqS8zj64PFjMpL3V9+VmdzTwooEKHIabyxRB/okJ8O/tnHE8xyK9F1bocaMm21qW1DXusPueTYCFwpxB68Cn6O/NAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2Q+NEjTGGRtgTYwlU/xRst4WIfCPvlKiJkvZscRWGg=;
 b=vQeIrWR2CPcZJggBwzs/evdRyhBKmgAt5vNBpN5Y8MYgpiifZHLkuKqyP9d5mXVVKY+kmOIF8rU/HRDTtctySwAezUdWL2hcVPwGVrGIo8lP6pt/bv5Rz7M9H/zqvN8RF7JUmarkN0PmlfggnbnWxLRoLDTH2D57BZQeg9Vw3Pik9szhS35wi6cwgnVxlsQgcC2r8Kcs/Jg4h/kMINJOg/wXFbb9GMyEhelCSV03yG8ypD4mRqou4MgEIVwDV7TMXwO6d/UfzMl0zXmMbwbKAnwdWdjUHa1RZ40xbZD5rm4DJyU5HBgne9fgbmcdY9ViKdvWUK4DMPdB+27oCn2R1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2Q+NEjTGGRtgTYwlU/xRst4WIfCPvlKiJkvZscRWGg=;
 b=Fl4mESu9YO0YZVfsJGfWBA/4ixj5s2W1JDWpsryepKnLSM9bEOOzkGj0xx5YAGKBfO58O6yL3ooQWP7LVdECfV0i/e8V6BQdKzYhIGck9hIv1+GRe7Q2elJtFkOsnEu3PPQYuYF2W3BEmY5/uAWCpxZ1I5vOX+7AP0xj5x6oDQU=
Received: from CH2PR12CA0006.namprd12.prod.outlook.com (2603:10b6:610:57::16)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 08:29:31 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com (2603:10b6:610:57::4)
 by CH2PR12CA0006.outlook.office365.com (2603:10b6:610:57::16) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8
 via Frontend Transport; Tue, 10 Nov 2026 08:29:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 10 Nov 2026 08:29:31 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 02:29:30 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, <x86@kernel.org>,
	Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH  2/9] KVM: SVM: Add support for Alternate Injection for the  SEV-SNP #HV doorbell page NAE event
Date: Tue, 10 Nov 2026 08:28:47 +0000
Message-ID: <26f0bd88dfca21d6f4b2e8cf3a34589764fe05be.1794295647.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794295647.git.huibo.wang@amd.com>
References: <cover.1794295647.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 5556ff38-6d0f-44b1-81b2-08df3f04be54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003|6133799003|10067099003|261009223027099003|261102130727099003|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	/Al3N1tAYgrLLc8BO5otinqHpqpUq7rY5rCLGrrr+ve07FQKWoNh/jW+cqdSbJSS8AHMVopvKjezuSBgcSTK9XMrorGnof5tpAgAe7xPqnxryEw+A9wFgZokE/vZoL+g6j0AZfZVDBtZRxwBxR9k6lL+9TZViCgfvlYdKHjnjzdeY/hStq86LAKeyGTPHU6blrHgToCz6GmB3BacYfmoj7aeEDwIyRYmtN3z54d/qY2G4wste1Lp1XS0Aou+isLCX7V5i31+55SFHQROP8xmnLJC98FQL6f6gCbrvS+dUzML3WFpOmIETMr1xAaY6nvl/SOy+ZGgb8ya/qnXmddf5eubZlwE+v3p9oeGT0eM725BKF3MRd6hJ51rZAk7n4HR0aJYB/0gPDCjeDg8L0AOa2/cC0ttsRY7+Z4KxHPUFTJrnwSfrllewhKD3/Q+xl4W3raS65IU887RHV7gUMu93lmf1oIu1f31pjVq3MYCnANzqFRvwiXrOKiO8lwRd/Prq5HK/WddYOOyGMLSsLcmGPLoFM7tH0sWvwsgcVpQ+2hw/lnR56fIss3pcLvbrokpT9uRDqg9SB74E21fa+6lmCoBWdkCECf2/omnfFwgbJvg6bgQRTrR+9yXCUsIAVDinqaOrxPN+cFP3h9zindgbpEKeUZU8hQP+vEHA6x5dl1m6fubGuf8TkCOGDC1Ay+LvSzw9Io6oqkaet+u57J1vw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261102130727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VJDArK6S/3siBy6TUddB4wjRL90mT+iiYilmBjjuCJ4CXjnS1k0dzk3pBZbmY3D+/iqM6WfVZlLgVSPEBjGR42Rj3K5YnolrU0GQojWVP+OYFrswgQVF9vchv7G/WwbO7hyFTK9/Qn0uWppLyPvih2Og/BAI+kvBcG7t2+Evr0ojOhCgKZFyC+BjDvqeNKGeubpAiZzGsq7Kf1B4VZkNRFWzXupBB+naMLnfY+MMtVYu/CM3dFuoUuFvHdDdPwYTsRbvKDwUw/0OCS5vs6/wmK1LQmPoNC7ZxDrLpGHxKA4Ct7AeIpaA2edIoz0fVHMYrJhZqSgr+yJX/wRK/1EDqio726INbNdu9oUDV3HqwwziNGDkNzGS/1hlIKusS2Ia+GWL3bLZRW1Dor0QDWxFfpVSRK6KXyAiYK+CPKrMCQEQ0NsWRFFYlxk9UFf021Z0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:29:31.5094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5556ff38-6d0f-44b1-81b2-08df3f04be54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730

To support Alternate Injection, there are three new NAE
events added in the spec:

1. "configure Injection Notification Vector": configures the interrupt
   vector that will be used by the hypervisor whenever it needs to
   notify the SVSM that the interrupt processing for VMPL1-3 is
   required

2. "Specific EOI" - requests the hypervisor to perform an EOI cycle on
   level-sensitive interrupt, and

3. "Disable Alternate Injection" - requests the hypervisor to disable
   Alternate Injection for a specific VMPL.

Implement the first two.

Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/uapi/asm/svm.h |  2 ++
 arch/x86/kvm/lapic.c            |  3 ++-
 arch/x86/kvm/lapic.h            |  1 +
 arch/x86/kvm/svm/sev.c          | 40 +++++++++++++++++++++++++++++++--
 arch/x86/kvm/svm/svm.h          |  1 +
 5 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 60b7a52f6f7e..786f50f33457 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -127,6 +127,8 @@
 #define SVM_VMGEXIT_AP_VMPL_SHIFT		16
 #define SVM_VMGEXIT_GET_APIC_IDS		0x80000017ull
 #define SVM_VMGEXIT_SNP_RUN_VMPL		0x80000018ull
+#define SVM_VMGEXIT_SNP_CONFIG_INT_INJ		0x8000001bull
+#define SVM_VMGEXIT_SVSM_SPECIFIC_EOI		0x8000001dull
 #define SVM_VMGEXIT_SAVIC			0x8000001aull
 #define SVM_VMGEXIT_SAVIC_REGISTER_GPA		0
 #define SVM_VMGEXIT_SAVIC_UNREGISTER_GPA	1
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index dc7a08831a54..9ebae1052f64 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1543,7 +1543,7 @@ static bool kvm_ioapic_handles_vector(struct kvm_lapic *apic, int vector)
 	return test_bit(vector, apic->vcpu->arch.ioapic_handled_vectors);
 }
 
-static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
+void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
 {
 	int __maybe_unused trigger_mode;
 
@@ -1584,6 +1584,7 @@ static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
 	kvm_ioapic_update_eoi(apic->vcpu, vector, trigger_mode);
 #endif
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_ioapic_send_eoi);
 
 static int apic_set_eoi(struct kvm_lapic *apic)
 {
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index a9ede0e145d9..9d202ef3016b 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -254,6 +254,7 @@ void kvm_lapic_switch_to_hv_timer(struct kvm_vcpu *vcpu);
 void kvm_lapic_expired_hv_timer(struct kvm_vcpu *vcpu);
 bool kvm_lapic_hv_timer_in_use(struct kvm_vcpu *vcpu);
 void kvm_lapic_restart_hv_timer(struct kvm_vcpu *vcpu);
+void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector);
 
 static inline enum lapic_mode kvm_apic_mode(u64 apic_base)
 {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0736e1c778d9..924c1b968fdc 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3432,6 +3432,8 @@ static void sev_es_sync_from_ghcb(struct vcpu_svm *svm)
 	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
 }
 
+#define SVM_SEV_VMPL_MAX        4
+
 static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
@@ -3566,6 +3568,21 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 		if (!sev_snp_guest(vcpu->kvm))
 			goto vmgexit_err;
 		break;
+	case SVM_VMGEXIT_SNP_CONFIG_INT_INJ:
+		if (!sev_snp_guest(vcpu->kvm))
+			goto vmgexit_err;
+		break;
+	case SVM_VMGEXIT_SVSM_SPECIFIC_EOI: {
+		u8 vmpl;
+
+		if (!sev_snp_guest(vcpu->kvm))
+			goto vmgexit_err;
+
+		vmpl = (control->exit_info_1 >> 16) & 0xff;
+		if (vmpl >= SVM_SEV_VMPL_MAX)
+			goto vmgexit_err;
+		break;
+	}
 	default:
 		reason = GHCB_ERR_INVALID_EVENT;
 		goto vmgexit_err;
@@ -4217,8 +4234,6 @@ static unsigned int get_ap_creation_apic_id(struct vcpu_svm *svm)
 	return upper_32_bits(svm->vmcb->control.exit_info_1);
 }
 
-#define SVM_SEV_VMPL_MAX	4
-
 static int sev_snp_ap_creation(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *target_svm = NULL, *svm = to_svm(vcpu);
@@ -4953,6 +4968,27 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		}
 		ret = 1;
 		break;
+	case SVM_VMGEXIT_SNP_CONFIG_INT_INJ:
+		svm->sev_es.hvdb_ai_vector = svm->vmcb->control.exit_info_1 & 0xff;
+		ret = 1;
+		break;
+	case SVM_VMGEXIT_SVSM_SPECIFIC_EOI: {
+		struct kvm_plane *target_plane;
+		struct kvm_vcpu *target_vcpu;
+		u8 vmpl = array_index_nospec((control->exit_info_1 >> 16) & 0xff,
+					       SVM_SEV_VMPL_MAX);
+		int vector = control->exit_info_1 & 0xff;
+
+		target_plane = vcpu->kvm->planes[vmpl];
+
+		if (target_plane) {
+			target_vcpu = plane_get_vcpu_by_id(target_plane, vcpu->vcpu_id);
+			if (target_vcpu)
+				kvm_ioapic_send_eoi(target_vcpu->arch.apic, vector);
+		}
+		ret = 1;
+		break;
+	}
 	case SVM_VMGEXIT_GET_APIC_IDS:
 		sev_get_apic_ids(svm);
 		ret = 1;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 7aba2cceb44d..d2e397542a84 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -287,6 +287,7 @@ struct vcpu_sev_es_state {
 	bool snp_has_guest_vmsa;
 
 	gpa_t hvdb_gpa;
+	u8 hvdb_ai_vector;
 };
 
 struct vcpu_svm {
-- 
2.43.0

