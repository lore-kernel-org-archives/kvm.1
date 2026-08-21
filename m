Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA633DDAF4;
	Fri, 21 Aug 2026 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304925; cv=none; b=YDKOJ7p4eNGyRrDsT0yRSNbjBDWYU4WEZHE/m/qMijeXckITMX+Yn5WHfXdndErUnzSwY2lmBVOqwQnlWyI5Y/FTspkR1QQs/SbcHkYF7U0FRI7D4+H23UNsu+F4syfOddGelvwEjCdMaPkwN6VlpTJdNdpgjNolLuRCq7Jo7/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304925; c=relaxed/simple;
	bh=Fr0L+bWzaux+VbiP5oEaxO4wV06GUEM1wypYkaQMS6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQX1hhLIDE5G1Vdr1KULbVypG7mxCpjrh56VLwt0vYbJVIRh+yjv5J1eoNsqLF8YdUDwQAfy5QIqQZNsda/hL8kSwiNPPSdeFaaFiZf08B8Gf40ptFVogcarmVB+zkTgdOCleiWlP3dFcfllICWoorh3T7afPYdZKxQBcZnXCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wyo6fqMX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wyo6fqMX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787304914; x=1818840914;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Fr0L+bWzaux+VbiP5oEaxO4wV06GUEM1wypYkaQMS6A=;
  b=Wyo6fqMXPgU43BCbNE8o+WgViQIBjxQ4MySl8GCDaSvRnwwYFJK6j5K2
   fk2XlaEFRhFGE+cD8As1EC7t9niCDJBlMV+J/o5k7NhL9JkbXZ4EWmXzT
   /f7mJJi6Xw9kVm9dpjvwUlCoCzPnS0bsqN7LADvXB6Ot2y1iBJ5X+IyPN
   qy4Ybwg3JiHXGM9QrO9zCORRf3tFXcUeWnsslNXaMsJywcWaKsNv+Qhpt
   Xy3IYx8j9AO5Lkwh5XrVxPvY4v42a7aLdUenJqp0PjICcv18OZnWhG8Hs
   ABXp+4mAA5pYKCsr2Epg4EZeN5X3/sb7Tv29qCOVrtfOz1+DPa+ePLP42
   Q==;
X-CSE-ConnectionGUID: vbdYgwBvRA6dxCrtXTfJVg==
X-CSE-MsgGUID: NSEQZjR0REKZWYC9kSvZ8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="99006460"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="99006460"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 02:35:10 -0700
X-CSE-ConnectionGUID: Z64lT8n1S9+8knxitS2Cbg==
X-CSE-MsgGUID: H5G+fFKdS7edO/3+Z/dhvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="268222739"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 02:35:08 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	binbin.wu@linux.intel.com
Subject: [PATCH] KVM: TDX: Charge misc cgroup before allocating HKID
Date: Fri, 21 Aug 2026 17:39:57 +0800
Message-ID: <20260821093957.1722167-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a tdx_hkid_alloc() helper that charges the misc cgroup before
allocating an HKID, and unwind the charge if HKID allocation fails.

__tdx_td_init() currently allocates an HKID before charging the misc
cgroup. If the charge fails, the error path calls tdx_hkid_free(), which
uncharges a resource that was never successfully charged. This can make
the misc-cgroup usage negative.

Charge the cgroup before allocating the HKID.  Wrapping both steps in
tdx_hkid_alloc() makes it the exact counterpart of tdx_hkid_free(), i.e.
keeps resource allocation and release symmetric, and lets __tdx_td_init()
simply bail on failure instead of open coding the unwind.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260710040153.D8EA71F000E9@smtp.kernel.org
Closes: https://lore.kernel.org/all/20260718020348.3B4221F000E9@smtp.kernel.org
Fixes: 7c035bea9407 ("KVM: TDX: Register TDX host key IDs to cgroup misc controller")
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a7..d1fe279b5bc3 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -260,6 +260,31 @@ static __always_inline void tdvmcall_set_return_val(struct kvm_vcpu *vcpu,
 	to_tdx(vcpu)->vp_enter_args.r11 = val;
 }
 
+static int tdx_hkid_alloc(struct kvm_tdx *kvm_tdx)
+{
+	int ret;
+
+	kvm_tdx->misc_cg = get_current_misc_cg();
+	ret = misc_cg_try_charge(MISC_CG_RES_TDX, kvm_tdx->misc_cg, 1);
+	if (ret)
+		goto put_misc_cg;
+
+	ret = tdx_guest_keyid_alloc();
+	if (ret < 0)
+		goto uncharge_misc_cg;
+
+	kvm_tdx->hkid = ret;
+	return 0;
+
+uncharge_misc_cg:
+	misc_cg_uncharge(MISC_CG_RES_TDX, kvm_tdx->misc_cg, 1);
+put_misc_cg:
+	put_misc_cg(kvm_tdx->misc_cg);
+	kvm_tdx->misc_cg = NULL;
+
+	return ret;
+}
+
 static inline void tdx_hkid_free(struct kvm_tdx *kvm_tdx)
 {
 	tdx_guest_keyid_free(kvm_tdx->hkid);
@@ -2445,14 +2470,9 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 	u64 err, rcx;
 
 	*seamcall_err = 0;
-	ret = tdx_guest_keyid_alloc();
-	if (ret < 0)
-		return ret;
-	kvm_tdx->hkid = ret;
-	kvm_tdx->misc_cg = get_current_misc_cg();
-	ret = misc_cg_try_charge(MISC_CG_RES_TDX, kvm_tdx->misc_cg, 1);
+	ret = tdx_hkid_alloc(kvm_tdx);
 	if (ret)
-		goto free_hkid;
+		return ret;
 
 	ret = -ENOMEM;
 

base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
-- 
2.46.0

