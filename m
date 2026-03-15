Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85A3624A3;
	Sun, 15 Mar 2026 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583184; cv=none; b=LtJJiE+VxtBgCs5SFzEFB0iwpXUnPEU3ItpukdUxqHM0kVdqx/7BNLW/iCvGxtl7GkGfalDbIQrOCooXY5yRSL9jn/kJriEKXmO6Qb75WRM6R1MxzjWtxYUvJEmfaPnjxMboauXh4ywEFU6u047LrbT7yNDmKomDcBdoiIc4uXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583184; c=relaxed/simple;
	bh=s6uY08ifCWK6lc4XDMMSYPQnJ0X4Kox0YD+uZNjfBn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiBHrTKw6x/N5rLNcPIt307wNbJPEWDNc+rBKQg20KUEj7ihzTST7OVC/gO03fvZn1hJD5hG8uOJ1wBvbJhb/K9C1cJqWn8ufQyDvhRiNsyM2D2ONSjMGLUosxfXiiq87AkZ7Y9cXiIqVfaofyw8XVkgeh5gD92KYV+YxpwS0AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YT1ytCXO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YT1ytCXO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773583183; x=1805119183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s6uY08ifCWK6lc4XDMMSYPQnJ0X4Kox0YD+uZNjfBn0=;
  b=YT1ytCXOOx+dziNSMkrtvcd96LE+jif4RAJSNXQDYxDJj8CAHrW6GdfW
   O1LgB3K+Fvp8n7zEBtTgw0ZyZJUgVrNkQ/Grxxuti7Z9Eckki1iNMvUFI
   mHuFmxPZvU+fys4gdfsOrhD3IbFrLBDOEK4Jlx1vcQ4cimc15mG+2m4C5
   VaZlZI5NhcZCIpnx2o74qO0WZwGvDe+nb0eAFkb7tk1YZPZ92XDTuesv8
   trFXIQYqEakX67Z52Mhw6hQYVrrRG9zCd1y4IqF8/fkww4rnbhmIi78Ch
   xgscDc3em9PzPTddR4aL0+TTVXRr+g8IOxfW/xOEfybLrgohsF4DfUvSQ
   g==;
X-CSE-ConnectionGUID: 4KuwkamST1+pZOvljWQSqQ==
X-CSE-MsgGUID: PeSYnjuKRBOnyrL6MBDYiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74732486"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="74732486"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:40 -0700
X-CSE-ConnectionGUID: hBegiaZuSky4v86/IdrKrw==
X-CSE-MsgGUID: nGKnVgqGSL+HPXzudkXa6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="226123046"
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
Subject: [PATCH v5 10/22] x86/virt/seamldr: Abort updates if errors occurred midway
Date: Sun, 15 Mar 2026 06:58:30 -0700
Message-ID: <20260315135920.354657-11-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315135920.354657-1-chao.gao@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
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
v5:
 - Replace failed count from atomic_t to int since it's now protected by
   a lock.

v3:
 - Instead of fast-forward to the final stage, exit the execution loop
   directly.
---
 arch/x86/virt/vmx/tdx/seamldr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 978fcca92128..e195703398e7 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -190,6 +190,7 @@ enum module_update_state {
 static struct {
 	enum module_update_state state;
 	int thread_ack;
+	int failed;
 	/*
 	 * Protect update_data. Raw spinlock as it will be acquired from
 	 * interrupt-disabled contexts.
@@ -237,12 +238,17 @@ static int do_seamldr_install_module(void *seamldr_params)
 				break;
 			}
 
-			ack_state();
+			if (ret) {
+				scoped_guard(raw_spinlock, &update_data.lock)
+					update_data.failed++;
+			} else {
+				ack_state();
+			}
 		} else {
 			touch_nmi_watchdog();
 			rcu_momentary_eqs();
 		}
-	} while (curstate != MODULE_UPDATE_DONE);
+	} while (curstate != MODULE_UPDATE_DONE && !READ_ONCE(update_data.failed));
 
 	return ret;
 }
@@ -264,6 +270,7 @@ int seamldr_install_module(const u8 *data, u32 size)
 	if (IS_ERR(params))
 		return PTR_ERR(params);
 
+	update_data.failed = 0;
 	set_target_state(MODULE_UPDATE_START + 1);
 	return stop_machine(do_seamldr_install_module, params, cpu_online_mask);
 }
-- 
2.47.3

