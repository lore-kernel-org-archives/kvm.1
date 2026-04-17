Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D368B375ACF
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411141; cv=none; b=qj7VUE7IfdiA20RgbLoe/DkVpY3WGey6kkl1Xf3E5Liell89cGfjYjrINyb+YLW98ACVcN4H/mnTMqzzWI6DvRybsk9IQgKhXFwKTZUaU43GLRszOmTFajkUrEdmwQqCd9jYn0RwdV4H3aWIKYzlp2pHgepNRmUPy6rVtkAkWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411141; c=relaxed/simple;
	bh=xTOt8zrlh8X2674pNMKEa6owxLlRacDLJ4iYaCw5uxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J58vrqyjVDCi9gUUzFe4d+3iGIBj1VaKrh02EKAtzUoa4yE2roNBF89achFzMIrJcq0JaRxedz6ciOk6V4z/Yf27Cs4kfN+s8k74zmS65IT6BxpGTd5gdNkzxLzsWf4kCy2SH7XnltfHqs8YizeHGvSzdqfdnFn6+oWpQ7qgN4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJA6RKKB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJA6RKKB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411140; x=1807947140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTOt8zrlh8X2674pNMKEa6owxLlRacDLJ4iYaCw5uxA=;
  b=fJA6RKKB4HnnI3A66igmsI3xcPnDwU9EgfDr7Da1buPSL9xX1tLDPNoO
   X2lB/apwajrjlzAoAMksH5+fh85UlWtyXD3VifT/RhEHFJ+WQlDGr8rjP
   KzvRWbxXiaBMH8QOeTeYIQDGAwScPibiELiMyNGN2FwCQmA01tnrXwnG6
   MNtxnNsqJoyC5ulqGrz7GBC4u4LPNbTYartl++n1Tl/lWTaT4NOrBUyXk
   zue7LBvqGDgrq6KWGQ9cC+N9J+3nnD2EvEnlLpGAY6gxCiCuJi5mN6w1K
   N044t7ANpxrFi8w0K4JflK06mdMtSA9DLsU1UrFBu5Le028U94Qb8pldO
   Q==;
X-CSE-ConnectionGUID: 7uh0t/RtRi+Qmo2bvx6aUw==
X-CSE-MsgGUID: 8I59kwKJQNupYCh6AC/w2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070170"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070170"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:20 -0700
X-CSE-ConnectionGUID: lIyo/Vn0Q1enG/a2raDb1A==
X-CSE-MsgGUID: 8D3d6Id7Sw2jH9No0K1m/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284893"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:16 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 07/27] KVM: x86: Support KVM_GET_{SUPPORTED,EMULATED}_CPUID as VM scope ioctls
Date: Fri, 17 Apr 2026 15:35:50 +0800
Message-ID: <20260417073610.3246316-8-binbin.wu@linux.intel.com>
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

Handle KVM_GET_{SUPPORTED,EMULATED}_CPUID in kvm_arch_vm_ioctl()
so that userspace can query supported CPUID on a VM fd.

When issued on a VM fd, KVM can return CPUID data tailored to the VM's
type (e.g. using the TDX overlay for TDX VMs instead of the default
VMX overlay).  @kvm is not yet used to select the overlay; a follow-on
patch will wire that up.  The dev-ioctl path continues to work by
passing NULL for @kvm.

Extract the copy_from_user/copy_to_user boilerplate into a shared
helper, kvm_get_cpuid(), used by both the dev-ioctl and VM-ioctl
paths.

There will a be new capability added for CPUID paranoid mode in a later
patch, reuse that capability to tell userspace that the VM versions of
KVM_GET_{SUPPORTED,EMULATED}_CPUID are supported.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c |  7 ++++---
 arch/x86/kvm/cpuid.h |  6 +++---
 arch/x86/kvm/x86.c   | 42 ++++++++++++++++++++++++++----------------
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 938b19767feb..9634ea01d2a3 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -2013,9 +2013,10 @@ static bool sanity_check_entries(struct kvm_cpuid_entry2 __user *entries,
 	return false;
 }
 
-int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
-			    struct kvm_cpuid_entry2 __user *entries,
-			    unsigned int type)
+/* The input kvm could be NULL, check it before using. */
+int kvm_vm_ioctl_get_cpuid(struct kvm *kvm, struct kvm_cpuid2 *cpuid,
+			   struct kvm_cpuid_entry2 __user *entries,
+			   unsigned int type)
 {
 	static const u32 funcs[] = {
 		0, 0x80000000, CENTAUR_CPUID_SIGNATURE, KVM_CPUID_SIGNATURE,
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 4b1274f055e5..0afde541b036 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -74,9 +74,9 @@ static inline struct kvm_cpuid_entry2 *kvm_find_cpuid_entry(struct kvm_vcpu *vcp
 				     function, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
 }
 
-int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
-			    struct kvm_cpuid_entry2 __user *entries,
-			    unsigned int type);
+int kvm_vm_ioctl_get_cpuid(struct kvm *kvm, struct kvm_cpuid2 *cpuid,
+			   struct kvm_cpuid_entry2 __user *entries,
+			   unsigned int type);
 int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
 			     struct kvm_cpuid *cpuid,
 			     struct kvm_cpuid_entry __user *entries);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index db8434f9a2ee..525fcb09a4c0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5041,6 +5041,26 @@ static int kvm_x86_dev_has_attr(struct kvm_device_attr *attr)
 	return __kvm_x86_dev_get_attr(attr, &val);
 }
 
+static int kvm_x86_vm_get_cpuid(struct kvm *kvm, void __user *argp, unsigned int ioctl)
+{
+	struct kvm_cpuid2 __user *cpuid_arg = argp;
+	struct kvm_cpuid2 cpuid;
+	int r = -EFAULT;
+
+	if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
+		return r;
+
+	r = kvm_vm_ioctl_get_cpuid(kvm, &cpuid, cpuid_arg->entries, ioctl);
+	if (r)
+		return r;
+
+	r = -EFAULT;
+	if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid)))
+		return r;
+
+	return 0;
+}
+
 long kvm_arch_dev_ioctl(struct file *filp,
 			unsigned int ioctl, unsigned long arg)
 {
@@ -5076,22 +5096,7 @@ long kvm_arch_dev_ioctl(struct file *filp,
 	}
 	case KVM_GET_SUPPORTED_CPUID:
 	case KVM_GET_EMULATED_CPUID: {
-		struct kvm_cpuid2 __user *cpuid_arg = argp;
-		struct kvm_cpuid2 cpuid;
-
-		r = -EFAULT;
-		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
-			goto out;
-
-		r = kvm_dev_ioctl_get_cpuid(&cpuid, cpuid_arg->entries,
-					    ioctl);
-		if (r)
-			goto out;
-
-		r = -EFAULT;
-		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid)))
-			goto out;
-		r = 0;
+		r = kvm_x86_vm_get_cpuid(NULL, argp, ioctl);
 		break;
 	}
 	case KVM_X86_GET_MCE_CAP_SUPPORTED:
@@ -7628,6 +7633,11 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = kvm_vm_ioctl_set_msr_filter(kvm, &filter);
 		break;
 	}
+	case KVM_GET_SUPPORTED_CPUID:
+	case KVM_GET_EMULATED_CPUID: {
+		r = kvm_x86_vm_get_cpuid(kvm, argp, ioctl);
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
-- 
2.46.0

