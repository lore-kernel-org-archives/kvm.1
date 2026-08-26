Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013035.outbound.protection.outlook.com [40.93.196.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADBC37F303;
	Wed, 26 Aug 2026 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727703; cv=fail; b=cxtxMTe10HqUas0qrS5LbQgIEFucS8axo9vsVZZ8RWyODdCuxjw2a0oI57m6Fwit2YKeVzE9Yxp/9FgM1OKVSjAx3TSHFH3OgNNF6N+ZClg4Wcn3BNjor7XMSfB5yymz0TjYXExvSu9vY6lH1/sHM8M2xR0NABLemi4TFW2qCVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727703; c=relaxed/simple;
	bh=4dbwfgAhiAlBu7lft9Qm64mYUyGlGQ+IGkZLbS9SkwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9RJCAdRotEn9aKoVn5dawJPbqyYidJCZbGBLPjEpT1HYt7/FEQEWb/Ci3ZzqWDznmyenhw+5MRQkOAZhAr7nYED9qjijcwFUbfy5BhwXrwxYKakW0DrCfPOcJADGPA4oWB0T0xWcOYBiD5/1StOkA59hfxPugnlJ/oo4EUsh6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BF0rG10O; arc=fail smtp.client-ip=40.93.196.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BF0rG10O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpSgjk1BcBct4rQhFrv+Ub65YmJ65N17LocXXZO9j9Kcd0hBUq3bn7UaqzSbnr1dv2Ym3Vb+gVAJVPT2EZRq73rStaNBrq78WsBhBtQr6Ac9rHe2FyRRK7pYR8Q6BheQhoZ4I5CGuVlQgTM0eRlObKYaOvWLuQsaQLIoj25GtE/4+B0ev28DqkEFwbS6BmXfNT8a0PA6ZClrZcjGk36aFUpR0LuUPOA5HuIje5Buo+SAZLvnf/adhKbashtntbeG7lIPdtjf0nw/IMUXgC2RGf18l/SHPwIcD2XFvE8mfRGlFmJ8PjPBXJZ6T/u7urNY1LtwPRu26QWdMA2IQy/7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSEyORetFbV0PsoszlD00CJWOqUV4itvcCd+aaceyG0=;
 b=P+hrlAIe2ymbiAee7P819J+wVV+tU76TNxelj7y7BOXe6IipNcMP+nNzoQoG0pnWqf4Q1cflR57T9F7KJJb9XaTO19wKns3eXJgX8E9PQCrVTrrsc8ye8++lUZ100ZVF50s8YpbOM+HZhqRyIZgpt4IPSVmpqLV+SWqME5Om8PQL6bt8KSo4UMw3+g8tfOiCRwJg565073TOK/wIscx6sSE9atrEKT6LsNGv2ibhkVrSPFmjcLUqTImLFMNF906XSyOwQ+ikC9AUtys6JkBNksCB6Rpio64ZWu+GpXa38Ffxw+Sboyy7ye/y8+z5US2I1HQ4SREp6Le/Uf1IT/oXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSEyORetFbV0PsoszlD00CJWOqUV4itvcCd+aaceyG0=;
 b=BF0rG10Omk+TgjVS/jIu+5WpK1g3+bEYjn76WvCwWsdH6UIhf431Y3Mlco0aT9Tb2wBPSAEq2gSGggpE+iQaSRLv1fbXSTmxnttM5zkL7zNKJk9dXohK7o1iYiRT2L2BCCe24Oewz8BDp+iUKfUpQSbcr7Lbus/AoIlyQYL/zyw=
Received: from SJ2P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::19)
 by SJ5PPFC41ACEE7B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 07:01:36 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:5da:cafe::6c) by SJ2P220CA0006.outlook.office365.com
 (2603:10b6:a03:5da::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 07:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 07:01:35 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 02:01:30 -0500
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
Subject: [PATCH v3 2/2] KVM: x86: Add support for cmpxchg16b emulation
Date: Wed, 26 Aug 2026 12:30:04 +0530
Message-ID: <20260826070004.8100-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826070004.8100-1-sarunkod@amd.com>
References: <20260826070004.8100-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SJ5PPFC41ACEE7B:EE_
X-MS-Office365-Filtering-Correlation-Id: ca28e3df-9722-4db0-2cd2-08df033fde51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|23010399003|13003099007|921020|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qr6bNgM/GEsYVjBdIg8I41TdlK1lLRdWrSIJEZdkLtL+xajkQokIVMOO7TPftAd472yh6B3Fosk/LtpxidfgmOaf9T68Utq4KwF1NHluLhY3RBA5fk7EQVe+U5hq0Ti74fZB821oRjv+fSB6ojQ6FN0RHWSDJ2c7lYgBPOY5KNyY2Z4+1t1YJ8UGLifTqW7LkCQSuAFSiP2jNL9qAxAPkBWGUEowoJR7EZLrybGmcSs0cFspnDw6ztdq9L3Upbr9KAMELHmwZeh63er3hZ6Y1fKXNAB/PiVBsyPx4dqLkODwlVNfQbPony8cuPJNgqgsA6A3g42dqZ+NCPCYDYrO5XTNLNVbZMRgFvFtCKn1EDBM1JEFs5yHFIr1KS1ynGQVs6lwJJbKiTMI+d9qWDm87pVoD+rFyhxC709rneGLvQZlcsl+jlsV0AkvsKrz5GdjvVEInQW/ChOG+mkEooHw3hhZiq0VoNWJk4f0trpp2jsTkVovvgmWMhNrFzPNPxcJHWHDAXruUK47s8yRZEasXUx6gFFyz2evGE0AVb3MqbrjHkdZguP/WP2OdSl7HahAhutlBwSXkYMW8hVh9CEROkYRZXy2qWAFJ2ybRnYa68vMZFleiLxJofVSVbLQ6mF8uiOSgYzLsfWRA8KOv9oPWzWNmPE11NDxGCJERCLa1FBU+DTODM+WFSPNz5o6QjiqfYaoWIWBEa9mLNTeHI+wOU5tf+sjosL5qZalTrOMGrZ6mb7Km/LnWTDtaDGMGE0Q
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(23010399003)(13003099007)(921020)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BKsP6F2BWZurZcx8PbLy68d8zdH7n+nG2z8YEuL+pbGBuQVaOnRlOKNW6IlIuzarr/6X4CUNGGnCaOoI/7P8iNdzhladYswZaetxulX0ONCQ2k9KCwHgkT+tcxiZpxoB3s5kr0UNzCe0M4azCN7vo3Kc5VN99RSMmmmQgbGbcNKRDgmmGOtMnbPxktSiDLn4lvgyK/N1GREw7PK19+bdJfcDuID3w2BPyUVQZbWdXIncOrZ56fqTc14oEYmu8/H/cXpjY6h9UYmfKSzpsrCKWdtQeUEaZEY21F5YLFcITkczefueDNWcbmsakYRdl4PD7oKKBOeAM/nx4My09OQflomz0rInS2MnhQQsliNPGXkRWEjeCupZBHBGI3sIeebvVm2N7Cb+JSmWQ6QCenGpd4EL0mGbR6Kh8/8aKyMOIW1BBN0GVMOa1Ro6NuZGuUEn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:01:35.6844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca28e3df-9722-4db0-2cd2-08df033fde51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC41ACEE7B

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
index c1b21282187f..f38c4f1a99c3 100644
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

