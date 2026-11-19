Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067916;
	b=QLmvOkMQjlPjUMzRzONi5PTXUCYxlLZraN20BfcHoNR1vDwIcGwTS65SRrMhic/y3oYs
	 VvnF8VQAxqJUl2asNPsyYzwR2ooo3pBue/gDW0peJhgJX8U9cJG8o1nuJH6gUNUBNxMyb
	 XtwgHcGkWBvxZ50xTjRvGZ+eDoR4UNUdHc1a9gTTD+5JQ/E5emd8+1ndnV4BK36OZ0lI0
	 dGCXwyaXJon+eHMf1/5fWCsHpD6kjqhxHvzVjV3ssijDbtsW5esvOM0NuWHs19PTaX527
	 sW9F7buw3jfCZ9pYcS3NDI97zZJmv4+HZF696I0jk1tYnhyo1mG3lq03iB+oSsUjyFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067916;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ay0rjNoHaCokGoQ+9Ck2XUH99fyrIscozeZHiL83Aoc=;
	b=s7vvIyyqUCzEN8Ifg51QuK+WPXoHkNZLjNnl3KfZehVl7XxROvQgdRhagpUnKO083H8W
	 Va3BkxhQWgUqeFikV82yFA1waAhVTlJwyjQK9kDUBD6rY2NlFMSswdtB6uJd7mG+hEevE
	 secTj1XJvQGyiNORDzTP9RUrkfHJo67ZdbY8dM/UguiO9MXQbShxqz04fV74yzCD9xcWA
	 Qr2/dL4sUlwhbQTL8feeo5nn8KlLc4x4VBLslSWMWlzfVztDG4y1dn2cP4b4RBrsNYk7M
	 kuY2DJGDD7+KaizKByiCVglDWWYCCGhpJTzTpAPJcop7U07q+hDRTTLWEJ0o2exWb9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HzpXI6Z0;
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14062606A320;
	Thu, 19 Nov 2026 05:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14062606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HzpXI6Z0
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795067906; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ay0rjNoHaCokGoQ+9Ck2XUH99fyrIscozeZHiL83Aoc=;
	b=HzpXI6Z0SASTI7u51CN2DyUqOZED/MDxFUT7fq8azrs00OQmgITmvxETfOy0QKp4cbfnD1EtwM1WHgRQeewaKEEdnE79mYRMc5R9Q6VN8nVbnZwcILVTahsgPxhtBeRSBDnTMskX2SX5MI2OyrSkW08NN85M1D/l2TjVpm1dUOA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=weichen.chen@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XF2Vf1m_1795067904;
Received: from localhost.localdomain(mailfrom:weichen.chen@linux.alibaba.com fp:SMTPD_---0XF2Vf1m_1795067904 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 13:58:25 +0800
From: weichenchen <weichen.chen@linux.alibaba.com>
To: kvm@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: weichenchen <weichen.chen@linux.alibaba.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	gleb@redhat.com,
	srutherford@google.com,
	avi@redhat.com
Subject: [PATCH v2] KVM: x86: Fix stalled descriptor table accesses to MMIO
Date: Thu, 19 Nov 2026 13:57:36 +0800
Message-ID: <20261119055747.23819-1-weichen.chen@linux.alibaba.com>
X-Mailer: git-send-email 2.55.0
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

Use the emulated memory accessors for the explicit operands of LGDT,
LIDT, SGDT and SIDT.  When the operand has no backing memslot, the
standard accessors return X86EMUL_IO_NEEDED without queuing an MMIO
fragment.  LIDT can repeat the generic operand read at the same RIP,
and SIDT can re-enter emulation without sending a write to userspace.

Check the segment bounds of both fields, then read the whole descriptor
in one emulated access.  On a single page, this lets KVM use the
faulting GPA for both fields without translating the base field after
userspace has handled part of the read.  For a split operand, translate
both pages before exiting to userspace.  Use the emulator's read cache
to resume after MMIO and skip the redundant generic source read.

Use the destination operand for common writeback of SGDT and SIDT.  This
keeps the entire descriptor available until userspace completes a
ten-byte MMIO write.

Fixes: c3cd7ffaf57a ("KVM: x86 emulator: x86_emulate_insn() return -1 only in case of emulation failure")
Fixes: 129a72a0d3c8 ("KVM: x86: Introduce segmented_write_std")
Signed-off-by: weichenchen <weichen.chen@linux.alibaba.com>
---
Changes in v2:
- Read the whole LGDT/LIDT operand in one read_emulated() call after
  validating both fields. This avoids a second GVA translation after
  userspace has handled the first part of a same-page read, as pointed
  out by Sashiko.
- v1: https://lore.kernel.org/kvm/20261119032912.94364-1-weichen.chen@linux.alibaba.com/

On Intel VMX/EPT, the 64-bit LIDT and SIDT probes reached the following
HLT with the expected data for RAM and MMIO operands. For same-page
MMIO, both transferred eight bytes followed by two. A TDP-style mock
with a saved GPA counted one GPA lookup and zero software translations
through completion for both loads at all three operand sizes.

Six KVM selftests passed, including a split RAM/MMIO LIDT and a segment
limit fault before any userspace MMIO exit. Eight kvm-unit-tests suites
at a2891d9528ef reported 445 passes, five skips and no failures. Both
vendor modules built with KVM_WERROR. Runtime testing used Intel.

Codex assisted with the emulator changes and regression testing.

 arch/x86/kvm/emulate.c | 49 +++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c1b2128218..3a9a67f4b0 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -918,23 +918,6 @@ static void *decode_register(struct x86_emulate_ctxt *ctxt, u8 modrm_reg,
 	return p;
 }
 
-static int read_descriptor(struct x86_emulate_ctxt *ctxt,
-			   struct segmented_address addr,
-			   u16 *size, unsigned long *address, int op_bytes)
-{
-	int rc;
-
-	if (op_bytes == 2)
-		op_bytes = 3;
-	*address = 0;
-	rc = segmented_read_std(ctxt, addr, size, 2);
-	if (rc != X86EMUL_CONTINUE)
-		return rc;
-	addr.ea += 2;
-	rc = segmented_read_std(ctxt, addr, address, op_bytes);
-	return rc;
-}
-
 EM_ASM_2(add);
 EM_ASM_2(or);
 EM_ASM_2(adc);
@@ -3447,10 +3430,9 @@ static int emulate_store_desc_ptr(struct x86_emulate_ctxt *ctxt,
 		ctxt->op_bytes = 4;
 		desc_ptr.address &= 0x00ffffff;
 	}
-	/* Disable writeback. */
-	ctxt->dst.type = OP_NONE;
-	return segmented_write_std(ctxt, ctxt->dst.addr.mem,
-				   &desc_ptr, 2 + ctxt->op_bytes);
+	ctxt->dst.bytes = 2 + ctxt->op_bytes;
+	memcpy(ctxt->dst.valptr, &desc_ptr, ctxt->dst.bytes);
+	return X86EMUL_CONTINUE;
 }
 
 static int em_sgdt(struct x86_emulate_ctxt *ctxt)
@@ -3465,14 +3447,27 @@ static int em_sidt(struct x86_emulate_ctxt *ctxt)
 
 static int em_lgdt_lidt(struct x86_emulate_ctxt *ctxt, bool lgdt)
 {
-	struct desc_ptr desc_ptr;
+	struct segmented_address addr = ctxt->src.addr.mem;
+	struct desc_ptr desc_ptr = {};
+	unsigned long limit_addr, base_addr;
+	unsigned int base_bytes, desc_bytes;
 	int rc;
 
 	if (ctxt->mode == X86EMUL_MODE_PROT64)
 		ctxt->op_bytes = 8;
-	rc = read_descriptor(ctxt, ctxt->src.addr.mem,
-			     &desc_ptr.size, &desc_ptr.address,
-			     ctxt->op_bytes);
+	base_bytes = ctxt->op_bytes == 2 ? 3 : ctxt->op_bytes;
+	desc_bytes = sizeof(desc_ptr.size) + base_bytes;
+
+	/* Check both fields before an MMIO read can have side effects. */
+	rc = linearize(ctxt, addr, sizeof(desc_ptr.size), false, &limit_addr);
+	if (rc != X86EMUL_CONTINUE)
+		return rc;
+	addr.ea += sizeof(desc_ptr.size);
+	rc = linearize(ctxt, addr, base_bytes, false, &base_addr);
+	if (rc != X86EMUL_CONTINUE)
+		return rc;
+
+	rc = read_emulated(ctxt, limit_addr, &desc_ptr, desc_bytes);
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 	if (ctxt->mode == X86EMUL_MODE_PROT64 &&
@@ -4074,8 +4069,8 @@ static const struct opcode group6[] = {
 static const struct group_dual group7 = { {
 	II(Mov | DstMem,			em_sgdt, sgdt),
 	II(Mov | DstMem,			em_sidt, sidt),
-	II(SrcMem | Priv,			em_lgdt, lgdt),
-	II(SrcMem | Priv,			em_lidt, lidt),
+	II(SrcMem | Priv | NoAccess,		em_lgdt, lgdt),
+	II(SrcMem | Priv | NoAccess,		em_lidt, lidt),
 	II(SrcNone | DstMem | Mov,		em_smsw, smsw), N,
 	II(SrcMem16 | Mov | Priv,		em_lmsw, lmsw),
 	II(SrcMem | ByteOp | Priv | NoAccess,	em_invlpg, invlpg),

base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
-- 
2.53.0

