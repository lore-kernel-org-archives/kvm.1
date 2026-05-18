Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE537B41C
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 05:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080401; cv=fail; b=KRcH/sQWINKIkGX/2wpOS2108PkaLSU2lS06FBORX+UFkm1xuqYrWEw4frEzr0MDuF6dXeNnVW+zSfeQQy/HJJJDZaj8+Wqn6LnA9Wy4kzTjHrGziwiQ7qLf3br7FNT/hQEyZSu8twFp4bs2wcicUQePzPg5chFuxS8IkpQN2AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080401; c=relaxed/simple;
	bh=tYafweHqW3od5pmCDiCStrA9nW+5Xqkn9egcdMEuxRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQmsdDUzp6i6l+6vCT5/RIQhvZFnzBGRf0TQzz985mUetWMuWgWmyZRQet1b52T164mauaduTP8p4l8tRCPqmj8TOKktihRsLXq/ph9jBLrYo/6MkB4Y1ZBgaEbXUnUPyx9/ikWBr+xoL36UmqUbXyibJ9fz/A7U3o44LWwWZJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ixRAf6lF; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ixRAf6lF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LusKkfpgN5YDiQGgUktdXYzLY5tZzI3b6Av0m3uK2LtHgmFq2H9CS4PCSw3qGsKrpz3CdCjkN9oV22AMkXnpw4OUp/GEeDJ6NJ5+9/w+38meceoovnc9ChKewI/BqR32USQ8FAfkzT9OeNd+Nj8m8WEOqCVt3h0YPJ8rYCjLujqIeeUuSQDDTEqoyuiJn3LURldz/cY2ISZOU1D0cIA6M75IlCazsuwY/oSvG7tSDV5Em/2spDYsQPQtnVtOTGFmslyX2ARESmsPfX4CmrMUzqP9P2yXrwVj+Jn0i8JM5JTSnwFmAhBC0ztAqEg9XgJh97eUbTbdNnZcu6Pra85s4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxquSmfGjTNN8GT2DWtv76egVRPrYuza6ywQpmZARuo=;
 b=UEUmoXb3SW7sFtJdCFFIcfVnpVrTo5yOdanxjFkjfjVIB9rQYGeZSb2inxxSJdgyZEfqjWi9v7sQAWljmF37iuWjTv16lQEbP4u1WiM7UbBAlXlqwvtBRdvg1Qy5Mo8b6w61nrU7NCnkw02iW5Q91VogolvleiYnshBEWJa+H3+SBzsEImgfpPKQ1tg8WcVBFjfWxdggdA7VFHHK98ooJALncLO1G2WB+DiWp+wLMXC//hao3NrAeuWG53LLM5XmHm1Kdzk6LtfiXIZY9SumWobZNC+xX/Wa2YEibKhwQk5gvgcQ2gcjaROOLMnnGWgcDj2HzWXu2/dQ7eUHoWO1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxquSmfGjTNN8GT2DWtv76egVRPrYuza6ywQpmZARuo=;
 b=ixRAf6lFgFdsxm8dAUETHrU61Ttsd8dX4qcsXCQZhOMURveTeZDsh/C6NpkerNXYTjCXkc2ybJq1S+4th4HPUdljiF+yfiJ6RXEe6JyDT3lADFNSL15IBziF0dgUkFTmJUqkAim8WTnfLkfeluZ60ws7QLCrSNpRhXViEke1ClY=
Received: from BLAPR05CA0045.namprd05.prod.outlook.com (2603:10b6:208:335::25)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 04:59:57 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:335:cafe::69) by BLAPR05CA0045.outlook.office365.com
 (2603:10b6:208:335::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Mon, 18
 May 2026 04:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 04:59:56 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 17 May
 2026 23:59:53 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v7 5/7] x86/cpufeatures: Add Page modification logging
Date: Mon, 18 May 2026 04:59:14 +0000
Message-ID: <20260518045916.2988667-6-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260518045916.2988667-1-nikunj@amd.com>
References: <20260518045916.2988667-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b652c0-30e6-4109-9db4-08deb49a4e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|3023799003|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	A6UqrCJ1l3nSfWfLV1x2UoAnuvK1Rw4eTKs3gFrWF/zuKr0LJTIAvuIQLP2QXEOZg6qgZ0kFIdjpUl93//TF7v3oCDZwAGv3yqMS9V4uDuFwRszgjiubcXtgH2A8BtXVWXGmKNgnQpwFNgKnfsWt/towSO10LKCjh0cqHQvjSYtUbdg8SQbaI0xXikswgi+9xWCSSlJPEJHtCE2xNW7aUQ6n4UYu1ISujIpqcndoWMG78yovC6wZ7Azz9/Ch4GG+piBXYW1L+zJVy7k8lbVTNAvd00V8lzlxf4KEqwoJP8Aur8XYJGtQYoOp0SseW3Kn1saClSKEKP/hd/MzqpmzYr5bJw4dno+DuHII53beOCY+uB2bcE8QvUjP+34F8R2iDbuGmlXfdAx39IVOE/2+QeYDwFjxxv1t4CY7i32QhZfrk0fIaTw2Sp2NvlWfFfH0ZvlZze1blx83ZNTHr4egb4/RXGJJt9DruJFM3lEUEdFXmtKCtIaxM2j55LK0E1DmXyQMh4dOQkfczrCQJmyiU20c2Bva4p4iuy9zmBzDmSUGdpGSTIaSbhGn08CWf4axVn+zkx78IEi0lW44/JXyLoku4Fb28rVz52OGtjrgFavn08SYcKRgybJdepjioIJBMRYTHohQ/UujNUpA/cZaUl3jI96YOQ6y0q7UneN94nBg8VQaiH9N750RhKJPwqrNEVDYZNiNCTLnK7Vxd78j03PD7N5Ow5g88bpPILWn5Q8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(3023799003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sxf4uUeKVDSO7LT07Fbr48AUfjMS0JB8pBWRF4wzUa2rTUdpYTq9GrBZlmKkUBdVWymJC/SZatGcQta3JCURl/YzNv9FUcZGxOmkO/vUBVbLoiafDX7cz/Tzdi2M7qB5OajUdF1cWLeD/E2jRyasMl8GlLG6FClz9UC7kxxkgjUlMYun/mWmNeAbp54nZ9Zo7/9Mvcx628isEMwMR1B0Psx6pCrihGAfHa/dD+rJaMsKnNk0rCSH9NWLDzns7CxLeYPifomIWp3czlQGhNs/VOoeXTEdHxuLh1bWNmZA+2WgNGLPT2/4iLBGyyCEvYDoI+cqxnELfRdOS7+Fwxmm8N2oL5FHOLCQsi5/ijjZlOc803FTfkbV9hjNvK0dhhBT+ysVSc5zPUx+ZUxEoFZz0wZBtPz8yZscEbTvlqsO2v+CqKsnqys8Widlft+grTzW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 04:59:56.2200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b652c0-30e6-4109-9db4-08deb49a4e2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163

Page modification logging(PML) is a hardware feature designed to track
guest modified memory pages. PML enables the hypervisor to identify which
pages in a guest's memory have been changed since the last checkpoint or
during live migration.

The PML feature is advertised via CPUID leaf 0x8000000A ECX[4] bit.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 35a2a0f9ab32e..f743f4643d897 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -228,6 +228,7 @@
 #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
 #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
+#define X86_FEATURE_PML			( 8*32+23) /* AMD Page Modification logging */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* "fsgsbase" RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 837d6a4b0c282..ad29798cf59dc 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -54,6 +54,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_AMD_FAST_CPPC,		CPUID_EDX, 15, 0x80000007, 0 },
 	{ X86_FEATURE_CPPC_PERF_PRIO,		CPUID_EDX, 16, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,			CPUID_EBX,  6, 0x80000008, 0 },
+	{ X86_FEATURE_PML,			CPUID_ECX,  4, 0x8000000a, 0 },
 	{ X86_FEATURE_X2AVIC_EXT,		CPUID_ECX,  6, 0x8000000a, 0 },
 	{ X86_FEATURE_COHERENCY_SFW_NO,		CPUID_EBX, 31, 0x8000001f, 0 },
 	{ X86_FEATURE_SMBA,			CPUID_EBX,  2, 0x80000020, 0 },
-- 
2.48.1

