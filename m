Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028539479E;
	Mon, 18 May 2026 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135925; cv=none; b=BxC5//0Mcw1uGcM8JIhf97RO/bXdhX+eZoxbzqX1cKwrgXLYZyZqrZd0RVbPIcIKIEfGvAZzOE3v9a1KISIsCUrpWNtNy6ehuL9B2uhRqxpru1vpZ6mVW3M3j5zOsZ9HfE+5T58yYRY42Q1yNZWzWOlFUUdNUB1HTeiniEh66S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135925; c=relaxed/simple;
	bh=T0i6Ik2CmSyrxKdX3wTZoYvO7kQfKV0rVgmsLlT+bZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgmUp+aycgsVzvvmF6V+7g3w0QDN3yBZFJHSMd3AjAke3RD4Yi6+i+719x8uc4MyWz2KDgUw8lGhD4dssTxnJ6apFMFEVn3TgUmEQgn9cKbhVo4nOjBN53O52Uy61VzgtRQhnd09zF/rHcozgDtc0Pw2MttiEt/AATwv0izI/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ify8YESl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ify8YESl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407A0C2BCF5;
	Mon, 18 May 2026 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779135925;
	bh=T0i6Ik2CmSyrxKdX3wTZoYvO7kQfKV0rVgmsLlT+bZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ify8YESlAPgIecdD3XFRF2kc41kTgiRNK6psaxG1FLbCbmWJmDI4AkpXTSBKc+dgT
	 uv4qtmKOTpl5Swb+BI/SuylAJbRfpSyN1PnPf5Aw1LcF4Knk9NmKOSEXYD3LlIDOFl
	 bBq8GZ9lBEyj9B7cUdGKLplZL5JyJS9vUYO6EE8sozR761z+ljuAv33guxnxqxhzo8
	 QPuVEK4N6YfcKXhbdL9uABJOTbNqDXbVRecz2GR5a9IB3TayBBv5pctQR32KNLS5cr
	 9sAMzRw5tDK2fJpdOfKfs1bPOQWWa9/gUT68rdye/Y85lcqXOiodNUGNqrsC77MgsT
	 F8u2jXEwoFnjg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 4/8] KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
Date: Mon, 18 May 2026 20:25:10 +0000
Message-ID: <20260518202514.2037078-5-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260518202514.2037078-1-yosry@kernel.org>
References: <20260518202514.2037078-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosryahmed@google.com>

Now that nVMX test codes preserves GPRs across nested VM-Exits
(specifically RBP, RDX, and RDI among others), drop the ucall-specific
hack to avoid clobbering these registers.

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
2.54.0.563.g4f69b47b94-goog

