Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB62DCF57;
	Thu,  2 Apr 2026 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161624; cv=fail; b=hRMbcMM+IAIr5yQSksYcXro5XQT0kfc8PQ5v99N5Df3GBwJws3cCLeOmPabsymUi0YkCm+SsXfLptC4GhjmbE5mS43Zz3AxgQPsGwApqJRmNGYM8xFRO14flGkeJu3C1N77fPWEoSTQT1mlWfqzfOCZtyFGhAvN6vhRYHPBJ2NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161624; c=relaxed/simple;
	bh=ztDaPdPck81fomMf2AmV3MOuXgScj0mrJ5Oeseus6Yo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgeBHTMe6qh8kkftRMxeDTlj9NcorUih0HjuuFyKxueLBLsM/xWkJeslG3QUBkSYr/skiOc8emUaHR1uLneoJlsqtXTZtb/E9LWgPGS8HmDJ4KbdAts+t+MtgVXEy5ESJqjHanCoSJP5EzVN5pQR9zU3ESnd3YiiXSvNH/b0xog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wtxa40zh; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wtxa40zh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrjHCVN44j0CgruQR4pAeeXqsmoLj8bOEgp0rwqv2iLzITLB2xiIoNE9riLc9rkfVnc1+RFpbFN1+yRvKEnkP4jDUqwq0GD/e0jmOIBpv5+KtlCCwMJvt+VtennrMCpnvNr4pfSjolJ3UiebBJlIqlSiHkEs24xGMRB5DG2q+teXC3fcw9BE7nfJrsOjN2ZWhJ4cQ4dPMy7Doz1naqmfoxkYidHzoUL4JRl/4xdFDMntXljdzoCNQZR5PhEDtzDpUyVe63HZdGIO3WtvIv4byMC/VSYl660ompF4H0y/gnLrpe7pZWh2q42WILAi636UQElfICPWw4lFmItpOrW6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCMaKi19xBd+cPMD1FVpqGAue83F+LqlnrPgKCQqQD4=;
 b=jC2xmNM//7mFQUGYi1WSeGMs5K6alltAO5XHAy7WmolP5/aBByo3Wn5eMniEY2AtwjillRrsWVoyb3G9QOuvtaaLkfQhUDO4V2j+Fuqv4yDvGFMJ4IGzPSQMpzjRzf7MStLzV9+q6lnLYDG1bTubhd/8ECxTcCnakwwB7526EBBSn+wABM+7xlI6wI/CrhPUbkpEvIwZYznuhioWRcU13cv80hCX2Vo2/uXF8IBUC8tUQhgeT1xE1hfOB9mmlhoWHREpqtgpMmVv2bECOy9tFTJyaCrfNLyIeV6g/NlgOVZTih+R+rELw3AHW0kR246LkIx3dWi7M6f47mKVloFl8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCMaKi19xBd+cPMD1FVpqGAue83F+LqlnrPgKCQqQD4=;
 b=Wtxa40zhRoBo24M9q838cR5dyY3AgWi4oa/pwXzno26y74M8QXjk8xaYjVvfoidxwwyBqgM5IWTc6ls7f9oH6CdNXlQ3TRFAp+9bKAPWkcJmnl9Ykk6qg3U8R5xS6FXOslXTUxr5ZdAMULfnAUJTeszEdhnrMpzNssEx7jL64Co=
Received: from SJ0PR05CA0058.namprd05.prod.outlook.com (2603:10b6:a03:33f::33)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 20:26:59 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::3a) by SJ0PR05CA0058.outlook.office365.com
 (2603:10b6:a03:33f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 20:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 20:26:58 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 15:26:57 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Kim
 Phillips" <kim.phillips@amd.com>
Subject: [PATCH v3 4/6] KVM: SEV: Advertise SVM_SEV_FEAT_SNP_ACTIVE
Date: Thu, 2 Apr 2026 15:25:56 -0500
Message-ID: <20260402202558.195005-5-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402202558.195005-1-kim.phillips@amd.com>
References: <20260402202558.195005-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab681bd-5b37-496a-0bda-08de90f630f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IWPVYKjaSe2BI2TXMRJPnwFQ0w1+W0oMCKnL4MMKf2T/e2kKNRDX83XQXiG7ER+OrO9dwDSDw25bCHRcoSXSTsqTXcvDQ/V7r8OjPsNghrwn/d8L2QNF0QZ2UrBbr1e6AUpSZ9YM+webs467ETJ94YL8/6pgdUbKxSAkMVhrIwWkcXFcL7bpwomoypj4u5bXmjXpkVHREDcuTxJSQOn8e5W8wniCTO89PNUGmVkw7+IuZBxqr1Aak/RA1V8stA3CbS6VVLNN1aifenLbiWDmPir0IiEu6CHEdwOC90OoFpJmI3qjnnf3ObcEXgL372PtDoslBkBoXvj1p85Lsgflnt9KUzZ8lrTk8TTpALFMIhFtWgSzFBoON8WXFIUIFyUcvi/0eCgCKwj55Vc58EKEkmDNV63cu7/wZfBnpj/xsOeS4OKvxDxz60aTKCZnZRVEzATThWyBee/zL8kEHTVh7mND5qEEvK/3wSy17sf8wrDguRnttocDqxfxSOoYkPwuHnmIJEDzcH5Vok7l9smzsL+kptfXSNi11BMV5Z2hlwAMa0eNN2tgztgGn0tN90VxtfCQQ53AJi8Fyz2t7MW/I2GgfYkaDsyP2yg8NIlSpDElNAvwXU2mjvuRGZfev9zfVGI+NNAaZVTy1ev8w09zN6g5kFQ7aUpPBy9BXyumAE/e6ggNTM18U4AXr1n8JbjboVgjR8V5Q+32s2oKY1+mu+9tVaMy86XGv3kcCznqJefO+dxGmhyfpi0JZu8K0C+jzDGsboLW55n/2eUViln/LA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zxc3ziOUYNdpkJ1sjsSY6PwPDejcPuFDjyuWGXOoG4+ezVd6+BAhOKX9Ov8amQcwfbFNOnwwie2KGuAqq1rNcTxNNsSYZjuIO0BTnh7CKZB24a4bpz1nM8YnMkPe8zZU4LK3P97IXbMTVIxnGvu5h2lsqetumYnRqnFjgdIGWnGAEHGUuVCKRljckYgKnt5OJFbwhWSOxZEXukHCxH3K/WX8DcQKEadBfZ9xxOkdk7k8JZkF97PHAbhPrTNPwfcxi9rTmOPsQefVTA/ai+XHEVAo1S/c89csLO/lEQPzrFCj8HVCebrU/+dvRY/xRdproDjiumqBoC97WmiP2kDvwJfcVSnGQ4/vhb6vggY3pLor3g7Gi8Ea4XQOzjJFMbNSNKsUTmnZ8irWJywdc4UG3OmBKbrADeKA50HIbVg/knBuipzDwprtXiBXnNRBGVPo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:26:58.9559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab681bd-5b37-496a-0bda-08de90f630f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306

Allow userspace to set the flag in kvm_sev_init.flags.

KVM still needs to set the flag for backwards compatibility, but
disallowing SVM_SEV_FEAT_SNP_ACTIVE for an SNP guest is "bizarre."

Suggested-by: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/kvm/aaWog_UjW-M3412C@google.com/
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
v3: new

 arch/x86/include/asm/svm.h | 3 ++-
 arch/x86/kvm/svm/sev.c     | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 7e3f9d92351a..4f844a72890c 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -307,7 +307,8 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
 #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
 #define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
 
-#define SVM_SEV_FEAT_SNP_ONLY_MASK	SVM_SEV_FEAT_SECURE_TSC
+#define SVM_SEV_FEAT_SNP_ONLY_MASK	(SVM_SEV_FEAT_SNP_ACTIVE | \
+					 SVM_SEV_FEAT_SECURE_TSC)
 
 #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 2b4f3c05e282..9663424c0cf0 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3165,8 +3165,12 @@ void __init sev_hardware_setup(void)
 	    cpu_feature_enabled(X86_FEATURE_NO_NESTED_DATA_BP))
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
 
-	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
-		sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+	if (sev_snp_enabled) {
+		sev_supported_vmsa_features |= SVM_SEV_FEAT_SNP_ACTIVE;
+
+		if (tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
+			sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+	}
 }
 
 void sev_hardware_unsetup(void)
-- 
2.43.0

