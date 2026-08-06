Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C2642AFA7;
	Thu,  6 Aug 2026 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015470; cv=none; b=A3V56TTrGBF9BtLUYR/Zan0gEDIU2sTTQ/bwXisANISIbk6+gFwp9C2w/hqVTPdU8HCqhdo5e4SEdR/0Ok2k06YQ0ZglLUYnuqSNSogJL3LyWR1hbQ09mmuJaoYHYjer/gzcgcvBLN61wxQ4zgKbpfv7TXm3NikB/HdKTYFQS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015470; c=relaxed/simple;
	bh=OyIh6aMTzBARNySVPQ7G1lgNnAHsMqs1DMU0W7y+f5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9MLy9X12tj1oSCBwQv32ovxCrTwl7hO98uLIW09nnOPCA2XR3w4OvgkxpvpSRvJrGqs7Pm/Z0JdSbMRxAV7hdz3mzfISzGguVmcknqVEWlPcYXTrvhLzTpud63Cs3PlS7XUUxqrxHmWaPY/9K/X55GHsIuKuuPQDzjG5j9jE5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbdeI7nL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbdeI7nL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786015469; x=1817551469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OyIh6aMTzBARNySVPQ7G1lgNnAHsMqs1DMU0W7y+f5U=;
  b=bbdeI7nLRCqn/rBcFHsntcm1/Bxqe/UpV9AK7XgPsT/+vWKV1Z+U99M5
   /OvtpzZYNPSvcTVom8WykRY5E1ryKWExH7mj+7Zr9cCAbIghjl1JDWFjL
   2H+up/XV7QdO3sCVRBr1RFC/x2E5dOl4DvQbjBVI+MNGg3KU34RX4ODZz
   ZEsCnggOaQ9OiMZYi4C8BT5LFcOBAfkjBCklgOCFpid4sTWF9/GkZfGLj
   3jWKnPEOMPBcnzAYF1537z9lfgwuUcVlzNuiKML9/hg5Cc3yXyZOhY9nj
   QfbJzAPse6I3n31v+OXu3lt95EHI3veSMPbh2ZtByjC88oo+PSmbKVD7t
   g==;
X-CSE-ConnectionGUID: TE03s/bfQx2wCv0MMKi8Og==
X-CSE-MsgGUID: CeVWgc7hQdGMJU5tRTXa5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86617200"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86617200"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 04:24:28 -0700
X-CSE-ConnectionGUID: lWp+ZP4PTx+/lClfzlMaxQ==
X-CSE-MsgGUID: L+5hv8UxTG2pvq2w+BTXbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="267225064"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by fmviesa005.fm.intel.com with ESMTP; 06 Aug 2026 04:24:27 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 2/3] KVM: x86: Reject enabling KVM_CAP_X86_BUS_LOCK_EXIT when !kvm_caps.has_bus_lock_exit
Date: Thu,  6 Aug 2026 19:19:22 +0800
Message-ID: <20260806111923.1990562-3-xiaoyao.li@intel.com>
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

Return -EINVAL to reject the enabling of KVM_CAP_X86_BUS_LOCK_EXIT from
userspace when kvm_caps.has_bus_lock_exit is false.

For KVM_BUS_LOCK_DETECTION_EXIT, if KVM doesn't support BUS LOCK EXIT,
return error to userspace instead of success.

For KVM_BUS_LOCK_DETECTION_OFF, it seems OK to allow it when KVM doesn't
support bus_lock_exit. But from an API perspective, it implies
inconsistency that KVM_CAP_X86_BUS_LOCK_EXIT reports 0 but setting
KVM_BUS_LOCK_DETECTION_OFF is allowed. To keep it consistent, also
return error for KVM_BUS_LOCK_DETECTION_OFF when KVM doesn't support
BUS LOCK EXIT.

Fixes: fe6b6bc802b4 ("KVM: VMX: Enable bus lock VM exit")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
---
 arch/x86/kvm/x86.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d94b59140c45..3d8422d1cd04 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4058,8 +4058,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		    (cap->args[0] & KVM_BUS_LOCK_DETECTION_EXIT))
 			break;
 
-		if (kvm_caps.has_bus_lock_exit &&
-		    cap->args[0] & KVM_BUS_LOCK_DETECTION_EXIT)
+		if (!kvm_caps.has_bus_lock_exit)
+			break;
+
+		if (cap->args[0] & KVM_BUS_LOCK_DETECTION_EXIT)
 			kvm->arch.bus_lock_detection_enabled = true;
 		r = 0;
 		break;
-- 
2.43.0

