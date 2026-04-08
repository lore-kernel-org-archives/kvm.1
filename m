Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC37F35C1A1;
	Wed,  8 Apr 2026 04:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623597; cv=none; b=CbxnMu2oi8i79q1aAke8uFDU7olU0i8XsRvGpIvIPKRgSSqwmyB68WTiQpaehVlXf4amZfKwRUXFxm9j0q9EZd/BsdmMl2h3ZiYZ5bQ3eFeLN0RclVpcJ0eKWEJYUGDgLi4kcyqEZvHUdslUIGOyAgE9qIDs/skbUY1CZdPVxgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623597; c=relaxed/simple;
	bh=aXtJER1i/jiZHz0CW84YvOWxpOmtfS3CoUtbXJp9/Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Puw9DMATN7wnPkROtpVNLMlc1jSQG/ap3VhzZWmpBx+4YizcO8bu9ea7wHPWX/bXVMkcka1a3nRous60SBeETvGuVsuvXdIuwm4k3BAb2MIaqUSV981E6KE2N8Uy5+fKWeuGteIngIcYbk5sMGtD1C4ulKDURFc+vT+dv53M8bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR9xTHeT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR9xTHeT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7A71C4AF0C;
	Wed,  8 Apr 2026 04:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775623597;
	bh=aXtJER1i/jiZHz0CW84YvOWxpOmtfS3CoUtbXJp9/Cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OR9xTHeT3MlNKwPS8U1Y1pb05eJyHV3/U3E4VrTKW3LVqZasKC1F57rCw90u+/O6k
	 dA+JeWIg0DvrTQ3fr5OhaTjUUjk0KG1o6jthz0EIfjUnDAP/NieCbW+wlcCS52bt/g
	 8NIzlSzq2bphL0e4UnQLAibzsHjSRUdPgCbURsmnDuoZl7HELkIa9qQSpGRPeZeXpf
	 viLjp/o6cCMRY1Bs638WUC+mqtUYoPSOJCZemP8twWojaEe6TH3567MLMGCZ1kJJaC
	 AzDN0rA0W32RlzaaMQZIUhVMkFgscUQlOAYE6u/af23Uh6RLJV6+CkZ+EV7alfwpsG
	 qpPFgLDVdz3yg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED8BFD5F61;
	Wed,  8 Apr 2026 04:46:37 +0000 (UTC)
From: Charlie Jenkins via B4 Relay <devnull+thecharlesjenkins.gmail.com@kernel.org>
Date: Tue, 07 Apr 2026 21:46:02 -0700
Subject: [PATCH 14/16] riscv: kvm: Use generated instruction headers for
 csr emulation
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-riscv_insn_table-v1-14-54b4736a1e77@gmail.com>
References: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
In-Reply-To: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Conor Dooley <conor@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775623594; l=5943;
 i=thecharlesjenkins@gmail.com; s=2026030; h=from:subject:message-id;
 bh=TwE25wT4s7hjayLJ5PBMi46uU0NYnVibnmjh3qrn1zU=;
 b=XfQ/Lc+Oog5aucttwcQK8XV7UR4f3VcYrjcyjIMQ8IPEQOeTwTcmtUzSR4T51lalVGpW9hPeG
 1FVo5tma6BeAhjyhR91dIJZI97CuktklLLZLLQQH5Zp/je9lrj4hcmc
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=vpF2USrG+aB6CTbSt34rzJKsAVe/l+GAXo1IomCMETk=
X-Endpoint-Received: by B4 Relay for thecharlesjenkins@gmail.com/2026030
 with auth_id=663
X-Original-From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Reply-To: thecharlesjenkins@gmail.com

From: Charlie Jenkins <thecharlesjenkins@gmail.com>

Migrate the csr emulation code to use the generated instruction headers
instead of the hand-written instruction composition functions.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

---
This can be tested with the introduced csr_test selftest.
---
 arch/riscv/include/asm/kvm_vcpu_insn.h |  3 +-
 arch/riscv/kvm/vcpu_insn.c             | 61 +++++++++++++++++-----------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_insn.h b/arch/riscv/include/asm/kvm_vcpu_insn.h
index 106fb4c45108..01efdaaede21 100644
--- a/arch/riscv/include/asm/kvm_vcpu_insn.h
+++ b/arch/riscv/include/asm/kvm_vcpu_insn.h
@@ -19,7 +19,8 @@ struct kvm_mmio_decode {
 };
 
 struct kvm_csr_decode {
-	unsigned long insn;
+	unsigned long rd;
+	unsigned long insn_len;
 	int return_handled;
 };
 
diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index c5a70de4a579..d666cd24f8c0 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -13,8 +13,7 @@
 #include <asm/kvm_vcpu_test_csr.h>
 
 struct insn_func {
-	unsigned long mask;
-	unsigned long match;
+	bool (*cmp)(u32 insn);
 	/*
 	 * Possible return values are as follows:
 	 * 1) Returns < 0 for error case
@@ -131,20 +130,17 @@ static const struct csr_func csr_funcs[] = {
  */
 int kvm_riscv_vcpu_csr_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	ulong insn;
-
 	if (vcpu->arch.csr_decode.return_handled)
 		return 0;
 	vcpu->arch.csr_decode.return_handled = 1;
 
 	/* Update destination register for CSR reads */
-	insn = vcpu->arch.csr_decode.insn;
-	if ((insn >> SH_RD) & MASK_RX)
-		SET_RD(insn, &vcpu->arch.guest_context,
-		       run->riscv_csr.ret_value);
+	if (vcpu->arch.csr_decode.rd)
+		*((ulong *)&vcpu->arch.guest_context +
+		  vcpu->arch.csr_decode.rd) = run->riscv_csr.ret_value;
 
 	/* Move to next instruction */
-	vcpu->arch.guest_context.sepc += INSN_LEN(insn);
+	vcpu->arch.guest_context.sepc += vcpu->arch.csr_decode.insn_len;
 
 	return 0;
 }
@@ -154,7 +150,7 @@ static int csr_insn(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong insn)
 	#define GET_REG(_rd) (*((unsigned long *)(&vcpu->arch.guest_context) + _rd))
 
 	int i, rc = KVM_INSN_ILLEGAL_TRAP;
-	unsigned int csr_num;
+	unsigned int csr_num, rd;
 	const struct csr_func *tcfn, *cfn = NULL;
 	ulong val = 0, wr_mask = 0, new_val = 0;
 
@@ -163,26 +159,32 @@ static int csr_insn(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong insn)
 		wr_mask = -1UL;
 		new_val = GET_REG(riscv_insn_csrrw_extract_xs1(insn));
 		csr_num = riscv_insn_csrrw_extract_csr(insn);
+		rd = riscv_insn_csrrw_extract_xd(insn);
 	} else if (riscv_insn_is_csrrs(insn)) {
 		wr_mask = GET_REG(riscv_insn_csrrs_extract_xs1(insn));
 		new_val = -1UL;
 		csr_num = riscv_insn_csrrs_extract_csr(insn);
+		rd = riscv_insn_csrrs_extract_xd(insn);
 	} else if (riscv_insn_is_csrrc(insn)) {
-		wr_mask = GET_REG(riscv_insn_csrrs_extract_xs1(insn));
+		wr_mask = GET_REG(riscv_insn_csrrc_extract_xs1(insn));
 		new_val = 0;
 		csr_num = riscv_insn_csrrc_extract_csr(insn);
+		rd = riscv_insn_csrrc_extract_xd(insn);
 	} else if (riscv_insn_is_csrrwi(insn)) {
 		wr_mask = -1UL;
 		new_val = riscv_insn_csrrwi_extract_imm(insn);
 		csr_num = riscv_insn_csrrwi_extract_csr(insn);
+		rd = riscv_insn_csrrwi_extract_xd(insn);
 	} else if (riscv_insn_is_csrrsi(insn)) {
 		wr_mask = riscv_insn_csrrwi_extract_imm(insn);
 		new_val = -1UL;
 		csr_num = riscv_insn_csrrsi_extract_csr(insn);
+		rd = riscv_insn_csrrsi_extract_xd(insn);
 	} else if (riscv_insn_is_csrrci(insn)) {
-		wr_mask = GET_REG(riscv_insn_csrrwi_extract_imm(insn));
+		wr_mask = riscv_insn_csrrci_extract_imm(insn);
 		new_val = 0;
-		csr_num = riscv_insn_csrrwi_extract_csr(insn);
+		csr_num = riscv_insn_csrrci_extract_csr(insn);
+		rd = riscv_insn_csrrci_extract_xd(insn);
 	} else {
 		return rc;
 	}
@@ -190,7 +192,8 @@ static int csr_insn(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong insn)
 	#undef GET_REG
 
 	/* Save instruction decode info */
-	vcpu->arch.csr_decode.insn = insn;
+	vcpu->arch.csr_decode.rd = rd;
+	vcpu->arch.csr_decode.insn_len = INSN_LEN(insn);
 	vcpu->arch.csr_decode.return_handled = 0;
 
 	/* Update CSR details in kvm_run struct */
@@ -234,43 +237,39 @@ static int csr_insn(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong insn)
 
 static const struct insn_func system_opcode_funcs[] = {
 	{
-		.mask  = INSN_MASK_CSRRW,
-		.match = INSN_MATCH_CSRRW,
+		.cmp  = riscv_insn_is_csrrw,
 		.func  = csr_insn,
 	},
 	{
-		.mask  = INSN_MASK_CSRRS,
-		.match = INSN_MATCH_CSRRS,
+		.cmp  = riscv_insn_is_csrrs,
 		.func  = csr_insn,
 	},
 	{
-		.mask  = INSN_MASK_CSRRC,
-		.match = INSN_MATCH_CSRRC,
+		.cmp  = riscv_insn_is_csrrc,
 		.func  = csr_insn,
 	},
 	{
-		.mask  = INSN_MASK_CSRRWI,
-		.match = INSN_MATCH_CSRRWI,
+		.cmp  = riscv_insn_is_csrrwi,
 		.func  = csr_insn,
 	},
 	{
-		.mask  = INSN_MASK_CSRRSI,
-		.match = INSN_MATCH_CSRRSI,
+		.cmp  = riscv_insn_is_csrrsi,
 		.func  = csr_insn,
 	},
 	{
-		.mask  = INSN_MASK_CSRRCI,
-		.match = INSN_MATCH_CSRRCI,
+		.cmp  = riscv_insn_is_csrrci,
 		.func  = csr_insn,
 	},
 	{
-		.mask  = INSN_MASK_WFI,
-		.match = INSN_MATCH_WFI,
+		.cmp  = riscv_insn_is_wfi,
 		.func  = wfi_insn,
 	},
 	{
-		.mask  = INSN_MASK_WRS,
-		.match = INSN_MATCH_WRS,
+		.cmp  = riscv_insn_is_wrs_nto,
+		.func  = wrs_insn,
+	},
+	{
+		.cmp  = riscv_insn_is_wrs_sto,
 		.func  = wrs_insn,
 	},
 };
@@ -283,7 +282,7 @@ static int system_opcode_insn(struct kvm_vcpu *vcpu, struct kvm_run *run,
 
 	for (i = 0; i < ARRAY_SIZE(system_opcode_funcs); i++) {
 		ifn = &system_opcode_funcs[i];
-		if ((insn & ifn->mask) == ifn->match) {
+		if (ifn->cmp(insn)) {
 			rc = ifn->func(vcpu, run, insn);
 			break;
 		}

-- 
2.52.0


