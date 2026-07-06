Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013043.outbound.protection.outlook.com [40.107.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1A3EB101;
	Mon,  6 Jul 2026 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319595; cv=fail; b=CY3Z3H051zqJEorq3GDlCNDCujQyHEHq8wF8AI8qOUzNGfyM8wq3mhLd/Mddgq6/l5KXXMESlsi839AMv9MObXCv0hS3IhyKRAiYNCkDO2X9hNilyBYT2jb1L7PD8IG/7mIJFR76727rhIBKXWf0i4/i6HpUzi+eEZjrV6+W3bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319595; c=relaxed/simple;
	bh=4Phqe1qZ70t5kFbvEibYVaLDsOFwk4vdh7WN4j5rCNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gM7J3UWGaOuVHKz2/FlPMfI5++HuMQJwtBuQA/A1xYTBCqhyllvfNst/cy9CFVF8u1HW20SP/TpvVAKIfvPEWTNxFgn50o1wI4iTDFUEMdo9xVyf6cfbuCWg3Lvkh42q+w+WzA4xcWmdT85OBxsEL18AyZfOi8ZRvzauBJGJnbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fn5m0lX7; arc=fail smtp.client-ip=40.107.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fn5m0lX7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCEbx8R55Kr9736bduynJjHAuS6X27Y9U4wej0W9QsKJ2bYK7vQAp+Il342k4yloNNmLaUbIdevsLoC93z3vcXRZQ5iA1i9I/QdEv5bvmQU5rBUtaPL0Iop+daAb1EIZgfTwchK0NP+HK/mCKDnEZ8qvTYQ3uBgzWXdMw1GPCRfhhVas2dPFL43JojWLpbaD/eAxJhuq1WSiLeeLtAZGgv9YLkpMK95v72CX1f7H81uDEA5zFSAjOL36EVsD0DTyshQZ4qmO5O/57nP/GLNzOYIxC/b6K25mAZSR7JPUteE3DxW54jZlXQOvPD2A3hp4sg6OINvQ6l0l/cmeSQG9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zuMcvswxN+H7oy2uvn0usXp5iUt5kHJky9igpCH6fk=;
 b=iPu2OhTxNJyPlPLUULXwjdXDkMn9zbrLvS13Vwl8qpq5LtFe4sKgMKtxoPBxyRoFyZL8Twr86zAR65N2LHSuB+WOmv3UZvjrGQJtFLjAoM1g/FtahA2XR/D/yj1HnTNVeydspzroO1sQL/O4ZuxngdDUjx6Vi+14qtWKkC8zw75HbyG6Uzoud6SYP0BHVzro082x0yoxQkxpLErwnHrZcTQO7htOLUbuOzXaQQxPDdhbASWgMezk4zrCv33eq383nfyHCtwWP8Qfu/rxSS0AU8E7wi65rPB2zi3ndCP9BP+JpbUAKdDOAIqAs0Stetgr2cl4tcNJwOupO4vvebLeyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zuMcvswxN+H7oy2uvn0usXp5iUt5kHJky9igpCH6fk=;
 b=fn5m0lX7coB/fJ5FB0DYzwl6mja0qei7ah6I7B1ZQWjhVeTqIoCjVkyjgYo3iSg/9uHXWUzae8NRL1abeMRZWZQgZQM+7c6A/72q3nny+duPGpFUMWip8Gd+0ylpEqZN3/8+vAmHnPwRP47T2Kmv2nUaGc8nMUgL5tWwSsSKBcU=
Received: from SJ0PR03CA0173.namprd03.prod.outlook.com (2603:10b6:a03:338::28)
 by DS2PR12MB9775.namprd12.prod.outlook.com (2603:10b6:8:2bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 06:32:56 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::50) by SJ0PR03CA0173.outlook.office365.com
 (2603:10b6:a03:338::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 6
 Jul 2026 06:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 06:32:55 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 01:32:49 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, "Uros
 Bizjak" <ubizjak@gmail.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 2/2] KVM: x86: Add support for cmpxchg16b emulation
Date: Mon, 6 Jul 2026 12:00:35 +0530
Message-ID: <20260706063035.1139-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706063035.1139-1-sarunkod@amd.com>
References: <20260706063035.1139-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DS2PR12MB9775:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f851766-ec91-49cf-8dcf-08dedb286a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|82310400026|1800799024|36860700016|13003099007|921020|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	BncwdL0Af3HoFetf1wwGkt6+is6WlvSL7ByEQi8qj/o3CD1mkQmntd5vMLE7ki7SFOSOgzNkMFRX8kjtPwkzWyIvnzwS5l/ABZhMjNTmL3FkekAEQV61oXrwiPlK3EMFlaGj/snsgP33ANW+vTbQWN7FF8UuioklST5hTLWKMFhwJTHOUMTiGwJJBVHTMDtOd+4eceAZzb02a5YseEGX1HTg3xHbBiOYkTpF/nhyizUmWq7t9jQiDVz3bmBWLS1KhfWP/tsPnQPlQuStuRiDZK0yW4q77LHkhrZyd0fkzfgQIZ2GKFRbH/l5+1Ce0shwTEg4smfXnISldvXMnDqU9cHkydSFxSUGP/r4VOl6sBCINyHGI8gGxzfvlWtTOf5POzTzMF/7pqC8aMiZPuGJaBTG5aI+nsUsfORnVjInzK3/3GG/eagG1/Wr7H9NM+InXD6WwwI/26y6d6CaaajbD+c/LD02GmI8hd7kMbcmOetcCcKINiUJ1JR73oBYyfeEZiMcrfPHCxJHFtXhSlVc8SThlkjKsXQ2fUKdYbu7a0v/suQg2HIN27YvhAfxGPHELJICKKWVXYdB/PvVePLAfMNFr/c40y7s/9zf+ToQjgopj4aVvCOxEFa6AbX8tJlwf4FBksL2YwyC1ewUVuLe9l+Q9QzmPqXRrh4tKDK54pjWcGX0LRTc3jlgAebDC/nMA0GkIigrS0Twi4cCjXmyhWUxZLivvDZdAlnLHttFTyzlPjiy84p5Gn9Pipw97rgJ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(82310400026)(1800799024)(36860700016)(13003099007)(921020)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kOdT94xlNiNxjuaLZv4oMoRSrfgnsYWe/3hX0CDqu+mof6Ur2K+7j4JB4tjDgnJ2Ce149wVYgbyyWIIRdxHZ4fFoFZyc4oIEW3Meb+zk1OH3FzNy8CA+zbOoJmdfzAx74In1xdYow26PxNF4RlwEa2cef6LEFBUmeWwqmbm1bz+WODnZpmyqmp3YWL1MQxvPVjziABwGZhpFwwSlLquxXW8d5eWuJOuBCN7Y4I8zGiQBaBEUR6cR+t+uyf1cNuTcZOPy+MuwAfGU/fxSAnvUMkxf+AXw9NtzTWwOffozySCMpRnoN5lEMYJ7x7jME76nsD0ein2YwUV+bnwUT+BEGF7bPhSCx9+gsLJWRrEQOFq2XUI69dHPVO34rh9SqA2R/nMaYZbVw5ifCswNPZ8gPBut0CR0mU58YBGbUEM0Vc5sfebET5mv7JVnmkpSrmj5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 06:32:55.5167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f851766-ec91-49cf-8dcf-08dedb286a02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9775

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
is 128 bit.

[1] https://github.com/AMDESE/qemu-iommu/blob/wip/for_iommufd_hw_queue-v8_amd_viommu_20260106/hw/i386/amd_viommu.c#L517

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/kvm/emulate.c     | 50 ++++++++++++++++++++++++++------------
 arch/x86/kvm/kvm_emulate.h |  6 +++++
 arch/x86/kvm/x86.c         |  7 +++++-
 3 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c8e292e9a24d..9df55b3c5627 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2188,24 +2188,36 @@ static int em_call_near_abs(struct x86_emulate_ctxt *ctxt)
 	return rc;
 }
 
+#define em_cmpxchg8b_16b(__c, rbits, mbits)\
+do {												\
+	u##mbits old = __c->dst.orig_val##mbits;						\
+												\
+	BUILD_BUG_ON(rbits * 2 != mbits);							\
+												\
+	if (((u##rbits) (old >> 0) != (u##rbits) reg_read(ctxt, VCPU_REGS_RAX)) ||		\
+	    ((u##rbits) (old >> rbits) != (u##rbits) reg_read(ctxt, VCPU_REGS_RDX))) {		\
+		*reg_write(ctxt, VCPU_REGS_RAX) = (u##rbits) (old >> 0);			\
+		*reg_write(ctxt, VCPU_REGS_RDX) = (u##rbits) (old >> rbits);			\
+		ctxt->eflags &= ~X86_EFLAGS_ZF;							\
+	} else {										\
+		ctxt->dst.val##mbits = ((u##mbits)reg_read(ctxt, VCPU_REGS_RCX) << rbits) |	\
+					(u##rbits) reg_read(ctxt, VCPU_REGS_RBX);		\
+												\
+		ctxt->eflags |= X86_EFLAGS_ZF;							\
+	}											\
+} while(0)
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
-
-		ctxt->eflags |= X86_EFLAGS_ZF;
-	}
+	if (!(ctxt->rex_bits & REX_W))
+		em_cmpxchg8b_16b(ctxt, 32, 64);
+#ifdef CONFIG_X86_64
+	else
+		em_cmpxchg8b_16b(ctxt, 64, 128);
+#endif
 	return X86EMUL_CONTINUE;
 }
 
@@ -5405,8 +5417,14 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts)
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
index fb3dab4b5a53..a51677217ada 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -255,6 +255,9 @@ struct operand {
 	union {
 		unsigned long orig_val;
 		u64 orig_val64;
+#ifdef CONFIG_X86_64
+		u128 orig_val128;
+#endif
 	};
 	union {
 		unsigned long *reg;
@@ -268,6 +271,9 @@ struct operand {
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
index 3fb64905d190..40c84f8c4912 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8322,7 +8322,7 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	int r;
 
 	/* guests cmpxchg8b have to be emulated atomically */
-	if (bytes > 8 || (bytes & (bytes - 1)))
+	if (bytes > 2 * sizeof(unsigned long) || (bytes & (bytes - 1)))
 		goto emul_write;
 
 	gpa = kvm_mmu_gva_to_gpa_write(vcpu, addr, NULL);
@@ -8362,6 +8362,11 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
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
-- 
2.34.1

