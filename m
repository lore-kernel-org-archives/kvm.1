Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747603F23D7;
	Tue, 31 Mar 2026 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961023; cv=none; b=kkLNNf9qbuIva6w+iG8ld7Ru5VUrXOiPXB1G1RgJ0pVk19ippUOwxOm7i2Veb8fkGFAuX6e1ImTDvOnm1hTu3Omy/KiNQOCF14Vwq5TApoUIEemunRsYmcmZl0mdqeRdY01TuUKZsMkQ0SMze+NWGmz2ZOVEji9tMjYsYd7RTOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961023; c=relaxed/simple;
	bh=0TQC7cmBm2VgUIBUJs6axkgT9cE/nu59OrVFALFkGjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAlx0epIjoyYCwgkl5G3TCXEuL8OnnzO3CYGGvfvw0kILfjimqA7vGJSAusiE49uSegu5bASoQDvXX+FSYwn2OkJ6Vj2U00OkWnR+oeeOVCZ/KZdhgS44hEMGCx9XhV3sqvsjLKhirtlaerGlcfoYESMMUnPffz1i0HzNJDD/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFby9Hqo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFby9Hqo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774961022; x=1806497022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0TQC7cmBm2VgUIBUJs6axkgT9cE/nu59OrVFALFkGjA=;
  b=JFby9HqoUyUgHTPN7jzUkpxm05q4OOvOUWwvCQlyrOtcHWjfJz/YgrRk
   fKf7l2mo4Rya3MimvaH/FAUIQX4uIebyZmTti1GDbo7zyIHejx7U18BQT
   dTEZ7WY26VeaquMXfk/4KUNXR66dtYcrxUwFzomuQK7CxLp/JbMZZ9hLp
   gTfQPyeeBjx73JqtrI1WwpwwhmeVHG2DWNOD9FiIDzhAvhBjXtcLmFqnk
   JRmWL8K+JNlywSRrF0DmOfgW/Wq5mD1sqLlwmOxH0hYkoxK9EpNyb8EjG
   uPZ3pY5iMABFrCAqwMKMtflJYVZL8v8LzCfOY9u8wDQRYFzfWRv+dCb0s
   w==;
X-CSE-ConnectionGUID: 5dYQ52BaTcWMbl7ILCygaA==
X-CSE-MsgGUID: Q5xbVe0pQzSQZ0w7fosxrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76084590"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76084590"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:42 -0700
X-CSE-ConnectionGUID: x/GEwzFfQqizEp84Pv8S8A==
X-CSE-MsgGUID: qHpiCv1kRUeU4J/4av3kGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221492233"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:41 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	kas@kernel.org,
	nik.borisov@suse.com,
	paulmck@kernel.org,
	pbonzini@redhat.com,
	reinette.chatre@intel.com,
	rick.p.edgecombe@intel.com,
	sagis@google.com,
	seanjc@google.com,
	tony.lindgren@linux.intel.com,
	vannapurve@google.com,
	vishal.l.verma@intel.com,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v7 19/22] x86/virt/tdx: Enable TDX module runtime updates
Date: Tue, 31 Mar 2026 05:41:32 -0700
Message-ID: <20260331124214.117808-20-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331124214.117808-1-chao.gao@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All pieces of TDX module runtime updates are in place. Enable it if it
is supported.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/x86/include/asm/tdx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 00751506dd3c..0c80e78ac665 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -36,6 +36,7 @@
 #define TDX_UPDATE_COMPAT_SENSITIVE	0x8000051200000000ULL
 
 /* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
 #define TDX_FEATURES0_UPDATE_COMPAT	BIT_ULL(47)
 
@@ -118,8 +119,7 @@ const struct tdx_sys_info *tdx_get_sysinfo(void);
 
 static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinfo)
 {
-	/* To be enabled when kernel is ready. */
-	return false;
+	return sysinfo->features.tdx_features0 & TDX_FEATURES0_TD_PRESERVING;
 }
 
 int tdx_guest_keyid_alloc(void);
-- 
2.47.3

