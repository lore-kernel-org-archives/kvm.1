Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758103CC332;
	Thu, 18 Jun 2026 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771984; cv=none; b=XCAtL377CF5jIYgzvJfBSYs6GrgjEpNmzMav0wOxrPEDaWETnRbs47jCmxVkGHmmkWVoYJgKPRtB9uqpvBvY5pzJ3U7TE96ZmX32+I16x+1EwGpUd/IZzyU0NUZAELmDkYmplTjoDeAyvcjU7ReICgm2xl1GYZ6jW5cA9URSc54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771984; c=relaxed/simple;
	bh=CiqzUTxOBe8IM+/FB5Dq2GsqJcAAmyzxM1b4S6QapWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sQ5EoNi7MTxhKBSBzyPtcz3jwB7zbFQbBvGof7KWKcQgkRn831yQ0tqrvZO8CL6ikRR0bj+sieGEOy0xVglPfE4LCyIyiU6TpLh1vECThWdrjruFMo+sTudTShgK9dg7C11Vt4AOhU51/nvrHXV17tzx15j/B7lpGA+CzK5hAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFVk8JJo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFVk8JJo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781771983; x=1813307983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CiqzUTxOBe8IM+/FB5Dq2GsqJcAAmyzxM1b4S6QapWc=;
  b=UFVk8JJols/qRfRVPFHlpOhqZYDQ6nXpRAD0SaVHX4ZpsVCxfCR64K54
   hLvC7Y4pZgmXDJHSp8CE8amgjAK+kD82MVz9XLCrDqjG8fURPFXpDqPS0
   mWpgP9TjMp1AnRKCP6UrThKDhkDFS8VvVJ+UZcxROSlLLP9R8GgjMyKCH
   b7HxSK9gM/kGOG7qBxbZs2ZgT5IZAZArkJOgA0lIs2wDcB0yIbxVJn0a+
   +Rhrv5aKfq3MWxldh9R+u6v4G5Si4GvzsnLf7TzZBP4U/nuwxWTm4JBgn
   MfZiJDGZxP/gDRTyMuSQEWlgefOVrmJ+ctpPhUo88lXJLRz8zxP1U6ZKN
   w==;
X-CSE-ConnectionGUID: NB8V9oz9TxqZa2XUNJiBsg==
X-CSE-MsgGUID: gbmnkkfASYG4WNWN+wuioQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584763"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584763"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:39:43 -0700
X-CSE-ConnectionGUID: RLCViYQzT9au5zfFWP2Csg==
X-CSE-MsgGUID: K3/Ly09eT9OmL7815i8oCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392321"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:39:38 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: djbw@kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	sohil.mehta@intel.com,
	adrian.hunter@intel.com,
	kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com,
	peter.fang@intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	seanjc@google.com
Subject: [PATCH v2 09/17] x86/virt/tdx: Add interface to check Quoting availability
Date: Thu, 18 Jun 2026 16:13:47 +0800
Message-Id: <20260618081355.3253581-10-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Fang <peter.fang@intel.com>

KVM needs to know if the Quoting extension is available to determine
whether userspace must be involved in Quote generation.

Since the Quote buffer is always created during Quoting extension
bringup, checking whether the buffer exists is sufficient.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h  |  2 ++
 arch/x86/virt/vmx/tdx/tdx.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 741fd97cc199..9432a736855e 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -147,6 +147,8 @@ struct tdx_vp {
 	struct page **tdcx_pages;
 };
 
+bool tdx_quote_enabled(void);
+
 static inline u64 mk_keyed_paddr(u16 hkid, struct page *page)
 {
 	u64 ret;
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 9716424a301f..da55c1aeeeb8 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1193,6 +1193,16 @@ static inline phys_addr_t tdx_vmalloc_to_pa(const void *addr)
 	return PFN_PHYS(pfn);
 }
 
+bool tdx_quote_enabled(void)
+{
+	/*
+	 * No need for locking here. The quote buffer is initialized as part of
+	 * core TDX bringup, which comes before KVM is ready for userspace.
+	 */
+	return !!tdx_quote.buf;
+}
+EXPORT_SYMBOL_FOR_KVM(tdx_quote_enabled);
+
 #define HPAS_PER_NODE			(PAGE_SIZE / sizeof(u64))
 
 /*
-- 
2.25.1

