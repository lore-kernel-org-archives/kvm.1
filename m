Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8753D6CBA
	for <kvm@vger.kernel.org>; Wed,  4 Mar 2026 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648124; cv=none; b=NcSClZTDIhpEytwDWAa7L5OS6V2cvIqzM7cVSsUZYLe4uLvrd2ibHzqwGzFfYGI0WXcAJMFan1CqyWyjgistnmkSlqFcBiJgAncTJrktw/8tzv8uaxC3LBx5vw4Xv2RpkB9Zj7ebZ3QaDbHfwHltZGEbtAlHeW34Nu+xYuk9pdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648124; c=relaxed/simple;
	bh=T3rLVATkeaOZqbu/K82gItA0KRLdS7dbDWTMLXCxiDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDoEES8YlVd3FfThnSc1cxbv4kqYwnYmyQ6HiWqbnilRemLeikdDCUUAJlTOFLxE60XggG9r45wWGuZxRM8LxlXLk/GznOIPwi0jNFqpPx4KzdskhhwgoaIlxUfGYenOPmnJoT2182TnaAPBWNsfMGq/6/AM39hs3cdmyMh7Ems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/Ft+TI0; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/Ft+TI0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772648122; x=1804184122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T3rLVATkeaOZqbu/K82gItA0KRLdS7dbDWTMLXCxiDE=;
  b=f/Ft+TI0BKshcmtA/nLr2qGJkd/oliMiAmIyBOhnHYJ2K8GTHiw+Xg8V
   vBVKN0I7/xdXJOwKYPppjfXsBZbcZv2rG6QLUtj6qm/CRn0skMbHwFxgk
   YfTA7G1sgMs/tLsxc2Ro7XlmPI1ibQ5rQITgABnsJyjBdZrzPHjjA3T4i
   Rfx6MDBm0CJ4zlYRFdqelKb7kqPstx/k21pbOp4yLx89i4G4PDFQtx6SD
   SYHKk75wklSWT+quha6VBSutgyF2tH+0unkC72O1qavwRWDoN6gF9eZb4
   POmvQhfRnUssczOziHSWxyiX0R13vkMz81Scf2m/THUMplVZqhfE/6A3r
   w==;
X-CSE-ConnectionGUID: DYI3YMmBRzet22FLqDF7dQ==
X-CSE-MsgGUID: /wiZnkEkS1Obme3Kg25AsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73909360"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="73909360"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 10:15:21 -0800
X-CSE-ConnectionGUID: zLAAZRQxSAuPbfVXzm+bZQ==
X-CSE-MsgGUID: DrbypqUxTG+baTwlPyAH0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="214542835"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 10:15:20 -0800
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
Subject: [PATCH V3 08/13] target/i386: Make some PEBS features user-visible
Date: Wed,  4 Mar 2026 10:07:07 -0800
Message-ID: <20260304180713.360471-9-zide.chen@intel.com>
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

Populate selected PEBS feature names in FEAT_PERF_CAPABILITIES to make
the corresponding bits user-visible CPU feature knobs, allowing them to
be explicitly enabled or disabled via -cpu +/-<feature>.

Once named, these bits become part of the guest CPU configuration
contract.  If a VM is configured with such a feature enabled, migration
to a destination that does not support the feature may fail, as the
destination cannot honor the guest-visible CPU model.

The PEBS_FMT bits are not exposed, as target/i386 currently does not
support multi-bit CPU properties.

Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Add the missing comma after "pebs-arch-reg".
- Simplify the PEBS_FMT description in the commit message.
---
 target/i386/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a69c3108f64b..89691fba45e1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1618,10 +1618,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
             NULL, NULL, NULL, NULL,
+            NULL, NULL, "pebs-trap", "pebs-arch-reg",
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, "full-width-write", NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "full-width-write", "pebs-baseline", NULL,
+            NULL, "pebs-timing-info", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.53.0

