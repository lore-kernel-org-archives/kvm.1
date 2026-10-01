Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE74ACC74
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860872; cv=fail; b=P9FoQWIFM6vV8st3/0yyUF6jK/gFSDKkmb8FK7Bp5yDlQTmYRqmYGparMGWBrD0pmUc0tengnO51CYbihIHVFzSQs2/uGyrPZR1RRFpBqcxY1LOgedyYFKuAOqJBpsHt6x7d9tID8NBNgH+UuucfmYgQX48QfNAG7pBz3/jKUCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860872; c=relaxed/simple;
	bh=54spgOmP1tcU7iLYLTlmvad1D736pootytRY1gXUk3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D43l0t5OXabdkZFxQWkzcvQluvH78SXTZwrNgMICyL1EoQFIVz6eRfiS0ISKIZzSSoabgxPGpxstAVyuwH96QZcIEsAY0OiKHUpYT3awHGnedA3vMJmIh0GrOWPbxFVNGWxmSUtJCAnkkM9e0/XsHmIii5jdF4iHejXpAJDBPQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PIxHBM1F; arc=fail smtp.client-ip=52.101.53.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PIxHBM1F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxowRG2GOpPvD4BdfcsP1+eOZgby1t26lRMjTk6lCVhC2ahM2DrEkQanHzZzps1B79ccVBw+5qZDFPmC/CCdB3V0oYo9VyMt4y+cxvT+F7FRo+Kd4XSBkpI+xvJQ174IH89RgAjP7COLElJsxTP8W6/Xfi7GL7CfAjh9ANGVRVGGSf0ufBe6JjKR5K3SCwx+7oyzwS2WBMiVDmaiMlPQ0U9vOcsepL/RIl8OaJEHXjnShDLY7XFSmTGmEPJ8of9nCKvQ5EBBq298kUMf0dSQYTSGLciyUnu8mMIeyps9EHItIjaqDTJnPkp0CUfZJstKjzaYzlodUZEPVSk9UYDy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlsS7SH7lqu71itL80LqCKZY/Wrb9lU/frxQhiXykDg=;
 b=mS7PPQBgCzPwIilZSsBhaeHqdahrMpSJ/lEWsIcn2+iLB37UAFz9fn5YO169aBVxS3GGdrvubbO2IKIU1kBl09KdScfccgsGyCdCyMYUQMFeHMCAUEd6A8TsVLKjSGFbprDCwY0CSIKZMAYKM2rpbUvdBeN0+CyItuFHrEzAoWXcYTCaM7g8FOtQPq5hFz6tIWqBHgjZZYAJANzff5Ww2vI58PGhDwv/dWuG+CM6r7Njf3e5ttp7nDv43i1n6PPJClfoh+gDrMrCbniMCuu3Yv6QXEozCE0t+cw6vbdtfZFWef8r1dcokhADZ99jYEiTv26jcDylFDGn/Cfhaqg5Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlsS7SH7lqu71itL80LqCKZY/Wrb9lU/frxQhiXykDg=;
 b=PIxHBM1FNyePFEH0trOEAOlrp9EeCSj6OD2YkmQXtt/wyhiwZj9CG/DgvOgMn/FB4eUj5Rq5RWl9w3XPKJdae3fuLnU3YueR2qY6SbAQsTT4ew0J/EKaWGXn1eunZkzza1L5jKypXl+ZfFAxcVnajnIjw0TcD5RcpG8CdfVVgNU=
Received: from BN1PR10CA0030.namprd10.prod.outlook.com (2603:10b6:408:e0::35)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Thu, 1 Oct
 2026 13:21:04 +0000
Received: from BN3PEPF00022BCE.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::a8) by BN1PR10CA0030.outlook.office365.com
 (2603:10b6:408:e0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 13:21:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCE.mail.protection.outlook.com (10.167.248.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 13:21:03 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 08:20:59 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
	<michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Sandipan Das
	<sandipan.das@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 2/9] KVM: SEV: Add VMSA fields for PMC virtualization
Date: Thu, 1 Oct 2026 13:20:14 +0000
Message-ID: <20261001132021.254270-3-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001132021.254270-1-manali.shukla@amd.com>
References: <20261001132021.254270-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCE:EE_|PH7PR12MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c951c12-ca3b-496a-e82d-08df1fbed7e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tNlYlIu9rd8iFSPle6J1CfDvLghwaPRtIdc0VO+GiQcdX60+K03rZ3bL+TzkMPaE9sdVrNYW1r3nrbvT0wuoXQoPcO+JxzJ3lAkmZ4dwq/VY/FpaVup2+aLOKLhIvlBvssHURMbxhIz/RwHSbtsDtvClhR9ULe6X9jnbSGgsw2SLRvkPNbdgo4h2t4VVg7M5MklPxpFRApQy2HDVcAsEApqqzig9gOvhj2OtAGo/iBrqFn2E0KL+ADmDz+KWrSO958+FWndljUx6Y6K864qRib5SgzWg+QzrLEDsjIhLW8/kpgzxRcK8fjK6EYSboHzC7Cj68Vk04jqZIdpy9legMYOa3T+gof+Np0W6rqTGLRM03X+PptllUA4Nsxkit1Yi5vg+WbuBzpi9uQCXJHaYjXEy47OsZwvYqipDWWAwljnZy86+Sqh3SPrgslHg/zZUH5IJp0/9NWrHCQxHHq7a3RSaYydCpjjjmA5bduFq4pES84oS/4hntv15OnV5Y65Y10oMFXFN6DmHmzEj5IsdXJciOB7YMXHAWTQ2MlGmj2VG4KQ/b4Jv7+c/qMoqIq1UJzWgTGV57zGTTaZ65jRFZY3uyBKUWUq6IjebSybKXV2cRICQgORmVDLftsSpp7H7ZdRopp2onWmJe92ZwAY55tYDrlbL/v9qruFG+1Fl9e7Ixzt2+oHBZPtrScw8qIJcY12udaAkKD/5bDTCIYEz7Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z0rhccDE2VjjxOuYPmCnRXncmw+71ZVbkxNl21YHqLa7spFFrASc25GRXeyX67voMRKWkgMrgldapNd0KFcC0i9kPb1dNfJFWxhQVSJDzyit6csHtKZoCHTuo44ObqA8LyiGXRy9GnHQhti3uoaTA/fSvPVHz0XJp1xc+c4b6wKiAdlV1TUlo4qc4TZkJ9w/pB/XPnJipAHPcJWRK2Upp7SJ1W8dJ2Y8nq2VSvftYhPsE4c75Z8GwXjpOCCHPQRusYzwLC7nH0oKd5l1wZQs1zxUqEmbQsX7RuB1xPp1CgZRMqE/3xT+KfxWq6Xle4kNLXUIGzHcPXSReJkDGPkhRF4o3oPk7MYB7QfPw8JDHhtECgMwINhYwT2i+Gkb7XfkjuDOXPSwRn+RSEUlzXYVSKKMw+ibjyVY2gMwNwO+bNSRJzjzCEtRBNUlCfVxUXIf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:21:03.5266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c951c12-ca3b-496a-e82d-08df1fbed7e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BCE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879

From: Sandipan Das <sandipan.das@amd.com>

When PMC virtualization (X86_FEATURE_SEV_PERFCTR_VIRT) is supported and
the feature is enabled, additional save slots are available in the VMSA
for the following MSRs.
  * Performance Counter Global Control (MSR 0xc0000301) (Swap Type C)
  * Performance Counter Global Status (MSR 0xc0000300) (Swap Type A)
  * Performance Event Select (MSR 0xc0010200..0xc001020a) (Swap Type C)
  * Performance Event Counter (MSR 0xc0010201..0xc001020b) (Swap Type C)

Define the additional VMSA fields that will be used by hardware to save
and restore the guest PMU state.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/svm.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 7208b910f2a56..6272ebc955d32 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -407,7 +407,11 @@ struct sev_es_save_area {
 	u8 cpl;
 	u8 reserved_0xcc[4];
 	u64 efer;
-	u8 reserved_0xd8[104];
+	u8 reserved_0xd8[8];
+	struct {
+		u64 perf_ctl;
+		u64 perf_ctr;
+	} __packed pmc[6];
 	u64 xss;
 	u64 cr4;
 	u64 cr3;
@@ -424,7 +428,10 @@ struct sev_es_save_area {
 	u64 dr1_addr_mask;
 	u64 dr2_addr_mask;
 	u64 dr3_addr_mask;
-	u8 reserved_0x1c0[24];
+	u8 reserved_0x1c0[8];
+	u64 perf_cntr_global_status;
+	u32 perf_cntr_global_control;
+	u8 reserved_0x1d4[4];
 	u64 rsp;
 	u64 s_cet;
 	u64 ssp;
@@ -597,6 +604,7 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0xcc);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0xd8);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x1c0);
+	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x1d4);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x248);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x298);
 	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x300);
-- 
2.43.0

