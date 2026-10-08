Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AC123D7DF;
	Thu,  8 Oct 2026 00:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418483; cv=none; b=WF/i5fG/l6Wxx5tMADLGWgeJpj12pn5Dv9rS3Xzj7nmt6jsiVc+vXyhnT6+j7wKKm2Tn4WSk8mBmmZOAKpIfxpWFFTYLKsQnetmr7FlD7ehsZHh0DjWre1mSv6GhxSLc1pO5yM1/sfuvpE9F4VP8Kxmtf/CKZbKtblvIUFdTpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418483; c=relaxed/simple;
	bh=hR7QD5cD4uy9CAgjAhVCiUn8R5UnrkW8OB2RrzFSUMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuuQSC/hPdIbWrMwifKM8Qq0+X2L+tY/kNFhkuge5r9p7YKyUyO9WptvBgJtfmtkm4xM8dVkPix2jOVdwc+3QfHECB2D9qk8lbjfuYxOC4fLJZOSqyVQp1vFtRx8Zi3sSkNvISYhYB8Zk8NJg424vLY0ZnVS/G6LEi5/srrxCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy4HyUMD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy4HyUMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FA71F0089A;
	Thu,  8 Oct 2026 00:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418482;
	bh=rcGq5lu/GoQ64oSlMf25cl06SQFERKvdgOadQtklw20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hy4HyUMDLOkHCkT0YzgiNOQ3ptMGQ46rhzdTfaOc82tAFCdlSTSPuQ7/zMWS5agRi
	 h/sGEdPFVuuOoaGzmHg+qtHT6Sp8td6TaHe7XH+M4fRJMZOSH8VWEynsn4diaW74ws
	 SG+tRanqWxuXRJoUKKwu8RtBwhoT9K+q8T0dBh8IoS+PlrONqfZe24fzlHeneutAvI
	 bO4qqHjaxtOyeAj9I5Vi8hDF9cXM4wOyx2hIb05dWjd/O95MRXN6wsYFS7+q7JAkXp
	 SnF+fbT76bJSyPJbD99Chn99dFWNYyBYOCkGF+wn28V2A7rH3Mw/D5cuIyWPK1Sdv+
	 W4PW5gxgBXD6Q==
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
Subject: [PATCH v2 06/29] KVM: SVM: Fallback to flush everything if FLUSHBYASID is not available
Date: Thu,  8 Oct 2026 00:14:02 +0000
Message-ID: <20261008001425.2458927-7-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
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
index ad4f172f170d9..0c3befd9bc850 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4326,10 +4326,7 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
 	 * unconditionally does a TLB flush on both nested VM-Enter and nested
 	 * VM-Exit (via kvm_mmu_reset_context()).
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_FLUSHBYASID))
-		vmcb_set_flush_asid(svm->vmcb);
-	else
-		svm->current_vmcb->asid_generation--;
+	vmcb_set_flush_asid(svm->vmcb);
 }
 
 static void svm_flush_tlb_current(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ba5077b9838c0..3b59561d6cc2c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -482,7 +482,10 @@ static inline void vmcb_set_gpat(struct vmcb *vmcb, u64 data)
 
 static inline void vmcb_set_flush_asid(struct vmcb *vmcb)
 {
-	vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+	if (cpu_feature_enabled(X86_FEATURE_FLUSHBYASID))
+		vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+	else
+		vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ALL_ASID;
 }
 
 static inline void vmcb_clr_flush_asid(struct vmcb *vmcb)
-- 
2.56.0.360.g66cac248cb-goog

