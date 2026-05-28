Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D91343887
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926765; cv=fail; b=eTw+Sk3ZJto3kxKY37a49avE2ChQ9/tk1+X6FpqQuWaF5cMYKOg7I3CpT8IOc3jqjBQQhBl15JPcsxdNq31HjGhA93kpNG9akYOgfhodO9ru4tTSAiAsPJmLTpURgeETQJlji5LVQK/VqeUSFv0fbbtE2ZkXchMZrted+Nni+GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926765; c=relaxed/simple;
	bh=qBMTTXA9pTYhZsSFix//3tKKmNQJ//UEc90YiagByuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oungsRDaYmXn6slwggCMD1XeGLFYSZz4by/q202TXz0J8zWS4zfdsWHJy5mmVGYFI1mzkavkSYQx221bEynzzRA5fMlMae6SYnOlBn34ShZd4Oed/PjZmzdOrC/ZEoSl0Ey7aRQ5e7k6ZdcOeBYjFHfj4hjW8I58NcdO++dLtp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CtOnltYt; arc=fail smtp.client-ip=40.107.208.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CtOnltYt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFC/h5GdcwoznXBJGPvxk4MQ+L7vdVgOYYqd1zubaekusjE3nmg6sDmEGhB2OSleiJQN+6jJBPA3vAe9qfiBF2y2Rph1vHod4wcZTAsuEfKrN3s262dcLixJUAfh//jcmqwNDI/Qm/WxH9MA29CdRHAlOWC1YwTR9287sP5aVpVoblSqHiO7hNIz08n+GZye8I8QgRaMW3rTHt9xgzo4AChlmqIqGkWTL5pdhDJqRPeLwETH3+25OIPQiaVzRNoVM4foc5bw88/dIJJCNgR773wdR4YY9j4kpJoU6IKh7hiyWAwPKh5VQR1bRzNy52xvL6dA7vYcLodUnlQIoT/i9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMwnal8j5WgNoN4ojSlokNd0nCMsv+Lp3ndNxBs+tM4=;
 b=As5+myzM5muHC5DKLv6yMFfnyyIQO3obmEzaeBT16uQiO626Tl/FyhP023OtXfkIKTWMdaIygd7P85QB7ZaOy3QwhDBQ9E7WcocQpxAR3uTGb+sQUIGxrCirY7e4Y+fTEEmLlTZRUo7edj/ji2OSS0rfMbtYNpI6+NvzVwW/MlWPZ4KZbwNfnrAJG32HRjxBgoJo806mBDjExZcwTATGAJrOgbuiQ2kM3a7YmhIH/9Nd0jtkImDFnzFMt6t5EPUfnUv/K+ZZw/5KFXkwLFWzkC4oLIRpJJ01T19vAM9G+Js9xXlpu072h9U3h4QozBhIoT665AQL1RE3FFXHJJpBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMwnal8j5WgNoN4ojSlokNd0nCMsv+Lp3ndNxBs+tM4=;
 b=CtOnltYtRs5dLqptBGSGptCTbnQ79Vw9bxHWmf4VwEcctvhFxNaRMtl2oFPzTc5X3fXqlps82QxmZL6HBJhCCGG3O7Xvadvsfkhli0pK/8QjQ+zNuqdE/y8e41VYWpJ2UTyBrfxtus9CGiXTD7HpNb1IgvRvJ9gcJ2FKCHswhQI=
Received: from SA1P222CA0116.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::20)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 00:05:59 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::e) by SA1P222CA0116.outlook.office365.com
 (2603:10b6:806:3c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 00:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:05:58 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:05:58 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 11/12] i386/sev: Update SNP_LAUNCH_UPDATE for in-place conversion
Date: Wed, 27 May 2026 19:03:36 -0500
Message-ID: <20260528000416.8161-12-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528000416.8161-1-michael.roth@amd.com>
References: <20260528000416.8161-1-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5555ba-98b9-40a7-9fa4-08debc4ce5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	jutXno2WDDOSkeXC7AadzNL80MDLMausmj0/W+BEYt7byAiS4S2xWjiLR6y81pbYHTMekV1iJNfpbrgopzZUqrxz8NrxzPZ5W6Ln/MwLRRS87DKZiOiO1in6QkuqmeKB7lx14o4s39uXsDToIeiYOr/wweR8LYH+1Tt0NEN2FlgRsNxA4QGJEyo1OEC6yjqk2dAp0ouBT/DmjOo30s/LlUpfx7LqS62bpkskZOugINOuSQ/Xaw0CWFQimIADXHjuZO83v5i53cHejcTrZWxxe3nQyycN0KAkx9WUma17u1TEpoyNKOUL6VwPEPuhAueA6owCnTsl9cOpiLi5iRSwAXUqTxKFwRX6o6XEqJWUFfxjs/9WmGDyrcTdXFZrwdcaeq+7CeFPHvun7hMyUT+6HwoutHzQDqcVFyWyeWw7dul6OIWtMWzPC2rkz8GzDER6EBxxpzdlEzNC/djoY3Qij2xBS5dx/Ql1iLc7wWt1Bn3rlddaOfIyJNomSK3t5buGF6l5X7OQNn6ipVwsmkw3uJsAO1CfuD08AaNWnQF5hL/pYJACxM5ao1BS6MmCTStgnnAAA10X1riR6FMnMgdtB2tnQacmlw5LB+tXS1l7pVQTEJS/p9aMRcdhaY2nzAksEhOSiSgWaMHNWez1C2OAYb8/Z9KsuXQndhtA7lnkhB9raM+SI/27vkbiBQR+KGLsJIIF83Y/BBRxdf6CDBIsVyMoB1S6elYG51OgLpm2vlg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5NIHjffMl5VvP7WZzwPOGbAelRuVC8eIgn4hMrmMYaNjPnyCwfEb8QX92N62r8Ixl4CB4I03gMefffdw9bumc1ToYU3ZlipgpWacB6X2NyJKzOrNQDhf34xWhSjy5UkMpkIlRN6vTSc7ZGiCJuZgBnB7qg+thUixYKPwWYAjiH5iiY7GIam2MzezmQRtoS6GQHkrDSud6rJ00pIO3jHLCusr6VJWKAQ+cvQTArLpSjegkfX0PV2Z5DZ7ptCBC2XBEidnPOM9qSOUrk+Jj/lTzXdn54UrI/ZD4buLHjAHIpdz/HSTL4U15F2v/WLw4qD81xV1QFORAFeLHP/rad84hUqd/0GDW/t8jD0RsJK3gYv9Ok4JBBerDv1Ga9ib01yYaJd5V01NPhXtAZQMRS7/4shlEnviu4yKvSIyghT47rLBEp75vqaicmP6lq56rHCU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:05:58.8867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5555ba-98b9-40a7-9fa4-08debc4ce5a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456

For in-place conversion, the source pointer is expected to be NULL since
the data has already been written directly to guest memory and doesn't
need to be copied in prior to encrypting it in-place for initial guest
memory payload.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b44b5a1c2b..32a5e605bf 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1186,6 +1186,8 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
     int ret, fw_error;
     SnpCpuidInfo snp_cpuid_info;
     struct kvm_sev_snp_launch_update update = {0};
+    ConfidentialGuestSupport *cgs =
+        CONFIDENTIAL_GUEST_SUPPORT(OBJECT(sev_snp_guest));
 
     if (!data->hva || !data->len) {
         error_report("SNP_LAUNCH_UPDATE called with invalid address"
@@ -1199,7 +1201,14 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
         memcpy(&snp_cpuid_info, data->hva, sizeof(snp_cpuid_info));
     }
 
-    update.uaddr = (__u64)(unsigned long)data->hva;
+    /*
+     * For in-place conversion, the source pointer is expected to be NULL
+     * since the data has already been written directly to guest memory
+     * and only needs to be encrypted in-place for secure access.
+     */
+    if (!cgs->convert_in_place) {
+        update.uaddr = (__u64)(unsigned long)data->hva;
+    }
     update.gfn_start = data->gpa >> TARGET_PAGE_BITS;
     update.len = data->len;
     update.type = data->type;
-- 
2.43.0

