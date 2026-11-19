Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058967;
	b=OjdnSHB6LKx7WWv1LRHPi0xLj7A+8jEjAojtWzGbbXizcrQmzlXsEzqjaUgX+HtxoebL
	 xZUQzuabnPDDOTlkblUz0SzaTkLfvzxkcw8SuvEsyze8F5uCuO30DQeLQn0WkrfNA0QYZ
	 L+fYZCrDR0RThcfVqgaCX4JFDKO9rY562I2x6zr2a7pHr/61ytUI/sli/yfsPaRXD9Hhx
	 Y6K9a6xRsIkctrETPeaNkYLn0hD/nVmx2BIjeIiRfvsJdb9JdsOnWU20mha4Z8l9rChn6
	 dIyxvC71JPMzwknLgs+eg4bnIVNGsMQOuMM0h+wYXT/RYQO17QCDEDjz/nPKI3V4H9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058967;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WXSeNbBJ4Yx2OV+gndxR3I61LCvTD/mi7uyMO9rDvG8=;
	b=DcUZM1/1q+SQYp5PBTvz0F4J8HKck+gp72KsXqLJUPpJ8aGbutl5kIZJkPgCim4hWuEA
	 iY90ckMyQpxyARmFxTk2x22mgBaVZXbZYw3kHBgIf2BEd+AYRZnObSfqOqBMm3z/BPExH
	 Ub1azkv4ZHEBslkxistghCMndbnwXsHNWN8b/49MZOgLqAQE3MCS5mGCxmxsnel4PTndk
	 nhDQm2ECgxiXCzIAwv9W7WV3u88eiwmusZtzca9QMcafzni7cSaFvwzXtmyTcz/jyvMsN
	 gz9Y05MQE6Yat1+33gS6yU0DCZ5PqdJcROz1UE4RK6CO5LNPAogHC+5FqhSUAJlw/MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=saGpptTE;
	arc=none smtp.remote-ip=115.124.30.97
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6748606A326;
	Thu, 19 Nov 2026 03:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6748606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=saGpptTE
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795058962; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WXSeNbBJ4Yx2OV+gndxR3I61LCvTD/mi7uyMO9rDvG8=;
	b=saGpptTE8EfdlgVlEMLZc4BwSda00gmUXRi0f4DwsEWLnpltcqbv2vfjuqhLfjsd/LNrzIYcg35aOF5YeEG2PuBjhweQM9ZotLzo0AUZ47kiAboFS2e2ABOQeT9bNWUoEobO9LRKkT4GR3W6HIg6Jw7yWihxNlg29S69CzTnFx0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=weichen.chen@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XF2Ah7y_1795058954;
Received: from localhost.localdomain(mailfrom:weichen.chen@linux.alibaba.com fp:SMTPD_---0XF2Ah7y_1795058954 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 11:29:21 +0800
From: weichenchen <weichen.chen@linux.alibaba.com>
To: kvm@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	gleb@redhat.com,
	srutherford@google.com,
	avi@redhat.com,
	weichenchen <weichen.chen@linux.alibaba.com>
Subject: [PATCH] KVM: x86: Fix stalled descriptor table accesses to MMIO
Date: Thu, 19 Nov 2026 11:29:12 +0800
Message-ID: <20261119032912.94364-1-weichen.chen@linux.alibaba.com>
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

Check the segment bounds of both fields before reading the limit or
base.  If the operand crosses a page boundary, pass the whole operand
to the emulated read so a fault on the second page is reported before
an MMIO exit to userspace.  Keep the separate limit and base reads on
a single page.  Use the emulator's read cache to resume after MMIO and
set NoAccess to skip the redundant generic source read.

Use the destination operand for common writeback of SGDT and SIDT.  This
keeps the entire descriptor available until userspace completes a
ten-byte MMIO write.

Fixes: c3cd7ffaf57a ("KVM: x86 emulator: x86_emulate_insn() return -1 only in case of emulation failure")
Fixes: 129a72a0d3c8 ("KVM: x86: Introduce segmented_write_std")
Signed-off-by: weichenchen <weichen.chen@linux.alibaba.com>
---
On Intel VMX/EPT, LIDT and SIDT both reached the following HLT with the
expected IDTR data for RAM and MMIO operands. LIDT completed a 2-byte
and an 8-byte MMIO read. SIDT completed an 8-byte and a 2-byte write.

With only the limit field in range in 32-bit compatibility mode, LIDT
delivered #GP(0) at the expected RIP before any userspace MMIO exit.
The same selftest passed with forced emulation. A local extension to
set_memory_region_test also covered all four descriptor-table
instructions and a split RAM/MMIO LIDT.

A standalone test of the emulator and its MMIO fragment handling used
mock page translation to check a userspace MMIO page followed by a
non-present page. All 36 cross-page load cases returned a page fault
without preparing a userspace MMIO exit or updating GDTR or IDTR.

Six KVM selftests passed. Eight kvm-unit-tests suites at a2891d9528ef
reported 445 passes, five skips and no failures. Both vendor modules
built with KVM_WERROR. Runtime testing used Intel.

Codex assisted with the emulator changes and regression testing.

 arch/x86/kvm/emulate.c | 57 ++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c1b2128218..3bd720d983 100644
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
@@ -3465,14 +3447,35 @@ static int em_sidt(struct x86_emulate_ctxt *ctxt)
 
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
+	/* Defer userspace MMIO until both pages have been translated. */
+	if (offset_in_page(limit_addr) + desc_bytes > PAGE_SIZE) {
+		rc = read_emulated(ctxt, limit_addr, &desc_ptr, desc_bytes);
+	} else {
+		rc = read_emulated(ctxt, limit_addr, &desc_ptr.size, sizeof(desc_ptr.size));
+		if (rc != X86EMUL_CONTINUE)
+			return rc;
+		rc = read_emulated(ctxt, base_addr, &desc_ptr.address, base_bytes);
+	}
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 	if (ctxt->mode == X86EMUL_MODE_PROT64 &&
@@ -4074,8 +4077,8 @@ static const struct opcode group6[] = {
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

