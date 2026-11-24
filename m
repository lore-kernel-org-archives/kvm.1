Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557207;
	b=RVeVNrpjhZNib3HmUSFGTvFqe992T/6AItzitcD1mRDOGV0hLGDeDNJPEMID1d722vaE
	 0W41X1oFQnwLUC+nixlNqxBgEpN40G5YDbyb2gkWZoTvouOuyszpSIu+zpQI/8oz6gjWr
	 6KJsfJ+utfi0pYNquTQNP6HZIdegAJj+9FiC3/vzGyzEsGuyx8/tUcYix9NLhKbsxPQCZ
	 QrwbSdiwHm1ZdUUhkBfz+1eRfanPOhDZFeADTb1HQQxq1ONm17Qvi8UZAX+STW2TVq70p
	 mvux5Q5GChFNdxzuJQh8gg3kjZwgNjEi6mswI8rKOchAG7cefZlpFEP7cEDDtAotQ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557207;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1V6Q60V/+g+XszFCh2B5eJs0FRIAZwVbbS5FeWvYHTA=;
	b=MAk5V3+quB0A2EAyr6b9ncGGOePZWPAGfJTKbg9+7dXAhuweJOgtV9+wdjGgfm96sWDT
	 A+iwL5ctDfxDU7+Xdv1O4KcrNblpxSSwlsIPd4MSbjm4aUMVNHL7HDnhi5GE9VVqIV/3L
	 wgmm6O2xm/SMB7nQiUIM0Pdpvmdv+tw9nGFbRw4hahjlmrXgnC94oYHv8ocx7MyZIcPWy
	 lS+Z6WvpmGj0hgYE2cUt9VqscnEcMsrt4009AQh5Rikiob14KXNlQv89WecvCuYG8HuZS
	 i9HHJCDQGsnZihKrpsCs18VZ2HG2nEsT2DkSXAR0IQ+qPA0pxqrvh1zHJ7+m4l6uaGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Da0JlFe6;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D44606A69D;
	Tue, 24 Nov 2026 21:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9D44606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Da0JlFe6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557206; x=1827093206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yYHcjf31YLwEgxKVAmaXq83+Ihu64ca+bG0TPaUBomA=;
  b=Da0JlFe6OlTQ0Pq6io+noWrPTusUWPG0z4ZqReaDun2/grRO0hO2cDgx
   wBsX4skjRbZlYFzlLacGa1ur1lk+xfrV54IzIak3lqulkmAPlZ7AgF3J8
   aMOwWCYgJjTVdZjOhg7cxpzK96uw7OPyFnLAmjazIIlVCPwvxoTKtBoTH
   KNItTxAyt/QeOG5BboJMfC/MBX7BZTk67mQMOAA8qsZEp2GB09N0BrfSP
   NNZjgo4bg3YJXKuh7hrN5A9c9CO5fer2D9zlvNcAF/yE6CRFACzEKe8DY
   mn8RVxE+gdqblk2ONJO6bOo5l/T/dX854XysIVcjIclwu/9H5maygTSZg
   w==;
X-CSE-ConnectionGUID: cFOq7C6aQbO3H/wvD2gBHw==
X-CSE-MsgGUID: 2NK2apo4TdG1FEGVafjoiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306002"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306002"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:25 -0800
X-CSE-ConnectionGUID: rNOTqnRjRlie6M/5110R0A==
X-CSE-MsgGUID: 9C9nd6/RTnO/pbEhChoZ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271906"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:24 -0800
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
Subject: [PATCH v10 05/18] perf/x86: Expose number of Topdown metric events to KVM
Date: Tue, 24 Nov 2026 14:38:48 -0700
Message-ID: <20261124213901.120572-6-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124213901.120572-1-zide.chen@intel.com>
References: <20261124213901.120572-1-zide.chen@intel.com>
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

The number of Topdown metric events varies by CPU: ICL/TGL/RKL
support 4, while SPR/GNR/DMR and some hybrid CPUs support 8.

Add num_topdown_events to struct x86_pmu_capability and populate it
in perf_get_x86_pmu_capability() so that KVM can determine how many
PERF_METRICS fields are valid on the host CPU and correctly identify
the reserved bits in IA32_PERF_METRICS.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
v10:
- Add Reviewed-by tag from Dapeng Mi.
- Export num_topdown_events as 0 if PERF_METRICS is disabled or absent.
---
 arch/x86/events/core.c            | 2 ++
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 770ca960fa6e..ea3d7e437aa9 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3165,6 +3165,8 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->pebs_ept		= x86_pmu.pebs_ept;
 	cap->mediated		= !!(pmu.capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
 	cap->perf_capabilities	= x86_pmu.intel_cap.capabilities;
+	cap->num_topdown_events	= x86_pmu.intel_cap.perf_metrics ?
+				  x86_pmu.num_topdown_events : 0;
 }
 EXPORT_SYMBOL_FOR_KVM(perf_get_x86_pmu_capability);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index a68cb7c79d8b..19e35a68f32b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -306,6 +306,7 @@ struct x86_pmu_capability {
 	int		bit_width_fixed;
 	unsigned int	events_mask;
 	int		events_mask_len;
+	int		num_topdown_events;
 	unsigned int	pebs_ept	:1;
 	unsigned int	mediated	:1;
 	u64		perf_capabilities;
-- 
2.56.1

