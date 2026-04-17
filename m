Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0D31ED68
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411163; cv=none; b=ibrH6mvw0ave2Y6DF2i4n6EaMOIQCrDxS1Obz+HZIPqaclpXBrqul3SRuJVvnrLa2fFNmPfB4qyebWR5S7RHqKjyRR2zNAhKuagcmCRH94E7nIZmaSmkZ6JLjaJKkjnUTiXT6JX3Hw0Y1mXzqPwA21jO1uuxssshJwC/vL/W5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411163; c=relaxed/simple;
	bh=JAPN9K8Ip0KYz377oNnFCdSNYZl5EQYnoAX3S/RzjYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJrf1NftyEarcEZxp5tR5HpzPAZ1YJxyHGxu3PRbkS6qBk3AJj35mpN0s6I8pxF5aZb/luTDMnnJ4RHqQOUn0MuMPD4h9heuuPE9JkwSCCqxLOfOMHK8EHj0miUc1Joia/Ab4WRp5XzAc8SP37Aqotvvjg4rpC0V7inkSX+42Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBvoqvIT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBvoqvIT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411163; x=1807947163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JAPN9K8Ip0KYz377oNnFCdSNYZl5EQYnoAX3S/RzjYo=;
  b=WBvoqvIT1YvdKW4Be0/e5KlMM2TBST1uNiCRtbCepJBjhDlo2Kn6f8KN
   TJ1UZkDZHrxhTYlKQPhD2PQ0KC4tnyf1bdM7E/mqDzuZYCOI69r62gFxX
   2vofGzm2JdXwKKKbeclwYi3I/6yu/tgl+B74RhgXA73DNzVH59OIVJlly
   hVDLASXqsta0e83rQTOhM5y4Rxj5ahXyQhqmFMZWGMJVt9d5r5AekUQ6Q
   YOjTmMDvW0W2r4JGAgNMY7ZedVtZbmdxK7DC+CbEMqFODPEq8h7cYMOP2
   803hrbPchER54VVKLfk47pGotZ1uoUmFA32RmZaMCP6fRrk7NQ0SrB+ql
   w==;
X-CSE-ConnectionGUID: Tkw9boWqTzuxDktC+cWTvA==
X-CSE-MsgGUID: HInONzXySaOEUkaGJj+RnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070263"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070263"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:42 -0700
X-CSE-ConnectionGUID: yHR+ILJETzK4FAAnvIL7Mg==
X-CSE-MsgGUID: rlGI84iISqiZTYHVI7wxdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226285019"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:40 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 18/27] KVM: x86: Handle Centaur CPUID leafs in paranoid mode
Date: Fri, 17 Apr 2026 15:36:01 +0800
Message-ID: <20260417073610.3246316-19-binbin.wu@linux.intel.com>
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

Register Centaur CPUID leaves 0xC0000000 and 0xC0000001.EAX to be
skipped during paranoid CPUID verification for the VMX overlay.

Ignore all registers of leaf 0xC0000000, which reports the max supported
CPUID leaf in EAX and vendor-string-like data in EBX/ECX/EDX.

For 0xC0000001, ignore EAX that holding the CPUID version. EDX is already
tracked CPUID_C000_0001_EDX. EBX and ECX are reserved.

0xC0000002 ~ 0xC0000004 are reserved for future use.

Use F_CPUID_VMX for the overlay mask when adding to ignored set since
Centaur/VIA processors are VMX-based, and these leaves are not applicable
to SVM or TDX guests.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 471733eb68d8..c75e7859cc2c 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1552,6 +1552,11 @@ void kvm_initialize_cpu_caps(void)
 	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
 		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE, F_CPUID_SVM);
 
+	kvm_cpu_cap_ignore(0xC0000000, 0, 0,
+			   BIT(CPUID_EAX) | BIT(CPUID_EBX) | BIT(CPUID_ECX) | BIT(CPUID_EDX),
+			   F_CPUID_VMX);
+
+	kvm_cpu_cap_ignore(0xC0000001, 0, 0, BIT(CPUID_EAX), F_CPUID_VMX);
 	kvm_cpu_cap_init(CPUID_C000_0001_EDX,
 		F(XSTORE, F_CPUID_DEFAULT),
 		F(XSTORE_EN, F_CPUID_DEFAULT),
-- 
2.46.0

