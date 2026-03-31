Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2683E3DAF;
	Tue, 31 Mar 2026 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961027; cv=none; b=lj4dVtRCs2Md0s5fThEk31RS4OBTyEM7lT8XUP1odUulkjzRaVi2CC4kXoa6sQA9q6nmA4sVXJZXhbOv3w7qssLpx0eWKhq0R8GpDqV/X1qQ+CTBMN28HaHE9lJkcTTHekcoLDSJZby+ILbtR+Qfr414rh3pyy/RcqkDdWaOCCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961027; c=relaxed/simple;
	bh=XaK/jOeHRwV+N+fhpd3s2Pd9o6jdHebnW8hLXe2SR3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8IdnAMp+aKj+ObOstRCIykGWwVC6tjMtSTY2Sf/cESjNzXa41wNP8rQBbefdm0wD4htJAD5tcHkAdQPpliHdclvWWNjs27KvW3bAimgjxOX/8TSoSdTSsTeKfnn1bk5AsojnwEYECGvCT3SAbm+KS35xrhZ1v2Khs7+nZqqylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3rpsPdn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3rpsPdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774961026; x=1806497026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XaK/jOeHRwV+N+fhpd3s2Pd9o6jdHebnW8hLXe2SR3E=;
  b=D3rpsPdnQFHTAUxxugr26edSt7e1N2t9Bx6vn4W1XH/cr5hN4ltW9YeE
   H8E65YguCV/9clSw0bL1IzZlnZS2mxtfjRACG7nq5mYHV7uY8ab74i2bw
   bXMAkMMbCUsSebNeM6gNAMOL8wZ7+0VXQ9JkI0JDqHr9MD0AStzN91Aos
   y8TP0RXTVYfwjEdjycDT3VBRZlU7Freqka7ZnsWIyh8Y3SOWu5N8lD5oz
   rUiOb8afov/z8L2vZkr1zv5w5LszkuufmOb3Z9Ixo/clsVbjA4CAILVYG
   z9ZgkeVTdzKb25EYd4Oow8YTzHcT183P0KryIso8q/qnqTSb6YmW9rA0P
   w==;
X-CSE-ConnectionGUID: 7iu+bTHUQ/GChfYzyqPOCg==
X-CSE-MsgGUID: uSf0By01R2WhOZLyZBcZag==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76084616"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76084616"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:46 -0700
X-CSE-ConnectionGUID: 1tMcUPwGSt2vZFW9MSOIMw==
X-CSE-MsgGUID: szn6bRtEQnGpQhYWmR6wbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221492247"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:45 -0700
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
Subject: [PATCH v7 22/22] x86/virt/seamldr: Log TDX module update failures
Date: Tue, 31 Mar 2026 05:41:35 -0700
Message-ID: <20260331124214.117808-23-chao.gao@intel.com>
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
 arch/x86/virt/vmx/tdx/seamldr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index b3f3b40627c3..a972f9ba6877 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -252,6 +252,11 @@ static void ack_state(void)
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
@@ -291,10 +296,13 @@ static int do_seamldr_install_module(void *seamldr_params)
 				break;
 			}
 
-			if (ret)
+			if (ret) {
 				WRITE_ONCE(update_data.failed, true);
-			else
+				if (curstate > MODULE_UPDATE_SHUTDOWN)
+					print_update_failure_message();
+			} else {
 				ack_state();
+			}
 		} else {
 			touch_nmi_watchdog();
 			rcu_momentary_eqs();
-- 
2.47.3

