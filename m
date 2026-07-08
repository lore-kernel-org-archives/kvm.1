Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C63CA4A0;
	Wed,  8 Jul 2026 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492443; cv=none; b=blIwwV55GziO+vnBt32jrEbgPjLDOLnZ/UOQbyNT6H347uXV/R0QmQv4OcZ+6DD39MOufCZpJgAWKPnUoA+bnEJPNn8+DKDi/gHoHeZZRfrxvle2IMOHJLkzxicorfgkvuQmVW2SNhYMgeXlQ6r3VhfYtRkJO5VnGXK3+Ydv6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492443; c=relaxed/simple;
	bh=kkl2j1ifC5EwIzph/XAZEspARp/aZtXExVMSbZCGhXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZ3lMnDJ6OVOIhgOQVlALj6QPpHH79ZF3UweuY0hAam/BTCc0oQI3mZBHRbNFnFvfchi/y7xXO0w7Y6x14nolT/rrRPHDLeMPIZ4BQN2Th3au6/kkMg5qypcHgm6UcX1hOvS7mH1PnRPrMDc5Rbd1WUjzT9xptSqC0ZagsMyhGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfdH6RQi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfdH6RQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591231F000E9;
	Wed,  8 Jul 2026 06:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492442;
	bh=SZO46gkvzvid8cKdahMtEhu9Hg2pL7KH50D9Hy+W7MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gfdH6RQi6vqk0qfsksQ5Xvhak/yeE+MYmB1HY0093+vz1Uq7eou0sZ+jSRz67OyMe
	 H2OqCmGbw/SnwGI6PdRGGvJNsV4gv/7zaje5QuGjrlgb4X/3oyyqgeuQEEp+Ebje9w
	 N5E50P5vHrTNaiFbnw46uF+JB7S5tgbeDViuLzGj6UBlur7HKLZ9Kp36nwkPQg0hYh
	 UCEYHuaetseEa2r4dtUAkuSOmFzlXxpgxR/nTCaE/uwwz8OJp9+295z1MfXlwwlfwg
	 9COdMRXEl9cXvkTh0xZPqTTaTwUpODxs7O9VGJB0+QxvCQF5c9dEWAcvyAzgbfLwol
	 BMzL3sM0QgALQ==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 11/27] KVM: SVM: Disable IPIv for Secure AVIC
Date: Wed,  8 Jul 2026 12:02:09 +0530
Message-ID: <1f1ce337c90819fe97b8108ac4c078dc8fd176d2.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Secure AVIC does not have IPI virtualization (except for Self-IPIs which
is not relevant for KVM), i.e., guest ICR writes are not accelerated by
the hardware but results in a #VC that the guest is expected to handle
with the help of the hypervisor. This also means there are no AVIC
Physical/Logical ID tables to be setup.

Add a helper avic_ipiv_is_supported() to query support for IPIv and use
the same to short-circuit various AVIC flows related to AVIC data
structures such as the Physical and Logical ID tables for Secure AVIC.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/svm.h  |  1 +
 arch/x86/kvm/svm/avic.c | 23 ++++++++++++++++++++++-
 arch/x86/kvm/svm/sev.c  |  4 +++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 1157d022bac1..e48744f6d756 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -131,6 +131,7 @@ struct kvm_svm {
 	u32 *avic_logical_id_table;
 	u64 *avic_physical_id_table;
 	struct hlist_node hnode;
+	bool avic_ipiv_is_not_supported;
 
 #ifdef CONFIG_KVM_AMD_SEV
 	struct kvm_sev_info sev_info;
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index c9e375c5a9c1..0a4e91e15e74 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -76,6 +76,12 @@ static bool avic_ipiv_is_soft_disabled(void)
 	return !enable_ipiv;
 }
 
+/* IPIv is not supported in Secure AVIC mode, no AVIC tables necessary */
+static bool avic_ipiv_is_supported(struct kvm *kvm)
+{
+	return !to_kvm_svm(kvm)->avic_ipiv_is_not_supported;
+}
+
 static int avic_param_set(const char *val, const struct kernel_param *kp)
 {
 	if (val && sysfs_streq(val, "auto")) {
@@ -364,7 +370,7 @@ int avic_vcpu_precreate(struct kvm *kvm)
 {
 	int r;
 
-	if (!irqchip_in_kernel(kvm) || WARN_ON_ONCE(!enable_apicv))
+	if (!irqchip_in_kernel(kvm) || WARN_ON_ONCE(!enable_apicv) || !avic_ipiv_is_supported(kvm))
 		return 0;
 
 	/*
@@ -435,6 +441,9 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	u32 id = vcpu->vcpu_id;
 	u64 new_entry;
 
+	if (!avic_ipiv_is_supported(vcpu->kvm))
+		return 0;
+
 	/*
 	 * Inhibit AVIC if the vCPU ID is bigger than what is supported by AVIC
 	 * hardware.  Immediately clear apicv_active, i.e. don't wait until the
@@ -1069,6 +1078,9 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 
 	lockdep_assert_preemption_disabled();
 
+	if (!avic_ipiv_is_supported(vcpu->kvm))
+		return;
+
 	if (WARN_ON(h_physical_id & ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
 		return;
 
@@ -1113,6 +1125,9 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
+	if (!avic_ipiv_is_supported(vcpu->kvm))
+		return;
+
 	/*
 	 * No need to update anything if the vCPU is blocking, i.e. if the vCPU
 	 * is being scheduled in after being preempted.  The CPU entries in the
@@ -1135,6 +1150,9 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 
 	lockdep_assert_preemption_disabled();
 
+	if (!avic_ipiv_is_supported(vcpu->kvm))
+		return;
+
 	if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >=
 			 PAGE_SIZE << avic_get_physical_id_table_order(vcpu->kvm)))
 		return;
@@ -1185,6 +1203,9 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	 */
 	u64 entry = to_svm(vcpu)->avic_physical_id_entry;
 
+	if (!avic_ipiv_is_supported(vcpu->kvm))
+		return;
+
 	/*
 	 * Nothing to do if IsRunning == '0' due to vCPU blocking, i.e. if the
 	 * vCPU is preempted while its in the process of blocking.  WARN if the
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a47bb417bd98..a12e7e9f9fa1 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -566,8 +566,10 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 	INIT_LIST_HEAD(&sev->mirror_vms);
 	sev->need_init = false;
 
-	if (snp_is_secure_avic_enabled(kvm))
+	if (snp_is_secure_avic_enabled(kvm)) {
 		kvm->arch.apicv_has_irq_bypass = false;
+		to_kvm_svm(kvm)->avic_ipiv_is_not_supported = true;
+	}
 
 	kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV);
 
-- 
2.54.0

