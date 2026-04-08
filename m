Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A323537D3;
	Wed,  8 Apr 2026 04:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623596; cv=none; b=VLZQB6hThiqg/FMJ/tZup3zZbcMVqyufmG61IEt6fHrxUrCoOIeanIuYv4xuJiDPoHpge0QWEVs1DpVlgrHV47yLpo/SAGg+ultqh6sLI0+tIwsuaPvDlcoRUYaSmz5Y8GekC3JznLCiET1wdJudbCWLaU3T1yiHnt7KF0NDmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623596; c=relaxed/simple;
	bh=rfGvxD69sz/bbw6KZgMDLQDC3fwl09ALozELDizQCRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISMiakih97ex58qZFTujLc4I/yIOnpyfkGX52OxYurUivsABoSgF01qHuIF7gsbbYh9havJtaLLZpy+KGnyXmlNwl8kXcgc4WAbPjqFnjWN1Vf37NJ9GNurhYUhrHnaTe0lqqKFxkrmt6sbxMM89sTYvdctpfmdp07n/PlNyoPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbICRBt6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbICRBt6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0399C2BCB2;
	Wed,  8 Apr 2026 04:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775623596;
	bh=rfGvxD69sz/bbw6KZgMDLQDC3fwl09ALozELDizQCRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tbICRBt6Lv3a9R8V0R4DS+Lf8wmB5u5QWxJs2vWUOkmkB6IYvkPQX2KsECxbvOQYv
	 LfIny+7BR7e8P6c/H8xh1l1r0InD+58CfAMCJ9c3FsQp2NhPHKIS342dq1z+V0uYIf
	 NAdZ/ZMguLiP5/DVi3AyDb2hXDYUq/zCRbDeQrs0RxzNEjECedCd82h3Zzt1hNeKbH
	 1RKlOdf7IiT5yfsqKTQX0C642j0WzwG3D9ySGBC9+5NTd9vRwNtvBvrFrnWxk/uo3P
	 Ii+tTHAXuCeq+9Avrg7zM6d1UbIfL9OGkQmdf56Hvu7mVJlDoFrsh8N/SyQYJHKEQh
	 o7Xf11d6EywKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85B6FD5F75;
	Wed,  8 Apr 2026 04:46:36 +0000 (UTC)
From: Charlie Jenkins via B4 Relay <devnull+thecharlesjenkins.gmail.com@kernel.org>
Date: Tue, 07 Apr 2026 21:45:53 -0700
Subject: [PATCH 05/16] riscv: cfi: Use generated instruction headers
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-riscv_insn_table-v1-5-54b4736a1e77@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775623594; l=1198;
 i=thecharlesjenkins@gmail.com; s=2026030; h=from:subject:message-id;
 bh=7VtWsi3USdmOKI/2dEDNXqFzi/ps3TMNRy1rcPp7qHk=;
 b=JkxmJoFaOoNr0y+eRwrfHP/YVmhcaiaertrKCpDjsoy0DwxP6yT3ArS34g7gxriu71lUt6wJu
 sXZ75QzbZgxBRrvJ4GepZR6ZFBcdh4hHjhKCA2FKx39bKP08q1sye4y
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=vpF2USrG+aB6CTbSt34rzJKsAVe/l+GAXo1IomCMETk=
X-Endpoint-Received: by B4 Relay for thecharlesjenkins@gmail.com/2026030
 with auth_id=663
X-Original-From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Reply-To: thecharlesjenkins@gmail.com

From: Charlie Jenkins <thecharlesjenkins@gmail.com>

Migrate the code that is decoding cfi instructions to use the generated
instruction headers.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

---

This function generates the same assembly as before.
---
 arch/riscv/kernel/cfi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cfi.c b/arch/riscv/kernel/cfi.c
index 6ec9dbd7292e..e38d5f863747 100644
--- a/arch/riscv/kernel/cfi.c
+++ b/arch/riscv/kernel/cfi.c
@@ -40,16 +40,16 @@ static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
 	if (!riscv_insn_is_beq(insn))
 		return false;
 
-	*type = (u32)regs_ptr[RV_EXTRACT_RS1_REG(insn)];
+	*type = (u32)regs_ptr[riscv_insn_beq_extract_xs1(insn)];
 
 	if (get_kernel_nofault(insn, (void *)regs->epc) ||
 	    get_kernel_nofault(insn, (void *)regs->epc + GET_INSN_LENGTH(insn)))
 		return false;
 
 	if (riscv_insn_is_jalr(insn))
-		rs1_num = RV_EXTRACT_RS1_REG(insn);
+		rs1_num = riscv_insn_jalr_extract_xs1(insn);
 	else if (riscv_insn_is_c_jalr(insn))
-		rs1_num = RVC_EXTRACT_C2_RS1_REG(insn);
+		rs1_num = riscv_insn_c_jalr_extract_xs1(insn);
 	else
 		return false;
 

-- 
2.52.0


