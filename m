Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1CD5012B9
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687057; cv=none; b=hDURWXCVMfOhoee+bg++xCHkIWMME/NKgO8xLmXVXT6XaisT0bng+j/TYbdgMgrz2nlqbMghmfdA/P/W+pJdwpPl7mLmh2k9Lz7LQi0SVhc9t/meHg5vcEaQCzfuCdLwItngEUACDkstddj+SApFQlWzYQnGUMI3lYc1sTuGjUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687057; c=relaxed/simple;
	bh=NZtFOz//WPMbBQGPi/EBcBXNelS6rNh+c8nARksit88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khMTi+yUS0O90tF/aBqSqy3bRiIXjGVGGGCnajqvnXuuw6u0JIWzPNIYy5+FHCLcK70fduSxW486Vx2vNt4pRJ+kvXlOwxdZ5fVvKoKY2op13tlfIyrgRmLf6V/uE6FC9lC5xllnbonrlsIYZB22shBAI/gzX8P9b+CstQ9Kol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mBZPPMEj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBZPPMEj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790687055; x=1822223055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NZtFOz//WPMbBQGPi/EBcBXNelS6rNh+c8nARksit88=;
  b=mBZPPMEja4lffcAvgnfkxNNLkSILVTlI6SLTpc4fe7le6KjTSsHw3RG6
   xbeIUwsZRsBwYgXgavCOffxk3m9UtLYcVWW/Fc21B5AXcdSHVG7+MDohU
   IbyyLbk3Jb2aEb5vlS7rpqCtcqJgJi7N+GnCQj+vCrJDJsog85FsoySGq
   mqF+vo4RvI5Ue/sVTEBffUtxg51m0aaaygnqnWW3NfL+c9pNlBK2aRHHN
   5J2oe38GBbbFUN5rM69+mzOUVpIwV9mc3o2W6GNhY1tNF8zorCpTYAVcb
   alpbOVUx1OCZFkf0DzbD+41e6YcCO6mCBh80n7/gAgP9KSizN1QZsrvAj
   w==;
X-CSE-ConnectionGUID: zw5SIXSjS2aBovKlxdhdtQ==
X-CSE-MsgGUID: 3bZQfdpLRPCtMkPiw6y6qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="108894089"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="108894089"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 06:04:14 -0700
X-CSE-ConnectionGUID: +LidmRoeSN6PR08z3e1BgQ==
X-CSE-MsgGUID: TGfZ/AVFS9G+5S+FKSSnKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="275397812"
Received: from lxy-dev.sh.intel.com ([10.239.48.89])
  by orviesa009.jf.intel.com with ESMTP; 29 Sep 2026 06:04:13 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [kvm-unit-tests PATCH v2 1/2] x86: Make cet and lam tests KVM-only
Date: Tue, 29 Sep 2026 20:24:33 +0000
Message-ID: <20260929202434.174501-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929202434.174501-1-xiaoyao.li@intel.com>
References: <20260929202434.174501-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing "-enable-kvm" in qemu_params forces tests to run with kvm
accelerator.  This leads cet and lam tests to run with kvm accelerator
silently without any warning even when "ACCEL=tcg" is passed.  Change to
require "accel = kvm" for cet and lam tests so that they can be skipped:

  SKIP cet (kvm only, but ACCEL=tcg)
  SKIP lam (kvm only, but ACCEL=tcg)

when "ACCEL=tcg" is passed.

As a bouns, removing the use of "-enable-kvm" will allow pass $ACCEL and
$ACCEL_PROPS to the standalone "-accel" QEMU parameter, since QEMU
translates "-enable-kvm" to "-machine accel=kvm", which is not
compatbile with "-accel" parameter:

  qemu: The -accel and "-machine accel=" options are incompatible

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 x86/unittests.cfg | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index ae731a93dc7a..afc0f7128c03 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -535,9 +535,11 @@ groups = tsx-ctrl
 file = cet.flat
 arch = x86_64
 smp = 2
-qemu_params = -enable-kvm -m 2048 -cpu host
+accel = kvm
+qemu_params = -m 2048 -cpu host
 
 [lam]
 file = lam.flat
 arch = x86_64
-qemu_params = -enable-kvm -cpu max
+accel = kvm
+qemu_params = -cpu max
-- 
2.53.0

