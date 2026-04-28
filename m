Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E63A872B;
	Tue, 28 Apr 2026 02:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344231; cv=none; b=DIgbrkMhkTT2fwGzuD96MWleO+rQBEEJ8A502MC67sV2Jwjvbi58Dcx8rNR9BrXAf15Ex/wLQEJbuBv7bb6XK8cJdzvgeWkUO4vFlM6Lx+8gk0bq89GAErLG0gNyJ2MOTy8bEazczedW5tCJAdstiyCEhr3V33Uv5YN/rC5Efuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344231; c=relaxed/simple;
	bh=CD4b6il938wUu9Dh3ZufGL0a78us6sJ5/s7k+OQi0qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TslYQngqUz4j+FGhxZyCcCe2DYG/TlrFNjUHZXTv9EFchzYeeOR1QlyMY3tIRy3rjOgSLrNNUIzvJqYOnvXthDpQXAwfyyvjQ4aSO7YJWNx52R+lL3tYCi1DfqMnWO9KvJtrPHfF1ABRRPzEMLkrAbjELDD6Owc4WZjx1H8KsoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qb8c6nMV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qb8c6nMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777344228; x=1808880228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CD4b6il938wUu9Dh3ZufGL0a78us6sJ5/s7k+OQi0qo=;
  b=Qb8c6nMVw02BWb6IsaVCEb+1EQ+sZghKFw3KIkAr7e6ujR+0xTBqagzI
   LfbPG+9xQP8yQ4eugjxscP+Zep6o7M0TtHb+QuxeVlVnD+0Jc+GZ2TDmh
   bp0oWXn84kDmJqgj5r1SRSIEApSbRnqAYQRVQaPysLEKTiNoYfxIFNRHz
   TlGObYo0mxu/yFV6nWeGpG8b0JvHh+Uf++cWTGLBgV6gu54aCDL28Vcug
   NCpMGVFH2Lr2fx6h8/JI9Ho1b/z7xN8Nn/MCgrVHoc1lWXM7Sb7kN0Gio
   28jmnxxwl5Aa1J+cMyqUHPm7Kkn5FrkjSb+pe22JLpY+Lu6GYh6xVyPvy
   w==;
X-CSE-ConnectionGUID: Af+psqe6RR2j/P/nsm+TUw==
X-CSE-MsgGUID: w+T2dqYtS2iqubo9NMY9aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82095997"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="82095997"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 19:43:48 -0700
X-CSE-ConnectionGUID: LX2mEWMiRuyUtVT2Pkjs9Q==
X-CSE-MsgGUID: AigD0zVmRdiCikmhWPR4Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="271943206"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 19:43:44 -0700
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
Subject: [PATCH 1/2] KVM: TDX: Allow TDs to read MSR_IA32_PLATFORM_ID
Date: Tue, 28 Apr 2026 10:47:45 +0800
Message-ID: <20260428024746.1040531-2-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
References: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MSR_IA32_PLATFORM_ID to tdx_has_emulated_msr() so that TDs can read
it.

Linux kernel reads MSR_IA32_PLATFORM_ID during init since commit
d8630b67ca1e ("x86/cpu: Add platform ID to CPU info structure").  KVM
already supports this MSR on read for normal VMs by returning 0.
Without support for this MSR, TDs get unchecked MSR access errors.

    unchecked MSR access error: RDMSR from 0x17 at rIP: 0xffffffffba38d6fc (intel_get_platform_id+0x7c/0xb0)
    Call Trace:
     <TASK>
     ? early_init_intel+0x28/0x2c0
     ? early_cpu_init+0x9b/0x930
     ? setup_arch+0xbf/0xbb0
     ? _printk+0x6b/0x90
     ? start_kernel+0x7f/0xaa0
     ? x86_64_start_reservations+0x24/0x30
     ? x86_64_start_kernel+0xda/0xe0
     ? common_startup_64+0x13e/0x141
     </TASK>

Add MSR_IA32_PLATFORM_ID in tdx_has_emulated_msr() to allow TDs to read
the MSR.  MSR_IA32_PLATFORM_ID is read-only by hardware definition, i.e.
KVM should never add it as writable, no need to add it in
tdx_is_read_only_msr().

Fixes: dd50294f3e3c ("KVM: TDX: Implement callbacks for MSR operations")
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 04ce321ebdf3..812ad99b11e5 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2094,6 +2094,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 bool tdx_has_emulated_msr(u32 index)
 {
 	switch (index) {
+	case MSR_IA32_PLATFORM_ID:
 	case MSR_IA32_UCODE_REV:
 	case MSR_IA32_ARCH_CAPABILITIES:
 	case MSR_IA32_POWER_CTL:
-- 
2.46.0

