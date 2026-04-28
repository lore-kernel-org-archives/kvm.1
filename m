Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D07C396B79;
	Tue, 28 Apr 2026 02:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344226; cv=none; b=GC0zG1r4qkzKSJC7EG1TjNcsZ445M02W55PQ7ipLA51QKLxv5eS3UJNGlTS4ZcUkZJwRSAZxzG27M4AvIH37ZHGaM2Olanp+tBVqkcueIkAXVmp7woGsfY+WTGGAE6GOK+FAqC3N7zv6a2oqQ16nFILoltyFdZoYGOG+nk9YKTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344226; c=relaxed/simple;
	bh=VPN4TNcLgUjmoLhUfCq2BusgP2O3ulC9z1EBngPVOAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9mSwJNpmvxwhmJjwTOlWggL1OnqtCyWhdWgwUWGmV7MhEPuFiVFLgfXfuCEAOg/lbt3nilyBxj/p/9iQxrNJ2PD+3PBzYUCP4hxB9Wk4ywUCcmS+AdrEvE05drt6gEYFQtsLyMf5Ou1L24b4QV28aNTRLdzPALZW0VKBP7XYJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8sMfDQ5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8sMfDQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777344225; x=1808880225;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VPN4TNcLgUjmoLhUfCq2BusgP2O3ulC9z1EBngPVOAc=;
  b=J8sMfDQ5Xx6MW2mzbQlnuVHAfo4/KW3Tud7dNhCy0DkoHhol/NDGpfDg
   X3yYwLwjVXhOEDsaqnXmt+cRnJoyyIjvks3WBp1s74TTKQpnHA/QTSF6N
   /Tl9Xm+HqLi9q2D1FPwFRktQXt0L9xNfdAuwlUiT+fqK+HFQkhaX316MJ
   bsLYAkuZnnIGd/Or/IiZaFYQgqyqWWcGc5MzDzHycQoS8151cHoIfH4gS
   yb23aU5ReLHYFc/Gf7IWhgA0ey+RZc9lJyod7k/16CAmTe+WfPU1mdWLt
   KIamKleEYH2o1jQ06EUL0HJQyguYU92T1dgwAn5UwYr/UfpeGwe6P5tpU
   Q==;
X-CSE-ConnectionGUID: dq2L5Qh+ReyU0N0bJ5+F+Q==
X-CSE-MsgGUID: IHdv9/FZSvmhQHfOEcKLxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82095992"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="82095992"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 19:43:45 -0700
X-CSE-ConnectionGUID: y6iMDkwvR7WK7yozgX3zzw==
X-CSE-MsgGUID: h8EJz1KLQRWjMmllbsvbQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="271943201"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 19:43:41 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	dave.hansen@intel.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	binbin.wu@linux.intel.com
Subject: [PATCH 0/2] Fix MSR_IA32_PLATFORM_ID access for TDX guests
Date: Tue, 28 Apr 2026 10:47:44 +0800
Message-ID: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit d8630b67ca1e ("x86/cpu: Add platform ID to CPU info
structure"), the Linux kernel reads MSR_IA32_PLATFORM_ID during CPU
init. This causes unchecked MSR access errors when running as a TDX
guest, because KVM doesn't include MSR_IA32_PLATFORM_ID in
tdx_has_emulated_msr().

On KVM side, this patch set adds MSR_IA32_PLATFORM_ID to
tdx_has_emulated_msr() so that KVM returns 0 for TDs reading this MSR,
consistent with how KVM already handles it for normal VMs.

Optionally, in order to provide back-compatibility for newer Linux guests
running on older KVM hosts without the fix, the second patch skips the
MSR_IA32_PLATFORM_ID read entirely when Linux is running in a
virtualized environment. This could be dropped if we think the fix on
KVM side is sufficient.

Binbin Wu (2):
  KVM: TDX: Allow TDs to read MSR_IA32_PLATFORM_ID
  x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in virtualized environment

 arch/x86/kernel/cpu/microcode/core.c     | 2 +-
 arch/x86/kernel/cpu/microcode/intel.c    | 4 ++++
 arch/x86/kernel/cpu/microcode/internal.h | 5 +++++
 arch/x86/kvm/vmx/tdx.c                   | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)


base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
-- 
2.46.0

