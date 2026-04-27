Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E130A3B95F2;
	Mon, 27 Apr 2026 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303812; cv=none; b=kY5LQty3daSPsxZCSyfRDTfd65sUeyKL7NPN81TyswD0cPgg1EINbNbucVRzAOULyRCCN3uD7s9QxUDP9Ch5PaH9j689iGkkOH7zilmJpIhBAUW+LL/tFHGKTpjDjQvjxIuMCBZaJMdfakyIfmLGDNPUllA1sQasmyENCZmIE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303812; c=relaxed/simple;
	bh=ja0sZPXfqEg02647Dix95yhc8htdxrG9MSGFPBzC070=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZRQB/ePNQGtVeE0V16GtKDdIkmlTPLAXOdsqJPhPv4ibp/r4zY7BNqwOU8wpircu3mTxg+UoHjOHyXD39ZDkKuQ/EQscXUlPanJB3LYLwh9bse/HSY+7z3017rM1Uf/6hY+ClmKqYNsSF05TciSgto58BtS7JzIRrm5uOWLmc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYtjeiIf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYtjeiIf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777303810; x=1808839810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ja0sZPXfqEg02647Dix95yhc8htdxrG9MSGFPBzC070=;
  b=eYtjeiIf4D5kFz6oj0v0FkGvJPFOZFRE6hd4tL8UQYoCrzRHWfeTS54l
   F265ENlua3LzBOh2DfDMqodvCT7AX4XoBzi9gatAsZPiSlYf1q9Dsb0Vs
   usdErWkX/NTYj3vaV9kO89Ecxv4qc7UNYDR9KZojzHpYv9lZfyFh9h9Yu
   DegVfHOhu1Ao4UQTlwN/SDRPcY8HG8gZZ9lddc1JYF/uKuKVo+B+09soY
   GSJxpHCWVWt9zTrXRmJB0sgVWJnmsvBJb5Mx4//do8bWmeVO2s82K5ykC
   oeeQcqF1Pcszl+RMzSuNdUzf/g/GEDVhczpKokjIHWYF3G1tPK8gPq19k
   Q==;
X-CSE-ConnectionGUID: fkCYrGjcQ1GAB5hbU1i5tQ==
X-CSE-MsgGUID: rDSZ4s+3T0qc7rXv7VcElw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77900795"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77900795"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:30:05 -0700
X-CSE-ConnectionGUID: V4iALeHsQaWit9edj0KG2A==
X-CSE-MsgGUID: i7ufKUKrRbeMiJAtVteGaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232673341"
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
Subject: [PATCH v8 17/21] x86/virt/seamldr: Abort updates on failure
Date: Mon, 27 Apr 2026 08:28:11 -0700
Message-ID: <20260427152854.101171-18-chao.gao@intel.com>
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

TDX module update is a multi-step process, and each step can fail.

The current update flow continues to later steps after an error.
Continuing after failure leaves the TDX module in an unrecoverable
state.

One failure case must remain recoverable: update contention with an ongoing
TD build. The agreed kernel behavior for this case is to fail the update
with -EBUSY so userspace can retry later.

Abort the update on any failure. For the contention case, this provides
a recoverable failure mode because the failure occurs before any TDX
module state is changed. Use the same rule for all errors to avoid
special-casing -EBUSY.

Introduce a shared "failed" flag. When a CPU fails, set the flag and force
all CPUs to exit the update loop. A failing CPU does not acknowledge the
current step, so other CPUs remain at that step until they observe the
"failed" flag and exit.

Use READ_ONCE()/WRITE_ONCE() for the flag because it is used for lockless
communication between stop_machine workers. Also use WRITE_ONCE() for the
initial clear to keep accesses to the flag uniform and explicit.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
v8:
 - Explain why aborting updates is necessary. [Rick]
 - always use READ_ONCE()/WRITE_ONCE() for the "failed" flag.
---
 arch/x86/virt/vmx/tdx/seamldr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index c81b26c4bac1..9b8f571eb03f 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -220,6 +220,7 @@ enum module_update_state {
 static struct {
 	enum module_update_state state;
 	int thread_ack;
+	bool failed;
 	/*
 	 * Protect update_data. Raw spinlock as it will be acquired from
 	 * interrupt-disabled contexts.
@@ -284,12 +285,15 @@ static int do_seamldr_install_module(void *seamldr_params)
 				break;
 			}
 
-			ack_state();
+			if (ret)
+				WRITE_ONCE(update_data.failed, true);
+			else
+				ack_state();
 		} else {
 			touch_nmi_watchdog();
 			rcu_momentary_eqs();
 		}
-	} while (curstate != MODULE_UPDATE_DONE);
+	} while (curstate != MODULE_UPDATE_DONE && !READ_ONCE(update_data.failed));
 
 	return ret;
 }
@@ -315,6 +319,7 @@ int seamldr_install_module(const u8 *data, u32 size)
 
 	/* Ensure a stable set of online CPUs for the update process. */
 	guard(cpus_read_lock)();
+	WRITE_ONCE(update_data.failed, false);
 	set_target_state(MODULE_UPDATE_START + 1);
 	ret = stop_machine_cpuslocked(do_seamldr_install_module, params, cpu_online_mask);
 	if (ret)
-- 
2.47.1

