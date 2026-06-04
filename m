Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3314C9008;
	Thu,  4 Jun 2026 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605363; cv=none; b=UM3xoQEXKnmJk5coXt5dzYJ6OoATquqatrioMqzuamBG5ESichnSLb0Ygr57DYEHcvp+tHOuUidfjFKfjVt7RJyFjK7OGFeZyRv+oBOlNJPgvzOVKiePeS68Rpe3lMwRZCaVpc4Pubqr+uWg+F0DEgTZm6XGCsESTSHR49gSZ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605363; c=relaxed/simple;
	bh=NC84ffeQy0iJL663aiqOy0R/eAc3gFvlRDSb+4dOhMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozHsukRYnJHM4NU+YB8X/L37n4OlusyJWle8ewktYaUPGrBp8PHs5tm1tAnwwNb0XqOpf37kKnnrc0JZUsPBrBH0IeZXMXtjuspp9rJdNUwO5cZWSRC9MqXh7uTVq7/9l7iBUhP6q5CU4brrJ1/smGILenHhneg7Ncx95kbwBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oH1kkwsF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oH1kkwsF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C991F00899;
	Thu,  4 Jun 2026 20:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605362;
	bh=OWWUy0BLOs/Gt8WhkITHDyuN301UMNeyVOt4Dhby09s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oH1kkwsFdwRGgpHZxjhlKiE5RRHjvvjnVe6T66j8hFVdBYBtXHw9XtiNapkpTPLP8
	 o03AfidrJKgfk9thQu7710O4iY9Dxnzc5ZM+oxn7cy6YLb+xjt+sTGisVFoV0+LUSC
	 JdSfhadLUXt16Xvr9W9GXigip9+XNIT6rg/8EI93jD2qMZg9Lrhx7FmumXQ9TJT84c
	 +l/Y6zU282CpomcVybBGji1rNFdoEwh4cT1Y3ZYVVOgo0UAbNI2rENzQO1Wd/XBhVE
	 weqErBzebfGPUjl6bMdv6UPFs+FFXXOy+4K54qrmPmLKpjHyi5qnrgwpsGepi3IMZ2
	 Fu+OS2KeRDNrw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 06/10] KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
Date: Thu,  4 Jun 2026 20:35:42 +0000
Message-ID: <20260604203546.365658-7-yosry@kernel.org>
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

Now that nVMX test codes preserves GPRs across nested VM-Exits
(specifically RBP, RDX, and RDI among others), drop the ucall-specific
hack to avoid clobbering these registers.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/lib/x86/ucall.c | 32 ++-------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
index e7dd5791959ba..38050c60a0670 100644
--- a/tools/testing/selftests/kvm/lib/x86/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
@@ -10,36 +10,8 @@
 
 void ucall_arch_do_ucall(gva_t uc)
 {
-	/*
-	 * FIXME: Revert this hack (the entire commit that added it) once nVMX
-	 * preserves L2 GPRs across a nested VM-Exit.  If a ucall from L2, e.g.
-	 * to do a GUEST_SYNC(), lands the vCPU in L1, any and all GPRs can be
-	 * clobbered by L1.  Save and restore non-volatile GPRs (clobbering RBP
-	 * in particular is problematic) along with RDX and RDI (which are
-	 * inputs), and clobber volatile GPRs. *sigh*
-	 */
-#define HORRIFIC_L2_UCALL_CLOBBER_HACK	\
-	"rcx", "rsi", "r8", "r9", "r10", "r11"
-
-	asm volatile("push %%rbp\n\t"
-		     "push %%r15\n\t"
-		     "push %%r14\n\t"
-		     "push %%r13\n\t"
-		     "push %%r12\n\t"
-		     "push %%rbx\n\t"
-		     "push %%rdx\n\t"
-		     "push %%rdi\n\t"
-		     "in %[port], %%al\n\t"
-		     "pop %%rdi\n\t"
-		     "pop %%rdx\n\t"
-		     "pop %%rbx\n\t"
-		     "pop %%r12\n\t"
-		     "pop %%r13\n\t"
-		     "pop %%r14\n\t"
-		     "pop %%r15\n\t"
-		     "pop %%rbp\n\t"
-		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memory",
-		     HORRIFIC_L2_UCALL_CLOBBER_HACK);
+	asm volatile("in %[port], %%al"
+		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memory");
 }
 
 void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
-- 
2.54.0.1032.g2f8565e1d1-goog

