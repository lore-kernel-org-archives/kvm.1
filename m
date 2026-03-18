Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67588373BE8;
	Wed, 18 Mar 2026 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820650; cv=fail; b=Rx8lE0J+ZJfDEK+LGG9mw+KR9XYW2M0AlMu9Qzm8JEnVM7D8gbPOFxBysvBTI0JDqHaZGfE9/PigMPUXnePQ7Qx3PuQl1iihIeRluU/3wJFlJGmdPaoHcX6q7P1exBnb1B+zZKcqu+pCgj+7FBgCVp/IoNiWqOyExZ4kzF+akWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820650; c=relaxed/simple;
	bh=k8/fnfsPOQrpvtRN/ejHEIQBN6H2XUd92jT9lByTjs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIfCsMjXSwZoveWTxeaiMMgukwvMalfpcxwRFbbGebGQU4XJZl/63LmJbXab2DqMQNFkOFPyfTrrplpRw5zGoInz1z7hDcJZOO/njpFgBkHxOXTJDKm+4wRluKanIKtN/CBrPWttujqEYWdvAfC2eF0aeGosdRctwtwIBIxbOhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L5j+cFqw; arc=fail smtp.client-ip=52.101.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L5j+cFqw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLwcbpBq6AZNhwdImUhVICZKoVV7Ry+bW8yeBZ+pc0ZEnZ4c1PmHgPBIfODRaf800v4FSqNSo05ICcm2sinLCCViUbV0OizcKQ9rBIQy9s5ZljvxVGdFQHImj0xmUjdYMlERiVFzirEf+C5FUB+P0C04afjpqmYND90DCa6qk5FEYcP6IasW6oBFlTwJqCjDlQOR5GE/K6+wEUx+7xpy6AGE+afMIVT1nMtFcO+3DLNPKolGV+O5OlNG2ZxWVaRMMhSB/qCJfxYlBSrgYKCG05TmICB3POIy36r/DIegIkrsH3WnXkn9lUYvbTIdGJPzqDSCAArIupmBnCnbh0q8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT9QikTnYIvR+XcZ8kcfNGe+F9AvATPk1bqKa/4yioQ=;
 b=A6gOVMtCao1dV7ETQXdbGHs27O84LKbL9hZzjejmIdSGidOluj4WxSa0MO2Ud/vP2EUTbndSugiQ8LrSR2djRt01y+00NDuPMliU10fW+Lam1MF+Ty3wZW863363qIlPMkMK7gmj7uv1Q6mHQYDzFjA2SNTMI2GIi+Oet7OrNLt3Eb01Jb/Ya4h9UzPZWpbhitzMU//KMYWSonmUOoG/3taH5noTp6Rd0eEa1+91l71cwAFmgV9A03Ws9FGZAUEK7vT3NBnoCU9wk7G4QCsAxKmLoWfk4ECJ1RcmvExgaPkaCgCE5vn4X9Hhc8gFkgz/g60h3Fi1FRAuQ/hmvER8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT9QikTnYIvR+XcZ8kcfNGe+F9AvATPk1bqKa/4yioQ=;
 b=L5j+cFqw8hqmvO9Sab66UHNdEOGnHRljfH1UXPHcI9ZBOK+nF4rqbtUNEw/MveNiRGjtnVyeCXRg7NdVRl3gtK5xs+cYPDXAF8SOhN8ZrL0NI2zmd6WPhzG6bj7B0we2mF06e6yntLuPSTG9ZLHX21LBReutmxPy507sR/ovhUY=
Received: from CH5PR04CA0003.namprd04.prod.outlook.com (2603:10b6:610:1f4::12)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:57:24 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::2b) by CH5PR04CA0003.outlook.office365.com
 (2603:10b6:610:1f4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 07:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 07:57:24 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 02:57:19 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <bp@alien8.de>,
	<thomas.lendacky@amd.com>, <dave.hansen@linux.intel.com>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <hpa@zytor.com>, <xin@zytor.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <x86@kernel.org>,
	<sohil.mehta@intel.com>, <chang.seok.bae@intel.com>, <jon.grimm@amd.com>,
	<nikunj@amd.com>
Subject: [PATCH v3 3/3] x86/fred: Fix early boot failures on SEV-ES/SNP guests
Date: Wed, 18 Mar 2026 07:56:54 +0000
Message-ID: <20260318075654.1792916-4-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260318075654.1792916-1-nikunj@amd.com>
References: <20260318075654.1792916-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 198638c1-8325-4277-a880-08de84c3fda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0ms56MTYFmvqpZHNHzRIzNXcfDdrlfvbSam/p/v7QilN3HA2q5GmJ9L/IC9yk1Q24LCQlZD2STLYllns3CVOzeCda+TUo9aFZCqx+qwZdypeOyg8Pnn4SxKvZZ+9mh94F/4qpY1JG8I0d3pv3g25e2vaucOrll0YDkgXdqUM4yWWgaVO7NsXdY5GdoZte7F8kcOn7Mt9rOyYl1dsF+i11jTHfTCIeF4aEffXZ3MtCgTkn7QMPL1DhtNej6CvVtY8X14XyxD7/4lcbRnrU6i9YoNtOEuUAWaeMA4wftjCu0vX/nbWJIOtyu6n+YzCUmHYlk82nexCY6rVVIy960aIBIqL8/7kxb7+gkLZlqP2vDT63GmMtcnw6sGrasr7kg821QP5/7aJ2vMZ6BYWWLwksQrhRHT3sxbtLJQzOqxyWqC3cACbkC+pIRw0NfIvwkNlBGC5XFrNidE5jNBQ/6jkL5n8t5PGMSg7dNmMuBe+HGljf4lu5K2TLRr0xjufwsLKRiXQ5nRBK7sqlqunRG822J5o+7mhTzSMNN9Q+SFvDX6hkRnoM2XaQo0n9cn9ZKsB3hm7aiJv+5P/y+rJ4JpseuS7A7kzBL1UgZPUCgjgTPhdACNuUqcY7qx45xTSyZnDuLpsJV26FhkI6kaxZykSIW+7HBONqfxX6uWTxESGt+7s5nT5luZVNRoDBxzUglLT6oHhvCWMTaq+M4JBTXeVfkPE8528pgEI3C1OXUUDRsEdPiPefDlC1e6MiGWEXxY6VD28L4F1DiS+BXeAm1W8ZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gNQKt5naXne//7uLLQPNWKm50F85cHlYVRBCI6khEaG/1Z/i7px6ERHjFAUn+4CbCZJHl/Zw+LE3snjDaPNTo7bB2YPHnwZJ6iPQlbwW22B7uKQZfqu27kby1lQw/5LwKdcuLHH15rLFMYQ+oNG6zpPwSpotsZ+t7mH05HyHkLO6dFaTTnmEtTYFhbVSaZvaPmDYReqzQHlHDwsWtUkTWe9D8j23DGwGGsyQLjly+xrSrHs88ieKbhGCvxO9KIHZy0I14Ja1jgfdFDYrPSymKJxDsw9FYbVq/B8dSLOBrNZxp8mi26+Cqae1LVW2HMLLdaZAYO+r/5LEIPRopGnx368C+OF/WBU3L0tO9u+Y5z1lKHjSIhaSHz7QwPQHposPyPF6WUl/GPlNifdp05Rt4UkXqO3er7ySuYqJ2w3XF5aAxifJcr+3Vv//88db1FLN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:57:24.1502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 198638c1-8325-4277-a880-08de84c3fda6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296

FRED-enabled SEV-ES and SNP guests fail to boot due to the following issues
in the early boot sequence:

* FRED does not have a #VC exception handler in the dispatch logic

* Early FRED #VC exceptions attempt to use uninitialized per-CPU GHCBs
  instead of boot_ghcb

Add X86_TRAP_VC case to fred_hwexc() with a new exc_vmm_communication()
function that provides the unified entry point FRED requires, dispatching
to existing user/kernel handlers based on privilege level. The function is
already declared via DECLARE_IDTENTRY_VC().

Fix early GHCB access by falling back to boot_ghcb in
__sev_{get,put}_ghcb() when per-CPU GHCBs are not yet initialized.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Cc: stable@vger.kernel.org # 6.9+
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/coco/sev/noinstr.c |  6 ++++++
 arch/x86/entry/entry_fred.c | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/coco/sev/noinstr.c b/arch/x86/coco/sev/noinstr.c
index 9d94aca4a698..5afd663a1c21 100644
--- a/arch/x86/coco/sev/noinstr.c
+++ b/arch/x86/coco/sev/noinstr.c
@@ -121,6 +121,9 @@ noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
 
 	WARN_ON(!irqs_disabled());
 
+	if (!sev_cfg.ghcbs_initialized)
+		return boot_ghcb;
+
 	data = this_cpu_read(runtime_data);
 	ghcb = &data->ghcb_page;
 
@@ -164,6 +167,9 @@ noinstr void __sev_put_ghcb(struct ghcb_state *state)
 
 	WARN_ON(!irqs_disabled());
 
+	if (!sev_cfg.ghcbs_initialized)
+		return;
+
 	data = this_cpu_read(runtime_data);
 	ghcb = &data->ghcb_page;
 
diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index 88c757ac8ccd..fbe2d10dd737 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -177,6 +177,16 @@ static noinstr void fred_extint(struct pt_regs *regs)
 	}
 }
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+noinstr void exc_vmm_communication(struct pt_regs *regs, unsigned long error_code)
+{
+	if (user_mode(regs))
+		return user_exc_vmm_communication(regs, error_code);
+	else
+		return kernel_exc_vmm_communication(regs, error_code);
+}
+#endif
+
 static noinstr void fred_hwexc(struct pt_regs *regs, unsigned long error_code)
 {
 	/* Optimize for #PF. That's the only exception which matters performance wise */
@@ -207,6 +217,10 @@ static noinstr void fred_hwexc(struct pt_regs *regs, unsigned long error_code)
 #ifdef CONFIG_X86_CET
 	case X86_TRAP_CP: return exc_control_protection(regs, error_code);
 #endif
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	case X86_TRAP_VC: return exc_vmm_communication(regs, error_code);
+#endif
+
 	default: return fred_bad_type(regs, error_code);
 	}
 
-- 
2.48.1

