Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175213;
	b=Bhii0UCm9gNuhTluDFwaMD3kmNX+seuMysNKOpVzU8ysjAsuVow4+cy6AveBSxA4XvtZ
	 7Kcx2b16IuI3V2pgntjpqPzccFbnL/Hhoa/FQQYA0pAKQ6IzkYmrRaYqA16CMTJOGehGF
	 xt2yqh26l3FbbA5vgeYBntPajlYH7C2DyAJbtsWhklChx/biJWtNqS6RRBg9QxWIiT/CH
	 W9gFF4kOehTQEJ0YeBVodRiJXyWvynQWBvpAWFxGLZkec/a+T21b0ByWRgs6T3fTtlEjy
	 YbMcZMLEh0/AO+l9vWxGBPqoIqdVsBBk7q4l27OfCcKmAzPTN6RxFtsm623E6Xro9gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175213;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=760A5nXuvA28x8FKbN7T+QLZhZJOV7PRxSzf47CFf14=;
	b=3IhBSOINlFTurLXB4euALaABlWALBTW7YtqZGoiu8OdHPDRa4COq1DbFSb9uso3btUo/
	 rDI/cjgcxMpeBSOxl8YVL9ymCKNkYkXZh6CUG722DzS+B3LAbiXdgL6YnMbtwZVZOd4wT
	 DwQ5Ocx1s5HQcN90oAEkGOdGQtNjtWXe6i/nmVZy1bpTDS75vSLpioW9V/gymiZipmXjm
	 JoclKqpJj2Kz44HEnvBNmK+66dP99PGvewKgIbTCaYlI+P6wmwC+C52Lc65q+7IkOsCAa
	 Cgvoo1JVIW+C8BGZwrpALdVZ8kDXsEzQRCz29yF4PduhQex9jQTnSxs18S5hMKvOHxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BuX16grn;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5412E606A322;
	Wed, 28 Oct 2026 08:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5412E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BuX16grn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793175214; x=1824711214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f38/FdJ4kqW1fCPVjApNDbzccbh82U1kw1iCz6K37Ok=;
  b=BuX16grnLwFzP6Ou6muKGcKtgJaNF+CDLJtKvwOUuWn9Qd69cFDeVqWG
   vBdvYrRaVTIvXul0KGpWRNp5M22GYbMagqqTJD2F1x2yMFVA6OC967M1l
   LjhmeJlm7tvu/1DwhJ+1y7UMsAod6g5/51UYDx5j7b1SBLvUfdblIpkIW
   Magt+LydBGEXSAqFBsW6JOyntkpZf5l02TArAy0lGcDt0HtcfPGjtfsvX
   lFZR0mVyM964NaC6ID6GrYBdT47V0Qcob74L6SClCWoJvHEUBS9q1dBwu
   6E9JcUSTRbCn/ej4AtPMzPSOOwrl5iwxjUk7h6sL8GALyX0Lhdi4WYHBm
   w==;
X-CSE-ConnectionGUID: rj2Nq4qIS+mttYRIAcyQow==
X-CSE-MsgGUID: wlG0GoXKRl6wmtbLgoe2SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1902961"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1902961"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:13:34 -0700
X-CSE-ConnectionGUID: Q0+RUEyMQ/mK3IP9MGhgHQ==
X-CSE-MsgGUID: r6ztB3Q2T4SP5ng2r1Q5GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5118515"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:13:28 -0700
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
Subject: [PATCH v6 4/4] KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM
Date: Wed, 28 Oct 2026 16:16:57 +0800
Message-ID: <20261028081658.1228484-5-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261028081658.1228484-1-binbin.wu@linux.intel.com>
References: <20261028081658.1228484-1-binbin.wu@linux.intel.com>
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

Validate the CPUID configuration provided by userspace through
KVM_TDX_INIT_VM against KVM's TDX allowlist, and drop the hardcoded
denylist-based check.

The TDX module lets the VMM directly configure certain CPUID bits for a TD
at initialization time, but KVM must strictly govern which of those bits
userspace can set, otherwise a feature that clobbers host state could be
enabled behind KVM's back.  The existing denylist rejects only TSX and
WAITPKG, and thus would accept any bit that a future TDX module makes
configurable, even if KVM knows nothing about the associated feature.

Rewrite tdx_is_unsupported_cpuid_entry() to reject KVM_TDX_INIT_VM if
userspace sets any bit outside of the mask returned by
tdx_get_cpuid_cfg_mask(), i.e. the same mask used to filter
KVM_TDX_CAPABILITIES.  Don't bother intersecting the userspace input with
the bits that the TDX module reports as directly configurable, as the TDX
module itself rejects any bit outside that set.

Ignore the index for non-indexed functions when walking reverse_cpuid[],
as userspace isn't required to zero it.

Note, this is an ABI change, as KVM_TDX_INIT_VM now rejects some input
that was previously accepted.  However, the semantics of KVM_TDX_INIT_VM
are unchanged: KVM already rejected unsupported CPUID bits, albeit via a
denylist, and userspace has always been required to consult
KVM_TDX_CAPABILITIES and set only the bits reported as configurable.

The change isn't expected to break userspace or guests:
 - The newly rejected bits are no longer reported as configurable by
   KVM_TDX_CAPABILITIES, so userspace that honors KVM_TDX_CAPABILITIES
   won't set them.
 - CORE_CAPABILITIES, which older TDX module specs defined as fixed-1, is
   still allowed.
 - The newly rejected features are either obsolete or unsupported by KVM,
   and in the latter case, a guest relying on them would already have run
   into problems.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
v6:
- Rebased on patch series "x86/cpuid: KVM: TDX CPUID fixes"
  https://lore.kernel.org/all/20261022210134.612848-1-seanjc@google.com
- Ignore the index for non-indexed functions when walking reverse_cpuid[].
- Fix the changelog on ABI change. (Rick)
- Collected RBs. (Rick, Chao, Xiaoyao)

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
 arch/x86/kvm/vmx/tdx.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 0741c3ef4745e..9b4e7db555347 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -276,29 +276,6 @@ static void __init tdx_initialize_cpu_cfg_caps(void)
 #undef TDX_CFG_F
 #undef TDX_CFG_INDEPENDENT_F
 
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
-static bool tdx_is_unsupported_cpuid_entry(const struct kvm_cpuid_entry2 *entry)
-{
-	if (cpuid_function_is_indexed(entry->function) !=
-	    !!(entry->flags & KVM_CPUID_FLAG_SIGNIFCANT_INDEX))
-		return true;
-
-	return has_tsx(entry) || has_waitpkg(entry);
-}
-
 #define TDX_CPUID_ALL_ALLOWED_MASK	GENMASK_U32(31, 0)
 
 static u32 tdx_get_cpuid_cfg_non_feature_mask(u32 function, u32 index, int reg)
@@ -334,14 +311,16 @@ static u32 tdx_get_cpuid_cfg_non_feature_mask(u32 function, u32 index, int reg)
 
 static u32 tdx_get_cpuid_cfg_feature_mask(u32 function, u32 index, int reg)
 {
+	bool is_indexed = cpuid_function_is_indexed(function);
+
 	for (int i = 0; i < NR_KVM_CPU_CAPS; i++) {
 		const struct cpuid_reg *cpuid = &reverse_cpuid[i];
 
 		if (!cpuid->function)
 			continue;
 
-		if (cpuid->function == function && cpuid->index == index &&
-		    cpuid->reg == reg)
+		if (cpuid->function == function &&
+		    (!is_indexed || cpuid->index == index) && cpuid->reg == reg)
 			return tdx_cpu_cfg_caps[i];
 	}
 
@@ -433,6 +412,18 @@ static int init_kvm_tdx_caps(const struct tdx_sys_info_td_conf *td_conf,
 	return 0;
 }
 
+static bool tdx_is_unsupported_cpuid_entry(const struct kvm_cpuid_entry2 *entry)
+{
+	if (cpuid_function_is_indexed(entry->function) !=
+	    !!(entry->flags & KVM_CPUID_FLAG_SIGNIFCANT_INDEX))
+		return true;
+
+	return (entry->eax & ~tdx_get_cpuid_cfg_mask(entry->function, entry->index, CPUID_EAX)) ||
+	       (entry->ebx & ~tdx_get_cpuid_cfg_mask(entry->function, entry->index, CPUID_EBX)) ||
+	       (entry->ecx & ~tdx_get_cpuid_cfg_mask(entry->function, entry->index, CPUID_ECX)) ||
+	       (entry->edx & ~tdx_get_cpuid_cfg_mask(entry->function, entry->index, CPUID_EDX));
+}
+
 /*
  * Some SEAMCALLs acquire the TDX module globally, and can fail with
  * TDX_OPERAND_BUSY.  Use a global mutex to serialize these SEAMCALLs.
-- 
2.46.0

