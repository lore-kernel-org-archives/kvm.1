Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6C522EEA;
	Fri, 18 Sep 2026 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761018; cv=none; b=aV6+N1LefIuS15s8P8V+e0JfWjr5vLySzOpuNk34LfWYvWTX5VyWGKwKl38VC9intzqDe3vhClBnX3fGtNAJuKPOXl7aktaexjBPQnRxcLmHnTwSE9zVJmyT2O3n6qrS4Q5a/Y2mYkwOPPLddZQjHExSUmwmKfN6/U4QPK43jMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761018; c=relaxed/simple;
	bh=KVR1n09iRYaUfFMh4hk3y0kGMGBo2NN+ks7hEJxO8gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfWR/fCQeF4k73P1VKWytvV9puWi4o3V2I9ggxekO7V7UAi5S3vnGye2TpPH7OXwj3TdzeYn1eWbG8tp9ZarIWLEuYqjZ1K4v8HnDB1uXEc0PsfmZbt3bk/oizOSgbhu/QAyVO3i5+v7LUHkXs4yVh3+oEsb/wwzOxWRUdhvMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loHBzg0u; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loHBzg0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789761017; x=1821297017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KVR1n09iRYaUfFMh4hk3y0kGMGBo2NN+ks7hEJxO8gQ=;
  b=loHBzg0uUTx4tcdTm66xASx+IOKr5pVISr5iwYDcPz9leCS2M0FnaAKb
   4Efyq0KGQlP3hZXYgaH+f6NeuEdtjG8MHjO0oMPOX6/yzqW5cOIc1fu3X
   k2MnxPyFGxQ5v2aPTiPXYGAUr5wic0j42Td/Jd21HlXJVJd6Kky1jcBdn
   lDwFkjg8muSesMOA7jKhlgjH5NRX5TeXs9qxXYZrPSo2wDh1mBE3wmgWK
   30IsSxGratjnwXRWfyTH9j593XfHF/sTwW1pNizsqPsyKbBqFU0MLWsQd
   b73+TZs62IgVtjUARyJBSet4VONtmlIq6qR9FWriTiZT5ad7so92quaF4
   Q==;
X-CSE-ConnectionGUID: z+El9bR1QB66hzJ+G/mIQQ==
X-CSE-MsgGUID: qQedsNXQReyNiAE6NJPUVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="790330"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="790330"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:50:01 -0700
X-CSE-ConnectionGUID: i9h21FlWQ0CzKb85vVMmLQ==
X-CSE-MsgGUID: y1zCjMv8QnOiwnBRUNZjIw==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:50:01 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v9 10/12] perf/x86: Expose number of Topdown metric events to KVM
Date: Fri, 18 Sep 2026 12:39:35 -0700
Message-ID: <20260918193937.569414-11-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918193937.569414-1-zide.chen@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number of Topdown metric events varies by CPU: ICL/TGL/RKL
support 4, while SPR/GNR/DMR and some hybrid CPUs support 8.

Add num_topdown_events to struct x86_pmu_capability and populate it
in perf_get_x86_pmu_capability() so that KVM can determine how many
PERF_METRICS fields are valid on the host CPU and correctly identify
the reserved bits in IA32_PERF_METRICS.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
v9: new patch
---
 arch/x86/events/core.c            | 1 +
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8b3ea0adb965..01c1c9447f30 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3164,6 +3164,7 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
 	cap->mediated		= !!(pmu.capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
+	cap->num_topdown_events	= x86_pmu.num_topdown_events;
 }
 EXPORT_SYMBOL_FOR_KVM(perf_get_x86_pmu_capability);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index ceb6188e5217..3c02389b2ea6 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -306,6 +306,7 @@ struct x86_pmu_capability {
 	int		bit_width_fixed;
 	unsigned int	events_mask;
 	int		events_mask_len;
+	int		num_topdown_events;
 	unsigned int	pebs_ept	:1;
 	unsigned int	mediated	:1;
 };
-- 
2.55.0

