Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF8D442104;
	Tue,  7 Jul 2026 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449842; cv=none; b=KfVyiS5XQUJBChMmsVUAvuVF/NZdABYbUo5IAxWxr3xEB0cRIPubgG4Y1ngG54WBoUEqhwoAt6lIXxtPxvywXQof9inEHgPzGO69eOSNdTTkgCUSwX+cwNqM1pcd/jOaadfQ985RzNAS+hM+h0yhH2lzxB0hVerLEVy8WI0fZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449842; c=relaxed/simple;
	bh=EqTn0L8ckMgLbNpxyk9lYBcVDhF/H3gp+97WdKJ1F5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phgEtoeM2HCRmh02uZxIYvgD4BleOwftpnDzaBkGTyYNXeUMi2nJb2nr5GPxaLNOiuIuiziEP8kSnrEMm0dfnfTmPrjTByRlzsxBuLNYIBcEoeTdMkjC4SLWydHpu2ZA83uBRK8vxi5Rjttptwd52gsJ69iHCKPkZL7ZrR2EQB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcIxQZVo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcIxQZVo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449841; x=1814985841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EqTn0L8ckMgLbNpxyk9lYBcVDhF/H3gp+97WdKJ1F5Y=;
  b=gcIxQZVo7KHGCSp59zKY+aX0vAIu8hCrnMoeofikiaPvvAKjVeqZ8xRE
   STxj83w1BZJqpzXdfsBBKp5CUNkxud7gse/q0FKYgNIcjHJGImiJwmWSS
   Wburj48qZFcbpbv3x+gFSczWbl6Me9mpOaD8bmLBy7cpJlEMAS2XMoufg
   JikYtxHcJqEHzUSLvtDw673811Q6r7QPbnFe8Ch0upvEvZlEHoWf3nRrE
   sTJf5AKr/SyJ67/2yiP6uhYkBfqZ3ALg5TF9lvaQqI8wxzn+loxZO5oTv
   BPpwNdge38SX8z2HHUOQljQGnIqeB26Ztkm7NyzDBrB1eqRtYtEuz91pu
   g==;
X-CSE-ConnectionGUID: Rm640TYaTV+UorwQmnxvAg==
X-CSE-MsgGUID: 14H/FbA5R1echlQ0EH/q3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94713871"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94713871"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:58 -0700
X-CSE-ConnectionGUID: b3wbJ2NWRvC4Zjrw1ykZNQ==
X-CSE-MsgGUID: jKk01YUQQMupLPxSZUwKCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277279295"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:43:57 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH 06/15] KVM: x86/pmu: Expose kvm_host_pmu to vendor modules
Date: Tue,  7 Jul 2026 11:33:56 -0700
Message-ID: <20260707183405.15571-7-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707183405.15571-1-zide.chen@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_host_pmu holds the unadulterated host PMU capabilities, which
can be used to compare against guest capabilities to determine whether
certain MSRs should be intercepted by KVM.

Exposing it directly avoids the need for multiple per-field accessors,
which adds boilerplate without hiding any implementation detail worth
encapsulating.

Opportunistically, fix typo "Unadultered" in the comment.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/kvm/pmu.c | 5 +++--
 arch/x86/kvm/pmu.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 0b66e7756ecc..3647ce3f0e3f 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -27,8 +27,9 @@
 /* This is enough to filter the vast majority of currently defined events. */
 #define KVM_PMU_EVENT_FILTER_MAX_EVENTS 300
 
-/* Unadultered PMU capabilities of the host, i.e. of hardware. */
-static struct x86_pmu_capability __read_mostly kvm_host_pmu;
+/* Unadulterated PMU capabilities of the host, i.e. of hardware. */
+struct x86_pmu_capability __read_mostly kvm_host_pmu;
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_host_pmu);
 
 /* KVM's PMU capabilities, i.e. the intersection of KVM and hardware support. */
 struct x86_pmu_capability __read_mostly kvm_pmu_cap;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 95dc95a9ae37..95b73aac72db 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -254,6 +254,7 @@ static inline bool pmc_is_locally_enabled(struct kvm_pmc *pmc)
 	return !kvm_pmu_call(pmc_is_disabled_in_current_mode)(pmc);
 }
 
+extern struct x86_pmu_capability kvm_host_pmu;
 extern struct x86_pmu_capability kvm_pmu_cap;
 
 void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops);
-- 
2.54.0

