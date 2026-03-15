Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82E0364EAC;
	Sun, 15 Mar 2026 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583185; cv=none; b=s7pXOwq4ezlgMFMIftFhi4sGFLX0Uh2Q0V0QKYvIwKDUAwa9s+eU3jawhJrPpJMdewa1SFw1hcmocYsTbMkRHdMl0WCVczR+ZVHtpLZ6O9ppREVR4DIkiDi9NyjV3kLHf+u02lRjNg71Djx/hW1imcDYYWsgC1YCzGUIr5onOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583185; c=relaxed/simple;
	bh=t+NnS+DiYvIho12OQivjxgaAaoctM7a/wHmbkrtpqBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tO4FP8PMy+lKk+thqGH91NO4M3kqprU5AIdUWXDL4qv1QbFVznuRn1B/X4DGL/e0qFBrY/j6+VsshiT3tKZURe0rfU6SqcaYjF2o/x05yyA7lZKsFj1FLhLbAHIRmvpI0JBjOuCUyxvu5AcfA1K0YurUp3KLDhLiG3Ls2qI/LgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TF+ZWva7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TF+ZWva7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773583182; x=1805119182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t+NnS+DiYvIho12OQivjxgaAaoctM7a/wHmbkrtpqBE=;
  b=TF+ZWva7uB8lPNgp81HBievCoAwsw8KzVfS+BzTpaY2FwkntUusyDhF3
   dJdCyHMgB6nh3YBVebelRG0gVcpgTOvBNd1S/ecegjhszuvu2tvii+jnb
   InfNKdVUBGhiBa5pXywzkKyTmG0kX/qXJ/AtZyDppNtSCpU0S3P3cah2x
   n2eNzKCtnmeMVZ0lRIIenjkOHJWncURHLChPtjMJ6/+n5LmzNrwQDNsoI
   rJ4FXbiITes8WSo0dz2QlUGsBenf2p7iPd3uRDY8a7PkZkJ2aMnT8Cgft
   xYagIZEUirJZHJzEvvVbYPajTdlvOSKoq5Hixy0HELbpighQVQPtG8Q0a
   A==;
X-CSE-ConnectionGUID: YtRvyYpkRgu5DacXDn2iRw==
X-CSE-MsgGUID: iyuUQJwNQTyxMKLhy3thDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74732478"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="74732478"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:40 -0700
X-CSE-ConnectionGUID: iL0+62YWSKu3Mh8juVcFfg==
X-CSE-MsgGUID: G/LAdcxiS1KmQXH6WpLYaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="226123042"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:40 -0700
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
Subject: [PATCH v5 09/22] x86/virt/seamldr: Introduce skeleton for TDX module updates
Date: Sun, 15 Mar 2026 06:58:29 -0700
Message-ID: <20260315135920.354657-10-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315135920.354657-1-chao.gao@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
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
Extensions (Intel® TDX) Module Base Architecture Specification, Revision
348549-007, Chapter 4.5 "TD-Preserving TDX module Update"). Ordering
requirements between steps mandate lockstep synchronization across all
CPUs.

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
---
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
 arch/x86/virt/vmx/tdx/seamldr.c | 77 ++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 20cb6c797ce5..978fcca92128 100644
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
 
@@ -174,6 +176,77 @@ static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
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
 
@@ -191,7 +264,7 @@ int seamldr_install_module(const u8 *data, u32 size)
 	if (IS_ERR(params))
 		return PTR_ERR(params);
 
-	/* TODO: Update TDX module here */
-	return 0;
+	set_target_state(MODULE_UPDATE_START + 1);
+	return stop_machine(do_seamldr_install_module, params, cpu_online_mask);
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_install_module, "tdx-host");
-- 
2.47.3

