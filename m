Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B36B23FC41;
	Fri, 24 Apr 2026 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052612; cv=fail; b=qAQ9sJPkKzETSt5UdAkuuFgZUBhoXBWmBRLRRygb5OOBB5lE6aW2lp1hgudmcAXiY60oBVtawDl3cQgLz6n6ZsWKSqCB5x9XmFHgGYzrzCf2LnlBb4S5UTyzcSVkOlgo+45IYyucqHRhl3FWIBwkAqTxzhdl3x3FhM9hvPJhyMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052612; c=relaxed/simple;
	bh=9mtZ41fuecLxhDpswCp20fQf3pTxIlNvje5R7Ixe08I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLmJuBbXS0tSzxBSLFR+MqmEfYELklBWQPqKKl+MS+rsMc020LZUsLtOayJwg3VeRMWgcqP8KdvNaQEcUjmHAdCedNYfm0Xuq9EklMnLXC6znAc47wMYblXHKfps0kfNgxrlv/KPeowNy9VG3y8eszine1juCC4iASerXg/3EMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d0tY/Byv; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d0tY/Byv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2eWOTjbO7eg+PgqGgFA6+c8KGqW0CglLeEOvRi+ALKFRokRbuv8TSjfU9LJbJKJ82NR7UVKfo3SBwqS7TtHj8AiokStykb7jjrzGkekZAAKkxfahqyQWU7mdzzNBkFwrZ8N9mtkHkJ78Ic0gUMbv4JX5mjx+5CuSdCiff6o0Hle8GLKih+cwYT2788soPuAiRR+nK49U2kh9YwxTfiNpV1MCV0qUTxXvE7o9lwfvEQmOzlWkrUah8yY5Ky4vII+ccj+brPdzJVzd/b38sMjfmNjkpz1iWMBhdU6KPDZD0xZryr6Qs88T1/5o8393jR/7CpKqYdzjlU2dWEqYofKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVFe7TZv+2UVL8gLu4MZJJqxaBqtrG100wkz26pyWy8=;
 b=aRtAkIkVs2lqkTJbccn7r8TUKqXAJr/DhaXlYt99IEgPxbns7scEbdJHyfyhBprcM04dZqbYnS9SskICThJLPuwJgi7dMIbtBPvTjdeEzpimqjUQFa31WO4s7UQUuzBmHnEwUS11FZHvtSOxwI+x12CxFausg7OVqwUKT//quNIAb6LYBCERTc4VEveoRIWdmxmAhH4yHRVlOdRZuOGxGn0XG8IO0UNdWFHDIjb19GOwBjCLLXyvdkYEMraF00rFvDV1zsflpNFI7hlPSWkgcnRGzF40ycwsZ8PNHOIqzVacMAnT9qaL3zU1Zf9RenOKLDgJR1vbjs90U8bR71IKgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVFe7TZv+2UVL8gLu4MZJJqxaBqtrG100wkz26pyWy8=;
 b=d0tY/Byvezp1s5OWnyeQLNJiSkgWZ/x/ipC3tQ02jrCDOTKG/JVeqTOH2nbdRi/dG41AKf635CwgsPOkEBJZZpDOK/k/AKIqUi5EFozrXkUjMqCE8YzRv8cRbhpujlxvnciM7e7WX9WHEg+DRRFHzQodeYLG/WeWmlS6ZYV5uM4=
Received: from BL1PR13CA0083.namprd13.prod.outlook.com (2603:10b6:208:2b8::28)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 17:43:26 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::10) by BL1PR13CA0083.outlook.office365.com
 (2603:10b6:208:2b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 17:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 17:43:25 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 12:43:23 -0500
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Joerg Rodel <joro@8bytes.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, <kvm@vger.kernel.org>, Melody Wang
	<huibo.wang@amd.com>
Subject: [PATCH v4 2/7] KVM: SVM: Add support for the SEV-SNP #HV doorbell page NAE event
Date: Fri, 24 Apr 2026 17:42:06 +0000
Message-ID: <eb5166a6cd0d301b879d6d7b3c728495dac38280.1777048608.git.huibo.wang@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 257f1b92-320a-4ac8-f3f5-08dea228fcf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RhfPcNUlsAKqAYdZo3XprGJ11LgRM33QOhASX5Xxhh+gbhnSlU/clO3JEzQJsphrEuuTxhK1JHwPoUeU81TPOKFtHNXfmbOtosXYXFWqWLnVkdvROD2N97pwkuWXRAiipb4XxXxwjexXk2NFodafAs0j91BxNW7lzeeiQSx7jFczQTMW94uDeqfF/dJWIcW9qU3NS6jdjL8roPmLHvwQaDX6xCBBpZ1QAGu5izZCoWzKyH7Np445pphbgPWYwFrg5ykKMZoFFWH4ABozjQEQi4AzgDye4UlAB5Y2HWo1CSVmWWWMQGO7moZLjm9Za75vtVnaV9tuq1IIHWnQQ2gxEfBZE0LKF/q+SfbsxLi4+IT0FTNCu1YZ0hPlmRu4zw80BD9U7PSutqL47H1W7IjyevUkSrTi9glrq45dFiskTeJ9J7y5H/JkjtefPjmdHN1eE6TnKCBt4pFSCNrxyOZosMnDwrjGV7BXtapU6LDhTNxRelcsfrHN8AsA5EBszCKBFQ+Pd48inEqmpamyGlKUPgDZd5rw8Y0/7q3ySNxbToO0gijOU9aToLPn7PluHTMb5NeWZAYTjtBmoX98RDuxNF43IVmzEVz/PfIXCZMa98UQg9jRcuvkpofkZc4lk5cVXct171wWFX8XuM5N2+w4J3vHey2ZYv1+TDwmPu2/fLaXe5l8pZhPvHkimH8JCMcR0URhb5Avx3SKmH/IPIjLGcXSD86UoMojJkLd7r43/MPDnX1+8JWfR+TOoKiaE8lgmxkIq8TIw4P4xAEtM92Fhw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gsZe12CKLChucOzWS2Ck80j0WGznilm0KRkWxAxap2e1zc9dHXj06IydHP0/bDDcf0xPAeCWyxJ08kg2EklxpGdOd3DolBYgLvm7YzEC1CxD6R55m7jFYiHgAPSuOnyEIbqUY0RVYRZk9/Pr58xoCrxWrdTRquVQveaFoNszdKQOJqvV0HnTrF4gRxAdEPuNhjMs5Q37oeUBTTVChTo7N1nwWlQq3jSQghvG2RBUgXjXezRFb+teKKD5A00lYHw4CJ8+yLnfLRZVxzXp/W7fLMvlN/B8Fa7C80j1RZHctkPDBOEfDrdwzxKSqqF62W89bT4Wcx8R8AsP8ydeQ6yfHS0lC0WSSpHv81+zVpNQF4qTsCco18Ur496+kFYm+nUf6U5Is/iReSKqt6nPU9NxrTda5+FikqCbWL+v+L2djFs69+LBymj/TnVK/wU+uVTb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 17:43:25.8937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 257f1b92-320a-4ac8-f3f5-08dea228fcf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087

To support Restricted Injection, the SEV-SNP guest must register a doorbell
page for use with #HV. This is done using the #HV doorbell page NAE event.

This event consists of four actions: GET_PREFERRED, SET, QUERY, CLEAR.
Implement it per the GHCB specification.

Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/uapi/asm/svm.h |  5 +++
 arch/x86/kvm/svm/sev.c          | 71 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.c          |  3 ++
 arch/x86/kvm/svm/svm.h          |  2 +
 4 files changed, 81 insertions(+)

diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 010a45c9f614..d84a13ac4627 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -117,6 +117,11 @@
 #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
 #define SVM_VMGEXIT_AP_CREATE			1
 #define SVM_VMGEXIT_AP_DESTROY			2
+#define SVM_VMGEXIT_HVDB_PAGE			0x80000014ull
+#define SVM_VMGEXIT_HVDB_GET_PREFERRED		0
+#define SVM_VMGEXIT_HVDB_SET			1
+#define SVM_VMGEXIT_HVDB_QUERY			2
+#define SVM_VMGEXIT_HVDB_CLEAR			3
 #define SVM_VMGEXIT_SNP_RUN_VMPL		0x80000018ull
 #define SVM_VMGEXIT_SAVIC			0x8000001aull
 #define SVM_VMGEXIT_SAVIC_REGISTER_GPA		0
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c2126b3c3072..f09c4236fb5e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3553,6 +3553,10 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 		    control->exit_info_1 == control->exit_info_2)
 			goto vmgexit_err;
 		break;
+	case SVM_VMGEXIT_HVDB_PAGE:
+		if (!is_sev_snp_guest(vcpu))
+			goto vmgexit_err;
+		break;
 	default:
 		reason = GHCB_ERR_INVALID_EVENT;
 		goto vmgexit_err;
@@ -4299,6 +4303,65 @@ static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t r
 	return 1; /* resume guest */
 }
 
+static int sev_snp_hv_doorbell_page(struct vcpu_svm *svm)
+{
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	struct kvm_host_map hvdb_map;
+	gpa_t hvdb_gpa;
+	u64 request;
+
+	if (!is_sev_snp_guest(vcpu))
+		return -EINVAL;
+
+	request = svm->vmcb->control.exit_info_1;
+	hvdb_gpa = svm->vmcb->control.exit_info_2;
+
+	switch (request) {
+	case SVM_VMGEXIT_HVDB_GET_PREFERRED:
+		ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, ~0ULL);
+		break;
+	case SVM_VMGEXIT_HVDB_SET:
+		svm->sev_es.hvdb_gpa = INVALID_PAGE;
+
+		if (!PAGE_ALIGNED(hvdb_gpa)) {
+			vcpu_unimpl(vcpu, "vmgexit: unaligned #HV doorbell page address [%#llx] from guest\n",
+				    hvdb_gpa);
+			return -EINVAL;
+		}
+
+		if (!page_address_valid(vcpu, hvdb_gpa)) {
+			vcpu_unimpl(vcpu, "vmgexit: invalid #HV doorbell page address [%#llx] from guest\n",
+				    hvdb_gpa);
+			return -EINVAL;
+		}
+
+		/* Map and unmap the GPA just to be sure the GPA is valid */
+		if (kvm_vcpu_map(vcpu, gpa_to_gfn(hvdb_gpa), &hvdb_map)) {
+			vcpu_unimpl(vcpu, "vmgexit: error mapping #HV doorbell page [%#llx] from guest\n",
+				    hvdb_gpa);
+			return -EINVAL;
+		}
+		kvm_vcpu_unmap(vcpu, &hvdb_map);
+
+		svm->sev_es.hvdb_gpa = hvdb_gpa;
+		fallthrough;
+	case SVM_VMGEXIT_HVDB_QUERY:
+		ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, svm->sev_es.hvdb_gpa);
+		break;
+	case SVM_VMGEXIT_HVDB_CLEAR:
+		svm->sev_es.hvdb_gpa = INVALID_PAGE;
+		break;
+	default:
+		svm->sev_es.hvdb_gpa = INVALID_PAGE;
+
+		vcpu_unimpl(vcpu, "vmgexit: invalid #HV doorbell page request [%#llx] from guest\n",
+			    request);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
@@ -4566,6 +4629,14 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
 		ret = snp_handle_ext_guest_req(svm, control->exit_info_1, control->exit_info_2);
 		break;
+	case SVM_VMGEXIT_HVDB_PAGE:
+		if (sev_snp_hv_doorbell_page(svm)) {
+			ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, 2);
+			ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_INPUT);
+		}
+
+		ret = 1;
+		break;
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 		vcpu_unimpl(vcpu,
 			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..826d60527297 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1266,6 +1266,9 @@ static void __svm_vcpu_reset(struct kvm_vcpu *vcpu)
 
 	svm->nmi_masked = false;
 	svm->awaiting_iret_completion = false;
+
+	if (is_sev_es_guest(vcpu))
+		svm->sev_es.hvdb_gpa = INVALID_PAGE;
 }
 
 static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index a10668d17a16..4ab58307bf75 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -267,6 +267,8 @@ struct vcpu_sev_es_state {
 	gpa_t snp_vmsa_gpa;
 	bool snp_ap_waiting_for_reset;
 	bool snp_has_guest_vmsa;
+
+	gpa_t hvdb_gpa;
 };
 
 struct vcpu_svm {
-- 
2.43.0

