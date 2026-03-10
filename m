Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010026.outbound.protection.outlook.com [40.93.198.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E434F346776
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122450; cv=fail; b=oiHy1+gTbP4Q4TuagW+yNQqwQQmuoDEBk2W9zQb8YZs7TageThnSgKRj5q3HC+P5A+bWmII5Owk2mCGP61NN4iRbLlZikY/4boYw+mSg1rO2FBqfPQzfVQtJvqXnSxXMHzT6b/eUZCw9L1iwu0XpxTirjJgUr/tzkLpqvWuGqTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122450; c=relaxed/simple;
	bh=h6xgbzlJjEAlMzQJDMOUsVoEhsT3NOIod4Mr6fvphNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAtq2cVYuRqjFypWbS89SPUnQR/pgPozf3gTB4c5a34Gamm4SjQf1kH/Yq/U7y0Couvq5fIue2d8xeYEzblySLww7H2bmeL0IRtIZ5cOoaWNUjBu3maKlRL3KbSIVSbFHjPf1oWYxZGpu/RTBoAuTru9txwpDP8GudtpAUwPoS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M9oVas8S; arc=fail smtp.client-ip=40.93.198.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M9oVas8S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skkMzKsyBo9BSbcBXPc3IMBPAayACt0i18Uvj3qAVaeRlGLPgLhgXbU6HKwcq9g68cw3rJck5ho3fVfznhzUOeQ7zXWniLK3a1Zm8PNqyrKpg+m8GEjjjDKIoqevt6uRTklhI0tHQn/6sV+Ex1gt8hHv2lukS8lV0GFMYyF8GmPK2ua8jahWxpIX2Au25OElGKqDnazjqa8UQcA4R2g8yv9gIST6ZrzFnaHg60vbNW0F8d3jT5Ec97UL9nVOO56N6u6CnneuTZowt2t/uYrWLk3b8duSPlpDOsbM0CUWtBw5FQruEN2HaWSrcYVfNU3Y0aX+M2eDUAdZ0/W+jDfwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev65VqgMhuAXz9XiqOkot/BytX3hXsAZm1lnKAul2YM=;
 b=CK1D1/FMIRJj1lm6PuXNUA93mg2uC6qIJDYeaazsmQAlIYtzrLHv/NnJlgLNLwn65hdt7ZN2AUtup8T5W+YjFFOgGOaj/OAbaWc9ZudIOZHJp8rzvcvhGeW/VtNHrLfnUU2Enhe7+3tnKr3dAxVs/0M6fQbcQ9xFnIuDC59ug14HtOW2dPel4RjbmUfl6uhpV2nsyOA6cifFhUQ2f3W1AFM1kKURpZKHZYGSB0BdrTeQ3DNFooBsC89GvHX86Pyb4QWz2PDOLr1vosy18x8xUWDeyPWJuiPu3c0uKIz/yR9/yIati7iYGEKSh8DAdLIAVfhyUvYVjISh/zaC957uOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev65VqgMhuAXz9XiqOkot/BytX3hXsAZm1lnKAul2YM=;
 b=M9oVas8SBhKQhFh9B4kub9jUOqypr+nmFznJaTSDnU4322+tqwGjQZcGwGFiO4UugG3Cohea6EJfWwnhNxNe1S9Qd/hwhr9oiOCiPOAFBiurpyMaI52HU1LN60CfS2BhGknlakbzpzZJ7H6XSSErCB/l4tP0HTd+fuVZKBcCemE=
Received: from MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20) by
 CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Tue, 10 Mar 2026 06:00:37 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::26) by MN2PR01CA0051.outlook.office365.com
 (2603:10b6:208:23f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 06:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 06:00:37 +0000
Received: from volcano-f23bhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 01:00:36 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>,
	<Naveen.Rao@amd.com>, <dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>
Subject: [PATCH v3 3/9] KVM: x86/cpuid: Add a KVM-only leaf for IBS capabilities
Date: Tue, 10 Mar 2026 06:00:15 +0000
Message-ID: <20260310060022.15120-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310060022.15120-1-manali.shukla@amd.com>
References: <20260310060022.15120-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d52e5ed-553f-44d2-1caf-08de7e6a5a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	y/jjNsaKY++Vrtc7VSP1wzakb7FcUG84yBSuZU0d35ptbsZoa/jYKZxBFi1Vox1nQo3l4/+YIi6/0acVAeMhea4H5BjUgsn9RY3JZIr43+s02MLHYiGXFwwC9+dz4v2e4RQXDhm3UWWQtJ5Fot/vqoQk+1cN4/HbbuDdusnGy4BoEcTpu0wXCY9xVXdD4QtdRqA/pnLB16iPQyPR2TGDl2mN5XbxE12NuCKKHM31L/K1tBnQLPtoXa++pYEOwny1VocZ8JNG8sMoFehN4WC0MN15VyTTh4q6bqeB30vryoZlXlW+s/6VVJSB6nnnohJkcfTa4mg+Z1n47hbQPc1zf1cWOV2kSKi6hu2Ckf+4j/YUfphAcuvHjV75RW3JCa19odG9l/IgA037wZ/JOtDTETXu3evcp06yXVyXiA2d5cWdHJYTg3F5yF1Y4m04pWhpMWwOUssQ6KPn0IvGm7tswWm2MVhazP74BWMoKRoUBSc4uYDUheTxon68noFtL6nAl+uZldV98zHWnFUn1Xd6D/Lk+IBYPSC5JA8Az4Z0VIns6NHc5EcBgKSajTd8E9cLYn+I6z1exclCXf/GV1b42UBAdGHIVC/V7t6hkzzHKgETQ/GPHxHc6gJWicjLcnhXz59U+sVDoER3UPa19lkT752roOww396OM2A1QHvy1e8++Aa+YB450IiTtgxRWiQiDWuYhxysLlgx0yJeIJjqIAUc3S86uXxTAJCREWoPGQMP6BudbCkBRIHM3ciIT61KV/gqtXijr97bSzsbBVw50g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2RPijYsd+zLuzq5QZbJ3knSnlZx25zZypqwc4BVxxe+XNwpSTi18K8FtH5cn+uS4nJAZkiSNPCdBkI3668YmlOnwy9sGlSmeI/ka9LfS5JkVZ7QWhRIXHOZ2mt6U1nWRX8TzDgqA4cfE72lxW39X8v7FJDTdkoUzNVfn8LW/N38g2m/GAtOOC9FjgKOl+MXdDOVDyaWpqUJk3y2CP+D9smaHi6eVR0OwGBjf5wg1jAI6yEGZAXsKuNPQL86ST5ufkDuiyym5M0pxxOPJLekRrRdvvm5p1BNM92qzgAbUyPvTmZEllz63OFmp3RGWiKr7bLHcQ268EvDRDLnX8aqJ8MKPO++a/ST0h2pDF1WGTrRKFZJ7rq2GprD9eSR7pTSPAtA8YSieEHJeJ8D0+BnGCEfYqqumln5YpA7zIpQSuwT6cE7UPnQEO1uCDjg7PjGQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:00:37.8337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d52e5ed-553f-44d2-1caf-08de7e6a5a3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306

Add a KVM-only leaf for AMD's Instruction Based Sampling capabilities.
Multiple IBS related capabilities are added to KVM-only leaf, so that KVM
can set these capabilities for the guest, when IBS feature bit is
enabled on the guest.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/reverse_cpuid.h    | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 32dd2d55e6f0..01abdf7f112b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -782,6 +782,7 @@ enum kvm_only_cpuid_leafs {
 	CPUID_12_EAX	 = NCAPINTS,
 	CPUID_7_1_EDX,
 	CPUID_8000_0007_EDX,
+	CPUID_8000_001B_EAX,
 	CPUID_8000_0022_EAX,
 	CPUID_7_2_EDX,
 	CPUID_24_0_EBX,
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 657f5f743ed9..22cfdb331e9e 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -76,6 +76,21 @@
 #define KVM_X86_FEATURE_TSA_SQ_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 1)
 #define KVM_X86_FEATURE_TSA_L1_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 2)
 
+/* AMD defined Instruction-base Sampling capabilities. CPUID level 0x8000001B (EAX). */
+#define X86_FEATURE_IBS_AVAIL			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 0)
+#define X86_FEATURE_IBS_FETCHSAM		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 1)
+#define X86_FEATURE_IBS_OPSAM			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 2)
+#define X86_FEATURE_IBS_RDWROPCNT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 3)
+#define X86_FEATURE_IBS_OPCNT			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 4)
+#define X86_FEATURE_IBS_BRNTRGT			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 5)
+#define X86_FEATURE_IBS_OPCNTEXT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 6)
+#define X86_FEATURE_IBS_RIPINVALIDCHK		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 7)
+#define X86_FEATURE_IBS_OPBRNFUSE		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 8)
+#define X86_FEATURE_IBS_FETCHCTLEXTD		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 9)
+#define X86_FEATURE_IBS_ZEN4_EXT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 11)
+#define X86_FEATURE_IBS_LOADLATFIL		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 12)
+#define X86_FEATURE_IBS_ZEN4_DTLBSTAT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 19)
+
 struct cpuid_reg {
 	u32 function;
 	u32 index;
@@ -105,6 +120,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_8000_0022_EAX] = {0x80000022, 0, CPUID_EAX},
 	[CPUID_7_2_EDX]       = {         7, 2, CPUID_EDX},
 	[CPUID_24_0_EBX]      = {      0x24, 0, CPUID_EBX},
+	[CPUID_8000_001B_EAX] = {0x8000001b, 0, CPUID_EAX},
 	[CPUID_8000_0021_ECX] = {0x80000021, 0, CPUID_ECX},
 	[CPUID_7_1_ECX]       = {         7, 1, CPUID_ECX},
 	[CPUID_1E_1_EAX]      = {      0x1e, 1, CPUID_EAX},
-- 
2.43.0

