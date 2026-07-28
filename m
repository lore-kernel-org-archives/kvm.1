Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACA7381AE7;
	Tue, 28 Jul 2026 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198979; cv=none; b=JCOgajS0K44VNO6mNt4yzVWvu/yVqIdEYv0DUCAjTUgNKJQLKsOjsf3EKlBAKvBx09tHv9vX7h4K6jYUy+GHdeixduwcaB5jOSch09pTsKT35Qo6wL4QamAfYYHS+RpjaMAzwbycX9DXQHuvsLN6tP25lhrrQDxk89lN7pBdpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198979; c=relaxed/simple;
	bh=R/ZYg3JM3G5SxkjDqr4TlXgQXSyYzcTQHuR0c0Avk64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrC6mwY6QW4rqmxC+Sp8AYHDLDHCOoObT/np/Y50yUyuj3jiK+tFDWFFfrML4JJWuGJWATZ2GlLkoYH7BP2v9n++2dl8t1drIbc+wUEZ7U0CIYlUnujyW/+BpGoJ6fSbymZhvXqomiHA1bO5dcaaYvXJdu0pIE+hHkRrHfPSwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wquymomk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wquymomk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7E11F00A3A;
	Tue, 28 Jul 2026 00:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198976;
	bh=s0tYcIcG2vJfZ8//3+rQ+jx2aUx1Zdyl0vETgjIjmtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WquymomkTnNRo1mWaM3ayZirfxVGcIlJw3VHOyuuKB3W6qK+3cJG4mm6ffFoSqaB1
	 DWH+gmfWQMhUiSdu4KIgfWaKwYvhq8NrltlzByOh2ki9iRjUE8Ubv+nGy9UDmMuee+
	 8lrqsbpubVU0+OvWWPGAfCkSjiCYt1Kv/fwHwETS5qC5gKnyxElvrsah/mduBHn711
	 6jwYU1oX7vHB/WEF2vcLGvWJmZ+o6uh71ON4HNOMA9Pq0SLKmjcZW5w4LweIBZdusu
	 zefYnXA1VRGAoXBZU+goGwyANzRt76PZTaA21b6fmjABoJp7UclmsqOjmlsR1VkXRW
	 kpBsiAu7bBVKA==
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
Subject: [PATCH v1 26/28] KVM: nSVM: Flush the ASID on nested transitions if shared by L1 and L2
Date: Tue, 28 Jul 2026 00:35:55 +0000
Message-ID: <20260728003557.1136583-27-yosry@kernel.org>
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

If L1 and L2 use the same ASID in hardware, always flush it on nested
transitions to avoid using L1 TLB entries for L2 or vice versa, since
from L1's perspective they are two different TLB domains.

This can happen in two cases:
- KVM runs out of ASIDs and uses the fallback ASID for both L1 and L2.
- SEV VMs always use the same ASID for SEV-specific requirements.

Note that KVM_REQ_TLB_FLUSH_CURRENT is required here, not
KVM_REQ_TLB_FLUSH_GUEST (used for L1 TLB flush requests). This is
because KVM could be switching between different NPT roots on the same
ASID. While this generally requires an ASID flush in the VMCB, which is
done by both KVM_REQ_TLB_FLUSH_CURRENT and KVM_REQ_TLB_FLUSH_GUEST, it
also requires a hypercall to specifically flush NPT mappings when
running on Hyper-V, which is only done with KVM_REQ_TLB_FLUSH_CURRENT
(as KVM_REQ_TLB_FLUSH_GUEST is only meant to flush translations created
by the guest).

Note that this is currently a noop as KVM requests
KVM_REQ_TLB_FLUSH_CURRENT unconditionally on nested transitions, but
this will soon be removed in favor of conditional flushes.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 58e7d099c559e..9ea8f21be9940 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -719,6 +719,15 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 	}
 
+	/*
+	 * If L1 and L2 share the same ASID in hardware (when using the fallback
+	 * ASID for both, or for SEV guests), flush it on nested transitions.
+	 */
+	if (svm->asid == svm->nested.asid02) {
+		WARN_ON_ONCE(svm->asid != fallback_asid && !is_sev_guest(vcpu));
+		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
+	}
+
 	/* TODO: optimize unconditional TLB flush/MMU sync */
 	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
@@ -734,6 +743,9 @@ static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
 	if (svm->nested.ctl.tlb_ctl == TLB_CONTROL_FLUSH_ALL_ASID)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 
+	if (svm->asid == svm->nested.asid02)
+		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
+
 	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
-- 
2.55.0.229.g6434b31f56-goog

