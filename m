Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034345D19F
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922756; cv=fail; b=oqlW2ZkbQnq4705Z9X59nJxikWHW1A8YNEF+E3boiAdmBboIZoskgdi340uSWZorTjP/3GCldssGJJ3YINQowurtohRTC6/Njo5tuua0arZL34lhNCgQIMUDTY7l7Zk+y2aAaHp9ieez+nlQKXQyKvZZQo49t5ZFhEYzsVbpr6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922756; c=relaxed/simple;
	bh=bQ7Hne+iApIuh3Lb7Cswqbbi8up7risrGkg1zHJHToc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAuRX7E2wF0gHn/6fT5xxcwLgEmk4yizlQ5Pt6aJLmu+C+mo9AW0yhm1uA2BTG8qYuJMRtA/6xKdJ4ofueMAXHP+smhag0CGQ7gDKiM2UBf83+A67IJfDvwS3Zv+x5ZEYlQPTGxm2wVHZtWbgzNVWrIkaUln5RTbSpkfpEiJq3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VFIDaEFF; arc=fail smtp.client-ip=52.101.57.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VFIDaEFF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crO8l1Mr2b1Zm4Z41Y7BG14+vJ2+csLBIvvVZxexySaoluiDELODWdW9qauGOGDcdukSRxXi0Qg+S89VF+ms5rjTYNXOpxB0FZAxMskq3+A5pdk2mdle8Yc+vPKag2frv6jCCLBHPWe7BbDuJrkrpXP5jra2K7LTy18nfJWhkj/SrIB4+RCMOyGS1Efhuph5YXyzGa2+ZSrBvqx4QmjXfllOSeNYbsNr/1sq9D+qwkaSAPMV8o43rnStBxBUgNRB5X/a9p3Z92WUz4oDshWySNLNw5Fwo4J2npY1PQf+KNpdU6YSSQR3wMdA4Nohy7JOmCddzLqdjjPOA0pbJndzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6iFdscwt8liu/y9ONASlFqxPXgflGQy5NTZ/hjDSlA=;
 b=ixw6wVFOywMEf0xc6H45WRHOlzhE+uSGTcUYozDGQFQn6TLdXkNNS7zU8+wD3kfH0UbUmGsmV6y5jOdneGlJPxzlc9qUm367RY8V17q2A5UfUsH2Pohd0Ib7rcsTKaDgKH98Bc4MMSKwmRqMFFDsOqC9/lkxxMAOBSG7ZnfcmcGzsbOaylLEp04flfGnqensiIfKYn3ZVF4J/h9ZY+4QslC+EcC74HZn+910eXdBPd9Rm091ggcHW11CSGnaHuQE+FOmS7oJWzKQ9aUODrfaiKFwsYV/pkwuJe45m++DUGgxhWwKIb0t1MyJJ6krtEL2hi4od7tFEhaQLXaTH/GEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6iFdscwt8liu/y9ONASlFqxPXgflGQy5NTZ/hjDSlA=;
 b=VFIDaEFF1eVXRe+6FVIW2gmDAzzN7UWtPQ58qzsw9dsR04a9waHMLO66uUCG6Tq2mnegEQL+7QqlZGp3w6JXmQ6Fjx28nfboXEXWb4tEWwlS+rqTjgGXYBVzdh3ww9fsxHEii+22jemx1FYdMndCGu+w2sII4ih88udN5uP3CWk=
Received: from SJ0PR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:33f::15)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 19:52:28 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::8e) by SJ0PR05CA0040.outlook.office365.com
 (2603:10b6:a03:33f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.9 via Frontend Transport; Fri, 24
 Jul 2026 19:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 19:52:28 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 14:52:24 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<sandipan.das@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH 1/7] KVM: SVM: Add VMCB fields for LBR v2 virtualization
Date: Fri, 24 Jul 2026 19:50:34 +0000
Message-ID: <20260724195040.630468-2-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724195040.630468-1-shivansh.dhiman@amd.com>
References: <20260724195040.630468-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d605c9-9d45-4d9b-c650-08dee9bd1754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5IIfjjCWC8yDdrXZx1+B/Be4tYUL9CPKzFNDz7AkHdt9pB9byuOfvT8K0jVR6W9mn/GzeB0hoTzCyqdYF31aZ14ErEESvWpUgWv4G9aqWJaW3MUupTWIuj77bwLA0UKFWQD1PmZ3yA8ddWxARcdQ2ysjE5MJHjXaSMVRqxIqSHujAeD+s3mub2XAL2huqWFUX3CUq2cmEkGIpdtuNPGp5Pum/ym6PEipy40+Roym0+KrLJQtU6Q3lXKu+JwvCAiJ4yW0EH+x30Hy8hxPRxmhgekY+DOeRQIGzJiK0DKPMe+WKXyIbo+7cewi+up5b+WaT/kdPJKOqhPNpTnnBKz5FL+EkvxBz/uBTsTz1tAh9dMTTtqh8rPmwEWRQVXBLcmtyogQmZCpnBS5XUD7rmIc0bxtgeJuG4a8GQC9PVCs0i3SLk7Q5gNoX3ecLA2p+zg/JtxsSlOfQI53ceUAZYyKcIdkzoe29Ue8glt9z7FBMJZhN4M4APKiA9Q6AC/k8uEPvaSkNgLBKDLcDcPEsDvv6vttncSyA7RTTMio0TMEv/evggCgHkzsAT/loIm+koHr1tBYP0GcF2PGsFF1bzQV9LupZ0IBxqDqg1GRm7wtGu/T4iZo4zxK+r2pq9BnLHRm3YGiW+zSXh464aW2yCZgK6a5sNa0wKxyxCR2nfd8gGqvesqpxKQNOunQ27Z4cnrGUH/ABELU429Tkfhsg2oSaw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dVg0Vu/CsveMcpIB5soLqtk3Cc6LO+A3z7wzOkceWDO8UhM/+lkF3QUjVUvVFCooduINxwwZAe8z0n8yXD9JNfqv0iLOQHVdbkjl1voIW/60F3ozAnW/Ya8pk40o2VwevV2JlM1Z7P2X1BB+g/ajr9CVLcXNiyuhkKnmekwRbbmYS6gm4X45XQ0XZramnA7yonGVRDTFOLo3lms0pT7GrBy8qVYJAaInzj3uwHdZfOYMSC3wOTrz+mYjxu+RPJdeezou3phR9cetX8mL608cKbE+YjKE2ZeMPp7Ddk8OWebsHB6RH8wWdTZUYTlwTwArIFta3xtP2R/PF3hOquhkPorUystUy1WgIxH+Uiw2ttmwiV2rebTSL4D5dJ5a7cmcURDsaFGHbI/L1QcLC3WrGIjq2wKOVw5wxtXxLYHKmoN4k3dA/sfQ1PSSv4n2D0lc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 19:52:28.1370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d605c9-9d45-4d9b-c650-08dee9bd1754
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945

From: Sandipan Das <sandipan.das@amd.com>

Define the new VMCB fields that will be used to save and restore the
state of the following Last Branch Record Extension Version 2 (LbrExtV2)
related MSRs.
  * Last Branch Stack Select (MSR 0xc000010e)
  * Debug Extension Control (MSR 0xc000010f)
  * LBR v2 Branch FROM (MSRs 0xc0010300..0xc001031e)
  * LBR v2 Branch To (MSRs 0xc0010301..0xc001031f)

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
 arch/x86/include/asm/svm.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index aa63431ba92c..fbcf6c4dbb92 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -368,8 +368,15 @@ struct vmcb_save_area {
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
@@ -552,7 +559,7 @@ struct vmcb {
 	};
 } __packed;
 
-#define EXPECTED_VMCB_SAVE_AREA_SIZE		744
+#define EXPECTED_VMCB_SAVE_AREA_SIZE		1912
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
 #define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
@@ -577,7 +584,8 @@ static inline void __unused_size_checks(void)
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

