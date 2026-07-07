Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D22F7F11
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407768; cv=none; b=Zi4HVPrRy6ilEeLwYJ7oKUuJNxsqvMc4easL9+xAFxqOcmXaExpDGLuh2NHdQrQfPukzPDSSfU3W6cYGwYhUdLImEuak28hTl5JAc/8JoMueLzOKj8knwNLEY97VxJiGCjK4pesYBNu6Xh/6eGDdC5zn8zDR6kMj2m2Q01IQ/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407768; c=relaxed/simple;
	bh=fhcmg/dXs8ZFlgkNPKXghaez0XWUiOupnKjaYQZ332I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVgRvdla5JEZcM+L5UY+I4rRSVOQ8qf+s4xMAxjD7AoHZQqnZ3tl55fMRGPZKaRsSqBoLe9ITQixn2L7MTNKbsbgMCgCv4wHA5URiaxM+COvVoIT65dNLZHpnV2y8s7yBGjLk1Nb9xnSXLFdVsUAtl6qpnHbSB0lO0PIBDGpW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIbCdup/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIbCdup/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783407767; x=1814943767;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fhcmg/dXs8ZFlgkNPKXghaez0XWUiOupnKjaYQZ332I=;
  b=KIbCdup/X+dDFbTMwwmkoay/e23I6iyI/7VZGzLDiGjT/E5Upm2c+USs
   Ql3kYfEfpmzonFHcPuwyFQMgXOwDkPoBOD88Ht5/kvNd0ZOjctl4JoicC
   nz3Z8Aug+K6W3v8Yh7mE/PSHVbJ2UfT2u/N6ircP7Jz/w/hb0KKnRNDWD
   Hkql8zzpykwUarrB0vX1sCrYkgQoDkC9xt+R+IowPAmE+AQSycHmdprnx
   9MDidy8cw9KIeod1mjvWgBDszVygK7Wq/8RbeWpfjrxVoWfg2ueaGxvpZ
   oL7a5/2Ro7A5DnY8jEZbi0xNBUy/VLg+1TGmn2Jbvi0a/KL/yoRcjRMep
   g==;
X-CSE-ConnectionGUID: g1mQQTWyTXSkRgt/tULtew==
X-CSE-MsgGUID: PlI9aLkRR/igoIdYx/fuSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84071774"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84071774"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 00:02:46 -0700
X-CSE-ConnectionGUID: 4EImg5C+RMCEObk0eeyHYQ==
X-CSE-MsgGUID: t594DLesR9eTYoU8+0x8cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="252847027"
Received: from dmrtest001.sh.intel.com ([10.239.48.48])
  by orviesa010.jf.intel.com with ESMTP; 07 Jul 2026 00:02:44 -0700
From: Xudong Hao <xudong.hao@intel.com>
To: pbonzini@redhat.com,
	kvm@vger.kernel.org
Cc: Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH kvm-unit-tests] x86/vmx: Skip LAM CR3 bits in 32-bit guest reserved bit tests
Date: Tue,  7 Jul 2026 07:02:40 +0000
Message-ID: <20260707070240.78295-1-xudong.hao@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Intel SDM 4.4.1 "Linear-Address Masking" (LAM), CR3 bits
61 (LAM_U57) and 62 (LAM_U48) are LAM control bits, not reserved. Skip
the LAM control bits in the CR3 reserved-bit loops when LAM is
supported for vmx_pae_test and vmx_pse_test.

Fixes: 55b77db1 ("vmx: add a test for 32-bit guest PAE paging PDPTEs")
Fixes: feef9d92 ("vmx: add test for 32-bit non-PAE guest")

Signed-off-by: Xudong Hao <xudong.hao@intel.com>
---
 x86/vmx_tests.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 16f8a648..2c0feca0 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -5896,6 +5896,11 @@ static void test_vmx_guest_pdptes(u64 cr3, u64 *pdpt)
 	}
 
 	for (b = cpuid_maxphyaddr(); b < 64; b++) {
+		/* CR3 bits 61 and 62 are LAM control bits, not reserved. */
+		if (this_cpu_has(X86_FEATURE_LAM) &&
+		    (b == X86_CR3_LAM_U57_BIT || b == X86_CR3_LAM_U48_BIT))
+			continue;
+
 		vmx_32bit_guest_init_common(cr3 | (1ull << b), pdpt);
 		test_guest_state("CR3 reserved bit", true, (1ull << b), "bit");
 	}
@@ -5979,6 +5984,11 @@ static void vmx_pse_test(void)
 	}
 
 	for (b = cpuid_maxphyaddr(); b < 64; b++) {
+		/* CR3 bits 61 and 62 are LAM control bits, not reserved. */
+		if (this_cpu_has(X86_FEATURE_LAM) &&
+		    (b == X86_CR3_LAM_U57_BIT || b == X86_CR3_LAM_U48_BIT))
+			continue;
+
 		vmx_32bit_guest_init_common(cr3 | (1ull << b), NULL);
 		test_guest_state("CR3 reserved bit", true, (1ull << b), "bit");
 	}
-- 
2.52.0

