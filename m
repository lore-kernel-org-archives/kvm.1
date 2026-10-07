Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42884AA56C
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380794; cv=fail; b=b8wgEOG8s2+uB3AkxG9wgWksaB3TxRAusej8uL68NTv7Ozxwc7H/rBOFZmmqAch01OQ+Gn0WSVXhl2lmQKML2A6X9wjzlr57KecitbyJEvYS21TJ/H6uh/FwldnAGQrOI6Ye4QWwSJXiPz1V9vAQ2vGs3LemAu7c/7W+ROufbJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380794; c=relaxed/simple;
	bh=j/t5FAT3UR1qPf5p8Xw0Bzx+JALHiU1LT8x58gtf2fM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+PZ3rwbJDgVuWJl3+xKK2LvFZ/XZW1QaAWo1ah26FYgyXJWlnOPR2n/FI44I/QgzhVkr1hnYxfYmB0OZMdDUg3h+WYUmaosyJuN0Yy1p0cASzxdD9zXcLZ8/fnvFs3O2coidXh9lHKHYJoZZavCMADQfVWqVtpC/qX6KdZppH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l7D3g7AY; arc=fail smtp.client-ip=52.101.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l7D3g7AY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIO20hnbTfJ7YwyTpUAaXeNznMT65rkgCxZ1w+vfAytIA3N1OrhGsYjCijleeHx6R8UIAnp5dlP6XLwX+jW+PqQiaZ3HRRS+SpVvMQ23kkkR2+tgjiWkoAB7BlgCxKhtg9eOJGOq9TQBxcY1rv9t4BJ7JQj3Si1XEi3yPkmUd1T7m6cZ3Kfe+zxv+y4nDrRZ+Riafs+OkIlrI0xgwEyCHjnxI6/D1sTBNuQ9IZcVVOIXGmUFrQgT6xfOeFCGZ4R9dUfmM41Xx46vPngINl1y5C+jacVnPCk8mTQRlsA/QTNqafjmhjWF84kjM2lc5+daifRFVRxJbLir62m1/WxB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+9pFWPdUevPO3CUOeSYuAd6LHqX68eHW18LGHa5GqA=;
 b=CLUB3BvSkpcJmruIX8RZfB7M3VBwJP9QxkErqiPRK9eQv563hw1dNNfeeJZqsE41Aj+C0pJkTNpCOQqq5+f+HGSzyo3Vm0RHFmESvYqyCgGX4YZWcFcBZ8AdpS1ww/HJjrpAP4lfWgRHYYjt5gMKtKl17jBZoHJaOa+VLlKOlwWEDNifRYJgU0qDLQNiSwxS7aduUrdWFSWbTJlII2c+fSe0sRzdiAzEF6RJpFlfdGwumziZFSKSRa4OzA9mnYuOS1+/GcPA86jFLehXT2sG3xvJolYnYoqDQkDlmWHtYNktM4oZ0HDp55+r81I1OkNIqENtW7aonp/YFFcTEMyMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+9pFWPdUevPO3CUOeSYuAd6LHqX68eHW18LGHa5GqA=;
 b=l7D3g7AYiiOefzRkPNsFK4laearHZ4u7k/LRKKhgl32AS95IWyzJG7HLT5A3tt6MwZB2iDPwDsdPvEW24XqMkvQ+cXEv2tILlj/OPI8i7pQVBtMCHpdKX8GWhwNFkomZulr20ypPhS3IVsDD1C4UtaSNQnhkTuV+H68Lf8pWEPU=
Received: from PH8P220CA0034.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::17)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 7 Oct
 2026 13:46:16 +0000
Received: from BY1PEPF000264B6.namprd02.prod.outlook.com
 (2603:10b6:510:348:cafe::1c) by PH8P220CA0034.outlook.office365.com
 (2603:10b6:510:348::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 13:46:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B6.mail.protection.outlook.com (10.167.242.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:46:12 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:46:10 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 15/19] i386/sev: Update SNP_LAUNCH_UPDATE for in-place conversion
Date: Wed, 7 Oct 2026 08:41:39 -0500
Message-ID: <20261007134323.1606088-16-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007134323.1606088-1-michael.roth@amd.com>
References: <20261007134323.1606088-1-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B6:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: bd81c8de-c68e-4697-739d-08df24795a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|82310400026|376014|36860700016|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	lTqGfJqtUmv3MroYlaVaC5rdwYYy8NQl8LsoSwmWTsUmDtEm486jRYdAbjPM6F7tezgRUHPeZSEMDoiZ6X0P3GnzAZRWXsp35G5JaXUP9tsEGVzswG6jBLx/FzZ6EU3QluAJmzXneqwPmF3GkLVK4xUj8vg7aKEQZgDXX4kEZsWX/aGPLJbtQZAOgwkn0HApHQ5icr/fAH4JXz6206JRFaP0guYarDu8AOxEnINHecM8Kosu/I/u+a2pILX7H+VCA6UPmWHs26DkZ3EjhOMOkf9Nca9wA0GnY+d35S77j6AXkvKsSDjYEeowNcr9HdgLq0Dn+Pii4t2bR5dq5UA6cN3HKIBU/v2endGpIYG21TJEWWexVTyw9UwOVHzTYXL0yuGXH9G4meJjWLN6qKNh4Z45CkE2sunLQifbc7cy/Peuojg+CN64BC9VS4pNrYvuLdRwVdbWLJIvAEuVGBkIG0bWDn+Fndrdu5uMNP2h4RSXG35BD7z/GkObSz0Hxi3yzV2uEAg8/8mWuUrZj+6QOohY+5VHNwUuvEH4rtfzYNPmmJAxnPSCyaWlNoda9p0IO0cPM91+Vv1PNIO4umakORKUMmfitDDle3q91dfP10f03lRKwlGmDz4E2o4Bgs54ETEj63aeGBVB0ivJuSNWg/JD4smbYGYR1DfkAdGThWO1C3MRCtO+hZFv8zpI+vOUVjfJnmhMR/2GLFmHs5LF2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rhvs4fWMyXGYnSCrwy/jaUNyrRDzo/OM4n7HHMgIdafCgS3tysYKMzUy6D+/DYzryH2kRz1WbrMSVjWFk/q2faMy6dJYk/c55m2s/gTFPsJzAFiYKT7IMLxk7VtvfUNvSaow9aLftQKlbYVjgonKFuAFWSjJ/LGbCRPh02k6GYtryBymhcw0rxJnfqkhXV4ebGcYkXHXzXRqUAgJa7idjw+FfM+RWHoBtomwxbaecSpmVbiIH5dihyjYdtVku+oXsafKotFNmai7s64v/DcR3VUJ0w96r85L59mRBWHsLQeYiJU5J4Mww5qVc75NxVJe5AJz5kflj9iqjyJlExgj4WUYnwwxkJ0r7CzKphnpt0seJnWdR4VblKFdQzvt7OrmV7W6YcjaOOaX70B5gs8xPpCtjyO7HpbZcdHMTyB1g1Ve0uL9L8lasqiCHyrXMV/T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:46:12.8687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd81c8de-c68e-4697-739d-08df24795a03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751

For in-place conversion, the source pointer is expected to be NULL since
the data has already been written directly to guest memory and doesn't
need to be copied in prior to encrypting it in-place for initial guest
memory payload.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index cc16c6b071..b28a31b7bf 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1227,6 +1227,8 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
     int ret, fw_error;
     SnpCpuidInfo snp_cpuid_info;
     struct kvm_sev_snp_launch_update update = {0};
+    bool convert_in_place = machine_require_guest_memfd_convert_in_place(
+                                MACHINE(qdev_get_machine()));
 
     if (!data->hva || !data->len) {
         error_report("SNP_LAUNCH_UPDATE called with invalid address"
@@ -1240,7 +1242,14 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
         memcpy(&snp_cpuid_info, data->hva, sizeof(snp_cpuid_info));
     }
 
-    update.uaddr = (__u64)(unsigned long)data->hva;
+    /*
+     * For in-place conversion, the source pointer is expected to be NULL
+     * since the data has already been written directly to guest memory
+     * and only needs to be encrypted in-place for secure access.
+     */
+    if (!convert_in_place) {
+        update.uaddr = (__u64)(unsigned long)data->hva;
+    }
     update.gfn_start = data->gpa >> TARGET_PAGE_BITS;
     update.len = data->len;
     update.type = data->type;
-- 
2.43.0

