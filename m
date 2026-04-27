Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988BE3B4EA4;
	Mon, 27 Apr 2026 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303811; cv=none; b=W0lIF9ZCEiidjuprbXy/HCPlLseqGBQVEF/azjWDLaz34O1uaxBrkXluPtuIiM3S5GQuPQCDtcrsS83ch68/ZvNJLMSWSUnTi8jR8b1b8fXoKg94P0jVWy27FnrqMjcGUw1whOuHjAhEE+7kwlYUa4x+qTxkb1BouPdcz5tcEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303811; c=relaxed/simple;
	bh=7bBCLiucmZHFHI75iF2P/vc3kyH74Banrb/S3ZoFYhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQvfGvfzJbszVYOOrNN/Sooqi3NpmDWpMt3VSvj7qofR5VCGpir2InJ8Ah5GmxIE4fRLlTSA04u4hgjU9MT5cr2P11iyCc7YAG3iOFNuK8lY4beHsXS3j3VhonCOlqXJRhad2yGijWeDZCVkpkB6NCqZyvdef1LF0fkvOSu0iqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3GvJt+U; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3GvJt+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777303810; x=1808839810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7bBCLiucmZHFHI75iF2P/vc3kyH74Banrb/S3ZoFYhI=;
  b=n3GvJt+UHwg+iBzfqT7JqpujcFUnd1ChgXuMpKvD/U7KlOzFdRn8/NDi
   3V5SeH/K5Rk5Ah87DmeNdNJBKAopB3ZWQR0bgz0xtLNca7nEh5DXL7lVZ
   bKnldLmL02KP3yDHGL/eijnQsL3Fa3vR7LPGjJ4k/s5RSkxJF5Vn4TAEe
   uxa9hsowhBpaq78CGht4JODiensr+YNXpP3QuWKOobVEZxvuk5HVTSQOD
   +3deNuA7+J+Yx9WwBFltyFg0tAOXmB1rkr3ODG1sxO7efjPwPcP/ykLMh
   d2Yi1yzRpDb2Mf67ve27zHodNBgQikmCQPmAnDFEXnOQVipJRIdYWyVlz
   w==;
X-CSE-ConnectionGUID: bmyR8/uaTJK1kc4kHU909A==
X-CSE-MsgGUID: q9WGvIhtQ6+6/LQ+3YE6gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77900785"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77900785"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:30:05 -0700
X-CSE-ConnectionGUID: OML46hBoTWm2L6OHLNxcdQ==
X-CSE-MsgGUID: nzLRMxpaRdWzm/o69g8kSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232673335"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:30:05 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: binbin.wu@linux.intel.com,
	dave.hansen@linux.intel.com,
	djbw@kernel.org,
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
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v8 16/21] x86/virt/tdx: Reject updates during concurrent TD build
Date: Mon, 27 Apr 2026 08:28:10 -0700
Message-ID: <20260427152854.101171-17-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260427152854.101171-1-chao.gao@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tl;dr: A TDX module erratum can silently corrupt TD measurement state if a
module update races with TD build. Handle that by rejecting the update,
instead of introducing new TD-build ioctl failure paths.

Long Version:

Updates must not break unrelated operations. For TDX module updates,
this means an update must not interfere with other TDX flows.

A TDX module erratum violates that expectation: if an update races with
TD build, TD build output can be corrupted, e.g. the measurement hash,
which later causes attestation failure.

The TDX module provides two independent, opt-in mitigations for this
erratum:

1. Reject updates while TD build is in progress. This mitigation can be
   requested via TDH.SYS.SHUTDOWN.

2. Do not reject the update for this race, but instead fail later
   SEAMCALLs in the overlapping TD build flow. This mitigation can be
   requested via TDH.SYS.UPDATE.

The kernel can choose option 1, option 2, or neither.

Choose option 1 to confine failures to the update path and preserve
existing TD build and KVM ioctl behavior. Userspace already controls
update timing, and retrying a rejected update is straightforward.

Option 2 would make TD build failures explicit, but it would also
introduce new error paths in existing KVM ioctls. That complicates KVM
error handling and risks ABI instability. Sean previously rejected that
approach [1].

Choosing neither option was also considered and rejected. Leaving this
erratum unhandled would allow an update racing with TD build to silently
corrupt TD build output. That violates the requirement that TDX module
updates must not interfere with unrelated TDX flows.

Request race detection during TDH.SYS.SHUTDOWN and map a detected race
to -EBUSY, and report it to userspace as FW_UPLOAD_ERR_BUSY. This lets
userspace distinguish the race from other failures and retry the update.

Do not pre-check support for this race-detection capability. If it is
unsupported, rely on the TDX module to reject module shutdown.

This implementation is based on a reference patch by Vishal [2].

Note: moving NO_RBP_MOD definition is to centralize the bit definitions.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/linux-coco/aQIbM5m09G0FYTzE@google.com/ # [1]
Link: https://lore.kernel.org/linux-coco/CAGtprH_oR44Vx9Z0cfxvq5-QbyLmy_+Gn3tWm3wzHPmC1nC0eg@mail.gmail.com/ # [2]
---
v8:
 - rewrite the changelog [Rick]
 - alway pass the compat flag to the TDX module [Rick]
---
 arch/x86/include/asm/tdx.h            | 11 +++++++++--
 arch/x86/kvm/vmx/tdx_errno.h          |  2 --
 arch/x86/virt/vmx/tdx/tdx.c           | 26 +++++++++++++++++++++++---
 arch/x86/virt/vmx/tdx/tdx.h           |  3 ---
 drivers/virt/coco/tdx-host/tdx-host.c |  2 ++
 5 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index de822ed9ef0b..b063aabe2554 100644
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
index a7dfa4ee8813..7864ab68f4e3 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1234,10 +1234,13 @@ static __init int tdx_enable(void)
 }
 subsys_initcall(tdx_enable);
 
+#define TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE BIT(16)
+
 int tdx_module_shutdown(void)
 {
 	struct tdx_sys_info_handoff handoff = {};
 	struct tdx_module_args args = {};
+	u64 err;
 	int ret, cpu;
 
 	ret = get_tdx_sys_info_handoff(&handoff);
@@ -1248,9 +1251,26 @@ int tdx_module_shutdown(void)
 	 * module can produce and most likely supported by newer modules.
 	 */
 	args.rcx = handoff.module_hv;
-	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
-	if (ret)
-		return ret;
+
+	/*
+	 * Mitigate the erratum where updates can break concurrent TD
+	 * build. Do not pre-check support for this flag. If unsupported,
+	 * rely on the TDX module to reject shutdown requests.
+	 */
+	args.rcx |= TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE;
+
+	err = seamcall(TDH_SYS_SHUTDOWN, &args);
+
+	/*
+	 * Return -EBUSY to signal that some ongoing flows are incompatible
+	 * with updates so that userspace can retry.
+	 */
+	if ((err & TDX_SEAMCALL_STATUS_MASK) == TDX_UPDATE_COMPAT_SENSITIVE)
+		return -EBUSY;
+	if (err) {
+		seamcall_err(TDH_SYS_SHUTDOWN, err, &args);
+		return -EIO;
+	}
 
 	/*
 	 * Clear global and per-CPU initialization flags so the new module
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index d0e8cac9c1d5..2c8b64eeea8e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -86,9 +86,6 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
-/* Bit definitions of TDX_FEATURES0 metadata field */
-#define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
-
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index d9bb1e7ef795..14f861c03be4 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -127,6 +127,8 @@ static enum fw_upload_err tdx_fw_write(struct fw_upload *fwl, const u8 *data,
 	case 0:
 		*written = size;
 		return FW_UPLOAD_ERR_NONE;
+	case -EBUSY:
+		return FW_UPLOAD_ERR_BUSY;
 	default:
 		return FW_UPLOAD_ERR_FW_INVALID;
 	}
-- 
2.47.1

