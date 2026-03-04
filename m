Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AAB3C6A43
	for <kvm@vger.kernel.org>; Wed,  4 Mar 2026 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648105; cv=none; b=qHbbllqxwHeiQoJViQTGqn/jeEO29BhBEVpO+6TsD0Okrqta4GoG8ndIpMqB//BSMx8wbSPoqJQjg95Ixp9vuvjx5vjL2/kpAVZr2VhP8VTOKOdzYR2ji2m9xompiYRJlNRyjazO7x0HrYHicXyO4OuC+y2Nhz4A7pT6GzX/6Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648105; c=relaxed/simple;
	bh=B0G4zOn0Aq8wL+6thBXZpp/WgAVLsoCHdMf7+BmI3vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJ9YvLbyMQA9rBlKXjFJEif777WvxC2d7TvJ8pcwuCB+k3rhVty+rTS/ZWtM2lftnMnGy6Qga4D70cKq+fpC4uyjkmWncQb6xDIOIWbTUt4iNrBqzGG/htiQk4teP9XlNTt66nCTVQK+cgK7VPeAWoMPotb8r5rRifCooW/uNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4DHmWTr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4DHmWTr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772648105; x=1804184105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B0G4zOn0Aq8wL+6thBXZpp/WgAVLsoCHdMf7+BmI3vw=;
  b=m4DHmWTrjgdmXc0W4q1hpAtf6drO8l2ICBeDTUj3DHu4GT9iGaqEEkvR
   pMf3ucd2vU8VE4OhMOUJxlq9y+/FweKdh8OIF2NdGqdMPU2131c8eX7+8
   b/IRNE1f56G28qaIM5YN7VeIxXEntDmihpyb1XGQn9CQ04M7pdi4mmfat
   UKbkJJ77evH/8v6S/Xq0ayA7NUYCMdy2TJI1qYpcVvyqIAY1ReWNo+mH6
   U9Mxzc/mYWYJ6pW3WprvPwAsKLnfcQZFcgox54UD8eRyYshKDdK31cexg
   o5BeRq7cupxfHUCIUon1F6MtKByw/MqoLGlB66uVU4WaBfttG13R5SiOc
   A==;
X-CSE-ConnectionGUID: GK02D+3BTBq2SEG39LDHdg==
X-CSE-MsgGUID: JighCLEDTp+Uin3lG4HO4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73909270"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="73909270"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 10:15:05 -0800
X-CSE-ConnectionGUID: p5I6NyclTCmZ4If9YJ49nQ==
X-CSE-MsgGUID: festpwoYQguhSWKRf0ptYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="214542769"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 10:15:04 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 01/13] target/i386: Disable unsupported BTS for guest
Date: Wed,  4 Mar 2026 10:07:00 -0800
Message-ID: <20260304180713.360471-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304180713.360471-1-zide.chen@intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BTS (Branch Trace Store), enumerated by IA32_MISC_ENABLE.BTS_UNAVAILABLE
(bit 11), is deprecated and has been superseded by LBR and Intel PT.

KVM yields control of this bit to userspace since KVM commit
9fc222967a39 ("KVM: x86: Give host userspace full control of
MSR_IA32_MISC_ENABLES").

However, QEMU does not set this bit, which allows guests to write the
BTS and BTINT bits in IA32_DEBUGCTL.  Since KVM doesn't support BTS,
this may lead to unexpected MSR access errors.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V3:
- Add two Reviewed-by.

V2:
- Address review comments.
- Remove mention of VMState version_id from the commit message.
---
 target/i386/cpu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9f222a0c9fe0..016fb1b30bbd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -474,8 +474,11 @@ typedef enum X86Seg {
 
 #define MSR_IA32_MISC_ENABLE            0x1a0
 /* Indicates good rep/movs microcode on some processors: */
-#define MSR_IA32_MISC_ENABLE_DEFAULT    1
+#define MSR_IA32_MISC_ENABLE_FASTSTRING    (1ULL << 0)
+#define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL   (1ULL << 11)
 #define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
+#define MSR_IA32_MISC_ENABLE_DEFAULT    (MSR_IA32_MISC_ENABLE_FASTSTRING     | \
+                                         MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
 
 #define MSR_MTRRphysBase(reg)           (0x200 + 2 * (reg))
 #define MSR_MTRRphysMask(reg)           (0x200 + 2 * (reg) + 1)
-- 
2.53.0

