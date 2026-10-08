Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD12DEA68;
	Thu,  8 Oct 2026 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418486; cv=none; b=FR74QIwCKOEyyAfivpoPbut10k9+IFq+UMBKzWdEZ/u0OKyEeYnPCPLOLKzrFZsiVodxK9z+8llPjPhfQ0rre2wj2zsc6bwcU81/4y2q0qLXeR8VRtbjUauixkzOxo+Cc3fW9MMjtU9ZYk/d9OUmo10lw9Q99p+folE0zMmTO8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418486; c=relaxed/simple;
	bh=SMHv5knt/Ypn+HmGkDfmMbbYLYOzQzGKGBd/FiWKK5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKZayy1kEBnC4COXofDizIvWi/MtBDneI9PqjyQqnJxtzdnIlS3C7qNNqWz/+8DUz1mDP923acwX6VrnbYgPjq59npoBKyQ41FmY2mtVxOR/bj1AajsKZOcncxmkJCXgou+qINO/HbBoBkJ7/4kLclxXGQQM46KDmCT0IT7gK8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+XvaaC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+XvaaC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3215C1F00899;
	Thu,  8 Oct 2026 00:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418484;
	bh=NvhBozTl+qNPkMjGpDr8YV6psYpFV/V1p/Rb0CUCFcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b+XvaaC86/k6ZxuDcNOZBhZoxO/7xCYMSpTS5F/Gr9fq/MyUmOmUjBr3TyiQgY43G
	 cSz9TppuDL8/oGXMrdNovzSAxC8YR0B4AntDVHO4mj7+CqMWEsmMGt/c4HpC4BwlvI
	 nlWpFqH40a877vn3gvBRKInUaJj8DWPWIUDXoxpg5/A4wD0E22/4yjrc4UO6Qk1fmz
	 MbXaHY3hh3T/EkbBpfCKRA7tGwGaJI4ImxgRCei5W/RTn/xX+mogsrjtEgOMHXe3YP
	 8FLOFSBkz8irqK9jTdIiNdektZSCNULSYCpbFFmTfMLVURQqxQko5poaMt6eHOeonk
	 mftTvf3bOu21Q==
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
Subject: [PATCH v2 11/29] KVM: SVM: Only flush the fallback ASID when used by a different vCPU
Date: Thu,  8 Oct 2026 00:14:07 +0000
Message-ID: <20261008001425.2458927-12-yosry@kernel.org>
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
index 8f27722bc4faf..0dbb1962d32b6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1405,6 +1405,8 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	struct svm_cpu_data *sd;
+	int cpu;
 
 	WARN_ON_ONCE(!list_empty(&svm->ir_list));
 
@@ -1422,6 +1424,11 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 	svm_vcpu_free_msrpm(svm->msrpm);
 
 	free_asid(svm->asid);
+
+	for_each_possible_cpu(cpu) {
+		sd = per_cpu_ptr(&svm_data, cpu);
+		cmpxchg(&sd->fallback_asid_vcpu, vcpu, NULL);
+	}
 }
 
 #ifdef CONFIG_CPU_MITIGATIONS
@@ -3868,6 +3875,7 @@ static void svm_set_nested_run_soft_int_state(struct kvm_vcpu *vcpu)
 
 static int pre_svm_run(struct kvm_vcpu *vcpu)
 {
+	struct svm_cpu_data *sd = this_cpu_ptr(&svm_data);
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	/*
@@ -3884,8 +3892,11 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
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
index 53c5ed2d93d91..d386f2a4f72d7 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -377,6 +377,9 @@ struct svm_cpu_data {
 	struct vmcb *save_area;
 	unsigned long save_area_pa;
 
+	/* Last vCPU to use fallback_asid on this CPU */
+	struct kvm_vcpu *fallback_asid_vcpu;
+
 	/* index = sev_asid, value = vmcb pointer */
 	struct vmcb **sev_vmcbs;
 };
-- 
2.56.0.360.g66cac248cb-goog

