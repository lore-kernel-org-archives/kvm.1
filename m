Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369445;
	b=WJjt33G6gpkefR9uzerFSbe3moY5vDrPRJIoIZsTv4jL5dgUmE7aRprpb3JTrLfUsAti
	 tQkiDC1/5H8jKlUJiPZ8xlAQc4UUfEZCkJ0xV3UmIDZYI1lfKtMjd/K4QjjEf50UjRr7M
	 sw0ETLvuSuy/F7et6cA4KhvnBl+s83w1vj3yH+Tz3co4/Qb9GKjDFj0TMvDZioCIQNqeB
	 tsO3kcbdYj34199vyaldSfjFTJ1pv1aqBBfp4jwkjrcbXt6jpYA8aDMscoc+A8ZqtTy4R
	 seSsfGzD0+ZASt3Doz9z4wENwOD9A5IIYPJWMF+K8OzZVApX1ZhLSfVg3KGvB2n5XGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369445;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=BMihiUsQERY/wr1+6kH/VNH8RnqCD9s0TStJ2r+fLIk=;
	b=ouctNAQ5QCYOjn7vePgaaPXjXqZ4WwmWT1w57AOFiiKsSQ7eD7L/K8lmt8gRD7zS+BpH
	 8CMO98FwGF1toMQ5MTeniIAHA9uPjX73+DpLN7vF54fkwCueZaOTnT/qDEgTxZ3mlv21H
	 lLcbhNdwpOU3RpKSxg0RZnMCexTDB58tFwhRUzsbjFDjAuanRxsfVD94O28u/QX05KobP
	 sPy9Bo4xbNT/qjCuFBg91q8TO07PpO9FenEbSiPrP6utJhI5rfl3iTEI4E4HKNXf+5kfp
	 wA+/N9Vw7ONfcYJTyJgJRBN1vZa/r2V5e0+iznQr4bc/x63kaL+F/EQjNR7INKoJfrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nBnt0WFf;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1ED606A327;
	Wed, 11 Nov 2026 03:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F1ED606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nBnt0WFf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794369445; x=1825905445;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hfZP8tMnHNG5zOG7UGpYG3BlDGb8Y99JJtk1lY43blg=;
  b=nBnt0WFfzcGM18ibQ+UIOQWAPEfPVr9U7kud69BMDAId7H3nzBR+wgB2
   ktwXZNCbk+T44lcNp8V/jgZfhRe2y07xl1H2YvDUUOjy86VvqflXIAOJj
   owhnT+H531nALS+LCbLjPf+vNy4vOTioBL9HZooyKyECcJEIgqY/7kdxH
   uqSQZ9pU3nNQF+zISnK6O3Wgcxh8cAj+5B+Z3uBh8J7Xl4WL8BfPp2Nnz
   U2dFRptyxC2vEAcoWygKHp64N4/5eeNqeKM9ZRLVc4gWus8/zmPGiV9hJ
   /flM6Q8o0CO/Whkj6e4PKVeYPzug/2cULwT+In26B0ncg7F0c4yC/olU+
   w==;
X-CSE-ConnectionGUID: 4iVhrq25QiydvgPWgMJs/w==
X-CSE-MsgGUID: i5mFAdN0R4G+lSAnOKXaRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3220304"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3220304"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 19:57:25 -0800
X-CSE-ConnectionGUID: 5rU4wX6YTJGpB7LnnLQpvQ==
X-CSE-MsgGUID: bfpwhyQjQjeZOAblyNE2Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="10199266"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by fmviesa013.fm.intel.com with ESMTP; 10 Nov 2026 19:57:21 -0800
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Wed, 11 Nov 2026 11:48:47 +0800
Subject: [PATCH v5 6/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-tdx-module-ext-v5-6-c74f764abc3d@linux.intel.com>
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
In-Reply-To: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
To: x86@kernel.org, linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com, 
 kvm@vger.kernel.org, yilun.xu@intel.com, yilun.xu@linux.intel.com, 
 xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
 kishen.maloor@intel.com, tony.lindgren@linux.intel.com, 
 peter.fang@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, 
 chao.gao@intel.com, artem.bityutskiy@linux.intel.com, nik.borisov@suse.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3800;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=hfZP8tMnHNG5zOG7UGpYG3BlDGb8Y99JJtk1lY43blg=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWR9frqyQ+RO+EEt6xkHOCokRbIOihvy2CxkmGQ6s9zF9
 u71wJdPOjpZGMQ4GAzFFFkWeMxymtI+i2nrp53XYOawMoEMEZapzMwpzdOrKHXIzCtJzdFLzs9l
 4OIUgKlau5Lhr+TWH1smNM+Xf9rALLUtz9q0zv60F+OR8xf+qz6/JLJy8TNGhutVZ83qZOdmvCk
 SOeWp8iN6L9MCxf9b76osejop7/vrAm4A
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

Runtime TDX module update introduces a mechanism to update the module
firmware while preserving and restoring TDX operations. The extensions
functionalities should also be re-initialized as part of the restoration
process.

The TDX architecture supports an update flow which allows updated
extensions to consume more memory than their original boot-time
requirement. So the arch defines the extensions re-initialization flow
the same as boot-up initialization: the host queries TDX module how much
additional memory needed, allocates it, adds it to the module via
TDH.EXT.MEM.ADD, then re-initializes the extensions via TDH.EXT.INIT.

Linux runs the updates in stop_machine() context, which prevents memory
allocation. So for Linux, a compatible update must not install updated
extensions that require additional memory.

Given that the memory for the extensions must not increase, the
re-initialization skips the memory adding steps. It is simplified as:

  - Check if the extensions are supported via TDX_FEATURES0_EXT. If not,
    skip the extensions re-initialization.

  - Re-initialize the extensions via TDH.EXT.INIT. The SEAMCALL leaf
    will fail if the updated extensions require more memory, which
    indicates the update image is not compatible.

The original changelog was written by hand. AI was used to help correct
grammatical errors and polish individual sentences for better
readability.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v5:
 - Better clarify the AI usage

v4:
 - Collect Reviewed-by tags

v3:
 - Add this patch back cause the latest discussion decides the
   re-initialization won't be integrated in TDH.SYS.UPDATE, a dedicated
   TDH.EXT.INIT call is still needed (Dave & Rick)
 - Drop the ext_required check (Rick)
 - Rename the reinit function as reinit_tdx_module_extensions() (Tony)
 - Move the reinit function right under tdh_sys_update() (Rick)

v2:
 - Removed this patch cause the TDX module is expected to re-initialize
   the extensions on TDH.SYS.UPDATE

v1:
 - Don't update the extensions metadata any more, only check the
   metadata originated at boot time.
 - Remove memory_pool_required_pages check, let TDH.EXT.INIT fail if
   more memory required.
 - Changelog & code comments
---
 arch/x86/virt/vmx/tdx/tdx.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 3a1ba4e73cfe..afdc6b5e667d 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1343,7 +1343,7 @@ static __init int tdx_ext_mem_setup(void)
 	return ret;
 }
 
-static __init int tdx_ext_init(void)
+static int tdx_ext_init(void)
 {
 	struct tdx_module_args args = {};
 	u64 ret;
@@ -1374,6 +1374,19 @@ static __init int init_tdx_module_extensions(void)
 	return tdx_ext_init();
 }
 
+/*
+ * Don't update the memory requirement metadata or try memory allocation in
+ * stop_machine(). If an incompatible update requires more memory, let the
+ * extensions re-initialization fail.
+ */
+static int reinit_tdx_module_extensions(void)
+{
+	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
+		return 0;
+
+	return tdx_ext_init();
+}
+
 static __init int init_tdx_module(void)
 {
 	int ret;
@@ -1557,6 +1570,10 @@ int tdx_module_run_update(void)
 	if (ret)
 		return ret;
 
+	ret = reinit_tdx_module_extensions();
+	if (ret)
+		return ret;
+
 	ret = get_tdx_sys_info_version(&tdx_sysinfo.version);
 	/*
 	 * Only fails if there is something unexpected

-- 
2.25.1

