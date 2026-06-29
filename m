Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DD73DA5D5;
	Mon, 29 Jun 2026 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758283; cv=none; b=JBv2DsC9/zjx0qpuGVM61gbl6TblTZ5ssudywhJ0YdWZPKD2E7NMpZzFP1KznAg011GVBLPkwveCVEH8Ts6oKARAVxnCJ3wVYKfFQyKrpvRbegY+J2IG3mic8R9fYB9paMlUgHyPnhyrjYcbW8dX8B0r7hQjyEvSS9SfHoqHAo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758283; c=relaxed/simple;
	bh=G/NejhiFprZDYDlTxC33YOC1k922YDa5wnNku1KdVeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=korkl5GXzQi19Th9r5nLezoX2BzqORH6KLCXWUv6lAKAWvPHJYkHVS0Vo3k33GQ2MrEG5OkrCumgPd7jneIsdxShocTYgt3a51Ys0r/1hvpiZWYKWRDWT1XtfEyTDJ1+g0v29o2NgxYVFk2xH4tdpQYyqdPtrKxefPLWSUBjfXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBuIv3ib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBuIv3ib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EB91F00A3D;
	Mon, 29 Jun 2026 18:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782758281;
	bh=k0xAOLo+wmBP/8GhF6vFfyDlEdoAMOupEvlLDLvspWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gBuIv3ib6IQkVSETJelZpajsbiUbDlRWouEeVIp4Q3HzY+GgwcC+82j2eaqyL9uF1
	 MkM03zzfyxQ1Oyhl5o9xJAAsrgmWJE6oONR9JEDaWltNrkUm4FyvIrSowXbXvnoFKq
	 neyi98aWCVx0QVXGeDUe7uc9VnsSsGplvvSEakt+1DbBa/MiYKRKXnMs5hXEQEn8Tg
	 9DI6JdhOTQKml4NjXBfFAR7TddrvtBqI5KmJa7v0Ne+/EqYMjkWR7xe1Ot/BvibSvD
	 DUTvPzKC1jJzRT48ifdirJJFb1kMg3h3BDhrzQhCwHJLU+PK9hZzULqpEKGyWhyv5c
	 P4mle+n1dJJKQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 06/10] KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
Date: Mon, 29 Jun 2026 18:37:41 +0000
Message-ID: <20260629183746.699840-7-yosry@kernel.org>
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
2.55.0.rc0.799.gd6f94ed593-goog

