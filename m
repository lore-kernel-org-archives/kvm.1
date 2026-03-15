Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70379368282;
	Sun, 15 Mar 2026 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583190; cv=none; b=NZnQe2HyQAXKo3dop+r/bgzPGDiwi8rnjDNYbcy2QX4SPRn5uSym7JCor4qqgQquIsXO+ghRuo4sFEFLKRzGRH/ZK+uP8YTVdA7T5EiS2S9OunEIsHBr/GvF5ArLRO4wu9ngiUruG0U+V70dDwewgN3gOTpBy4yAmLxjv+pR+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583190; c=relaxed/simple;
	bh=bbsEVrsCZXv9NRjeuz4IhBm5aaC1Wm/j1HLFR49O5Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUkINULsm81eoaA5mUQe6uiaTiMTS8wRDWANwWfuImoDbkajupDW6OCNJbvdT3PBgF27EKszP6OHODYhvyLgLBR4DYcdwiTYXjmcPaWmAaE8ZtR/NN9thd+u3TjEd5ALTWtF8SBS0MxqSjXzp2JQ14eVk6K1D7RlOw8WTdZ//I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRJGNHhD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRJGNHhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773583188; x=1805119188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bbsEVrsCZXv9NRjeuz4IhBm5aaC1Wm/j1HLFR49O5Sc=;
  b=dRJGNHhD1geyDkSKTpjMYQ+Ff7kqwhdufVp0u2E/oprJyt1StIAMhzaL
   TYfitCm+PaEg8Ke9JWnKCrc1Ao2hGEFKz6gQQFguzwIKFWsxi730gKsNP
   IRQXPBp9EYSlu5l+oKlP0aHE8HsT8D3Bk5swQiurPMwU6vRSsOnRHwbxH
   sbzwuAD29MuTOEth6+hTvHsvnmZ4Bj7pjrN2zxftj3iE4KkIqGB/vtr2l
   JiaLIGpvI9hE86ETi+gutdyyGveHgqB6oYqhaJW4Iq1hoGzpsIPMT0RTX
   PWfLmvCqeVXjG/tFmgy2/AsVQ0tqBXJ7bONZcZBz5UHUDn5PYvfE4b34H
   g==;
X-CSE-ConnectionGUID: VbaZbA/rRfiGgKibmM2Wpw==
X-CSE-MsgGUID: I3kQXKDTQnCT8Eyhih0nOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74732543"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="74732543"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:44 -0700
X-CSE-ConnectionGUID: j+7GDNfAQjOEaXyMGLY19A==
X-CSE-MsgGUID: c0IIjA9CQy2rWprba0oKrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="226123073"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:44 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	kas@kernel.org,
	nik.borisov@suse.com,
	paulmck@kernel.org,
	pbonzini@redhat.com,
	reinette.chatre@intel.com,
	rick.p.edgecombe@intel.com,
	sagis@google.com,
	seanjc@google.com,
	tony.lindgren@linux.intel.com,
	vannapurve@google.com,
	vishal.l.verma@intel.com,
	yilun.xu@linux.intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 17/22] x86/virt/tdx: Avoid updates during update-sensitive operations
Date: Sun, 15 Mar 2026 06:58:37 -0700
Message-ID: <20260315135920.354657-18-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315135920.354657-1-chao.gao@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A runtime TDX module update can conflict with TD lifecycle operations that
are update-sensitive.

Today, update-sensitive operations include:

- TD build: TD measurement is accumulated across multiple
  TDH.MEM.PAGE.ADD, TDH.MR.EXTEND, and TDH.MR.FINALIZE calls.

- TD migration: intermediate crypto state is saved/restored across
  interrupted/resumed TDH.EXPORT.STATE.* and TDH.IMPORT.STATE.* flows.

If an update races TD build, for example, TD measurement can become
incorrect and attestation can fail.

The TDX architecture exposes two approaches:

1) Avoid updates during update-sensitive operations.
2) Detect incompatibility after update and recover.

Post-update detection (option #2) is not a good fit: as discussed in [1],
future module behavior may expand update-sensitive operations in ways that
make post-update detection fragile for existing KVM userspace APIs.

"Do nothing" is also not preferred: while it keeps kernel code simple, it
lets the issue leak into the broader stack, where both detection and
recovery require significantly more effort.

So, use option #1. Specifically, request "avoid update-sensitive" behavior
during TDX module shutdown and map the resulting failure to -EBUSY so
userspace can distinguish an update race from other failures.

Do not disable updates when option #1 is unavailable. In that case,
effectively fall back to "do nothing", and set the expectation for
userspace to "update your module at your own risk".

Note: this implementation is based on a reference patch by Vishal [2].
Note2: moving "NO_RBP_MOD" is just to centralize bit definitions.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Link: https://lore.kernel.org/linux-coco/aQIbM5m09G0FYTzE@google.com/ # [1]
Link: https://lore.kernel.org/linux-coco/CAGtprH_oR44Vx9Z0cfxvq5-QbyLmy_+Gn3tWm3wzHPmC1nC0eg@mail.gmail.com/ # [2]
---
 arch/x86/include/asm/tdx.h   | 16 ++++++++++++++--
 arch/x86/kvm/vmx/tdx_errno.h |  2 --
 arch/x86/virt/vmx/tdx/tdx.c  | 23 +++++++++++++++++++----
 arch/x86/virt/vmx/tdx/tdx.h  |  3 ---
 4 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index b3a7301e77c6..4c4f7acd4044 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -26,11 +26,18 @@
 #define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
 #define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)
 
+#define TDX_SEAMCALL_STATUS_MASK		0xFFFFFFFF00000000ULL
+
 /*
  * TDX module SEAMCALL leaf function error codes
  */
-#define TDX_SUCCESS		0ULL
-#define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
+#define TDX_SUCCESS			0ULL
+#define TDX_RND_NO_ENTROPY		0x8000020300000000ULL
+#define TDX_UPDATE_COMPAT_SENSITIVE	0x8000051200000000ULL
+
+/* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
+#define TDX_FEATURES0_UPDATE_COMPAT	BIT_ULL(47)
 
 #ifndef __ASSEMBLER__
 
@@ -109,6 +116,11 @@ static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinf
 	return false;
 }
 
+static inline bool tdx_supports_update_compatibility(const struct tdx_sys_info *sysinfo)
+{
+	return sysinfo->features.tdx_features0 & TDX_FEATURES0_UPDATE_COMPAT;
+}
+
 int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
diff --git a/arch/x86/kvm/vmx/tdx_errno.h b/arch/x86/kvm/vmx/tdx_errno.h
index 6ff4672c4181..215c00d76a94 100644
--- a/arch/x86/kvm/vmx/tdx_errno.h
+++ b/arch/x86/kvm/vmx/tdx_errno.h
@@ -4,8 +4,6 @@
 #ifndef __KVM_X86_TDX_ERRNO_H
 #define __KVM_X86_TDX_ERRNO_H
 
-#define TDX_SEAMCALL_STATUS_MASK		0xFFFFFFFF00000000ULL
-
 /*
  * TDX SEAMCALL Status Codes (returned in RAX)
  */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 98682c4a383a..2025d00b0567 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1176,10 +1176,13 @@ int tdx_enable(void)
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_enable);
 
+#define TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE BIT(16)
+
 int tdx_module_shutdown(void)
 {
 	struct tdx_module_args args = {};
-	int ret, cpu;
+	u64 ret;
+	int cpu;
 
 	/*
 	 * Shut down the TDX module and prepare handoff data for the next
@@ -1189,9 +1192,21 @@ int tdx_module_shutdown(void)
 	 * modules as new modules likely have higher handoff version.
 	 */
 	args.rcx = tdx_sysinfo.handoff.module_hv;
-	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
-	if (ret)
-		return ret;
+
+	if (tdx_supports_update_compatibility(&tdx_sysinfo))
+		args.rcx |= TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE;
+
+	ret = seamcall(TDH_SYS_SHUTDOWN, &args);
+
+	/*
+	 * Return -EBUSY to signal that there is one or more ongoing flows
+	 * which may not be compatible with an updated TDX module, so that
+	 * userspace can retry on this error.
+	 */
+	if ((ret & TDX_SEAMCALL_STATUS_MASK) == TDX_UPDATE_COMPAT_SENSITIVE)
+		return -EBUSY;
+	else if (ret)
+		return -EIO;
 
 	tdx_module_status = TDX_MODULE_UNINITIALIZED;
 	sysinit_done = false;
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index f8686247c660..2435f88c6994 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -88,9 +88,6 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
-/* Bit definitions of TDX_FEATURES0 metadata field */
-#define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
-
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
-- 
2.47.3

