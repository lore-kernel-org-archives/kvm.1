Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794954827;
	b=pAXTJihSq5WSGRxTqz/sSZt8q+T94gF0p0+bhhGwfWvOdPnxRF6GuQrEvbsXscXP6YbA
	 r5zV0oVS0EBOpZ1jCtxyoHZhx46N1qe/GYzoHnI0ZYVL0st90PVLsGn789s9L3fZgdP9V
	 OJTuNnGhFzXdzlHgjqU1tgAt7CQ281owIsRL68nACznBGqfpXwjyE+3ZsFFPFButTu7Gy
	 f+WKbjwF8B/EJgvXAlEtbiQmoZ03zcObkHmHeyX+VFNS6EnDCL8jvNixcaCem72ei/X7X
	 +eT0nnm0YGAghTiPEeMPDeipqTbUyEPpm7KqNvU70CoAQ6oRUcDb8AxsTBspkfSK18g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954827;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yAds9vKoPlwNAQLPVlq02CPdwJ6doQXrxNZP+ur/dko=;
	b=ScgAsNdHz3vjNFO6+BPK4rsfgmLzLm+K0fhEnjnkp6Cyb4dRN2AOPR08StavBpqhuJ48
	 x4b3fO1FSntrVlkbpQnZcd2ucGQpDI1A+U8z6rgrFzLBs1MLoT2sOuAyqHkrO6Fyb0bOT
	 3ONomChu5PLv+o6t57n8HixKtQ+BJVW4n516hUik1DtBen+6WnYQbq+Ufa7MsrN+3gMVx
	 7l2FFZNoSB45Txl44GRcdz841hapMBbAstZvHaLn8/jof3UZuUFI0lRD3Zufj8bobUg1Y
	 jFE0DLLS02Ya8WnhRDNvWXlgkKQqDyII/WDuHQLMlfkOj1S+IYkEdvrzVWsI/URMfTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=M5rPfZVa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.27
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A1606A31C;
	Tue, 17 Nov 2026 22:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A7A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=M5rPfZVa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gux+fDrmZNfgzmvPLEsg1BdbdTri2kmjyXTQPqQm22Maw60rxA3HE2xS2GHgsguzcftpxRK/k3rVHK3oq6kGqRrzHMCAvEeXS31gFFQUQKEuEpKqxT0iT6+dm5sA2pCzF6qGvAQybS1fdFCU1vOUeBy4M2tW5tj5HRNqBaT/WcZLFIgBSdq7g8X1iftq3lpMuIICqBPQdtnP7DN5GYByQNxj7oRKeokpgpiV4Y/B6/BHhE1lo1W5ztMUMCtwfaBtYz+UEBVMqCCyxH5+kzTFx6PfPjboHWjTXn/+Ql/gBmvutsJiWhoGYzCWR2UCBSsFjAmD6B2kwjvqisUNv2J+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAds9vKoPlwNAQLPVlq02CPdwJ6doQXrxNZP+ur/dko=;
 b=QeO4vv8qLguXuCQLVIugMXoqQgricXzGfBFInCQmH8bILJt5ryYgXXFQxAktJbMFgaoeTIy5vFEzwMTOVELdYhtwfrahY73Lpz9I2G8Vv8qyN2zv9KePWcEE6lpF5xaRHNsyePOrvA0Je2WOYC1/ZJgOXFIVaLk7N/LZRYuUaYO/gOGoRvz+QcQ9lja1EWL6XZRNBK/z93La96NAPLvbWy9xIbSMoTRniWWMmZup333i9BulnFuuD/q1Nnoq4bYMeWYQVthTf6jep1LS8X92SkKxWPMB3ILwM5k4WgiIEG+SVADS9DTxWppcx8DSYqDDvbeXpjtEJoNSlJWsZCtjGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAds9vKoPlwNAQLPVlq02CPdwJ6doQXrxNZP+ur/dko=;
 b=M5rPfZVaUbtJ4J3x8gthiITMTn+tg710EOiJWwT4fzMpxzY/1qIJFJkay19JSMGLNUe9P61BdLZcrJz3ICOAzm+/U3+eQm/NbAMm/en2uUTG2JC4QKovdxYf9VUgZw3CCpHOszwFK2kMShiS4l1qcfUal34HZaSvzOolSoIH3RA=
Received: from PH7P220CA0060.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::29)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:33:42 +0000
Received: from PH5PEPF0000002D.namprd04.prod.outlook.com
 (2603:10b6:510:32b:cafe::a8) by PH7P220CA0060.outlook.office365.com
 (2603:10b6:510:32b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 22:33:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002D.mail.protection.outlook.com (10.167.243.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 22:33:41 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 16:33:40 -0600
From: Kim Phillips <kim.phillips@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <tglx@kernel.org>, <mingo@redhat.com>,
	<ardb@kernel.org>, <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	Kim Phillips <kim.phillips@amd.com>, Nathan Fontenot
	<nathan.fontenot@amd.com>
Subject: [PATCH 3/3] x86/sev: Distinguish CC-blob failures from generic SNP-unsupported
Date: Tue, 17 Nov 2026 16:32:57 -0600
Message-ID: <20261117223257.748178-4-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117223257.748178-1-kim.phillips@amd.com>
References: <20261117223257.748178-1-kim.phillips@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002D:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 160168f9-5c6c-4baa-e213-08df44fad505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|3023799007|261022115727099003|261022105027099003|261021123027099003|261021121427099003|921020|261026121527099003|261026140227099003|261028144727099003|56012099006|11063799006|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	0b0ENkExFpOF1s/pvz8dxTTUi973iZP5nT6A+wgsUDsdcJ0si1qQ+AK84lAIvSPvywHei/7j8QXNL9PfmoNgDBSdM7udD38V6xAwLrVJK6Oq3kfOgbPjzStsU/tFZw3TwH77SOEr2FgbGNXw9l3ojU1rS8qcJbVLraBAVhFQ8HdPDSgpGS7HMu9ZqVstSEuq3oM8cB9B/GsU6bnnFO8e0vV9hdD50bWGJswFypjnjhzHERE6xW+Z03MPpJ135ZFqGySyZ3hrtWdV3HNWhg/b4b6ZAurL7oGs75SgqVwhug0mHjFNojOGeBSJ87JeXFoSWOdtso7BvVeBt/fWwr1LkYqMSj0N1+2lmzJ0V0BfQkP3lvAF92ZmAQ/Y6Fl06Q6Br3ZohQglKoBA9VGn6AXnnpxwC+HUUbJt09wnOtoPq47nAuT9rD09D95gyTDmkJYsJt9Z3mc8AG/txcIo+C64iqN7DK4vfYJSqljjWIDGxroIP9FhBuBwDC5VWDEhUv32EU0+UIC0S/pimZLgKtYpmj3v8otsGnJy6QDa+4lxDLQgjBc9vkg0NfJUEJBYDGlV3hPpLLcgSbB7HA3lEVuDAeJolv+dr9yJamMcLftOTA2Sk3BljeK0aDMxn1rIZOATzmQaeicvN5gqQ2FtizvnG/l+TbQN7mhKxrCHTSjrZfOFkdYnLv02nAZUaj9Ct4UrDNaJq7MkeXDfeuaCXRxYm1P5HKW/IgZ8GhepFNv6jmmBTV91xFwpaKFxMm/6Se5v
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(3023799007)(261022115727099003)(261022105027099003)(261021123027099003)(261021121427099003)(921020)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q621hHh1ItIPSK6AfjbS/R+UfdZ/H5rEtQSqM9NDuq3w6MCGEeICU48lHxj/Mjh7arSVa77C4hBTI4dGaC6ZbMfEyTkeMpfa4v4pJb55uX/3JhLMvawlBmejW2HXTHbx8eqeaklgM8CC/oI+ZqOD/XloTANVugZLgpZq4wf07bBZow0JJQE4G/5S/WuSHheKIpLSBYJco15O0mrJkc7YiR1+r30bpozhhkER3oDsupo6SjljKwKqJu6G9yo+tB35QVke+c86NQ1jEQ3xXKESaHp7B2Tg5MZLXY3q6/FipuUk8ERBxdSLTivk7zgB+CCvm052NBYH7anYu8TAs3zC+MNMeiddZVHGC9Ti1qcIJmtBkTnMkstY7DP9E38qkNDoqtybRtNalWX1MkeVR311gb0hhSYzNMIcRZl+dR4jhMHsPABArLjpBiTT3hutdukV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:33:41.5562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 160168f9-5c6c-4baa-e213-08df44fad505
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH5PEPF0000002D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199

Both find_cc_blob() implementations terminate with GHCB_SNP_UNSUPPORTED
when the Confidential Computing blob they located has a bad header magic.
That reason code is otherwise used for a hypervisor that genuinely does
not support SNP, so a corrupt or misplaced blob - a firmware or bootloader
bug in the guest's own boot chain - is indistinguishable from an
unsupported host.

Add a GHCB_TERM_CC_BLOB Linux-specific reason code and use it for the two
invalid-blob-magic checks. The sites that truly represent an
unsupported-SNP hypervisor, including the CC-blob/SNP-enablement
discrepancy check in sme_enable(), are left on GHCB_SNP_UNSUPPORTED.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 arch/x86/boot/compressed/sev.c      | 2 +-
 arch/x86/boot/startup/sev-startup.c | 2 +-
 arch/x86/include/asm/sev-common.h   | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c6512f2ea31e..2deaf8bfaaa7 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -274,7 +274,7 @@ static struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 
 found_cc_info:
 	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CC_BLOB);
 
 	return cc_info;
 }
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
index 789e99d38d17..75b40aefb856 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -145,7 +145,7 @@ static struct cc_blob_sev_info *__init find_cc_blob(struct boot_params *bp)
 
 found_cc_info:
 	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CC_BLOB);
 
 	return cc_info;
 }
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 3717796c4673..ee251fa5e266 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -212,6 +212,7 @@ struct snp_psc_desc {
 #define GHCB_TERM_VC_FAIL		13	/* #VC exception handling failure */
 #define GHCB_TERM_GHCB_SETUP		14	/* GHCB setup/mapping failure */
 #define GHCB_TERM_NEGOTIATE		15	/* HV GHCB protocol negotiation failure */
+#define GHCB_TERM_CC_BLOB		16	/* CC blob header magic is invalid */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
-- 
2.43.0

