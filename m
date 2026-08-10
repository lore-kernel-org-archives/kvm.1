Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63923B5311
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357019; cv=fail; b=MZL3kL+8exJxYWGY/7IdzFsdydyG0j45l4Vuv/QFOXZmzuTC5FZi0WDrwDadz+zqfWve0Qg1slDJ10wg99KRdyOOsuPvlk/jb/aaiDWImrE+euUJo5nOT3TN7/dJv0TzzYtoqtWUdH4j79/jGd27gxburArf1NXmagTsJ4NKnqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357019; c=relaxed/simple;
	bh=92Ko6YhrbIwjpvotUieIc7qSHr69nc+ASeyDq7ryWzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6VYk9G6KxknmPHtYj9Vh67fv3dR1jHg6lrZHvQ/f/hVgphHkR9+mbk5CI6Mqvvz3A4OiE/TMK0S7S1xLE0+37I37/e/qhG3cU1GNTKx2ljuj2ET9k824jTE2NQ3ONJUpUZmZCwBGMnyKGd/DfOmSZDE/U1kI5fw48FO3ku+tyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xxU1TOof; arc=fail smtp.client-ip=52.101.61.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xxU1TOof"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDU7hoYOktO3peXasCHnzNYchwg1fRfgBQfs9CPyq25qa137bZnOLSfiNLBu32Tl9K0eplN4P0xi4ejorQWQeZKFOU2H7XBSnD1V1lOVLj3UksitNuFebwYYXZ9fybklC1+dFI0N77HYVjaPOGC4RWXLFLOLt27exDbxBHRNhC0jN04E+KRgl0rfXmWK6MzdZAw82cHmDvmamP8DGXouVpEU1takYHZgILQ08YTyec8tk9Uq+DBJbS/JNRRbgugIMjtih02CevlBFp5kU30W1zCQrkAOOTrIi3iYb5/d3huDYijmQhSnn3klojnzayT3mE+pF9eYwSusfcNh+29EVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KVUWuf6GsY6V7sa11d9ZYwCZn0YOgFhxrIgaIXrMi4=;
 b=Gcfbf+odWMLLh6ZBBEbk0JDvkaDfcoGUJPmgSXhmXryRz5dKR1wR0XlQMPpMEPni4zo0I2Jk4LtHF4InhTLiyZ6MGPZ+8V2w3d+mOJChKBg/Yhx/7a7+InoUeydJj9APuvgnLPKgNR5/jfmDhvuL707aoKT3eabJYvEncAC/92E8xZB1AlOWsDZgHyVIoV+dbipqYDIvl2B48BpFSyrbDZaqVR4zbsqccdLoX9pGz7s40Lh8z4NpeEUReD9o6ywoa8S2ln9ETXQtEG3OcJ+yi+XQQyf4gI0V9Sj4PROzxHoN8ju+G/IPyR+OZ6AxVEGFi1fElcatYp/T863P1sjKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KVUWuf6GsY6V7sa11d9ZYwCZn0YOgFhxrIgaIXrMi4=;
 b=xxU1TOof8haSZxAseFVs7sI4yj8jd4iNGPb04v73Vc2r8rU4TUWJD/MiQ7oIHlbSAQ6qWGTyJJFCbWuBiFCE17RahgEK0VXbudQZ7+eSOO3j+Tc5Wc9OKVXSirPCeAflq+pwta6MD+qV3sRvk3cPaM/LVk2Xc0P3JQcR/dPNu4Q=
Received: from MW4PR04CA0222.namprd04.prod.outlook.com (2603:10b6:303:87::17)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Mon, 10 Aug
 2026 10:16:52 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::29) by MW4PR04CA0222.outlook.office365.com
 (2603:10b6:303:87::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 10:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Mon, 10 Aug 2026 10:16:51 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:16:47 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, Yosry Ahmed
	<yosry@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Nikunj A . Dadhania" <nikunj@amd.com>, "Manali
 Shukla" <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 4/8] x86/cpufeatures: Add PerfCtrVirt feature bit
Date: Mon, 10 Aug 2026 15:44:52 +0530
Message-ID: <cdea00ec61978f097d15202a2d5fe4f8fc9c4948.1786345201.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786345201.git.sandipan.das@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: b8313ba3-8b59-4937-9e6a-08def6c87ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+AmPBrRYSe5kENjzibrSgS/i2bbWO5RfFyM/6jK6q6Tj3anKsM8mMH1qs2E7IQ5+oNBaTBclpUr7qeV44UBiILiTPQy16qGnLMeRsgA6DRqYCu57Co77TVCH6BAvC3hUUHTHa0HxUF7oExbx2QSWkSTnU/Eanxzd3m2T62kMl8FR1x0O1DrE1f2REq2j90cPGGFfro3nVKEfF0NlXr5CfJRw9Hx6gKM3ne1Dmw/fH0l423NFaBWcaL1cfKtPl7mwx+5euMkQNKHbzSm4tZM2h3XmRtG9XUQGDBQbxwG8e4MOmPJybyBKhphTPq8pwG4MaKLjASxfIjYwIyYA3cEdzYlawLWcVFa+kCg7MniyOG8KhFdtXpP0icOo3s+/zVDq78Iwl8zFn4xypt6qdFtJGEa+PGuREVbJckw1NIfJO/xCpe9m4sqIVNwu9iX9nzU50/5Z8fLObCt0H6YohQpf7/i08SVl3oiGqHJOo9nxsxgnMDn9Gr5aqKli48egWavDLcc9JqP+oAp0y0ZEU8tLY5OWxPk4zp/RtJcj4xL6d/PAZ60o/gohDxbFW5jIqFqosk/pTAvvyFRw7izIl4er3hBUUroHjMtlDILFukANNlFr+BXbb4rVF+VsUIA6P3WPRhv6YFkHi9BmGnfie8UfVqQLHgGyDBc5TyrBIbkNkzNnqloR1mhu6qvd0a6e63e3PDqVl3AiLpXdBcYsIdmdSg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A8N2e9vsPY+fsZPsUmOo+nHsxKESm8y+5Rvt/H3y6j3tPmpF/H0Bu3vFwULEkDuyC27j5bDHZbfM/z+tE5ALRWkCqLYba5z20iGWCFDLX3k8Mirz882w2MYBx9hHd1EYPbK+TMmJlOOq9ci7gmyq8fmh/Xwj/i7zDElxkYv2DrvVCZNG9Zl9rJ7A5DPgniUpfKiaoHUnvg60WXYi5tXIVYDJzKW95Ud0dtrnAkG5HJJgVuHLxaxsMUM6rqmAv8gRRY/hE6z+x2R6rA6LYC48H7mexI+Jr8G+spRHDWTBGjupQdGGYM0jk0YtswmGyQUpsQHVw1LVpOcQgboNHpTTtm+2Z6obBNk0sEGyCtB0H4TFfKPkR5TYRLseV/q2oVZA2VY+LU/y5QTv0TUaNMD1Y0I6X22rTiEri5dnRQhu7OpRYUfwBgzuxVylUhNhNnzx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:16:51.5494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8313ba3-8b59-4937-9e6a-08def6c87ef1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158

Define a feature flag for bit 8 of CPUID leaf 0x8000000A EDX which
indicates support for PMC virtualization. Hypervisors can use this
feature to offload the guest PMU context switch to hardware. Hence,
this is a required host capability for enabling hardware-switched
mediated PMU in KVM.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 30bb8fdf2a8b..b551ba381b6e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -384,6 +384,7 @@
 #define X86_FEATURE_VMCBCLEAN		(15*32+ 5) /* "vmcb_clean" VMCB clean bits support */
 #define X86_FEATURE_FLUSHBYASID		(15*32+ 6) /* "flushbyasid" Flush-by-ASID support */
 #define X86_FEATURE_DECODEASSISTS	(15*32+ 7) /* "decodeassists" Decode Assists support */
+#define X86_FEATURE_PERFCTR_VIRT	(15*32+ 8) /* PMC virtualization support */
 #define X86_FEATURE_PAUSEFILTER		(15*32+10) /* "pausefilter" Filtered pause intercept */
 #define X86_FEATURE_PFTHRESHOLD		(15*32+12) /* "pfthreshold" Pause filter threshold */
 #define X86_FEATURE_AVIC		(15*32+13) /* "avic" Virtual Interrupt Controller */
-- 
2.53.0

