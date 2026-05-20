Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95673E835E;
	Wed, 20 May 2026 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284428; cv=none; b=JdGERMBQ1i476M974HW4bphKb4jjQVM9hVEMVTORrzc10vwpwnJuBKLEuRgBvnhUbGfp1LOM5T5kkYcne3mR991M4GC0Z8b8o/jExxMlumSA7LDSci6ARVsVtGL5PqFzUcryt7jNEGg/8zcXnZtzz4UuoHMPkkTWEOeUIjVxzg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284428; c=relaxed/simple;
	bh=tVsArRA2sGbQoUu1urPqUjzAv7PIClDuiJsEtM6+h+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzhgxFTpPOxBrQaEt0TmhKcrt+yBAfocMWX/rw34EEeNVNIhtOTNOP/aJ/z6XOb66UBZfgJYYudO6UBUh885cW+xcTDVnggTp2OZp1+TkxXuXLClbcUedk9BtcnV239TpTXk6EnbF7wb48w3C9Z+LD3IVFIF5lngucNLlJmp1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7HtHUVr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7HtHUVr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284423; x=1810820423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tVsArRA2sGbQoUu1urPqUjzAv7PIClDuiJsEtM6+h+c=;
  b=K7HtHUVr+7opDW/0g9u5N8rXRDqxILcmKoZvmhmxk/ns/MO2JvRwnnUv
   vaoxIghliiFmquTAU7Y6s7FECBIraIOxWcPlHgfYyp5YFOSiYJ7Pn4oju
   BKye9H1Jb4LzLqgXLSl3KfmuBqeu9L1ZntA5Q1ODtPF39IGe8EDrf4CvL
   pTRwoY6lmYCdoubFmGqZhNxOOc9TB8V0LM8o5gzHx44KidbR6vc0uSKQc
   cJkO9WPFlXyTmt5Z6g19il2E30QzWgrip9jwtXBpS1QqXeZsIEiM1VhD7
   PEx01zVePPWghHgaE8Xj1mP8JUGfuWmXbatAwFf92grs15whPAtSZM6vV
   Q==;
X-CSE-ConnectionGUID: GJFxBufhS3eUVuztVK5t4Q==
X-CSE-MsgGUID: FfTicD4dQ1Keq90pbvf+xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146528"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146528"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:19 -0700
X-CSE-ConnectionGUID: Amq7jAaPSyivrXtCeLJyrg==
X-CSE-MsgGUID: vvXZYRJzSty9LCyiEs0c4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923890"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:18 -0700
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
Subject: [PATCH v10 14/25] x86/virt/seamldr: Introduce skeleton for TDX module updates
Date: Wed, 20 May 2026 06:38:17 -0700
Message-ID: <20260520133909.409394-15-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520133909.409394-1-chao.gao@intel.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
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
 arch/x86/virt/vmx/tdx/seamldr.c | 87 ++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 11bd28e8370c..db6c52f65995 100644
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
 
@@ -165,6 +167,84 @@ static int init_seamldr_params(struct seamldr_params *params,
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
@@ -192,7 +272,12 @@ int seamldr_install_module(const u8 *data, u32 data_len)
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

