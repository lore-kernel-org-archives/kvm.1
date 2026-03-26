Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D623921C8;
	Thu, 26 Mar 2026 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774494752; cv=none; b=V/d1xEmCIWnyo1tWj5uylSmTGI3ZUfc+XMf3hvrc5xMpZjWHMZK0dsk5DieTdi8t9OS314v9S3sMEdxjY7ONd83Bzx410n2Ph0hLi/Sh/WZ9igar3YnIp2duQkKmogo5rO1jp0SlMOGCFS9/G3um8OWEQKWvLGb1t6JONexMIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774494752; c=relaxed/simple;
	bh=qDXb6RRNHKcex5f0LtzcegwbG5/8saeewaxBaYEyuQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/bRBio3SiZQWuJa26f/PhTNJm/7Sg9+9t6tfSlH0K23WnjiRyUkO+dlHfV5r4F/VMBRN46BaPrtKyq6MXHUsSsx44gj1cU8U0DghFNF0iQunMuMZj8CQsOWkt2j8v2Np2rqNmT9kfruipUYdNp8qoLTnbl0ZJEGZegfhviirJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhzfU2LT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhzfU2LT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFF8C2BCB2;
	Thu, 26 Mar 2026 03:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774494752;
	bh=qDXb6RRNHKcex5f0LtzcegwbG5/8saeewaxBaYEyuQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhzfU2LTCfYt1KI2YSzGKlHdtqHbJPKdKfaQSxEt0yMTCJGmGrdy3EQUyj740Pn1Z
	 vfidCb9lkfziguRSL+RK/Vc+M7soq5+reGYL083uX86UJJrHKhJOVjrqjxRjRPgoMP
	 ML/fJX1d1YUN80AA/nnqWqo6SHA5+RDM8aYFPUmvoh+r9fexUaYu2BaN4RvONa3wnb
	 DdRcKfOyoO5PdRW9GrljEjcTUb1I+87qGLWRO7e5cEHPrxReu7IdjSN0hroVNgEWE3
	 jFlloiVPJEGBrahLRDafAJLZ/WJG0YDiTWvoQFzdw1FZov+caWkW4S8i1v1SxYJ1BB
	 KIjuXFr4QiVGg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 2/6] KVM: x86: Move guest_mode helpers to x86.h
Date: Thu, 26 Mar 2026 03:11:46 +0000
Message-ID: <20260326031150.3774017-3-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260326031150.3774017-1-yosry@kernel.org>
References: <20260326031150.3774017-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move enter_guest_mode(), leave_guest_mode(), and is_guest_mode() to
x86.h. This is more semantically appropriate to keep kvm_cache_regs.h
for register helpers, and more importantly it allows for expanding these
helpers without including more headers into kvm_cache_regs.h, keeping it
as much as possible a leaf header.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/kvm_cache_regs.h | 23 -----------------------
 arch/x86/kvm/x86.h            | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 8ddb01191d6f6..8682ef54a8c9b 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -223,27 +223,4 @@ static inline u64 kvm_read_edx_eax(struct kvm_vcpu *vcpu)
 		| ((u64)(kvm_rdx_read(vcpu) & -1u) << 32);
 }
 
-static inline void enter_guest_mode(struct kvm_vcpu *vcpu)
-{
-	vcpu->arch.hflags |= HF_GUEST_MASK;
-	vcpu->stat.guest_mode = 1;
-}
-
-static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
-{
-	vcpu->arch.hflags &= ~HF_GUEST_MASK;
-
-	if (vcpu->arch.load_eoi_exitmap_pending) {
-		vcpu->arch.load_eoi_exitmap_pending = false;
-		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
-	}
-
-	vcpu->stat.guest_mode = 0;
-}
-
-static inline bool is_guest_mode(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.hflags & HF_GUEST_MASK;
-}
-
 #endif
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 48f3e8c0dc30d..f1c29ac306917 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -148,6 +148,29 @@ static inline unsigned int __shrink_ple_window(unsigned int val,
 void kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu);
 int kvm_check_nested_events(struct kvm_vcpu *vcpu);
 
+static inline void enter_guest_mode(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hflags |= HF_GUEST_MASK;
+	vcpu->stat.guest_mode = 1;
+}
+
+static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hflags &= ~HF_GUEST_MASK;
+
+	if (vcpu->arch.load_eoi_exitmap_pending) {
+		vcpu->arch.load_eoi_exitmap_pending = false;
+		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
+	}
+
+	vcpu->stat.guest_mode = 0;
+}
+
+static inline bool is_guest_mode(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.hflags & HF_GUEST_MASK;
+}
+
 /* Forcibly leave the nested mode in cases like a vCPU reset */
 static inline void kvm_leave_nested(struct kvm_vcpu *vcpu)
 {
-- 
2.53.0.1018.g2bb0e51243-goog

