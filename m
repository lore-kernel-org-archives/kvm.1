Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E52371CF4;
	Fri, 22 May 2026 04:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422760; cv=none; b=SK3sVHkH59+oVF7gCXi5NFxqkaUO7nptUWv5gUprLyeTC5NCL6KUcn293LksdePQklOYfxyWB9G/We4OcbTJ0SZOTkS9hGnaJzxKh4MNsvthjQF2O5V5xDqkjipqNOwjC5xv8YtWYpncvU4VsivBUaL/L2u1v99sofVSbhC4Njo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422760; c=relaxed/simple;
	bh=8ymCjBYlGqF8pPYfR9+OToil8KwvC5uuqR0U1MvIwag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQVFldlOO2tpbJLvUyDKMz9M6zkPldZTMkDr6+DKm5sjwRjBXqQcIQvVL6LRLclaV1sgCzLWjDPSTyIthMqxfNHbhNEWErjyFb26EmDWGvS6k10DUelzTHWxvP6bZVnaKVpCFcOKppt9H7zifbTTdqX3RjcLyoyyC4D1lKLG4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjF/GZnE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjF/GZnE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422760; x=1810958760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8ymCjBYlGqF8pPYfR9+OToil8KwvC5uuqR0U1MvIwag=;
  b=DjF/GZnEViqA2VYPXwRSRflA94b4MeIGta5N2cYFquZjk4RwLK2FFEx+
   DLDtU6/u/04H7ma0V4BEfpJ+7flO0XCQ7Dv0OXAabBPf0MckTRvw89kK5
   cmHhkw8PmFyC86aV2W3X/mjgZ/SJo+Wg46EonWp4RKdSyXcWosKU3eyaq
   8LJe9KM32F9xdl/j10awBQLDwPWmaHpNzFp2VZV1Rl+FSWSrjUk10EuVU
   na9I8LUriA0WFmzZJ8ykDeoehUihVp/0Pb1OUq0zB6Wu3KWHG9ekWdh4g
   F1Ovv2Efh2v5UXYZJUFDoOiqt6rWnhftd7E0VfEUJbMsQPyV0lbcVRol5
   g==;
X-CSE-ConnectionGUID: 6nTSB2/qSpKfrJX/Azi7Aw==
X-CSE-MsgGUID: bhNndQUERFm40lV1qMwtrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528924"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528924"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:06:00 -0700
X-CSE-ConnectionGUID: JHPT7t9PRlOsLysMRo9Acw==
X-CSE-MsgGUID: ZbGWsh5sQXSbHMXb+vftww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757929"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:55 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: kas@kernel.org,
	djbw@kernel.org,
	rick.p.edgecombe@intel.com,
	x86@kernel.org,
	peter.fang@intel.com
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	sohil.mehta@intel.com,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	xiaoyao.li@intel.com
Subject: [RFC PATCH 13/15] KVM: TDX: Support event-notify interrupts only with userspace quoting
Date: Fri, 22 May 2026 11:41:26 +0800
Message-Id: <20260522034128.3144354-14-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Fang <peter.fang@intel.com>

Tie userspace SetupEventNotifyInterrupt support to userspace Quote
generation. Delivering event-notify interrupts via userspace breaks if
KVM never exits to userspace in the first place.

No known guest currently requires event-notify interrupt support, so
defer adding in-kernel support for now. Linux TDX guests use polling
only.

Update the KVM API Documentation to reflect the change.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 Documentation/virt/kvm/api.rst |  8 +++++++-
 arch/x86/kvm/vmx/tdx.c         | 20 +++++++++++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..8a02745a36ee 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7335,6 +7335,9 @@ inputs and outputs of the TDVMCALL.  Currently the following values of
    queued successfully, the TDX guest can poll the status field in the
    shared-memory area to check whether the Quote generation is completed or
    not. When completed, the generated Quote is returned via the same buffer.
+   If the host kernel generates Quotes through the TDX Quoting service provided
+   by the TDX module, KVM processes the GetQuote request and it will not appear
+   in userspace.  KVM only supports version 1 of the GetQuote request.
 
  * ``TDVMCALL_GET_TD_VM_CALL_INFO``: the guest has requested the support
    status of TDVMCALLs.  The output values for the given leaf should be
@@ -7342,7 +7345,10 @@ inputs and outputs of the TDVMCALL.  Currently the following values of
    field of the union.
 
  * ``TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT``: the guest has requested to
-   set up a notification interrupt for vector ``vector``.
+   set up a notification interrupt for vector ``vector``.  Since this TDVMCALL
+   is used to optimize ``TDVMCALL_GET_QUOTE``, KVM disables this support in
+   userspace VMM if ``TDVMCALL_GET_QUOTE`` is completely handled in the kernel.
+   KVM may add kernel support for this in the future.
 
 KVM may add support for more values in the future that may cause a userspace
 exit, even without calls to ``KVM_ENABLE_CAP`` or similar.  In this case,
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index bade046da5a1..5aebbec7fa6e 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -185,7 +185,7 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
 	tdx_clear_unsupported_cpuid(entry);
 }
 
-#define TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT	BIT(1)
+#define TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT	BIT_ULL(1)
 
 static int init_kvm_tdx_caps(const struct tdx_sys_info_td_conf *td_conf,
 			     struct kvm_tdx_capabilities *caps)
@@ -202,8 +202,15 @@ static int init_kvm_tdx_caps(const struct tdx_sys_info_td_conf *td_conf,
 
 	caps->cpuid.nent = td_conf->num_cpuid_config;
 
-	caps->user_tdvmcallinfo_1_r11 =
-		TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT;
+	/*
+	 * Don't advertise userspace event-notify interrupt support if TDX
+	 * quoting service is enabled, as quote generation will be done entirely
+	 * in the kernel. Support in the kernel can be added later if needed.
+	 */
+	if (!tdx_quote_enabled()) {
+		caps->user_tdvmcallinfo_1_r11 |=
+			TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT;
+	}
 
 	for (i = 0; i < td_conf->num_cpuid_config; i++)
 		td_init_cpuid_entry2(&caps->cpuid.entries[i], i);
@@ -1684,9 +1691,16 @@ static int tdx_get_quote(struct kvm_vcpu *vcpu)
 
 static int tdx_setup_event_notify_interrupt(struct kvm_vcpu *vcpu)
 {
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(vcpu->kvm);
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	u64 vector = tdx->vp_enter_args.r12;
 
+	/* See init_kvm_tdx_caps() for comments */
+	if (kvm_tdx->get_quote_in_kernel) {
+		tdvmcall_set_return_code(vcpu, TDVMCALL_STATUS_SUBFUNC_UNSUPPORTED);
+		return 1;
+	}
+
 	if (vector < 32 || vector > 255) {
 		tdvmcall_set_return_code(vcpu, TDVMCALL_STATUS_INVALID_OPERAND);
 		return 1;
-- 
2.25.1

