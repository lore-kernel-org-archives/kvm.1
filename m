Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D144E654;
	Wed, 19 Aug 2026 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133285; cv=none; b=eJE+fIQKs9BooRkNvE8ldYG4DhFroAMYoDdmmvYzNbIw80dgAnvizLmGvmewHIJro1yFImQnHR/p2INSlAQC5XUq3mTEduOv+T251eY9+seKTCDvoNqeof2G1o59kBb6auU5W2zO/pM/4ZUdKagCn/OynI8PrCBIO5pdhBMuNHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133285; c=relaxed/simple;
	bh=lrotawLdDfCNHz98+9pbLuuZyH1ENmRJGuWwnKfbDhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaSOpp3LLapVFGz6jKOoJJSI1jkdjVRyEFMbhT0D99w0EFZApMuS43y4F64gqGpfZgyKFsfhfgoUjMazyL90DvDmLgpYubPB37Bf5KjuxWOO8N8Gy9yb1KIIlD71NYBP2Tzrxrf/UwSnFBYDYlOiu5qBhihJ2NSFuNkH1aHiv4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpOi68D1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpOi68D1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787133278; x=1818669278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lrotawLdDfCNHz98+9pbLuuZyH1ENmRJGuWwnKfbDhU=;
  b=dpOi68D1Kfd2IPzShbuZ0Mtpqc24LDoGyYRdg/D8ybLHKuQlzFw6DNET
   VaV5yRHhrQsAVqUIuCo+EvbmX9wb0a+umkx4xB2BerfEzx+IWxshxhMZs
   6jyXk4o34guLCVWYN6NJlk5jlwNU7m6MpvzuknSU+zdeRq07eEKFDEMYb
   HmkIR60178ZGPw9/9pYTMjHTbXWC9wHBFCZaQxVE9W2I1f5+fFsrIbzCL
   6Bk4+1aqwNUpZ1j06rkaqvCnynwlduekUeSxAHZrhN5qyC7MerUn5tVnT
   /cyqga/A2Lb2Tvm5qKpu/r/FzKj13xvRPCuP7n8+dAisRzb94Iq+AGTbi
   Q==;
X-CSE-ConnectionGUID: Y2jgnelxTIWds9zi8iZ7Iw==
X-CSE-MsgGUID: IXtbE6MWQIKe+R9kMIfjjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87514950"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87514950"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:54:28 -0700
X-CSE-ConnectionGUID: OGsF/snlS6GXIlVQ41GSXQ==
X-CSE-MsgGUID: ardc860MRKGEeEfldxev3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="303708883"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by orviesa001.jf.intel.com with ESMTP; 19 Aug 2026 02:54:26 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	nik.borisov@suse.com
Subject: [PATCH v4 6/9] KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected
Date: Wed, 19 Aug 2026 17:49:00 +0800
Message-ID: <20260819094903.3060020-7-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819094903.3060020-1-xiaoyao.li@intel.com>
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preserve the negative return value from __vmx_handle_exit() when a bus
lock is detected, instead of always overwriting it with 0.

The purpose of bus_lock_detected handling is to force a userspace exit to
inform userspace that a bus lock happened. The negative return value can
achieve this purpose, and changing the negative value to 0 fails to return
an error to userspace. So, preserve the negative return value.

Fixes: fe6b6bc802b4 ("KVM: VMX: Enable bus lock VM exit")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260805034602.5B2BB1F000E9@smtp.kernel.org/
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
I'm not sure on the Closes: link, since Sashiko didn't find the VMX
issue directly.

Changes in v4
- grabbed from https://lore.kernel.org/all/20260806111923.1990562-2-xiaoyao.li@intel.com/
---
 arch/x86/kvm/vmx/vmx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 35ac9ddffaf4..d302d0ce47f1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6860,11 +6860,12 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	 * a bus lock in guest.
 	 */
 	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
-		if (ret > 0)
+		if (ret > 0) {
 			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
+			ret = 0;
+		}
 
 		vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
-		return 0;
 	}
 	return ret;
 }
-- 
2.43.0

