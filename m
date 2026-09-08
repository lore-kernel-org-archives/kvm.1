Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133139FCCD;
	Tue,  8 Sep 2026 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853725; cv=fail; b=RmsMeW9eZxAi0hxM/yCsS+i/DMZa5B06xo/cE1GgiJAwZuEFAX+pWFrHw8JRR0CHhwpfG/MCYnf2Eye2Hhk68zyDGq/koKaL+mGTALK8QItfwxEjjtvL+l81z6UbUa9Fnl/0mRsxm98q7qRTSnYeTKOfd5Finm173KbG6mVxVXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853725; c=relaxed/simple;
	bh=65r6mz9u21XnMm2Qr8EvNQDGidZSD4jrHhsD/Bs6oHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bd7veeDVSrmlzfQssBGrc7gFkV/QB7pVfd0XQMffTlpeqAOPnE+VMAaxDST0DP2FpMk75n0ybzbEVFn5Z1vihnU+1HCoYZpY6DOzZrrVoKYMk8r2XvOAczY3+kQH34FRhaYZ7XgYRxyX5fykcHUQlN2tga9AMfAsK7MXXVZ5YsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IMrlP0SV; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IMrlP0SV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvjU/SQzM+232eO8pZbp2cAWh9V2+L/IOcoAtcaQ7iB5XMVBf0FE4NcjgV5be1uvCB3/By3LoC8mxCehCU8mrR9YIdqH8+7061qph/IpJZWUAkDqnVdYGfXjtbOgALiaanZJF0c9vKRMBXbaZEZgMLLb6H+lIZqWcaAja/55flCkIF4vqEDlrmXiNADo6IyEsCETyvLxajQz3ammeq4E1cDiuoUXGq+S0oxXqG0MoJ9vkeoQJeped2YXeN3uQYgfRX19qj3f7OUGxmKaLJTBu8o48DjZMt1tf3GyVl2uCkoJUbA4egnMxuQXPZaaf7PFLphnVqxJIdt1l25jEfZPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdK3zbvfFAvLFJ8N2wgUjRoDe6bN6DLIL192uGMz0jg=;
 b=wLrZOQ2IuTG73FdeRyfmSmTAHKChUQYaJ+Vjf1BW+0k+rhfk/mGkUHy/NUo9w7di4vigvq7d4S6EjGfN5wkig5VDfTpxvFjB2qlNUgdvwupIxkYjpqImrE6Lb3UiOcR21fH2oi+DpuIsBhZkoAGdqoBSqFdR4Ft5c/qH0gppuWZLeY2Li5NJDMGbB0Q7ymESxPSwsEamXLKg0CZVMxZxgGitRHPE8QIDhAR6gkAS+saccix+j09TYKOinwUnWyBze2gqyHyyR54Gv58tvPYano7NGK5l/xQciC3c7XugJ7caMh5+3mUCrQRwEhUmWssUgNFJ+9ehHVU0g5XGzdUc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdK3zbvfFAvLFJ8N2wgUjRoDe6bN6DLIL192uGMz0jg=;
 b=IMrlP0SVfbnCXggl30YRXS/Q5oslbn9gBhMdob0H9zmQrENh5m4kFpMvAM8DAGlR+9Ag4TIJSjH9DF/ACqdXmVBiOBMB8IatwOT26TZuRNO4AfRkdaZZYsabmHr+rqUvoFpYaN6l67zegE7yVgeMLIHJvj+0shPQ7rLFqbhk8xQ=
Received: from CY5PR15CA0188.namprd15.prod.outlook.com (2603:10b6:930:82::9)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.15; Tue, 8 Sep 2026 07:48:40 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::72) by CY5PR15CA0188.outlook.office365.com
 (2603:10b6:930:82::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 07:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 07:48:39 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 02:48:34 -0500
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
Subject: [PATCH v4 2/2] KVM: x86: Add support for cmpxchg16b emulation
Date: Tue, 8 Sep 2026 13:17:39 +0530
Message-ID: <20260908074739.10748-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908074739.10748-1-sarunkod@amd.com>
References: <20260908074739.10748-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f2781c-6ef9-466d-e09b-08df0d7d98f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|7416014|10067099003|3023799007|56012099006|11063799006|22082099003|18002099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	WgGCv8k5eP03t8f+PiUmjk2HwaeekSTMxKRUlmt57/HJg5pWnf6i+E1y/SWZHD4ICaGRi2OHA3G1Y5DdpiVnU15HjG9XVEj7dGey5+K64m602Nzh8ToQZm18azLY/O5Bq7UQJ9s82mglC8IsdRY7PR6DMxD78j86rqS4rhigfGCdbgM5g1EFxO+qQZfOf15t4AaThTtKAoh9UsPj4ofCwQ4MTgTAtWDMNDdZ/hjHMB9clNtATZmCWNktS7f8E+NslVSoNtTYQsmxyJmhPGOWg3xAD+TysFvk1K6rw0pKEhMWFnF21qyhBOBU9v6fn7KLK7iI5o3bUHQp+rwn6AMEqzjzziZmbhJAffd8PEFn6FPBv+Z3YNP/kQKu3F0gjcuxVxP8XxMN2cuaNBPgMOEryDeh7REggbnATwzVE8mmqrtalRY83rbgDzoCFC0HFVrTBgdZ2Yo4327kUz6eo4hbC8IbDeNuA1uo79YaDIzET1TerWGA2HUeCLE6jMfRoHUCi6ruqwz3YFa1x96Ke8kP+yIAiFK6B3C/MaaFHsT5UWDiMYgD0BkKjBraSop2LI+EC0xfO+qE0eFWxxc55q6ls8VEjl8pg26GVjHp92tejtPsIhdxZzxfrK8LVnnAdJDPN9REqmDljm84dy2W4/K5fhRzl1y6I+ni8HIdKTKdNGZXfB1Cw8tMeHpIZboQ4QERUS1SB8EylJLPuWfCRhv5xOYPByykMdCkQ+JMZZGPmbe6Kt0RYslcG+aPETRwkpMP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(7416014)(10067099003)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I0zNvnX9P07TXljs7iDPSZuLyeIMYvJ7ILmNHMmOrvLYan/0rys2jLQAMFC5j7GlkSxOfcdo8Sw8+EQSw5MRfjEN3ht3yTUeP5ANpUIiXm2YHGC2bkmbQg45QZNdt/XmDhi1P9cwTw8+cFLccfaSwg1ELlG/flR4kJtwcCvePbo8/K7ftGUzNe7gUXJElk0KC4Swe7QVhU3o/KU+jD9dEFcKZj0b+81KbeLABQcK51iDl/jb/rBUNfYKS3/uZWmpY/ZqhhHRxlSkkE8imtH0YVfPw4bsekB/8Iu51eXchl4r5Yi201kSea4/1U1oKyJs/tWH7iekx78kRY4/mnhxFnUCUwTUickcjL8eN7+X+MkJKdUWAo5CdoXP3oiqCuXEqRV9dsrzf60F1dGfc+ZMSethFR2YEWANTM+rOPbY0DIQVD2jY23Hl7VsXLGCT+v0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:48:39.7205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f2781c-6ef9-466d-e09b-08df0d7d98f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159

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
 arch/x86/include/asm/uaccess.h |  2 +-
 arch/x86/kvm/emulate.c         | 50 +++++++++++++++++++++++-----------
 arch/x86/kvm/kvm_emulate.h     |  6 ++++
 arch/x86/kvm/x86.c             |  7 ++++-
 4 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 6e10a8a3ba4d..948937a24cc5 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -598,7 +598,7 @@ do {										\
 
 extern void __try_cmpxchg_user_wrong_size(void);
 
-#if defined(CONFIG_X86_32) || !defined(X86_FEATURE_CX16)
+#ifdef CONFIG_X86_32
 /*
  * Always fail on 32 bit arch or 64 arch without 128 bit cmpxchg support
  */
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c1b21282187f..535842336d76 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2184,24 +2184,36 @@ static int em_call_near_abs(struct x86_emulate_ctxt *ctxt)
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
 
@@ -5414,8 +5426,14 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts)
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
index 3e375af15c03..89911845233d 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -263,6 +263,9 @@ struct operand {
 	union {
 		unsigned long orig_val;
 		u64 orig_val64;
+#ifdef CONFIG_X86_64
+		u128 orig_val128;
+#endif
 	};
 	union {
 		unsigned long *reg;
@@ -276,6 +279,9 @@ struct operand {
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
index 79468ddfe473..60be16f05d79 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5271,7 +5271,7 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	int r;
 
 	/* guests cmpxchg8b have to be emulated atomically */
-	if (bytes > 8 || (bytes & (bytes - 1)))
+	if (bytes > 2 * sizeof(unsigned long) || (bytes & (bytes - 1)))
 		goto emul_write;
 
 	gpa = kvm_mmu_gva_to_gpa_write(vcpu, addr, NULL);
@@ -5311,6 +5311,11 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
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

