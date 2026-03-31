Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24793E5EFE;
	Tue, 31 Mar 2026 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961014; cv=none; b=GT4VGkEuLDklyU2SlvISxcjPZH/3OFa68bp1Durui66Rm+k4FLjO/cbWTxi5+QjNxRPdZUv2Uuatcbw1Za4jT+90S9CKlamOtP8Ck8ZLY+fpjTiwWiB0t3YCpJC7IDaTy6Mq036Ll3fHHIhl2vfxLOp5g5wThE6LoqUAnpGuYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961014; c=relaxed/simple;
	bh=lR/qyIK7SspLK5c6BWwm1ShqRyRCf54QcosDdPdoMZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFEbNIBY/Ak0jBvIbQgAiOwngU/7fbRmuVUxCL9VnPVNIUmbZqPoFseBB6Ul+3Rwtltp+v240sC6iVJ/cu1oxcH29ltkVcAU4Fyviq/PmZWCUiLd/2iLTbaE2aRsqA1wxPQPLhmxEVHf0fFKaEKctVPkh8DUdzLCOvonJEl3g88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCzACOFU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCzACOFU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774961012; x=1806497012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lR/qyIK7SspLK5c6BWwm1ShqRyRCf54QcosDdPdoMZo=;
  b=mCzACOFUbATxVG8gADCP5W9qyzJcQyeZISZ2jNO1OLjKtAmdDVwjNSCf
   Y2fu8hFLjC2wC1Yt0EwM8Tz16PuXoCHo2OWz2Hze/Zl0L7fd+oZHEJVQV
   Op8/FydyadMc8VxHih6VBk3v+CKLDNncsfCVacFTVX7eaVPcoYWSH+1FV
   z+UyGBKp0Mpq6zKxzC4EMHEwJBVUJXma4kL6hOIfvcij6nR1l2jKIB/uw
   kZbaUw7bj0Mh66mo7QPLWYB0rb6qbjyO/4NZhmjk7kmegkO8u7fzg1cNw
   /TN7Tbev5m67O0IyBdtrZrrEDmLNN1oMLPFsZYBmIKWqptBW6h3Kg67Bx
   w==;
X-CSE-ConnectionGUID: VRl1j40LSneshCUxsFoDaQ==
X-CSE-MsgGUID: UMEssVxDR0atdf+McXa0KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76084501"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76084501"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:29 -0700
X-CSE-ConnectionGUID: ijcyw1JgR4KHE2yGP9VSjw==
X-CSE-MsgGUID: J4UaC9TlTIOdKoBD/xpVjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221492115"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:28 -0700
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
Subject: [PATCH v7 09/22] x86/virt/seamldr: Introduce skeleton for TDX module updates
Date: Tue, 31 Mar 2026 05:41:22 -0700
Message-ID: <20260331124214.117808-10-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331124214.117808-1-chao.gao@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TDX module updates require careful synchronization with other TDX
operations. The requirements are (#1/#2 reflect current behavior that
must be preserved):

1. SEAMCALLs need to be callable from both process and IRQ contexts.
2. SEAMCALLs need to be able to run concurrently across CPUs
3. During updates, only update-related SEAMCALLs are permitted; all
   other SEAMCALLs shouldn't be called.
4. During updates, all online CPUs must participate in the update work.

No single lock primitive satisfies all requirements. For instance,
rwlock_t handles #1/#2 but fails #4: CPUs spinning with IRQs disabled
cannot be directed to perform update work.

Use stop_machine() as it is the only well-understood mechanism that can
meet all requirements.

And TDX module updates consist of several steps (See Intel® Trust Domain
Extensions (Intel® TDX) Module Base Architecture Specification, Chapter
"TD-Preserving TDX module Update"). Ordering requirements between steps
mandate lockstep synchronization across all CPUs.

multi_cpu_stop() is a good example of performing a multi-step task in
lockstep. But it doesn't synchronize steps within the callback function
it takes. So, implement one based on its pattern to establish the
skeleton for TDX module updates. Specifically, add a global state
machine where each state represents a step in the update flow. The state
advances only after all CPUs acknowledge completing their work in the
current state. This acknowledgment mechanism is what ensures lockstep
execution.

Potential alternative to stop_machine()
=======================================
An alternative approach is to lock all KVM entry points and kick all
vCPUs. Here, KVM entry points refer to KVM VM/vCPU ioctl entry points,
implemented in KVM common code (virt/kvm). Adding a locking mechanism
there would affect all architectures KVM supports. And to lock only TDX
vCPUs, new logic would be needed to identify TDX vCPUs, which the KVM
common code currently lacks. This would add significant complexity and
maintenance overhead to KVM for this TDX-specific use case.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
v7:
 - hold cpu hotplug lock before updates as the online cpu count should
   be stable otherwise forward progress isn't guaranteed.

v5:
 - rewrite the commit message [Rick]
 - use a lock to synchronize accesses to update_data [Dave]
 - rename tdp_state and tdp_data to module_update_state and update_data
   for clarity [Kai]

v2:
 - refine the changlog to follow context-problem-solution structure
 - move alternative discussions at the end of the changelog
 - add a comment about state machine transition
 - Move rcu_momentary_eqs() call to the else branch.
---
 arch/x86/virt/vmx/tdx/seamldr.c | 84 ++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 219a8e0c7127..3bcde3fd94a6 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -7,8 +7,10 @@
 #define pr_fmt(fmt)	"seamldr: " fmt
 
 #include <linux/mm.h>
+#include <linux/nmi.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/stop_machine.h>
 
 #include <asm/seamldr.h>
 
@@ -197,6 +199,77 @@ static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
 	return alloc_seamldr_params(module, module_size, sig, sig_size);
 }
 
+/*
+ * During a TDX module update, all CPUs start from MODULE_UPDATE_START and
+ * progress to MODULE_UPDATE_DONE. Each state is associated with certain
+ * work. For some states, just one CPU needs to perform the work, while
+ * other CPUs just wait during those states.
+ */
+enum module_update_state {
+	MODULE_UPDATE_START,
+	MODULE_UPDATE_DONE,
+};
+
+static struct {
+	enum module_update_state state;
+	int thread_ack;
+	/*
+	 * Protect update_data. Raw spinlock as it will be acquired from
+	 * interrupt-disabled contexts.
+	 */
+	raw_spinlock_t lock;
+} update_data = {
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(update_data.lock)
+};
+
+static void set_target_state(enum module_update_state state)
+{
+	/* Reset ack counter. */
+	update_data.thread_ack = num_online_cpus();
+	update_data.state = state;
+}
+
+/* Last one to ack a state moves to the next state. */
+static void ack_state(void)
+{
+	guard(raw_spinlock)(&update_data.lock);
+	update_data.thread_ack--;
+	if (!update_data.thread_ack)
+		set_target_state(update_data.state + 1);
+}
+
+/*
+ * See multi_cpu_stop() from where this multi-cpu state-machine was
+ * adopted, and the rationale for touch_nmi_watchdog().
+ */
+static int do_seamldr_install_module(void *seamldr_params)
+{
+	enum module_update_state newstate, curstate = MODULE_UPDATE_START;
+	int ret = 0;
+
+	do {
+		/* Chill out and re-read update_data. */
+		cpu_relax();
+		newstate = READ_ONCE(update_data.state);
+
+		if (newstate != curstate) {
+			curstate = newstate;
+			switch (curstate) {
+			/* TODO: add the update steps. */
+			default:
+				break;
+			}
+
+			ack_state();
+		} else {
+			touch_nmi_watchdog();
+			rcu_momentary_eqs();
+		}
+	} while (curstate != MODULE_UPDATE_DONE);
+
+	return ret;
+}
+
 DEFINE_FREE(free_seamldr_params, struct seamldr_params *,
 	    if (!IS_ERR_OR_NULL(_T)) free_seamldr_params(_T))
 
@@ -214,7 +287,14 @@ int seamldr_install_module(const u8 *data, u32 size)
 	if (IS_ERR(params))
 		return PTR_ERR(params);
 
-	/* TODO: Update TDX module here */
-	return 0;
+	/*
+	 * Prevent CPU hotplug. If a CPU goes offline after thread_ack
+	 * initialization, thread_ack will exceed the online count and
+	 * never decrement to zero, causing all CPUs spinning forever
+	 * with IRQs disabled.
+	 */
+	guard(cpus_read_lock)();
+	set_target_state(MODULE_UPDATE_START + 1);
+	return stop_machine_cpuslocked(do_seamldr_install_module, params, cpu_online_mask);
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_install_module, "tdx-host");
-- 
2.47.3

