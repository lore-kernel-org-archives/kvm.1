Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2192E2F1F;
	Wed, 20 May 2026 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284408; cv=none; b=cKIJ63ttqSnLGwaIzzqAnV/+WmfX7V25dzNq9JfsIq6cRqx/C+P9EWzGJJ5dC1B7IejXkBFXTenD07pt/nsZD7CswIMHSipTHbnWtra17IbzB6Y9Xt/MRS1/cZr+wZZMDzxJRBit6r2z2LEY1fS1Ldka3eEwRz+c0MXs4+xH2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284408; c=relaxed/simple;
	bh=8rfjTJTMMNoR4Sspo8JUOf6q9kOwUDez03bzPGnIrnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApqCTRG9REclED/3YxI6oYi28YBv8vckjWQzlsz3zxDPsIuRdABqrObrPXWTa7Llc2nFjQD9YeF3gE34o0G3YACLmQK/4wK1LCM0Ea4xQJsRbK8psEWr7oOHnFJ+9XbOIbOnYzqiIAI0X/bVpyyoM7SJ/+bWKwDzM2gf3/rTm2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1/qMy2x; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1/qMy2x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284404; x=1810820404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rfjTJTMMNoR4Sspo8JUOf6q9kOwUDez03bzPGnIrnk=;
  b=N1/qMy2xcI7IrmkCJQy/QGRDph0vPNo4PkzYZW6SyVx9Pb8KHemYp7fG
   Ziq9LA7+YGC6IPnnwjNZBtmRVzGwnzbjThG6ZkcH8goRxGAMnQX0QuHcS
   Qqy+PtwG5oUZgJHX/NgSRZ5GsWtLBJCFosk2G7mvVItxP3z4hk7i8+rNz
   LxBaP8vjgmZ7xIwmIWPtTq+I4g/JUZYMUB7M/EEr13OYD2v5XIuJeUqcM
   pPbcZvXdjcfdIC4XnTYzXp7W3uIXNiX+vZD8noXs9K/UKxoEWBTWWUO76
   s0+MhOWsdJoR3tl1bnUUo+c47BXkdE3YuxQMD42y6by3NEiBpRpgA3q6+
   g==;
X-CSE-ConnectionGUID: kUYE5tiQQG6Urw18mEY2jw==
X-CSE-MsgGUID: 7ubk0ABORNC+NtcJTJeSoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146397"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146397"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:01 -0700
X-CSE-ConnectionGUID: lPpUJ2FUSoW6dEo4n3TOHQ==
X-CSE-MsgGUID: 7Amo8i5SSfWs5y6dzfuB+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923613"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:00 -0700
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
Subject: [PATCH v10 02/25] x86/virt/tdx: Move TDX global initialization states to file scope
Date: Wed, 20 May 2026 06:38:05 -0700
Message-ID: <20260520133909.409394-3-chao.gao@intel.com>
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
saved result. A lock protects that cached states.

Those states and the lock are currently kept as function-local statics
because they are used only by try_init_module_global().

TDX module updates need to reset the cached states so TDX global
initialization can be run again after an update. That will add another
access site in the same file.

Move the cached states to file scope so it is accessible outside
try_init_module_global(), and move the lock along with the states it
protects.

No functional change intended.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index ad56f142dd0b..40444a3c5cdd 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -105,6 +105,10 @@ static __always_inline int sc_retry_prerr(sc_func_t func,
 #define seamcall_prerr_ret(__fn, __args)					\
 	sc_retry_prerr(__seamcall_ret, seamcall_err_ret, (__fn), (__args))
 
+static DEFINE_RAW_SPINLOCK(sysinit_lock);
+static bool sysinit_done;
+static int sysinit_ret;
+
 /*
  * Do the module global initialization once and return its result.
  * It can be done on any cpu, and from task or IRQ context.
@@ -112,9 +116,6 @@ static __always_inline int sc_retry_prerr(sc_func_t func,
 static int try_init_module_global(void)
 {
 	struct tdx_module_args args = {};
-	static DEFINE_RAW_SPINLOCK(sysinit_lock);
-	static bool sysinit_done;
-	static int sysinit_ret;
 	int ret;
 
 	raw_spin_lock(&sysinit_lock);
-- 
2.52.0

