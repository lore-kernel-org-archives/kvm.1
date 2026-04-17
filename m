Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797E373BE7
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411129; cv=none; b=DlKMReQuR3kkhviJdqYn/eLXgoAvqQOGO/XBPqlWI0ODqsXEMsNQ//IOr7mu+/E0pCxFMMgvG9UgUrb3KACJzebV+uizA5b8q+iul7PT0E8cSKd98vDVfGEK24C+14brvbdAYCELZcILMCliwz+NW8cSC1fBrjK/uApsrf8wLpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411129; c=relaxed/simple;
	bh=Wpnqm9w0dmfpcwQ7EoEr7ckY8/dg0Ow4sX1KjYabLxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPb1QiMK2CdzSOzsBZI9tK98rzPZsloQA8F0m7u2LfGt2BI+WCgt2LGdaik+TcPUl8hy1jUHLfPLWSp+L+6YSsef/WsvUHZT0N2C9Bp9oTwBXib+x3Oq/41c6+mBflwq1o+3/t8CSOUBhUPasrsIIy4vPzF0glOI4cwx29+efeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOP5jde+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOP5jde+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411128; x=1807947128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wpnqm9w0dmfpcwQ7EoEr7ckY8/dg0Ow4sX1KjYabLxM=;
  b=GOP5jde+Umr7siWNKmN4EbZB64CbIXqoJ/NsjrlgODJOLXbyWMbTDGKW
   CqMtUZAHoeYhhvelQvDKrLHWQQ7iiNm0pLWc+39XR94pOMAN+RffVvsrL
   PXExW+4C9A23302QzeN94aXDjvgVZvnpn4FKdEw6Z1MDi/l30fmuor9Eu
   vc3nTCUb46uJKQcV/5i9NE/zRzQAD+TuCzdWkVxF9fgnxZMMfPvVV9YSF
   /u597RfQICYrwLd0Vedm4WT85ambm1i9EaOxG50tZMBd2Dbrfg0+huQvq
   nQb0GZ5whrFizeMSd8b0tz1riJKcqNY3aKBJBIz0tOZPoKdflXf7OE1Gb
   g==;
X-CSE-ConnectionGUID: z42/KiPdTCmfeq0mTTCBZQ==
X-CSE-MsgGUID: VotYW4g1QTabCj5QXYf/eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070117"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070117"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:07 -0700
X-CSE-ConnectionGUID: KI+DfY4LR2u+oBtX/62NEg==
X-CSE-MsgGUID: pNHL2xa2QXyxXIVrHkOraA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284820"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:03 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 01/27] KVM: x86: Fix emulated CPUID features being applied to wrong sub-leaf
Date: Fri, 17 Apr 2026 15:35:44 +0800
Message-ID: <20260417073610.3246316-2-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Guard the use of cpuid_func_emulated() with a check that the CPUID
sub-leaf index is 0, as cpuid_func_emulated() unconditionally returns
emulated features for index 0 and does not account for indexed leaves.

Without the guard, when iterating over reverse_cpuid[] entries that
share the same CPUID function but have a non-zero index, e.g.
CPUID_7_1_ECX (function=7, index=1), the emulated features for index 0
are incorrectly OR'd into the wrong capability word.  For example,
RDPID (CPUID.7.0:ECX[22]) gets erroneously applied to CPUID_7_1_ECX,
which would allow userspace to set bit 22 of CPUID.7.1:ECX in the vCPU's
capabilities.

This is currently benign as the affected bits in the non-zero index
words happen to not correspond to meaningful features, but it could
cause problems as new features are defined in those positions.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e69156b54cff..25f582a8d795 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -399,15 +399,16 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		if (!entry)
 			continue;
 
-		cpuid_func_emulated(&emulated, cpuid.function, true);
-
 		/*
 		 * A vCPU has a feature if it's supported by KVM and is enabled
 		 * in guest CPUID.  Note, this includes features that are
 		 * supported by KVM but aren't advertised to userspace!
 		 */
-		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i] |
-					 cpuid_get_reg_unsafe(&emulated, cpuid.reg);
+		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i];
+		if (!cpuid.index) {
+			cpuid_func_emulated(&emulated, cpuid.function, true);
+			vcpu->arch.cpu_caps[i] |= cpuid_get_reg_unsafe(&emulated, cpuid.reg);
+		}
 		vcpu->arch.cpu_caps[i] &= cpuid_get_reg_unsafe(entry, cpuid.reg);
 	}
 
-- 
2.46.0

