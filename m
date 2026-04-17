Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890862FE056
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411167; cv=none; b=VKWaxjhNJq0isonHGEIpxCy+1MyQdM2/RSGmlt7W13SFNv/9m8v9m/ptcuD3NO4hEQZBRNqS/TdfTmttfydwXThnl8VvxjhejJ5y/8uM4Escwn4xwc4PzYy//6oM9NK64n37n+gAHAnO4pP3wog/yuZaaLML0zCxvuaBojINOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411167; c=relaxed/simple;
	bh=G3Oftg/5J80QifcQYnrnXNxuLe3Rs3QaFMK9yKHGiy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLAftoZU9O4GjhtOLMXci1P7WTLLuCZwSeqhAs7Wq8jTI1CzRi0T90oor0ffF6NuJxgGSYbMp3hnD42hOmTcnqX3X0Uap0YX4wq8uLfuqgOnF+Hx/8p/7F+q21UlctVGKlIhLl9MEerC8ZAsYZuewX36y9BpxZNVpnl+jxibJbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZWu8izL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZWu8izL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411167; x=1807947167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G3Oftg/5J80QifcQYnrnXNxuLe3Rs3QaFMK9yKHGiy0=;
  b=eZWu8izLf//EyeH0/eIpTXmLvbrsqA7KbADAqRHBa7HWi5uSFOoFH5tV
   T86Sn2ppfXNMT4/BJHBCr59zDOR/fqx8igZNxxqIEtYS5jH4hk9Z8H9mK
   UBEVLCIGk8P1u4TFN91mLu1BzG6s5tEJaut4/TEisSH6f/JxiLn4gJa/b
   4Hcyifq8wvo3nZFZcFbka0yRy5yAflUJF2Am2RjV7NMavrY6/DND/35vc
   AK6A/A+0BsaBeQJcUis/pKW3mjofiDycEyZx2gXnmlXnAyM0eALLutRPd
   +iFVUOplrgl+XDHRBXFHuYci43zKBmUerCxT3qDVwYB8MHgQE6MP+7c3O
   w==;
X-CSE-ConnectionGUID: tfIcpk6FSEy4DbtH9BToOg==
X-CSE-MsgGUID: n4Ie0fZsTvSXcqGq57Sv+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070275"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070275"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:46 -0700
X-CSE-ConnectionGUID: XasbBrN1Q3ybofPdjWRezg==
X-CSE-MsgGUID: dP50U6MLQOufTB1Xd5Wr6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226285038"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:44 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 20/27] KVM: x86: Add per-VM flag to track CPUID paranoid mode
Date: Fri, 17 Apr 2026 15:36:03 +0800
Message-ID: <20260417073610.3246316-21-binbin.wu@linux.intel.com>
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

Add 'is_cpuid_paranoid_mode' to struct kvm_arch to indicate whether
CPUID paranoid verification is enabled for a VM.

When enabled, KVM will restrict the guest's CPUID configuration to only
known and supported bits, rejecting userspace-provided CPUID entries that
set unsupported or unrecognized features.  CPUID paranoid mode will be
unconditionally enforced for TDX guests, and optionally enabled for other
VM types via a new KVM capability that will be introduced in a subsequent
patch.

No functional change intended.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f6d79e8496c3..4f645f9dfb5a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1485,6 +1485,9 @@ struct kvm_arch {
 	bool has_protected_state;
 	bool has_protected_eoi;
 	bool pre_fault_allowed;
+
+	bool is_cpuid_paranoid_mode;
+
 	struct hlist_head *mmu_page_hash;
 	struct list_head active_mmu_pages;
 	struct kvm_possible_nx_huge_pages possible_nx_huge_pages[KVM_NR_MMU_TYPES];
-- 
2.46.0

