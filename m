Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DFA242D89;
	Wed, 25 Feb 2026 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771981200; cv=none; b=iPv0rcaLaCnYdBVMV5AmKnVoXgdnGQhUP7J6P5dJ/ObMZxH33C30GjB7HOF7n2wANzDbD7TqwJDU3QmnH/tWLxtnXSILc7v5zRzHWvX9hJRsi79apxhqbcfvjOpZwljvtuu+CDsmskx3OOjAbg408Iq0LyZgIeLR2JV/mCIjymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771981200; c=relaxed/simple;
	bh=9lBPXI38bsEWr8vPvyFeR/i42i2pmCvUDBm+vmL0Rzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GV05v05cK0/UmPrZYXug2HFEFLE+PnvXpHCXc1vejfA8XBlrrfu5IAt9unC0RbqZjPl6LhfJwGXNwE1wINti8wwjw6MpLu/svv4zqlUqLQcoX4Ahc7y3yVYF4upp2ikyc08//pma1i+QydswmcNoe2VjEJTdk4B/RNujjk+Q2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA+9ukFJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA+9ukFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B66C2BCAF;
	Wed, 25 Feb 2026 00:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771981200;
	bh=9lBPXI38bsEWr8vPvyFeR/i42i2pmCvUDBm+vmL0Rzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UA+9ukFJrjpgEAsv+sW6ce3NiI1yDQeg6KMmJ8ar1oiUHfYgjeezixqMUknvKcXm2
	 77AihvBTJmuKBSGkuKKcOnZCUgi1HiOJUIfoDYIAx0jvEIN1xQPtVR/aJbYPofw6NT
	 yB4ZklEGT9W8wOc4ZvDvhy40aOczU1ZluLaeDkengrQe7nYWH0KrUXtzS4vUKumJPp
	 DnBmQja6Mw+LCEYXDXS4CXbkDWF5Pse+RwDgByo2YqAEfkUwCnngYotLjadVD3Jqk0
	 6IUU093D/hA5a+/d6AupSlDHQOo9b+1SSh2xrg+QquMBVCug6KAVCLJNEZValbNiQM
	 EycX1V52pNuXg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/8] KVM: nSVM: Sync NextRIP to cached vmcb12 after VMRUN of L2
Date: Wed, 25 Feb 2026 00:59:43 +0000
Message-ID: <20260225005950.3739782-2-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260225005950.3739782-1-yosry@kernel.org>
References: <20260225005950.3739782-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After VMRUN in guest mode, nested_sync_control_from_vmcb02() syncs
fields written by the CPU from vmcb02 to the cached vmcb12. This is
because the cached vmcb12 is used as the authoritative copy of some of
the controls, and is the payload when saving/restoring nested state.

NextRIP is also written by the CPU (in some cases) after VMRUN, but is
not sync'd to the cached vmcb12. As a result, it is corrupted after
save/restore (replaced by the original value written by L1 on nested
VMRUN). This could cause problems for both KVM (e.g. when injecting a
soft IRQ) or L1 (e.g. when using NextRIP to advance RIP after emulating
an instruction).

Fix this by sync'ing NextRIP to the cache after VMRUN of L2, but only
after completing interrupts (not in nested_sync_control_from_vmcb02()),
as KVM may update NextRIP (e.g. when re-injecting a soft IRQ).

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
CC: stable@vger.kernel.org
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8f8bc863e2143..07f096758f34f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4435,6 +4435,16 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	svm_complete_interrupts(vcpu);
 
+	/*
+	 * Update the cache after completing interrupts to get an accurate
+	 * NextRIP, e.g. when re-injecting a soft interrupt.
+	 *
+	 * FIXME: Rework svm_get_nested_state() to not pull data from the
+	 *        cache (except for maybe int_ctl).
+	 */
+	if (is_guest_mode(vcpu))
+		svm->nested.ctl.next_rip = svm->vmcb->control.next_rip;
+
 	return svm_exit_handlers_fastpath(vcpu);
 }
 
-- 
2.53.0.414.gf7e9f6c205-goog

