Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457881;
	b=vNxgi89cujKR+M39q8DDoJoMzaGDznA5kBTfLnT7/ASOqw8YPsQXkIZt09rJQQixzeQl
	 60pBAGhnuCRAZClkN2Adl2G9YFR/eA1u/mQ/H16xpdQUARxLma6DYKKOk2mvUG9AsKupM
	 tSQvyzlIzOQLwbabRm16jFDNL+zve4cdq/NTv9BJdWUReuhW2d78kCRbMAVrmtZywvx9C
	 vHB4/jYzImcl/bUWlXZASh8vGFBLDrt+Hr/D0GPD28TTaYNbDYc8mKavPnLqqAITyfV8Z
	 6Fac1qGekgi/y4zsIOIVuGmW+oySv1nPMPhbPwCuOAQGQc/NvxhqsIJ1JgfuKN3PexQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457881;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s7JLDvrN76bnWv00z37G6CICc+lWUkZr/55uVvLmt0o=;
	b=Ixx4csWrmoaJYqUipY6thXIND3xlvAHRJ/4t0EeJkGnlz7Osqo0Jrzkkjv3h7afHtrJG
	 Wp6UoweyD8C16BvJCbi9MCD5yPtuUmFO4bIA/x/X9ZPLKpcahv9D5rfLZa3P26lYnKSbm
	 pb8NvQRaVOuDJLY1celYU6F+Be0nBCdmBZChxhxds5mVVwf2oBciSiSQQwxUII2yVcdHg
	 lP8W3CBmYxodAD8+hT6Ta8cjymLXhe50aHdWa+qo3WEsOMz4aLl4JQfLMf8ghVgIGGY5S
	 NIygEQBgz6FkzDtqz/5pYH/lpZn79W47qYZZTTB/WUKxcDT5hwM47BVK8cn+Kkc5xSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="BS0/mdhY";
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40140606A68B;
	Mon, 23 Nov 2026 18:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40140606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BS0/mdhY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457881; x=1826993881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O6SEP3RzCSZL2t7dMmmk9Jxcg9QhN0M4WuooDvfagVg=;
  b=BS0/mdhYSREW6+Qg776pJJZI1kqMSSftsZKePo2nsOXp1Cd3eQyOcCSq
   vqLoCoYGSRXGlgPv0mtKh62faQ/x8KUmhtpHtUewR0xQVlvml4Kh7uew4
   6zBmUbGRJQWmQUHCN0QxLURXxjBhx+tqqUHt8qxzKV3ybPYRXzMtHnnNF
   Sk8Mnh/PspHrKSFldY4sVjm4pGPvSc6ocs/sebqxMzz/crWbhGpiqmnH3
   g+YH6pQJhYPeH7T7orGzOGX1p4l077yQxD6xq/EnpwJeJ535CHnKUXrql
   pewkMkiyl6czHOhyPbbpT/FK+BYHGGO7vi2+cyOonof8oxioxtXQiTOfB
   Q==;
X-CSE-ConnectionGUID: WJL99zOCQV+AbtEEDNJm0w==
X-CSE-MsgGUID: QaA+dqiXRSqS98q8psGfUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288780"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288780"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:07 -0800
X-CSE-ConnectionGUID: wQhIF3ynRwuDPCio5D7QMQ==
X-CSE-MsgGUID: +8dT6kDQT56NqbRTtJq1Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241067"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:07 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 03/20] KVM: x86: Support EGPRs on vCPU RESET/INIT events
Date: Mon, 23 Nov 2026 17:37:15 +0000
Message-ID: <20261123173732.1072124-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123173732.1072124-1-chang.seok.bae@intel.com>
References: <20261123173732.1072124-1-chang.seok.bae@intel.com>
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

Zero EGPRs on vCPU RESET and preserve them on INIT, matching the
hardware specification.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
V9 -> V10:
* Use NR_VCPU_LEGACY_GPRS instead of a hard-coded number, then the
  change looks small, reverting the previous refactoring as well. (Jim)
* Add a review tag, thanks!
---
 arch/x86/include/asm/kvm_host.h | 6 ++++++
 arch/x86/kvm/x86.c              | 9 +++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7db87bc99f4a..327d26e38cbc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -211,6 +211,12 @@ enum kvm_reg {
 	NR_VCPU_TOTAL_REGS,
 };
 
+#ifdef CONFIG_X86_64
+#define NR_VCPU_LEGACY_GPRS	(VCPU_REGS_R15 + 1)
+#else
+#define NR_VCPU_LEGACY_GPRS	(VCPU_REGS_RDI + 1)
+#endif
+
 enum {
 	VCPU_SREG_ES,
 	VCPU_SREG_CS,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2cd9ee316aad..c2ce1bc8c77f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9673,8 +9673,13 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 		kvm_msr_write(vcpu, MSR_IA32_XSS, 0);
 	}
 
-	/* All GPRs except RDX (handled below) are zeroed on RESET/INIT. */
-	memset(vcpu->arch.regs, 0, sizeof(vcpu->arch.regs));
+	/*
+	 * All legacy GPRs except RDX (handled below) are zeroed on RESET/INIT.
+	 * EGPRs (R16-R31) are zeroed on RESET, but are unchanged on INIT.
+	 */
+	memset(vcpu->arch.regs, 0,
+	       init_event ? NR_VCPU_LEGACY_GPRS * sizeof(vcpu->arch.regs[0]) :
+			    sizeof(vcpu->arch.regs));
 	kvm_register_mark_dirty(vcpu, VCPU_REGS_RSP);
 
 	/*
-- 
2.53.0

