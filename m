Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9713A39A04F;
	Mon, 29 Jun 2026 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758281; cv=none; b=mqfvHenjpo3nycO4mrs+OmkQcuRBUdwCrEtf5a2lyhJOPCPpmQczNU6U7DeJdCpbgfifl66dLAwJ2cMD/owQr0nNc7rivMncaJH5B/d73Go7fV5Cul5bdDe+lKBrjpNrorhf4PIkQTXCqSn90bbADYDhvStL9ZSY2j4c6YZRtQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758281; c=relaxed/simple;
	bh=ydOjPPV1iw7uUEQiXArLViOG3nelMgBhyqd/LrL8CbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Km1bEXT97eTV9Okyav3dIeVE8DHQ73yLnXxbGwIqJEBs5XjqeH+i7jYpmPGQtp/5No3eeoDurGgGfHBiBAQ+ZT7Xp3NkmhdR/ZDQ5Rkj8/sdolTLeFZhnatC0objzae+HoS5sYio2ePItfAXZ4wccS58Ntb9LBrCgN3RU4h4A4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0lEQmAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0lEQmAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74E21F00A3A;
	Mon, 29 Jun 2026 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782758280;
	bh=rZJKOJ5v0nrbdTTjOW2joD/BNT6VdeO+4tzc2xmuxgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i0lEQmAPCrD4WaMUanWqpXFXlybctdvDeelJfZoJmycP96t5AK78elsNpOkcM6Xvi
	 uyRaZFn78lJvyxRj6X/BBzeP0FVF8gCBP/j9JTyWIbTr+Dx1Roj5hFp/hgxiLghZ9p
	 5UCKxQtI4vpdh9oST5mrd1QBuJ6jrOEktxC12XYctUJHVezxJ8/Ow2N5zoCtjOCmrj
	 6Cyss67NlByOVgoAPP0O3RS5SxlFf02LyruhjEEWjQOyD1moWT0OXvENNoNnAfOs3G
	 E6vbBZvGNXAsxLX79X3L65K9WaZ4k2bqVthUCOe6g7xvtLT+5jdXvv46EaiRXt4OEs
	 qgMaRUL6SkL4Q==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 02/10] KVM: selftests: Fix RAX and RFLAGS VMCB offsets when running L2
Date: Mon, 29 Jun 2026 18:37:37 +0000
Message-ID: <20260629183746.699840-3-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260629183746.699840-1-yosry@kernel.org>
References: <20260629183746.699840-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The offsets used (0x170 and 0x1f8) are offsets within vmcb_save_area,
not vmcb. The correct offsets should include the base of vmcb_save_area
within vmcb (which is 0x400 -- so 0x570 and 0x5f8).

Instead of just correcting the offsets, use vmcb->save.rax and
vmcb->save.rflags as parameters to the asm block and avoid hardcoding
offsets completely. While at it, also use guest_regs.rax directly
instead of assuming it's at offset 0 of guest_regs.

Note: "+m" must be used for vmcb_rax and vmcb_rflags, as caching those
fields in registers would be wrong as the underlying KVM will update
them in memory.

The same problem was recently fixed (differently) for kvm-unit-tests
[1].

[1]https://lore.kernel.org/all/20260521092311.86030-1-pbonzini@redhat.com/

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260518202514.2037078-1-yosry%40kernel.org?part=1
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/lib/x86/svm.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/selftests/kvm/lib/x86/svm.c
index 1445b890986fd..766d15f1d534a 100644
--- a/tools/testing/selftests/kvm/lib/x86/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86/svm.c
@@ -164,19 +164,22 @@ void run_guest(struct vmcb *vmcb, u64 vmcb_gpa)
 {
 	asm volatile (
 		"vmload %[vmcb_gpa]\n\t"
-		"mov rflags, %%r15\n\t"	// rflags
-		"mov %%r15, 0x170(%[vmcb])\n\t"
-		"mov guest_regs, %%r15\n\t"	// rax
-		"mov %%r15, 0x1f8(%[vmcb])\n\t"
+		"mov rflags, %%r15\n\t"
+		"mov %%r15, %[vmcb_rflags]\n\t"
+		"mov %[guest_regs_rax], %%r15\n\t"
+		"mov %%r15, %[vmcb_rax]\n\t"
 		LOAD_GPR_C
 		"vmrun %[vmcb_gpa]\n\t"
 		SAVE_GPR_C
-		"mov 0x170(%[vmcb]), %%r15\n\t"	// rflags
+		"mov %[vmcb_rflags], %%r15\n\t"
 		"mov %%r15, rflags\n\t"
-		"mov 0x1f8(%[vmcb]), %%r15\n\t"	// rax
-		"mov %%r15, guest_regs\n\t"
+		"mov %[vmcb_rax], %%r15\n\t"	// rax
+		"mov %%r15, %[guest_regs_rax]\n\t"
 		"vmsave %[vmcb_gpa]\n\t"
-		: : [vmcb] "r" (vmcb), [vmcb_gpa] "a" (vmcb_gpa)
+		: [vmcb_rflags] "+m" (vmcb->save.rflags),
+		  [vmcb_rax] "+m" (vmcb->save.rax),
+		  [guest_regs_rax] "+rm" (guest_regs.rax)
+		: [vmcb_gpa] "a" (vmcb_gpa)
 		: "r15", "memory");
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

