Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299364;
	b=VTnaU+sXEh7fKOOaqHaR/6QNj5IttnpI7OgdwpG1u32yN64qcEg2rQ5Q9BEuVDouRR9a
	 OQUApcykrm36rKDnw/OmEFc2viIy7tFRsJHmvdH3Mdf2RgPIuOumoloD3KLG6bnmYBnDm
	 eocM7JgqbHkeFz73a//LAw6iM2vXxqoVYjMvC/czldma64Pdgke8l3B+yHrQi6Ck56kLf
	 gyU6VCjZXCWoYuvJWOdrCeeRvTsXD9mTUVNXuMJbkHY+NaieXapwq9jdSRxV/Df66OkOg
	 VUa6MbCV9xbxn7yzmQw/OmnNw7ObYLVNmYn/+AkCZJup1x6Ef+lqspSI9Z3xSAcvK9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299364;
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
	bh=KGe55IHeFB7w/iB7+C6otU2GyA7GJQ6OjZhbWiS08VQ=;
	b=RmVZ3VwfPy+YK7vQTP0/GHiwJ/vP/y8Yqpso+vpTTovhGPwS1RhTbSFTWcbnZtNuMTAI
	 ofRbmeWnRO/wLXMJLOMERAp3En+Lcc1xCFM9Xjn4nYnTnnjCqMsVwxpMH/a32qbhCRGvI
	 WEQlHpsOk7tuX6ne+L0a8HRavz6g2Pc3GB9vg20UzhQM1Utv7lDpfX67uYI+qlRRnw5wR
	 lkyLMGqbOW6rUN7CCfl8c6YPWhr70bCxBEcXvJTYKlfVMplLlyJTgt5EVPkFpu65i3JeR
	 4FHT5H3XtkxTQYm+R6lANQMB/wGGNYbZNY1FW205J9dv2IBEpeX6hGvPYeZXJx6093Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LcOuB7wu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.18
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010018.outbound.protection.outlook.com [52.101.193.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65C660A3814;
	Tue, 10 Nov 2026 08:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D65C660A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LcOuB7wu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPfraEO8RX3lK8HMsGDM0o+6nQZ19yE88rMuNHabk9hc2Yi/wsGlwWME8YSG0FlM0aTW+BfXqfxDzvywhNvnSWys+VsJCTNc6lAszZecK1IYFuBDFhMv9QCUkKrvN6RpY/iCaryqOzKf7nujoGYjqq6TfPf/rFWfN/DGexZ16DPEnGsS4gXhCs73k1vK7flJQR0ok+rRBa0HbTc2Lp8JwQ3MXPq01RfOXD0IrtwxU/l0YZ3DsCZZdXHXJA8hFSB+CeyFV2VSJxR5FmQnhcfGXqMCMJKF6Nk/W2/BhvxvGC8ZSglOLqcCGZ5+p2Rn5Xt4gDvmRNKHXErRi3F+N9NZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGe55IHeFB7w/iB7+C6otU2GyA7GJQ6OjZhbWiS08VQ=;
 b=nQ4x2eu054xDBS8s99oB5tcJgaDNaVXVwKcP7dTIDU8ArejhG5vd4eLMvrrRO4s5UQkeZKnqILBmWMIH+wLFoV7xrsvyQ/Fi+MxeSRm7Xfdm/6WSxYQdlbKv6DmV0ad3Jxv76X3RbIaKQ756JQ51vdyResPUBswQqjaqJLnscFjqZm/1B1qeaMyNYc6a7krT6E7/1z6Oj1DeXlUO9JfZyUxIZ7NRbKBKzOBBUaIWNorfwr/Pocy70aGrDF3K+np/NhRBlJ1yC8lgtxgqYze+BAvGCpXM9qoZtHXp2dED7pQtuEuGfn2kGxgBWen0JfEvW2GPNMqGhboftnDnxI5SSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGe55IHeFB7w/iB7+C6otU2GyA7GJQ6OjZhbWiS08VQ=;
 b=LcOuB7wucPSLRbSRM8vMrnnnIUF5qVooeZ4KIGuNHSCRX7H526eDPvBZ0P/qg9k0h1+ocSWBKmeDzUHp+6aZo6b0QnpmLhlLfs435QqZC5+aF68t3C7bUI5aG3ZIOY3aZ5NyrjWO1qNkl7tckBx7EuNN7eH07kFt/e7oaIqlOHY=
Received: from BN9PR03CA0419.namprd03.prod.outlook.com (2603:10b6:408:111::34)
 by IA0PPFA19DE7612.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 08:29:20 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::9e) by BN9PR03CA0419.outlook.office365.com
 (2603:10b6:408:111::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 08:29:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 10 Nov 2026 08:29:20 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 02:29:19 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, <x86@kernel.org>,
	Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH  1/9] x86/sev: Define extended #HV doorbell page structure
Date: Tue, 10 Nov 2026 08:28:46 +0000
Message-ID: <64d588e4148556fba3587cf399c512e658c4cfff.1794295647.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794295647.git.huibo.wang@amd.com>
References: <cover.1794295647.git.huibo.wang@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|IA0PPFA19DE7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 297d8c75-0efd-47e6-764e-08df3f04b7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|261009223027099003|10067099003|261102123227099003|261026121527099003|261021135927099003|261021123027099003|261021121427099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7eaGhWzy7xJJv1SB8J38NXLrU35opcRaN+dpapSzAc6NZZF/iW0oaY2DoITIRNxDs+JKbv1pSNcw8P7TyNULcrhz4OcnLg2R91X68N5kOPsklgM8LkTWnyuuArY2ZaeaIrWwYitNdtkP+flOjd6oAT2AJ/7dq0n89JEu+GlBKMf21GIRJysNPIFKy4aVQLmZznFXf+JuUMkhJuL+/Ftm7ABUB+9XOI+sWRL9XpmMiMy8XXiycnJvlbMNqAZgSzdvk6fcUukqKpouKjV09YMSALKpiBdTpBzf2s0CICkDc3FGrmuy2FgSzCRLqi6wpsOOv3Tp2Syc/MX7QBEj0rZF2c2dVpIUIRSdxFO8WCO4OcBXLhbGmwzTk2s51f6XulN5Opl+DRBK+qHOw0MEFguStgUHsKM8Gdu9ydkjhVcf9LGV+6IEcKr1/9CZlMCcORnWdCw8zkHU7DfzgraanwRFR+R7+ATO2fXDyfdlzUFzPe1zHWNIMN8aAcIlYoYKtvCf/GdolfVRAK6vEyDwxjVNqVxPTMbSE9R3XH9COR+Zf0hyUiu3c+aZ0rTkYzNQ/rboZPp0r0FO/CBinUoFGeW78hTwCnJkt93KggHK1sN85NKgwi3r8b6TrR/Rl5sHHE5hUrOHPjOfnrdB2zoKQP7pcxYTEb7zuLdMjpewuuLnZfV/qo6SKvS741m8xYsSg02aUB9j9Hga39h4rbSnS+JjKA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(261009223027099003)(10067099003)(261102123227099003)(261026121527099003)(261021135927099003)(261021123027099003)(261021121427099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q4kK/S+jybZOR0LTFRRudXAuULQOELiM6IH0l1YAKM54VLtT3kzz1AwK00RHMC4VpgbBEEah7Di17Xl3u3iwZY1DkrG7rC+e0Wyug2fmn4/oY/bBdA6qutivkqRjnHDdsSh7PuHI44Pt7L8mASEJikvcOaaqvdsyL0qIQ3lT8ui79Qvyn15Ns8jvtXriVU6rmNm0uG9VHRuIJN1z0HRN/lOmwWHjf+jmwpq8wrGjKD3v+gfP22S56Ts1jMtdMNHVmjG+E5q5NGHVnDNLnIIFbKvp6nqjdNVMjAfX7Y3lEgpi0YnnyRmV62sFvMiSImCkHZblivKOaur78veLko3MS/Q2PeKKBI61OMDFV51i7Q8UZfDC7yIf5LA20GUPZCKGrT0o5R1R068ZjmjJcMVr8j+G8LjskeP00cnd0ITCkmYnjr7sEQ4ewa9FK79sjNfh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:29:20.5194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 297d8c75-0efd-47e6-764e-08df3f04b7c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA19DE7612

Alternate Injection extends the #HV doorbell page with additional
information about interrupts or events related to interrupt processing
for VMPL1-3.

Define the extended #HV doorbell page according to the spec.

Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/asm/svm.h | 60 +++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 32a35ee10bce..c658eba189dc 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -259,8 +259,43 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
  * is shared between the guest and hypervisor to communicate exception and
  * interrupt events.
  */
+struct ext_irq_desc {
+	/* first 16-bit word */
+	union {
+		struct {
+			u16 si_vector:		8,
+			    nmi:		1,
+			    mce:		1,
+			    trigger_mode:	1,
+			    reserved6:		3,
+			    multi_interrupts:	1,
+			    reserved7:		1;
+		};
+
+		u16 ext_word0;
+	};
+
+	/* Second 16-bit word */
+	union {
+		struct {
+			u16 reserved8:		15,
+			    interrupt_vector:	1;
+		};
+
+		u16 ext_word1;
+	};
+
+	/*
+	 * Set the corresponding vmpl?_irq bit in the bitmap after setting
+	 * multiple bits here.
+	 */
+	u16 interrupt_bit_vector[14];
+
+	u8 reserved9[32];
+} __packed;
+
 struct hvdb_events {
-	/* First 64 bytes of HV doorbell page defined in GHCB specification */
+	/* first 16-bit word PendingEvent */
 	union {
 		struct {
 			/* Non-maskable event indicators */
@@ -274,10 +309,27 @@ struct hvdb_events {
 		u16 pending_events;
 	};
 
-	u8 no_eoi_required;
+	/* Second 16-bit word InjectionInfo */
+	union {
+		struct {
+			u16 no_eoi_required:	1,
+			    reserved3:		7,
+			    vmpl1_irq:		1,
+			    vmpl2_irq:		1,
+			    vmpl3_irq:		1,
+			    reserved4:		5;
+		};
+
+		u16 second_word;
+	};
+
+	/* IRQ info associated with the SVSM itself */
+	u8 svsm_irq_info[64 - 4];
 
-	u8 reserved3[61];
-};
+	/* VMPL[1-3] extended IRQ descriptions */
+	struct ext_irq_desc irqs[3];
+
+} __packed;
 
 struct hvdb {
 	struct hvdb_events events;
-- 
2.43.0

