Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792444086;
	b=JAMMIiLB4613qpTtOxSD0sceEoDNsRRoB+5itBGFp/sqg3MZkAH0sIy5LMokH8xCsXy4
	 T+4u2ziBMLJWhP0x4XuUPBDfCzfVJ4aLbzKYupUD3RXV2MxP6SLmblC6//KUJKEz8XCtp
	 ovue895UtD1fFYmDQQ9ajWbohHGwDKWgOs1Zbcd9VLeN75nhEu/cqs02ndtckTeEKNrVV
	 HvGanz6IvavnhkYsZMBIiPVrKCDtot10kdmV3Nj5CGIbqeAooV/q+r25HEgeJzQRg3hjS
	 jZxS/jNt2bHEicWV5ktqIZeAYD4HNfypge5ao06FXR8THawTIBTQBemsdbXpOtz+5Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444086;
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
	bh=S8KKElI0HsxRAGixjG/CnszVwYVkQeOgaHo2WgmycJg=;
	b=mF/LP/Y8WRoqa8NtnGptfvohiliurtYq28A+m/rB5+NDG3WlZQwEDbdnfkctOf+DLmTk
	 8eDEiTvzldYjE6JgItu7sYLT6WJiVIrEeceMytMEv3UngcCzAUhAYyMGxERcFw4lEqocA
	 eKF/sAbh19TnDH619LA31GGTXTQjqStEuY2fov96f6YIoJQlvAarXj+HK8STA1vypeosS
	 rslvF9a7/8pClUFD0xBNSC3L91ubA32BkxZJJlTEeOrpwiNxyFRACw3ZOgS1NcgaeVKdA
	 1t9Ek7IjmtjuJJnHqQzeOjCt4I49vZQ4sdzIQk7Jn3rgTGuuLAN3Z1VZmTIQsn8eOTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IBs95trG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.37
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660C606A31A
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8660C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IBs95trG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ca8QzbSX+vySCmIyy1+3Xq3ntU9Ezx/7m+WGw2b+kAOSq922REgewz0CvW5D5WDVnslW9uUr1pbx/0ztpQkyN0PLBMKgYqrkMEU/Ii7pAm9m0yhOwav4eC+bvBg89k1VYL2GPco7PRq3vmk/88Py6vpncM9147IIKQlRYIVKyhJZ+82/I09IIEDWq3bJliQihDkhLQfLzgEco6vWyqOqWp9VOPh0dDytP+V6d9e5zxrbzXyMEzdRwEhdaXHSiGzywTiSRhiivdL9nKk1DXc1mrrscbNyRtmw/JPhXpC4LGveZRwhxYQaupztOFjOaJbdciTUYDBQCtDsupAWS3U2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8KKElI0HsxRAGixjG/CnszVwYVkQeOgaHo2WgmycJg=;
 b=HmVvUIIin+rZZw1x24fcjhZkdHC5d0OtV0ohDtbEb3JZt4pBOVW09JdXEqx3Enn1tqJV/eB14dQ6OYXdqqY47D14KOQHh4RPygYumqN7MxLclaP7H71172d+dNjeQ4mqkXqklweXryfPtSrNayRg3EKBNGfETv3zjnP0fJTERNH3ZnYjrtRe2BjYf3dODeWlEs6lIbI51K6stEaSqPMZqbJYXeXRPjQH39/8Y4OZZ1Hz9wXmFqsyQRS9B/MiAmrcJVVLDWJ32ReESkcx5oRNqWhfOgdf7Yyq9IDNf5UngYTqVQDdKpHMhNHZEUnUNkqi8CaOKbfTkXN8Da2Pn7aQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8KKElI0HsxRAGixjG/CnszVwYVkQeOgaHo2WgmycJg=;
 b=IBs95trGyLanDkrFGyqUJZSiL3JjG6LflAdh69FfRPYVSjVrwgGcyQboK4MnPF7R+AdLPQS8n4TuKff16GKpoLLYDD2zJEm23+RSrFbTmiAXQqtZ52ax8+raBkO4ko7PB+jekP1LRAJ4TRKW037UJ+VJVngT0TMXAoPmx/QubJw=
Received: from DS2PEPF00004563.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::519) by LV2PR12MB5775.namprd12.prod.outlook.com
 (2603:10b6:408:179::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 21:08:02 +0000
Received: from CY6PEPF0000004E.namprd03.prod.outlook.com
 (2603:10b6:93f:fff6::eb) by DS2PEPF00004563.outlook.office365.com
 (2603:10b6:f:fc00::519) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.0 via Frontend Transport; Mon, 19
 Oct 2026 21:08:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004E.mail.protection.outlook.com (10.167.247.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:08:01 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 16:07:59 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <peterz@infradead.org>, <acme@kernel.org>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <yosry@kernel.org>, <jmattson@google.com>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 07/12] KVM: SVM: Advertise LbrExtV2 to userspace
Date: Mon, 19 Oct 2026 21:05:27 +0000
Message-ID: <20261019210532.378628-8-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004E:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: d505bc5f-d86a-4754-3c6d-08df2e250f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|23010399003|1800799024|6133799003|18002099003|10067099003|22082099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	y/OwhYdunVhHtXVA32LKXz3EYNlZGY6sqbi6rd3KgnN8on/QXhTD5K1RLIXC1fYtNnMXioN/vjCMdtAZMPvZgzxKFP1lQJan3oAmhK67ei1kclc+GwSApVEd+4RWARDGFjfG8xfvOrBzNTntfnhUT3Sh7Rzc3CXPmLubRBeT+i67+CDKV+hJpoITGjMiwsel0CmQoLE5DSdrWwDutzOV/Pb8LJ6k8mq6/b0zmBqvshr3Sjvi82tTkJjgmShdz4Vot19eVyY++fNYc6DMFQ9vZ79nJCYJbTkn3Pc/Z6MC6LPXAmwQd0/LfNGZKLdRD+6x3ZW1tbXUSXs0lsBlsTban0y0BPfkQTs8OsH7bliJpcjS1fDJ0X24Xr7QUFJiIObWHhqyhiJFm0zn64WOrc1ZyTxtrekNYjchm3SNO3RIpDssznnGOVy6gFriz4g5AAqHDlzbWDPReiwIFsNZfeRmsPHsrIDhLKAcuZEwPxIc/jqSDtUwGF+LqZiJIHr894CJXygek8U/meVt8A3ljFlf+Wd6poCqf5P5UhFUn7CRY5s9O+0H9Si8hWXlf3lRXsqrn0Oc50CCajcSA8sj5G8zFbsCHEmZN0TxaX5iQyIN5nHyVAzkzY9pFmZpFOSOB5B6e6WqSqU/FaXSBFim+9BHW1EMm/g/EJtn9SSnULlOuVnMLroFkfwDvwtJAioHs3mLpIihKcsoc2s2la3ZDxu8cw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(22082099003)(3023799007)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2CTw3tGOgUECMCS3vcyqezBqY+ckJjDFG2wroqo3/dGxg6BrE0fLG3YApkykKpwKAwP/8OzYfxrUqkldrL5EWZHPib4VR/LaEKhGl3JkMEYmBqH33dIF/VXI2Dvx8EloPVDLFVn9nrGiMnb0yRw+LLHKTwwyn+AZtu9+lWItTeRNAgnJ7PjhGivdcPeQo8zNqzucWXgdmpuUg2zjCqvn+0QhLgdfXo+sp+W2nBfy9oLP3qw8kt+eOLNDF8MqEPhTaCXQEs8S0isQJtxCyNg4uGUWnHR9dstPCI+OumVQrXrCBUQopvaxWX9Y4ik6veuSkAnBx6QtePQ1+zzrvpxzwl+QTc+iE418hSN8VGRNzOObdSMeLrxXPc4kEuT4+P9dSom4uqdVav6Pvm5mj2ceLok4AeVxuyJ8o5dY3oe5eSQaEa8J5DthOQgpHNaCZeJt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:08:01.7206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d505bc5f-d86a-4754-3c6d-08df2e250f74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775

Now that LBRv2 is fully virtualized, advertise it and report the LBR
stack depth in CPUID. Gate the advertisement on LBR virtualization, the
mediated PMU, PerfMonV2 and a 16-entry host stack, so KVM never exposes a
configuration it cannot faithfully virtualize.

Co-developed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* Clear AMD_LBR_V2 in svm_set_cpu_caps() if the host LBR stack does not
  have 16 entries.
* Removed the per-vCPU clear of AMD_LBR_V2 in svm_vcpu_after_set_cpuid().
* Report the host LBR stack depth in CPUID 0x80000022.EBX directly.
* Added a comment.

---
 arch/x86/kvm/cpuid.c   |  3 +++
 arch/x86/kvm/svm/svm.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index adafd6fa2c54..bb24d8362132 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1258,6 +1258,7 @@ void kvm_initialize_cpu_caps(void)
 
 	kvm_cpu_cap_init(CPUID_8000_0022_EAX,
 		F(PERFMON_V2),
+		SCATTERED_F(AMD_LBR_V2),
 	);
 
 	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
@@ -1904,6 +1905,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
 
 		ebx.split.num_core_pmc = kvm_pmu_cap.num_counters_gp;
+		ebx.split.lbr_v2_stack_sz = kvm_pmu_cap.num_branches_lbr;
+
 		entry->ebx = ebx.full;
 		break;
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 69f9ea746bb6..ea7535ccc3fe 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5843,6 +5843,18 @@ static __init void svm_set_cpu_caps(void)
 		if (kvm_pmu_cap.version != 2 ||
 		    !kvm_cpu_cap_has(X86_FEATURE_PERFCTR_CORE))
 			kvm_cpu_cap_clear(X86_FEATURE_PERFMON_V2);
+
+		/*
+		 * LBRv2 requires LBR virtualization and the mediated PMU to
+		 * let the guest own the LBR stack, and is enumerated through
+		 * PerfMonV2's CPUID leaf.  KVM also can't faithfully virtualize
+		 * a stack depth other than the architectural 16 entries, as the
+		 * VMCB save area provides exactly that many entries.
+		 */
+		if (!lbrv || !enable_mediated_pmu ||
+		    !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2) ||
+		    kvm_pmu_cap.num_branches_lbr != SVM_LBR_V2_STACK_SIZE)
+			kvm_cpu_cap_clear(X86_FEATURE_AMD_LBR_V2);
 	}
 
 	/* CPUID 0x8000001F (SME/SEV features) */
-- 
2.43.0

