Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F143BDCD;
	Thu,  6 Aug 2026 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015468; cv=none; b=DZgnlTHS3Cjvb94xUq8KX2WMIDinLW0j3O9ALSL6GDk3i0MG69NXF1mMK8L6umkuttINcfaYbZ8Oh/5yZTrFLk/H1kJ0k12rJgft+FqcOzoFI7a+RcYietnC2bPJE81K4Mx7CYN/GZxlAjUA16LvHtmvnAHSRp393EYmNBqmPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015468; c=relaxed/simple;
	bh=/aX44MsGPFBYQ9hf0Exvq4l0dEXgLJroJsi7T69Jg/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZEgNUSg7EXIJiP+47JsEB+A/HLMmr5TsxGUjA6Wf77XE1NPuzkEuYCDjjVuKZcIYhu3Py4xxjKxaWDuGy35KSY+Qa4Ij3+tz62Iv+dtFbPgz9iletXYv3OTHK2LaV0MsG7JFchzAY8LD11lYWEbO/kRqq3GudXPHA+VeF6+EBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lfc15nIz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lfc15nIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786015466; x=1817551466;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/aX44MsGPFBYQ9hf0Exvq4l0dEXgLJroJsi7T69Jg/Q=;
  b=Lfc15nIzuOlTKmXFDDwfjPc1Kimlzn58M4fVCN8QqjINgYwByIxRJWBL
   jpaiv+hr6s84NxC3YoW+qBraC3uJzwq1Rdh0t0Gf690/ErD2zloQWGWB3
   pATisKwr8IuhFfgj0qtPSsTfNJ9sQ7GZ+9gZ3/DkXl3TwIpZJNbuuiXI0
   kN2GGwl3pFV45vC9Rck//xBVeUUbJJHOzntP36rjg2WQ85iZIF/QXq5jh
   CsBpC+/Sxpasq/crisULhm3uN2aW2+bU4Il0LJ+e3hEjTDvc8zbrWy8B0
   /S66dB7DQ8KSDnvlmmzhVsZDn21ckyqsQM3x4DJJ/zKGwYEN5DhJe8ryq
   w==;
X-CSE-ConnectionGUID: CFMLdGkMTueYWrfz55Dn9Q==
X-CSE-MsgGUID: lTY8PTAOREmPmCFs/w9JLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86617190"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86617190"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 04:24:25 -0700
X-CSE-ConnectionGUID: 7+eQnIoySmyGCVXEtKxX2w==
X-CSE-MsgGUID: R2Oa10yMR/qB69Qfz7z6AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="267225052"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by fmviesa005.fm.intel.com with ESMTP; 06 Aug 2026 04:24:24 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 0/3] KVM: x86: BUS_LOCK_EXIT fixes
Date: Thu,  6 Aug 2026 19:19:20 +0800
Message-ID: <20260806111923.1990562-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains fixes for x86 Bus Lock Exit feature.

Patch 1 fixes a bug which is somewhat discovered by Sashiko, when it
reviewed the TDX Bus Lock Exit enabling patch [1]. It pointed out one
issue for the TDX patch, and I found the existing VMX code has the same
issue.

Patch 2 and patch 3 fix the issues for KVM_CAP_X86_BUS_LOCK_EXIT,
which were found When I tested the TDX Bus Lock Exit enabling patch.

[1] https://lore.kernel.org/all/20260805034602.5B2BB1F000E9@smtp.kernel.org/

Xiaoyao Li (3):
  KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus
    lock detected
  KVM: x86: Reject enabling KVM_CAP_X86_BUS_LOCK_EXIT when
    !kvm_caps.has_bus_lock_exit
  KVM: x86: Only allow enabling KVM_BUS_LOCK_DETECTION_EXIT before
    creating any vCPU

 arch/x86/kvm/vmx/vmx.c |  5 +++--
 arch/x86/kvm/x86.c     | 14 +++++++++++---
 2 files changed, 14 insertions(+), 5 deletions(-)


base-commit: a806d364ef288a6443a1337820ea8410a7ccc6b3
-- 
2.43.0

