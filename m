Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6300C4503FF;
	Wed,  5 Aug 2026 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927848; cv=none; b=ATdyR8trI1E3f+udL0iH7qonBAvDiuXHO8n4Ie2NjiHYxwlPYSnhc9O0ykimbEKzBNoj11rNeuNySI/phY1HTThmZj/640QOimt1l8EMWo3/YY4l3XZrMf/9946/SLgdEjQODAWZwgHC4Ch+BK6cdW1pQ6CJB7NOnpzgGLN+LVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927848; c=relaxed/simple;
	bh=kpkgZl0Tcw92oo543975qMU66f9hJ6QM9ee1afXBaws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdCdXcgAtqmOPdhHooXaF+BbyW8RTrAgYZeaY3sPPjT7SJSEzp/P3Pu20t1l0cwQnV3eepjJBgyPKNKD7PXK9t8Q6z0GUnPMg8Z1sD06gmfbtpSH9F/oBFBqQZuN9USCEZpoV+MdNBjWSLm7l7hdAgKc07WFvnV61Gu9D1lnQF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Cf3aD486; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Cf3aD486"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 871C420B716B;
	Wed,  5 Aug 2026 04:03:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 871C420B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927825;
	bh=m4DXXDJSWrtuCFV6AD4mQm8ZCb5skNiU0wv/knEqjsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cf3aD486bf0MQTJDeii5vYS8j3k5l8EsuGlzg38ch2TmPmq/NtypvT9PxXDjT4QvO
	 8fU/Y57P59/iBcJ1AunXewWG9wJFwITnkNVEM1nmlOivyInmTvSEwOQcPTSdF/N4sO
	 94gYroOQvmAGaG7dtuA6y9K/CyMP0w0EnJvfSc2E=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 27/42] KVM: planes: add arch-neutral in-kernel plane switch helper
Date: Wed,  5 Aug 2026 04:03:09 -0700
Message-ID: <20260805110324.25067-28-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor the in-kernel plane switch out of the SEV-SNP VMPL path into a
generic kvm_vcpu_switch_plane(). Both vCPUs share the same vcpu->common,
so the switch only validates the sibling relationship, flips the
per-plane runnable/stopped state, and returns 1 to keep the caller
inside KVM_RUN; the run loop then re-selects the target plane via
kvm_vcpu_select_plane().

This is the common core shared by all secure-plane backends (SEV-SNP
VMPL today, VBS/VTL next); vendor-specific state preparation stays in
the caller. Convert __sev_snp_run_vmpl() to use it.

Signed-off-by: Sriram Nambakam <snambakam@linux.microsoft.com>
---
 arch/x86/kvm/svm/sev.c   | 13 ++++++-------
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 27 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 53e76d22eb08..b9b0bbb72394 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4507,21 +4507,20 @@ static int __sev_snp_run_vmpl(struct vcpu_svm *svm, unsigned int vmpl)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct kvm_vcpu *target = vcpu->common->vcpus[vmpl];
-	struct vcpu_svm *target_svm = to_svm(target);
+	struct vcpu_svm *target_svm;
 
 	if (!target)
 		return -EINVAL;
 
-	/* Mark current plane as stopped so it is not selected */
+	target_svm = to_svm(target);
+
+	/* SEV-specific preparation for the target VMPL before switching. */
 	kvm_set_mp_state(target, KVM_MP_STATE_RUNNABLE);
 	/* In case KVM_REQ_UPDATE_PROTECTED_GUEST_STATE is set - mark the new VMSA as runnable */
 	target_svm->sev_es.snp_ap_runnable = true;
-	kvm_vcpu_set_plane_runnable(target);
-	kvm_vcpu_set_plane_stopped(vcpu);
-
-	kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
 
-	return 1;
+	/* Perform the arch-neutral in-kernel plane switch. */
+	return kvm_vcpu_switch_plane(vcpu, target);
 }
 
 static int sev_snp_run_vmpl(struct vcpu_svm *svm)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 82e557e66152..c6cf2b6c0076 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -455,6 +455,7 @@ struct kvm_vcpu {
 
 void kvm_vcpu_set_plane_runnable(struct kvm_vcpu *vcpu);
 void kvm_vcpu_set_plane_stopped(struct kvm_vcpu *vcpu);
+int kvm_vcpu_switch_plane(struct kvm_vcpu *vcpu, struct kvm_vcpu *target);
 struct kvm_vcpu *kvm_vcpu_select_plane(struct kvm_vcpu *vcpu);
 
 static inline bool kvm_vcpu_wants_to_run(struct kvm_vcpu *vcpu)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9623ab8ebd9e..553c282500fd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5039,6 +5039,33 @@ void kvm_vcpu_set_plane_stopped(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_set_plane_stopped);
 
+/*
+ * Switch the logical CPU from the currently-running plane (@vcpu) to a sibling
+ * plane (@target) without leaving KVM_RUN.  Both vCPUs share the same
+ * vcpu->common, so this only flips the per-plane runnable/stopped state and
+ * requests a plane reschedule; the run loop in kvm_arch_vcpu_ioctl_run() then
+ * re-selects @target via kvm_vcpu_select_plane() and re-enters the guest.
+ *
+ * This is the arch-neutral core of the in-kernel plane switch shared by all
+ * secure-plane backends (SEV-SNP VMPL, VBS/VTL on Intel and AMD, and, in the
+ * future, Arm stage-2).  Any vendor-specific state preparation must be done by
+ * the caller before invoking this helper.
+ *
+ * Returns 1 to keep the caller inside KVM_RUN, or -EINVAL if @target is not a
+ * valid sibling plane of @vcpu.
+ */
+int kvm_vcpu_switch_plane(struct kvm_vcpu *vcpu, struct kvm_vcpu *target)
+{
+	if (!target || target->common != vcpu->common)
+		return -EINVAL;
+
+	kvm_vcpu_set_plane_runnable(target);
+	kvm_vcpu_set_plane_stopped(vcpu);
+
+	return 1;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_switch_plane);
+
 struct kvm_vcpu *kvm_vcpu_select_plane(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_common *common = vcpu->common;
-- 
2.55.0

