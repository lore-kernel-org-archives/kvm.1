Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03347F2DD;
	Wed, 13 May 2026 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685116; cv=none; b=dVpO6cPU6CgI1QbFEFwR9yYrunYyadk/7QVI1E4tkf1gyOxmvmVhSGqiRhUnqwDpaUXFcyW2BmRhD88zaao0SH3LkiiO6zaMWwrYF6WKwKTgO0hr3pDI4rVP9bwzxcX28jXutaraKlNL77B4uHOTMQf1HNPoScEJYbIbbXYXxr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685116; c=relaxed/simple;
	bh=8PbicTqEbhDrnSTKwgpCFEyUH9Bk/LHwnp78ypWxyUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRj+cwTtO/Qf9nTaq2f5+T6RAJAN2DEYa3rZlIgv0eIhM8JaBeL3ThrBR4fGnGwkBodMYN4mRX0khLLYeOxOY3bLwRlNOMyp8ggfk8TXHwiU0zvcG7eMLWHODrbyEuF6hRtKacQDKJcGnw0XSL1ZrpWg+YHwr3Ym3//aRTHYQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLYr5h9J; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLYr5h9J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685114; x=1810221114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8PbicTqEbhDrnSTKwgpCFEyUH9Bk/LHwnp78ypWxyUQ=;
  b=BLYr5h9JHSn741ohgyqhDBBwiSEWW9EoMJOayS4qs0cv/OS7pXC5aORD
   R9kwyHqDImP4tvc/mIqxFTxesMgozA56AaBpmcTHtvsVfgovTBn/LInIL
   iCOYDaNeR5SJeMx6OP2w028nJhS4tpwU3Vua8ENxthvZykGMxRvyyJMEe
   a65v6kmjbFsDw8dS5GPiVvbzUuWdTl7/SoDqqyoffwL2Y3BogDR+ZPZlv
   D2aM2l3IWElL2f/KyM3a/nXUEal/x8geP8n2QwGBeT4kSj5/o45zHxDMX
   ar42wgxUPNeBZ+1fC4SOUfj3BGMxZIiWNpNneTtjvcl6mDuoOS58vC0Wn
   w==;
X-CSE-ConnectionGUID: 3ooqeFVpRxOStzItMWPB6A==
X-CSE-MsgGUID: qOmGcZ6fT6+a8a+emux79Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921726"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921726"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:54 -0700
X-CSE-ConnectionGUID: p8rbDWQsSbWpWtU5aEuTAQ==
X-CSE-MsgGUID: 9/ap5W54QNaxG9k4rUE31w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716848"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:50 -0700
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
Subject: [PATCH v9 13/23] x86/virt/seamldr: Abort updates after a failed step
Date: Wed, 13 May 2026 08:09:56 -0700
Message-ID: <20260513151045.1420990-14-chao.gao@intel.com>
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

A TDX module update is a multi-step process, and any step can fail.

The current update flow continues to later steps after an error.
Continuing after a failure can leave the TDX module in an unrecoverable
state.

One failure case must remain recoverable: update contention with an ongoing
TD build. The agreed kernel behavior for this case [1] is to fail the
update with -EBUSY so userspace can retry later.

Abort the update on any failure. This also makes the TD-build contention
case recoverable, because that failure occurs before any TDX module state
is changed. Apply the same rule to all errors instead of special-casing
-EBUSY.

Track per-step failures, stop the update loop once a failure is observed,
and do not advance the state machine to the next step.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Link: https://lore.kernel.org/linux-coco/aQFmOZCdw64z14cJ@google.com/ # [1]
---
v9:
  - Avoid nested if/else by deferring failure accounting to ack_state().
  - Reduce indentation of the main flow.
  - Convert the failed flag into a counter. This avoids a conditional
    update of the flag; the counter can simply accumulate failures.
---
 arch/x86/virt/vmx/tdx/seamldr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 7befe4a08f33..48fe71319fea 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -170,6 +170,7 @@ enum module_update_state {
 static struct update_ctrl {
 	enum module_update_state state;
 	int num_ack;
+	int num_failed;
 	/*
 	 * Protect update_ctrl. Raw spinlock as it will be acquired from
 	 * interrupt-disabled contexts.
@@ -187,12 +188,13 @@ static void __set_target_state(struct update_ctrl *ctrl,
 }
 
 /* Last one to ack a state moves to the next state. */
-static void ack_state(struct update_ctrl *ctrl)
+static void ack_state(struct update_ctrl *ctrl, int result)
 {
 	raw_spin_lock(&ctrl->lock);
 
+	ctrl->num_failed += !!result;
 	ctrl->num_ack++;
-	if (ctrl->num_ack == num_online_cpus())
+	if (ctrl->num_ack == num_online_cpus() && !ctrl->num_failed)
 		__set_target_state(ctrl, ctrl->state + 1);
 
 	raw_spin_unlock(&ctrl->lock);
@@ -202,6 +204,7 @@ static void init_state(struct update_ctrl *ctrl)
 {
 	raw_spin_lock_init(&ctrl->lock);
 	__set_target_state(ctrl, MODULE_UPDATE_START + 1);
+	ctrl->num_failed = 0;
 }
 
 /*
@@ -228,8 +231,8 @@ static int do_seamldr_install_module(void *seamldr_params)
 			break;
 		}
 
-		ack_state(&update_ctrl);
-	} while (curstate != MODULE_UPDATE_DONE);
+		ack_state(&update_ctrl, ret);
+	} while (curstate != MODULE_UPDATE_DONE && !READ_ONCE(update_ctrl.num_failed));
 
 	return ret;
 }
-- 
2.52.0

