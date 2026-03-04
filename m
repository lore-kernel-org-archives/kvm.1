Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030603D34BF
	for <kvm@vger.kernel.org>; Wed,  4 Mar 2026 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648128; cv=none; b=brPYslgTPGbxUjupUE3IZMaGyKsINay7BmJEV8Gs9dCYZcqyM22IfW226vGTeSAm5S5aW6RoR3PMAKtMI4WtQNvTZFbILOH/wB0MYsWys4lCGLFXZlr3R9uEpnHMKnoQpb6/FOqoZPylKcQokVJO7m7gcOqaeW9ckInYOQozttE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648128; c=relaxed/simple;
	bh=QEP92vBSwHQx5y1RIYH9jHcfZSZY2SQok02SXDN/lGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWAIbFc/RcvGFDa88QUAF0Z0hqQbyDC/wo5kr07ZSWCLWuy6o0BvlZsJPRAHH8VPZXtiV7BKP5gqdvkGoaqJhUKLrqwMj8iHyHacUvvCkCqpuBXgQ2B0IcMto2/aNGdniwmB2VaZj2Wl9N+iHshQMzHU1nta37hMMzALTLkj/2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neZlrg7N; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neZlrg7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772648127; x=1804184127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QEP92vBSwHQx5y1RIYH9jHcfZSZY2SQok02SXDN/lGk=;
  b=neZlrg7NNAXOT7M9z7vcP6uK0+d675I+gZ9tYB2+SxbjjXLPjAdUlPR2
   II1vZ4dyXFu4T7RvgE9+iitSJJciPKklUbYMeHeY0W6RRSzA+vs9vQqN6
   PMepvch+6yMXI3/aojA9R0nE2qlq6+Uv+WTJHTxufFGKpltxPTzulb2VR
   wuEyP5JQ5HubptzBJVZb94VSA60b+fD5Zu4C7OV4WDg6o21HBGj0fQZ9W
   I4pfTqrGs0KzcI7b1SuT7q8Uaso3PQqNtNFjO5WA8US2E4Rx/siK5lui1
   Z91W+j8dlHNFZY616LgbUnVeEfqE+dkPajehW0sg9re9onaur8timwntR
   g==;
X-CSE-ConnectionGUID: dQKCB4oXTjiG8Jvw88yucA==
X-CSE-MsgGUID: VR3/K0mZTI+uLkNIHQjmxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73909398"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="73909398"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 10:15:25 -0800
X-CSE-ConnectionGUID: QOqgkkB0QIqoSq/qQOtWlQ==
X-CSE-MsgGUID: TfQNgZRaRgydxgPG46P9AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="214542857"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 10:15:24 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 12/13] target/i386: Clean up Intel Debug Store feature dependencies
Date: Wed,  4 Mar 2026 10:07:11 -0800
Message-ID: <20260304180713.360471-13-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304180713.360471-1-zide.chen@intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- 64-bit DS Area (CPUID.01H:ECX[2]) depends on DS (CPUID.01H:EDX[21]).
- When PMU is disabled, Debug Store must not be exposed to the guest,
  which implicitly disables legacy DS-based PEBS.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V3:
- Update title to be more accurate.
- Make DTES64 depend on DS.
- Mark MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL in previous patch.
- Clean up the commit message.

V2: New patch.
---
 target/i386/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2e1dea65d708..3ff9f76cf7da 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1899,6 +1899,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_1_ECX,             CPUID_EXT_PDCM },
         .to = { FEAT_PERF_CAPABILITIES,       ~0ull },
     },
+    {
+        .from = { FEAT_1_EDX,               CPUID_DTS},
+        .to = { FEAT_1_ECX,                 CPUID_EXT_DTES64},
+    },
     {
         .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
         .to = { FEAT_VMX_PROCBASED_CTLS,    ~0ull },
@@ -9471,6 +9475,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
             env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
         }
 
+        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
         env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
     }
 
-- 
2.53.0

