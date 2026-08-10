Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCA02FFF90
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357037; cv=fail; b=FR6dX6BK1AAzzX7mPG4nSvNvHZOgjl0enMowooY0oW6mA07++UO96A5fP0SN1dqNM6qedVw4GZtzxX4TdqYkheaBibJmgy0zpzn8kARtKiIJ2zcjhsyigarKEq/1kvBLpZmIHSY1y/xiEPeca/CaAyb52/TF0dlXR3avHn2bgxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357037; c=relaxed/simple;
	bh=2w/M307pM81SMqO0usFEcGUFYFztKFGL2wHDKNFf96c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kndS7SFerugelANig9g06cXNKxUh5jqOPb7cr9W+ERbaF7aOIGYbEwYgcPjls1k1j8MMwvks4dwD6SGEoKoLc0W8zL8Ug8ZYyxKzHjzhLJ+Mb1ubPolGbY5iZsjNHGAIlsRQ+5SmP2gNvz1lI6Fh8jNQt+yx66Kg7vrYUveakWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O4TfQJWz; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O4TfQJWz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgZnbJrQwxd5V1FEGmFJLhFJN5PzFK9RQeRv7mTZlfBBWd7R5/8ZapQCrYs5rFEcASFmRa+bZzYDzpKo77c7jRWsxxhhy10BynOxKZxPz2BGk6t8UWsKXLkbEU2dX3G11KwT54kXOjfLkRo7MP6bCHQCP5WgYHHBAS1JBEgrrbyJfNQ0HCepFrltlwGm9YPAgN34oBWoImpgGIvcCIiFJVKKZIPJukKl6pnmvtdUVicls5FH0miNGlHX4cuccdSylKAbb3tFoX9OwzRpa50RWrsXfYJ7UflDGMkke73gxfuuIl7SHY8TxBVdmAXwalLPESpVK79fueQcKI846I8qvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dqoLbmbFu+mfI/hWu0mIf/bDDOpVhbfHGTxhlsvTS4=;
 b=jNUo6fwAjSFhOUNoFw9E2K0hRPxpwTAMARLOWRgxuwFU0cbqPvBeiIx5cF5gKmqBZImVFb4U49x6bhKE+cjIyG4p8ornV5078eK0fSw/mDJKhQP2U21LaPaeE+hPMIDPiHy0no5nMAgHoU43PBe6xxlYcMQRK20U6jiDkvChVoaIXXUJVIn8HxTAJVc0kz0LbR9rpgFk/2YMZ3fzM9JibuFanDSptngH3aU8swkq404oudmECQtcGMSjzoUYHY2RttNeJv5oks7JGKn/W4bWFrFhmOWowEA0A7ZjEB/3aI38LdJ7WuXvoFOWGezyFJo8X9YAz7tKrmEC3XnNXZNywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dqoLbmbFu+mfI/hWu0mIf/bDDOpVhbfHGTxhlsvTS4=;
 b=O4TfQJWzWF1IyTE/Fqv3qW9fvPI4fLoaRHQFGM+gAUsHYiNvptljzaadyYHGE6/aVpwsf4J+5K6H1IvEAk59Zj5jaLSeMmU9hw4aqPMF6S/3kQYbZ48rNXMA4JW+87dowSKc+iPEjjQDCQ5IryB29fJhlDTeyRb2gRmITW5nBOM=
Received: from MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:17:10 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::26) by MW4PR04CA0215.outlook.office365.com
 (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 10:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Mon, 10 Aug 2026 10:17:10 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:17:03 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, Yosry Ahmed
	<yosry@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Nikunj A . Dadhania" <nikunj@amd.com>, "Manali
 Shukla" <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 5/8] KVM: SVM: Add VMCB fields for PMC virtualization
Date: Mon, 10 Aug 2026 15:44:53 +0530
Message-ID: <661393b87a3fc91835cebe5f2149a62d25f46f83.1786345201.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ca83b7-8ee3-4888-91ff-08def6c88a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	RWtOu6puD5WOB5GNTefloWUpm04eWlYcOf5hOVvnSfWevWZ0gkFIbFgUh5NQChpBgeu1CbdXOVih6Vb0v75dudvUyT8A6Y5B7Yr/byecJe0U0is0CgLaIRu2AKYU6xStMlc6rF4cFR19QTAv3CrNUl7wp49xLQ+gYDWmXgy+qSLiHjpUUIzsXsfc05SoipkqUYoToWT6Xy+jSU3auFsKRjre2H+i6quQnOop34cuxkhRgkSfAFx0g/WYlwSKlNu5s6mEYEZ9VxofsCr/Ogs8UZ0hOkMYYnllwbKBNvcsgzpYZ2O3heE6F6MDTZjcXXUyl49eQsUL86dPg7tN4IyILw55gREfQKXPgaWdTba5mgVWiU53ifY+JRtcDqFeZcGlJpDXzcRK3TwXNsX6k55wW5d3eniUBF6IiuJMBQjln0RETfjXHhRBjrwadCa7w1Bug22IRxZaMSiTubaoKg8960Vykc84cpOHPS8NkhSasaGnlgXg2wYRBExkitZc4UuK/FAvKAAZWwUIQmB72lmx2d/WQNoYRvB53SrveIGPPlHxoYPSRijlibqVzeB0R4faMA70hdsR7mJ3ZInnFokRqvQD94QrK7Jjk6bgdg0jm+SARijvt94oQ0kllm0h/Zc89sJRRuKbniysKkq/PlcI6U5/Nm3QeF2Zh4zkhAXPu7FX/uW0D2PHAHCqvp0LwYO+bb6rQaAktGyxCD0Pzk9/jA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fIpPAtDIwTjuEeHScHhngdSKTYa5fdS/nNV8swYuRwNWkccCvnNThBPFoecM4ZuL3VvdQGELLvNiEsJJrtXvOnUfkr4B06pZN989UlgnWsGYCwGiRDOr2qqBgigFI3fYoxH7AYEemalAcRwLhuhFWvRNZBb3qy6tYZ+UiGFxx9DcC9bk3R6pMKhg+qs5JGViKbJ7vDPQ5AaBx6xjTgDNlm0poqmmkSoj+bxuaYzcmGn65m2dw4D5BrnndwNAA8Afrnj4OhgRvLtR2R9pN0AHq8blOUQCT5AzB4TuHXu8v0+uq1mXSyAznmK1JyRGX2ABgZKdEfM7oDY/Pfm4mPPqPbxdKl0vvYAUS7UP/jnJXaakvI9Fwcl527euKAPKKRGWLVsLSDxcnhnNABI3zdt3+Hd2MgCAf9yVXekE+0pIy8qS5ZMzh3X7zR3nTOs04Gga
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:17:10.7524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ca83b7-8ee3-4888-91ff-08def6c88a63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440

When PMC virtualization (X86_FEATURE_PERFCTR_VIRT) is supported and the
feature is enabled, additional save slots are available in the VMCB for
the following MSRs.
  * Performance Counter Global Control (MSR 0xc0000301) (Swap Type C)
  * Performance Counter Global Status (MSR 0xc0000300) (Swap Type A)
  * Performance Event Select (MSR 0xc0010200..0xc001020a) (Swap Type C)
  * Performance Event Counter (MSR 0xc0010201..0xc001020b) (Swap Type C)

Define the additional VMCB fields that will be used by hardware to save
and restore the guest PMU state.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/svm.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index aa63431ba92c..73f17af22d6c 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -338,7 +338,12 @@ struct vmcb_save_area {
 	u8 cpl;
 	u8 reserved_0xcc[4];
 	u64 efer;
-	u8 reserved_0xd8[112];
+	u8 reserved_0xd8[8];
+	struct {
+		u64 perf_ctl;
+		u64 perf_ctr;
+	} __packed pmc[6];
+	u8 reserved_0x140[8];
 	u64 cr4;
 	u64 cr3;
 	u64 cr0;
@@ -346,7 +351,9 @@ struct vmcb_save_area {
 	u64 dr6;
 	u64 rflags;
 	u64 rip;
-	u8 reserved_0x180[88];
+	u8 reserved_0x180[72];
+	u64 perf_cntr_global_status;
+	u64 perf_cntr_global_control;
 	u64 rsp;
 	u64 s_cet;
 	u64 ssp;
@@ -575,6 +582,7 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0xa0);
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0xcc);
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0xd8);
+	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x140);
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x180);
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x248);
 	BUILD_BUG_RESERVED_OFFSET(vmcb_save_area, 0x298);
-- 
2.53.0

