Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849E3D75D7;
	Thu, 18 Jun 2026 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772024; cv=none; b=VDQS0vrSeljdh1QlEHgjNnEIi2zk2POOufWFCMm6ZV2LFBeqTUGVioUoDr8Yffx3QSxmQhgD4SjZBqrdKuKigoWEcqh9AoMReuM9l8udtH6pd64YvB9CJ8i5TUHjni4HfV2DjlRRroy5vpCl1Wp5vGpWZN9hMx9fFL+SBbo1zLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772024; c=relaxed/simple;
	bh=0w/6XgujKVJ9toSJI3a+CCuTU7ezdd2xwJ2qpvrcDtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s6NnhNsQgEZbPYix7tPzci/JcgNJ5f78IrzDbNySbvPORGXoH3GkBH4Kdhpr6Q5JItIfohDzBH4KcXoBHRvrADY3gIL7vQl+2vi9yd0YxJYnFmt+oPuyWfXTiJ8rnwxN7crzPUOum8g6SyH37+5rOcghHGIMHzHM4In8FSJwxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFcgh6Sg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFcgh6Sg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781772022; x=1813308022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0w/6XgujKVJ9toSJI3a+CCuTU7ezdd2xwJ2qpvrcDtU=;
  b=NFcgh6Sg386RTQRDKkuF9YKRHVllfcpnrZXr981qVgZWyFLafdd3ODNQ
   RMc9cHGq61FH5thNAaYfZ8RsyoDvQhNihPVzbipgNndLUuVGDZgV5HzsN
   9zXgjuO+3qsQW71wIilX2F945AqxH82MsTH2MAvxaO8KUBc0pUhB+GUsi
   /AmV4FVmTIDKs7XsSQFkMNqIf/42HIVs1bJbLLzmG2Yhum69TnfeamTYh
   FFgmLgde/nwHwQ1av/gTsLTKBks5cktmR0CludGTfmmRS1IeceDaWrOtI
   1u8cDJR4Quht/JWDRVyXtU0NxuA2dNnkOFpfZsGRNUKLmIrb6xWMSVYOb
   A==;
X-CSE-ConnectionGUID: AS6g2b01RCiEuPPJxg9Q0g==
X-CSE-MsgGUID: i/D/QykTR4WEbrin2wslCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584852"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584852"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:40:21 -0700
X-CSE-ConnectionGUID: ZCtkBSw5R7GhCLrsGa/o/g==
X-CSE-MsgGUID: d69uf/O7R4io492KrDM/fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392540"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:40:17 -0700
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
Subject: [PATCH v2 17/17] KVM: TDX: Support event-notify interrupts only with userspace Quoting
Date: Thu, 18 Jun 2026 16:13:55 +0800
Message-Id: <20260618081355.3253581-18-yilun.xu@linux.intel.com>
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

Tie userspace SetupEventNotifyInterrupt support to userspace Quote
generation. Delivering event-notify interrupts via userspace breaks if
KVM never exits to userspace in the first place.

This is an optional capability to notify the guest when Quoting has
completed. No known guest currently uses it, so defer adding in-kernel
support for now. The Linux TDX guest relies on polling only.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 20558b0185b6..25146da3933f 100644
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
+	 * quoting service is enabled, as quote generation will be handled
+	 * entirely in the kernel. Support in the kernel can be added later.
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
 
+	/* See comment in init_kvm_tdx_caps() */
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

