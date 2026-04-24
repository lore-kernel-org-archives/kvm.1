Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010009.outbound.protection.outlook.com [52.101.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687A3D8102;
	Fri, 24 Apr 2026 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053036; cv=fail; b=ouAnwk2kfHhjmT9KbvOhuKLpDkOSxo/dBsykrVpJ89nMXkVZY8MBu0DwAMbQPACt2SG/GDp+1H6+B7+S09FCxvMobIR0SLn8gD+H0pLa8OCWb7WG3pJe6LETjQW5rozrpM2Q5TGmvGIiYAzNyVoI3+E9s1R8v/VnQe/tqAd1GXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053036; c=relaxed/simple;
	bh=FaGokt2CTOtTnEi7XHoJPeF80XY8S6DcWXewafWuE4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RO8TG7LMY0ouMCEf+jjE2H/MAdt53Z2sXfeIVbpB5tvtcGjVEedDY/iPl/Juk3pzEiWPNm6gc681t0zvGGuVQs6e4J4Ve5Y5jeZ/026hrWdnj5aC/MfMRC1vWIJyhTH3g6RbRnmMAnRObpb/ohShje6bxc7NFQtUu1uA8NZkjso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=twUj5jHP; arc=fail smtp.client-ip=52.101.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="twUj5jHP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEfSkAHgm2sC0gd1lNw8qGncCbkwcOeQv5JzG4SQhqgV+DDNJZZI4OKeGHRdU0rqgb51aSwpQ+3DE4WFMxHDLTmF1/yGVu9draV9ukwEU63vE6v2QZZRk3ohhGmSg47JSKzseiSRRWdxica1loOcKiRqk4SObVCMOmS/4rhXELIjJvs2tRFwvgvgH+V79UoJkogwgqyi2Vb2nL4YBZd7nW115y+UcRxtG99zwa8blyR+ItYglEAWTCPlX08gkjipZ09xmMk2rA+MLmhRuaF2rF4it08bBmDH0EtYOMHW0+YXETyVeF/qv5LQ5hHvTQqgy6mg08eesO+VjCje5yEyOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UN+Z3tjmhW4SDPKdoAq7Zk3yURH1g2wrAiCHAjEkKxk=;
 b=uBo+sAEkgHh6ZufJsA40eQj3xY4FFnxsErApk6i9SCIwRkxrQFmRcyXVShzxpRamEDw3lz44L+7L5M0GIh25exia83EbHhYUgaCI/UlwJvMWMaybJ4v1FIms+JdAuZudIevH+2Fr6fLL7QN6lZyPGHY6gPPhWslM1/HpY8pNqmydQoJ08H5bRRZ2nSq2aOT643qICVV/qtkYZ4KlkvC/XbWDP4z/1ZuKHvZNE1ilm+/0VoklCHghQItebiBhvY8+niymldHi4JFxBhYLUx2Lptfb7sFBHxhXK34nLmrDBBXeVyz10PclbknOFnV+9NnPFpFD/tOXeq9ZYOSMSUi8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN+Z3tjmhW4SDPKdoAq7Zk3yURH1g2wrAiCHAjEkKxk=;
 b=twUj5jHP5uSPiJZ2rQAXBDL/cv9W30U/SVLR3I5/OInB7sigDVSbVWRl7uWvCp0C4Jd0fXSXaeCTkxEx+dLMRSpkU7EuuPnthjzBlU6ve9oXLwsLqffxT9F6yOA0bL94vozI/weTEMVo2LgISKHpg0HcxCEAr9axR2pesepbjas=
Received: from SA0PR11CA0207.namprd11.prod.outlook.com (2603:10b6:806:1bc::32)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 17:50:27 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::f1) by SA0PR11CA0207.outlook.office365.com
 (2603:10b6:806:1bc::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 17:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 17:50:26 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 12:50:25 -0500
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Joerg Rodel <joro@8bytes.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, <kvm@vger.kernel.org>, Melody Wang
	<huibo.wang@amd.com>
Subject: [PATCH 6/7] KVM: SVM: Add support for the SEV-SNP #HV IPI NAE event
Date: Fri, 24 Apr 2026 17:50:07 +0000
Message-ID: <20260424175007.4057-1-huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777048608.git.huibo.wang@amd.com>
References: <cover.1777048608.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a48fb9d-e229-45c2-aa6c-08dea229f787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GDlVdhKpTaiAqzLknRF6blI0/L8ueF0uhPGOB2Jf5Ld+QhqwA0FLvoZBU8qUVafnZq9+aqLUCyeYylPI5a6h53lm1oFNxZh+zyi6WQswKMGtek9KshFdCffS/l6MLjv7AHJlXH0s/ft+wbDYWbOhc+ijJvbgazHsGV+TLErOX1wazdAmcye09QVQDGvaSD6YZ6ablac7WZEbXUFinSXHu6/bA5DIqsL8U9Kmn4CEp/Q11FHcgQl9K2O+HzLeKaHw64Sd8b74Pv+Ny9z1gsoGq5f+awtKSQxnL/68d/qwMlpvqMfH4GRfRoDsvNlcIymEtBH8D+X+oY8mmblZA7o8E+yB4fMhZRJPpu/qLKc7eKw6h+gJRyX0dEyOg6VT37V3U8ufnI0IRGZj3sxEN0qzSMnqROaXJL+q6g+sj/05HAxknuUI0qwLiBtrPGgEE07/+2ORE7FXxhKsxcexKoSaO4VtEPyWejdxKClItcbCZZNNWsFnnGYVxAA/vyB2O9VCv4B/RMBptpPG92n0vK7NgiYQ5dPmMtkB5igO9zAiw2waREgsKeypeL5WXmPD0N74TNPH9F2uqQJWcbbaJszSP4jmT5H72g3M3ar9LsdK2nuHWM3yixNMIbseOmj8h1zvO1jC9XOs99cgHQ/W7EW1TR3A4K8RBBKX/fGlMla243/lhN3wbtcNJKBP5WMt2gvqhSdVCwoGEXRK0m9XF+hQzReVr6yT8dIq7DBJyk7lBJ0nHchbkz97AE0JpUuMiGUBX2nyt3o3Oy+5ovxVI/50JQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jE1Ju4mvNXohp/wrJ0dz+W4aDCWk0SLsrRcVyaS8LgsGGzNO6W8seX7wpCgaR3MfDPONzRjtd2gIFzi49W6xEJt1LPXqxGdH9JN7laeUmcgH3tnXBYeWUdwgAwL9TA26YQvq7ofBi3WKuACJOB6KuoHWXV+vTiQmE/SPHn4EqYuAlkU2X8aYGk9oe5j8dTjJGr7K18IwXrhTlfIqcjwQ06rqDRFAJlqr+v3ZC7NoI1+0NgiHOlSy+4jRP4M23B5WgP6ObLyDu7t0NtxRZG6Hq/cDVJQ54BJCLgGxTw/CbYjnE/DFkEWU4tM93Dkrbe6j4Oea/NpjevkLmtmXWlpduvEiYE67n4anW2iJzUvwJaYW6OwlwW7dkCumd9YJI7jNXTdZcjzaA6cAU1o/QKGWomY9N3ibwBKCM1rgx4XLwJLSW2Q1SBzKPCD3ROVsaeZU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 17:50:26.2759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a48fb9d-e229-45c2-aa6c-08dea229f787
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375

The #HV IPI NAE event allows the guest to send an IPI to other vCPUs in
the guest when Restricted Injection is enabled. Implement the NAE event
as per GHCB specification.

Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/uapi/asm/svm.h |  1 +
 arch/x86/kvm/lapic.c            | 24 +++++++++++++++++++++++-
 arch/x86/kvm/lapic.h            |  2 ++
 arch/x86/kvm/svm/sev.c          | 26 ++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 1 deletion(-)

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
index e3ec4d8607c1..9601d960824f 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2556,7 +2556,7 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 static int apic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
 			    gpa_t address, int len, const void *data)
 {
-	struct kvm_lapic *apic = to_lapic(this);
+	struct kvm_lapic *apic = this ? to_lapic(this) : vcpu->arch.apic;
 	unsigned int offset = address - apic->base_address;
 	u32 val;
 
@@ -3581,3 +3581,25 @@ void kvm_lapic_exit(void)
 	static_key_deferred_flush(&apic_sw_disabled);
 	WARN_ON(static_branch_unlikely(&apic_sw_disabled.key));
 }
+
+/* Send IPI by writing ICR with MSR write when X2APIC enabled, with mmio write when XAPIC enabled */
+int kvm_xapic_x2apic_send_ipi(struct kvm_vcpu *vcpu, u64 data)
+{
+	u32 icr_msr_addr = APIC_BASE_MSR + (APIC_ICR >> 4);
+	struct kvm_lapic *apic = vcpu->arch.apic;
+	gpa_t gpa = apic->base_address + APIC_ICR;
+
+	if (!kvm_lapic_enabled(vcpu))
+		return 1;
+
+	if (vcpu->arch.apic_base & X2APIC_ENABLE) {
+		if (!kvm_x2apic_msr_write(vcpu, icr_msr_addr, data))
+			return 0;
+	} else {
+		if (!apic_mmio_write(vcpu, NULL, gpa, 4, &data))
+			return 0;
+	}
+
+	return 1;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_xapic_x2apic_send_ipi);
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 274885af4ebc..afd440c88981 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -156,6 +156,8 @@ int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
 int kvm_lapic_set_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len);
 void kvm_lapic_exit(void);
 
+int kvm_xapic_x2apic_send_ipi(struct kvm_vcpu *vcpu, u64 data);
+
 u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic);
 
 static inline void kvm_lapic_set_irr(int vec, struct kvm_lapic *apic)
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 2483357bdd97..95ee199e38fb 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -35,6 +35,7 @@
 #include "svm_ops.h"
 #include "cpuid.h"
 #include "trace.h"
+#include "lapic.h"
 
 #define GHCB_VERSION_MAX	2ULL
 #define GHCB_VERSION_MIN	1ULL
@@ -3554,6 +3555,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 			goto vmgexit_err;
 		break;
 	case SVM_VMGEXIT_HVDB_PAGE:
+	case SVM_VMGEXIT_HV_IPI:
 		if (!is_sev_snp_guest(vcpu))
 			goto vmgexit_err;
 		break;
@@ -4362,6 +4364,22 @@ static int sev_snp_hv_doorbell_page(struct vcpu_svm *svm)
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
@@ -4635,6 +4653,14 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 			ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_INPUT);
 		}
 
+		ret = 1;
+		break;
+	case SVM_VMGEXIT_HV_IPI:
+		if (sev_snp_hv_ipi(svm)) {
+			ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, 2);
+			ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_INPUT);
+		}
+
 		ret = 1;
 		break;
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
-- 
2.43.0

