Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389073BD624;
	Thu, 26 Mar 2026 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514740; cv=none; b=sTd6UUQXMulWKDzmjBrss9F0IONr5oFnCkWYEhToIh8zujSs/BnYSQvyIs+Hrbl0fxVxumCY5qxRb/al5HpKXNy0aDDCjj53MSac8Fefv1ybX31l9FG9iA9QUucJjVVZlxtsAbiYrlHxNpyxEbI41jSxRblJzDgOa4PuxRceme4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514740; c=relaxed/simple;
	bh=XO2Iq5QOuokCCGG7DYLq4t7E0xxdoXIf0qENfO88F/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lP7IHg3CR+ZA+gL6TWaIQ1la3R5mIznIRdHGdYE/Bp0wSWlfkC/K4ubOO/8COVcNHOoqGryieaqUp8CwhKF8zulgm+V0RGAySAMBM6TlB/iXW6+j/aa60znA4vUUdpV8rr0+feTtdimG+ZaGw85ipjeOSpet6qCY8/Ne6O915kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRE9FmUM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRE9FmUM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514738; x=1806050738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XO2Iq5QOuokCCGG7DYLq4t7E0xxdoXIf0qENfO88F/Q=;
  b=iRE9FmUMN8LBazmN6vvJer7ChWFBWsuO8LulGmNeDnQBVoAw4Y3LQeSC
   0DoGEft/m3Z3nuHSp0XFnO9awHPzLN0ce0U2HKrAifTmm8gKYz4cWx+ek
   k3YHa5QsjgJb8f5WfqJDBEiCQ3lkrq35GVa7YIis0hW02qZDj/El0Gnxy
   pxcjKxwwPK/AHjoDQ+IqXmRCiPLtEJpxLCSrbFlnM4tRgEdNQ8RdlKCG6
   3elECJUZh1ZCEhIUtkPozM+T90C+0wb7bVObor4VQ6f6C14VlQ7Fxurvw
   4uhw5pMmmk7xHmx+f4z/dJXY+R4AS4vXQGzPubkxvrMMpYQd54qPIFTiQ
   A==;
X-CSE-ConnectionGUID: 40FIBY0mRXyTPvXs31Jxag==
X-CSE-MsgGUID: HEqo+LEmS4aCAqoFHXN+KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86644686"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86644686"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:22 -0700
X-CSE-ConnectionGUID: rtCNGcSRT3m3akRXRzJHOQ==
X-CSE-MsgGUID: JQWMfTg9QjSfAlk109M11Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224967206"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:21 -0700
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
Subject: [PATCH v6 10/22] x86/virt/seamldr: Abort updates if errors occurred midway
Date: Thu, 26 Mar 2026 01:44:01 -0700
Message-ID: <20260326084448.29947-11-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326084448.29947-1-chao.gao@intel.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX module update process has multiple steps, each of which may
encounter failures.

The current state machine of updates proceeds to the next step regardless
of errors. But continuing updates when errors occur midway is pointless.

Abort the update by setting a flag to indicate that a CPU has encountered
an error, forcing all CPUs to exit the execution loop. Note that failing
CPUs do not acknowledge the current step. This keeps all other CPUs waiting
in the current step (since advancing to the next step requires all CPUs to
acknowledge the current step) until they detect the fault flag and exit the
loop.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
v6:
 - change failure indicator from int to boolean [Kiryl]
 - replace lock with WRITE_ONCE for @failed [Kiryl]
v5:
 - Replace failed count from atomic_t to int since it's now protected by
   a lock.

v3:
 - Instead of fast-forward to the final stage, exit the execution loop
   directly.
---
 arch/x86/virt/vmx/tdx/seamldr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index ed6a092b11e2..771671b7755b 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -196,6 +196,7 @@ enum module_update_state {
 static struct {
 	enum module_update_state state;
 	int thread_ack;
+	bool failed;
 	/*
 	 * Protect update_data. Raw spinlock as it will be acquired from
 	 * interrupt-disabled contexts.
@@ -243,12 +244,15 @@ static int do_seamldr_install_module(void *seamldr_params)
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
@@ -270,6 +274,7 @@ int seamldr_install_module(const u8 *data, u32 size)
 	if (IS_ERR(params))
 		return PTR_ERR(params);
 
+	update_data.failed = false;
 	set_target_state(MODULE_UPDATE_START + 1);
 	return stop_machine(do_seamldr_install_module, params, cpu_online_mask);
 }
-- 
2.47.3

