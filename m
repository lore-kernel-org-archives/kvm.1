Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601B47F795;
	Mon, 12 Oct 2026 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848220; cv=none; b=JF5DU9ZV8YUlGBlU6W4Es7qdykVPDnD9BbRvulsEA8wv7wqazEqZ8JFMG+gNW2wr9Hpaay5uq4pZ3EQJljFtyjn9mewto5+zls4onq93tGW/DCt7PfTg8QR1mMA+VdCKOzs9IcFdL5U8hx9Z9cvP0zyezZMnWrqraRXBjP7pxh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848220; c=relaxed/simple;
	bh=20ELIYwNeN9kHUiryBA1l8S6CuLKBgvUgtV/t/V5r1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVPWqGcs2X5n26LbpwyYV2jwYgCWR94VZWhfuHb9++5GGlsPtrOPDQgaUkeqo85ZQ5LF+cJXkJNGWNVCzrtFIJLZrZuKz25oHtLtzL/lkWlhzgJZJrjapOQ3XM8jXIKByds4Nc4mNpORKIeGHogh6i6+PLyCT6ksHW+HuVBnEb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzrW3S1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzrW3S1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545A31F0089B;
	Mon, 12 Oct 2026 23:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848218;
	bh=xOjHbV1irZzRYOTeaWaq7KS9KrQyyYR+6d4cxah1rPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lzrW3S1EIkGyKVG2eTEbqLcrXBgaMkZdf54g3KDwoy7f4rYfhTGdG5qO6v/yvQo9f
	 tuOBAK8rEiSmOWolmRnfXMEIn7dBuyjE9GwBzdvCz1wEVNJk7x1LYlkH1uA169VkNV
	 d7ksf7KW/Vg9Nos5o4HB/fHo5fCHuNyvKZskwApA0NTdUr1UVHfPjuM3731ykwDibS
	 2qvfbFO/CVoQgRkvwCnqCn1EhtSa2pFkUuS2gUU8XwGc3IqZj7Z0LrG2dpk93lY7oy
	 G1ypto1cYergOLp4vqtmqqtGEAf/Wa5R2Jjsk1xEvv3sgKiEAhVJxloT7KxNeL7dWf
	 nmKdR4n9tsC6Q==
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
Subject: [PATCH v3 25/27] KVM: nSVM: Flush the ASID on nested transitions if shared by L1 and L2
Date: Mon, 12 Oct 2026 23:36:36 +0000
Message-ID: <20261012233638.2546339-26-yosry@kernel.org>
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
2.56.0.385.gd3acb90ef8-goog

