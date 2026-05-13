Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624BF4D9918;
	Wed, 13 May 2026 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685123; cv=none; b=S8ayyTsbuXN7s7vyuS3UyI0WIVXT9Rh7eIpgZibW8C1PAYXKyX4gWQNWb3arN0KF3aVgR9d55rrYCxWRwnssvCPjXo1Dqvs0Jg6xMTXb8ZU14Hmv50rNhQxqA7n689Q3luxmdwMU0lu7uh1vAjbJnIXotz1U3jMP5AoboVURT+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685123; c=relaxed/simple;
	bh=i9WOcanhTAn5ETWDOWE5GSQybjpHUnROCBLLlQF1bBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAnJbNZA1Lp5m3ALmqazXRo99KI9FrUrhlFddErU9IJ3dMGX5Ro/X2sEfCEjhgOkEu1VoN6wfIWTdnglXi3qTvnlFvS84aLgqE7ajKkUKISqME/yx5caiZVFumHr3oAWGl8YlAsKKZ1EsHvt9Dq0RrPMLSeAGDtmfGlUmtgvrEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7+9gq0F; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7+9gq0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685122; x=1810221122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i9WOcanhTAn5ETWDOWE5GSQybjpHUnROCBLLlQF1bBw=;
  b=E7+9gq0FbxoIU1qcRZd5Vh+IxAF3SAZjDNqGkeg9v864JRooFfW8d/Ny
   yx0dRA6hp5UheUeSxf4STdFWQTrt0fTjvbGn3HhXjZju6UE8T7TFlRzbp
   fLeiM1UamkQJa4xSEj2kb8BpvNDjI+ijbiwHwcPHnAtms4HcmhRpHKU+h
   THh1CtrT00oyb3MoDBhJNjUk65cpLV3PptFV3KurhyNmRFGxP9VoJdWKq
   1X2MZP4bu2a2ilYdPj7XnXAOPL0NXAnDPomp0DFtDsLez8zP67Bnq/RFz
   TKTp0aX4MqGul0gr+kqNdOm+8fSpIlRGI5nqC79uthvVXtYHPdzDMboJy
   Q==;
X-CSE-ConnectionGUID: vE9iQ5/WT4aMkDDir38rSw==
X-CSE-MsgGUID: s1LDKerHSmWFg0n2YxtUCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921801"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921801"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:59 -0700
X-CSE-ConnectionGUID: 3aVINOlxRoS6JhmVBX9Ezg==
X-CSE-MsgGUID: ZKG9/6SFRG+5AKK3w90/aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716916"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:59 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
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
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v9 20/23] x86/virt/tdx: Reject updates during compatibility-sensitive operations
Date: Wed, 13 May 2026 08:10:03 -0700
Message-ID: <20260513151045.1420990-21-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513151045.1420990-1-chao.gao@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A TDX module erratum can corrupt TD state if a module update races with
a compatibility-sensitive operation. For example, if an update races
with TD build, the TD measurement hash may be corrupted, which can later
cause attestation failure.

Handle this by requesting the TDX module to detect such races during
TDH.SYS.SHUTDOWN and reject the update when one is found. Report the
failure to userspace as -EBUSY so the update can be retried.

The downside is that module updates can be blocked indefinitely if
compatibility-sensitive operations do not quiesce. In that case,
userspace must resolve the conflict and retry the update.

Do not pre-check whether the TDX module supports this race-detection
capability. If it does not, rely on the TDX module to reject module
shutdown.

== Alternatives ==

Two alternatives were considered and rejected [1]:

  a. Fail TD build when the race occurs. This would complicate KVM error
     handling and risk KVM uABI instability.

  b. Allow the issue to leak through. This would make the problem harder to
     detect and recover from.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/linux-coco/aQIbM5m09G0FYTzE@google.com/ # [1]
---
v9:
 - Rewrite the changelog: focus on what the patch does and downsides then
   the alternatives [Dave]
 - Extract the movement of TDX_FEATURE0 bit definitions into a cleanup patch [Dave]
---
 arch/x86/include/asm/tdx.h            |  6 ++++--
 arch/x86/virt/vmx/tdx/tdx.c           | 30 ++++++++++++++++++++++++---
 drivers/virt/coco/tdx-host/tdx-host.c |  2 ++
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 5d750fe53669..1e1bdc4ec9c8 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -29,11 +29,13 @@
 /*
  * TDX module SEAMCALL leaf function error codes
  */
-#define TDX_SUCCESS		0ULL
-#define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
+#define TDX_SUCCESS			0ULL
+#define TDX_RND_NO_ENTROPY		0x8000020300000000ULL
+#define TDX_UPDATE_COMPAT_SENSITIVE	0x8000051200000000ULL
 
 /* Bit definitions of TDX_FEATURES0 metadata field */
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
+#define TDX_FEATURES0_UPDATE_COMPAT	BIT_ULL(47)
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index a04b69f77c6e..2ab6f6efe6d1 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1267,11 +1267,14 @@ static __init int tdx_enable(void)
 }
 subsys_initcall(tdx_enable);
 
+#define TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE BIT(16)
+
 int tdx_module_shutdown(void)
 {
 	struct tdx_sys_info_handoff handoff = {};
 	struct tdx_module_args args = {};
 	int ret, cpu;
+	u64 err;
 
 	ret = get_tdx_sys_info_handoff(&handoff);
 	WARN_ON_ONCE(ret);
@@ -1281,9 +1284,30 @@ int tdx_module_shutdown(void)
 	 * module can produce and most likely supported by newer modules.
 	 */
 	args.rcx = handoff.module_hv;
-	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
-	if (ret)
-		return ret;
+
+	/*
+	 * This flag tells the TDX module to reject shutdown if it races
+	 * with a "sensitive" ongoing operation. That eliminates exposure
+	 * to a TDX erratum which can corrupt TDX guest states.
+	 *
+	 * This flag is not supported by all TDX modules and may cause
+	 * the shutdown (and subsequent update procedure) to fail.
+	 */
+	args.rcx |= TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE;
+
+	err = seamcall(TDH_SYS_SHUTDOWN, &args);
+
+	/*
+	 * The shutdown ran into a "sensitive" ongoing operation. Signal
+	 * to userspace that it can retry.
+	 */
+	if ((err & TDX_SEAMCALL_STATUS_MASK) == TDX_UPDATE_COMPAT_SENSITIVE)
+		return -EBUSY;
+
+	if (err) {
+		seamcall_err(TDH_SYS_SHUTDOWN, err, &args);
+		return -EIO;
+	}
 
 	/*
 	 * Clear global and per-CPU initialization flags so the new module
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index c4c099cf3de1..ad116e56aa1a 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -135,6 +135,8 @@ static enum fw_upload_err tdx_fw_write(struct fw_upload *fwl, const u8 *data,
 	case 0:
 		*written = size;
 		return FW_UPLOAD_ERR_NONE;
+	case -EBUSY:
+		return FW_UPLOAD_ERR_BUSY;
 	default:
 		return FW_UPLOAD_ERR_FW_INVALID;
 	}
-- 
2.52.0

