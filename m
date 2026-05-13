Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7C547A0DD;
	Wed, 13 May 2026 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685101; cv=none; b=lWqPqSgQ+IR1j/TrYkdECQh0Ip7jfaseewuINCKHqc5QFbgdwaEfyLADwMLREzS4QcBxZBAPrGcS/EH2aSpucpke5okFCRdS9L7ETAhPnUpf5+9go2ZobFhuxyB7wzrbcqkrKg9EeY4O4DWFUjhfpiug8H1t2ZbD54uoBNBBj1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685101; c=relaxed/simple;
	bh=lvO/bL79m2HL36etwJxBtAXykeqehbg7haklsgoA7Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQ2tSvYBHfqVMQFmK+eyaNTzaC5GY6vxlqVcNZXyLI8MrLL+Mw7cyNBrd8T8i8nprcO7duuEGcwBWtisPDDHF6vIc8Kn5OcV2uqdrK3znvAQAVC+ASdHPMPxi1vYWi1qnQtMywMQP37y9Xp1MLfVJQc0OEyA3fyU9/Wl05PhHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6GJxkrQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6GJxkrQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685099; x=1810221099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lvO/bL79m2HL36etwJxBtAXykeqehbg7haklsgoA7Q4=;
  b=I6GJxkrQxCmsTr0DtDVRGm8/aFhAklLcF6Op7Biv7WhlsUaSxE1lnX5U
   FVFzudOv2HfEtZHEp4EtxTo6ju95jAVSivwJdHo98WAuizI8KVBGvSFIx
   awGyzepwxAdCARrwh4/BeWDvjubKXnNpaiFesMYlFRBEiIBu3kXM4+Ulf
   TJL2x1GXBsOcx7i3V9b9yStsyc4Oelz0XsybTGtQ+gaD6b/sCURocR8Ee
   GIqcFscGrjhCm/gr/hM7BnvTsExAnzOLdddiTwQ2bpa/pIZeEb8RWVKWz
   Qfy6ViZWmlEj2bdx3HfGac55hEpHCfT6zvtqTZ0Z+zsfhvJFDqHAcemYI
   Q==;
X-CSE-ConnectionGUID: D8/04h9PScuKYje16A2Z7Q==
X-CSE-MsgGUID: zFoB6L9hS6Gv6GfTKswrVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921591"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921591"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:37 -0700
X-CSE-ConnectionGUID: 1ZZltKsBThWz/+AgPvNWkQ==
X-CSE-MsgGUID: sVkv/9D/S2OQx+UQJm6vZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716752"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:37 -0700
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
Subject: [PATCH v9 02/23] x86/virt/tdx: Move TDX_FEATURES0 bits to asm/tdx.h
Date: Wed, 13 May 2026 08:09:45 -0700
Message-ID: <20260513151045.1420990-3-chao.gao@intel.com>
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

Move the TDX_FEATURES0 bit definitions from the private TDX header to
asm/tdx.h, and opportunistically switch to BIT_ULL() since TDX_FEATURES0 is
64-bit.

This prepares for TDX module update [1] and Dynamic PAMT [2] support. Both
add new TDX_FEATURES0 capability bits, and both need those capabilities to
be queried from code outside arch/x86/virt. The corresponding feature-query
helpers therefore need to live in the public asm/tdx.h header, so move the
existing bit definitions there first.

No functional change intended.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/kvm/20260427152854.101171-17-chao.gao@intel.com/ # [1]
Link: https://lore.kernel.org/kvm/20251121005125.417831-16-rick.p.edgecombe@intel.com/ # [2]
---
 arch/x86/include/asm/tdx.h  | 3 +++
 arch/x86/virt/vmx/tdx/tdx.h | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 15eac89b0afb..e2430dd0e4d5 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -32,6 +32,9 @@
 #define TDX_SUCCESS		0ULL
 #define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
 
+/* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
+
 #ifndef __ASSEMBLER__
 
 #include <uapi/asm/mce.h>
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index e2cf2dd48755..76c5fb1e1ffe 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -85,9 +85,6 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
-/* Bit definitions of TDX_FEATURES0 metadata field */
-#define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
-
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
-- 
2.52.0

