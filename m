Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32F373BE7
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411178; cv=none; b=J7I3qK1XitUE87XK8QnDpiuR6MWcNlgCalcb8bfnmFoFkaR/b2ULw8jlyYodXYq58mIIpTHP9LP3ZSMCXepBoBspHJF6HgeENatrkJjbefh3369+VFUpJE32p0+NGS2Yt1ta/DlB+4Y22EIL8FrxBoFRfgTMYyX7mh0dq0CoK2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411178; c=relaxed/simple;
	bh=PP7+NN3Vg1k7Y4bannRcRHIbJOzjMP91Yo0hkRjyZKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1Nzgv8nkjUI1w34EkzNMou6Te/pA7o4uPVMF+WttWS0x8JbyceRJ0sCzjRGH8UmW/4hdkp+YBekSgzidGjO1Mo0O+EmzuEV64GMey/dzRFBR7a4rvAlir1B7bkoazqjYTF/0pcXYRpX6ppVAUQNjYPerKXMVdxNSKTRQeYt2d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKkFVoqn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKkFVoqn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411177; x=1807947177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PP7+NN3Vg1k7Y4bannRcRHIbJOzjMP91Yo0hkRjyZKM=;
  b=MKkFVoqnnmj7yUJoN/3fEiI4CLX6tJLbcj/6zQ82jcpHceINHZDundIi
   iuFuj6/jiufrEnrVXd7VLSB8KOTsug9BtHyOfPT6HDFFv9FK1MOT4h4JC
   sCgE2ArwglZqgXVgVoRd6IQ+13T9HaTpSYSba22zwyHW/X3SQlJCT/V1m
   guQMWYVAsksMaevKUTjb5Yx0XCeefrz3iNhSi409u+MrJdJ3yHtef1WTk
   z5KB9y4Dy97jMtDVZjlOw9fxQzbxNKsClFUx4c0WLqEqaZuMxcPeUNp7Z
   +i+CwIxlsn5U1FTlxk0UKaoyRa2Cs/aCiOg+vX1p16zBx+j3Dl3/+oF3c
   A==;
X-CSE-ConnectionGUID: v7fl3j1eS3eOjUWNKpCYbg==
X-CSE-MsgGUID: u9BiHkWZTPaBMzRoCoJcbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070322"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070322"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:57 -0700
X-CSE-ConnectionGUID: wWg80RbpQWO2GHD52UIhKw==
X-CSE-MsgGUID: UPcJ+3c6Que53fbOCU8Jsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226285087"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:55 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 25/27] KVM: x86: Add new KVM_CAP_X86_CPUID_PARANOID
Date: Fri, 17 Apr 2026 15:36:08 +0800
Message-ID: <20260417073610.3246316-26-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new VM-scoped capability, KVM_CAP_X86_CPUID_PARANOID, to
allow userspace to opt-in CPUID paranoid mode.

When  CPUID paranoid mode is enabled, KVM rejects KVM_SET_CPUID2 if any
CPUID bits unknown or unsupported by KVM are set.

Userspace should enable KVM_CAP_X86_CPUID_PARANOID before creating any
vCPUs.

Unconditionally enforce CPUID paranoid mode for TDs.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 Documentation/virt/kvm/api.rst | 18 ++++++++++++++++++
 arch/x86/kvm/vmx/tdx.c         |  8 ++++++++
 arch/x86/kvm/x86.c             | 13 +++++++++++++
 include/uapi/linux/kvm.h       |  1 +
 4 files changed, 40 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..81cb78ee9368 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8904,6 +8904,24 @@ helpful if user space wants to emulate instructions which are not
 This capability can be enabled dynamically even if VCPUs were already
 created and are running.
 
+7.47 KVM_CAP_X86_CPUID_PARANOID
+-------------------------------
+
+:Architectures: x86
+:Type: vm
+:Parameters: arg[0], a bitmask of flags, which is reserved for future use.
+:Returns: 0 on success, -EINVAL if arg[0] is not zero or vCPUs have been created
+          before enabling this capability.
+
+When this capability is supported, userspace can query supported CPUIDs per VM
+via KVM_GET_SUPPORTED_CPUID and KVM_GET_EMULATED_CPUID.
+
+When this capability is enabled, KVM will only allow the CPUID bits that are
+known and supported to be exposed to the guest.  KVM will reject KVM_SET_CPUID2
+if any unknown or unsupported bits are set.
+
+For TDX guests, this capability is enabled by default.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index a1df89d66a84..a996e7f761ed 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -638,6 +638,14 @@ int tdx_vm_init(struct kvm *kvm)
 	kvm->arch.has_private_mem = true;
 	kvm->arch.disabled_quirks |= KVM_X86_QUIRK_IGNORE_GUEST_PAT;
 
+	/*
+	 * KVM enforces CPUID paranoid mode for TDs to prevent userspace from
+	 * setting unknown or unsupported bits in CPUID, which could be host
+	 * state clobbering features requiring KVM to do additional host state
+	 * management.
+	 */
+	kvm->arch.is_cpuid_paranoid_mode = true;
+
 	/*
 	 * Because guest TD is protected, VMM can't parse the instruction in TD.
 	 * Instead, guest uses MMIO hypercall.  For unmodified device driver,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4f713afd909a..ed2df450fd0b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4870,6 +4870,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_MEMORY_FAULT_INFO:
 	case KVM_CAP_X86_GUEST_MODE:
 	case KVM_CAP_ONE_REG:
+	case KVM_CAP_X86_CPUID_PARANOID:
 		r = 1;
 		break;
 	case KVM_CAP_PRE_FAULT_MEMORY:
@@ -7006,6 +7007,18 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		mutex_unlock(&kvm->lock);
 		break;
 	}
+	case KVM_CAP_X86_CPUID_PARANOID:
+		r = -EINVAL;
+		if (cap->args[0])
+			break;
+
+		mutex_lock(&kvm->lock);
+		if (!kvm->created_vcpus) {
+			kvm->arch.is_cpuid_paranoid_mode = true;
+			r = 0;
+		}
+		mutex_unlock(&kvm->lock);
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6c8afa2047bf..daf429cfc6eb 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -996,6 +996,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
+#define KVM_CAP_X86_CPUID_PARANOID 249
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.46.0

