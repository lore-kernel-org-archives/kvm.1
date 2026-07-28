Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6664483B5;
	Tue, 28 Jul 2026 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260563; cv=none; b=usSihN2tOfaPwEXRH6tyxyDj/BkxfWTUK/GbZTjnfozqaPKVZ70RnwQBygoQgdEP9C8Gdm0usOBtXemvKHmZE/djrKNLhYZS96chfAAqvmFwTFeFtbU7WHTAn2JQY4RVPNhlcEQt6wtXi1MsylUQ36if57tae3nkh/J3eW7wlwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260563; c=relaxed/simple;
	bh=86DhvDHlVL78Z4vV5u0Jv/Z9VXoJHU0exCMgmpNjShQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEqtgdgHechGdAwD5UWXwllVKqegnDYpm74iw/t8f6A5OC3D6/SPTkUrT6broNgyk+t0tF/prwks9UFzJQ+1VWAMpIHYs9sDi77AGxrNPmNEcSC5boCMdIMY36w7QJsIupHvDxxZoPGSEUWiSE9zeGrf+hS9QyQpb/9cVa3xFSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TN8SF/hK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TN8SF/hK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB091F00ACA;
	Tue, 28 Jul 2026 17:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260561;
	bh=mno+jyHIKhhiTcqWZExIECyUg4QH0bfAgCt20H00CYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TN8SF/hKC5122tvUGKeOfwfRV3mEZIaD5BAE6mfk25HelDoC8Zv+vs4Mf+JbkHMEZ
	 iOyBYcmStOBcgXfbUaS9Y1c5HoarGGmlXtF03k2ODDKx7a+KSHycujflye5GAcTK0/
	 5tDAcmSOxLoY5j6Ict0l//5X84sNa/+vAO1SxplXnLtkgI7Cmdgpv/M+hieemC/Sw2
	 jrhQT5IcKH0We+42Y4ix6RKK5vc3ZpLFHgDxbR8BEQWNBXjeIHsUnr24ZOYBFjy4Hm
	 NNC/O6w7VNPNxqeBd+ghAIMNOW4BopRRZhkF0DjMVuJ6r743dQqTK8hwSME9K0ExtT
	 P9DDH7/wxLhvg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 06/13] KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
Date: Tue, 28 Jul 2026 17:42:25 +0000
Message-ID: <20260728174232.2423257-7-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
In-Reply-To: <20260728174232.2423257-1-yosry@kernel.org>
References: <20260728174232.2423257-1-yosry@kernel.org>
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
2.55.0.487.gaf234c4eb3-goog

