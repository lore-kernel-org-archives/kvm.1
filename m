Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7450D3E95A8
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417032; cv=none; b=RJ342IeOr0q/VtqZTGNnINF5pAUIFyQb1G+Ssqk7NCyYW2pWq0WeJoM6PbVkc+hPV/XXo0gzObeoVb53kVEfwtK+ELMqo4gODd56BebUF2nMa2tLRbZS8VoamzLiXeDVpLZhN9T6jwYZ935ZBlNaw0XneqIG/+Z3XWabrKPA3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417032; c=relaxed/simple;
	bh=upgAS3QhbwQDYrLzViBQS9u/HOQy6d6rM9ummlMmTu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jneeogFp0J24H+lmZVnArC4xrC79ypUKCn2Y2gjnSCM/Y/fiBaMKZeXG8lhGiRTEsHve8A2OK8jncFb722QMStD0JBViI2K2+18N0apxGl5oXNbJfQoRp+Z9LYppVLlUStNq1y12lj/ZCmjPfvXFhhSsbdTo36kTH4cg5EVJMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oktMOJGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oktMOJGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582B21F000E9;
	Thu,  3 Sep 2026 06:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788417028;
	bh=k6HirYOPwhnvcG/G1JkXkI1vcjpTLFmc+EprWnm3IWU=;
	h=From:To:Cc:Subject:Date;
	b=oktMOJGkIKPiYZV5yPiNcQpj2FkN/CZUnRgqVwgOUZT03wk8RFdrlWtw/Rvhe8KNq
	 ypwBJP0lZn2yo6kzVclvWZfw/ggNKv3rVU09NUMLunn0VY7BTq7ySnu8TQ3DNx/bOx
	 jRfLbBgIOU9Kh1nbk5E5UHadfqSkRxr2CAniDdW3nyd34XX3jLlYiAIzRqxPDILrtn
	 t1BrppAVYABWlSXCXzEiKNRxM6iaou8bTrcg6dP6iUSkr2JHj/aA6zhKG3w3s5QfCZ
	 0K1yPSa/0vLMas6NLq0dTgDyr212uNs63pgbJ7iiV7gmqqhD1UPH8FmRZySGR7S6m0
	 8xtZlVNego1yQ==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: <kvm@vger.kernel.org>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH] KVM: SVM: Clear AVIC Physical ID table entry if vCPU creation fails
Date: Thu,  3 Sep 2026 11:58:56 +0530
Message-ID: <20260903062856.2090499-1-naveen@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If vCPU creation fails after kvm_arch_vcpu_create(), the AVIC Physical
ID table entry corresponding to that vCPU continues to point to the
freed APIC backing page which can result in UAF. Address this by
clearing out the corresponding AVIC Physical ID table entry in the
vcpu_free() callback, similar to the VMX commit b41f2ca6c060 ("KVM: VMX:
Fix stale PID-pointer table entry left after vCPU free").

Though unlikely, it is also possible that svm_vcpu_create() itself fails
after the AVIC Physical ID table entry has been setup if memory
allocation fails in svm_vcpu_alloc_msrpm(). Clear the entry in this path
as well.

Note: this change depends on commit 97d65b544f48 ("KVM: Check for
duplicate vcpu_id as early as possible"), which ensures that a vCPU with
a duplicate ID is never created. Otherwise, a valid AVIC Physical ID
table entry for an existing vCPU will be cleared.

Fixes: 44a95dae1d22 ("KVM: x86: Detect and Initialize AVIC support")
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/svm.h  |  1 +
 arch/x86/kvm/svm/avic.c | 10 ++++++++++
 arch/x86/kvm/svm/svm.c  |  6 +++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e958943b8162..790bd96a9791 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -954,6 +954,7 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb);
 int avic_incomplete_ipi_interception(struct kvm_vcpu *vcpu);
 int avic_unaccelerated_access_interception(struct kvm_vcpu *vcpu);
 int avic_init_vcpu(struct vcpu_svm *svm);
+void avic_vcpu_free(struct kvm_vcpu *vcpu);
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void avic_vcpu_put(struct kvm_vcpu *vcpu);
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 3b037e385523..bc2c699380b3 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -885,6 +885,16 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	return ret;
 }
 
+void avic_vcpu_free(struct kvm_vcpu *vcpu)
+{
+	u32 max_id = x2avic_enabled ? x2avic_max_physical_id : AVIC_MAX_PHYSICAL_ID;
+	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
+	u32 id = vcpu->vcpu_id;
+
+	if (kvm_svm->avic_physical_id_table && id <= max_id)
+		WRITE_ONCE(kvm_svm->avic_physical_id_table[id], 0);
+}
+
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 {
 	avic_handle_dfr_update(vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ea647938a2a6..c2a2ae7d8ec3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1337,7 +1337,7 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 	svm->msrpm = svm_vcpu_alloc_msrpm();
 	if (!svm->msrpm) {
 		err = -ENOMEM;
-		goto error_free_sev;
+		goto error_free_avic;
 	}
 
 	svm->x2avic_msrs_intercepted = true;
@@ -1351,6 +1351,8 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 
 	return 0;
 
+error_free_avic:
+	avic_vcpu_free(vcpu);
 error_free_sev:
 	sev_free_vcpu(vcpu);
 error_free_vmcb_page:
@@ -1365,6 +1367,8 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 
 	WARN_ON_ONCE(!list_empty(&svm->ir_list));
 
+	avic_vcpu_free(vcpu);
+
 	svm_leave_nested(vcpu);
 	svm_free_nested(svm);
 

base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0

