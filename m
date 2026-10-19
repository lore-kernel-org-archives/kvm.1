Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792443979;
	b=QCF9Yu+NXCIIay/af4aYRGBw0GT+TFhVlyl20j7hHW3GwgwaV0WtVm5Xv9EMqt6K3fjb
	 cXM5F4/q1nHEQsgoh/ltTQmQgk6DTHZNDau+dawr/apwWC7r4mCx3IxgA3EUDjIZzy5Y1
	 7PR6uuMrB6USkQMaZ1LARHWA5P7l10JfmYM8Ikci1XCLZ5mdVPBwjoWXQ4Fn+PmqXgbDD
	 yIemttOPWvaSNbmRj4S7e1HP5zY35VWaqevEtT53Ayp0esecwo1eAAwaJmHdVkvXeD7jc
	 ufMNl6ClaV8YJRO+DzDqIGdcljeFuXPAk/De8KaKI9R0bxS1w4C2/GbtVg4qVrjeY4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443979;
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
	bh=W0I17wKfV1iY43E/7oO5pOR7w8w7VhDDbFhOGKegNp0=;
	b=rIfVFRdzdFpplOBbzOnI5Wyrj8oJxpLLkmbQbuKalLVW+WFwBsHmebnYvL7njaYXN1tm
	 YN6WVi4XqKfR+GQvzRwvDDtfRkjBWv0EG3n1AM8HTgAuyzI1xIklwHv0u5L1keF50LouY
	 NpwSqU0HiiTBzl827IJioGkFiFtZf1KUnwBN6T1dkyn0O0Dl4uu8Vo1NkNAK1krLJUqn4
	 wI3zmqF33OgShWiggVPb0DKn00bn3gtRmRS8mzmgfQHtDVZq02n4hj6zrL8pX87mxADRq
	 x1iEp896aZPIw0BpSc+9xkP7qAtDmMVX0Kns56waMjlihBD96BQxA5dfJIImk5ORqqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jDWI+tZQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.33
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2841A606A326
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2841A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jDWI+tZQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjJfLodRIHSpY7fcrDA6IPW10lARmlPWt/aYInxJFOV2TAieWPP5RtcsUb81WJXBU6BXWXui/mllCSmy+N5nqeXCDJAF7YgT+yA+SSe+RKz8WI1V9r9fP2fR9oQ8z1wDg2I5UISuiqbkT+aL163WNIBy2FHS5cANcgpH+0cixE5ON2oUKW76RDB0vvlJ5YbgEVb/hGlBPxPSAZ0SgXXwy7PcQ/F3IknDB+q1zzwj9mclHwQUxxyIvHgs/dnWe4k9x7Mb4RJlx4J2vWuqIpFi275qIcbgnhYjpMcAFdR9GZ12rUZpdNHAY8ZG5XSO+Z97ZvmsnVWQXAWO1AYGotu2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0I17wKfV1iY43E/7oO5pOR7w8w7VhDDbFhOGKegNp0=;
 b=FdTqErOwTg4jnFcYDadN4EF6IA25Wn3wGgDLqIFr1kNnq+C9sjoZSSrwuAUovDZZHGNSoeb5n+7do0Bio8mePUfypqG3fLonJEDFfi7jfvL5anBdikBBqSTZNa2/QEO9abT1YBxsA8s/XB0Ix2pdmpGc7LO1rAUhew86ZXvOsKjStc+43s9LqnkfEw/NsBCE/T0+8l7vr6oA6mmsbELjvIbMA8Od7yaFxQcNuUJDn3up0ysiMfb+z4gZ+6o0Mn7l/fnwfLBxplUTiLDc1dQa/vyFGmvZ3qswRekr8tIYKNn253y+FNImsm2Z2JyMQc2OAYOM//8sV/fbG1tYQ7XIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0I17wKfV1iY43E/7oO5pOR7w8w7VhDDbFhOGKegNp0=;
 b=jDWI+tZQbLCk1WggkyFMXTJFvtuWxUBKxmhzhUY6bDlum1vEWH6r5VwV84WuonJZFW0+/4ohTS715N5YH92BsKJVBPyQVdlkzlVtOWps0vtxCrquqmktkGH11oYqt2hqZe7wBpfJ8cD5sytWtZVlux+gVG9RCTUi+hI42Qv3594=
Received: from PH8P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::11)
 by SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 21:06:12 +0000
Received: from CY6PEPF00000048.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::7c) by PH8P220CA0033.outlook.office365.com
 (2603:10b6:510:348::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 21:06:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000048.mail.protection.outlook.com (10.167.247.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:06:12 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 16:06:10 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <peterz@infradead.org>, <acme@kernel.org>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <yosry@kernel.org>, <jmattson@google.com>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 01/12] KVM: SVM: Add VMCB fields for LBRv2 virtualization
Date: Mon, 19 Oct 2026 21:05:21 +0000
Message-ID: <20261019210532.378628-2-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF00000048:EE_|SA1PR12MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eeddcb5-623a-4e73-7481-08df2e24ce14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|7416014|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rSChppHtO5PbZiKSk7lJXH72rF9v7fRnryKb/KTjSN3ici2Ku1QIyuf4E5tYfDLxcfRSttS6o896EGgUlu0w7iC+JCrULkJofweMCHwiZ+3Zpdk6oB/WydlIUQF/BMT4JtrFsr9PoeaBQqij3lk4QTaRwJ/H1g3ygX2V6vngIak4rjKi13/LRAqzkbfljJk9EHIzWfB5lmOVIRhdKERjrcvXjuEdSUD8uzNfKNLj+QBrO+cvOyNBdGJTDW4PjCPp8EmG7qStNxBDRQRvycL64ouJTLB2XsbH2xm7W8CcOfwXWQuqlrlLA2jrG2Riz6gTNHbHzxfJCIEFSzA39sowvja4c4Qt097zqBOT13TYCDep4d6aHYEQVh2n7AZNDeX/SJGu0qk0VysrWVpoWLE2rUVcg6yGArsVia9NhVwrN/yHuzMjnQ6nY70UU/lyYWsnjWPCxa9F7ibCD7h872wXMTMRP9LCTtu7zvv/f5eAiL/njpNv7nHuU0dN1DmiJQvKC1GAwV2em5gD+694CYPrDUtk/8K+ZRRKdJLi26wl3UBXXTeLWMvCUOGGz+B8bvBV5+Szho0efLMrj89xZ2ldYf4fiY6Kbf+wwA1Nje6w8eq8YhXy9U/V7B9wvM1Nv2iRaTIDK+wNr7whgp6e3lGaxzXCAnoO3XHXtH12wY22fAH0CvXDZSaKYu9HBXY9XqPZzwrjxSUkddLEtIsgevJVcQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(7416014)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QZMQfDfB0BtKQRG13EHzVR04hdiLzqVuA87txUx6MbvxKJVOcrirxp0RzRwoSqDwBUw0bLseH+r6N5s4rNvMDYZrVyK+OIjRXGtOG6UChWp66MSa3Qn1edF6o8RDjZNmHSJAePQUiDpQfJpmDIhzgWjLZF269G0CAOmYWGPua6f13wVYPt4xSMNSvZ4s+ebEVNgn+NJyHuQdAq9k+C8vQ71JoRntjBXBfS3OfcSiFxRhyqgCFtO0O967IKVsCMRjwgv6HNWstYIWwBK8l1XRbPxtQYBlUL722/M4azfBWopwO0cIydvGBHBiuzJqAvvkOCtd8WVijXVfZXKh5nUE8RfNrb+3c8Kjo+FHGi6dc7znMOqHQt9/LdDV8TeD3UNnBixn1z/fFtx5J7d3+VLf2e5xCu7EZW1AtAPbgmzZPtZfg6zFkS+KcMlDTnBa4LKp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:06:12.0454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eeddcb5-623a-4e73-7481-08df2e24ce14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000048.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643

From: Sandipan Das <sandipan.das@amd.com>

Define the new VMCB fields that will be used to save and restore the
state of the following Last Branch Record Extension Version 2 (LbrExtV2)
related MSRs.
  * Last Branch Stack Select (MSR 0xc000010e)
  * Debug Extension Control (MSR 0xc000010f)
  * LBRv2 Branch FROM (MSRs 0xc0010300..0xc001031e)
  * LBRv2 Branch To (MSRs 0xc0010301..0xc001031f)

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
 arch/x86/include/asm/svm.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 83fd49b26a4b..d76844224745 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -372,8 +372,15 @@ struct vmcb_save_area {
 	u64 br_to;
 	u64 last_excp_from;
 	u64 last_excp_to;
-	u8 reserved_0x298[72];
+	u64 dbg_extn_cfg;
+	u8 reserved_0x2a0[64];
 	u64 spec_ctrl;		/* Guest version of SPEC_CTRL at 0x2E0 */
+	u8 reserved_0x2e8[904];
+	struct {
+		u64 lbr_stack_from;
+		u64 lbr_stack_to;
+	} __packed lbr[16];
+	u64 lbr_select;
 } __packed;
 
 /* Save area definition for SEV-ES and SEV-SNP guests */
@@ -556,7 +563,7 @@ struct vmcb {
 	};
 } __packed;
 
-#define EXPECTED_VMCB_SAVE_AREA_SIZE		744
+#define EXPECTED_VMCB_SAVE_AREA_SIZE		1912
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
 #define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
@@ -581,7 +588,8 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0xd8);
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x180);
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x248);
-	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x298);
+	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x2a0);
+	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x2e8);
 
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0xc8);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0xcc);
-- 
2.43.0

