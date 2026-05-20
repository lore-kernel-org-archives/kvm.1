Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ECD2E3397;
	Wed, 20 May 2026 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284437; cv=none; b=MefWFG3uEIwzh5CpZUA5LR69ciLeqzYuNAnBH64UApbvpGoCYdnJpd86XaUvyex3zp4nnSW49v2kVsvSvMmI7brZHPs1Q/IlAyKErPDG9Um7g2rJuuQ8ZCh/1IQunysJiC6f1T9r6nW/uOWyZIAe3ZjkhrFJDa5hVFDI75nctkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284437; c=relaxed/simple;
	bh=NKjcSYXRbvLTovLssfzj1NQJ+Uo5FfLtMzRr4pePg8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzYER/KqnRo7zyVfY60jtlMUJZUaX24zK1KcK9pL9fta4y8HrD3Fmkj5A1G7oA6goNDkJfIvTzPJiaabyiYemlN5+Bkh4xlj12wiCOt1ks2pIgP3f3D6wRDtaWMFnf5YPz95SHqws3ugxK9hug43w7k7gLu4gByaRVRphX770TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAbA1OC0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAbA1OC0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284436; x=1810820436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NKjcSYXRbvLTovLssfzj1NQJ+Uo5FfLtMzRr4pePg8w=;
  b=PAbA1OC0Oo/ax67MC9j4/g8NDCZytsBhds/KV0gS4jhdIQ8FSkBxYSUu
   PGj6G72bhlrNrEok5au18iPc8i0OA/x883iz2JsjAgmH8ch99M2zkzhMY
   UKynxBDhCwy+CbI/IAxKvY+vYdeuYnXmUewdanZgIq/wEoEy450MqqdN4
   GskiX5ntzlN6TrawmwaTirlx2Fd81ltY0n5hO5yPQqnaOgAQXFm1k60hX
   rR8nqRbFqSAWD0BiP6aBn1s+Ysev0wIYlo9t4MaN24AiHW/EZbqnCgv/3
   UoXHaDwSR9cOBY4XYA47tI+6yQGUX3eGSz3hHn/CRszcoTbwak/P5iZH5
   w==;
X-CSE-ConnectionGUID: jjr/Zy/7S+q7fNyz2ZM+QQ==
X-CSE-MsgGUID: XXG2/hUdT9ObL6J/BrSujg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146655"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146655"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:36 -0700
X-CSE-ConnectionGUID: ITYUc7h9Q1CJT03wVv5gaQ==
X-CSE-MsgGUID: HvAYQfPUQQ+r6RIp3MPTHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235924045"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:35 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dave.hansen@linux.intel.com,
	djbw@kernel.org,
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
Subject: [PATCH v10 23/25] x86/virt/tdx: Enable TDX module runtime updates
Date: Wed, 20 May 2026 06:38:26 -0700
Message-ID: <20260520133909.409394-24-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520133909.409394-1-chao.gao@intel.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
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
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/tdx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 282cb0e08b8e..c848483d815f 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -34,6 +34,7 @@
 #define TDX_UPDATE_COMPAT_SENSITIVE	0x8000051200000000ULL
 
 /* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
 
 #ifndef __ASSEMBLER__
@@ -114,8 +115,7 @@ const struct tdx_sys_info *tdx_get_sysinfo(void);
 
 static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinfo)
 {
-	/* To be enabled when kernel is ready. */
-	return false;
+	return sysinfo->features.tdx_features0 & TDX_FEATURES0_TD_PRESERVING;
 }
 
 int tdx_guest_keyid_alloc(void);
-- 
2.52.0

