Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE13E6DC5;
	Tue, 31 Mar 2026 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961013; cv=none; b=KyTy4I8dp7L/eCT2XcvGqzvW+Fe1WQUw7oeWnU18qDxFoWbguA8dyqj0cm1IokPjBDh/lolp55MPHChBZ1+i2EwZ67nbOkYS4k7zqJ2d4qymd6WS2npuZWYjoyxOPW5TFNXsb4MfVgfij4gP7IxJZlAJYkzTOIu1RDtok/PWynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961013; c=relaxed/simple;
	bh=avTrumEyypZavVOjzYQTSOSyPAumy2mIcrqhv8ZW7P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRdYVubAe590RLyO1uNusjU7JSC9jPuliNklmQWQZBYx45JQFjwVnAUcAePFxIuLLwhGb0BTFFp9MgnHpP0IVw2FHOcPsE4G8O7AAdAAL6fRlN+XBddd1VRxn76yHAKXPZF0upzqvd8d+qOTk1EPNU6oX2R46Ukg2o4GpSj2Gpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7a1c20P; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7a1c20P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774961012; x=1806497012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=avTrumEyypZavVOjzYQTSOSyPAumy2mIcrqhv8ZW7P4=;
  b=N7a1c20PC1f9gPUt4cUGFToAm8iTHYbaDa8tzasCaJjph8Ts3kSJQEcM
   q9AY4m/luP6O1rDTYglB66/lgeo8hWKgHzyK5FZ9+mZpq2ILdEbbdA9kd
   xh6qVO0FmdaTRkvKIhuy7wXIqefsMeerJUUUGW4H7244O5bsgVuZn2WpF
   mWt0yPNyStpHRHGg3TDGaqo5ewIRZVxe1I522BlrpPoTlg9DrEV3XSVeA
   LqHfcMNKCM9Zf2V/CIhLa237dkWsaMNWhbPlFi77/KXR7G+LhbqXflgnY
   5JufOACV2Nw9EgFJLlil9EDdT/mDkB5sZ3xIBdMbbIvrUXakeXscfP7zY
   Q==;
X-CSE-ConnectionGUID: 9ChQ78n8SVOqP7iF//f6eA==
X-CSE-MsgGUID: UdKNpqNOR1q8r5y7EUtTaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76084509"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76084509"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:30 -0700
X-CSE-ConnectionGUID: /+sZHCmmRtSrq/NWRzaTeQ==
X-CSE-MsgGUID: Q5Mi2t1fQqqYZF6fSak+dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221492119"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:29 -0700
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
Subject: [PATCH v7 10/22] x86/virt/seamldr: Abort updates if errors occurred midway
Date: Tue, 31 Mar 2026 05:41:23 -0700
Message-ID: <20260331124214.117808-11-chao.gao@intel.com>
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
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
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
index 3bcde3fd94a6..5964bbc67944 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -213,6 +213,7 @@ enum module_update_state {
 static struct {
 	enum module_update_state state;
 	int thread_ack;
+	bool failed;
 	/*
 	 * Protect update_data. Raw spinlock as it will be acquired from
 	 * interrupt-disabled contexts.
@@ -260,12 +261,15 @@ static int do_seamldr_install_module(void *seamldr_params)
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
@@ -294,6 +298,7 @@ int seamldr_install_module(const u8 *data, u32 size)
 	 * with IRQs disabled.
 	 */
 	guard(cpus_read_lock)();
+	update_data.failed = false;
 	set_target_state(MODULE_UPDATE_START + 1);
 	return stop_machine_cpuslocked(do_seamldr_install_module, params, cpu_online_mask);
 }
-- 
2.47.3

