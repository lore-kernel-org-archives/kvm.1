Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195933B42F3;
	Thu, 18 Jun 2026 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772018; cv=none; b=X0bMzaCGd2i0T8+nKlzL0Cu6HZH4qO5IllClucwU4X5HAOZSaxwNDDh6wydh91BaTEzd4OT0X1kJmM7kyLWkhYz660SALRkKKbe85HQwn8Fa2ta0/1VZrsJ8914nCUNmxb3dp7dW2HnhQZWzcziZPZ2F2RAK74vKwLBooVC62Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772018; c=relaxed/simple;
	bh=mdaixLTfZt50YjRj6sqi964zIP0erz6tVjDzP/NZnrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rBaCF/pamlMq+2dlvRHc36fB+xaOZvY/J7LrDKJP4cHxMU6+gqS81gm9sNaWJC3Lr7FhMR/1oVDu1UdpGJpxQR7w2EbS5MGpoIfDFfwgOjSiZUE+2JcabViXryyU97aVWrDYblC/gxFM4nlshkzIBQN1e2w2aDuXv9qzR9vGmF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+nO0e86; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+nO0e86"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781772017; x=1813308017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mdaixLTfZt50YjRj6sqi964zIP0erz6tVjDzP/NZnrM=;
  b=L+nO0e86AKkYVVIGAoCtbcPOo2LIEBV0Zpsw3x5xnRTTQojirdt3Zqqh
   bNoML2tJOau2uCVS9NKPwoVPr8cFGmYxNeNX9zBiznag0U09F1jAqZyNu
   dsXTDxdmVkkCOyvY7Ql+ZWQL4NKZWQ6CFbY0z7R09llArHuYvhglbfbSe
   84kkwiCjdNMKIhzbG3R8rZAUN1VOUA5soB8BZsvgbMXSKWytwFU9fOKh/
   cj90KqYtYQj6pGPEmlHs7GIUGvPApqQBNeNfQNOeX0UDfi+YY1rfv2Urv
   jChmGe64bM3w1Efp2K/6JT7s9VRDtpDIkLvHrA/egnlrHdfJmOYvTWweL
   g==;
X-CSE-ConnectionGUID: zLzaE719R0u4OPryGZrh7w==
X-CSE-MsgGUID: ruVc3M0UQqip2pOBOXpEWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584841"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584841"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:40:17 -0700
X-CSE-ConnectionGUID: IjR0WJxsQE+HbuZsW7Q8Rw==
X-CSE-MsgGUID: K+4HkavYRDOlkj6R0dmAfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392521"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:40:12 -0700
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
Subject: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Date: Thu, 18 Jun 2026 16:13:54 +0800
Message-Id: <20260618081355.3253581-17-yilun.xu@linux.intel.com>
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

Provide an in-kernel path for Quote generation when handling
TDG.VP.VMCALL<GetQuote>, without requiring an exit to userspace.

Use the core TDX API for Quote generation when the Quoting extension is
available. For simplicity, KVM checks its availability once per guest
during initialization. KVM does not handle Quoting service disruptions
or switch between the in-kernel and userspace paths.

Update the KVM API and TDX documentation to describe this new Quoting
capability.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 Documentation/arch/x86/tdx.rst |  19 ++---
 Documentation/virt/kvm/api.rst |   3 +
 arch/x86/include/asm/tdx.h     |   9 +++
 arch/x86/kvm/vmx/tdx.h         |   6 ++
 arch/x86/kvm/vmx/tdx.c         | 135 ++++++++++++++++++++++++++++++++-
 virt/kvm/kvm_main.c            |   1 +
 6 files changed, 163 insertions(+), 10 deletions(-)

diff --git a/Documentation/arch/x86/tdx.rst b/Documentation/arch/x86/tdx.rst
index 3303499ad4c6..f02bb6919d91 100644
--- a/Documentation/arch/x86/tdx.rst
+++ b/Documentation/arch/x86/tdx.rst
@@ -522,15 +522,16 @@ provided by attestation service so the TDREPORT can be verified uniquely.
 More details about the TDREPORT can be found in Intel TDX Module
 specification, section titled "TDG.MR.REPORT Leaf".
 
-After getting the TDREPORT, the second step of the attestation process
-is to send it to the Quoting Enclave (QE) to generate the Quote. TDREPORT
-by design can only be verified on the local platform as the MAC key is
-bound to the platform. To support remote verification of the TDREPORT,
-TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT locally
-and convert it to a remotely verifiable Quote. Method of sending TDREPORT
-to QE is implementation specific. Attestation software can choose
-whatever communication channel available (i.e. vsock or TCP/IP) to
-send the TDREPORT to QE and receive the Quote.
+After getting the TDREPORT, the second step of the attestation process is to
+convert it to a Quote. A TDREPORT by design can only be verified on the local
+platform, as the MAC key is bound to the platform. A Quote makes the TDREPORT
+remotely verifiable. It can be generated either through a Quoting Enclave
+(QE) in userspace or through the Quoting service in kernel space. In
+userspace, the Intel SGX Quoting Enclave verifies the TDREPORT locally and
+converts it to a Quote. The method of sending the TDREPORT to the QE and
+receiving the Quote is implementation-specific. If the TDX module supports the
+Quoting service, the kernel can convert a TDREPORT to a Quote directly through
+a SEAMCALL. In this case, the Quote is generated entirely by the TDX module.
 
 References
 ==========
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..4a3b69b2e602 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7335,6 +7335,9 @@ inputs and outputs of the TDVMCALL.  Currently the following values of
    queued successfully, the TDX guest can poll the status field in the
    shared-memory area to check whether the Quote generation is completed or
    not. When completed, the generated Quote is returned via the same buffer.
+   If the host kernel generates Quotes through the Quoting service provided by
+   the TDX module, KVM processes the GetQuote request and it will not appear in
+   userspace.
 
  * ``TDVMCALL_GET_TD_VM_CALL_INFO``: the guest has requested the support
    status of TDVMCALLs.  The output values for the given leaf should be
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 24bce7512de3..b9a24104415c 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -86,6 +86,15 @@ struct tdx_quote_req {
 	u8 data[];
 };
 
+#define TDX_QUOTE_REQ_HDR_SIZE		(offsetof(struct tdx_quote_req, data))
+
+/*
+ * TDG.VP.VMCALL<GetQuote> Status Codes
+ */
+#define TDX_QUOTE_STATUS_SUCCESS	0x0000000000000000ULL
+#define TDX_QUOTE_STATUS_ERROR		0x8000000000000000ULL
+#define TDX_QUOTE_STATUS_UNAVAILABLE	0x8000000000000001ULL
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 void __init tdx_early_init(void);
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index ac8323a68b16..5e4b3aee0577 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -47,6 +47,12 @@ struct kvm_tdx {
 	 * Set/unset is protected with kvm->mmu_lock.
 	 */
 	bool wait_for_sept_zap;
+
+	/*
+	 * Whether to get the quote directly in kernel, without exiting to
+	 * userspace.
+	 */
+	bool get_quote_in_kernel;
 };
 
 /* TDX module vCPU states */
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 9f7c39e0d4b5..20558b0185b6 100644
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
+static u64 get_quote_kernel(struct kvm_vcpu *vcpu, struct tdx_quote_req *req,
+			    gpa_t req_gpa, size_t total_len)
+{
+	struct tdx_td *td = &to_kvm_tdx(vcpu->kvm)->td;
+
+	/* Only support version 1 as defined in the GHCI spec */
+	if (req->version != 1)
+		return TDX_QUOTE_STATUS_ERROR;
+
+	/* Header + input data must fit in the page read from guest memory */
+	if ((size_t)req->in_len + TDX_QUOTE_REQ_HDR_SIZE > PAGE_SIZE)
+		return TDX_QUOTE_STATUS_ERROR;
+
+	/* Caller owns the requested quote */
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
+	 * Read the first GetQuote page for its header + input data. The check
+	 * above ensures that this GetQuote message is at least one page in
+	 * size. in_data spanning more than a page is not supported.
+	 */
+	if (kvm_vcpu_read_guest(vcpu, gpa, first_page, PAGE_SIZE))
+		goto out;
+
+	qerr = get_quote_kernel(vcpu, first_page, (gpa_t)gpa, size);
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
+	 * Check only once at TD creation. Switching between userspace and
+	 * in-kernel quoting is not supported.
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

