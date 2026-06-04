Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218F7261C;
	Thu,  4 Jun 2026 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535478; cv=none; b=hoT7PaVkk83+tYLX1gZRhqsSiCOTvqhBHNiztlbwVuGpMAdZ/DqUOq02ZZKBBoC/c8nX2JWVjZe9qPo75sOTN1BSGaAsBK3Gc1Rza7aRVHWIiBIqCT7RrCLWHtVNpyDmNXPSSLv0/ahl7eoQNbaNvkIB6aAg9cHKvRFThIm+8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535478; c=relaxed/simple;
	bh=zF/pxGGLx2M1uSvDtqLzftdd+XMKiQ6snvx3hUfiJ0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fO1oIM/p7H2iIEVfbkyeF7FYhmy33KUY0EC52aYXpx8swc2Smmy+6eK3n0H0bGUa+YBA+z0HW5FSqgt48oQGYOa9HYEp8j/AgAKyRl/gey7KjudHcxKG1d+sXYRDrU3qym+poqBnHT/YzSiEvUVqijOoUfAQI4nbq/mjwfp0kdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imSM8da9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imSM8da9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780535477; x=1812071477;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zF/pxGGLx2M1uSvDtqLzftdd+XMKiQ6snvx3hUfiJ0M=;
  b=imSM8da9ZK5ssPEVLPBhPh8u4ioXqNhz56MfWSb4W6JrA+rAv52+ZKPs
   esZHXODi1nKdJM6YYUwfdfH5dve5DXekB6BbIOPf+d9R7zIepymqrbLGH
   z/kOTtXCKbsKy6qfNOgsQtny9McBg7T9yLzJ9rrjMaQ7I8wZECqZYC0jB
   bpnrQYAthFkFo+SETrpRhZBk3TGWCgGEsI3YMTiAtiOGVBagL44YkdnQG
   +gsTXVm1OJYKEDAaWFE3ozC4yj7BAHA2KY8ZNtDvvU6E8seaozYFemxQm
   RL0Q0KwmZ6wUxPp4MBJUeb9/FH0mkgcHkFcU+axxspPfVBgiDG1b44VwH
   g==;
X-CSE-ConnectionGUID: zvoRzthoSPO2D4u/3UX36w==
X-CSE-MsgGUID: p/wfRAMgRDy8tzT/w1QZ3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81214164"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81214164"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 18:11:17 -0700
X-CSE-ConnectionGUID: A1HHuhhfRyqMsj9By+Rdtg==
X-CSE-MsgGUID: 6sjtHBG7Qq2nfiJXfT8cUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="239924533"
Received: from khuang2-desk.gar.corp.intel.com ([10.124.222.135])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 18:11:14 -0700
From: Kai Huang <kai.huang@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai Huang <kai.huang@intel.com>
Subject: [PATCH] KVM: x86: Use <linux/lockdep.h> for lockdep header inclusion
Date: Thu,  4 Jun 2026 13:11:06 +1200
Message-ID: <20260604011106.315176-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9717efbe5ba3 ("KVM: x86: Disallow guest CPUID lookups when IRQs
are disabled") added a lockdep assertion to catch unexpected cases where
guest CPUID lookup is performed in IRQ disabled context.  However that
commit used the "linux/lockdep.h" for header inclusion.  This header is
kernel wide but not KVM local.  Switch to using <linux/lockdep.h>.

No 'Fixes' tag since there's no real bug here.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index fd3b02575cd0..591d2294acd7 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -11,7 +11,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
-#include "linux/lockdep.h"
+#include <linux/lockdep.h>
 #include <linux/export.h>
 #include <linux/vmalloc.h>
 #include <linux/uaccess.h>

base-commit: d4bfaa66fa171089b9b9fb2dc17af9245f2b9b34
-- 
2.54.0

