Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2683BADBC;
	Fri, 16 Oct 2026 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141846; cv=none; b=hGcIwWMytPDkHfrYq6IGim9W+/xgZsx4cHAu2613RiymwbRwbTCkcmvqNEHp02Cd961LkVa4ijLowP5hem026rBi5q5ciChUFwW7iwrQusQnmTjjDFIbEqeKPLlwFg6XM5q5me/doaB4sI+RFWeg2tHGqUkyIp7i5ZACQa/r4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141846; c=relaxed/simple;
	bh=4xZWr/LAnf5pRFqgWGrhbmztkU7yhdCxfCaI+CbTjVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyK1xAfJcxtzRp6+cyNs74/E2MLmwLH7qMROeu3qPeAAX3wkH2Y3H6pPuybQe5jD+W+gCzWCu8eUjfUkjxNtYeoQIJZjfYRBoyS7CDD2DUX6wnBUrXlIZvvMK6feQeXjFS4BTknSdlx8jLc2G7NqjVniSN1DB2phr6w40Jyt1ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CakmfB1X; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CakmfB1X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792141846; x=1823677846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4xZWr/LAnf5pRFqgWGrhbmztkU7yhdCxfCaI+CbTjVM=;
  b=CakmfB1XS0r/wd3d3AJ9Qef6WyNIqT1pfZhdQxznKFfh8/FEzFnORmZO
   rit1tzbF1DU5gy0noFzxu1lwOUnxMvbELXTlPaHMd8yXQDd5Yc4UT+Gn3
   gwG5kUiPCK5j59IVrVzUSlgQxh1gXkue+daOFsBXVv2fLdN4oX1fmOCNO
   mpPYfgUTTF9ZEe6YKdOeeThnyknodINuw+pJFmh6zHQ2VBzXjWA7tjTcJ
   hSxIYCVIk6JQl+Sz8fxjX3h/W/YXU+s43u0nYNBuU9yt7EGpaytI++l72
   lg6RS+tuajFczUQSTwcD6iOqQ+vMEY3INRfANS6s8gU8/9U7YX6vCoDmv
   Q==;
X-CSE-ConnectionGUID: nPIPJCJCTrmhgGYew16E5A==
X-CSE-MsgGUID: 5ZzmWCMRSECabrQw+t5qGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="927169"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="927169"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 02:10:44 -0700
X-CSE-ConnectionGUID: jkj+o4aySsCuxsOclFc5Fg==
X-CSE-MsgGUID: XNH+hCp4T66J2kxPPOnSdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1812583"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 02:10:42 -0700
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
	adrian.hunter@intel.com,
	binbin.wu@linux.intel.com
Subject: [PATCH v5 5/5] KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM
Date: Fri, 16 Oct 2026 17:14:22 +0800
Message-ID: <20261016091422.3182216-6-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate the CPUID configuration provided by userspace through
KVM_TDX_INIT_VM against KVM's TDX allowlist, and drop the hardcoded
denylist-based check.

The TDX module lets the VMM directly configure certain CPUID bits for a TD
at initialization time, but KVM must strictly govern which of those bits
userspace can set, otherwise a feature that clobbers host state could be
enabled behind KVM's back.  The existing denylist rejects only TSX and
WAITPKG, and thus would accept any bit that a future TDX module makes
configurable, even if KVM knows nothing about the associated feature.

Add tdx_has_unsupported_cpuid_cfg_bit() and reject KVM_TDX_INIT_VM if
userspace sets any bit outside of the mask returned by
tdx_get_cpuid_cfg_mask(), i.e. the same mask used to filter
KVM_TDX_CAPABILITIES.  Don't bother intersecting the userspace input with
the bits that the TDX module reports as directly configurable, as the TDX
module itself rejects any bit outside that set.

As with the existing check, use the subleaf reported by the TDX module to
look up the allowed mask.  For leaves without subleaves, the TDX module's
"no subleaf" index is normalized to 0, which matches how such leaves are
tracked in reverse_cpuid[].

Note, the change is user-visible, as KVM_TDX_INIT_VM now rejects some
input that was previously accepted.  The ABI itself is unchanged: KVM
already rejected unsupported CPUID bits, albeit via a denylist, and
userspace has always been required to consult KVM_TDX_CAPABILITIES and set
only the bits reported as configurable.

The change isn't expected to break userspace or guests:
 - The newly rejected bits are no longer reported as configurable by
   KVM_TDX_CAPABILITIES, so userspace that honors KVM_TDX_CAPABILITIES
   won't set them.
 - CORE_CAPABILITIES, which older TDX module specs defined as fixed-1, is
   still allowed.
 - The dropped features are either obsolete or unsupported by KVM, and in
   the latter case, a guest relying on them would already have run into
   problems.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
v5:
- Update the changelog and call out the user-visible change more loudly.
  (Rick)
- Drop the description in TDX document and the uapi header, as the ABI
  itself is unchanged.
- Split the CPUID entry index check out to a separate fix patch.

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
 arch/x86/kvm/vmx/tdx.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index d617d1a0f63b..78ff0170411b 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -275,25 +275,6 @@ static void __init tdx_initialize_cpu_cfg_caps(void)
 #undef TDX_CFG_F
 #undef TDX_CFG_INDEPENDENT_F
 
-#define TDX_FEATURE_TSX (__feature_bit(X86_FEATURE_HLE) | __feature_bit(X86_FEATURE_RTM))
-
-static bool has_tsx(const struct kvm_cpuid_entry2 *entry, u32 index)
-{
-	return entry->function == 7 && index == 0 &&
-	       (entry->ebx & TDX_FEATURE_TSX);
-}
-
-static bool has_waitpkg(const struct kvm_cpuid_entry2 *entry, u32 index)
-{
-	return entry->function == 7 && index == 0 &&
-	       (entry->ecx & __feature_bit(X86_FEATURE_WAITPKG));
-}
-
-static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry, u32 index)
-{
-	return has_tsx(entry, index) || has_waitpkg(entry, index);
-}
-
 #define TDX_CPUID_ALL_ALLOWED_MASK	GENMASK_U32(31, 0)
 
 static u32 tdx_get_cpuid_cfg_non_feature_mask(u32 function, u32 index, int reg)
@@ -2565,6 +2546,14 @@ static int setup_tdparams_eptp_controls(struct kvm_cpuid2 *cpuid,
 	return 0;
 }
 
+static bool tdx_has_unsupported_cpuid_cfg_bit(const struct kvm_cpuid_entry2 *e, u32 index)
+{
+	return (e->eax & ~tdx_get_cpuid_cfg_mask(e->function, index, CPUID_EAX)) ||
+	       (e->ebx & ~tdx_get_cpuid_cfg_mask(e->function, index, CPUID_EBX)) ||
+	       (e->ecx & ~tdx_get_cpuid_cfg_mask(e->function, index, CPUID_ECX)) ||
+	       (e->edx & ~tdx_get_cpuid_cfg_mask(e->function, index, CPUID_EDX));
+}
+
 static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
 				 struct td_params *td_params)
 {
@@ -2594,7 +2583,7 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
 		 * not the index of the userspace entry, which may differ if
 		 * KVM_CPUID_FLAG_SIGNIFCANT_INDEX isn't set.
 		 */
-		if (tdx_unsupported_cpuid(entry, tmp.index))
+		if (tdx_has_unsupported_cpuid_cfg_bit(entry, tmp.index))
 			return -EINVAL;
 
 		copy_cnt++;
-- 
2.46.0

