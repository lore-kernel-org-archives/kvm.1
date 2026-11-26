Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795673181;
	b=sWTo/wBo0kbRgDYoqiLE73GBJqQUWDCgRgeeTOmzg9BbcxtTTs5H0sIlqFCe5+MxVKSD
	 +8NRGufNd6KdM8A/1sSH29oPlEaXGAh/S/76/wmIzgCHZ42RX6e1vw+VHivMc2smeS52S
	 BZN55g0+Si9Iy2bNQBXBOXeeayg1WhwUTdthj5EEvbDwVhz+Cy8OWHZvju+tVy6oONcts
	 HjY6g1mvY6ZeAZkzfdnkNrhxb+mX2M2AVme/yCPnJr3iIXsDFYqmi+qBBZ5Ib6rb2gRle
	 yvuZYqNj7lapFAYrjIfFdm48LRWUMehJKRghzuGblNkM8ZP+fqLHvcN4P/N3deQVq6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673181;
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
	bh=bKwVJ14dbRm8WY12WgcgfQHPRPoxYtHMMbW7HYO/Gw8=;
	b=EkWM9+BI/evd8I/mzZIWm3tIqiEPFwWn/BIKfRsNJTLfD213wRvdLeATiGu+R7NVhV8U
	 Pd84ZHfcsqQI+qKhc4MqlKwpGa0oW+tuvZXkAs1ol+Zim5lerdcJjpvnZ9HJN+56O+oyk
	 8DEp6Jd1MsJ6ukfCSw1YzPP8cqHvrjLEMf4CkTRrPhjfYu4uFPIT2Hl5pBWu2QV/NdDDV
	 gwC2CWK6yaYEiiO/6Ik7gKxangt6R0s2b89trUEci2B/zDANFA+DEUwQDJUuZnPsrmxmr
	 nOxm9FPhIblVYlBDirO+0GfDMigOfzAdmZPwauLW+uiAigxi6Cb/BTIw5/RAnmVFZjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DZgBAt2E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.71
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633F6606A332;
	Thu, 26 Nov 2026 06:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 633F6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DZgBAt2E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vk7A3pK3hyDBa8zLoN37Bqvc7INalm7+qMjna6syA/o4c73ab4ziUoU34ooeRkhjHIPzNK9h04zm+VnoK9Uf9Yg9r47HKZBph3G67Nr4kYLEItfaKSJueNSnj9vYjkDLijrCZflXMcVRd5IxY4IzvuXzx88bvwbDEC07B1iCaVfgGeXpTe9B2NRJvgDppJg6tsmXj76fbFIL8qvn2DYYN56NpL6qwgLkts8f/AHwCXqr/sMc00UGXsA53zQBPHyHTU8AQUlO1o19L+syeCJOyXZC0L2xP2KSOoxypyVwyzuWS0mSfQscZbqJu19U+05v5IYkoMQL36yGnkBU+ApJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKwVJ14dbRm8WY12WgcgfQHPRPoxYtHMMbW7HYO/Gw8=;
 b=JP3EQemxwdFahLciTTBYSzCV25omNOuKAL/zSx4A9SHKnRRnTLBvSdkNXPBHQgKMi/byvqgZ8NmzEccvacd0KMUd0HFDbkUdIR0ivLfAQwcjRBGuTq918J7NSO7b0HXot5AZRv+2EG5xZxbhhIWnkzdjIOCULT7BtQ4d1col1Shm85hUMcjyrKCa+QzHboEk9ZcBq73FR8TyHMjmJfllc4Ll3C7gwdIt8jWP491fRXAq8g19pkBagj9GeTsAU5cnUAkT9hxQWXgE6WQ5La6C7wVENk4UmDBpgqccSe6fg+D684S5fil1fFpcjo02e3L0ayq8a/Pd5c7cniPdF91fbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKwVJ14dbRm8WY12WgcgfQHPRPoxYtHMMbW7HYO/Gw8=;
 b=DZgBAt2EvDjsHYC1jnOR3IlPg8fqw92ak8MJUL6OatxwwDNn+KoY/QqD163MtLenAZCS0YLw5XVDd9yLQQL5bydN9aoo+DWSf6sjRfACiXPbo05shTqs0T1swdSIKPFGhGCGwuKZRes85bphJHGK+Fpl0y++wIIOzXnF0KUEMuQ=
Received: from BN9PR03CA0175.namprd03.prod.outlook.com (2603:10b6:408:f4::30)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 06:06:16 +0000
Received: from BN2PEPF0000A894.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::1) by BN9PR03CA0175.outlook.office365.com
 (2603:10b6:408:f4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Thu,
 26 Nov 2026 06:06:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A894.mail.protection.outlook.com (10.167.248.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 06:06:16 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 00:06:12 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <Vasant.Hegde@amd.com>, <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH v5 2/2] KVM: x86: Add support for cmpxchg16b emulation
Date: Thu, 26 Nov 2026 11:35:15 +0530
Message-ID: <20261126060515.2198-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126060515.2198-1-sarunkod@amd.com>
References: <20261126060515.2198-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A894:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8b4cce-3b0c-4287-b5a7-08df4b8361d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|23010399003|6133799003|22082099003|18002099003|3023799007|13003099007|921020|11063799006|56012099006|260925021911599003|260925022911599003|260925021311599003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	mu7JuKogB1K02NFfYwcdaxdtaJUHOV4A8QFDHa9qIv5qMSBiv1LQP2vE0BPc6T1Rd4qeIZRyKM9lJnaTDwBmhpoTiQjnBbJ8KHWdSFL0xrn9ZRoPrtCbizf2AndP3b5onRcPFhE9FyfIsIgfJxNng4zK8bCIxbOxJd5Sgwbx/nrxW5WMEN9baltaDg43nMmB7I8FtV8pDUbhYmkkjlvCKuAOpxZceTtGQpZOHdRuy0kibhhcKHCdjXGjkdSpizU7Zi65kCs7YffIUvpFxsVnpmSoPd4qDp/Df881KGyJE9ItDazr3+UWDBRAR5JL2j+z8reqGlZW6aT/KHA8qr1ivPH5PMBz/AKE7EqD1pnrJPjODo9G6HDPmxC0lMW6Qc8wljMq6ToYBWs8PNq/QvehRpX4EOAA57hRuYH9iWYi9ruKZkZlx6IqfvQ9z8892KuH51LLqowO5/vmGu0VXDSPr9zT3yC2/BV0kT9g88CVp9KIZBXTyM0Ggl2T2Pl3Rddum5X1N4qxiIBrW4ftcbUIKp2QvfzQ2kWrXtd7Hh66dHvcXJWkHA3+OX8ccdGlxvXDnVliFT8af+nld3TLcMs6M1UBFEgxcQp75MUK+744Nt6hMA/9X+PvFLCrYHYFCY0WAYfeVFwcjuXglQh37FrEldhkMM+rJqikacwwqKCRb0RE1InA1panggV6dhq/lerGOS5LkpYh64FHOGgaQjOelGIZTxN6UMXPfLUduWt6F09y8zOKrr4+8S27Nmb7Zl4J
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(13003099007)(921020)(11063799006)(56012099006)(260925021911599003)(260925022911599003)(260925021311599003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1QvD7xjRWjvPO5YKd7VHSce29dBYX9t/Kh4tjXVTGDJ1D9onOSOgs0qqJRN0PitvYxBnGzvsivzNA6yLUrTJ+m+uKV7oh4O1hC5FK3YrkDOA4u8w4hgBrKah0jYb6G7CubxSZZXDzYpupZDILkkrShUbc/4vIKA1TaZoMHmZuY6HUaMJ1V3bjNKYGF7oNox1ua+36Z/dJ5KpHK6aT7B91vt/YwWxBYXeaCAxG6Dx+TzsznauHHXiCscFxq+0wLfz4sG+ss0aCjIzil3PY/ZfSHaxQh1gbjjFcNXQuemKBp0ei5eUkG8iXMTH1hwOvrlZYqZ/ebh0Ri7LqxunDbUryjgeHlOa3H+A1ndjHN2l/LupwqKbFfLygQ6pegNbj/ogrnQyoxVYcNGVvbpMLYuNFowmLSOj4jCuwCi8KHyIUjsOktDft/SZkUQIe4XV9+FG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:06:16.3345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8b4cce-3b0c-4287-b5a7-08df4b8361d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A894.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267

AMD and Intel both provides support for 128 bit cmpxchg operands using
cmpxchg8b/cmpxchg16b instructions (opcode 0FC7). However, kvm does not
support emulating cmpxchg16b (i.e when destination memory is 128 bit and
REX.W = 1) which causes emulation failure when QEMU guest performs a
cmpxchg16b on a memory region setup as a IO.

This failure is seen on the AMD IOMMU driver which writes 256-bit device
table entries with two 128-bit cmpxchg operations. For guests using
hardware-accelerated vIOMMU, QEMU traps device table accesses to set up
nested page tables (see [1]).  Without 128-bit cmpxchg emulation, KVM
cannot handle these traps and DTE access emulation fails.

Hence extend cmpxchg8b to perform cmpxchg16b when the destination memory
is 128 bit.Also check guest CPUID for X86_FEATURE_CX8 / X86_FEATURE_CX16
before emulating CMPXCHG8B / CMPXCHG16B, and inject #UD if userspace has
not exposed the corresponding feature. This mirrors MOVBE/RDPID handling
and ensures KVM does not emulate an instruction the VMM withheld from
the guest.

[1] https://github.com/AMDESE/qemu-iommu/blob/wip/for_iommufd_hw_queue-v8_amd_viommu_20260106/hw/i386/amd_viommu.c#L517

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/kvm/emulate.c     | 52 ++++++++++++++++++++++++++++----------
 arch/x86/kvm/kvm_emulate.h |  8 ++++++
 arch/x86/kvm/x86.c         | 19 +++++++++++++-
 3 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c1b21282187f..a3483dcc011e 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2184,23 +2184,41 @@ static int em_call_near_abs(struct x86_emulate_ctxt *ctxt)
 	return rc;
 }
 
+#define em_cmpxchg8b_16b(__c, rbits, mbits)\
+do {												\
+	u##mbits old = __c->dst.orig_val##mbits;						\
+												\
+	BUILD_BUG_ON(rbits * 2 != mbits);							\
+												\
+	if (((u##rbits) (old >> 0) != (u##rbits) reg_read(__c, VCPU_REGS_RAX)) ||		\
+	    ((u##rbits) (old >> rbits) != (u##rbits) reg_read(__c, VCPU_REGS_RDX))) {		\
+		*reg_write(__c, VCPU_REGS_RAX) = (u##rbits) (old >> 0);			\
+		*reg_write(__c, VCPU_REGS_RDX) = (u##rbits) (old >> rbits);			\
+		__c->eflags &= ~X86_EFLAGS_ZF;							\
+	} else {										\
+		__c->dst.val##mbits = ((u##mbits)reg_read(__c, VCPU_REGS_RCX) << rbits) |	\
+					(u##rbits) reg_read(__c, VCPU_REGS_RBX);		\
+												\
+		__c->eflags |= X86_EFLAGS_ZF;							\
+	}											\
+} while (0)
+
 static int em_cmpxchg8b(struct x86_emulate_ctxt *ctxt)
 {
-	u64 old = ctxt->dst.orig_val64;
-
-	if (ctxt->dst.bytes == 16)
+	if (WARN_ON_ONCE(8 + !!(ctxt->rex_bits & REX_W) * 8 != ctxt->dst.bytes))
 		return X86EMUL_UNHANDLEABLE;
 
-	if (((u32) (old >> 0) != (u32) reg_read(ctxt, VCPU_REGS_RAX)) ||
-	    ((u32) (old >> 32) != (u32) reg_read(ctxt, VCPU_REGS_RDX))) {
-		*reg_write(ctxt, VCPU_REGS_RAX) = (u32) (old >> 0);
-		*reg_write(ctxt, VCPU_REGS_RDX) = (u32) (old >> 32);
-		ctxt->eflags &= ~X86_EFLAGS_ZF;
-	} else {
-		ctxt->dst.val64 = ((u64)reg_read(ctxt, VCPU_REGS_RCX) << 32) |
-			(u32) reg_read(ctxt, VCPU_REGS_RBX);
 
-		ctxt->eflags |= X86_EFLAGS_ZF;
+	if (!(ctxt->rex_bits & REX_W)) {
+		if (!ctxt->ops->guest_has_cmpxchg8b(ctxt))
+			return X86EMUL_UNHANDLEABLE;
+		em_cmpxchg8b_16b(ctxt, 32, 64);
+#ifdef CONFIG_X86_64
+	} else {
+		if (!ctxt->ops->guest_has_cmpxchg16b(ctxt))
+			return X86EMUL_UNHANDLEABLE;
+		em_cmpxchg8b_16b(ctxt, 64, 128);
+#endif
 	}
 	return X86EMUL_CONTINUE;
 }
@@ -5414,8 +5432,14 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts)
 			goto done;
 		}
 	}
-	/* Copy full 64-bit value for CMPXCHG8B.  */
-	ctxt->dst.orig_val64 = ctxt->dst.val64;
+	/* Copy full 64/128-bit value for CMPXCHG8B.  */
+
+#ifdef CONFIG_X86_64
+	if (ctxt->dst.bytes == 16)
+		ctxt->dst.orig_val128 = ctxt->dst.val128;
+	else
+#endif
+		ctxt->dst.orig_val64 = ctxt->dst.val64;
 
 special_insn:
 
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 10886bea82c9..6926865826c9 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -236,6 +236,8 @@ struct x86_emulate_ops {
 	bool (*guest_has_movbe)(struct x86_emulate_ctxt *ctxt);
 	bool (*guest_has_fxsr)(struct x86_emulate_ctxt *ctxt);
 	bool (*guest_has_rdpid)(struct x86_emulate_ctxt *ctxt);
+	bool (*guest_has_cmpxchg8b)(struct x86_emulate_ctxt *ctxt);
+	bool (*guest_has_cmpxchg16b)(struct x86_emulate_ctxt *ctxt);
 	bool (*guest_cpuid_is_intel_compatible)(struct x86_emulate_ctxt *ctxt);
 
 	void (*set_nmi_mask)(struct x86_emulate_ctxt *ctxt, bool masked);
@@ -263,6 +265,9 @@ struct operand {
 	union {
 		unsigned long orig_val;
 		u64 orig_val64;
+#ifdef CONFIG_X86_64
+		u128 orig_val128;
+#endif
 	};
 	union {
 		unsigned long *reg;
@@ -276,6 +281,9 @@ struct operand {
 	union {
 		unsigned long val;
 		u64 val64;
+#ifdef CONFIG_X86_64
+		u128 val128;
+#endif
 		char valptr[sizeof(avx256_t)];
 		sse128_t vec_val;
 		avx256_t vec_val2;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0549c0b48901..0e8cc7073858 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5314,7 +5314,7 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	int r;
 
 	/* guests cmpxchg8b have to be emulated atomically */
-	if (bytes > 8 || (bytes & (bytes - 1)))
+	if (bytes > 2 * sizeof(unsigned long) || (bytes & (bytes - 1)))
 		goto emul_write;
 
 	gpa = kvm_mmu_gva_to_gpa_write(vcpu, addr, NULL);
@@ -5354,6 +5354,11 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	case 8:
 		r = emulator_try_cmpxchg_user(u64, hva, old, new);
 		break;
+#ifdef CONFIG_X86_64
+	case 16:
+		r = emulator_try_cmpxchg_user(u128, hva, old, new);
+		break;
+#endif
 	default:
 		BUG();
 	}
@@ -5774,6 +5779,16 @@ static bool emulator_guest_has_rdpid(struct x86_emulate_ctxt *ctxt)
 	return guest_cpu_cap_has(emul_to_vcpu(ctxt), X86_FEATURE_RDPID);
 }
 
+static bool emulator_guest_has_cmpxchg8b(struct x86_emulate_ctxt *ctxt)
+{
+	return guest_cpu_cap_has(emul_to_vcpu(ctxt), X86_FEATURE_CX8);
+}
+
+static bool emulator_guest_has_cmpxchg16b(struct x86_emulate_ctxt *ctxt)
+{
+	return guest_cpu_cap_has(emul_to_vcpu(ctxt), X86_FEATURE_CX16);
+}
+
 static bool emulator_guest_cpuid_is_intel_compatible(struct x86_emulate_ctxt *ctxt)
 {
 	return guest_cpuid_is_intel_compatible(emul_to_vcpu(ctxt));
@@ -5894,6 +5909,8 @@ static const struct x86_emulate_ops emulate_ops = {
 	.guest_has_movbe     = emulator_guest_has_movbe,
 	.guest_has_fxsr      = emulator_guest_has_fxsr,
 	.guest_has_rdpid     = emulator_guest_has_rdpid,
+	.guest_has_cmpxchg8b = emulator_guest_has_cmpxchg8b,
+	.guest_has_cmpxchg16b = emulator_guest_has_cmpxchg16b,
 	.guest_cpuid_is_intel_compatible = emulator_guest_cpuid_is_intel_compatible,
 	.set_nmi_mask        = emulator_set_nmi_mask,
 	.is_smm              = emulator_is_smm,
-- 
2.34.1

