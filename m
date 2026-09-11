Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A646C830;
	Fri, 11 Sep 2026 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162900; cv=none; b=TaWFQj/vOqU1DG+s/6ZrS09LCDUTKxEngu0eUpJA46mOIKAgoERxQeihmmZLuoteAsLYuePh309M1jsidQKXJLBDGjFus9qzQfK3os0YYySs4RYnQgpM6PsXD+nEnOWquQ065/cfD6xi+rebhP+vrV2BHiJi6topQUL6SEJVs9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162900; c=relaxed/simple;
	bh=7ETT34uBFBm6rxlUmHDQWKjIjRP+Dbp9dWzkfkSPA8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8gOlLLqkC6JNThxa8rYCNtT8o79dMVNy2+FbFcgITppq4FlBJo2jTSWVz80lZlY09VJLJrlojKD3q03yki4I2jLfJvXHtmcZGz5Va+N9v9MQbGEsg5y3mf680qZWFFfyYBvH0vaiADCRwboBf6wUPweHkIIEWZhCpSatHHeaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGmrzaga; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGmrzaga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162899; x=1820698899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ETT34uBFBm6rxlUmHDQWKjIjRP+Dbp9dWzkfkSPA8Q=;
  b=QGmrzagaTCbynGCxlybRR3nOSt+31o/c7MSVyu/vHlC5sfL+4iQTB5ES
   iFhhPkw6YD8G420l79QPdx1GSiNa7cocWr/2BaLpZpz8sD6Ol6J26Aiik
   ShxllDKpANalkx6qZYSpb4Zvn4HDAaXFjPiOI+wNtseROk/4wlhnY3S5w
   no0hjQEMkPQIgi97TPSJEYGtd0o9IMRwvQ35USaofvkyG4501G6w+IlXX
   74NWDVuQpCRWbIphNke1x/VfeasPacYu7O+i2ts1ANjYGS+nCGpOh4sZr
   U+81qRh3jJJt0o7BL3x37LdKpFdNz38mTQUi9o0Qy2ZFXkdv1V0U/qr01
   g==;
X-CSE-ConnectionGUID: 8VnF58YdQ86q1bR60EvtBw==
X-CSE-MsgGUID: WQQcQrhxSmmMp7FNE+BsJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572649"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572649"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:41:38 -0700
X-CSE-ConnectionGUID: DzCUGsU8St6LgzASWN70cQ==
X-CSE-MsgGUID: qZZuu7lUR4C7zUalgkEtXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004109"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:41:37 -0700
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
Subject: [PATCH v10 12/28] KVM: x86: Add a new save/restore flag for FRED metadata
Date: Fri, 11 Sep 2026 14:36:42 -0700
Message-ID: <20260911213659.2025974-13-sohil.mehta@intel.com>
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

From: Xin Li <xin@zytor.com>

Introduce a new save/restore flag for FRED metadata (specifically, the
event nested flag and data) being saved and restored during VM save/
restore and live migration.

Signed-off-by: Xin Li <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Advertise KVM_CAP_X86_FRED_EVENT only when KVM can virtualize FRED, and
   return -EINVAL from KVM_ENABLE_CAP otherwise.
 - Document the new return value in api.rst.
---
 Documentation/virt/kvm/api.rst  | 22 ++++++++++++++++++++++
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/include/uapi/asm/kvm.h |  1 +
 arch/x86/kvm/x86.c              | 18 ++++++++++++++++++
 include/uapi/linux/kvm.h        |  1 +
 5 files changed, 43 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 4eb7e75a7473..22ef94f3eb3a 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1199,6 +1199,10 @@ The following bits are defined in the flags field:
   triple_fault_pending field contains a valid state. This bit will
   be set whenever KVM_CAP_X86_TRIPLE_FAULT_EVENT is enabled.
 
+- KVM_VCPUEVENT_VALID_FRED_STATE may be set to inform that the exception
+  state includes FRED state (specifically, the event nested flag and data).
+  This bit will be set whenever KVM_CAP_X86_FRED_EVENT is enabled.
+
 ARM64:
 ^^^^^^
 
@@ -1301,6 +1305,11 @@ If KVM_CAP_X86_TRIPLE_FAULT_EVENT is enabled, KVM_VCPUEVENT_VALID_TRIPLE_FAULT
 can be set in flags field to signal that the triple_fault field contains
 a valid state and shall be written into the VCPU.
 
+If KVM_CAP_X86_FRED_EVENT is enabled, KVM_VCPUEVENT_VALID_FRED_STATE can be set
+in the flags field to inform that the exception state contains FRED state
+(specifically, the event nested flag and data), which shall be written into the
+VCPU.
+
 ARM64:
 ^^^^^^
 
@@ -8979,6 +8988,19 @@ enabled, cmma can't be enabled anymore and pfmfi and the storage key
 interpretation are disabled. If cmma has already been enabled or the
 hpage_2g module parameter is not set to 1, -EINVAL is returned.
 
+7.48 KVM_CAP_X86_FRED_EVENT
+---------------------------
+
+:Architectures: x86
+:Parameters: args[0] whether feature should be enabled or not
+:Returns: 0 on success; -EINVAL if KVM cannot virtualize FRED.
+
+With this capability enabled, KVM allows exception save and restore operations
+to include FRED event context (specifically, the event nested flag and data).
+When injecting a FRED exception during VM entry, FRED event delivery relies
+on this information to select the correct event stack level and apply proper
+event data.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0fd5d4edeebb..dd68db17fdae 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1286,6 +1286,7 @@ struct kvm_arch {
 	bool has_mapped_host_mmio;
 	bool guest_can_read_msr_platform_info;
 	bool exception_payload_enabled;
+	bool exception_fred_state_enabled;
 
 	bool triple_fault_event;
 
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 1585ec804066..6a67832c59bb 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -331,6 +331,7 @@ struct kvm_reinject_control {
 #define KVM_VCPUEVENT_VALID_SMM		0x00000008
 #define KVM_VCPUEVENT_VALID_PAYLOAD	0x00000010
 #define KVM_VCPUEVENT_VALID_TRIPLE_FAULT	0x00000020
+#define KVM_VCPUEVENT_VALID_FRED_STATE	0x00000040
 
 /* Interrupt shadow states */
 #define KVM_X86_SHADOW_INT_MOV_SS	0x01
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b3681796c75..01198aba27cf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2288,6 +2288,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_PRE_FAULT_MEMORY:
 		r = tdp_enabled;
 		break;
+	case KVM_CAP_X86_FRED_EVENT:
+		r = kvm_cpu_cap_has(X86_FEATURE_FRED);
+		break;
 	case KVM_CAP_X86_APIC_BUS_CYCLES_NS:
 		r = kvm ? kvm->arch.apic_bus_cycle_ns : APIC_BUS_CYCLE_NS_DEFAULT;
 		break;
@@ -3022,6 +3025,8 @@ static void kvm_vcpu_ioctl_x86_get_vcpu_events(struct kvm_vcpu *vcpu,
 			 | KVM_VCPUEVENT_VALID_SMM);
 	if (vcpu->kvm->arch.exception_payload_enabled)
 		events->flags |= KVM_VCPUEVENT_VALID_PAYLOAD;
+	if (vcpu->kvm->arch.exception_fred_state_enabled)
+		events->flags |= KVM_VCPUEVENT_VALID_FRED_STATE;
 	if (vcpu->kvm->arch.triple_fault_event) {
 		events->triple_fault.pending = kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 		events->flags |= KVM_VCPUEVENT_VALID_TRIPLE_FAULT;
@@ -3036,6 +3041,7 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 			      | KVM_VCPUEVENT_VALID_SHADOW
 			      | KVM_VCPUEVENT_VALID_SMM
 			      | KVM_VCPUEVENT_VALID_PAYLOAD
+			      | KVM_VCPUEVENT_VALID_FRED_STATE
 			      | KVM_VCPUEVENT_VALID_TRIPLE_FAULT))
 		return -EINVAL;
 
@@ -3051,6 +3057,11 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 		events->exception_has_payload = 0;
 	}
 
+	if (events->flags & KVM_VCPUEVENT_VALID_FRED_STATE) {
+		if (!vcpu->kvm->arch.exception_fred_state_enabled)
+			return -EINVAL;
+	}
+
 	if ((events->exception.injected || events->exception.pending) &&
 	    (events->exception.nr > 31 || events->exception.nr == NMI_VECTOR))
 		return -EINVAL;
@@ -4038,6 +4049,13 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		kvm->arch.exception_payload_enabled = cap->args[0];
 		r = 0;
 		break;
+	case KVM_CAP_X86_FRED_EVENT:
+		r = -EINVAL;
+		if (!kvm_cpu_cap_has(X86_FEATURE_FRED))
+			break;
+		kvm->arch.exception_fred_state_enabled = cap->args[0];
+		r = 0;
+		break;
 	case KVM_CAP_X86_TRIPLE_FAULT_EVENT:
 		kvm->arch.triple_fault_event = cap->args[0];
 		r = 0;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9fc8dfdfd65f..c5ffc4e7ddb1 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -998,6 +998,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
 #define KVM_CAP_ARM_PMU_V3_STRICT 250
+#define KVM_CAP_X86_FRED_EVENT 251
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.43.0

