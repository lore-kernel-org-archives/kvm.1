Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4C0377023
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411180; cv=none; b=WwMeiymPSwcOnpLxomO9CZ9JN3tr/T4yBCadRYnHc3S93dAsVpEq58RJdXHpG8MmrXc86IHIwwKqfjz4y+3Nlfm8s8jnt9ZH2Wmi/7h28XotuT6xlQelQf7Vv8aB+DrS2LLg2dBhoK0ycr8PxACdLRO93THnFRkh5efUZuz9d9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411180; c=relaxed/simple;
	bh=mPZ6nyvn4hFYcLdH3lb9ES0wAwPYbQbD/vQMAVmy4GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upeOnUtNGqMXyTC16f0hsArzM8oepWUEUlMNywgFMh+j0IT/tNeZV+5Nxfn0lwFmJJb4Ml3xqfEu7aFPoETPPAkcfrhB85S8i/EcJfMEBODTC5xqfi0BKV25oy6140TYsQXYucIpqgPlHkPbCw+WY7lu7KlfRpggVU+C7jy1tHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZgqaIYi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZgqaIYi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411180; x=1807947180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mPZ6nyvn4hFYcLdH3lb9ES0wAwPYbQbD/vQMAVmy4GI=;
  b=XZgqaIYiPtY7anLSLXAmO/XYDdRPPshd0GvF/A0bI92i2G/OD9n0/7sf
   VonQNPxbicKaYNdsoMFTbXRYLkWpow9SJILCu6feqU3rQ0x8uCnavSStn
   0nWQLEuH0lioBYUAGZvir8Y0jpohywBDx1k6tmfzrNq/SgdMh5vCBLjWt
   xo5RtYUK0Ge7BNhOKZXxQTMKI+5feH7XrhKwYIMVV1vSD9eLQcudpcAnP
   4cqZxd1HYTTEjYf9qvSwdYA8kjRAY82A1atdlIgTf8hEpzMRMXqKZdMAa
   W/S8rkruU993wGgbSaJADv8vm4/+f1jHtXxRl4cAVrgtO5bk3DOZLS7G9
   g==;
X-CSE-ConnectionGUID: trzWcN9FT1S6SxhDth6//w==
X-CSE-MsgGUID: XQC5oiE0R4mKZ6nTF3efyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070325"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070325"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:59 -0700
X-CSE-ConnectionGUID: I27WaMnKTIaPjRZ2/iDnrQ==
X-CSE-MsgGUID: 3yY14O8hTqinduGinZsq1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226285104"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:57 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 26/27] KVM: x86: Add a helper to query the allowed CPUID mask
Date: Fri, 17 Apr 2026 15:36:09 +0800
Message-ID: <20260417073610.3246316-27-binbin.wu@linux.intel.com>
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

Add and export kvm_cpuid_get_allowed_mask() to let vendor modules (e.g.,
TDX) look up the allowed bitmask for a specific CPUID leaf/subleaf/
register under a given overlay.

TDX is probably the only user, CPUID features emulated are not
included.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 16 ++++++++++++++++
 arch/x86/kvm/cpuid.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e6f0ecadc290..30fb61c1430d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -526,6 +526,22 @@ static int kvm_check_pv_cpuid_relocated(struct kvm_vcpu *vcpu, struct kvm_cpuid_
 	return 0;
 }
 
+/* CPUID features emulated are not included. */
+u32 kvm_cpuid_get_allowed_mask(u32 func, u32 index, int reg, u32 overlay)
+{
+	u32 leaf;
+
+	if (is_cpuid_paranoid_ignored(func, index, reg, overlay))
+		return (u32)-1;
+
+	leaf = cpuid_reg_2_x86_leaf(func, index, reg);
+	if (leaf == (u32)-1)
+		return 0;
+
+	return kvm_cpu_caps[overlay][leaf];
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_cpuid_get_allowed_mask);
+
 static int cpuid_check_and_set_vcpu_caps(struct kvm_vcpu *vcpu,
 					 struct kvm_cpuid_entry2 *entry)
 {
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index cff5e71579ce..251003d78990 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -85,6 +85,7 @@ int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
 			      struct kvm_cpuid_entry2 __user *entries);
 bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 	       u32 *ecx, u32 *edx, bool exact_only);
+u32 kvm_cpuid_get_allowed_mask(u32 func, u32 index, int reg, u32 overlay);
 
 void __init kvm_init_xstate_sizes(void);
 u32 xstate_required_size(u64 xstate_bv, bool compacted);
-- 
2.46.0

