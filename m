Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206C1531E8;
	Wed, 20 May 2026 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284404; cv=none; b=oqzCKpCWWyjv0PeUXNkvAzN3JWVQ7qeP3Dc/TAdER15cMZ6u/fuba1gY1JrhJyy08DVQ47iOqd3WoZ+JY4gHmiPm7kXYFPhujiNTQcZXD2PcVrHqTU3w+gARzR0m+h1IkJ0/1mXtGDk5SEsGma483KJX4Wpbe9JPGKCJj4nEono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284404; c=relaxed/simple;
	bh=Dnc6vYjOgJ7kPnjh+chu/5a8ACZuGGWSZJFZC4cfU6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GG8IfVKstAT68dHjTjw4gfu1S60bd8jqevfGBXgPLCGSPyCqBliHuq/PaeOxFjpiS+2esQdQVbRHrNGuNZaEZNzE8EuxEFaWhPfPrCb6hAsmXcTIgWBXV3U2lWSo2umEA51CHfyctR2tOen3RXF3tGxgH25sxkmWqvkheMqRs0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GH5XFL/+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GH5XFL/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284402; x=1810820402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dnc6vYjOgJ7kPnjh+chu/5a8ACZuGGWSZJFZC4cfU6M=;
  b=GH5XFL/+gDUJ5DbQ/2/hJ+TxmzSIQb9e32AUlp8GXaoJWTpJtM78o9Cw
   3keZaWLvuoeP0xJqGdnob8SVb2nlb95DPS6CLMYu6IrRaxcT1ESH1SEL/
   TV7E3VblHhL4AK2/ysN59AvX/F117kfex66S2dIct03ybdLG+zQOBvLuC
   ROa/Aedp+8QGIRllZIjdZOWhnMRXeAD+S7JOcjtX3hPUwlPXnVq/PcPQ/
   0ouFzulzIwj6V0tAIWlQxVZYyj+5PP5AQ3JSo1MU2tNlvwhVfReyemlxX
   52QwNuwF8Jj5NkESxv03R/6ZyuqIbYlY8pSQ6C835GCW4cpbI5ySbAVPC
   A==;
X-CSE-ConnectionGUID: 7EvSNPNXRs+AwIWcGpVWsQ==
X-CSE-MsgGUID: AK61UmP3S/iqoqEDmWMAdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146387"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146387"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:00 -0700
X-CSE-ConnectionGUID: kgJHbNTvQFCArELGFUUbYg==
X-CSE-MsgGUID: 3Vag2oDBSAKCkuj3p+Xj8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923599"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:39:59 -0700
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
Subject: [PATCH v10 01/25] x86/virt/tdx: Clarify try_init_module_global() result caching
Date: Wed, 20 May 2026 06:38:04 -0700
Message-ID: <20260520133909.409394-2-chao.gao@intel.com>
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

TDX module global initialization is executed only once. The first call
caches both the result and the "done" state, and later callers reuse the
saved result. A lock protects that cached state.

The current code is hard to read because sysinit_done is accessed under
the lock, while sysinit_ret is not.

To improve readability, move sysinit_ret accesses within the lock.

Group sysinit_ret/sysinit_done updates right after initialization so
Caching the result is separate from the initialization itself.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index c0c6281b08a5..ad56f142dd0b 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -115,28 +115,34 @@ static int try_init_module_global(void)
 	static DEFINE_RAW_SPINLOCK(sysinit_lock);
 	static bool sysinit_done;
 	static int sysinit_ret;
+	int ret;
 
 	raw_spin_lock(&sysinit_lock);
 
-	if (sysinit_done)
+	/* Return the "cached" return code. */
+	if (sysinit_done) {
+		ret = sysinit_ret;
 		goto out;
+	}
 
 	/* RCX is module attributes and all bits are reserved */
 	args.rcx = 0;
-	sysinit_ret = seamcall_prerr(TDH_SYS_INIT, &args);
+	ret = seamcall_prerr(TDH_SYS_INIT, &args);
 
 	/*
 	 * The first SEAMCALL also detects the TDX module, thus
 	 * it can fail due to the TDX module is not loaded.
 	 * Dump message to let the user know.
 	 */
-	if (sysinit_ret == -ENODEV)
+	if (ret == -ENODEV)
 		pr_err("module not loaded\n");
 
+	/* Save the return code for later callers. */
 	sysinit_done = true;
+	sysinit_ret = ret;
 out:
 	raw_spin_unlock(&sysinit_lock);
-	return sysinit_ret;
+	return ret;
 }
 
 /**
-- 
2.52.0

