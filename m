Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E34BC016;
	Wed, 13 May 2026 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685111; cv=none; b=hQKpkaqTnkdcTqlUaZ3pNXHB97zuh0M5TbbMUWFViPJWHFUNqZUy9O0kjQ/sIqJP1oDbaS/612TJkw8Qn1nSytC1F1lqNb1RD3ctYnuDFN2Ppa0JTs43MOhraeqOGaKB8wWSaZYLASk1f7o0ojRBc2Oa7T+1vk+3o8h6Dx0yg5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685111; c=relaxed/simple;
	bh=BwCRyzJCVNr5aEzvQLZc6k5Qz5gHLeOaIsH1XuiGS9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwz6IhcKq3aiw0OOrydj/qMzfMCkEh17A6Q+hW0JflOFNSBiBqAGK6Rc3kBXbKUD1bXAZjTJWETg0Y1tJ/wQbM6qkYNv2bpgsBZr6prOHyeA9lT78KUgzYoG+EpI6o89AdC6UBeR0LujYabwJM8zMivDK2kOhMeV8V2vcAY0LPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViJqStGt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViJqStGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685110; x=1810221110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BwCRyzJCVNr5aEzvQLZc6k5Qz5gHLeOaIsH1XuiGS9k=;
  b=ViJqStGtjnykorv98q6DDovQ3L9s4dTOrTXtYVq7RwqVtNquULxR8/jN
   +XBQt2cGMR0X1N7KM6S+NUtZJ58wzpfPNiKNFlV4Z2NhLRuBzhBT/cIA9
   vAp44wKUZ/y/q+6UZV1sfSE0HItbxnVaOSD8+/xZ26vlIghW1tIn40447
   B+hU1tuavUvThESb2m6Fkr7oI84O7rO1pRZ5jwX5bLP1/DfT52qfNrOAE
   7ufWwZXu45IEAB8gHlTgUpeclh6utIc8uqoWX6k4g1snU1euEKB7Bn6w2
   2iELNMzjKZ9apNrbvWbyx1fQzXEVKR4NRmm+8j09GYejQjAyNf8FzUmoh
   g==;
X-CSE-ConnectionGUID: IB2E3PwtSHaC0sxzMi5OmQ==
X-CSE-MsgGUID: LUgoaUICSri9VMWLTe8KPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921710"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921710"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:49 -0700
X-CSE-ConnectionGUID: GVVPtxrHS/e+2vG3S0rFAQ==
X-CSE-MsgGUID: ApfAVFcQRcaUmsJa4+i8NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716836"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:49 -0700
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
Subject: [PATCH v9 12/23] x86/virt/seamldr: Introduce skeleton for TDX module updates
Date: Wed, 13 May 2026 08:09:55 -0700
Message-ID: <20260513151045.1420990-13-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513151045.1420990-1-chao.gao@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
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

multi_cpu_stop() provides a good example of executing a multi-step task
in lockstep across CPUs, but it does not synchronize the individual
steps inside the callback itself.

Implement a similar state machine as the skeleton for TDX module
updates. Each state represents one step in the update flow, and the
state advances only after all CPUs acknowledge completion of the current
step. This acknowledgment mechanism provides the required lockstep
execution.

The update flow is intentionally simpler than multi_cpu_stop() in two ways:

  a) use a spinlock to protect the control data instead of atomic_t and
     explicit memory barriers.

  b) omit touch_nmi_watchdog() and rcu_momentary_eqs(), which exist
     there for debugging and are not strictly needed for this update flow

Potential alternative to stop_machine()
=======================================
An alternative approach is to lock all KVM entry points and kick all
vCPUs. Here, KVM entry points refer to KVM VM/vCPU ioctl entry points,
implemented in KVM common code (virt/kvm). Adding a locking mechanism
there would affect all architectures KVM supports. And to lock only TDX
vCPUs, new logic would be needed to identify TDX vCPUs, which the KVM
common code currently lacks. This would add significant complexity and
maintenance overhead to KVM for this TDX-specific use case, so don't take
this approach.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v9:
 - Extract control-data initialization into a separate helper. [Dave]
 - Drop touch_nmi_watchdog() and rcu_momentary_eqs(), as they are not
   needed here.
 - Rename thread_ack to num_ack to make it clear that it counts the
   number of acknowledgments.
 - Rename set_target_state() to __set_target_state() to mark it as an
   internal helper. Add a comment noting that __set_target_state()
   does not take the lock, unlike ack_state().
 - Update the changelog to explain why a spinlock is used instead of
   atomic_t plus memory barriers to protect the control data.
---
 arch/x86/virt/vmx/tdx/seamldr.c | 87 ++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 929203ec96f2..7befe4a08f33 100644
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
 
@@ -154,6 +156,84 @@ static int init_seamldr_params(struct seamldr_params *params, const u8 *data, u3
 	return 0;
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
+static struct update_ctrl {
+	enum module_update_state state;
+	int num_ack;
+	/*
+	 * Protect update_ctrl. Raw spinlock as it will be acquired from
+	 * interrupt-disabled contexts.
+	 */
+	raw_spinlock_t lock;
+} update_ctrl;
+
+/* Called with ctrl->lock held or during initialization. */
+static void __set_target_state(struct update_ctrl *ctrl,
+			       enum module_update_state newstate)
+{
+	/* Reset ack counter. */
+	ctrl->num_ack = 0;
+	ctrl->state = newstate;
+}
+
+/* Last one to ack a state moves to the next state. */
+static void ack_state(struct update_ctrl *ctrl)
+{
+	raw_spin_lock(&ctrl->lock);
+
+	ctrl->num_ack++;
+	if (ctrl->num_ack == num_online_cpus())
+		__set_target_state(ctrl, ctrl->state + 1);
+
+	raw_spin_unlock(&ctrl->lock);
+}
+
+static void init_state(struct update_ctrl *ctrl)
+{
+	raw_spin_lock_init(&ctrl->lock);
+	__set_target_state(ctrl, MODULE_UPDATE_START + 1);
+}
+
+/*
+ * See multi_cpu_stop() from where this multi-cpu state-machine was
+ * adopted.
+ */
+static int do_seamldr_install_module(void *seamldr_params)
+{
+	enum module_update_state newstate, curstate = MODULE_UPDATE_START;
+	int ret = 0;
+
+	do {
+		newstate = READ_ONCE(update_ctrl.state);
+
+		if (curstate == newstate) {
+			cpu_relax();
+			continue;
+		}
+
+		curstate = newstate;
+		switch (curstate) {
+		/* TODO: add the update steps. */
+		default:
+			break;
+		}
+
+		ack_state(&update_ctrl);
+	} while (curstate != MODULE_UPDATE_DONE);
+
+	return ret;
+}
+
 /**
  * seamldr_install_module - Install a new TDX module.
  * @data: Pointer to the TDX module image.
@@ -174,7 +254,12 @@ int seamldr_install_module(const u8 *data, u32 size)
 	if (ret)
 		goto out;
 
-	/* TODO: Update TDX module here */
+	/* Ensure a stable set of online CPUs for the update process. */
+	cpus_read_lock();
+	init_state(&update_ctrl);
+	ret = stop_machine_cpuslocked(do_seamldr_install_module, params, cpu_online_mask);
+	cpus_read_unlock();
+
 out:
 	kfree(params);
 	return ret;
-- 
2.52.0

