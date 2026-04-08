Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5535CB6F;
	Wed,  8 Apr 2026 04:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623598; cv=none; b=JfO6Mu1Asj56dM46444YTjLkQeRqKbskJtuDSpb/3/2wEPj2o6zkM2JWPjhSerXK5Cke+wzuLPw8ZonuUNenUojnXFbE9U4tYhCtA1pVgnG3ouUwZQe7GOql444tjqQhAbBq5uZuWqcez8GduXaUZHAFf1kCvu/oD96/1V+jMOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623598; c=relaxed/simple;
	bh=yXr1OY92hmXeh6OBXzipzOIC3tW8ebE9lewtd1G8Asg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Il7h4SUkj2t5f5hKnRRnQ9KTQe0HzSBtg5WZjL1JqtpXgFcZ4IcBxYlbNYl7cAe6Y4NM0XvnSRB0a3VouI6P7zBfJZJFrUwiNXUN28gVrPPLlCEkx6NrqelTb4MBsvDnTm+Iyyr82wNqxO3Vpr32H5lE1bbOQfx5gFS1XukrC1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEe3IZuc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEe3IZuc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA4D7C19425;
	Wed,  8 Apr 2026 04:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775623597;
	bh=yXr1OY92hmXeh6OBXzipzOIC3tW8ebE9lewtd1G8Asg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IEe3IZucW+mH7x+/+qXU5BOd4Xtt0LjVls4UbN1L+MNxGxkLWtP0ZAI10B6tR1bxx
	 X5vhBbzP0iyoC+HWbP3ODtFU5sDJ6FsLK1lCZnrZbAj9JtvqcweiCOaTacJ9Xb39K7
	 D+qOgWfpD8PQZslSTUth0kSZKvKwbrHLxLk0FRY61RT8Fyf3n3pyDiFAUTYZjcsxiO
	 pmbaaUSdIReEr9sWs0gJNyuX52zSBFzHUm3wbe2qmdvDnyinve/7CPushabq8zpN0K
	 q1nZ91+zcT4LJh+XTKW7Yi+2Ysm0w/vL4fedVSPq+tI2FAyAS0rfa7sPAcvl+NaV/p
	 24vrK9P6yzHTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D221BFD5F70;
	Wed,  8 Apr 2026 04:46:37 +0000 (UTC)
From: Charlie Jenkins via B4 Relay <devnull+thecharlesjenkins.gmail.com@kernel.org>
Date: Tue, 07 Apr 2026 21:46:03 -0700
Subject: [PATCH 15/16] riscv: kexec: Use generated instruction headers for
 kexec relocations
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-riscv_insn_table-v1-15-54b4736a1e77@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775623594; l=3956;
 i=thecharlesjenkins@gmail.com; s=2026030; h=from:subject:message-id;
 bh=xqRUM2JXf85Zh+yqhrsAE1KnYguobicrPYwOKvSMf/k=;
 b=Ef2tD17dwpijvmUL+uh6TImx+ecanapQBRBXbjhUAKTd2GhdfKsfY8jVUeaMjLf3X/3erSF2N
 bU8wdXu4+FNBrd+qiU4tZikYJWOGjQV5cCiWonrBy+azbODZa+V23Ag
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=vpF2USrG+aB6CTbSt34rzJKsAVe/l+GAXo1IomCMETk=
X-Endpoint-Received: by B4 Relay for thecharlesjenkins@gmail.com/2026030
 with auth_id=663
X-Original-From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Reply-To: thecharlesjenkins@gmail.com

From: Charlie Jenkins <thecharlesjenkins@gmail.com>

Migrate the kexec relocation code to use the generated instruction
headers instead of the hand-written instruction composition functions.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

---

This was again tested by brute forcing all possible inputs to the value
fed into the immediates.
---
 arch/riscv/kernel/machine_kexec_file.c | 55 ++++++++++++----------------------
 1 file changed, 19 insertions(+), 36 deletions(-)

diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index dd9d92a96517..1d58aafea232 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -116,32 +116,6 @@ static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
 	(((x) + (RISCV_IMM_REACH >> 1)) & ~(RISCV_IMM_REACH - 1))
 #define RISCV_CONST_LOW_PART(x) ((x) - RISCV_CONST_HIGH_PART(x))
 
-#define ENCODE_ITYPE_IMM(x) \
-	(RV_X(x, 0, 12) << 20)
-#define ENCODE_BTYPE_IMM(x) \
-	((RV_X(x, 1, 4) << 8) | (RV_X(x, 5, 6) << 25) | \
-	(RV_X(x, 11, 1) << 7) | (RV_X(x, 12, 1) << 31))
-#define ENCODE_UTYPE_IMM(x) \
-	(RV_X(x, 12, 20) << 12)
-#define ENCODE_JTYPE_IMM(x) \
-	((RV_X(x, 1, 10) << 21) | (RV_X(x, 11, 1) << 20) | \
-	(RV_X(x, 12, 8) << 12) | (RV_X(x, 20, 1) << 31))
-#define ENCODE_CBTYPE_IMM(x) \
-	((RV_X(x, 1, 2) << 3) | (RV_X(x, 3, 2) << 10) | (RV_X(x, 5, 1) << 2) | \
-	(RV_X(x, 6, 2) << 5) | (RV_X(x, 8, 1) << 12))
-#define ENCODE_CJTYPE_IMM(x) \
-	((RV_X(x, 1, 3) << 3) | (RV_X(x, 4, 1) << 11) | (RV_X(x, 5, 1) << 2) | \
-	(RV_X(x, 6, 1) << 7) | (RV_X(x, 7, 1) << 6) | (RV_X(x, 8, 2) << 9) | \
-	(RV_X(x, 10, 1) << 8) | (RV_X(x, 11, 1) << 12))
-#define ENCODE_UJTYPE_IMM(x) \
-	(ENCODE_UTYPE_IMM(RISCV_CONST_HIGH_PART(x)) | \
-	(ENCODE_ITYPE_IMM(RISCV_CONST_LOW_PART(x)) << 32))
-#define ENCODE_UITYPE_IMM(x) \
-	(ENCODE_UTYPE_IMM(x) | (ENCODE_ITYPE_IMM(x) << 32))
-
-#define CLEAN_IMM(type, x) \
-	((~ENCODE_##type##_IMM((uint64_t)(-1))) & (x))
-
 int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     Elf_Shdr *section,
 				     const Elf_Shdr *relsec,
@@ -197,12 +171,14 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 
 		switch (r_type) {
 		case R_RISCV_BRANCH:
-			*(u32 *)loc = CLEAN_IMM(BTYPE, *(u32 *)loc) |
-				 ENCODE_BTYPE_IMM(val - addr);
+			/*
+			 * For simplicity, use beq as represenative of all
+			 * branches (they all have the same imm encoding)
+			 */
+			riscv_insn_beq_insert_imm((u32 *)loc, val - addr);
 			break;
 		case R_RISCV_JAL:
-			*(u32 *)loc = CLEAN_IMM(JTYPE, *(u32 *)loc) |
-				 ENCODE_JTYPE_IMM(val - addr);
+			riscv_insn_jal_insert_imm((u32 *)loc, val  - addr);
 			break;
 		/*
 		 * With no R_RISCV_PCREL_LO12_S, R_RISCV_PCREL_LO12_I
@@ -213,16 +189,23 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		case R_RISCV_PCREL_HI20:
 		case R_RISCV_CALL_PLT:
 		case R_RISCV_CALL:
-			*(u64 *)loc = CLEAN_IMM(UITYPE, *(u64 *)loc) |
-				 ENCODE_UJTYPE_IMM(val - addr);
+			riscv_insn_auipc_insert_imm((u32 *)loc, RISCV_CONST_HIGH_PART(val - addr));
+			riscv_insn_jalr_insert_imm((u32 *)loc + 1,
+						   RISCV_CONST_LOW_PART(val - addr));
 			break;
 		case R_RISCV_RVC_BRANCH:
-			*(u32 *)loc = CLEAN_IMM(CBTYPE, *(u32 *)loc) |
-				 ENCODE_CBTYPE_IMM(val - addr);
+			/*
+			 * For simplicity, use c.beqz as represenative of all
+			 * compressed branches (they all have the same imm encoding)
+			 */
+			riscv_insn_c_beqz_insert_imm((u16 *)loc, val - addr);
 			break;
 		case R_RISCV_RVC_JUMP:
-			*(u32 *)loc = CLEAN_IMM(CJTYPE, *(u32 *)loc) |
-				 ENCODE_CJTYPE_IMM(val - addr);
+			/*
+			 * For simplicity, use c.j as represenative of all
+			 * compressed jumps (they all have the same imm encoding)
+			 */
+			riscv_insn_c_j_insert_imm((u16 *)loc, val - addr);
 			break;
 		case R_RISCV_ADD16:
 			*(u16 *)loc += val;

-- 
2.52.0


