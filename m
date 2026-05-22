Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F736F910;
	Fri, 22 May 2026 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422757; cv=none; b=Aqq0AMlZbgz4zI7xreqCf7YRyuwJQr/0ziwULOlUD2dTT+cDvRw0C6TUUQwAk0aZmW9F8silXbunfhNnNs/xc8Ra7hljhbADBDk6Ofi7O3blTu3KKH/PfPhTDvMOg3xrup5avPrFVgCX5OJZiAoEKaYqCrZZT1MORBfRkZSzpCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422757; c=relaxed/simple;
	bh=jfWMgmbUk563zhcrm+vODqwHxXh19W0SoPcTnCLRL6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O0zF5S3sIu7xir0rwSqW9uodBe1yaHAQeMB5Us9dcPKg48DwC77SZG0Ah7Mey51P1FAtuyprw2VXs1ytKm71wlRUN2u8ig6WjGypWFeFb4hhryMOt/P0gvAXTKaYrnrEEqt5uoBMB8M8ydoNU8RDeC9wZa7Qr2tZAvHtTJw68mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8eAdZL+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8eAdZL+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422756; x=1810958756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jfWMgmbUk563zhcrm+vODqwHxXh19W0SoPcTnCLRL6Y=;
  b=c8eAdZL+luQ/h5+XEDq8/fxDv+8g3kATfaPE6WMuX56T1u3/Cc+GMNtw
   WRisSjgVNC5pj8rYRLnV1PiUVHD440EGtkEiZDAbQ4cYchElLj9avIgzp
   T1zh1EmLVGGFS4vtJhPNpnDl2+zEcMLCFA7fwIYpA11uah41MB+5o6Keq
   UCzZfsONPkE4ze85QEMF5gKKbthWwtSO0/Wf+tUwlQRSboATbpElZcAl6
   uXyVYfSO5rhXE0gM5BOnAzJmTLxVQbCAjJV7amR91UsoqxqmQ1SaW+3aw
   8YhyOHLsUH3DdzGuHOl8vreHkYqsYCgDSR+mg51zHCXVHHMhidc1nJZ/Q
   w==;
X-CSE-ConnectionGUID: jIdcWKX5SQaQMpOb/0UAIQ==
X-CSE-MsgGUID: wv4rYH3FR8GyMhHqKe7Dqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528917"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528917"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:05:56 -0700
X-CSE-ConnectionGUID: 43lUnzLqQYGvusGc9f1COA==
X-CSE-MsgGUID: ZYyTKD/TTAGvlPAlCFuPaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757919"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:52 -0700
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
Subject: [RFC PATCH 12/15] KVM: TDX: Add in-kernel Quote generation
Date: Fri, 22 May 2026 11:41:25 +0800
Message-Id: <20260522034128.3144354-13-yilun.xu@linux.intel.com>
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

Provide an in-kernel path for TDX Quote generation when handling
TDG.VP.VMCALL<GetQuote>, without requiring an exit to userspace.

Use the core TDX API when the TDX Quoting extension is available. For
simplicity, each KVM guest checks for availability only once during
initialization. KVM does not handle Quoting service disruptions.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h |   9 +++
 arch/x86/kvm/vmx/tdx.h     |   6 ++
 arch/x86/kvm/vmx/tdx.c     | 135 ++++++++++++++++++++++++++++++++++++-
 virt/kvm/kvm_main.c        |   1 +
 4 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 945e6817abb2..5863d6748100 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -115,6 +115,15 @@ struct tdx_quote_req {
 	u32 out_len;
 	u8 data[];
 };
+
+#define TDX_QUOTE_REQ_HDR_SIZE		(offsetof(struct tdx_quote_req, data))
+
+/*
+ * TDG.VP.VMCALL<GetQuote> Status Codes
+ */
+#define TDX_QUOTE_STATUS_SUCCESS	0x0000000000000000ULL
+#define TDX_QUOTE_STATUS_ERROR		0x8000000000000000ULL
+#define TDX_QUOTE_STATUS_UNAVAILABLE	0x8000000000000001ULL
 #endif /* CONFIG_INTEL_TDX_GUEST || CONFIG_KVM_INTEL_TDX */
 
 #ifdef CONFIG_INTEL_TDX_HOST
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index ac8323a68b16..18c93e80c0ec 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -47,6 +47,12 @@ struct kvm_tdx {
 	 * Set/unset is protected with kvm->mmu_lock.
 	 */
 	bool wait_for_sept_zap;
+
+	/*
+	 * Whether to get TDX quote directly in kernel, without exiting to
+	 * userspace.
+	 */
+	bool get_quote_in_kernel;
 };
 
 /* TDX module vCPU states */
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 9f7c39e0d4b5..bade046da5a1 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1538,11 +1538,133 @@ static int tdx_get_quote_user(struct kvm_vcpu *vcpu, u64 gpa, u64 size)
 	return 0;
 }
 
+static bool write_quote_status_to_guest(struct kvm_vcpu *vcpu, u64 status,
+					gpa_t gpa)
+{
+	if (kvm_vcpu_write_guest(vcpu,
+				 gpa + offsetof(struct tdx_quote_req, status),
+				 &status, sizeof(status)))
+		return false;
+
+	return true;
+}
+
+static bool write_quote_to_guest(struct kvm_vcpu *vcpu, void *quote_data,
+				 u32 quote_len, gpa_t gpa)
+{
+	if (kvm_vcpu_write_guest(vcpu,
+				 gpa + TDX_QUOTE_REQ_HDR_SIZE,
+				 quote_data, quote_len))
+		return false;
+
+	if (kvm_vcpu_write_guest(vcpu,
+				 gpa + offsetof(struct tdx_quote_req, out_len),
+				 &quote_len, sizeof(quote_len)))
+		return false;
+
+	return true;
+}
+
+static u64 __get_quote_kernel(struct kvm_vcpu *vcpu, struct tdx_quote_req *req,
+			      size_t req_len, gpa_t req_gpa, size_t total_len)
+{
+	struct tdx_td *td = &to_kvm_tdx(vcpu->kvm)->td;
+
+	/* Only support version 1 as defined in the GHCI spec */
+	if (req->version != 1)
+		return TDX_QUOTE_STATUS_ERROR;
+
+	if ((size_t)req->in_len + TDX_QUOTE_REQ_HDR_SIZE > req_len)
+		return TDX_QUOTE_STATUS_ERROR;
+
+	/* The caller frees the quote data */
+	void *quote_data __free(kvfree) =
+		tdx_quote_generate(td, req->data, req->in_len, &req->out_len);
+
+	if (!quote_data)
+		return TDX_QUOTE_STATUS_UNAVAILABLE;
+
+	if ((size_t)req->out_len + TDX_QUOTE_REQ_HDR_SIZE > total_len)
+		return TDX_QUOTE_STATUS_ERROR;
+
+	if (!write_quote_to_guest(vcpu, quote_data, req->out_len, req_gpa))
+		return TDX_QUOTE_STATUS_ERROR;
+
+	return TDX_QUOTE_STATUS_SUCCESS;
+}
+
+static u64 tdx_get_quote_check_args(struct kvm_vcpu *vcpu, u64 gpa, u64 size)
+{
+	gfn_t gfn_start, gfn_end;
+	u64 end;
+
+	if (!size)
+		return TDVMCALL_STATUS_INVALID_OPERAND;
+
+	if (!PAGE_ALIGNED(gpa) || !PAGE_ALIGNED(size))
+		return TDVMCALL_STATUS_ALIGN_ERROR;
+
+	if (check_add_overflow(gpa, size, &end))
+		return TDVMCALL_STATUS_INVALID_OPERAND;
+
+	gfn_start = gpa_to_gfn(gpa);
+	gfn_end = gpa_to_gfn(end);
+
+	/*
+	 * Reject if the guest didn't explicitly convert its quote pages to
+	 * shared.
+	 */
+	if (!kvm_range_has_memory_attributes(vcpu->kvm, gfn_start, gfn_end,
+					     KVM_MEMORY_ATTRIBUTE_PRIVATE, 0))
+		return TDVMCALL_STATUS_INVALID_OPERAND;
+
+	return TDVMCALL_STATUS_SUCCESS;
+}
+
+static int tdx_get_quote_kernel(struct kvm_vcpu *vcpu, u64 gpa, u64 size)
+{
+	void *first_page = NULL;
+	u64 err, qerr;
+
+	err = tdx_get_quote_check_args(vcpu, gpa, size);
+	if (err != TDVMCALL_STATUS_SUCCESS)
+		goto out;
+
+	err = TDVMCALL_STATUS_INVALID_OPERAND;
+
+	first_page = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!first_page)
+		goto out;
+
+	/*
+	 * Read the first GetQuote page for its header + in_data. The check
+	 * above ensures that this GetQuote message is at least one page in
+	 * size. in_data spanning more than a page is not supported.
+	 */
+	if (kvm_vcpu_read_guest(vcpu, gpa, first_page, PAGE_SIZE))
+		goto out;
+
+	qerr = __get_quote_kernel(vcpu, first_page, PAGE_SIZE,
+				  (gpa_t)gpa, size);
+
+	if (write_quote_status_to_guest(vcpu, qerr, (gpa_t)gpa) &&
+	    qerr == TDX_QUOTE_STATUS_SUCCESS)
+		err = TDVMCALL_STATUS_SUCCESS;
+
+out:
+	kfree(first_page);
+	tdvmcall_set_return_code(vcpu, err);
+
+	return 1;
+}
+
 static int tdx_get_quote(struct kvm_vcpu *vcpu)
 {
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(vcpu->kvm);
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	u64 gpa = tdx->vp_enter_args.r12;
 	u64 size = tdx->vp_enter_args.r13;
+	int ret;
 
 	/* The gpa of buffer must have shared bit set. */
 	if (vt_is_tdx_private_gpa(vcpu->kvm, gpa)) {
@@ -1552,7 +1674,12 @@ static int tdx_get_quote(struct kvm_vcpu *vcpu)
 
 	gpa &= ~gfn_to_gpa(kvm_gfn_direct_bits(vcpu->kvm));
 
-	return tdx_get_quote_user(vcpu, gpa, size);
+	if (kvm_tdx->get_quote_in_kernel)
+		ret = tdx_get_quote_kernel(vcpu, gpa, size);
+	else
+		ret = tdx_get_quote_user(vcpu, gpa, size);
+
+	return ret;
 }
 
 static int tdx_setup_event_notify_interrupt(struct kvm_vcpu *vcpu)
@@ -2751,6 +2878,12 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
 	else
 		kvm->arch.gfn_direct_bits = TDX_SHARED_BIT_PWL_4;
 
+	/*
+	 * Check only once at TD creation. If the quoting service gets disrupted
+	 * during TD runtime, let the user handle it.
+	 */
+	kvm_tdx->get_quote_in_kernel = tdx_quote_enabled();
+
 	kvm_tdx->state = TD_STATE_INITIALIZED;
 out:
 	/* kfree() accepts NULL. */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 89489996fbc1..599f88a13071 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2461,6 +2461,7 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 
 	return true;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_range_has_memory_attributes);
 
 static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
 						 struct kvm_mmu_notifier_range *range)
-- 
2.25.1

