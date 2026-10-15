Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685E43F210C;
	Thu, 15 Oct 2026 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092240; cv=none; b=rYRPoR3nGlvix1COq8gP+prRsZ1B3LpxgWG+puc7DN5aL8QF1BjYoJbvMTehkXZQRCjBL4wcYbnfDW52DQHaoWLHuMOjeo8Yp/+XQ2jWTpjCyc3iZ4faSg59b6bmmbn+4rh0BAm0zNRuvrNiIBCMPrssy272xl8mCFdgGGxOdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092240; c=relaxed/simple;
	bh=drnsMmlo0/kFdXnXsEi9yVwfZa26x6ahZwO3Xr9d1FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ff4EgEsWNwFfKE5u07DT6iHLVPMnm95R3J1HBnc+cbviJUjUCvgIHpohfhBiOa3/FjTw6VM9h97I9+KsgiVyBJ74ZL3Eq2MNnNgXDOvRShj8qHT4ch1h50YDRLIDCrQz0lo+Pr00uSxQla9/uQyVEXxpnw8ndlT8QNK2OQjNeBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4aI9BJ5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4aI9BJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792092239; x=1823628239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=drnsMmlo0/kFdXnXsEi9yVwfZa26x6ahZwO3Xr9d1FU=;
  b=i4aI9BJ50un5UThSwyvdPKfC+jHwq8R6e0CaZnQBrsx1gg+kYmEzNETR
   y17fvQX5Jk5yqeLQmEJ89fozRt3J+MFR+50omtpPfpCWyWnuCvc7iqnlj
   HFnBUbcgbkMnF3qMEj9HZsAB5BnN5A6WPTtYMH3Au/6aqoyGwj0wqkEd8
   b0Xkke1A6BZjpAcirVuXLLYR+wFYEEcsI+STCFo+YNhBJMUdomCHV2tPy
   uoiiWYtUX90y68XY+lGwHI4uvhbqtuz8Xhpl9poGDJgiF3gjpYAKY2kRT
   vL+Kxx5sulwo8ZL53ZTxvNU5j7fGvsnf9XxDvdTrQTEVHxgpy6nummIYs
   Q==;
X-CSE-ConnectionGUID: CVqwDo5OQjaXUEhsBWlk+w==
X-CSE-MsgGUID: ZiCdX+1YQf+pat12Vj4+MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="764806"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="764806"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:17:18 -0700
X-CSE-ConnectionGUID: ASKiAG61QHKF/3NpHubQPA==
X-CSE-MsgGUID: ROs+S65cTaW9fmba6Ogvxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1836892"
Received: from rpedgeco-desk.jf.intel.com ([10.24.81.149])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:17:16 -0700
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
	kvm@vger.kernel.org,
	nik.borisov@suse.com,
	yilun.xu@linux.intel.com,
	tony.lindgren@linux.intel.com
Cc: rick.p.edgecombe@intel.com
Subject: [PATCH v2 0/2] Drop unneeded cache flushing
Date: Thu, 15 Oct 2026 12:17:08 -0700
Message-ID: <20261015191710.3632302-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi TDX developers,

Can I get another round of review before we ask Dave and Sean to look at
it? I'd like to pick up a few more RB tags.

-- Summary --

In the early days of TDX it was assumed the HW would need some cache 
flushing help around transitioning memory between KeyIDs, and so TDX arch 
was designed to specify how the VMM needed to help the module perform 
this. But it turned out the HW was able to handle these issues without SW 
help. For some reason the TDX arch around performing the flushes remained. 
Now the TDX arch is getting fixed and Linux can remove the code that was 
helping perform this unneeded cache flushing. The changes will appear in 
a future documentation update.

As some more context, while this is nice cleanup as is, merging these 
patches will let us drop 2 patches out of the TDX huge pages series. Then 
that series doesn't need to modify these flushes to work with TDX huge 
pages. It also addresses Kiryl's comment about the cache flushing in 
tdh_mem_page_aug() not respecting the 'level' arg, or warning that non-4KB 
sizes are not supported.[0]

-- Changes since v1 --

Yilun asked if we could also remove the WBINVD calls around kexec and TDX
setup error paths. It seems the answer is likely yes, but not confirmed
enough for me yet. So I left that change for the future. Besides, it
doesn't have the same TDX huge page intersection.

Yilun's comment about cleaning up the TDR reclaim after the changes in 
patch 2 was a bit bigger that I expected. I really debated whether to 
split that out. But it wasn't very feasible to do it as a prep patch, so I 
left it as one big bigger. Really debated doing that, or an follow up 
cleanup patch. Opinions requested.

Based on v7.3-rc7.

Thanks,

Rick


Rick Edgecombe (2):
  x86/virt/tdx: Drop tdx_clflush_*()
  x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()

 arch/x86/include/asm/tdx.h  |  2 --
 arch/x86/kvm/vmx/tdx.c      | 40 +++++-------------------------
 arch/x86/virt/vmx/tdx/tdx.c | 49 -------------------------------------
 arch/x86/virt/vmx/tdx/tdx.h |  1 -
 4 files changed, 6 insertions(+), 86 deletions(-)

-- 
2.55.0

