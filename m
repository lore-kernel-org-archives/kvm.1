Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D2241686;
	Tue, 28 Jul 2026 00:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198969; cv=none; b=J+24j5YQyyYnC2dYepxV/IMbWQnS0raddxRRlfHQiRlx1rvCbmQQ18DbAtvodG17CDCEL9v/SPA9vSKMaJI/klD8brzlfumYxcENCyBfT1JgmP3Yfge/ZUIpbtkOF7aD28JAbWtgr5bYPK/7Bkr/cOGPSNHBOtBgGC5PJ9hySyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198969; c=relaxed/simple;
	bh=Ma4mhERhzrmYpy8AcXz3D2LoFRj6xeh7pYuDmGlNEXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImzXFXYgHFOcn1qvba+MkijVEWZMMOqrH2v/4AXtFWXCZkkF5qeKT0dL7G/f/l+QX3seECoWzi495y0Wlk7ksVkno9iZX1qGdIeuF5Ul9x4kXevMcTkyWrVoec1JPCZXNlH87a4B3UjvmCvzPSkiUicZDpmq945k6LFr43WcpZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=genejh9A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="genejh9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7651F00A3E;
	Tue, 28 Jul 2026 00:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198967;
	bh=k9v6Hm4ixmSTHOV5vXvJJOCPlIo3vm3tSbopagholGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=genejh9Al2251BHs5NGCDnH7Gme6LOv06i9sQBblhdBIxkX4raevb+NJlA8riOThJ
	 o/R8a1YNCCof7949ATlS/HQPVStW6JrN6Nyy/8IE66DfSxc77YWraUaaM5s5jQN4Wj
	 +i+Y+oODOmsHnnFuaWByxQwOxo2iiFTmnzljRmvpljO04T0pPU++5IanFACnaoa1La
	 +2G9xcSsIlIej5lxlkRrkBNA/F/57xAlNGKoYF+AXSaJ7KsQdnn5iXd2vQnrl3j96x
	 byVeIiAkjxestDyBxQRFgxKopkRtwPnxszIbGh37Y2jIs9c9Fg+ANTMaJJ22wyvimm
	 IdHrvuSrD68QA==
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
Subject: [PATCH v1 07/28] KVM: SVM: Duplicate pre-run ASID check for SEV and non-SEV guests
Date: Tue, 28 Jul 2026 00:35:36 +0000
Message-ID: <20260728003557.1136583-8-yosry@kernel.org>
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

In preparation for dropping the check separately for SEV and non-SEV
VMs, duplicate the check between pre_sev_run() and pre_svm_run() (for
the non-SEV code path).

Opportunistically drop the unconditional dirtying of VMCB_ASID, as it's
only needed when the ASID is actually updated in the VMCB, not when
TLB_CONTROL is updated (as the code currently reads).

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 6 +++++-
 arch/x86/kvm/svm/svm.c | 9 +++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d1f0e42c72b27..0e5046a12a970 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3583,6 +3583,11 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 	/* Assign the asid allocated with this SEV guest */
 	svm->asid = asid;
 
+	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
+		svm->vmcb->control.asid = asid;
+		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
+	}
+
 	/*
 	 * Flush guest TLB:
 	 *
@@ -3595,7 +3600,6 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 
 	sd->sev_vmcbs[asid] = svm->vmcb;
 	vmcb_set_flush_asid(svm->vmcb);
-	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index aff1aae5a5a32..b8f3f71f70673 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3779,6 +3779,11 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
 	if (svm->current_vmcb->asid_generation != sd->asid_generation)
 		new_asid(svm, sd);
 
+	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
+		svm->vmcb->control.asid = svm->asid;
+		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
+	}
+
 	return 0;
 }
 
@@ -4515,10 +4520,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	sync_lapic_to_cr8(vcpu);
 
-	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
-		svm->vmcb->control.asid = svm->asid;
-		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
-	}
 	svm->vmcb->save.cr2 = vcpu->arch.cr2;
 
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS) &&
-- 
2.55.0.229.g6434b31f56-goog

