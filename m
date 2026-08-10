Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C63B7B9D;
	Mon, 10 Aug 2026 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361227; cv=none; b=XdhsDKUbF63zfD+B7YBJCPQgjOHMFCpKsL+jK/osfaEdVj/ui03Jo7SCQR2mfuNvGuRnDbbq69Z1fPMDfvc5FIT4eRdm84m6chgKkN8x9XLyOUSvA0Qz/rjRG02YEMclIb8eizqjtRK16iNWoxEbABV6EZGqG4fj/4aqbhIaFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361227; c=relaxed/simple;
	bh=wWaVS26hy3gDMXzyp41DvhtfjZjgfr++xZVngrqw25o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJaNbUUnQYK7VhJcdL6x12PtqMsH/8eNlaxiMSruvl6D3j5iNMq/VID515sLLzEt+FWXh4O5Ock3bT01OQfUoADkpMsrvO4kUgCd1Ihy8DAPc3uSWuOcLyRxk5peuwV9MH8eek9O369ctAHMuo3c3ntklsw77hszM6jOGTccwl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8zbz2sn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8zbz2sn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786361225; x=1817897225;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wWaVS26hy3gDMXzyp41DvhtfjZjgfr++xZVngrqw25o=;
  b=P8zbz2snflgAwVIFWZ4MmxtFsqxxy0DeUha0mymMMV5hQKaKpkypCLhG
   rLwA54OexVdie5lt9DtoBwgtHrIUIpmdfV4TTfIwQ14usxVJ0tTPfMwwq
   BI59CS0Ycc2QdPyK1c6RzgBIYHbkrmYG4QzOG0A5kQ5GyRmPVU7O1vUt6
   ttPDmkN46mneN3jlA7FJDQI0OrC9uPnRy5KzzYbgE/5ZOMKH1fR7Q7p71
   l839+Nf9RRJytixs6GHl7aK4LmuClLvbyP7BJX1lSnWcVaClGiu8sxjAq
   0yakjqvDme6Y80kVkk4ao7cBABXF1s7ynvmGLAiVKneo61KJ/s+2RrRZL
   g==;
X-CSE-ConnectionGUID: nZTSHDopRSKZHX3I7VoQog==
X-CSE-MsgGUID: 1DKvOsw6Qf+om7zMuo3jKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97221224"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="97221224"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 04:27:05 -0700
X-CSE-ConnectionGUID: JrcVGKGPR0i5VgXk/k0lYw==
X-CSE-MsgGUID: bYWTJW1MSCyGNJvxIj6vZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="264999162"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by fmviesa004.fm.intel.com with ESMTP; 10 Aug 2026 04:27:02 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [PATCH v2 0/3] KVM: TDX: Enable VM-DoS Prevention Features for TDX
Date: Mon, 10 Aug 2026 19:21:57 +0800
Message-ID: <20260810112200.2326727-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is v2 of the series to enable the Notify VM Exit and Bus Lock VM
exit for TDX, which fixes the KVM CAP issue related with them and allow
userspace to actually enable the features.

This v2 tries to keep the series as small as possible and it adds one
more patch, patch 02, because it's targeted for being backported to
stable kenrels.  The comments on v1 that are not addressed by this series
will be handled in followup series separately, such as renaming notify vm
exit to instruction timout, tdx fast exit handler and vp_enter_ret
handling, etc.

Please refer to v1 for a full background.

v1: https://lore.kernel.org/all/20260805031257.1844914-1-xiaoyao.li@intel.com/

Xiaoyao Li (3):
  KVM: TDX: Enable Notify VM exit
  KVM: TDX: Fix the exit reason handling
  KVM: TDX: Enable Bus Lock VM exit

 arch/x86/kvm/vmx/common.h | 19 ++++++++++
 arch/x86/kvm/vmx/tdx.c    | 73 +++++++++++++++++++++++++++++++--------
 arch/x86/kvm/vmx/vmx.c    | 15 ++------
 arch/x86/kvm/vmx/vmx.h    |  1 +
 4 files changed, 80 insertions(+), 28 deletions(-)

-- 
2.43.0

