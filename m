Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F444A0924;
	Fri, 11 Sep 2026 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162801; cv=none; b=OBk6jql9N3s/VJ46aMw/i7vGMQ2wb+GuEauvM+D5R3iko+I972OqR/NKiSQoY372rtFxYZgmW8fHEnD8kvNL1xJndkhcmarlShbZDVmKC5hYleEjambUC879VMGqmtQ50SczH89tdfJlnQ8m5haWBLgCcW3bf65E4b7MrytNo1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162801; c=relaxed/simple;
	bh=ETcu91PDs3gLxLnQuKEIAtZJFznbfQuLnFoKByW+LdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXuT0O8XVcCuhqO96t9n/iMDv3MpTLkWZHsO73Q1u3Um4woZP5ei2uCBcoKUIz9b0tcuQPp5YJPsUIxIVZAullfiUz1C6YsH+kCNZsN4nvChFIyuYFtybiOsqbRzSGY6QTiRL82Q77v9wxY1NqLVaoloSGM4vAmy2yM6fTj4THk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AeMm6AQZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AeMm6AQZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162799; x=1820698799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ETcu91PDs3gLxLnQuKEIAtZJFznbfQuLnFoKByW+LdE=;
  b=AeMm6AQZbgMdX2G7ZfXPci+JvT4V3jUwop8K+WVHe0+tJystmLlOy8ZD
   zFE8YF83usgKneviSiG+sso6Ex3vP5icLTGWI1D36bZAWFsEj6pZZ5XiM
   aJNdRkrPeSKNdaKDNeK/uL+q12X0RWVoWPJy/J2fCPuTxOzWofWOo6e3F
   rBTQf3U3o5skkbANVABk1SH+XURGwrGV1URwk9EcSF8x+ebRv9U5pbL/j
   Dklc+3kMhoNbAfLL2fOh9fEpfB7VMjpj/UZbxAiKQthrAd23Mj5AaAbpO
   EfscaIeQ6c3wMT/Do1vgeIMxW0L6KrRbEdz8BBo0mmPv7rY6nq7/j4UyJ
   Q==;
X-CSE-ConnectionGUID: 6nHdNOBtRmSsBEiYiEJE7Q==
X-CSE-MsgGUID: TNCd9RNVRMiufQNOrGlJ5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572369"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572369"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:39:58 -0700
X-CSE-ConnectionGUID: bafdppx8Q3O48WoejAKV3w==
X-CSE-MsgGUID: EhBRnRZEQcu+vT4F8WCjKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272003903"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:39:57 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 01/28] KVM: VMX: Enable support for secondary VM exit controls
Date: Fri, 11 Sep 2026 14:36:31 -0700
Message-ID: <20260911213659.2025974-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Xin Li (Intel)" <xin@zytor.com>

Introduce infrastructure to support secondary VM exit controls.

Always load the controls when supported by hardware, though all control
bits remain clear in this patch.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - No change
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/include/asm/vmx.h       |  3 +++
 arch/x86/kvm/vmx/capabilities.h  |  9 ++++++++-
 arch/x86/kvm/vmx/vmcs.h          |  1 +
 arch/x86/kvm/vmx/vmx.c           | 29 +++++++++++++++++++++++++++--
 arch/x86/kvm/vmx/vmx.h           |  7 ++++++-
 6 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 18c4be75e927..ad899d9070e1 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1274,6 +1274,7 @@
 #define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 #define MSR_IA32_VMX_PROCBASED_CTLS3	0x00000492
+#define MSR_IA32_VMX_EXIT_CTLS2		0x00000493
 
 #define MSR_IA32_MCU_STAGING_MBOX_ADDR	0x000007a5
 
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 3f1b3096ff04..1f7cffc118bf 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -119,6 +119,7 @@ struct vmcs {
 #define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
 #define VM_EXIT_LOAD_CET_STATE                  0x10000000
 #define VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL	0x40000000
+#define VM_EXIT_ACTIVATE_SECONDARY_CONTROLS	0x80000000
 
 #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
 
@@ -275,6 +276,8 @@ enum vmcs_field {
 	SHARED_EPT_POINTER		= 0x0000203C,
 	PID_POINTER_TABLE		= 0x00002042,
 	PID_POINTER_TABLE_HIGH		= 0x00002043,
+	SECONDARY_VM_EXIT_CONTROLS	= 0x00002044,
+	SECONDARY_VM_EXIT_CONTROLS_HIGH	= 0x00002045,
 	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
 	GUEST_PHYSICAL_ADDRESS_HIGH     = 0x00002401,
 	VMCS_LINK_POINTER               = 0x00002800,
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 810119167f79..6be818ce27bf 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -57,8 +57,9 @@ struct vmcs_config {
 	u32 cpu_based_exec_ctrl;
 	u32 cpu_based_2nd_exec_ctrl;
 	u64 cpu_based_3rd_exec_ctrl;
-	u32 vmexit_ctrl;
 	u32 vmentry_ctrl;
+	u32 vmexit_ctrl;
+	u64 vmexit_2nd_ctrl;
 	u64 misc;
 	struct nested_vmx_msrs nested;
 };
@@ -149,6 +150,12 @@ static inline bool cpu_has_tertiary_exec_ctrls(void)
 		CPU_BASED_ACTIVATE_TERTIARY_CONTROLS;
 }
 
+static inline bool cpu_has_secondary_vmexit_ctrls(void)
+{
+	return vmcs_config.vmexit_ctrl &
+		VM_EXIT_ACTIVATE_SECONDARY_CONTROLS;
+}
+
 static inline bool cpu_has_vmx_virtualize_apic_accesses(void)
 {
 	return vmcs_config.cpu_based_2nd_exec_ctrl &
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
index 504630f0eb40..b4aec4218b7d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2751,8 +2751,9 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	u32 _cpu_based_exec_control = 0;
 	u32 _cpu_based_2nd_exec_control = 0;
 	u64 _cpu_based_3rd_exec_control = 0;
-	u32 _vmexit_control = 0;
 	u32 _vmentry_control = 0;
+	u32 _vmexit_control = 0;
+	u64 _vmexit2_control = 0;
 	u64 basic_msr;
 	u64 misc_msr;
 
@@ -2773,6 +2774,12 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 		{ VM_ENTRY_LOAD_CET_STATE,		VM_EXIT_LOAD_CET_STATE },
 	};
 
+	struct {
+		u32 entry_control;
+		u64 exit_control;
+	} const vmcs_entry_exit2_pairs[] = {
+	};
+
 	memset(vmcs_conf, 0, sizeof(*vmcs_conf));
 
 	if (adjust_vmx_controls(KVM_REQUIRED_VMX_CPU_BASED_VM_EXEC_CONTROL,
@@ -2870,10 +2877,19 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 				&_vmentry_control))
 		return -EIO;
 
+	if (_vmexit_control & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
+		_vmexit2_control =
+			adjust_vmx_controls64(KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS,
+					      MSR_IA32_VMX_EXIT_CTLS2);
+
 	if (vmx_check_entry_exit_pairs(vmcs_entry_exit_pairs,
 				       _vmentry_control, _vmexit_control))
 		return -EIO;
 
+	if (vmx_check_entry_exit_pairs(vmcs_entry_exit2_pairs,
+				       _vmentry_control, _vmexit2_control))
+		return -EIO;
+
 	/*
 	 * Some cpus support VM_{ENTRY,EXIT}_IA32_PERF_GLOBAL_CTRL but they
 	 * can't be used due to an errata where VM Exit may incorrectly clear
@@ -2922,8 +2938,9 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	vmcs_conf->cpu_based_exec_ctrl = _cpu_based_exec_control;
 	vmcs_conf->cpu_based_2nd_exec_ctrl = _cpu_based_2nd_exec_control;
 	vmcs_conf->cpu_based_3rd_exec_ctrl = _cpu_based_3rd_exec_control;
-	vmcs_conf->vmexit_ctrl         = _vmexit_control;
 	vmcs_conf->vmentry_ctrl        = _vmentry_control;
+	vmcs_conf->vmexit_ctrl         = _vmexit_control;
+	vmcs_conf->vmexit_2nd_ctrl     = _vmexit2_control;
 	vmcs_conf->misc	= misc_msr;
 
 #if IS_ENABLED(CONFIG_HYPERV)
@@ -4617,6 +4634,11 @@ static u32 vmx_get_initial_vmexit_ctrl(void)
 		  VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL);
 }
 
+static u64 vmx_secondary_vmexit_ctrl(void)
+{
+	return vmcs_config.vmexit_2nd_ctrl;
+}
+
 void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -4960,6 +4982,9 @@ static void init_vmcs(struct vcpu_vmx *vmx)
 
 	vm_exit_controls_set(vmx, vmx_get_initial_vmexit_ctrl());
 
+	if (cpu_has_secondary_vmexit_ctrls())
+		secondary_vm_exit_controls_set(vmx, vmx_secondary_vmexit_ctrl());
+
 	/* 22.2.1, 20.8.1 */
 	vm_entry_controls_set(vmx, vmx_get_initial_vmentry_ctrl());
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index dc8517f15bc4..6295f9302cd9 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -501,7 +501,11 @@ static inline u8 vmx_get_rvi(void)
 	       VM_EXIT_PT_CONCEAL_PIP |					\
 	       VM_EXIT_CLEAR_IA32_RTIT_CTL |				\
 	       VM_EXIT_LOAD_CET_STATE |					\
-	       VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL)
+	       VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL |			\
+	       VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
+
+#define KVM_REQUIRED_VMX_SECONDARY_VM_EXIT_CONTROLS (0)
+#define KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS (0)
 
 #define KVM_REQUIRED_VMX_PIN_BASED_VM_EXEC_CONTROL			\
 	(PIN_BASED_EXT_INTR_MASK |					\
@@ -615,6 +619,7 @@ static __always_inline void lname##_controls_changebit(struct vcpu_vmx *vmx, u##
 }
 BUILD_CONTROLS_SHADOW(vm_entry, VM_ENTRY_CONTROLS, 32)
 BUILD_CONTROLS_SHADOW(vm_exit, VM_EXIT_CONTROLS, 32)
+BUILD_CONTROLS_SHADOW(secondary_vm_exit, SECONDARY_VM_EXIT_CONTROLS, 64)
 BUILD_CONTROLS_SHADOW(pin, PIN_BASED_VM_EXEC_CONTROL, 32)
 BUILD_CONTROLS_SHADOW(exec, CPU_BASED_VM_EXEC_CONTROL, 32)
 BUILD_CONTROLS_SHADOW(secondary_exec, SECONDARY_VM_EXEC_CONTROL, 32)
-- 
2.43.0

