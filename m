Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BAB469859;
	Wed, 19 Aug 2026 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133290; cv=none; b=YTcHeF7tfJKWsLP923azlEsmamk+8Vf4Q8Fn4kfEEX6+lh5KA94AS9Ns5+5ynbyFt+xJEiDaLjb9HfVBoIBGka3hq77s//uVE7+r4GdHxycGUMyZ7znB2p7AD+wjHNV0QfAPeZRm0adJcO+Pihhl8hToM90DZUl8C6VRJRyc/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133290; c=relaxed/simple;
	bh=Xt9weOB2lj5KYEsyJLVJDLtGjvntwyLSMZgoSJIRW28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYxG3SqT+9bAXTpcVY6/QXSuJR9maxX93Ig6xBCXlSM+/yW+pzRZ/gJh6wtGy20ZWg97MloyHeIk4rvXBRIyPYeaVV2Ybd0sBcDo7Qm+MlGFb96+HtMfpo7pl3APkyPktRqqVAuLZxFuOVYCBlJfcAAMfS2vY8cG/LRhDn6uDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tdu0eXQT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tdu0eXQT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787133281; x=1818669281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xt9weOB2lj5KYEsyJLVJDLtGjvntwyLSMZgoSJIRW28=;
  b=Tdu0eXQTIh4OO8tfLQfFWTqMXNnCDeMwiX7pxEX/K7hyY9BrM6PQdm25
   NGIIExn9xhmD5nJZ7RFwGI6yjC9VSQt6D73i5uGu7Deqp/S6xDTaUbFzv
   HAQ+M4c/yfHURL0VXhIPWF7dErIG9+yhSZeXteYZshhFSIi82EyGei++l
   zoF8tyzZwR6NSeyXsYXm+VaouoHaiHBEsi5XazY8FlOwS9XhoVD4d/AFg
   JJWsv5S5r9hQ19A/EvG8D7HK3xiOaOJ21e41IXvuDnKa0PAuPtTpFmiUd
   PzlbRXLloO8Kwnv6oR+6qZTWnDsUp13hRFEtfwaps7ElTVxoItesB4axN
   Q==;
X-CSE-ConnectionGUID: 6iRpAtnnS4CudenNZ8N6Cw==
X-CSE-MsgGUID: 6sH40P/4R8CzkdFfVvtjCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87514996"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87514996"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:54:32 -0700
X-CSE-ConnectionGUID: HM1S2T6vTyeMdj2+i6+LJQ==
X-CSE-MsgGUID: xwEVNGg8SBu2wkcOD/+ISg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="303708892"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by orviesa001.jf.intel.com with ESMTP; 19 Aug 2026 02:54:30 -0700
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
Subject: [PATCH v4 8/9] KVM: TDX: Enable Bus Lock VM exit
Date: Wed, 19 Aug 2026 17:49:02 +0800
Message-ID: <20260819094903.3060020-9-xiaoyao.li@intel.com>
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

Enable Bus Lock VM exit functionality for TDX guests.

Bus Lock VM exit is an existing feature supported by KVM.  Userspace can
enable Bus Lock VM exit through KVM_BUS_LOCK_DETECTION_EXIT when it's
reported as supported.  However, KVM reports the support of this CAP
just based on the hardware capability but doesn't differentiate between
VMX and TDX.  This leads to the issue that userspace can enable this cap
for TDX guests without getting an error, but the feature is not actually
enabled because KVM doesn't call the TDX module API to program the
relevant TD VMCS fields.

Enable Bus Lock VM exit for TDX guests by programming the
BUS_LOCK_DETECTION control in the TD VMCS and by adding the exit handler.

Note, there is no enumeration bit for this feature by TDX module because
all TDX modules support it and allow to set the TD VMCS as long as the
hardware supports the feature.

Fixes: 161d34609f9b ("KVM: TDX: Make TDX VM type supported")
Cc: stable@vger.kernel.org
Originally-by: Chenyi Qiang <chenyi.qiang@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in 4:
- The code to make handle_bus_lock_vmexit() a shared helper is split
  as a separate patch.
- The handling for wait_for_sept_zap is no longer needed since a general
  handling for it is added as a separate patch.

Changes in v3:
- Refine the changelog. (Rick)

Changes in v2:
- Don't overwrite the negative return value to 0. (Sashiko)
- Clear the bus_lock_detected bit when it returns early for
  wait_for_sept_zap case.
- Add a note to clarify the feature is always supported by the TDX
  module, to make Sashiko happy.
---
 arch/x86/kvm/vmx/tdx.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 014710945e8a..8db0c67aaadc 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2058,7 +2058,7 @@ int tdx_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 }
 
 
-int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
+static int __tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	u64 vp_enter_ret = tdx->vp_enter_ret;
@@ -2159,6 +2159,8 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 	case EXIT_REASON_NOTIFY:
 		/* NMI blocking state is handled by TDX module */
 		return __vt_handle_notify(vcpu, vmx_get_exit_qual(vcpu));
+	case EXIT_REASON_BUS_LOCK:
+		return vt_handle_bus_lock_vmexit(vcpu);
 	default:
 		break;
 	}
@@ -2168,6 +2170,22 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 	return 0;
 }
 
+int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
+{
+	int ret = __tdx_handle_exit(vcpu, fastpath);
+
+	/* Exit to user space when bus lock was detected */
+	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
+		if (ret > 0) {
+			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
+			ret = 0;
+		}
+
+		vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
+	}
+	return ret;
+}
+
 void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 		u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code)
 {
@@ -3194,6 +3212,10 @@ static int tdx_vcpu_init(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
 				vcpu->kvm->arch.notify_window);
 	}
 
+	if (vcpu->kvm->arch.bus_lock_detection_enabled)
+		td_vmcs_setbit32(tdx, SECONDARY_VM_EXEC_CONTROL,
+				 SECONDARY_EXEC_BUS_LOCK_DETECTION);
+
 	tdx->state = VCPU_TD_STATE_INITIALIZED;
 
 	return 0;
-- 
2.43.0

