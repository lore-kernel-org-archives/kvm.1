Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C847ECDD;
	Thu, 17 Sep 2026 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629728; cv=none; b=F77otYUQLhndPcL7elQOKGm2d0w6RPMk13Q/5gBQSb3RecrRnZhnBLiT05u5daXuvv48aHljUw9sdNVQCy2gHgzJoJ2YXs0l/82APC30XqHeh8y5R7GPGbcxtvMJb+hGTxaXDFaRT/4/rK7mCTnuf/7RlJ/eFczdVSvDnns7HdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629728; c=relaxed/simple;
	bh=Bcx8AYHB1t/Ot/Sz8VFwmw35xbBw+Tf0ELwyt0yh56s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APMlbYwQU5JvN9xCaaWDzAW9KMMzKXcPBhXzSTIP/mmddcTukyKN9KkU9XKOF3RTj65Fe8cYE4UaDhQnOxE6m28ZR07O9WpCJstUN6PaxDdwAq9Z0p4Yh4z95FBTO7lhv1ULwMz2RRsx4UOBKaPwgnoTZjf70qX265AL81qVMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lT15/n2h; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lT15/n2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789629722; x=1821165722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bcx8AYHB1t/Ot/Sz8VFwmw35xbBw+Tf0ELwyt0yh56s=;
  b=lT15/n2hQFbgv1PpJr5aNg54SYhLk8TF62WFlw9UXHXd1AM378FnML0M
   QOeSj4Xg+SXj4XmUPNZRsgC9UAzhkd3ziMc1Qd2yolxWQbeo3mZI1ZUdo
   9Ebouv2TTAIHRxG8B0x6nuWGoBCl6J1APdpQeJs50zamPUaBwkR9awAi0
   6Nup2FHdkVE6vVmAp5hMUCxZEAdKCFSfe2q5M2zdihpkVaqN5qq9x3Udm
   Kq0eSYuwd3g4Lo3CmaHJoWCyqkBlm9jFehb/9hVGFSuIBYqFjBzHmP2Ws
   QeAU1TWt79nWFrDO//1zDVLAoBKojUeSlcmv+5W0hUlsPQer24Kcrs6Mu
   w==;
X-CSE-ConnectionGUID: iIlwYpFARL2YLCk7dav3MQ==
X-CSE-MsgGUID: Nal+Z+kxQtiLnFm+RxpIag==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="531876"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="531876"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:21:40 -0700
X-CSE-ConnectionGUID: 69pfWXumQeSHTVAE1YIgeA==
X-CSE-MsgGUID: hsYhOe2OQRWXhmEbFdu8aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1849453"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:21:38 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@linux.intel.com,
	andrew.cooper3@citrix.com,
	nik.borisov@suse.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	tony.lindgren@linux.intel.com,
	kishen.maloor@intel.com,
	dedekind1@gmail.com,
	binbin.wu@linux.intel.com
Subject: [PATCH v4 4/4] KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM
Date: Thu, 17 Sep 2026 15:25:48 +0800
Message-ID: <20260917072548.2314491-5-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate the CPUID configuration provided by userspace through
KVM_TDX_INIT_VM against KVM's TDX allowlist, and drop the hardcoded
denylist based check.

The TDX module lets the VMM configure certain CPUID features for a TD at
initialization time, but KVM must strictly govern which of them userspace
can actually enable, otherwise a host state clobbering feature could be
enabled behind KVM's back.  The existing check only rejects TSX and
WAITPKG, i.e. it is not fail-safe, as any bit that a future TDX module
makes configurable would be accepted even if KVM has no idea about the
feature.

Add tdx_has_unsupported_cpuid_cfg_bit() and reject KVM_TDX_INIT_VM if
userspace sets any bit outside the mask returned by
tdx_get_cpuid_cfg_mask().  There is no need to first mask the userspace
input with the bits the TDX module reports as directly configurable, as
anything outside that set is rejected by the TDX module itself.

Also reject CPUID entries whose index differs from the value expected by
the TDX module, as kvm_find_cpuid_entry2() ignores the index when
KVM_CPUID_FLAG_SIGNIFCANT_INDEX is cleared, i.e. a mismatching entry could
otherwise be applied to the wrong subleaf.

Update the comments for KVM_TDX_INIT_VM in the uapi header and the TDX
documentation accordingly.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
v4:
- Update the comments/documentation.
- Collect RB tag from Tony.

v3:
- Check CPUID entry index mismatch b/t userspace input and TDX sysinfo
  configuration. (Sashiko)
- No need to mask the userspace input with TDX module reported directly
  configurable bits first, since the userspace input should be subset of
  directly configurable bits. Otherwise, the input will be rejected by
  the TDX module.
---
 Documentation/virt/kvm/x86/intel-tdx.rst |  2 ++
 arch/x86/include/uapi/asm/kvm.h          |  2 ++
 arch/x86/kvm/vmx/tdx.c                   | 41 ++++++++++++------------
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/Documentation/virt/kvm/x86/intel-tdx.rst b/Documentation/virt/kvm/x86/intel-tdx.rst
index 6beeb89d7f057..36bd0fee2480d 100644
--- a/Documentation/virt/kvm/x86/intel-tdx.rst
+++ b/Documentation/virt/kvm/x86/intel-tdx.rst
@@ -135,6 +135,8 @@ KVM_CREATE_VM and before creating any VCPUs.
         /*
          * Call KVM_TDX_INIT_VM before vcpu creation, thus before
          * KVM_SET_CPUID2.
+         * KVM validates @cpuid, i.e. setting a bit that KVM_TDX_CAPABILITIES
+         * doesn't report as configurable fails the ioctl.
          * This configuration supersedes KVM_SET_CPUID2s for VCPUs because the
          * TDX module directly virtualizes those CPUIDs without VMM.  The user
          * space VMM, e.g. qemu, should make KVM_SET_CPUID2 consistent with
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 1585ec8040666..784cb5cd7f664 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -1032,6 +1032,8 @@ struct kvm_tdx_init_vm {
 	/*
 	 * Call KVM_TDX_INIT_VM before vcpu creation, thus before
 	 * KVM_SET_CPUID2.
+	 * KVM validates @cpuid, i.e. setting a bit that KVM_TDX_CAPABILITIES
+	 * doesn't report as configurable fails the ioctl.
 	 * This configuration supersedes KVM_SET_CPUID2s for VCPUs because the
 	 * TDX module directly virtualizes those CPUIDs without VMM.  The user
 	 * space VMM, e.g. qemu, should make KVM_SET_CPUID2 consistent with
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index ad7d70b36ffe5..5426191905d0d 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -286,25 +286,6 @@ static u32 tdx_set_guest_phys_addr_bits(const u32 eax, int addr_bits)
 	return (eax & ~GENMASK(23, 16)) | (addr_bits & 0xff) << 16;
 }
 
-#define TDX_FEATURE_TSX (__feature_bit(X86_FEATURE_HLE) | __feature_bit(X86_FEATURE_RTM))
-
-static bool has_tsx(const struct kvm_cpuid_entry2 *entry)
-{
-	return entry->function == 7 && entry->index == 0 &&
-	       (entry->ebx & TDX_FEATURE_TSX);
-}
-
-static bool has_waitpkg(const struct kvm_cpuid_entry2 *entry)
-{
-	return entry->function == 7 && entry->index == 0 &&
-	       (entry->ecx & __feature_bit(X86_FEATURE_WAITPKG));
-}
-
-static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
-{
-	return has_tsx(entry) || has_waitpkg(entry);
-}
-
 #define TDX_CPUID_ALL_ALLOWED_MASK	GENMASK_U32(31, 0)
 
 static u32 tdx_get_cpuid_cfg_non_feature_mask(u32 function, u32 index, int reg)
@@ -2548,6 +2529,17 @@ static int setup_tdparams_eptp_controls(struct kvm_cpuid2 *cpuid,
 	return 0;
 }
 
+static bool tdx_has_unsupported_cpuid_cfg_bit(const struct kvm_cpuid_entry2 *entry)
+{
+	u32 function = entry->function;
+	u32 index = entry->index;
+
+	return (entry->eax & ~tdx_get_cpuid_cfg_mask(function, index, CPUID_EAX)) ||
+	       (entry->ebx & ~tdx_get_cpuid_cfg_mask(function, index, CPUID_EBX)) ||
+	       (entry->ecx & ~tdx_get_cpuid_cfg_mask(function, index, CPUID_ECX)) ||
+	       (entry->edx & ~tdx_get_cpuid_cfg_mask(function, index, CPUID_EDX));
+}
+
 static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
 				 struct td_params *td_params)
 {
@@ -2571,7 +2563,16 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
 		if (!entry)
 			continue;
 
-		if (tdx_unsupported_cpuid(entry))
+		/*
+		 * Reject entries whose index doesn't match the expected one.
+		 * This catches userspace passing a CPUID entry with the
+		 * KVM_CPUID_FLAG_SIGNIFCANT_INDEX flag cleared when the index
+		 * is significant.
+		 */
+		if (entry->index != tmp.index)
+			return -EINVAL;
+
+		if (tdx_has_unsupported_cpuid_cfg_bit(entry))
 			return -EINVAL;
 
 		copy_cnt++;
-- 
2.46.0

