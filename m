Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5547336A00F;
	Sun, 15 Mar 2026 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583193; cv=none; b=eN2UfmPHrIovSBjhAi55bCm/lwVdItlKoqViWvWgkDy932TfYvfFe6kuWaXjq+k8cPTO27zrEa7hbd4z9+wQM5mr76qSitScgTt18cTENlenq5+xe7W4dT2Hf9RVY/haUGQZrVgevFuxBLBMZ/5Q8JS01DgO1RkbxBB14Lgy7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583193; c=relaxed/simple;
	bh=NsSwEUJo/IKxts+1rlSdsmQb/o/Uv38ZVDhpgJa+5Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM5Q4e4TG/HMFlcmU4VK2rAGyOwMXQB7QWslGtnl/er4ThDVUCG/z40dAYNwJDIilKFA9m05YJO1V3bx86gxVdfajjc1/NkNEr2WJ2ckINWfpaZWoV3M5X4KnsF4ZXZ8S5rzVkDKSb349tRrEeuBmqQ2L9BJNZPhrxvXAIKVmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Exuzk9Z7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Exuzk9Z7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773583192; x=1805119192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NsSwEUJo/IKxts+1rlSdsmQb/o/Uv38ZVDhpgJa+5Bk=;
  b=Exuzk9Z7kke5PvD+e1yVps33y42e/TLzhbY2ITb3JupNfqsm3DFE7Riq
   1DrlXcRspLNx1mRmoKOUS0PazAtJMG9AwdU93OnkRUDDidBidVyZqYfag
   nPqXlrVBGbg8XqyCVRZMOa6rLYWge5G1fv7nwQfZFlFK9yVDoR5VXEEZl
   BRPDl1PmQwr6BOj/8/2yXkkB1It95YXc4knjRxsM1jCx3klutcCH+wR+7
   az6yJjYIHfYIkMFyvMrZ67TF+lCYa22OmDDLIEKEsNxFomkVHEIrSI/H3
   4t8j8VTbrJQVXOY5wZg5qabIGCBclNjKr6o3Q3K7PKI+O0zqkbSbl7zZl
   A==;
X-CSE-ConnectionGUID: cdUJ4hLmQku4zPi7/JrQkw==
X-CSE-MsgGUID: YOgV4YFFQ2Wx10x0HWiVyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74732583"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="74732583"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:46 -0700
X-CSE-ConnectionGUID: zDYqwXEeT2a1uv5vcnit5Q==
X-CSE-MsgGUID: O0jjjL4yQomgxaL/LXqQYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="226123094"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:46 -0700
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
Subject: [PATCH v5 22/22] x86/virt/seamldr: Log TDX module update failures
Date: Sun, 15 Mar 2026 06:58:42 -0700
Message-ID: <20260315135920.354657-23-chao.gao@intel.com>
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

Currently, there is no way to restore a TDX module from shutdown state to
running state. This means if errors occur after a successful module
shutdown, they are unrecoverable since the old module is gone but the new
module isn't installed. All subsequent SEAMCALLs to the TDX module will
fail, so TDs will be killed due to SEAMCALL failures.

Log a message to clarify that SEAMCALL errors are expected in this
scenario. This ensures that after update failures, the first message in
dmesg explains the situation rather than showing confusing call traces from
various code paths.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
---
v4:
 - Use pr_warn_once() instead of reinventing it [Yilun]
v3:
 - Rephrase the changelog to eliminate the confusing uses of 'i.e.' and 'e.g.'
   [Dave/Yilun]
---
 arch/x86/virt/vmx/tdx/seamldr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index e6b7af410c54..4e1ad06506cc 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -222,6 +222,11 @@ static void ack_state(void)
 		set_target_state(update_data.state + 1);
 }
 
+static void print_update_failure_message(void)
+{
+	pr_err_once("update failed, SEAMCALLs will report failure until TDs killed\n");
+}
+
 /*
  * See multi_cpu_stop() from where this multi-cpu state-machine was
  * adopted, and the rationale for touch_nmi_watchdog().
@@ -266,6 +271,8 @@ static int do_seamldr_install_module(void *seamldr_params)
 			if (ret) {
 				scoped_guard(raw_spinlock, &update_data.lock)
 					update_data.failed++;
+				if (curstate > MODULE_UPDATE_SHUTDOWN)
+					print_update_failure_message();
 			} else {
 				ack_state();
 			}
-- 
2.47.3

