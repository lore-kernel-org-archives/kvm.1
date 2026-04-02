Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4201361678;
	Thu,  2 Apr 2026 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155413; cv=fail; b=SiKqly9wQ/bSVt8gR4g/PE+YTuCZikrbWEvREiOHVKl4i+tniHuShDEU52QjcYCeU+A8axqXdG6J3l53WFW1/ahsZBzZBEfTklFn6ldg+Qze2WABOS1YiOvm1xLsDUlOyXeTXfAa03z9VezF362LgTyP+hHSNuPWH2cxoGbeQDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155413; c=relaxed/simple;
	bh=kixwIgpJ3n4s2pCwC1D7BRNAhSLvQ4vTAgrMKVQjjys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqD/Rr/gPSCotxWaUkALEvDHWCrClmQiu89S6N30Sq3phZehS+Mrz2jre7217jls9KHn6QQ2nOM+V5IA6JT1xi8pMLIHZWLdkj8va4NJuxAfjI84q0sPUrhUfKZF1BSYkFiSODt/pQKAm5vPppbFXJjVvlGG9wqlESY3WIlZRYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wpDm5pXU; arc=fail smtp.client-ip=52.101.57.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wpDm5pXU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXSwRIhkh73f0rLpQdvtcdEwaaXIyp1VPZOgdVa8/f/1DXie2Zwhii26rZ52XW/YtTgeqFQuw+D+EI1dQMrYhL8bjGsWetRHN3nLrOMCpEpRDw8WCHqZY0lwgkT2Wgdh6p49UiS4rXrx1Gdv/0NsqOYPca8c77Mg60Hy7aAnwrD6uXAFlQWVHf3waWSs4/wFVB0fhN54n1GWKQaHcA4xviEdryCI3AYB/9RyMvPUbWt2gtE4MKBI5s584IE1HfpQdlHJqjIsQH5zELCydmH9JdeiZkrGlEgtPdM860SCLE9+/naCgEUFk7/gOnosKIcudsqfMUG4JcTLG2bHDnP3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4W6QnVUudsksppBJjDkGRl1u5wcvj8pwencc/0fprtw=;
 b=KGOUdibszlRvfuMl45xOz2j70y6n1DBqpFcFs3gI4ruLjBCs20NfIJcy8HukJ2yXeOvaXRPpIXMEKqFUaTbfpMD9o6hNl9+0jaWQg75fpHglvLtKgwh+uDuGr3tjRWz1k2Gg9++2VJNsw6MH4q5vna8Wz4PQQFNIvT2XcIABjl2+/2+j78K1dyTHXfuBPQTS/pyE/qwlxIEamSheYpHuSW12uSyFimkdPusV1hOVzmcokNv1/ItsK8qMpXa27UJTjFOR9Jo1rY7ol7nk8ncxBgJxAXcuTmJeub1LwPPSYZWA1F+qEJ3EoOQNsMhmAVlZZgorKYtUFpvYakYTBwsk+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W6QnVUudsksppBJjDkGRl1u5wcvj8pwencc/0fprtw=;
 b=wpDm5pXUz8T5OCp3YYFkWrfzwXRzNIL8YC8qbShr5+aAijIaad4hh297HTGawth7DXNb8SzspAVdcmBg1tur/E5r043RMzb585lI/D+6Utw+xw+CqMxFapDxquHZ3ZBQu0zvc28KxhE+vnI8XLY+F/PwR7Dto/J+8Y0OPGXjFI4=
Received: from BN0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:408:e4::28)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 18:43:16 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::31) by BN0PR02CA0023.outlook.office365.com
 (2603:10b6:408:e4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 18:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:43:14 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:43:10 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 1/7] KVM: SVM: Initialize FRED VMCB fields
Date: Thu, 2 Apr 2026 18:42:34 +0000
Message-ID: <20260402184240.1939480-2-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402184240.1939480-1-shivansh.dhiman@amd.com>
References: <20260402184240.1939480-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 688313fb-43e1-48aa-8582-08de90e7b2d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lCFXGHfYgq4cLTlGLgGz+cpzqPSLfRhDduBVO4xeZK7ich8b6mA3W54ER6YhM9ef5KOixkwAHc/JUBfUqA6nVYNO8PvsCBtBMLEwY85IZ9gA5Qsk1IS6ydUoS8+wMntC6AN6JI/AM6Eyw+uCs+qNZmmCe93PDiwfw8GrebyLz2HU+KujT7IehXM7zHPiH1CX9LpbwJlp+pcI/A8lhgFW8S8+lmAkJDIe+tiklVrCp/z4GA3stk4r+glJ3pxZW07cVy3jzqeJ3f380XW68pq2Lq05WUt66zOJQyUisxR5+hekdEoh7bmYd5Jo/PhovL35GpGmdnsxcwAWYz2dSOwjRh6V4MUrAzqoAo7l669ZDICIa88criFFZZ7wvHh222OJ8ET08ggaGp0zoCfQjpToLDPDlKMp9gniAbnJ90yHldqixNMNTJfKvYpadiAyr0Css4SNXbpjSeV+QhiHnDOHS3/iRyjzV2JTBDZFz/MX7rBd7S2Imvqh6BuCtKg05KSlQEyzUASEJ8A8Ym8wqsq2+29Kt8TDp6EN3r61dOrtT1rfmjwtQIWhh4iJ3KvHObQCRSzfkm+EHrPQQwc3UTI33nG4tjBLrwQx46EV8EtdSZfBcKfMwP5ceFHHQjGAZUXJdn3xM74p0svLz3WsI5ggGeHmc6ORw8iykzoLvC2yxiIWC/wlb60378tw1oJa+Dk1sxJmNAu6RDHMKYnrayb12IM0UWDffAtxoFusjVXsXkeQP0XExsPr+pH9LJXxY48DloL3xK6aFu8aTXpX/k7SgQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Va1HUggN9DXtQlZnm1PPaVuRLROeHCRtoLUQ59MoXZBFC/WHf+6XrmiPBGI6ODIuf+yd8lTSCCdSM1GuKyEmxv3hHkHrM4BTbBlMlDFzxQL2Hq0R3r0skMAMLfy1jYDs9GQ59NDF6xBh0GAwxu1DGkx2gEVlz46V4tQ85JB9KU9LJl//iu95GVkffg3K/tRZQ5kqnB/pRyCoZQgWXstk2e5YNouVHnWkH+EMF8ePiDoEzc+Afytod3/8gt4qahh3GVz3iqJKui+OaIOzApTC4Da3yQ9b5K5wznCf0riPl16sAat1nZKUE5shXtAdeWp/mTdRDbRVL6eOqyFN3MWjNE5gFP/Bcp2hG1ilF9PP/LaYMZNNT8yYjFsd9Ne2QJxxRPzSN31HEODFyX54B5GfU6WOBCsSqKbfU6LBZrEV6Fths5RdnhpwJl2nxZkAhMYz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:43:14.5093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 688313fb-43e1-48aa-8582-08de90e7b2d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745

From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

The upcoming AMD FRED (Flexible Return and Event Delivery) feature
introduces several new fields to the VMCB save area. These fields include
FRED-specific stack pointers (fred_rsp[0-3], fred_ssp[1-3]), stack level
tracking (fred_stklvls), and configuration (fred_config).

All FRED MSRs are zeroed on RESET. Reproduce the HW behavior here to
ensure that vCPU starts with a valid FRED state. Also update the size
of save areas of VMCB.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Co-developed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
---

Changes in v2:
- Modified the zeroing of FRED MSRs from INIT to RESET and updated the commit
  message (Sean Christopherson).

---
 arch/x86/include/asm/svm.h | 33 ++++++++++++++++++++++++++++++---
 arch/x86/kvm/svm/svm.c     | 12 ++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 17f6c3fedeee..a42ed39aa8fb 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -165,7 +165,10 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	u8 reserved_9[22];
 	u64 allowed_sev_features;	/* Offset 0x138 */
 	u64 guest_sev_features;		/* Offset 0x140 */
-	u8 reserved_10[664];
+	u8 reserved_10[40];
+	u64 exit_int_data;		/* Offset 0x170 */
+	u64 event_inj_data;
+	u8 reserved_11[608];
 	/*
 	 * Offset 0x3e0, 32 bytes reserved
 	 * for use by hypervisor/software.
@@ -360,6 +363,18 @@ struct vmcb_save_area {
 	u64 last_excp_to;
 	u8 reserved_0x298[72];
 	u64 spec_ctrl;		/* Guest version of SPEC_CTRL at 0x2E0 */
+	u8 reserved_0x2e8[448];
+	u64 guest_exit_int_data;        /* GUEST_EXITINTDATA 0x4A8 */
+	u64 guest_event_inj_data;
+	u64 fred_rsp0;
+	u64 fred_rsp1;
+	u64 fred_rsp2;
+	u64 fred_rsp3;
+	u64 fred_stklvls;
+	u64 fred_ssp1;
+	u64 fred_ssp2;
+	u64 fred_ssp3;
+	u64 fred_config;
 } __packed;
 
 /* Save area definition for SEV-ES and SEV-SNP guests */
@@ -472,6 +487,18 @@ struct sev_es_save_area {
 	u8 fpreg_x87[80];
 	u8 fpreg_xmm[256];
 	u8 fpreg_ymm[256];
+	u8 reserved_0x670[568];
+	u64 guest_exit_int_data;        /* GUEST_EXITINTDATA 0x8A8 */
+	u64 guest_event_inj_data;
+	u64 fred_rsp0;
+	u64 fred_rsp1;
+	u64 fred_rsp2;
+	u64 fred_rsp3;
+	u64 fred_stklvls;
+	u64 fred_ssp1;
+	u64 fred_ssp2;
+	u64 fred_ssp3;
+	u64 fred_config;
 } __packed;
 
 struct ghcb_save_area {
@@ -542,9 +569,9 @@ struct vmcb {
 	};
 } __packed;
 
-#define EXPECTED_VMCB_SAVE_AREA_SIZE		744
+#define EXPECTED_VMCB_SAVE_AREA_SIZE		1280
 #define EXPECTED_GHCB_SAVE_AREA_SIZE		1032
-#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		1648
+#define EXPECTED_SEV_ES_SAVE_AREA_SIZE		2304
 #define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
 #define EXPECTED_GHCB_SIZE			PAGE_SIZE
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f4ccb3e66635..cf6ba59d6d1e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1110,6 +1110,18 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 	save->idtr.base = 0;
 	save->idtr.limit = 0xffff;
 
+	if (!init_event) {
+		save->fred_rsp0 = 0;
+		save->fred_rsp1 = 0;
+		save->fred_rsp2 = 0;
+		save->fred_rsp3 = 0;
+		save->fred_stklvls = 0;
+		save->fred_ssp1 = 0;
+		save->fred_ssp2 = 0;
+		save->fred_ssp3 = 0;
+		save->fred_config = 0;
+	}
+
 	init_sys_seg(&save->ldtr, SEG_TYPE_LDT);
 	init_sys_seg(&save->tr, SEG_TYPE_BUSY_TSS16);
 
-- 
2.43.0

