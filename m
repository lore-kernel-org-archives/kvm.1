Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0563B4570CB;
	Thu,  6 Aug 2026 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015471; cv=none; b=FO8Xb7UqMw1t/d/P1xD0xg+Kq1O6+C6u5Rh9/OJ6oCHMHvOHE/J//++qZwXTPP+Bd9Sqk+DSkf2hMRaRosgmJOKQbIEufar8fn6VwpyPtvs5DBSTkRtluionb+WaRE5K/lwxHXWFls1vFrj5NyOntXeT19r0IFMlZd4Gg4AoTPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015471; c=relaxed/simple;
	bh=isHhFSqON99RM9lN9KMHhx8YxIhQFYw/nL3WJQcjprc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nz6QZCh+rA7Wrq55kCEng8Nk0KfGPx9h9T/2wwui3VUf89A9wD+YUWByB+F/vW1dVl6GsfukMAF3jR+IyUW5aCoxGc/ak/S2xINDGK3AVaeOWnZUdItvZVD9IVBh0b29FFWtoRfEs0O6d0Rqa6xTDASUjPzLEjMAJzcDrf7QoKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERwC+k8z; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERwC+k8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786015470; x=1817551470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=isHhFSqON99RM9lN9KMHhx8YxIhQFYw/nL3WJQcjprc=;
  b=ERwC+k8zU9gu52NPZM9qDgpplJFs/JGKzMxn6/DB68OVy8zDktswWI1C
   CnJDfQxJGLayUrm2UdEaGfefVM6mOE6zM+HzFpv3QhNKanzONX22ej6Oa
   hKRgGzFJ6CfGaNzpIYzZzktN9CVMV+6Ph+eNErSBk1ThpgO5n4si0zESt
   Pi0/AdRMd0+e/IJ60WlzmenJZUl5ubIewpbWNXTnKzm0if4CsJWIHlEi0
   h84VVXjobyjXweRZ/8dLc7DQ3r2i5A9vrQX2Xgk30ScBAdLlcEb29ekDf
   ScLyTYoexZviuIh0S9BoHs66LcYomzs1A6xs77TIroxGbeCQCZUgJcrGs
   g==;
X-CSE-ConnectionGUID: +c4tNAK3SFybD6tx4kbPHg==
X-CSE-MsgGUID: iYOeId8ZTgWuLbM8aTVxVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86617209"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86617209"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 04:24:29 -0700
X-CSE-ConnectionGUID: RGTYbLApRR2xtOUuj81jJw==
X-CSE-MsgGUID: oFUKArw7S/GUBRIBfLF2vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="267225071"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by fmviesa005.fm.intel.com with ESMTP; 06 Aug 2026 04:24:28 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 3/3] KVM: x86: Only allow enabling KVM_BUS_LOCK_DETECTION_EXIT before creating any vCPU
Date: Thu,  6 Aug 2026 19:19:23 +0800
Message-ID: <20260806111923.1990562-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806111923.1990562-1-xiaoyao.li@intel.com>
References: <20260806111923.1990562-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When userspace enables KVM_BUS_LOCK_DETECTION_EXIT after some vCPUs have
been created, KVM may fail to enable the feature for created vCPUs. It
is possible for KVM to later enable the feature for created vCPUs in some
cases, but it's not guaranteed. Instead of introducing complexity to support
this use case, just disallow enabling KVM_BUS_LOCK_DETECTION_EXIT when
vCPUs have been created for simplicity.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 arch/x86/kvm/x86.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3d8422d1cd04..df8ee03cd9ad 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4061,9 +4061,15 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		if (!kvm_caps.has_bus_lock_exit)
 			break;
 
-		if (cap->args[0] & KVM_BUS_LOCK_DETECTION_EXIT)
-			kvm->arch.bus_lock_detection_enabled = true;
 		r = 0;
+		if (cap->args[0] & KVM_BUS_LOCK_DETECTION_EXIT) {
+			mutex_lock(&kvm->lock);
+			if (!kvm->created_vcpus)
+				kvm->arch.bus_lock_detection_enabled = true;
+			else
+				r = -EINVAL;
+			mutex_unlock(&kvm->lock);
+		}
 		break;
 #ifdef CONFIG_X86_SGX_KVM
 	case KVM_CAP_SGX_ATTRIBUTE: {
-- 
2.43.0

