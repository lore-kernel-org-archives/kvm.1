Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC50D377007
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411156; cv=none; b=ZGnqCHM3w1yLgJ6UOd+9h8EZJTutGsrrSCsWEjZVxk45VMbWxwUeD6Zw/ZF4rx0Qs5Iii8p3T9IKKK+xvkYuhpF0D2uR3RseeP/qArIcIiSxXKFuqnihj45uwWAC/V+o07zIhcNFRatx+M+P2DmPrew2kpGutb57eHB2CB0lWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411156; c=relaxed/simple;
	bh=bt39ZvQFk2YOP8stD7zQj/1OT+NFnCxb9gfwaBDIH/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkQW0S2X3nYQYeO/Nux+keTBlxbfI9qYacbBNs5hAK7FxhNOQT8UV6uUEXjOtv1ROCr9RhrsA2YI7tDZaGVe9+V9aQlm2pqfXIHZGtEhV38ApmNMgo2fCH2u4gBvzz4XMsMFLPFWreUGAbZQAM8Lis5N6ywJ1gM+7ZZmuk4JlDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrFv313Z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrFv313Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411155; x=1807947155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bt39ZvQFk2YOP8stD7zQj/1OT+NFnCxb9gfwaBDIH/8=;
  b=nrFv313Ztfd4kWyVswymljfVROcE6rM1MLcPDWcQMObmLSe4l6bKEVcG
   geV2zmSUHhFszd3LKznkSvceOv2P4J0SJXChdSyNQbXFgBDSQ5jC4OuiQ
   g7YdW2T8PbtnAOKDKhWKq4OLbCNovNFm3HlkWYqiS1wcUjq+djZO+Kyk1
   JBGSzIKpYuFevvmUB/OzVdPIqyHeYhN2wpgufVOH1hsFUOmO1Ts5SWQx5
   TjjpltamKdT7qFqo8FhIczrSQMgvmYNwZBEwR5xugvQKeNlCngg5f8zd4
   OOQrDuSHa8+yWzgmcrKrCfw/fqU1OigG81tQdQqIwKCNyAxjhs7KoOVl7
   Q==;
X-CSE-ConnectionGUID: 0gf8edgIQHCeky2x55D+Ow==
X-CSE-MsgGUID: SdyBG03RSsur+qIjk9Ul4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070221"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070221"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:32 -0700
X-CSE-ConnectionGUID: XOd4a9pIRcGaq7MnxDl97A==
X-CSE-MsgGUID: pOdPFj3iQxqPQDN+SE4APQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284950"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:29 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 13/27] KVM: x86: Add a helper to initialize CPUID multi-bit fields
Date: Fri, 17 Apr 2026 15:35:56 +0800
Message-ID: <20260417073610.3246316-14-binbin.wu@linux.intel.com>
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

Add kvm_cpu_cap_init_mf() to initialize CPUID leaves that encode
multi-bit value fields for specified overlays.

Unlike kvm_cpu_cap_init(), this helper directly assigns the provided
value without intersecting it with native CPUID or boot_cpu_data. This
is necessary because multi-bit fields encode numeric values, e.g.
address widths, field sizes, etc., where the value userspace wants to
expose to guests may differ from the native hardware value.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index bdfaedb1cfcc..ea8ff5210e4a 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -259,6 +259,17 @@ static __always_inline void kvm_cpu_cap_check_and_set(unsigned int x86_feature,
 		kvm_cpu_cap_set(x86_feature, overlay_mask);
 }
 
+static __always_inline void kvm_cpu_cap_init_mf(u32 leaf, u32 features, u32 overlay_mask)
+{
+	WARN_ON_ONCE(!kvm_is_configuring_cpu_caps);
+	BUILD_BUG_ON(leaf >= NR_KVM_CPU_CAPS_PARANOID);
+
+	for (int i = 0; i < NR_CPUID_OL; i++) {
+		if (overlay_mask & BIT(i))
+			kvm_cpu_caps[i][leaf] = features;
+	}
+}
+
 static __always_inline bool guest_pv_has(struct kvm_vcpu *vcpu,
 					 unsigned int kvm_feature)
 {
-- 
2.46.0

