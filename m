Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0713C6A5F;
	Thu,  4 Jun 2026 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605361; cv=none; b=PLvV6YTSFe2hr760EpT6/ExyLPatuYOYa+fOD/e328+08PD0eLHf1h74dnr8XVrx4PSGZGl40enOj5JlKZ/oLOGDEJME+h5u33Z5IJjJIN046lgmbdTdgmKaKMV/7RKzzSFYSKFnm4MJkhT7AsKCSjunJMKarMH3oCNqyyCfhmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605361; c=relaxed/simple;
	bh=o+gRf/jJkkQT7GrXgVPHQbiVu+EFRgY7NIiZfDaYg54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoMDRMlJFe1ZxHUo8BBXddnEY4xpJ0K1sGXGHQCCtflLraotLFG+SqXIO0Wm0xHBnPUvVT1M/OmiIsOtHqIImoFfh79mG7FAbN+qpHyBoQe/AB119KkBgYOpa3LzcGnqs3DaJ9/cAHzOqW391aYQRrPIu7pvMf8lloI2V9I2hiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRYqw7c5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRYqw7c5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683FA1F0089A;
	Thu,  4 Jun 2026 20:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605360;
	bh=iyNtZBVOFOFiHv/bxlZAV8NqRiBzVXC6M4IsHF/XRWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SRYqw7c57VATQRJQ8MPK9gQBEfEXhLqVO2uy2mfxkaGUxQRF+YJhvEMHbNsoBgUZH
	 qKELDlXCpCacmMovDq615Kp/Y6ft6/jQetu24mA70MmOSLKqxt3p6vSE7UIKuDI6ZF
	 ABliST0ic3QlmgwiGiZv6ljRgIG7uVhIuIvWdtw7FhtoUUM8bZhj9b90k02P2HRnIy
	 /tgA09EYywF/c58h6furNNwlRLt/NLBt7Ky/pqgzA1qIIy+Y94fHgIZYgjWgZLsNz1
	 PZOZaqt6YoIwxDln3mI5AZHjSfqKV8WTIr2D4oy2JMZR/1hStWUkiSxVfH+riToxhR
	 4Z0hfNYg+v/Sw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 02/10] KVM: selftests: Fix RAX and RFLAGS VMCB offsets when running L2
Date: Thu,  4 Jun 2026 20:35:38 +0000
Message-ID: <20260604203546.365658-3-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604203546.365658-1-yosry@kernel.org>
References: <20260604203546.365658-1-yosry@kernel.org>
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
index 3b01605ab016c..f9ea1a2aeb8bc 100644
--- a/tools/testing/selftests/kvm/lib/x86/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86/svm.c
@@ -162,19 +162,22 @@ void run_guest(struct vmcb *vmcb, u64 vmcb_gpa)
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
2.54.0.1032.g2f8565e1d1-goog

