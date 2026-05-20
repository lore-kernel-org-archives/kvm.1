Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210E3D3480;
	Wed, 20 May 2026 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284428; cv=none; b=pNrhFOHM+JdOyCqqAPraKM2ncZ0Dx3vhU24ikZ73woAyP2Y120TiwTQTmD7mtZK8Wz7VMsVZqPeR8coSCzHMgAztksGr86x9sX3KJpGgGuPGW24yJiDuDZC08O9obtK+i0UnWqnci31ocgbLQ37HlClDH2N493kpinUnkneiYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284428; c=relaxed/simple;
	bh=lh0QUflOJ+0B1qD0EDBKQhCL1yyuhVcDXTIhG/1ITuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHV2hALJZErsoGYRN9yiRWfR9aYTKh85RJUrqpsvs+GbfYQ3xg3/A0SU5SLZ8phwkZKKq1Z+C5eD3LDbW3zqtGX32GwjoNu1+ammR9TO3UkA2xu1L1U6qfjJCEk4dHE4o0ZQ12BLYwcoO5KOH3qB90GUcelgUiYR0RSCpFINKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnKXEYaA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnKXEYaA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284426; x=1810820426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lh0QUflOJ+0B1qD0EDBKQhCL1yyuhVcDXTIhG/1ITuM=;
  b=nnKXEYaAUqv7c24HodEP9jsCEK7UMqwemYDyWsz8acIrsSjXem1ow0Kl
   L9IfhsgBMRBvGmjmg5dAjR3aLmcsAcJxE602SR2iCPbhlEjgEbnglwuSP
   ht15E02n1YekwDvekSNgZ2kE8dW2H3znndQojmkPGkGU6hWKLU5q2w9gO
   RydbJsNE64PI7kaZ8A3nzADWvM+xZAGsF3grZSVf2q023gexkrhZj5Brk
   KP6ObZVrfeYy8NZFOM/L8TShTriO0NPz+7dYBbdkGztjFNqSWTNakvYx5
   Rn0Hc93oEkFQMim5eQfyqMiu1X74Rt3UCCgXBk014D7ryj+JutncEAr8m
   Q==;
X-CSE-ConnectionGUID: 3JhaJi2nS8KrpboL0Dd+Zw==
X-CSE-MsgGUID: kQZbrCvCSe21pUwFnzPJFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146537"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146537"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:20 -0700
X-CSE-ConnectionGUID: s7yx0l03SxegTCq1Fe7pww==
X-CSE-MsgGUID: zC//OBAtRhK903Og1bdiSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923899"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:19 -0700
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
Subject: [PATCH v10 15/25] x86/virt/seamldr: Abort updates after a failed step
Date: Wed, 20 May 2026 06:38:18 -0700
Message-ID: <20260520133909.409394-16-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520133909.409394-1-chao.gao@intel.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A TDX module update is a multi-step process, and any step can fail.

The current update flow continues to later steps after an error.
Continuing after a failure can cause the TDX module to enter an
unrecoverable state.

But certain failures during the initial module shutdown step should
simply return an error to userspace, so the update can be retried cleanly.

To preserve that recoverability, one option would be to abort the update
only for those failures, since they occur before any TDX module state is
changed. But special-casing specific failures in specific steps would
complicate the do-while() update loop for no benefit.

Simply abort update on any failure, at any step.

Track failures for each step, stop the update loop once a failure is
observed, and do not advance the state machine to the next step.

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
index db6c52f65995..002cdae3b1ff 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -181,6 +181,7 @@ enum module_update_state {
 static struct update_ctrl {
 	enum module_update_state state;
 	int num_ack;
+	int num_failed;
 	/*
 	 * Protect update_ctrl. Raw spinlock as it will be acquired from
 	 * interrupt-disabled contexts.
@@ -198,12 +199,13 @@ static void __set_target_state(struct update_ctrl *ctrl,
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
@@ -213,6 +215,7 @@ static void init_state(struct update_ctrl *ctrl)
 {
 	raw_spin_lock_init(&ctrl->lock);
 	__set_target_state(ctrl, MODULE_UPDATE_START + 1);
+	ctrl->num_failed = 0;
 }
 
 /*
@@ -239,8 +242,8 @@ static int do_seamldr_install_module(void *seamldr_params)
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

