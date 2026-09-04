Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB235A38C;
	Fri,  4 Sep 2026 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489098; cv=none; b=d++hGZQ3Cfk51dP7FSjFNoAHEOEsPJXb+10XILAbckZicEYjYLsaArBCFDyy9nqbK2dkZmFkvIbLtHpuq2nQRHcGNfme/34fdpSQm4xd1TbWBnNfhU5tWRUZGGjxMGz6w3dicsoEMhmg8sX94jWmy3HLEmX+tOccWYWglR29vJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489098; c=relaxed/simple;
	bh=xyyAeImsv/c6zaKPXBbjA79R1V7s/rMIpMqeIvhnIGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V52a7u2+eP/3qBsf4EAWP4extPO2EVAh7+Jg1xUnBo7tg8wXisfo6ePdQp83e3SK5e5UdbCOQk/bPkw2shxIsxkWJewXOiVYCO5QJKu3lFRoG8islo5BUHWB6coASaspewi2nn2tMTWbiUDhZ8hHWh1HJWNxh074a7cKs1vObJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0p8i/L3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0p8i/L3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788489096; x=1820025096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xyyAeImsv/c6zaKPXBbjA79R1V7s/rMIpMqeIvhnIGk=;
  b=R0p8i/L3kHykwN7qqIaM2GsDI0V3SReH++ev+86kuW2YuJZsLequwK2P
   kjuGzGs2EDk4VlEjPa0A3ajOIL/5c+oCHlx4ySO4lzRiAkAqB5nh3WnAO
   lxRYmlQuUb1BU94ADTx91VXG3N4DH+mKtlfcAIokVruVxU8Yau6PXZ2rp
   6BeTRdZxhRo958YeLpnOvunKzpHZQwBn8Cz73nWCsETWZWfFXYBHm7Isv
   WFQHPyoIJiJvNc+XQcYpTtwnTxhvGwRGdyp6mLSToTM7SuuQFV0LN3THu
   MA8fRj2wMh+fYjo+UEQ8qZjXaUTd2xE3/x6OX88SZZHUaqoKHLYoOSilW
   w==;
X-CSE-ConnectionGUID: 7UdPWLcrQ+WL1dMSEiYsiw==
X-CSE-MsgGUID: d8onl97rT/2OQQCSwycgQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="106506746"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="106506746"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:31:35 -0700
X-CSE-ConnectionGUID: /wm2SOTXQN+Fww2QRETqHw==
X-CSE-MsgGUID: cNa97v6VRyGi3U7g4x21VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="270433492"
Received: from zhaoliu1-desk.sh.intel.com ([10.238.208.118])
  by orviesa009.jf.intel.com with ESMTP; 03 Sep 2026 19:31:33 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Chao Gao <chao.gao@intel.com>,
	Xin Li <xin@zytor.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 1/4] KVM: nVMX: Don't copy L2's CET state to L1 if VM-entry didn't load it
Date: Fri,  4 Sep 2026 10:31:02 +0800
Message-Id: <20260904023105.1167376-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904023105.1167376-1-zhao1.liu@intel.com>
References: <20260904023105.1167376-1-zhao1.liu@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a nested VM-exit that disables VM_EXIT_LOAD_CET_STATE, only copy L2's
CET state from vmcs12 to vmcs01 if VM-entry really loaded that state,
i.e. don't copy when VM-entry fails before loading guest state.

The state, that L1 should see after a L2 VM-exit, depends on three
things: the VM-exit load (host state) control, whether VM-entry loaded
L2's state, and whether L2 ran.

For CET, there are 4 cases:

 1) VM_EXIT_LOAD_CET_STATE is set. Load L1's CET state from vmcs12's
    host fields, no matter what happened before. KVM already does this.

 2) VM_EXIT_LOAD_CET_STATE is clear, and VM-entry loaded L2's CET
    state. Whether it's the normal VM-exit or VM-entry failure exit,
    the guest's (L2's) state should be retained, so copy vmcs12's guest
    fields into vmcs01 to give L1 the same result.

 3) VM_EXIT_LOAD_CET_STATE is clear, VM-entry didn't load L2's CET
    state, and L2 never ran. This is the typical case that VM-entry
    fails before loading guest state, the CPU keeps L1's own state, so
    do nothing.

 4) VM_EXIT_LOAD_CET_STATE is clear, VM-entry didn't load L2's CET
    state, but L2 ran and exited normally. The CPU keeps L1's state
    again, but L2 could have changed it while running, so still copy
    vmcs12's guest fields into vmcs01, because they hold what L2 left
    behind.

Case 3) is broken today. When VM-entry fails, KVM copies vmcs12's guest
CET fields into vmcs01 as long as VM_EXIT_LOAD_CET_STATE is clear, so L1
gets the state it wrote for L2 instead of its own state. KVM never syncs
vmcs02 back to vmcs12 on this path, so those guest fields still hold
what L1 wrote with VMWRITE.

To fix case 3), it's necessary to distinguish case 2), case 3) and case
4). But one "VM-entry failed" flag is not enough, since it only tells
whether L2 ran, and lacks the information about whether VM-entry loaded
L2's state - and this is important, EXIT_REASON_MSR_LOAD_FAIL is
triggered after guest state loading, but EXIT_REASON_INVALID_STATE is
not.

Note, SDM vol.3, chapter 29, "VM ENTRIES", does not guarantee the order
of the guest state check and the guest state load, however KVM can more
directly assume that the guest state load occurs after the check,
thereby simplifying the emulation of state handling when
EXIT_REASON_INVALID_STATE occurs (corresponding to Case 3). But MSR list
loading is after guest state loading, so at EXIT_REASON_MSR_LOAD_FAIL,
guest state has been loaded.

Therefore, to determine whether the VM-entry loaded L2's state and
whether L2 ran, introduce the nested_l2_state enumeration to mark the L2
guest state phase, thereby helping to distinguish between Case 2), Case
3), and Case 4) in a helper nested_l2_state_is_live().

This pattern can be reused to support additional features that have load
controls, such as BNDCFGS, PAT, and FRED.

Fixes: 625884996bff ("KVM: nVMX: Prepare for enabling CET support for nested guest")
Reported-by: Xin Li <xin@zytor.com>
Suggested-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 59 +++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd..35f0bf84b373 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3613,8 +3613,45 @@ static int nested_vmx_check_permission(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+/*
+ * Describe the loading state of L2 guest state, i.e. whether VM-Entry loaded
+ * L2's state from vmcs12 into vmcs02, and whether L2's state is synced back to
+ * vmcs12.
+ */
+enum nested_l2_state {
+	/* VM-entry failed before finishing loading L2's state. */
+	L2_STATE_NOT_LOADED,
+	/* VM-entry loaded L2's state from vmcs12 into vmcs02 before L2 runs. */
+	L2_STATE_LOADED_FROM_VMCS12,
+	/* L2 ran, and KVM saved L2's live state to vmcs12 from vmcs02 on VM-exit. */
+	L2_STATE_SAVED_TO_VMCS12,
+};
+
+/*
+ * Return true if L2's guest state in vmcs12 needs to be loaded into vmcs01,
+ * i.e. if L1 should observe L2's state retained on hardware when L1 runs.
+ * @vm_entry_load_control is the VM-Entry control that loads the state on
+ * VM-Entry.
+ *
+ * Note: this helper is used when the VM-exit load (host state) control is off.
+ * Otherwise, host state (L1 state) should be loaded into vmcs01.
+ */
+static bool nested_l2_state_is_live(struct vmcs12 *vmcs12,
+				    u32 vm_entry_load_control,
+				    enum nested_l2_state l2_state)
+{
+	/* normal VM-exit. */
+	if (l2_state == L2_STATE_SAVED_TO_VMCS12)
+		return true;
+
+	/* true iff VM-entry failed after loading L2's state. */
+	return l2_state == L2_STATE_LOADED_FROM_VMCS12 &&
+	       (vmcs12->vm_entry_controls & vm_entry_load_control);
+}
+
 static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
-				   struct vmcs12 *vmcs12);
+				   struct vmcs12 *vmcs12,
+				   enum nested_l2_state l2_state);
 
 /*
  * If from_vmentry is false, this is being called from state restore (either RSM
@@ -3636,6 +3673,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 		.basic = EXIT_REASON_INVALID_STATE,
 		.failed_vmentry = 1,
 	};
+	enum nested_l2_state l2_state = L2_STATE_NOT_LOADED;
 	u32 failed_index;
 
 	trace_kvm_nested_vmenter(kvm_rip_read(vcpu),
@@ -3700,6 +3738,13 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 		goto vmentry_fail_vmexit_guest_mode;
 	}
 
+	/*
+	 * VM-entry has completed the architectural guest-state loading phase;
+	 * MSRs are loaded after guest state, so failures below should retain
+	 * L2's state (see nested_l2_state_is_live()).
+	 */
+	l2_state = L2_STATE_LOADED_FROM_VMCS12;
+
 	if (from_vmentry) {
 		failed_index = nested_vmx_load_msr(vcpu,
 						   vmcs12->vm_entry_msr_load_addr,
@@ -3778,7 +3823,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 
 	nested_put_vmcs12_pages(vcpu);
 
-	load_vmcs12_host_state(vcpu, vmcs12);
+	load_vmcs12_host_state(vcpu, vmcs12, l2_state);
 	vmcs12->vm_exit_reason = exit_reason.full;
 	if (enable_shadow_vmcs || nested_vmx_is_evmptr12_valid(vmx))
 		vmx->nested.need_vmcs12_to_shadow_sync = true;
@@ -4798,7 +4843,8 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
  * This function should be called when the active VMCS is L1's (vmcs01).
  */
 static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
-				   struct vmcs12 *vmcs12)
+				   struct vmcs12 *vmcs12,
+				   enum nested_l2_state l2_state)
 {
 	enum vm_entry_failure_code ignored;
 	struct kvm_segment seg;
@@ -4856,12 +4902,13 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	/*
 	 * Load CET state from host state if VM_EXIT_LOAD_CET_STATE is set.
 	 * otherwise CET state should be retained across VM-exit, i.e.,
-	 * guest values should be propagated from vmcs12 to vmcs01.
+	 * guest values should be propagated from vmcs12 to vmcs01, but only if
+	 * L2's CET state is live in hardware.
 	 */
 	if (vmcs12->vm_exit_controls & VM_EXIT_LOAD_CET_STATE)
 		vmcs_write_cet_state(vcpu, vmcs12->host_s_cet, vmcs12->host_ssp,
 				     vmcs12->host_ssp_tbl);
-	else
+	else if (nested_l2_state_is_live(vmcs12, VM_ENTRY_LOAD_CET_STATE, l2_state))
 		vmcs_write_cet_state(vcpu, vmcs12->guest_s_cet, vmcs12->guest_ssp,
 				     vmcs12->guest_ssp_tbl);
 
@@ -5193,7 +5240,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 						       vmcs12->vm_exit_intr_error_code,
 						       KVM_ISA_VMX);
 
-		load_vmcs12_host_state(vcpu, vmcs12);
+		load_vmcs12_host_state(vcpu, vmcs12, L2_STATE_SAVED_TO_VMCS12);
 
 		/*
 		 * Process events if an injectable IRQ or NMI is pending, even
-- 
2.34.1

