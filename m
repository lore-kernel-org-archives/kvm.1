Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660250;
	b=bClY0ij03k5pfw5X2lYpPw5XFxklq/MDbp5zRuHkrELvD2drKJZ6WO4RdZAFEJ/Xb9Qf
	 8QMR5lAiPByr+te/GIcn4/T+O2KNxvhBaCI+1mrs/6A/1yXtZd2V6Oiaqh9t2odugLmna
	 BPCT1VtNiAqBz49sNr8B1wVi3i5idwo5fhzaeF2Y40bEYcO6QqYSx/32HjP0SXpZaOfQs
	 yvoYzbrQhX6qwXLlVyRlGCzjA1A9wCG1GGgBINQNQfOefZyr+l711J/u/TQ14vw2pvYUp
	 Vb/MHQBcL3HGqWW3GqDbJpChESU4VGg2JfW8r/w0Yr5/NLm1AHLLIbbybrhWHVtCyIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660250;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U/FqTyKXk6o0LjlxqmzhrFkA2OF1Ko44ZViBlH+Qyk0=;
	b=Aen2JvB0N8Pg1xK1AKXTm83lUkMBGJe1vpU/DAKfi7Tid/c02D10Ze7KH1M/h8ohOoLQ
	 bQMNuwx+dj1oXPLYoo6d5DsSWKFTQCy+loAQ1uCeM/rJYm0F80UpsG6nsMRVwBhVvXQLQ
	 HiTHYr4sZPzPSw+tjRAfWx5EFVxTjp3evx9EKHMJvZ+gmFHPsQQcYyoQmA7VwfmbMer4p
	 Gff8vQyPDY+yLH66DhEiqug/pV5y0tCtkYFiXBcZJfwMBV69kjzJ+NTSdT5tAptbrbOZd
	 uhTECvW/0KHMPGqXUXGK3wWTK/n0klX80DR9sRsWLy+OvCrbBz+GoiVnYb8eYzvqvrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YHTUZGfA;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B570606A321;
	Thu, 26 Nov 2026 02:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B570606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YHTUZGfA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795660250; x=1827196250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mXNuyhIz+7PIUiv1Yt0Wm0qxYAZan4uZyFvd/J41th4=;
  b=YHTUZGfATZPGolnoWjs7jF6+eA7tzA+E8l27E7Gz2e4A4e+94gpiLt80
   Uay/HQ7yQjtiyoGJfk65XhU9y2upA+6c1gW/apqynWWa+9HqW8sn9MhBu
   r68VN/LdoyavjPXsqoTmZspwmGFUv3Wu0II3yfKUz0c+6cK/1SAwlFMNi
   PeUqZqbZxEl5Sp7B6QaBxjJUO80/VD01UgdUH3G4J5SAUER0wlLGBKCXb
   wVfcR7A4usYqI9fm+jjxoFQac+Lu+4EYQiroJzTXwhJR/OZl6OpQaUyll
   gzcTlt7dTilvKG7QCHe3yuij/Tlfvp3iW99ia+EmjwiD9grHQnwsuQlNQ
   w==;
X-CSE-ConnectionGUID: rvIMoQ86QPeyqLkpYAbnrg==
X-CSE-MsgGUID: i/7hMDmlR0O4nuFKIkiiuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4642518"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4642518"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 18:30:49 -0800
X-CSE-ConnectionGUID: F40QdhzVQzSx8lZMo1XMag==
X-CSE-MsgGUID: BnN6MTOHTRKhAbSsZ6Sc5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="12044176"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 25 Nov 2026 18:30:48 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Jon Kohler <jon@nutanix.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] KVM: VMX: Add support for the secondary VM-exit controls
Date: Wed, 25 Nov 2026 18:27:41 -0800
Message-ID: <20261126022743.4082392-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126022743.4082392-1-sohil.mehta@intel.com>
References: <20261126022743.4082392-1-sohil.mehta@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Xin Li (Intel)" <xin@zytor.com>

The secondary VM-exit controls are a 64-bit VMCS field for controls that
no longer fit in the 32-bit primary field. Bit 31 of the primary VM-exit
controls activates them. No feature KVM supports uses any of these
controls yet, but the upcoming FRED KVM support is planning to use them.

Add the VMCS field, its 64-bit controls shadow and the vmcs_config
plumbing, and activate the controls in vmcs01 whenever hardware supports
them. With every control bit clear, KVM behaves exactly as before.

Check the secondary controls through their own entry/exit pair table.
Avoid using a shared table because a failed check would clear the
activation bit and turn off every secondary control, not just the
inconsistent one. The new table stays empty until the first feature adds
a pair.

Copy the controls into vmcs02 as well. vmcs02 inherits the activation
bit from vmcs01, so without the copy it would run with the secondary
controls active but empty. That is harmless while every bit is clear.
Once a feature sets one, though, L2 would run with it silently off,
leaving the host with L2's state after a VM exit.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Co-developed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v1:
(Changes from FRED KVM v10):
 - Set the secondary VM-exit controls in vmcs02 too, so that no commit
   leaves vmcs02 with the controls activated but empty. (Prevents a CPU
   hang on exits from L2 once FRED guest support lands without the
   nested patches.)
 - Match the names and placement of the new variables and code to their
   neighbours.
 - Reword the changelog and also say why the secondary entry/exit pair
   table is separate from the primary one.
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/include/asm/vmx.h       |  3 +++
 arch/x86/kvm/vmx/capabilities.h  |  6 ++++++
 arch/x86/kvm/vmx/nested.c        |  3 +++
 arch/x86/kvm/vmx/vmcs.h          |  1 +
 arch/x86/kvm/vmx/vmx.c           | 25 +++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.h           |  7 ++++++-
 7 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index c0914829a925..ba26b8eccb01 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1288,6 +1288,7 @@
 #define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 #define MSR_IA32_VMX_PROCBASED_CTLS3	0x00000492
+#define MSR_IA32_VMX_EXIT_CTLS2		0x00000493
 
 #define MSR_IA32_MCU_STAGING_MBOX_ADDR	0x000007a5
 
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index e49b836c7313..a0802af63dc3 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -127,6 +127,7 @@ struct vmcs {
 #define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
 #define VM_EXIT_LOAD_CET_STATE                  0x10000000
 #define VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL	0x40000000
+#define VM_EXIT_ACTIVATE_SECONDARY_CONTROLS	0x80000000
 
 #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
 
@@ -283,6 +284,8 @@ enum vmcs_field {
 	SHARED_EPT_POINTER		= 0x0000203C,
 	PID_POINTER_TABLE		= 0x00002042,
 	PID_POINTER_TABLE_HIGH		= 0x00002043,
+	SECONDARY_VM_EXIT_CONTROLS	= 0x00002044,
+	SECONDARY_VM_EXIT_CONTROLS_HIGH	= 0x00002045,
 	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
 	GUEST_PHYSICAL_ADDRESS_HIGH     = 0x00002401,
 	VMCS_LINK_POINTER               = 0x00002800,
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 810119167f79..5737e79bf2da 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -58,6 +58,7 @@ struct vmcs_config {
 	u32 cpu_based_2nd_exec_ctrl;
 	u64 cpu_based_3rd_exec_ctrl;
 	u32 vmexit_ctrl;
+	u64 vmexit_2nd_ctrl;
 	u32 vmentry_ctrl;
 	u64 misc;
 	struct nested_vmx_msrs nested;
@@ -149,6 +150,11 @@ static inline bool cpu_has_tertiary_exec_ctrls(void)
 		CPU_BASED_ACTIVATE_TERTIARY_CONTROLS;
 }
 
+static inline bool cpu_has_secondary_vmexit_ctrls(void)
+{
+	return vmcs_config.vmexit_ctrl & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS;
+}
+
 static inline bool cpu_has_vmx_virtualize_apic_accesses(void)
 {
 	return vmcs_config.cpu_based_2nd_exec_ctrl &
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1a98f28651f7..0f39309cc7f3 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2559,6 +2559,9 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 		exec_control &= ~VM_EXIT_LOAD_IA32_EFER;
 	vm_exit_controls_set(vmx, exec_control);
 
+	if (exec_control & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
+		secondary_vm_exit_controls_set(vmx, __secondary_vm_exit_controls_get(vmcs01));
+
 	/*
 	 * Interrupt/Exception Fields
 	 */
diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
index 1f16ddeae9cb..ca341c59bab1 100644
--- a/arch/x86/kvm/vmx/vmcs.h
+++ b/arch/x86/kvm/vmx/vmcs.h
@@ -45,6 +45,7 @@ struct vmcs_host_state {
 struct vmcs_controls_shadow {
 	u32 vm_entry;
 	u32 vm_exit;
+	u64 secondary_vm_exit;
 	u32 pin;
 	u32 exec;
 	u32 secondary_exec;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 68fa251dda60..3752a86c3fca 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2752,6 +2752,7 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	u32 _cpu_based_2nd_exec_control = 0;
 	u64 _cpu_based_3rd_exec_control = 0;
 	u32 _vmexit_control = 0;
+	u64 _vmexit_2nd_control = 0;
 	u32 _vmentry_control = 0;
 	struct msr val;
 	u64 basic_msr;
@@ -2774,6 +2775,12 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 		{ VM_ENTRY_LOAD_CET_STATE,		VM_EXIT_LOAD_CET_STATE },
 	};
 
+	struct {
+		u32 entry_control;
+		u64 exit_control;
+	} const vmcs_entry_exit_2nd_pairs[] = {
+	};
+
 	memset(vmcs_conf, 0, sizeof(*vmcs_conf));
 
 	if (adjust_vmx_controls(KVM_REQUIRED_VMX_CPU_BASED_VM_EXEC_CONTROL,
@@ -2864,6 +2871,11 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 				&_vmexit_control))
 		return -EIO;
 
+	if (_vmexit_control & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
+		_vmexit_2nd_control =
+			adjust_vmx_controls64(KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS,
+					      MSR_IA32_VMX_EXIT_CTLS2);
+
 	if (adjust_vmx_controls(KVM_REQUIRED_VMX_PIN_BASED_VM_EXEC_CONTROL,
 				KVM_OPTIONAL_VMX_PIN_BASED_VM_EXEC_CONTROL,
 				MSR_IA32_VMX_PINBASED_CTLS,
@@ -2886,6 +2898,10 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 				       _vmentry_control, _vmexit_control))
 		return -EIO;
 
+	if (vmx_check_entry_exit_pairs(vmcs_entry_exit_2nd_pairs,
+				       _vmentry_control, _vmexit_2nd_control))
+		return -EIO;
+
 	/*
 	 * Some cpus support VM_{ENTRY,EXIT}_IA32_PERF_GLOBAL_CTRL but they
 	 * can't be used due to an errata where VM Exit may incorrectly clear
@@ -2935,6 +2951,7 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	vmcs_conf->cpu_based_2nd_exec_ctrl = _cpu_based_2nd_exec_control;
 	vmcs_conf->cpu_based_3rd_exec_ctrl = _cpu_based_3rd_exec_control;
 	vmcs_conf->vmexit_ctrl         = _vmexit_control;
+	vmcs_conf->vmexit_2nd_ctrl     = _vmexit_2nd_control;
 	vmcs_conf->vmentry_ctrl        = _vmentry_control;
 	vmcs_conf->misc	= misc_msr;
 
@@ -4629,6 +4646,11 @@ static u32 vmx_get_initial_vmexit_ctrl(void)
 		  VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL);
 }
 
+static u64 vmx_get_initial_secondary_vmexit_ctrl(void)
+{
+	return vmcs_config.vmexit_2nd_ctrl;
+}
+
 void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -4973,6 +4995,9 @@ static void init_vmcs(struct kvm_vcpu *vcpu)
 
 	vm_exit_controls_set(vmx, vmx_get_initial_vmexit_ctrl());
 
+	if (cpu_has_secondary_vmexit_ctrls())
+		secondary_vm_exit_controls_set(vmx, vmx_get_initial_secondary_vmexit_ctrl());
+
 	/* 22.2.1, 20.8.1 */
 	vm_entry_controls_set(vmx, vmx_get_initial_vmentry_ctrl());
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 74cd50f29fa4..e8c6ce23168a 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -457,7 +457,11 @@ static inline u8 vmx_get_rvi(void)
 	       VM_EXIT_PT_CONCEAL_PIP |					\
 	       VM_EXIT_CLEAR_IA32_RTIT_CTL |				\
 	       VM_EXIT_LOAD_CET_STATE |					\
-	       VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL)
+	       VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL |			\
+	       VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
+
+#define KVM_REQUIRED_VMX_SECONDARY_VM_EXIT_CONTROLS 0
+#define KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS 0
 
 #define KVM_REQUIRED_VMX_PIN_BASED_VM_EXEC_CONTROL			\
 	(PIN_BASED_EXT_INTR_MASK |					\
@@ -571,6 +575,7 @@ static __always_inline void lname##_controls_changebit(struct vcpu_vmx *vmx, u##
 }
 BUILD_CONTROLS_SHADOW(vm_entry, VM_ENTRY_CONTROLS, 32)
 BUILD_CONTROLS_SHADOW(vm_exit, VM_EXIT_CONTROLS, 32)
+BUILD_CONTROLS_SHADOW(secondary_vm_exit, SECONDARY_VM_EXIT_CONTROLS, 64)
 BUILD_CONTROLS_SHADOW(pin, PIN_BASED_VM_EXEC_CONTROL, 32)
 BUILD_CONTROLS_SHADOW(exec, CPU_BASED_VM_EXEC_CONTROL, 32)
 BUILD_CONTROLS_SHADOW(secondary_exec, SECONDARY_VM_EXEC_CONTROL, 32)
-- 
2.43.0

