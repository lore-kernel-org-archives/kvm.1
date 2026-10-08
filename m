Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB93381EB1;
	Thu,  8 Oct 2026 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418493; cv=none; b=qu0fZcrPGuWi9rAaR3PNG0atzrUsy6NPGHO5IgRbLQlS1/6HMhOzoponKdsCQFyy+HkgoFwqRc/rKNOaVFfQZfgj2jQYRFhSti7hfEuY/8gJ/7vdB6t6NFBkOnl/nVkDxMT/+OZy23S6pB1FU4yo7EpKYvRhpUa0vPEyUl3fiYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418493; c=relaxed/simple;
	bh=jzTBNuQYePMYzWL6AMfy5zNz+TJV4q0sBwhvElEgARk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yf5b/uHphN7yp+p9Npy5zucvNmZpwPHf5KrXL8XpCDOZQSc3Fy3X3VvIokgPtM33PHVDoBHET3+Nkyq4SGTXGNi9M4qiC3G7RWoN8JXxXiqFiSEyfIl91+qwKqb3Vadk+U3QvTTNVNQVInnkioRJWVu18/3PkG+L5Y2MIXEMguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfPS2Ihc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfPS2Ihc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF581F0089A;
	Thu,  8 Oct 2026 00:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418492;
	bh=O9KdHNHutDV+JQ59rRSBVNijPi9fkvprm9/+/9dn/es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QfPS2Ihc1eaqGRhWGCfb+7ozBh6fMwtSYJcVQwL+9aaCpBKGzTW6kyqBU0b0OjKWF
	 8MRFTiyAngPp7R9gO+ck+6GyOABCzZSeOg2PqaIg72GvKiGHsQ09I0EzUHxQnkTaQ0
	 tE+L3w8nspCWopAWGR76TlnXxhRgY4+Y7F7QuH4LBACqhQOTt1UK0+gKL90UYEqjpH
	 5mW7Bz2PiRnA5W6/aYwbeMvNTwI0+ybM8wmzS4t34MACKuF6otzA6fqoknql4Lb2Js
	 YeotiaUyaUpPxpQ59FVPw5ElTPQV4yTiOeCg8/AHwyWL6ys/nAPA7K/Tl//t7HXwdL
	 O1ruJ6bfQTG2w==
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
Subject: [PATCH v2 27/29] KVM: nSVM: Flush the ASID on nested transitions if shared by L1 and L2
Date: Thu,  8 Oct 2026 00:14:23 +0000
Message-ID: <20261008001425.2458927-28-yosry@kernel.org>
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

If L1 and L2 use the same ASID in hardware, always flush it on nested
transitions to avoid using L1 TLB entries for L2 or vice versa, since
from L1's perspective they are two different TLB domains.

This is currently always the case, but KVM will start using separate
ASIDs for L1 and L2 in most cases soon.

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
 arch/x86/kvm/svm/nested.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 738ec1f2ec869..4ffc10bf9232e 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -723,6 +723,13 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 	}
 
+	/*
+	 * If L1 and L2 share the same ASID in hardware (when using the fallback
+	 * ASID for both, or for SEV guests), flush it on nested transitions.
+	 */
+	if (svm->asid == svm->nested.asid02)
+		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
+
 	/* TODO: optimize unconditional TLB flush/MMU sync */
 	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
@@ -738,6 +745,9 @@ static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
 	if (svm->nested.ctl.tlb_ctl == TLB_CONTROL_FLUSH_ALL_ASID)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 
+	if (svm->asid == svm->nested.asid02)
+		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
+
 	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
 	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
-- 
2.56.0.360.g66cac248cb-goog

