Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516229;
	b=jNm/vo0egDa+ptl4kVTNlAgYK0DlCirh5QndpZlLKHTqGlzUJ56WCqKio+gXvwMCcfYi
	 z4o2Tme5AJJcYVsqxAGYNW8Am1MoIG2bu1aGJKhuVTb/FRAUOSZ4cFnACkcOQCKKmRFyK
	 JZmXG3SjRLrgAfY6muApJG3MiVp0Udt0F6xP2FbddCRKNBwVk2PTRBi7aSWbbQ0QuUrQW
	 MzZy4v2C8xn3xCDAx1RwPebooJ6xbu/7YOyWb+VlAWLjXOwljt+DoHX4kPSERQJ2XGasd
	 4KIJimoTimiFL/20Nyk434j3k2AcRzfj/Nhs7Hn0awGbGIFS0g0cWG+Rn1A7P/VY5uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516229;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I3y68qJSl+P6xP/WySEdfzygrb9CjfS4jxxPfaaMe3M=;
	b=S/PdRe20OtLgdntbJHMjW85uLh7UPM5S3c1e+pTpO/XdgQzx7+1rhruLcaMUEOS1mt15
	 yab3ldmJaK4AotlAI0c3+j6zJ6NOQH8CmXI37lFXY3dMvT3vcrIT3K45yspcvaSYhY9K3
	 vpwyS9VXMQqymu5v5Xo9ZFXHzmGYSdkNUbGpH/lO4WGyTm8cl7Dr5CeJE7McS54VcibzF
	 tPxgnVNTZl6y+lWmVjszK4I5xMjJq9gstrji1wjHI/3MGYpCBPTGwCBacPu9BgWcDO174
	 JX5bbFDbO3+kfJ8HodO+1uIkCnoxI/mXm0lqXt6ZbhvRSGwDvDYh0++KhiE5Ev06rJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ihnXa3Ud;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D47606A89B;
	Thu, 12 Nov 2026 20:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D47606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ihnXa3Ud
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516229; x=1826052229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JfJvfpLwpM3XTNdq0mrf6exMBASCLRDcjxitWKRd24g=;
  b=ihnXa3UdXvgp2PVios9BYmzO8/FQKbY0pT1zafCaHFWhbTLCxIjR/7Vf
   hqCls9CLC3PF4ttv2pkzuOZkRJVlYGqpIMeLdrziGf5/f10gxArx1W7Ht
   I5BVp41IuLTpJtBUWyTXnqqIe/j1EnOq3XjlJmMjAMwm9zMIlaO+p3PgC
   p6ivhNgNxAF8YJaigta454kbqqT9rVOc3CLhFxszq78XxSki5N1iHknHh
   +JaS0sKkP4myoEhBldkXGiAiND1Tun/vy8YGg3nNATJO24xQ65QlqX152
   cXjntaz/3I5IWPMemm94whX5RGkOeK7mg1JVbNjqCcVDNlOqNbl0b/dPy
   w==;
X-CSE-ConnectionGUID: z6mMqFBSTTSNxkSI+qJZTA==
X-CSE-MsgGUID: CLDrCI7WR7i59LWULDcZcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192250"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192250"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:48 -0800
X-CSE-ConnectionGUID: CRW9F1tISruc8RZJ7Kfe5g==
X-CSE-MsgGUID: SO37GhklR5qtthBwLXx1Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087886"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:48 -0800
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v4 07/21] KVM: x86/pmu: Expose kvm_host_pmu to vendor modules
Date: Thu, 12 Nov 2026 13:32:13 -0700
Message-ID: <20261112203227.289379-8-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112203227.289379-1-zide.chen@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_host_pmu holds the unadulterated host PMU capabilities, which
can be used to compare against guest capabilities to determine whether
certain MSRs should be intercepted by KVM.

Exposing it directly avoids the need to introduce per-field accessors,
which would add boilerplate without hiding any implementation detail
worth encapsulating.

Opportunistically, fix typo "Unadultered" in the comment.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c | 5 +++--
 arch/x86/kvm/pmu.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 484dfd2eba10..d203cbc7fd12 100644
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
index b312f80f5cda..02a19aa7e7de 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -252,6 +252,7 @@ static inline bool pmc_is_locally_enabled(struct kvm_pmc *pmc)
 	return !kvm_pmu_call(pmc_is_disabled_in_current_mode)(pmc);
 }
 
+extern struct x86_pmu_capability kvm_host_pmu;
 extern struct x86_pmu_capability kvm_pmu_cap;
 
 void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops);
-- 
2.56.1

