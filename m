Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6273EC837;
	Mon, 12 Oct 2026 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848210; cv=none; b=IoOGj2NfHoZBO+TJGCAfeUAWOQ5ySCttszhyEZ96NgaoDaHIzxuN/gFMSPzflGk1dffzsxSKWBkIEYPDCmeCzKx0Dt649p1GvcWaKvTRMc/MTYAsALxEpG/+3XNuwvhai/lM0Xkjk9/7GN7PX8hht+x0qChwJmtGjnZkWaUdG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848210; c=relaxed/simple;
	bh=oC++HnbNVBPzn9IPIrGkJWmOX63pZeHKYyKqgaP9XEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhsZ8nbXOMbbWYKHDGYZa/MYuzhed5iYG+W/7QjwJt+HNN+waaGPiBqUu5t1dlU0ZNKx2PRVIobHb2QnkgE1ZGhWh+yLFWYq6rwP3h1bznExt5G8PErOiEBngV0AxEX/OqokxCLiwWILKBra83X435XPcQfdpyc2/2cdyIqDnro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUFUoaUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUFUoaUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5ACB1F008A2;
	Mon, 12 Oct 2026 23:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848209;
	bh=nHWs9fdHb10oFLCmMVp5pRkBPVBN0HXSu/aadpWYtKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CUFUoaUJp17wFfWmbg0LjMacNDJea4oUW1YId4nW/yFtRh+qJ3ToZ/P5igBBZR0hB
	 jTz+5bLsq10g/fVKfLmifDi3FyuokR7TFgusxCChbt4jkRhft1xos8iFpfR7veTa4x
	 M1KXuSPIjPWEIe0NWCYqbLvaA6ConMx1UcTGeunX6wiQ7IcAMCX0Y1bbFxSnyzUJq3
	 EmV5CO6jEZLrgH2SUSjbhs3sLYFoTkD2k0tVP5pRWl7RCZEUk199xZvn75rBBwEbWR
	 Y89yUtcXl0ILiRpcgkaX2n7tTzvATDl77frdRUVRL0kC0HBm5QOMI6hU+xa4hstQjx
	 fOM4uR8YAeZ1g==
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
Subject: [PATCH v3 06/27] KVM: SVM: Fallback to flush everything if FLUSHBYASID is not available
Date: Mon, 12 Oct 2026 23:36:17 +0000
Message-ID: <20261012233638.2546339-7-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
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
2.56.0.385.gd3acb90ef8-goog

