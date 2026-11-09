Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794194426;
	b=ROhHHbdQDI9+QB5GAywRJ3nQEABDe+k8mbExI/rlLdKoGexMLFAS04wkBMf73ajUpx62
	 5jwMMMWn3a4Ke+4hm539NFvyOxeJEE+QUEHVOYCucSofBYVVYcq4AbfAHD84f4Rez94WC
	 jzMlHTI1bys4kEZnQYp672msxP2cKNntQ4d0CcqLxGvImXKA040CMHKe5fD0OCBRN0fN0
	 XKq/iXdKhotHqrsWYLhJfOTwq1EwfAyfl6oA71sXJIAOQPKFWme172bRTzbOLItn3C/mM
	 TN0RIUUjNvXSTUkGlBByVDW2FwZZAvVqqdKqtRR0Rf0aKOou3BiWbO61oQommc+g2xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194426;
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
	bh=vBaVdiSUvvQzVb4HWYaHiIK4SjFwsDSyuAqJzCs5gks=;
	b=kH9ICk+kYVUvq4yf5fNf7k9N+IbeiP+k0aXV9BTsDRPYSWC9BG468MLoHU21X1+Fsv3x
	 whtAMGaA7mPHrE9SpXPvTneT9wJ+NNlZNwMlnw3ifMffJYvVAiChKuZJSQyw7C0PFkwcX
	 VfU/33LNCYGUYqbSvQp5+pXVwDCL8EKDdz0hP0JAuvjlunx8hGnivFIQRKKoVmnlh4vZ+
	 eNqRGaD+/Mdo2iijhFhrhDf/oGMVFvNee7uornuAtT5E4FAohOdo5LWlLO2/ougdylmpF
	 Mpca0HjQQMQyw59611+zFn6jWBxBE7EcO6PPRYq3dEjyR8qZtILdGj37+v8usP2QAiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=19A3B2X5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.12
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E1606A326;
	Mon,  9 Nov 2026 03:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C76E1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=19A3B2X5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C42B3gs1ZaBUgw3Hjms04RZR+jvix8YqoMqWqKuhr8xPuOqutTcANMDs3SnwKRzsH9gyKcmgAcEKe2bEH697AFt+lozRyBUKSeSR4EvUNgnqfCLqbtCZRS2vTIagt6oy+kJP3CPy3NrGpOqfeqxXy3vLAVSTJiMNGpL1GOVgLgq22ANT5zp3PagdGI766hGlv9SMZScGjDJtFKAIEA5ccmKkNxLtBh22WNQiLwCNR9KC44ro6I2GahlBWHuLEwP5U/uD5RldHwl8kjoNqdyWKon+cpdJyK/hK0U9U0uARbnZP+NGddUlHAeB8S5NhoCLhoa9YtflJw6K7451XkScfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBaVdiSUvvQzVb4HWYaHiIK4SjFwsDSyuAqJzCs5gks=;
 b=qs8BBw8tXCznlJaNnrWmfJ/IaOBUpU5Ox+HxDMsqS6N6S6SAtSG9lf1wg6UjFZGtLF6eJonuJb/Tmi6wagfAqV3ijpbQkhOjVSAartzj5HgcPc+UXS9sIWCXGIlXZRzUcy3pyHrhGFVV6w6iKEXj9ICk0QJ4iHBMt8IPnSy798mLWY+sYtaVYuwmNkxvJV6hbF5KAv9nYFnAjWi5OA05PyjbaoKVgiYJ7qgfIGeaWX7npunMN+uLbyES2Vq3Doc34uVQaKtq8pcz5V/lpjki3cO+y0AezhhMcZMb5qMKQwWENI52C0Q/q1ryIdt0tEJKYnKh5j+h7o/8mpm8vnfNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBaVdiSUvvQzVb4HWYaHiIK4SjFwsDSyuAqJzCs5gks=;
 b=19A3B2X53g9MKQnAkGsQMPA0iN5pTgyqKnGdo57kw8MKbKYuutDUUt3nzpiF0Q6rhUNCpoHymt7KgFO3CpJiNqnjx0IIS2LOQxp03gVTsC0YPwj/s7F9Cyv7peWPqvQE2KsWvNj0U6lGf7Fv1/5xbe+TO/A8O8vUk/PHnJIAqn0=
Received: from CH2PR02CA0023.namprd02.prod.outlook.com (2603:10b6:610:4e::33)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 03:20:21 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::46) by CH2PR02CA0023.outlook.office365.com
 (2603:10b6:610:4e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 03:20:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 03:20:20 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 8 Nov
 2026 21:20:20 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, <x86@kernel.org>, Melody Wang <huibo.wang@amd.com>,
	"Thomas Lendacky" <thomas.lendacky@amd.com>
Subject: [RFC PATCH v5 7/8] KVM: SVM: Add support for the SEV-SNP #HV IPI NAE event
Date: Mon, 9 Nov 2026 03:18:39 +0000
Message-ID: <84d844c08a9f09a2ea1a44df7d36fe0b21324a69.1794171754.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794171754.git.huibo.wang@amd.com>
References: <cover.1794171754.git.huibo.wang@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: b31b9e89-d539-4df9-3b57-08df3e1062ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|11063799006|56012099006|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261102130727099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1iI8K+cJsQLFDu7pBp8Tz2vv+GHtnb9DDmTw2pe5Dd3aKupgIjb74hQEavgPAY0nL1gv1nHGdHycurKCLqExCZHZiyLKBZUEYmVZsJFB3MK9feyqWchZa7PWMJ+bZMvAhxZD+axI5JG8x2J3oC5lUaIZDvP1hIIMoLc4YKO0bTtkY97TT/mfePP1YM+O2KgpRR2fb9Uby9MC+Kli83GCMVdzVARflNETJ605UNc2kSCEVPKEbbaGZ20Sryvp5b7fV7g6DrCuzcMJOnymNi/9Uu+bQBj/ANfbndFTUQ/R3ywaGrUMmdZ3JLMU6uhQQXHTJrNbmUKC5qIp4bikhlZqmKX0PWYK1rJPy7pqx/V3O2OB5S6Gf4sAllnBz7gXtWlC8IUTWU4el+87u4yqHrp6JwlTSh2OYOfQNUdklD3uMHNG67p5z1S8LGuav6Jzp0AxCjns6NPXQxnk0wsJbGL2u1PvGqrG2WYZKvZf/gTxJjJWXc3F7oHGW0zu+rsPiqDG+l3ksPb4fSX2qD6luoKrMjza7AV07ewvROAZlRb7Set6+8CrtVaRsrxo7iuhQ8XMGHXqTUDGelkGVWDaUXK2M1PWYLXYFhih6raiTA2beYi4ODrwdcq+S9ofgKx/Ay+GzgE2Lc6+vbcQ/k8XCQvnUSfXP+tPBmHhbPoj9hBLKuwnWxsGnGjwPIYP3ic0Fz33luxhH9sft3rc9dqjK6ZvZg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261102130727099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YNaxYB7K7NvtjgcNiyeAV2LBBLBUkJJo66XbvdkKIc2TELcuXl4EkGijXDiDXFbVx3ABes7k6pPrYVzymf8hJViiTKrhYfiZ+V4YkbLi6VqWvrUdudlA3tPGZlrobL6/XUeddNFtvrvcWllQ+CKquzOJ1PPdgRamCrtJyi2dYxBwgTXatY8Wl2I9/prOsmTkUmkkfJvRdG2/7mve6l6es0WhLhiQwqfwfHiDsu9PMhmnqqHPcb8SPWb9Asr+XSpr6idoKBQYWdPW6tnWl8YzRxjYgIF7i3JGz/c35ebPgco7UaxY0haLmCVU16tHntYZyyLfIZVtHAYv1CIeRYYWbhTKJKaRk6OUqyYjTUdMsG+o5obnzrzgEJiQaCGwVKQM64/1xqFRK4FJq7zNbB/xt8iouVwxPgfzPYImFjHt6CpjmcHNEdLbrGZ/OWoFDgh/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 03:20:20.7285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31b9e89-d539-4df9-3b57-08df3e1062ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654

The #HV IPI NAE event allows the guest to send an IPI to other vCPUs in
the guest when Restricted Injection is enabled. Implement the NAE event
as per GHCB specification.

Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/uapi/asm/svm.h |  1 +
 arch/x86/kvm/lapic.c            | 12 ++++++++++++
 arch/x86/kvm/lapic.h            |  2 ++
 arch/x86/kvm/svm/sev.c          | 21 +++++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index d84a13ac4627..1c0165e9db16 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -122,6 +122,7 @@
 #define SVM_VMGEXIT_HVDB_SET			1
 #define SVM_VMGEXIT_HVDB_QUERY			2
 #define SVM_VMGEXIT_HVDB_CLEAR			3
+#define SVM_VMGEXIT_HV_IPI			0x80000015ull
 #define SVM_VMGEXIT_SNP_RUN_VMPL		0x80000018ull
 #define SVM_VMGEXIT_SAVIC			0x8000001aull
 #define SVM_VMGEXIT_SAVIC_REGISTER_GPA		0
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 037a4599d6f1..3a83bdd13b5a 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -3673,3 +3673,15 @@ void kvm_lapic_exit(void)
 	static_key_deferred_flush(&apic_sw_disabled);
 	WARN_ON(static_branch_unlikely(&apic_sw_disabled.key));
 }
+
+int kvm_xapic_x2apic_send_ipi(struct kvm_vcpu *vcpu, u64 data)
+{
+	struct kvm_lapic *apic = vcpu->arch.apic;
+
+	if (!kvm_lapic_enabled(vcpu))
+		return 1;
+
+	kvm_apic_send_ipi(apic, (u32)data, (u32)(data >> 32));
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_xapic_x2apic_send_ipi);
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 8530a6333bdd..e5e6730bfcca 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -194,6 +194,8 @@ int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
 int kvm_lapic_set_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len);
 void kvm_lapic_exit(void);
 
+int kvm_xapic_x2apic_send_ipi(struct kvm_vcpu *vcpu, u64 data);
+
 u64 kvm_x2apic_disable_read_intercept_reg_mask(struct kvm_vcpu *vcpu);
 
 static inline void kvm_lapic_set_irr(int vec, struct kvm_lapic *apic)
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 9aafa6167ae6..b7c2993f8c63 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4414,6 +4414,22 @@ static int sev_snp_hv_doorbell_page(struct vcpu_svm *svm)
 	return 0;
 }
 
+static int sev_snp_hv_ipi(struct vcpu_svm *svm)
+{
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	u64 icr_info;
+
+	if (!is_sev_snp_guest(vcpu))
+		return -EINVAL;
+
+	icr_info = svm->vmcb->control.exit_info_1;
+
+	if (kvm_xapic_x2apic_send_ipi(vcpu, icr_info))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
@@ -4566,6 +4582,7 @@ static bool is_snp_only_vmgexit(u64 exit_code)
 	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
 	case SVM_VMGEXIT_PSC:
 	case SVM_VMGEXIT_HVDB_PAGE:
+	case SVM_VMGEXIT_HV_IPI:
 		return true;
 	default:
 		return false;
@@ -4754,6 +4771,10 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
 
 		return 1;
+	case SVM_VMGEXIT_HV_IPI:
+		if (sev_snp_hv_ipi(svm))
+			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+		return 1;
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 		/*
 		 * Note, the _guest_ is reporting an unsupported #VC, i.e. this
-- 
2.43.0

