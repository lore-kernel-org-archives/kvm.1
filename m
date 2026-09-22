Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9743B4AA;
	Tue, 22 Sep 2026 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110384; cv=none; b=NqjvOkroLF57yZWlKEVdI2lh5HFM0E4NeizXCoBrdYpTsSNwC+ybewNso4TFcr5Hz8phbDeFA/cURcywYfG0An/wr+NaKJ0okiwgzcrrGQohSIS9/8KJmzsMORiy7dOJG/prPFbVZA3uBh6dYp+Yx3iRfy8UNpsgtghNlmxcgZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110384; c=relaxed/simple;
	bh=u1oUaITjzjpvz1A9ArnfyFRgBZB3uQ8BhHx7NUp0WHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7yUXyG2hDmZngfNInOKiLvPwkah1kILxV3LddYiuuR0oiCFBsgJFG1EoXfIwYcqJOX1TCZzzUJW5XZaais0ZII69CHEGCXcvmAiQMgBU7hEFH1zc5b0OvaDdyPuLSHqLEzwjA8aUiedDmtOE8gyz/mrBXAX5P0Bj8r3H8PhAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sr77r2wP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sr77r2wP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790110373; x=1821646373;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u1oUaITjzjpvz1A9ArnfyFRgBZB3uQ8BhHx7NUp0WHc=;
  b=Sr77r2wPmv+KeDqqVr39oPv/A/vgtFqWprEsEyqloEy0jnsDYLMQlFWg
   mkbKM/gmQ29BaBu4/p/KpxBOgBEqBnJRCrXwOm6wzNRkjhM0WEr1/Slr/
   8hp5IaLiIcqA9+OXtdlVOSvgeqAenqQyomiPJlJSzI4YhxljINZDo4PiH
   j/Il67njFlSMKYbMmamI8++MLGakAGY9YltflxSYUpd8s7pXgKfEq5mbY
   QsBuIRFf4M1lgHEtgdfCX24BXf4rUh2RdoWbX4H4FP9RBMMnQsqvIf30v
   LO2bbyBfPFr/xk4OCHsqzsCHXMXrRW/mVD981CfXHimjPFYG6hjoRtBd3
   w==;
X-CSE-ConnectionGUID: i2UHsvPWR3GV1FOBjqH11A==
X-CSE-MsgGUID: +KyJm6Z+RS+pH6HFifPGuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101343602"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="101343602"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 13:52:43 -0700
X-CSE-ConnectionGUID: 25cP273ATAiRduuy7bBCKQ==
X-CSE-MsgGUID: Gh8mjI+iT4ucDQ403mXBNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="271877314"
Received: from rpedgeco-desk.jf.intel.com ([10.24.81.149])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 13:52:43 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: pbonzini@redhat.com,
	dave.hansen@intel.com,
	seanjc@google.com,
	x86@kernel.org,
	kas@kernel.org,
	adrian.hunter@intel.com,
	yan.y.zhao@intel.com,
	binbin.wu@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: rick.p.edgecombe@intel.com
Subject: [PATCH 0/2] Drop unneeded cache flushing
Date: Tue, 22 Sep 2026 13:52:13 -0700
Message-ID: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi TDX developers,

Can I get a round of review before we ask Dave and Sean to look at it?

In the early days of TDX it was assumed the HW would need some cache 
flushing help around transitioning memory between KeyIDs, and so TDX arch 
was designed to specify how the VMM needed to help the module perform 
this. But it turned out the HW was able to handle these issues without SW 
help. For some reason the TDX arch around performing the flushes remained. 
Now the TDX arch is getting fixed and Linux can remove the code that was 
helping perform this unneeded cache flushing. The changes will appear in 
a future documentation update.

Especially, please consider if the explanation is clear enough for 
maintainers and future git archaeologists.

As some more context, while this is nice cleanup as is, merging these 
patches will let us drop 2 patches out of the TDX huge pages series. Then 
that series doesn't need to modify these flushes to work with TDX huge 
pages. It also addresses Kiryl's comment about the cache flushing in 
tdh_mem_page_aug() not respecting the 'level' arg, or warning about that 
non-4KB sizes are not supported.[0]

Based on v7.3-rc1.

Thanks,

Rick

[0] https://lore.kernel.org/lkml/20260825025533.25663-1-yan.y.zhao@intel.com/#t

Rick Edgecombe (2):
  x86/virt/tdx: Drop tdx_clflush_*()
  x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()

 arch/x86/include/asm/tdx.h  |  2 --
 arch/x86/kvm/vmx/tdx.c      | 14 -----------
 arch/x86/virt/vmx/tdx/tdx.c | 49 -------------------------------------
 arch/x86/virt/vmx/tdx/tdx.h |  1 -
 4 files changed, 66 deletions(-)

-- 
2.55.0

