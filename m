Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C103DA7D6;
	Wed,  8 Jul 2026 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492468; cv=none; b=SomU17zr/zHFPQ1Tp2Y7/m1/GLCGCDimSBCOor6FRgDB42xaO4JcUIiNMOKd0JJmgNb63mumSHNhoRAW9FZ1lSVqA3qlZIiALydqOksKM8zqmNooWz3tVo4lKoTixyd2ObeMUDUQlKtjrGXtRAUB/lIiXrPLriJiR6KFHVMXZig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492468; c=relaxed/simple;
	bh=g2Q08i70jbOV6/cp8zvD7tr2iSr8DM+L627LKe16T88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ob7wewwcpaa9RAGSVDXUET75nIOunXkyvCc01fKBIYU63jz84mwxWMF0wuwN0k/Zcl7fS0sZ4MMbJhm0Br+83jGpPuDlrPkb71/676+wnBBOyxEgHoJtAOhro1N7hvd1l9Yqkbees+XG0IfrTPwGS/pwATqN5HcQff8dfUjdcKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvNpqCAL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvNpqCAL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A43A1F00A3A;
	Wed,  8 Jul 2026 06:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492464;
	bh=xJu/hIfe1SmrMyu6fpjnNeLcbmrq/bbgkLy0QgkRH10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PvNpqCALhEOeHGzkW1o4zpXpYOyTVj0CjYgbWNPjkp3k89vPsg25Knvz+W2V/h8PN
	 9/nCE+aABJs2T7W89DXPpmdEpqGWEeaqqmjWrXT2r7ojLiMAoAxPbt2nQ1VmTJmxew
	 zohyfw5I3mQOpJrgC/HM40C6uPipKNsMijijKLfIe9mjLef1uVA4tAdgFuOE9RTDOt
	 QwOSNm4zHpbiG+lmCsgNibbuvK86xFLnhbKm9cKqpc/LCDszimBUTkPWHgUfaOEllR
	 K3RPQXAY9kfNZUNaCO2ze+B0f9HStCjHLGlmnJ/d/lf9BwmxRoNvcOhHzOhFBiakrm
	 8BMRQTWWg0PIw==
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
Subject: [RFC PATCH v3 16/27] KVM: SVM: Add handler for VMGEXIT Secure AVIC NAE event
Date: Wed,  8 Jul 2026 12:02:14 +0530
Message-ID: <c0f9fdc27f3d9a1e63f2d39a40989d66b6facee3.1783490022.git.naveen@kernel.org>
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

From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

[DO NOT MERGE]

VMGEXIT Secure AVIC NAE event is used by the guest for two purposes
determined by VMCB->EXITINFO1:
1. SVM_VMGEXIT_SAVIC_REGISTER_GPA: Used to inform the hypervisor about
   the GPA of the page (RBX) being used as the Secure AVIC backing page.
   RAX indicates APIC ID of the target vCPU (-1 for self)
2. SVM_VMGEXIT_SAVIC_UNREGISTER_GPA: Used to inform the hypervisor that
   the GPA is no longer being used as the backing page for Secure AVIC.
   The previously registered GPA for the Secure AVIC backing page is
   returned by the hypervisor to the guest.

The primary motivation behind these is to ensure that Secure AVIC
hardware accesses to the guest APIC backing page never generate an #NPF,
since Secure AVIC hardware cannot recover from such faults. Quoting the
APM:
  "It is required that the guest APIC backing page for a vCPU is
   pinned in system memory between VMRUN and VMEXIT because some AVIC
   hardware acceleration sequences may not be restartable when secure
   AVIC is enabled. If an access to the guest's own backing page by
   AVIC hardware results in a nested page fault, EXITINFO1 bit 63
   (Not Restartable) is set (this is an Automatic Exit) and the BUSY
   bit in the VMSA is set."

A guest vCPU that has the BUSY bit set in the VMSA cannot be restarted
and the guest will have to be killed.

One of the main reasons why the SPTE for a Secure AVIC backing page may
be invalidated is if it is backed by a huge page in the host, and an
adjacent page changes state forcing the huge page to be split. Currently
though, KVM uses guest_memfd to back SEV-SNP guest private memory, and
those only use 4k pages. As such, this _may_ not be an issue today.

It is possible that KVM may still invalidate an SPTE for other reasons -
those will need to be addressed.

Co-developed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Co-developed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/include/uapi/asm/svm.h |  1 +
 arch/x86/kvm/svm/svm.h          |  2 +
 arch/x86/kvm/svm/sev.c          | 68 +++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 010a45c9f614..e8531a9d998d 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -245,6 +245,7 @@
 	{ SVM_VMGEXIT_GUEST_REQUEST,	"vmgexit_guest_request" }, \
 	{ SVM_VMGEXIT_EXT_GUEST_REQUEST, "vmgexit_ext_guest_request" }, \
 	{ SVM_VMGEXIT_AP_CREATION,	"vmgexit_ap_creation" }, \
+	{ SVM_VMGEXIT_SAVIC,		"vmgexit_secure_avic" }, \
 	{ SVM_VMGEXIT_HV_FEATURES,	"vmgexit_hypervisor_feature" }, \
 	{ SVM_EXIT_ERR,         "invalid_guest_state" }
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e48744f6d756..5e9496f8566a 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -367,6 +367,8 @@ struct vcpu_svm {
 
 	/* Guest GIF value, used when vGIF is not enabled */
 	bool guest_gif;
+
+	gpa_t snp_savic_gpa;
 };
 
 struct svm_cpu_data {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f5b9ff69dbc1..ca921a185b64 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3474,6 +3474,13 @@ static bool sev_es_are_required_ghcb_fields_valid(struct vcpu_svm *svm)
 	case SVM_VMGEXIT_MMIO_WRITE:
 	case SVM_VMGEXIT_PSC:
 		return kvm_ghcb_sw_scratch_is_valid(svm);
+	case SVM_VMGEXIT_SAVIC:
+		if (!kvm_ghcb_rax_is_valid(svm) ||
+		    (control->exit_info_1 == SVM_VMGEXIT_SAVIC_REGISTER_GPA &&
+		     !kvm_ghcb_rbx_is_valid(svm)))
+			return false;
+
+		return true;
 	default:
 		return true;
 	}
@@ -4420,6 +4427,57 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 	return 0;
 }
 
+static int sev_handle_savic_vmgexit(struct vcpu_svm *svm)
+{
+	struct kvm_vcpu *target_vcpu;
+	u64 apic_id;
+	gpa_t gpa;
+
+	apic_id = kvm_rax_read_raw(&svm->vcpu);
+	if (apic_id != SVM_VMGEXIT_SAVIC_SELF_GPA && upper_32_bits(apic_id))
+		goto vmgexit_err;
+
+	/* Use invoking vCPU if apic_id is -1 (SVM_VMGEXIT_SAVIC_SELF_GPA) */
+	target_vcpu = &svm->vcpu;
+	if (apic_id != SVM_VMGEXIT_SAVIC_SELF_GPA) {
+		target_vcpu = kvm_get_vcpu_by_id(svm->vcpu.kvm, (int)apic_id);
+		if (!target_vcpu)
+			goto vmgexit_err;
+	}
+
+	switch (svm->vmcb->control.exit_info_1) {
+	case SVM_VMGEXIT_SAVIC_REGISTER_GPA:
+		gpa = kvm_rbx_read_raw(&svm->vcpu);
+		if (!PAGE_ALIGNED(gpa))
+			goto vmgexit_err;
+
+		/*
+		 * TODO: Ensure that guest (Secure AVIC hardware) accesses
+		 * to the guest APIC backing page can never cause an #NPF.
+		 */
+
+		/*
+		 * Don't bother using any synchronization here if updating the
+		 * GPA for a different vCPU. If the guest is invoking this for
+		 * a specific vCPU in parallel, then it gets to keep the pieces.
+		 */
+		to_svm(target_vcpu)->snp_savic_gpa = gpa;
+		break;
+	case SVM_VMGEXIT_SAVIC_UNREGISTER_GPA:
+		kvm_rbx_write_raw(&svm->vcpu, to_svm(target_vcpu)->snp_savic_gpa);
+		to_svm(target_vcpu)->snp_savic_gpa = 0;
+		break;
+	default:
+		goto vmgexit_err;
+	}
+
+	return 1;
+
+vmgexit_err:
+	svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+	return 1;
+}
+
 static bool is_snp_only_vmgexit(u64 exit_code)
 {
 	switch (exit_code) {
@@ -4427,6 +4485,7 @@ static bool is_snp_only_vmgexit(u64 exit_code)
 	case SVM_VMGEXIT_GUEST_REQUEST:
 	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
 	case SVM_VMGEXIT_PSC:
+	case SVM_VMGEXIT_SAVIC:
 		return true;
 	default:
 		return false;
@@ -4490,6 +4549,13 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
+	if (control->exit_code == SVM_VMGEXIT_SAVIC && !snp_is_secure_avic_enabled(vcpu->kvm)) {
+		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx is only valid if Secure AVIC is enabled\n",
+			    control->exit_code);
+		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_EVENT);
+		return 1;
+	}
+
 	if (!sev_es_are_required_ghcb_fields_valid(svm)) {
 		/*
 		 * Print the exit code even though it may not be marked valid
@@ -4610,6 +4676,8 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 
 		return snp_handle_ext_guest_req(svm, control->exit_info_1,
 						control->exit_info_2);
+	case SVM_VMGEXIT_SAVIC:
+		return sev_handle_savic_vmgexit(svm);
 	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
 		/*
 		 * Note, the _guest_ is reporting an unsupported #VC, i.e. this
-- 
2.54.0

