Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A83E5EFF;
	Tue, 31 Mar 2026 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961017; cv=none; b=qdEK3atQffAkreRX6AFiSbXtLFGjFFuv0e7GEcqVQWkr522rWHSj0XTqMx0edgpJImk7yuE85aFDRK+1w06hrTRENwBl1LzO5IgCv0CFq5zu3vYVanX+OtlHbs9ZTCtnTYYGVot45h6OyP8r47gn3eVGfO73mYsycRO1GYdIGbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961017; c=relaxed/simple;
	bh=QUz8IW/znHh6fFXzsaBjm2lfyPy6z0YcRiJPFTLz70w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X64PCkPIw/zVphUfTuR+EDJgjSiLxrG22eMZYrMne0fx8uP6GOpANGVEEJtzGgiFk06LPNrJzGieRyGLNOytY+NT3cpyyKDLI20/au3tqOmOJesNed5j0YSopmOhiFffyuAMHxoFUCj3wlq6mSewvACywXbJVvxBftDA7071C6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUEEE2mn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUEEE2mn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774961014; x=1806497014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QUz8IW/znHh6fFXzsaBjm2lfyPy6z0YcRiJPFTLz70w=;
  b=GUEEE2mnHd4sfsTy7y5x908EIX8q0xD7YFZg5fMhaWw34e7Esw+Pe81z
   zfW06114jCSAhd8FORAl8UGReQTW/2MJzGg1WqDcs4Kvy0hG184G1CWnz
   g6XQPI+BaBNVMZlKrkS5wJXaxHs+jL8tc02PfCgbKJ+4qlUbdAW3UusgO
   YuzEbnUgrSAidC3hCZdx35wzqEu33cOFFq/g2BoUQMbZVhfuuTsG9PXHX
   rQ2Gsb/mjMxe23Fq5k8pPEoVvN+pYJYPt9ash+PVJ/OwzVEA8HKMuVPBS
   3fAet2JKVGBZx94qgse2ulQ0gpkWCaevItBUK5JYEKG6JpL8W3uri9Gtb
   Q==;
X-CSE-ConnectionGUID: frrmCC2tSvmhrI5HZSJapw==
X-CSE-MsgGUID: LZ1rXDMiQzKm1HgFvAz4+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76084526"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76084526"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:33 -0700
X-CSE-ConnectionGUID: WsB5aApQQlmec3DGTW4+3Q==
X-CSE-MsgGUID: p8r0xjzCQZyId02VIqOrXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221492129"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:32 -0700
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
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v7 12/22] x86/virt/tdx: Reset software states during TDX module shutdown
Date: Tue, 31 Mar 2026 05:41:25 -0700
Message-ID: <20260331124214.117808-13-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331124214.117808-1-chao.gao@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX module requires a one-time global initialization (TDH.SYS.INIT) and
per-CPU initialization (TDH.SYS.LP.INIT) before use. These initializations
are guarded by software flags to prevent repetition.

After TDX module updates, the new TDX module requires the same global and
per-CPU initializations, but the existing software flags prevent
re-initialization.

Reset all software flags guarding the initialization flows to allow the
global and per-CPU initializations to be triggered again after updates.

Set tdx_module_status to ERROR to indicate the module is unavailable. This
is to prevent re-initialization/tdx_sysinfo reporting on a failed update.
Using ERROR instead of UNINITIALIZED as the latter implicitly depends on
get_tdx_sys_info() failing early to prevent re-init after successful
shutdown followed by failed update.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
v7:
 - Use ERROR instead of UNINITIALIZED for tdx_module_status. Both work,
   but UNINITIALIZED implicitly depends on get_tdx_sys_info() failing
   early to prevent re-initialization after successful shutdown followed
   by failed update

 - add a comment to explain why no lock is held and re-initialization
   isn't a problem.
v6:
 - reset tdx_lp_initialized for offlined CPUs and update the comment
   accordingly [Kai]
v5:
 - add a comment to clarify why state access doesn't require holding a
   lock. [Kai]
---
 arch/x86/virt/vmx/tdx/tdx.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index f87fad429f4e..4c9565d507fe 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -55,6 +55,8 @@ static struct tdmr_info_list tdx_tdmr_list;
 
 static enum tdx_module_status_t tdx_module_status;
 static DEFINE_MUTEX(tdx_module_lock);
+static bool sysinit_done;
+static int sysinit_ret;
 
 /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
 static LIST_HEAD(tdx_memlist);
@@ -70,8 +72,6 @@ static int try_init_module_global(void)
 {
 	struct tdx_module_args args = {};
 	static DEFINE_RAW_SPINLOCK(sysinit_lock);
-	static bool sysinit_done;
-	static int sysinit_ret;
 
 	lockdep_assert_irqs_disabled();
 
@@ -1179,6 +1179,7 @@ EXPORT_SYMBOL_FOR_KVM(tdx_enable);
 int tdx_module_shutdown(void)
 {
 	struct tdx_module_args args = {};
+	int ret, cpu;
 
 	/*
 	 * Shut down the TDX module and prepare handoff data for the next
@@ -1188,7 +1189,31 @@ int tdx_module_shutdown(void)
 	 * modules as new modules likely have higher handoff version.
 	 */
 	args.rcx = tdx_sysinfo.handoff.module_hv;
-	return seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
+	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
+	if (ret)
+		return ret;
+
+	/*
+	 * Mark the module is unavailable (in ERROR status) to prevent
+	 * re-initialization and tdx_sysinfo reporting. Note the status
+	 * will be restored after a successful update.
+	 *
+	 * No need to acquire tdx_module_lock here since this runs in
+	 * stop_machine() where no concurrent initialization can occur.
+	 */
+	tdx_module_status = TDX_MODULE_ERROR;
+	sysinit_done = false;
+	sysinit_ret = 0;
+
+	/*
+	 * Since the TDX module is shut down and gone, mark all CPUs
+	 * (including offlined ones) as uninitialized. This is called in
+	 * stop_machine() (where CPU hotplug is disabled), preventing
+	 * races with other tdx_lp_initialized accesses.
+	 */
+	for_each_possible_cpu(cpu)
+		per_cpu(tdx_lp_initialized, cpu) = false;
+	return 0;
 }
 
 static bool is_pamt_page(unsigned long phys)
-- 
2.47.3

