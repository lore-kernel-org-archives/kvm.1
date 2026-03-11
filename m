Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B2F23ABA9;
	Wed, 11 Mar 2026 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234414; cv=fail; b=i3qiju2/rU2KZDOnCIHmrUSIJhg7etfjUPKoYKDuRgJagcqgDNdm2aUafFxigbmpnTHMoVR0dCe3/o3LR3k/KLvJHgG+etoceuhHWC8artJucgE+H3kYywzDmpuu8ynASg7J4NLtC0Hr0lj4c2qbH+RxcWxtbPqqtjBVpoPtBS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234414; c=relaxed/simple;
	bh=2SvsWycSyxsjQ9DXanoARVkPPqCsLN4B8LtzdZPVfYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwSd41SJY5p0q6p5MfkkLoPKNx9+0Jd+KOQON3DKVXW4qBNqXvX3l5gDElYsQnNgT/ihRzjzDjtf923/vEGLDM9QXNWBVKm9YQ3L7Xtqfu8VWOXSRgWdY2WCV1SwYPl1sfJBHjst0VJBa4iwggKy1f7z7V/kFmLi+QZCsEp2YB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j5RuHkmF; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j5RuHkmF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWY7wrpltY/EeHFaJU9Qo2Pm2l8NVkojZFuhN44CKAlt7vw8q2RxHHTJXTtrczIjEAXnhc8IKpzHc3eqqgKzf8Gd9a3ZlliIF63KjClDcUAr6LUrhcLnD9+5G/gOtp2aepBWzlxfrS6kxKGsYg6A2lYVSgeTANJouGNHV06ZTkWYhewURtHHu16Wy0FvRM325D3CXOAiGFXxZDb0gmEwa/2CrTZyPobMDxeqMOdzfZxrF1SgRK7/oixQZzorGpbK5yNEmhiWFxp3XHIFSW5KDP0VwyEm5iZDxqiwKYLqRldNCdRScIeX6AZ38R4B+0bfa0rnJ2vGzlPp6CL4F4b27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixU3YUMsWUyKyoqFhLfNwDy1RAvMpcMjNRaN82t31lg=;
 b=JaywoWlbubc/3dIUpKf1BhLvHNoo2atGmJoOWdBSzNEnxNyfTL0Our45s4bZJNnKCDSDQvHc8EmyuH1y8ShXZl7B4f148pi58ErqCP/+QPCH0SunFrhP3AiFZzvlErOHFA3WSBu4sWsAaI2xdT/fqO8VMNLlhb7vglwO275idFY62lrwatKiyM+pGgnGs3JcFcJaM8VuHUw+r3ddDmqutpHqH6Z/qTlEHvmEgNR1+uuUCas2d1oIYl8vo97RkoBf/KgMnwQt5XE7w4E3HavhamDCauJGBH+Yrp07j06uRQnuDxVJsdLYT5I87u7f6ZufCTeq9mpvl8ROfF1Jp1lDZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixU3YUMsWUyKyoqFhLfNwDy1RAvMpcMjNRaN82t31lg=;
 b=j5RuHkmFCU+3YVbNLAxspqByWD8sMVY1TErtMl6r729ZYcQ+fovG6/RAtzr21jpSEkZ5B/FA65quJ2OaamylzaXffY8e0qiZiwfhfQDI/W0ONTlquY4kp3BZPDDhI8jiifWhm0Bc/6/yHzBjBSW0GhsZxOmhXFY1t4FnhRVALeQ=
Received: from BN9PR03CA0285.namprd03.prod.outlook.com (2603:10b6:408:f5::20)
 by IA0PPFDC28CEE69.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Wed, 11 Mar
 2026 13:06:48 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::64) by BN9PR03CA0285.outlook.office365.com
 (2603:10b6:408:f5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 13:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 13:06:48 +0000
Received: from gaul.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 08:06:46 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Kim
 Phillips" <kim.phillips@amd.com>, <stable@kernel.org>
Subject: [PATCH v2 2/3] cpu/bugs: Allow spectre_v2=ibrs on x86 vendors other than Intel
Date: Wed, 11 Mar 2026 08:06:10 -0500
Message-ID: <20260311130611.2201214-3-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311130611.2201214-1-kim.phillips@amd.com>
References: <20260311130611.2201214-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|IA0PPFDC28CEE69:EE_
X-MS-Office365-Filtering-Correlation-Id: 23762fcb-7394-4919-d9c8-08de7f6f0dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	w3s1u61/lcdfqF//vUDX9g/z1jCEutAcPZXMks/OPL8hWAjQpNQJYbNlPhFix6lBprx84xU6vnJrj9/R0T7HUgkIH0U23ILaBwvB9U82GEBp63jt5Bw7BavIf+1vG4nh06PgAULrhXQWeTjV+S9F4f71AkY4aXnSF+FgM6hzhBuIjB/I26w0gzoCjiZsnYh7Dp95pwAPFpFAi0aHJxzsR0qU04aRdnS4ygN/sPK53GHeLGe0X4MIKsAYnKUrIclkhpviD8AVctsV2K3ung7M1I2BKMMXr3uQa/2kZWtAJiOSZ/DZ2tLucsHhDApJvpfRqP+DO6Wpc+fdJcfKacNaYwCZLMR7KpReG7+TuORoM2o9JVyEcR4oNueygJ1eKCxvvx+c4efofW/OhY1+6cobd/V0j6jrb944dKUAIvrArZTrOGrw6mIH5LxGrtAm0UqvD2Af9ViWVEnH1mGuZbFKrcg3QtxJ6j4bxkCoITeal751T4hj6fuHL53Yaeuqd1DY9WqUnyp/6XGuNbMTT9QsXM7u3zCyhu8z00ItpHEI0LX0DdUhvA5Kym6/44BzHMJNAN/dLWhyh/ovVs6JQnEsE2Ynwi8X26UUglCqvHkTxnzWA/FI6rxhplGi+debL5O0NMqF13jxIPY+w30TVrzDH9CjUqw9/wuUoI5rOwfaPAO+MHgCOZZVD+AIrEstVdWcu0gkedrGv/zE8u4/SRjdfSfsFlwqZ9CY837AV/3AVTi3Z+XriFBRDhbtob+bZ2WXJ0gSXeJyhMNzJSxyvEEUdw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SrZO20Yl46bksi5GUuFnOtBcyI1oC8Asrmv4PJEyuZl4n+dH/MHjxVPt0MvOUC9wg93z1snlOpS8aAR67OMMm5iUdl1020AFR7uJvFz/hbj3Zqw8fRbCeX+kh31FYwVLLvx+b7PhQa6N5FcVMUF9qgP1wmHfZskVf45lZ9GsdSC/EF5DVHiLhWVbJCc92ZeKPWhlGYUfB8T2amVQNxnjfBKCiV/RiR+GEtWxbA8G+hZF/6J56iF655Rjdduih6SJyHP1rXnqOfli7xVDxoq1bkotnhnvwKM+PP8xnKorux/MASnfibplF6JJszNHwBV5bDDWz4AuwBG8RrkQj/N9PNTjwsW8W1NtsY+VYZhSTjrPzyrwJ7jvddKbObX+Nm5swTiv9zFaNhbviCeI1u7IAJll4rxtI8o71E9XW5YfpyS5cDEmnLDKTWpMK4ofhT4x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 13:06:48.3161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23762fcb-7394-4919-d9c8-08de7f6f0dd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDC28CEE69

This is to prepare to allow legacy IBRS toggling on AMD systems,
where the BTB Isolation SEV-SNP feature can use it to optimize the
quick VM exit to re-entry path.

There is no reason this wasn't allowed in the first place, therefore
adding the cc: stable and Fixes: tags.

Fixes: 7c693f54c873 ("x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS")
Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@kernel.org
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
v2: No changes
v1: https://lore.kernel.org/kvm/20260224180157.725159-3-kim.phillips@amd.com/

 arch/x86/kernel/cpu/bugs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 957e0df38d90..c910da561044 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2152,11 +2152,6 @@ static void __init spectre_v2_select_mitigation(void)
 		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
-		pr_err("IBRS selected but not Intel CPU. Switching to AUTO select\n");
-		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
-	}
-
 	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && !boot_cpu_has(X86_FEATURE_IBRS)) {
 		pr_err("IBRS selected but CPU doesn't have IBRS. Switching to AUTO select\n");
 		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
@@ -2251,7 +2246,7 @@ static void __init spectre_v2_apply_mitigation(void)
 		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
 
 	if (spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
-		if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
+		if (boot_cpu_has(X86_FEATURE_AUTOIBRS) && spectre_v2_enabled != SPECTRE_V2_IBRS) {
 			msr_set_bit(MSR_EFER, _EFER_AUTOIBRS);
 		} else {
 			x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
-- 
2.43.0

