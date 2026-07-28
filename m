Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA700224AF9;
	Tue, 28 Jul 2026 00:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198968; cv=none; b=Nf2ork0+PFKBBoi87U2qc5/taGXUk6NNRquCTWZSqL5QdcvqzLaE412gs7y1tb/jAmDy+eg7OFpTcbWY6jINyVecXZQUG8Z4Ya3KmuUe32St2zbJ2wJ0lmJTIN43evgOPwC63jsCHcUD0086k/ASGUgmVDh4kAd1XMXWVt24Cww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198968; c=relaxed/simple;
	bh=OgQtBoFYHqMC0XIFe8p6DFaVW4yIjaxo5oH0jVKC0ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGXSSWjJdRQPLP/+0DguXYV/+mOF05OO/OWQ6eUO52Po5ZWDt0yo4VGP1teA5xECgt9NyFts8UwsVgF4H7gO1taR2bhq2kehthH3LFau4nHIeKdmYOrpHIkSXZsMvbk3XPLqz87u/VUPFZSdWpf4gNfsfhBWmm+4jmxSVoVJUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb8CfsQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb8CfsQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440F81F00A3D;
	Tue, 28 Jul 2026 00:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198966;
	bh=/idk54VU3bpdZr41Sty/+Ou7MPII4mh1G0EXswdg2iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hb8CfsQK410oBjRqcl0vlM2Cmldzvhv3u4LPDD7Eo4fPEN1R/cnwu7Vsdoy/jDrIe
	 rHXnYH3SOOKpYH5gwuSJvjjfzmlLJZmmnLIIj+vrZeNMvDyC7+2blCsNfOkrGAp+bl
	 3ar1ztfHLJ3t9xRfy+vXfngs4h84zAnKg9nT+ObtjfhK7oV0CFYMzY5I/fbKXE8X3K
	 OJafoqBcPELclBrbHPtH+44AZF/JmY9B/2t3C3ohAb5cOGNtdtJOg0AgazsAWfyboQ
	 GdG37lRPJSuwgiw4kK3dSMpZx5zo17TdgxQSb01EdA5rRf+OlfWIQBvq9ZjYO6kRW2
	 3WeCF/YF62BkA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v1 06/28] KVM: SVM: Fallback to flush everything if FLUSHBYASID is not available
Date: Tue, 28 Jul 2026 00:35:35 +0000
Message-ID: <20260728003557.1136583-7-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
References: <20260728003557.1136583-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if FLUSHBYASID is not available when performing a TLB flush,
the fallback is decrementing the ASID generation to trigger allocating a
new ASID. In preparation for using a static ASID per vCPU (like VMX),
just fallback to flushing everything if FLUSHBYASID is not available.
This is probably worse from a performance perspective, but FLUSHBYASID
has been around for ~15 years and it's not worth carrying the
complexity.

Move the fallback logic into vmcb_set_flush_asid(), as more callers will
be added and will need the fallback as well. The only other current
caller is from SEV code, and no CPUs support SEV but not FLUSHBYASID (at
least according to AI).

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 5 +----
 arch/x86/kvm/svm/svm.h | 5 ++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index de90320a2e669..aff1aae5a5a32 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4198,10 +4198,7 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
 	 * unconditionally does a TLB flush on both nested VM-Enter and nested
 	 * VM-Exit (via kvm_mmu_reset_context()).
 	 */
-	if (static_cpu_has(X86_FEATURE_FLUSHBYASID))
-		vmcb_set_flush_asid(svm->vmcb);
-	else
-		svm->current_vmcb->asid_generation--;
+	vmcb_set_flush_asid(svm->vmcb);
 }
 
 static void svm_flush_tlb_current(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e3cce839573d9..2f18dff023bc5 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -479,7 +479,10 @@ static inline void vmcb_set_gpat(struct vmcb *vmcb, u64 data)
 
 static inline void vmcb_set_flush_asid(struct vmcb *vmcb)
 {
-	vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+	if (static_cpu_has(X86_FEATURE_FLUSHBYASID))
+		vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+	else
+		vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ALL_ASID;
 }
 
 static inline void vmcb_clr_flush_asid(struct vmcb *vmcb)
-- 
2.55.0.229.g6434b31f56-goog

