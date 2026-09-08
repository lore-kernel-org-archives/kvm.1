Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22353D75A6
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900994; cv=fail; b=kOJ2tFyyceF+7z192+PArb2KPhJVedR2TrQoU7jtyNyk8zYn7v6sWEyMTlul10jMhXvfrPGWy1WSRl8d9hH5KclTG52fsoLJ/aUPzQoVvixLKAlamLOMm78nL1VzX3ubAZ4e/DMJninUeUSb4mInRdLi4MqB1UA8weP90M8D6N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900994; c=relaxed/simple;
	bh=svMXyr/z8K2SSpAuWABzrvgtWQbwoazU7HF0HQaJ6BY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2rsKbKGHk3Zr6iyMQ12fsvljRS75W5y7IxJu8QnwNACCfa+y2OiN9ZUDamLUu/tT0kUNddN0eiRKWxXncfrLMphcaIlke5sa81CGA0FRPoAGXP0h2/Or4+6tRNE8bLKNeofNPjU0aRtqj97vc6wv5DFNF9/gBmDdN77LlireUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ISzOs1JN; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ISzOs1JN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STj2AllL97wpd8Jp8IOrAKcSH5EyFVGPncDJPwXQT2Hsgpipf4j14fY9M11x+yOt+5KurJIHii4nKKtKL3sPZSXkivn3LitfG4WN540VWyXUjWEC64h+J/ytrrujOjZinOUqn4chGXetiPR4EFbLH6L6DIdDrdwxzXMRmvV7xt5riDHhT0HJnHa7LYdPLRdjA3D4rqfQTkFEHCG/iByHP3gyOwQAdZqMMHEX0mbD54kNE0t1IZC8d1J/nQ1Dkkcm+nciMeNnXV/odaI3eGhzvLiDon2L7bgwytjwhgngNhyWmyRf4I1ORkyfEFWn/JBm6aYvwhqfdX1QvJWJOucGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls0LNdgKzsb7+4arXWpyoz6xIE2Fdg9XQDtlINKrtAk=;
 b=w5bFCMi8wbZ2WJ5pF/xFU7JNJKKwpUF9zCYYcutXQ2kPZRpC9Sn3pkotCJJ7nyafND74vxN+gss4KED5ASjek7b+09VOqi5jUiZwyiaUA2vNQsa7hnJ/Mtygq08wmqb+fCExGirN3cYsaKbveNKc8/43qwc4IsmYE+tGCUkLqUT6VYGTtXESaT5eF9acvnWfXwkC4T7nDHV96miVekAYxAYofuA7NfEBFZcL1N7I8yX+r75INRZweB0uiZYJFjGzmdcYgUR8LK0UlEic4tzhTpZ1xL4EsIUaDzqpVnHWnoe0dI9nO+TnvCEWcqoPhifo1xnHxGsQ2A6VJifFJRX57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls0LNdgKzsb7+4arXWpyoz6xIE2Fdg9XQDtlINKrtAk=;
 b=ISzOs1JNchHbAFFAwFhzbOR5x1QnW8KGi2QOVGNJOlbAU9k3oWozF6B7zbgYs6zpnhuPbBD+/MqE4Q8Gw3E75ccrUbOwOEFV9t2AiCpLGbrtGAVyODr+YmXku58SesjZYa3RReg+bPiJu57LPI6YCpnWnKdOvjYYbOnt/3YPVy8=
Received: from CH5PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:1f4::13)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:56:27 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::e) by CH5PR04CA0013.outlook.office365.com
 (2603:10b6:610:1f4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 20:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:56:26 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:56:26 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 17/19] i386/sev: Update CPUID failure handling for in-place conversion
Date: Tue, 8 Sep 2026 15:48:37 -0500
Message-ID: <20260908205236.838281-18-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908205236.838281-1-michael.roth@amd.com>
References: <20260908205236.838281-1-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7f3a8b-9ab0-4d4a-ff51-08df0deba641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|7416014|1800799024|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ga06Pd7ch2yfTLGyYPBVU3J2TBkUkJrjkoV51sMaWPuiGTwCY9HnH8PQu3bMygG19Wu9pZVRDgAI4BhtI3Vcs+0wMSve51GP/UJP7Adi4qdiXA1Fz5fOAGuIW4BYnHaEMpaiD5KlsapdckhW7SpE/2uCMjds3TS0PD6HaQBUszrVBE/MTS24H4xBf0ivhEJ/eqCcDA0BDT9BgAgYkTPILcGb/ZOk0gaAk3cZmyBn02Gi23TsQ08QHi6S5G8GY+LwwJuGM3oCXDNl8SwD17wJNc8w9py2oHhd+jaRZtiKylIj8/ZHRGuqiWofnMIB/gnpBvdAPEnP1ZP2+/8KFsAR14NdNF6yeEPPne2JM4ZrrPhIdKpob4lkG1vNYQt50vezxDxKWxAi8Ms2WQL5Yyk67jYLqpPn0qYpxwTMf+z1ZjtK3dxwSdCOU8UCLZkhY27a+MqRONZ74yyEv3Qe9uocvuV1KjYz3h0j+zAayawxXO8O0ksf/LqHPaNokrgDLhKVa2dJLy1IvN817ZQaiADDhPbfRDydapy+L/yeU4c8Sl3B6h3AExPRUFmF1SymTRp8Aj04tATCKTR8aOc8LrkfIjucxCeor+YGcJfiXKulsQ3/HM3JaW1K4j1xSrAedXfVKoNU8HnmYXikbzAzXTND2DMy1dr/Sx7Z8uHG31g5ol1UVHPMWsX4lJQp0pSpHz0GwRcXkKQjzUxwKqdnkFWgeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(7416014)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w3paSMkbF1fSbJ70vVCpBXwIm+39CxUt/ZSEYB4TXJxJlMeRFitmKnWuu7EjaiJBtuiigH+TqIY9Z7FakcGURSkBO9zT91ZJObXcx258i96klADHkNMRC/PDSzC/P9oFOMYU1W4njRNWX3IksUZBlL7KXNFoU6rmZtXnf9NotOJhcC6ruvD+2U9XujOq6A2l3YoSsqfe6749llIjSAK175eoMV/I7IYeX9TaJ0n90J3uR/byUqhgMOMc2eOVhCe80g9WeL0lq+67XPTogLqZGuSLTJlF16UQMyUBF9ny0x2qjomuXYxMpxruT1iY3KhQPGBIanK5qFXtsx+U+R542WgwmS4RBvZ1sLQ5dJwRHtc9oQhuwY/BMNh2Eaur3OU7EHcmnUJ/58W7HHmDzd/kSXxCnN70wj/583KGu9/N0IewyHFr/05/CtZkcsG+mJO6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:56:26.7188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7f3a8b-9ab0-4d4a-ff51-08df0deba641
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158

When SNP_LAUNCH_UPDATE fails to update the CPUID page, the CPUID page
data passed in will be re-written with metadata about what CPUID fields
didn't match with what trusted firmware expected. In the case of
in-place conversion, this will have been the same page that was
initially passed to SNP_LAUNCH_UPDATE, and so it will have been put in
a private state prior to making the call.

Make sure to switch it back to shared before accessing it for
error-reporting, otherwise this path will generate a bus error.

While here, sneak in a typo fixup for the error message that gets
printed immediately afterward.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index dc9934d5f3..46ef3f7778 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1277,8 +1277,17 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
                          ret, fw_error, fw_error_to_str(fw_error));
 
             if (data->type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
+                if (machine_require_guest_memfd_convert_in_place(
+                        MACHINE(qdev_get_machine()))) {
+                    ret = kvm_set_memory_attributes_shared(data->gpa, data->len);
+                    if (ret) {
+                        error_report("SEV-SNP: unable to access CPUID page to "
+                                     "check failure reasons");
+                        goto out;
+                    }
+                }
                 sev_snp_cpuid_report_mismatches(&snp_cpuid_info, data->hva);
-                error_report("SEV-SNP: failed update CPUID page");
+                error_report("SEV-SNP: failed to update CPUID page");
             }
             break;
         }
-- 
2.43.0

