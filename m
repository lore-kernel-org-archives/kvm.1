Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CF64DA55C;
	Wed, 13 May 2026 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685124; cv=none; b=AiD8aG9D2rr5X/grnj4wg7KXohHRHFizvkX3OLPyru6BhYdzeyEt1ykD9opOclHboxMJ8rWNpOTwws4C1MoWCLFUlX52x9Esf98nVVA9X9GhVhUifEaXmDZSZC5jMYcX8yC9aunRdLCi/6P7CMPjs1JmOQbd0IP91BHNeJv/tYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685124; c=relaxed/simple;
	bh=NQ4lEceBbiRV2FzlBRrERpkQeA5r2KNYHsPAFpy9GUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOm0XjEdF0DE5awEQD5V+7sOCg3aqHCNcI7vGikKxsHB60m9dDbNUiDjjppTK4tv1vLMr048vKc7tFYHzMIouvmfGT81fcVFJXnQGO6k+7hRzy5lmwqvXYRm9vGmZWQ+ZRU7OXLKEtVqjDViswbbSurMKvmX3uq0c+/zeM+09+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgL/DuzL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgL/DuzL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685123; x=1810221123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NQ4lEceBbiRV2FzlBRrERpkQeA5r2KNYHsPAFpy9GUE=;
  b=LgL/DuzLwxuijQZpADpJMaXEEZxe/lcGDlzkxVIb1jNN3B5eKcNfBjsF
   6IFKTdL2ZaLtnZb0Nxw2iNpaupESpDutDQpwa7uQQ9x18ugp4qBw5WjVr
   4rYZj7ZkQ4FItQHb9am348CUAivpyx5srMexTRbv2Vt18YxqeTKsZ3g5K
   a/jtMchxiHUypMm/0ASrm7UM39F/fUGA6joMt24P1T+6NAVUNExTo9ufH
   zGBchOvOTZniFhV156ntivtrTNC6rSiEihGhrr8NDVM0WOfRX2Kvf/7W1
   7xAsaY5F+mab3X2dURbEHQfcwudPJ9ka78E7u8ilyEuJ92bcTD8wBC0ZH
   Q==;
X-CSE-ConnectionGUID: akBEJne1SxO1ATqXneWBlQ==
X-CSE-MsgGUID: kh4sqhZuQMOeOD1VkqGn7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921811"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921811"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:12:00 -0700
X-CSE-ConnectionGUID: h9+/am/jT/Sxq/mdceleFQ==
X-CSE-MsgGUID: poH7E0tORwSMvvqKCXvL7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716922"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:12:00 -0700
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
Subject: [PATCH v9 21/23] x86/virt/tdx: Enable TDX module runtime updates
Date: Wed, 13 May 2026 08:10:04 -0700
Message-ID: <20260513151045.1420990-22-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513151045.1420990-1-chao.gao@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
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
index 1e1bdc4ec9c8..ac042b369843 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -34,6 +34,7 @@
 #define TDX_UPDATE_COMPAT_SENSITIVE	0x8000051200000000ULL
 
 /* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
 #define TDX_FEATURES0_UPDATE_COMPAT	BIT_ULL(47)
 
@@ -115,8 +116,7 @@ const struct tdx_sys_info *tdx_get_sysinfo(void);
 
 static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinfo)
 {
-	/* To be enabled when kernel is ready. */
-	return false;
+	return sysinfo->features.tdx_features0 & TDX_FEATURES0_TD_PRESERVING;
 }
 
 int tdx_guest_keyid_alloc(void);
-- 
2.52.0

