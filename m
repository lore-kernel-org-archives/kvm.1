Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C64431A42;
	Mon, 27 Jul 2026 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196368; cv=none; b=Mbd1CV2jvIQOgOomD6hcpwh2Nt+zjm+qV9EWKpcqhEOpvHwBlJldZI4+5bNbG93KwjLTnsZSSTFFfE3C7ym7iKNeh+KbB6Da6BOwtN5kRjpf27hVm9cJUbsjagw5EIdzT45vxiGO6hxDs+NLjdKRXunct6w3lak9mpdZNjVkqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196368; c=relaxed/simple;
	bh=0XwYsbMy5QCPyl10QYS1lgiLUzB8KTfFe41yAz4d69Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHmokrElYgRd4E9TRxUMWXWlOIi2gQQ4eaN6ZeGfHOkkLXBp6t4ScyluY0TfM1WwIFZfW8R6PzSVfuDwHqRQyYVoGeOkawkR8ZjwxLdETITl6sVLz+I7V8yOsQuvc2zPYShI3mr9rPn/Pv6Ne96rHNWfhC6kdmhKZetPcN7qyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j17aMrvV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j17aMrvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FBE1F00A3E;
	Mon, 27 Jul 2026 23:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196367;
	bh=Y2ZP4cU4kxWYJ9538/o34pyg45N755GVcwPinonU/aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j17aMrvVmIgcI7pfQoUyt7dYU9GPae1s30dt7NMXgpC7GkJSfgbLj3JwZwXZDyg0z
	 tsZplUn0K5Oxg9Wqn7knUTwCQBgfqzdElJ6R8FTQIForEOS1ZV+iynxzSoev47tvo1
	 JZ9UghpTVBvGTRFo519jFWuzhWKFYdhOSzAGxB8tQ5lwm/uRk5M4f8WpUzdCg/NNMv
	 qddQJVFd3Sz2qL0z/rlU2cbAvYKZaml1Sd1iq55lpyJSGJpy26nooQDS67pE17abnI
	 OSe80fLdVtC4WmrtPGUbH1H7ssnLY9PibhHV7lOemgD43Yw0G3BBTIAFLbJx5tAnVL
	 m1SC8OOdaQv2w==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 06/12] KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
Date: Mon, 27 Jul 2026 23:52:22 +0000
Message-ID: <20260727235228.1007324-7-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260727235228.1007324-1-yosry@kernel.org>
References: <20260727235228.1007324-1-yosry@kernel.org>
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
2.55.0.229.g6434b31f56-goog

