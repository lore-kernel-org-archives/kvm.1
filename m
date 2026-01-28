Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C855D335554
	for <kvm@vger.kernel.org>; Wed, 28 Jan 2026 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769642263; cv=none; b=hRNXjQxB5rgrybnBDTIrVKA0Fla8URw5miYq8b1doL/hVJmU7dwxSCSKR0joBCRNR4zz1a0/GyFFS6iZWF4ZuQfE+yHQWaRiIZE8i5JWFiQpgDV84kRg7vpXN1m/50fMkfUY2W07ZHLwu73TJTFfY2LK4N0aL7hJHqqEKj+OzzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769642263; c=relaxed/simple;
	bh=n4k/dBndX6PazD52gFOh8+8Xc/EV6fspDOZfLr8VGQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fs1uBItxAmyZoQvs2se3NMboMykOAPKELmoS4Ivhd/4qH12jLnv7JyCQWo+ZFDseWrqhqkgCSj2mDrRNc7nri75tZB96lUNebbq47idVp7Iwv4gL/MWzHwVvgVkFytsTg4cIU4RIdVhz8810EHKgO2uiSQll1KcvkgBmRANuITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHn86RZw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHn86RZw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769642262; x=1801178262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n4k/dBndX6PazD52gFOh8+8Xc/EV6fspDOZfLr8VGQk=;
  b=KHn86RZwLyHUpcnF4peevZRQClkqPRXEYM0K4OOPV+ZnZWnwueYQUTIE
   cuPS0JNQgGlD/MlASTpijZDg0R/kneJfqGbVRw/xtH+gDIt3YXFwU9Pu3
   J80pnzpLAno0gem3SK9YFe1EJuAQrcmUJHucg6Yy2LELvurGLZ3+5zwMc
   sXOLgb/UC2FLnO/fqVlvzoVBhP24d13B+43o9aC/tpqeYfaFjGEHQ9a+y
   bocuz4VJ6reaREbfYRHyWjvWhaog40ZimWsDpkbKa27plk2UP8Q2KlFsL
   8qHXcarC9PiRTPjRgRvkGT3MSp32PLDRDttkYEB9E+4Bt7XCe59oYVq70
   w==;
X-CSE-ConnectionGUID: i+jlMxWUTNS6OPo0Rmq7RQ==
X-CSE-MsgGUID: l95I0j1mSVe5eOHS6uZr5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462334"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="73462334"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 15:17:41 -0800
X-CSE-ConnectionGUID: sjmY/ywyTQucpE4h6sBdAw==
X-CSE-MsgGUID: s19KMWBaStm58hq2kDHykw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208001778"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 15:17:40 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 07/11] target/i386: Make some PEBS features user-visible
Date: Wed, 28 Jan 2026 15:09:44 -0800
Message-ID: <20260128231003.268981-8-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128231003.268981-1-zide.chen@intel.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
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

 target/i386/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d3e9d3c40b0a..f2c83b4f259c 100644
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
2.52.0

