Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C32E228D;
	Thu,  4 Jun 2026 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584435; cv=none; b=n29kdo0/ofMf/racQ3pqDoF9xcIgx+RY2JWl1H+YsRFkAXPnTyCQ1voqJFryuRzecVeFAxGpULkN0qyjcYhO+zbAMRTH84K3VihEwlu6UMZaIzBMYuUicsqZSZqWC87k56XnudHP8NSwwAK50NrV3JTIcqIugtek5n2z6KwYbq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584435; c=relaxed/simple;
	bh=jgrP38vN0ksP/oa1kiyCmivDmkkc+7nIEFf7CigrHKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQzCykUqIEhlppFqh/DWddaaXmf6M6ik138MrvvRw4wxssDfsVLkjhswGzINttyjVU05tYfrKoJbFqefDNK3btAFifLUAzeiCqZtLIfsa/RX2mRoK+bOxORbFwJiKy0qIPiAmPgWuGYNzeq0kjBOy6GIvb9vE9C8RpCfStFWiZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA4wo/Yi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA4wo/Yi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F79B1F00899;
	Thu,  4 Jun 2026 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780584434;
	bh=Gap47TFOhQ6ls41YxeGXU4G423uVPHsg939VsDxPFk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OA4wo/Yit6QC6SB+7XkFzOujaIAnMDInZ5pbKNYuZ3X0xGlydjRhONcAbEjMDmux+
	 rYQlzewkDNaSOmN6YGaJnF3sNU18oJOq/ypMoef7Y9gBWCBCe1xUY/z/dU4uGmKR3Z
	 nEQAtBJkCiEPi8V4vC/U8/BE+/zx+pk77/E7PWmX2hywjkxLWSRIh4bzmN0YWrM+3X
	 aZMQgVS/WR1zAuhFJqzcFbGs3R+udkb1bsgHKCo/Hd9EGJ6MJy7ciz3RUI8urpfC/W
	 Ha1ZbfkTm9KOiz+dPANtzI3f5oA8P3t15euYcVSpvj+4d8LhbneR01kSb78qQvL3qO
	 D4umjr9Z21rIw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 60A49F4006A;
	Thu,  4 Jun 2026 10:47:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 04 Jun 2026 10:47:12 -0400
X-ME-Sender: <xms:8I8hamkVDjx1vv_gCAUnMk9k4UR47wDgOIBF-Xox9PwmUyQdHV8qGA>
    <xme:8I8hauMnFs6LCF6ZpN8QoMRck9XdE5n0M9mJ8J_k0cXEEtOGG5eFt3MW-tiRZOOds
    4sqRZbhwTP9oxmN_D4_L0Z9-HP0r386Nbaz8Nu6B1YVBAvuMUvTMw>
X-ME-Received: <xmr:8I8halz7QsU7_Eb_1X1x-akBuELuyiRQGwSvBoA6F7phy3jJNjcE1Er5XIEu-g>
X-ME-Proxy-Cause: dmFkZTFj8ZnrVtOWx8yn50yce9nPuOihKudbBgfFxqft5oPy1zZX5JIfLuFpGdCcWrnhfl
    Pxz325N4XazAyAzTdNz9aWTIHmCJwIofCI+99fVGtXOCjxSo8k+EHuf2f7CbPoHEMSWrfL
    Eu/vyp4eHayFnrBZ+cvyjC170T8MtAfXrlwruHYlST6W6tnHi2O6FaxgAEwRiKVEZclZgB
    1OCxiWZWO0+bd+wOVrTUbIWcIOKxo9Jhw8E1nFS7ABPYRi3tBDwc6A3isnRgid/yx8777k
    UbZgmYnR8zVjavXZPBuNijxgMcY5IV2jOz3OuyI0TuHvOl6pbuCj+E3+Wwala5e5leikEG
    C+j80mjhalvt/GDp7Kt08a3Sdvna0iBUHd63KUeNIYVAizY212bFNayQnsE6YGNQ9bDdU5
    yjCD8mQ79RkHa7mHneLUSPxcUSoY0RAdvlDZ5GJqOHTFkuJbe8NJ+DTrjpsQ8JZwil1fjE
    FfgkAelctBIXeXXC5I+Yx6WUPRuegb8q4KGzM7FXjnNkLK/Pt7IXHIrbbwv48OiuILve2a
    PmYdA+kzbDzP4iRYWejwTR4+mMCT3DbFJdoc2erIO81qAUAZgENV7QIH2rWDiuZxyCpRwk
    /UI0kmcW0aLlkdxKzTlkpNVQPrnQFWSMmBt/gZKeufI97vEsqbUSlgUkl0bw
X-ME-Proxy: <xmx:8I8hamlf-0kSWNvKyhQIFYUIV-MZp0_YO4e07htjrV_dTmR6Uwn9ag>
    <xmx:8I8haj_6uvVtbW_4874bRh5QSMy09VOWb74eJg1I9CtNE-w13jA8XQ>
    <xmx:8I8haqPOQJwW8e4qw16M8uX4AOJxBntYjErlgsl-T_nueocNsi3pqw>
    <xmx:8I8hat8KqN_X7MAcWOSR7j8A_DJuBQ7KkYMMoPb10sWN8Baqve7KVw>
    <xmx:8I8haiLCUbeeDY1DJwxJvCUYldoSKMzRYAS5uplOiFDuKStQtyUlWObE>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 10:47:11 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	kai.huang@intel.com,
	xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com,
	rick.p.edgecombe@intel.com,
	david.laight.linux@gmail.com,
	ak@linux.intel.com,
	djbw@kernel.org,
	tsyrulnikov.borys@gmail.com,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v4 2/3] x86/insn-eval: Add insn_assign_reg() helper
Date: Thu,  4 Jun 2026 15:47:00 +0100
Message-ID: <daac026e677c10b68740b16ed8ad2556bd9583f8.1780584300.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780584300.git.kas@kernel.org>
References: <cover.1780584300.git.kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM's instruction emulator has a small helper, assign_register(), that
writes a value into a sub-register with x86 partial-register-write
semantics: 1- and 2-byte writes leave the upper bits of the destination
untouched, 4-byte writes zero-extend to 64 bits, 8-byte writes overwrite
the full register.

The TDX guest #VE handler needs the same logic for port I/O emulation
to get 32-bit zero-extension right. Rather than copy-pasting the helper,
lift it to <asm/insn-eval.h> as insn_assign_reg() so both can use it.

Rewrite the body using arithmetic instead of pointer punning so the
helper does not depend on -fno-strict-aliasing or little-endian byte
order, and add <asm/insn.h> to the header's includes so it builds
standalone in callers that have not pulled it in transitively.

No functional change.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 arch/x86/include/asm/insn-eval.h | 25 +++++++++++++++++++++++++
 arch/x86/kvm/emulate.c           | 26 ++++----------------------
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 4733e9064ee5..85251e718a77 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/bug.h>
 #include <linux/err.h>
+#include <asm/insn.h>
 #include <asm/ptrace.h>
 
 #define INSN_CODE_SEG_ADDR_SZ(params) ((params >> 4) & 0xf)
@@ -46,4 +47,28 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
 
 bool insn_is_nop(struct insn *insn);
 
+/*
+ * Write @val into *@reg with x86 partial-register-write semantics: a 1-
+ * or 2-byte write leaves the upper bits of the destination untouched; a
+ * 4-byte write zero-extends to 64 bits (matching IN[BWL], MOV[BWL]
+ * etc.); an 8-byte write overwrites the full register.
+ */
+static inline void insn_assign_reg(unsigned long *reg, u64 val, int bytes)
+{
+	switch (bytes) {
+	case 1:
+		*reg = (*reg & ~0xfful)   | (val & 0xff);
+		break;
+	case 2:
+		*reg = (*reg & ~0xfffful) | (val & 0xffff);
+		break;
+	case 4:
+		*reg = (u32)val;
+		break;
+	case 8:
+		*reg = val;
+		break;
+	}
+}
+
 #endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8013dccb3110..74972c17edb8 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -24,6 +24,7 @@
 #include "kvm_emulate.h"
 #include <linux/stringify.h>
 #include <asm/debugreg.h>
+#include <asm/insn-eval.h>
 #include <asm/nospec-branch.h>
 #include <asm/ibt.h>
 #include <asm/text-patching.h>
@@ -439,25 +440,6 @@ static void assign_masked(ulong *dest, ulong src, ulong mask)
 	*dest = (*dest & ~mask) | (src & mask);
 }
 
-static void assign_register(unsigned long *reg, u64 val, int bytes)
-{
-	/* The 4-byte case *is* correct: in 64-bit mode we zero-extend. */
-	switch (bytes) {
-	case 1:
-		*(u8 *)reg = (u8)val;
-		break;
-	case 2:
-		*(u16 *)reg = (u16)val;
-		break;
-	case 4:
-		*reg = (u32)val;
-		break;	/* 64b: zero-extend */
-	case 8:
-		*reg = val;
-		break;
-	}
-}
-
 static inline unsigned long ad_mask(struct x86_emulate_ctxt *ctxt)
 {
 	return (1UL << (ctxt->ad_bytes << 3)) - 1;
@@ -505,7 +487,7 @@ register_address_increment(struct x86_emulate_ctxt *ctxt, int reg, int inc)
 {
 	ulong *preg = reg_rmw(ctxt, reg);
 
-	assign_register(preg, *preg + inc, ctxt->ad_bytes);
+	insn_assign_reg(preg, *preg + inc, ctxt->ad_bytes);
 }
 
 static void rsp_increment(struct x86_emulate_ctxt *ctxt, int inc)
@@ -1766,7 +1748,7 @@ static int load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 
 static void write_register_operand(struct operand *op)
 {
-	return assign_register(op->addr.reg, op->val, op->bytes);
+	return insn_assign_reg(op->addr.reg, op->val, op->bytes);
 }
 
 static int writeback(struct x86_emulate_ctxt *ctxt, struct operand *op)
@@ -2007,7 +1989,7 @@ static int em_popa(struct x86_emulate_ctxt *ctxt)
 		rc = emulate_pop(ctxt, &val, ctxt->op_bytes);
 		if (rc != X86EMUL_CONTINUE)
 			break;
-		assign_register(reg_rmw(ctxt, reg), val, ctxt->op_bytes);
+		insn_assign_reg(reg_rmw(ctxt, reg), val, ctxt->op_bytes);
 		--reg;
 	}
 	return rc;
-- 
2.54.0

