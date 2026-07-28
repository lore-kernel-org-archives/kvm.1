Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD4E279329;
	Tue, 28 Jul 2026 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198970; cv=none; b=jKyKh7IoU7FzyvmfWevm8n3LddLOEdY2RbYL5KwgV8Iczb/h5XkkTCeRnBZT+hX1SJfd8b5c8T+kGaPH+qeoFMbdJkFpmenOYBYvBL9lxd2s6WIG2nYgKHNHyRdWGRtMNUbO3IS7lFamjJaP7HeftCr6endctdsuVMCtRs4wJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198970; c=relaxed/simple;
	bh=L1S/+ZMAZfC6V9tQKfVBvG0LiDACK1yxUK7HR4BlbRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtBiOsC0lKS7QKCy9q+Af9i5ia08kYDM3Q3eTSIOWxUeUVXrA7fptmkx0b3Pdm3XcBbt8rvUSuS6G9zkZN60gTXUB/Up+LCE858FEw/h151kbvwirZMvQdQwRlqPW5g0UBg4xCEUfymtGVCEeS1sNZH9Es0R9bWE/yA6tpx6nMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afKNumb2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afKNumb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B866D1F00A3D;
	Tue, 28 Jul 2026 00:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198969;
	bh=iUMlpHqGz2KuoZ8oob+EZjkvMx/XMFzf/Po20cxPt4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=afKNumb2+b/Adw7n7ZMpInYWl28DSLyC4oecE9dyud871q/UJA6vtb+06/7jBm/l7
	 kZHFsihcpj/dSaCLR0VFprWum/mmGpDwfIk8FzHxWu2zc9Gk2Uzqafn+9ikp8XGRLB
	 Or28o01kRtAtI3hGN3pckBbCE0VJFp2OtHl4pWFrPsF/LgeabDkRCryqGFfQG6s3ss
	 f/mZNaSBu32KkEIoZJ3rYeCYUiGgqDWpzHUVkevLvlr+eguqmDgdnmDGFrDYjIDDcw
	 DnJ4Z5P8VWeI9HugZC8PLL5L/Vq4bz9ZMEK+hIrUtUDPfYHU2fV1Y8c7EE95o36Wp5
	 pez9r20n7mKGQ==
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
Subject: [PATCH v1 11/28] KVM: SVM: Only flush the fallback ASID when used by a different vCPU
Date: Tue, 28 Jul 2026 00:35:40 +0000
Message-ID: <20260728003557.1136583-12-yosry@kernel.org>
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

Instead of always flushing the fallback ASID on every vCPU run, only
flush it if the last vCPU that used it on the pCPU changes. This avoids
constant TLB flushing on a vCPU using the fallback ASID if no other
vCPUs that use the same ASID ran on the same pCPU.

Note that checking (and flushing) the current ASID on vCPU load is not
sufficient, as it is possible that a vCPU is using the fallback ASID
only for L1 or only for L2. To do this correctly on vCPU load, both L1
and L2 ASIDs would need to be checked, and the respective VMCB would
need to be flushed. This would not be much simpler, and would perform
unnecessary flushes in some cases (e.g.  loading a vCPU that uses the
fallback ASID for L2, but L2 doesn't actually run until the vCPU is
unloaded).

Another alternative is always flushing on vCPU load if the current ASID
is the fallback ASID, and flushing on nested transitions if the new ASID
is the fallback ASID. Again, this is not much simpler and also incurs
unnecessary flushes in some cases.

Do the logical thing and track the vCPU using the fallback ASID instead.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 13 ++++++++++++-
 arch/x86/kvm/svm/svm.h |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 31194c773af7c..30a295785c68a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1365,6 +1365,8 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	struct svm_cpu_data *sd;
+	int cpu;
 
 	WARN_ON_ONCE(!list_empty(&svm->ir_list));
 
@@ -1377,6 +1379,11 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 	svm_vcpu_free_msrpm(svm->msrpm);
 
 	free_asid(vcpu, svm->asid);
+
+	for_each_possible_cpu(cpu) {
+		sd = per_cpu_ptr(&svm_data, cpu);
+		cmpxchg(&sd->fallback_asid_vcpu, vcpu, NULL);
+	}
 }
 
 #ifdef CONFIG_CPU_MITIGATIONS
@@ -3755,6 +3762,7 @@ static void svm_set_nested_run_soft_int_state(struct kvm_vcpu *vcpu)
 
 static int pre_svm_run(struct kvm_vcpu *vcpu)
 {
+	struct svm_cpu_data *sd = this_cpu_ptr(&svm_data);
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	/*
@@ -3771,8 +3779,11 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
 	if (is_sev_guest(vcpu))
 		return pre_sev_run(svm, vcpu->cpu);
 
-	if (unlikely(svm->vmcb->control.asid == fallback_asid))
+	if (unlikely(svm->vmcb->control.asid == fallback_asid &&
+		     sd->fallback_asid_vcpu != vcpu)) {
 		vmcb_set_flush_asid(svm->vmcb);
+		sd->fallback_asid_vcpu = vcpu;
+	}
 
 	return 0;
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index a75862e693134..79339ee8a3d56 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -375,6 +375,9 @@ struct svm_cpu_data {
 	struct vmcb *save_area;
 	unsigned long save_area_pa;
 
+	/* Last vCPU to use fallback_asid on this CPU */
+	struct kvm_vcpu *fallback_asid_vcpu;
+
 	/* index = sev_asid, value = vmcb pointer */
 	struct vmcb **sev_vmcbs;
 };
-- 
2.55.0.229.g6434b31f56-goog

