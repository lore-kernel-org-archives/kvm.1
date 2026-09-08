Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010010.outbound.protection.outlook.com [52.101.193.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869433CC324
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900952; cv=fail; b=XOUG98L/U2T9M7GAON1ip5npKDo6DfC1CphZIV4alYWs/cGwiQChCglYwoH5bgcyecJKvHeFJev3/PkKXh+IibJPKlnBCeCJTAGq3rVd2IKLe4Uw7hLQAOHbfzeY1ayyZBY87KoIxA0tqSOr4tnCDiwoEobr/WuPmqrhloJjQsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900952; c=relaxed/simple;
	bh=dx1MUuzsMiGGEW+FiDYtT+KYO16q6QrwTus2+mROBug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJ/2nK3n1OE0jccVBguduyqgq034H85z8J0oj2HO7RCtrh+s2j7ES6btztkAc5AIHFEJkrFqx+0Qr5LJJgjFvgtQqb0sb7WY+qiYaVZ4TxsQBpY4hF43KEDlkiYSbQ6et4aTGoq1aycmTOrf4buVe4O0eqM6HeD59Uzzr9kaukA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QA96osfk; arc=fail smtp.client-ip=52.101.193.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QA96osfk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jh8tFuVIfVEFZFzz1SLLrgc5+Z+PZZjEcKw3OMbqvCi7vTM/ToofbxwHV9lEw1MSJgaiEGFXasoNwXwKmN66iN5ZLl/OJ3unV5qEz7bQ5GMQXlARnD4eSw/Yc3kqBuehS3ShTBofBi+LMpyXGoAtdgqY7ZuRLmapY/oGdM+OLRTZzoHdFdGuh0er8ABxbNPbNHdoDx5SAIwxWCdXBORObUpmQrSmOYQTjISuUpYncyt7Y2aa79v9UU/05fYlIGnO0Pp1MpW0lfDxN0wuOip6f/DGlk6bCw3mWRSlHmnPq++WJtelTKhz0cOgtzutAW83u3eMz/g7/+ftDs9kvro7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3A94Q2cOVtDXlvyMPEwL0+A6/A4i347HHYt0pOPsUE=;
 b=Y1SSW6gRM63NfuLfQ60a6nuZwY8t/YzuEsrBt4lJg8Ci9G/DWv1X6qRDfJitlx8nSHrw02+/w9Gbd8+7GBtAqMfGnjlazpVKzGpy0CShzdVSdvdWLxL4Hiip1Z5tQo8GLJ4OysapARMqMGjSf5ECxx/rToLyPeNl3A3ox7jC9IHl57ip3kBWHGJSeDFJHDBp3mZahdoKwzLJoYEg2L6r6wh4Pi8QZSJyYn9nkTKR0JWORULyw3JkqBART2iIm+zrvqmto45ryq+ytOLQ57agNVw+TV41MS5FY9pStY73pVBn0JIoEjMtpCzjXCuWSlPnZsjmSgL/AvtHDjS9NxNiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3A94Q2cOVtDXlvyMPEwL0+A6/A4i347HHYt0pOPsUE=;
 b=QA96osfkS0oCFxj6jkTHbRd8DoI4FTqW7pGVGV95m3/HMg8DCYMI58Q7SY901KX9cI/kYVXUTapJsJWzMoafTXICvPAt/yOwVlzbabOytDWhe4G532+qc1ELEhhDM5M5CtxFz/H8UXzphCRu9mVuCaki8nRErIKH57fN7YIlXQ0=
Received: from CH2PR18CA0028.namprd18.prod.outlook.com (2603:10b6:610:4f::38)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Tue, 8 Sep 2026 20:55:45 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::6b) by CH2PR18CA0028.outlook.office365.com
 (2603:10b6:610:4f::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 20:55:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:55:45 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:55:44 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 15/19] i386/sev: Update SNP_LAUNCH_UPDATE for in-place conversion
Date: Tue, 8 Sep 2026 15:48:35 -0500
Message-ID: <20260908205236.838281-16-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea27d78-2d2f-4268-97a9-08df0deb8d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|23010399003|376014|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ry+T8umK1UqygZ/xUmyKHlLrfGbauwEHNokN+McvLyJzytgI0dwlUSHbx9jQDEk++bvCKkpBqHSYRdauNvpo21VLoQir6Mb/xJ5kQ9U7wgc56vVnVL/OaHSgPqD5hjJYoX/IPb8MB2XxEqKZLnOy6NKD3RiG5K7CJ4/hGvm0yWEowJyBJgyf6essfLe0BsgX4UEVN/H/peT3yXi0J/nAQF5Z2rwiQ4wTdMzawap4PXCP5pkFjs/VJHAu4HlTdV5kKRv469Ktx7u0u8pVpd1ARl2cOt/93w9mWVRA7Oe1zfjLE+VAKenLhdE/v6+gISLaXkaJsU8iapeOSDFjy8wOFedVcK3Td7uUM4GzQ2p2fwh+6KGexVjCJtpvoIUKYidezoUAOSlJ2/n3yeykvRGPlyZ3YUyy1nkEgXmjgmpnts9QJ5yc8vqBtjufqSenhCi8MYe8I++ZFx69zyN9zFDCSlOcsldPDfMEO8KpkcYDOvrNAkx6Mso9eA+L42bOoSn39Cmi8eyayYRb3CiAF1RdaphKHH6rQKnrlf3wssjnW7HVb6u4Xc5ICE6x5WwLRVSMmxznFDCmABJ8nMH+hFAA00DKTtCaFP7It9kFCFGYBNYwj/z2IV4fiFjSh1fSrbkJSMJ+fBBUWtOYP9VAB+LAvGmZnVxsQ3PgSiJdPzKB+ZHO6WilJjMaAvoUPrROve8ONnkTIr9VEkkxH5/WF98EaQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DuK1VEJS51FFoN6FqCngHvXM6SzbJ++8CPzbEch+47C9YKiGhbxh4255edPe8EqrNoJOfVCg4OT3zn9cvXyurvbQcP1/zO27C6tSU7LJ412sYWltYd1oHRIDtSFCiKUTw9djUOuzjjycHDlUKY/1VYJjSnFni17x4bB12+EgIsecEv8L2eNR6ZXsB76Ev/Mec9c1+Vze9G9IBpK3CCEUIX9mBmr81O5k5si13m+sw6NjydcOUYCIh9OmFuoA4HQUHrV5s1HpwYxs274ApTC6otH9dlE6P8sPrt1XNK9pj5aIj8455r/E3fDd8a1oq/qhj3Rz+dl+8tOPZ+WD0bL/day88GgTHwfRz0CdEr/FEYhYxUftN7M27IvnmADmW2gkR5su3MjbVdcqEfKG3uEFhMWDjMA5K+0z2yf6p8aMsl1rzqPAS6Rav9xxRs7x6/uA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:55:45.3700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea27d78-2d2f-4268-97a9-08df0deb8d9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485

For in-place conversion, the source pointer is expected to be NULL since
the data has already been written directly to guest memory and doesn't
need to be copied in prior to encrypting it in-place for initial guest
memory payload.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index cc16c6b071..87d88b7920 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1240,7 +1240,15 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
         memcpy(&snp_cpuid_info, data->hva, sizeof(snp_cpuid_info));
     }
 
-    update.uaddr = (__u64)(unsigned long)data->hva;
+    /*
+     * For in-place conversion, the source pointer is expected to be NULL
+     * since the data has already been written directly to guest memory
+     * and only needs to be encrypted in-place for secure access.
+     */
+    if (!machine_require_guest_memfd_convert_in_place(
+            MACHINE(qdev_get_machine()))) {
+        update.uaddr = (__u64)(unsigned long)data->hva;
+    }
     update.gfn_start = data->gpa >> TARGET_PAGE_BITS;
     update.len = data->len;
     update.type = data->type;
-- 
2.43.0

