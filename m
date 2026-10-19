Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792444137;
	b=JXyCcHwD3USPh993Em597EcSIvqdJ3pRpRJe+8D92piCu4FgdZmcUQGq5HeJ1Nyz0aXS
	 WlSNQdTOsxFJXsxwjAxmLV2dGiWGi0Cdbl+xh6Sik2w57Bd0Q8zVDOfzfynxXLkrzbwsj
	 TYFN5s25ji9Yk/SVN9RF2xoAmjAQG9JB4xPafrgt+JRc9hSYlqGF4bhPPR0ju5E/5ebFW
	 SdGnE2COhxAw4qmuSHQOZiEJXWjLgt0rB40ZgAwGdOab6ejDvzbJ9NlQQX8/g0jNYY0/A
	 9F3ox+9Igi9zpmg22AatJROJrqtr+OO8bwAhamckBUE36Mub2CKipaK9nz0NvLax//A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444137;
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
	bh=AgEFiUj1IMG5s8hsf73oXghlNBjWiln29yQxOFSLLbo=;
	b=rVFrfZoIYPkYiiw6pp1rk3XAvTFgPFi7vcBNSbgUFqH7wReqicVmPfdJPqo6CphGF+mq
	 38iPF3opgDbCdSBYIZ+GchsTZhHfawpN61oR74gflQgsgawkCTdJAbPe8nS4FgOCNBvoj
	 P3awlu8QgSEEOLLzxxvp3VEs5um9dNUz0u7Asj1ZHI180XN8mL5B6uDve2i2hbhJ6cH6c
	 ZGRaLz8Bl3KZ+cG5yo/M8IwS8E4Fdx++CELEoDj7cBJAipH1/XycxmAKCBX3Q+xOPKwqR
	 j7D13184kgdwUTDdzzQDualDzMVR0lPpFOebDj10hzhmLF9ANh33gQqfibU3JLCcCGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mDxdfJh6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.62
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8414606A31C
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8414606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mDxdfJh6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thYl0dY3QYbIVKLlaTaYsq5xcSXz+McEbRxQ8SGWj8M2HWkIYyTMyTZvbUfdUoMjuGyknaMr8dpu3SNamlwBQsweZgylf/EnaByC/vP0gLaB4PmDcE4xJ83u+DMwTFBh5yCeeEgicb8hJPUTuhlV0K8Nc0FHytvVVumYhwU83AXghsLeeqojFaQum/X9z2eJ+RrQSIlQ2cskTvdV4krY9/WycRd5tWhxWPLZpKllCk6sYkbtV4pFQs8midkmGsDSTupWvavb/Q/JWM/cRIf9Np9B/8/SlaLFNkFfgoXcza310TyZKMa0zu1lC7nokVGnWgQ6HHAQdN87B7US+nKevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgEFiUj1IMG5s8hsf73oXghlNBjWiln29yQxOFSLLbo=;
 b=NaDbINNihkK06BpNzbMm9UsPdv9YeZEwHEjctAB5tarOXQO8Bm2zBdYhU5whf4XOXNPUz2d6KxpvRj+2VKsuz9Iakwh+BNls2PWRpQhldvz6sXTw9Nce2fXcoWD+hIKQc+FPdDzGstQQiD/Z5C4c7QHFn8VZVy/PjZlOgvDmKxNci84CdQG4sjFKz8myG/7opmF4NlfK8udhZOf0Wwb5a3aSxIzMAIuGfSpO72uAN1MHW4ybqtyIB4cqclFa5PK1gG/yd6KYbJo2Bq8plGlpavdF538AK+Su1BCchoMCv0wrP86AT9HXmVYDbIZlvDTTXkm56Zsvk0NMS0+iB/RRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgEFiUj1IMG5s8hsf73oXghlNBjWiln29yQxOFSLLbo=;
 b=mDxdfJh6X9ia3LodUaKhi1T7t2L+nW5k9w85bJaFH8bl0DM9PR+gCTe2jKnvhB1kEb/WSIKaciwo3Qru374OgaLgi2dHyhAz8+c2f/xc81dKNw6aWYpc4aPRudgErXmCgZjl98gUiBKbK7HHXq8a0p3GYLMK3OLQ+0gtRTLa9GE=
Received: from DS2PEPF00004567.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::509) by CH2PR12MB4280.namprd12.prod.outlook.com
 (2603:10b6:610:ac::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Mon, 19 Oct
 2026 21:08:51 +0000
Received: from CY6PEPF0000004E.namprd03.prod.outlook.com
 (2603:10b6:93f:fff6::eb) by DS2PEPF00004567.outlook.office365.com
 (2603:10b6:f:fc00::509) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.0 via Frontend Transport; Mon, 19
 Oct 2026 21:08:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004E.mail.protection.outlook.com (10.167.247.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:08:51 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 16:08:49 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <peterz@infradead.org>, <acme@kernel.org>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <yosry@kernel.org>, <jmattson@google.com>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 10/12] KVM: nSVM: Pass through LBRv2 MSRs to L2
Date: Mon, 19 Oct 2026 21:05:30 +0000
Message-ID: <20261019210532.378628-11-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004E:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db2fbf8-d8a2-4da3-8857-08df2e252d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|261009223027099003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NI9PsyemR8nQtEVdrzIfmS0ELedTjao7DK3TNC9Z31zASxjRV7y08XzGyBFd9+bzToF/gT3rvu2Of6WjQZ0y7dUNiZKdlRSGX45fg1gWWHr44RAH15r0tU6sRwhUJDor2ae4JiROrFji8G+zdMRMPiW4nWGzmI0YdJSiuQw0qc68zzrQJDNEUIEJ6Zm+akyInbLchAnkTAYw88IXlp1Ss6WANtXdoQBbhvIEMRiWuRDRcJk6Mu6rBSCRbplflPVxhkHKyd9eKQcMM5M9qhByjMSCeVB2z35ZSQuQcYu/ZVKLxBXjxdBnB9j12EkUwApxvT+1b5KlR0/GOmQIK5fXT0dZEDZxVQbHhq37/kRWFBG36cz5KrojWEOIW0rRVtjA1h6wOT/+3zFD61NLoT4S0+GPc8PO7md7dmXJIJHwPnJHoPAnFVE0MxDVVMKVQ1GwfMzo4OiYcVP5yNKLvpDDdrF/n5SU5r/EyQMFiM/0nWJNH5NLibjMM9W6Iouokt8xTKJAJ2tU7mlEYXmoae6/9QvyTzLpLxY+SSz5del9blmgXq7Eo/eoWDTXSEFghkF9oPvG6eK98Y7EQlQ4nOgZGRj5c6hMxwlewqq/ULFZa4W8CjE95/Cpj9SSX7uatwnRzEK9KQ7hQyF1USsDHyAxz1+qctdjXsU4ZNg7rqqK3rcQcYm0knSt5/asbLXv1PaF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(261009223027099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	27pOuUtz2viAPsXt4AQeHT9xXWWRKeJ8K1leizQLiEzElZ3ypkuHNB+0EPrVSeIxnSpb/fm4D76o8cJJ9WjgdXCgtQxHhXoMBb722Dut4AH/CV+J5ly36AP2y+wsRKbbKtAmLPqAHpQVtKk9uIintRnnCwx2cxZddIhex+MtnWEBtbvhyJiBMTFExpLqPdZGkS+dBYkVVzCVNwfZSRFsIok0jpwnghGElD1219RsLYCV+RzjC3ZVMevrJOf6IbcPV5ni9mREWoRD5Es/dsEmEKu8upqB6ggCZreCaQR4mNuIZhXBICHTzrma+vbPfRfuksnvj20K+R46+yAVHbiZ1LxqP0UP/h2zG4aWfrCybjFNcfyirrljuZ67n851kgnC/Vw8gHJxEQw3i+HuRfB36lYXc0GrFd01us7UVDW5TOnkerV8wwh0CqFio6A3rE+w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:08:51.5043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db2fbf8-d8a2-4da3-8857-08df2e252d24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280

Add the LBRv2 MSRs to merge_msrs[] so that their MSRPM bits are merged
into msrpm02, letting L2 access them without taking a VM-Exit. Grow the
merge offsets array to 12, as needed by 32-bit kernels where each offset
covers 16 MSRs rather than 32.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* New patch.

---
 arch/x86/kvm/svm/nested.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b356a091e320..84154f353935 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -209,7 +209,7 @@ void nested_vmcb02_recalc_intercepts(struct vcpu_svm *svm)
  * Hardcode the capacity of the array based on the maximum number of _offsets_.
  * MSRs are batched together, so there are fewer offsets than MSRs.
  */
-static int nested_svm_msrpm_merge_offsets[10] __ro_after_init;
+static int nested_svm_msrpm_merge_offsets[12] __ro_after_init;
 static int nested_svm_nr_msrpm_merge_offsets __ro_after_init;
 typedef unsigned long nsvm_msrpm_merge_t;
 
@@ -253,6 +253,27 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
 		MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
 		MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
 		MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
+
+		MSR_AMD_DBG_EXTN_CFG,
+		MSR_AMD64_LBR_SELECT,
+
+		/* This part of MSRs should match SVM_LBR_V2_STACK_SIZE * 2. */
+		MSR_AMD_SAMP_BR_FROM + 0, MSR_AMD_SAMP_BR_FROM + 1,
+		MSR_AMD_SAMP_BR_FROM + 2, MSR_AMD_SAMP_BR_FROM + 3,
+		MSR_AMD_SAMP_BR_FROM + 4, MSR_AMD_SAMP_BR_FROM + 5,
+		MSR_AMD_SAMP_BR_FROM + 6, MSR_AMD_SAMP_BR_FROM + 7,
+		MSR_AMD_SAMP_BR_FROM + 8, MSR_AMD_SAMP_BR_FROM + 9,
+		MSR_AMD_SAMP_BR_FROM + 10, MSR_AMD_SAMP_BR_FROM + 11,
+		MSR_AMD_SAMP_BR_FROM + 12, MSR_AMD_SAMP_BR_FROM + 13,
+		MSR_AMD_SAMP_BR_FROM + 14, MSR_AMD_SAMP_BR_FROM + 15,
+		MSR_AMD_SAMP_BR_FROM + 16, MSR_AMD_SAMP_BR_FROM + 17,
+		MSR_AMD_SAMP_BR_FROM + 18, MSR_AMD_SAMP_BR_FROM + 19,
+		MSR_AMD_SAMP_BR_FROM + 20, MSR_AMD_SAMP_BR_FROM + 21,
+		MSR_AMD_SAMP_BR_FROM + 22, MSR_AMD_SAMP_BR_FROM + 23,
+		MSR_AMD_SAMP_BR_FROM + 24, MSR_AMD_SAMP_BR_FROM + 25,
+		MSR_AMD_SAMP_BR_FROM + 26, MSR_AMD_SAMP_BR_FROM + 27,
+		MSR_AMD_SAMP_BR_FROM + 28, MSR_AMD_SAMP_BR_FROM + 29,
+		MSR_AMD_SAMP_BR_FROM + 30, MSR_AMD_SAMP_BR_FROM + 31,
 	};
 	int i, j;
 
-- 
2.43.0

