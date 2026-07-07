Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B09844BCB1;
	Tue,  7 Jul 2026 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449859; cv=none; b=rJUa/6eFUx0Ct2C4+uBUPKl5MxqUPEQRokYr4mFApi5axlhhouvqcfjW9o1NUzg178WvqJZs/OMfCQhe4qrkx54+I5tpS6lnNxmnUYHG/A9i+SBySBOASaN/xPLLvy4mgnVwuPvK4D3yKRw0cy2ULWor9vtixGLUL88pM7isaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449859; c=relaxed/simple;
	bh=zV2LAvnVwo9OKsTkQDTILQtvErGmlgwexacyl6kFvi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWq/xMoWL0v6T22NgQaokQY/x+Pn2Yg385Kt541UgVP4u/+Ws7q822EDIiunoVlGng/cBY/gvU1Urjuf6r9AfjqQTFMJWgBYcU0YbYgzx8xNk5eL9bZrY5XtC2RYbzfkwuCSKZP+DQq9yBrIwQvyTXrH4i6H5hukB+KbfK4adDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqBGXLye; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqBGXLye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783449858; x=1814985858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zV2LAvnVwo9OKsTkQDTILQtvErGmlgwexacyl6kFvi4=;
  b=gqBGXLyejJSR11k+Ev8TqPIp2NAIYCDIff8ycHF7bKT7E8a6bIVTWO0j
   kyEJSPifkUX9uiwF9EOAUt0YNp9SHPnknc8neAQJdY+0bEwOF3q2i7Q5H
   OpwEkQxvXkO5TGc6bouiqShfj4D4VMWuTrPnPJJ2pBotg8At+wRVFDqh9
   qGjdfDdYPoTEAYtDHvHki1knhjYm2c0K7IwV7bBJJAKI1xdkthukwhWh1
   OnfXkvQnXAHGtRnaZtAojapc9NvnCqR1yGZibpvV6NPlKjeRLd1dXhTH8
   fI5LbgP9vxt6hVTrIH3HqWikPxPOF+sDYIUKC6bl/UVEmX/UNVt3KjimJ
   Q==;
X-CSE-ConnectionGUID: d8tP0VLtTI6255wwSLcq7w==
X-CSE-MsgGUID: lAUK7eVHQUam16Jt4UxHdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94713912"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94713912"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:44:00 -0700
X-CSE-ConnectionGUID: KgyWhD3/SsiczJopeDB2mg==
X-CSE-MsgGUID: dJnVQxPgRPOPcet4SgckiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277279347"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:44:00 -0700
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
Subject: [PATCH 14/15] KVM: x86/pmu: Advertise PerfMon version 5 on Intel hosts
Date: Tue,  7 Jul 2026 11:34:04 -0700
Message-ID: <20260707183405.15571-15-zide.chen@intel.com>
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

KVM currently caps the guest PerfMon version at 2 for all Intel
platforms. Now that KVM emulates the basic architectural PMU features
introduced in PerfMon versions 3 through 5, raise the guest PerfMon
version to 5.  Features that require additional emulation support, e.g.
architectural LBR will be enabled separately.

When enable_mediated_pmu is disabled or in the non-Intel paths, KVM
retains the existing cap of version 2.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/kvm/pmu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 7d58f7a2a2db..83332e8ed1e0 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -176,7 +176,18 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 	}
 
 	memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
-	kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
+
+	/*
+	 * AnyThread counting is not supported by KVM due to cross-VM
+	 * information leakage concerns on SMT cores. Therefore, AnyThread
+	 * remains unavailable for PerfMon v3/v4 guests, where AnyThread
+	 * deprecation is not enumerated.
+	 */
+	if (is_intel && enable_mediated_pmu)
+		kvm_pmu_cap.version = min(kvm_pmu_cap.version, 5);
+	else
+		kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
+
 	kvm_pmu_cap.cntr_mask64 &=
 		GENMASK_ULL(pmu_ops->MAX_NR_GP_COUNTERS - 1, 0);
 	kvm_pmu_cap.fixed_cntr_mask64 &=
-- 
2.54.0

