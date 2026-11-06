Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929837;
	b=Lov3JK615JA47MVbVXwGH542KcjBdRX/BIuq/QboCTPXg/Daie5/Ba10q07Wid5/iXQv
	 fhifmoh71XkB8plYlJGb3s7IlC83nNWYjacoFrHgRlQDStAZL0sA3gutQx5iNYGvmC3QA
	 wf0PTZ5tJ9vTbpvLjwJSdEiWKXVAaYUbnaG8DWf20Tp3GMNNOiDFXSb43H5SCy7IPfIIJ
	 Wk2SUJlFbs2Qw4kayyd4qh8z38s2nsFj7gGFbvagbBN12Kgm9KaPYIC7G3mrgKcuZmnt+
	 ElUE4zpITHItU/Lc9MmNyWMPwIhCqom+4ptKPSW5sMAHpzD/Mg0jncnyih69TM7D2cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929837;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0/RWgiQ3XQTb5GJnhUqz4E6kcmy2ka2CbvDhjBbA4hs=;
	b=KjMc0nUNJr+0BttprW91IVtmReHxSp52oe0Zbe2ZmNBf20rKxv/oSjfcf3g4YzAka2Aq
	 nic6GE2w3TIVT5ufvc+FSfHzhW3xzbT7pi7r5eA9xu1B7mJEdwl0psDo488UzA7fvsRJV
	 ZIioMWgQiJp89BJwBh5zqsG1J2F1XsbBNLLAC2usESS6kGMWJIjCwY3hpN+8edHyx+T+S
	 ClyVIHOe/4SjJeVo9ZqH5PG3P5i+F8zXnC9dg2xe+2uppd6poZVVXouLlDupwrlrujzvX
	 zmewkq7kG/Iv8UdtRRcTRxa/UsNO7g9URSL3CBAljiJEJRd3Te0knK/AmwqRpyZZhCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KsIA9w7e;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FF606D81E;
	Fri,  6 Nov 2026 01:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 429FF606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KsIA9w7e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929836; x=1825465836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u3Go4M+v2dqbCzqe7zRCRS7sqaB/eyOouSmra48BVLc=;
  b=KsIA9w7eR9LNeeUCu09op7qWR+n4B8FbztZPUcCQAyX1tkC7JVyg8Ev5
   IClzrqMK2KO/0y3dIUp4ZVHRWbLd2EbcW4+SEoGtns349VX803+MMU7+C
   NGRKt3WJ3i7YINfZA8z1OlsnRyqTVfEWISCd8e53JevAllj7FRjuBT14B
   ogcIDcvMl1MRxbLFmK2TgRibtzETfeuC+81aGTn+ogScMbK+3vHeKcIIO
   wZaEvFscwyki8HGbATpyvJJwiay65DerLei1G5vNquoViHXQkLBdCKRww
   KUC5ojsMcvjfINZLd+i9Q+LP3LVEc2SB7Guwrff79MZN3cPEcgS6NysIU
   w==;
X-CSE-ConnectionGUID: nxdsd+coTN22hNe1NBlmJQ==
X-CSE-MsgGUID: Inu2QEQCSE2GPQsaAtLSSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740163"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740163"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
X-CSE-ConnectionGUID: e4cTVBV2RUmwIhixwhsHQg==
X-CSE-MsgGUID: QaY1qjEcQYOsB3NyB9gAOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067193"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
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
Subject: [PATCH v3 10/18] KVM: x86/pmu: Document GLOBAL_STATUS_RESET passthrough erratum
Date: Thu,  5 Nov 2026 18:39:19 -0700
Message-ID: <20261106013927.166209-11-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106013927.166209-1-zide.chen@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
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

IA32_PERF_GLOBAL_STATUS_RESET, introduced in PerfMon version 4,
inherits the MSR address and architecturally defined bits from
IA32_PERF_GLOBAL_OVF_CTRL, while providing additional bits to clear
new indicators in IA32_PERF_GLOBAL_STATUS.

From an emulation perspective, KVM handles it identically to the
OVF_CTRL MSR: reads return zero, and intercepted writes are guarded
against pmu->global_status_rsvd. No code changes are needed in KVM
to emulate this MSR.

However, to reduce VM exits, KVM passes through this MSR in mediated
PMU mode when GLOBAL_STATUS is also passed through. Consequently,
writes to bits that are valid on the host but unvirtualized by KVM
will not trigger a #GP (unlike when the MSR is intercepted). Except
for the known limitation where host Intel PT in system mode can
assert Trace_ToPA_PMI (bit 55), unvirtualized status bits are not set
while the guest is running, so clearing them has no negative effects.

Document this divergence in errata.rst.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- New patch prompted by Jim and Yosry's review on unvirtualized
  status bits.
---
 Documentation/virt/kvm/x86/errata.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/x86/errata.rst b/Documentation/virt/kvm/x86/errata.rst
index a9cf0e004651..161ba6d1beb4 100644
--- a/Documentation/virt/kvm/x86/errata.rst
+++ b/Documentation/virt/kvm/x86/errata.rst
@@ -84,4 +84,12 @@ memory.
 
 Note, this erratum does not affect AMD CPUs, which fully virtualize CR0.CD in
 hardware, i.e. put the CPU caches into "no fill" mode when CR0.CD=1, even when
-running in the guest.
\ No newline at end of file
+running in the guest.
+
+IA32_PERF_GLOBAL_STATUS_RESET
+-----------------------------
+To reduce VM-exits on performance-critical paths, KVM passes through writes
+to IA32_PERF_GLOBAL_STATUS_RESET (0x390) in mediated PMU mode when the guest's
+counters match hardware, without injecting #GP on unvirtualized bits.  Because
+the MSR is read-as-zero and write-to-clear, this cannot leak host information
+to the guest.
-- 
2.56.0

