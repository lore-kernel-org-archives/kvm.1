Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641526;
	b=CUy0m7HF4SPZC8nL5bA9YkdOD9ldmf4h5d/0Kp1JZW6PYD/I6AU42dPHoWZeYMTwpxxP
	 L9ooRaUwnIHUVf6azkVhQSS8uTEqDcVGI7b1qSYG2iDHATSiVk+aOfcDpLfpOBTIBlUZj
	 c1QRZUp+P9n9z8wwJ3SIxmSIosXVvKl6C8JFm05UFGolUMeNpOdc4Jt6GC0FglcW4WOp9
	 3sLJdkaGjPYyDacl15CqRkUtuAsU6EWiiwKZF5CbrLw0hqcpqlDkMA7gZRMlx/KALgcbu
	 P+ZhS5oO9Wl+SSF3XV9EUdD3i2bwZ0NGbAxrOoEY6UqzR3MRQE9BdfxCTRSkdLqNuFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641526;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=B579Los3X6jd4fFI7dhDpIjk2BN3Xl2eix631IvbZT0=;
	b=dflpcfG2uK52yX0dtmIUPypOpe88qLgzgdAzaDW9cqggTbJ2xB+pAq/EBdxuk5ilv1sw
	 H161R537wgEufvmaGXrCcWYijp/EDW5VMbJek6taLaS8c7OkVP1Cvttl8TTDvKlqwd2l6
	 yVqmPqznsPej0w0LfFMR48qKAukIpafMND2G95Tt5n405vlQRAR4UpSOn6uldT3+JnPUx
	 6jCJJQcRaG4Gp7VDa/cIpuSM13YzCVFX3tSi3ODm48718sJi+BvsyzTVgxu0JIuQ6Dm7P
	 DtycewPlrs9kdljc5kGfWDBPsROx8/IoHfMmNayYQD1grKqY10R9xrYxNR+j9i3HTIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Chr0i5v1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997160A3807
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2997160A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Chr0i5v1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B579Los3X6jd4fFI7dhDpIjk2BN3Xl2eix631IvbZT0=;
	b=Chr0i5v14St/t83/MGB6XnsxY4LnKReYlu7uE8K+2YElktyXKHE7wVKENUsKOTF8VzcJfl
	BNlX3bW+3qCrxN5ajumAJqNrQdgPvUUPKl2yUPm8zNO3z/+7+27M1BLAaPLQknT82+udwO
	19LNPDMahWq6pTC+wSrSrDsSuZvglAA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-_QnT7bVoNpqqWDsRqX21pw-1; Mon,
 02 Nov 2026 12:45:23 -0500
X-MC-Unique: _QnT7bVoNpqqWDsRqX21pw-1
X-Mimecast-MFC-AGG-ID: _QnT7bVoNpqqWDsRqX21pw_1793641522
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FC7A195604C;
	Mon,  2 Nov 2026 17:45:22 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D2EF433;
	Mon,  2 Nov 2026 17:45:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 30/45] KVM: x86/emulate: Propagate memory faults to userspace
Date: Mon,  2 Nov 2026 12:44:57 -0500
Message-ID: <20261102174512.8903-14-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Full handling of memory faults is not really possible with KVM's
architecture, short of adding something like a journal to complex
operations like task switches or SMM enter/leave.  However, KVM
also should at least try to propagate faults to userspace, as an
emulation failure if it is not possible to return them as -EFAULT.

Introduce new return values for both the emulator ops
(X86EMUL_MEMORY_FAULT) and emulate.c (EMULATION_MEMORY_FAULT), and
plumb them through the entire call chain.  Terminate them with
-EFAULT as a best effort.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/emulate.c     | 24 ++++++++++++++--
 arch/x86/kvm/kvm_emulate.h |  3 ++
 arch/x86/kvm/svm/svm.c     |  6 +++-
 arch/x86/kvm/vmx/sgx.c     |  4 ++-
 arch/x86/kvm/vmx/vmx.c     | 22 +++++++++------
 arch/x86/kvm/x86.c         | 56 ++++++++++++++++++++++++++------------
 include/linux/kvm_host.h   |  3 ++
 virt/kvm/kvm_main.c        | 24 ++++++++++++++++
 8 files changed, 111 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8464816349b5..93596cf6aa3d 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2555,11 +2555,15 @@ static int emulator_io_port_access_allowed(struct x86_emulate_ctxt *ctxt,
 	base |= ((u64)base3) << 32;
 #endif
 	r = ops->read_std(ctxt, base + 102, &io_bitmap_ptr, 2, NULL, true);
+	if (r == X86EMUL_MEMORY_FAULT)
+		return r;
 	if (r != X86EMUL_CONTINUE)
 		return -EACCES;
 	if (io_bitmap_ptr + port/8 > desc_limit_scaled(&tr_seg))
 		return -EACCES;
 	r = ops->read_std(ctxt, base + io_bitmap_ptr + port/8, &perm, 2, NULL, true);
+	if (r == X86EMUL_MEMORY_FAULT)
+		return r;
 	if (r != X86EMUL_CONTINUE)
 		return -EACCES;
 	if ((perm >> bit_idx) & mask)
@@ -2758,7 +2762,10 @@ static int load_state_from_tss32(struct x86_emulate_ctxt *ctxt,
 	int ret;
 	u8 cpl;
 
-	if (ctxt->ops->set_cr(ctxt, 3, tss->cr3))
+	ret = ctxt->ops->set_cr(ctxt, 3, tss->cr3);
+	if (ret == X86EMUL_MEMORY_FAULT)
+		return ret;
+	if (ret)
 		return emulate_gp(ctxt, 0);
 	ctxt->_eip = tss->eip;
 	ctxt->eflags = tss->eflags | 2;
@@ -2993,6 +3000,8 @@ int emulator_task_switch(struct x86_emulate_ctxt *ctxt,
 		ctxt->eip = ctxt->_eip;
 		writeback_registers(ctxt);
 	}
+	if (rc == X86EMUL_MEMORY_FAULT)
+		return EMULATION_MEMORY_FAULT;
 
 	return (rc == X86EMUL_UNHANDLEABLE) ? EMULATION_FAILED : EMULATION_OK;
 }
@@ -3260,7 +3269,10 @@ static int em_cr_write(struct x86_emulate_ctxt *ctxt)
 	int cr_num = ctxt->modrm_reg;
 	int r;
 
-	if (ctxt->ops->set_cr(ctxt, cr_num, ctxt->src.val))
+	r = ctxt->ops->set_cr(ctxt, cr_num, ctxt->src.val);
+	if (r == X86EMUL_MEMORY_FAULT)
+		return r;
+	if (r)
 		return emulate_gp(ctxt, 0);
 
 	/* Disable writeback. */
@@ -3939,6 +3951,8 @@ static int check_perm_in(struct x86_emulate_ctxt *ctxt)
 
 	ctxt->dst.bytes = min(ctxt->dst.bytes, 4u);
 	r = emulator_io_permitted(ctxt, ctxt->src.val, ctxt->dst.bytes);
+	if (r == X86EMUL_MEMORY_FAULT)
+		return r;
 	if (r)
 		return emulate_gp(ctxt, 0);
 
@@ -3951,6 +3965,8 @@ static int check_perm_out(struct x86_emulate_ctxt *ctxt)
 
 	ctxt->src.bytes = min(ctxt->src.bytes, 4u);
 	r = emulator_io_permitted(ctxt, ctxt->dst.val, ctxt->src.bytes);
+	if (r == X86EMUL_MEMORY_FAULT)
+		return r;
 	if (r)
 		return emulate_gp(ctxt, 0);
 
@@ -5219,6 +5235,8 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
 done:
 	if (rc == X86EMUL_PROPAGATE_FAULT)
 		ctxt->have_exception = true;
+	if (rc == X86EMUL_MEMORY_FAULT)
+		return EMULATION_MEMORY_FAULT;
 	return (rc != X86EMUL_CONTINUE) ? EMULATION_FAILED : EMULATION_OK;
 }
 
@@ -5579,6 +5597,8 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts)
 		ctxt->eip = (u32)ctxt->_eip;
 
 done:
+	if (rc == X86EMUL_MEMORY_FAULT)
+		return EMULATION_MEMORY_FAULT;
 	if (rc == X86EMUL_PROPAGATE_FAULT) {
 		if (KVM_EMULATOR_BUG_ON(ctxt->exception.vector > 0x1f, ctxt))
 			return EMULATION_FAILED;
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 10886bea82c9..488738794bb6 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -97,6 +97,8 @@ struct x86_instruction_info {
 #define X86EMUL_INTERCEPTED     6 /* Intercepted by nested VMCB/VMCS */
 /* Emulation during event vectoring is unhandleable. */
 #define X86EMUL_UNHANDLEABLE_VECTORING	7
+/* Terminate emulation and return a memory fault to userspace. */
+#define X86EMUL_MEMORY_FAULT	8
 
 /* x86-specific emulation flags */
 #define X86EMUL_F_WRITE			BIT(0)
@@ -532,6 +534,7 @@ bool x86_page_table_writing_insn(struct x86_emulate_ctxt *ctxt);
 #define EMULATION_OK 0
 #define EMULATION_RESTART 1
 #define EMULATION_INTERCEPTED 2
+#define EMULATION_MEMORY_FAULT 3
 void init_decode_cache(struct x86_emulate_ctxt *ctxt);
 int x86_emulate_insn(struct x86_emulate_ctxt *ctxt, bool check_intercepts);
 int emulator_task_switch(struct x86_emulate_ctxt *ctxt,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 487897ef11dd..205d8783aa13 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2363,13 +2363,17 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 error_code = svm->vmcb->control.exit_info_1;
 	u64 svm_exit_code;
+	int r;
 
 	/* Both #GP cases have zero error_code */
 	if (error_code)
 		goto reinject;
 
 	/* Decode the instruction for usage later */
-	if (x86_decode_emulated_instruction(vcpu, 0, NULL, 0) != EMULATION_OK)
+	r = x86_decode_emulated_instruction(vcpu, 0, NULL, 0);
+	if (r == EMULATION_MEMORY_FAULT)
+		return -EFAULT;
+	if (r != EMULATION_OK)
 		goto reinject;
 
 	/* FIXME: Handle SVM instructions through the emulator */
diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 771c75a58343..162548b97c00 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -236,7 +236,9 @@ static int handle_encls_ecreate(struct kvm_vcpu *vcpu)
 	 */
 	r = kvm_read_guest_virt(vcpu, pageinfo_gva, &pageinfo,
 				sizeof(pageinfo), &ex);
-	if (r == X86EMUL_PROPAGATE_FAULT) {
+	if (r == X86EMUL_MEMORY_FAULT) {
+		return -EFAULT;
+	} else if (r == X86EMUL_PROPAGATE_FAULT) {
 		kvm_inject_emulated_page_fault(vcpu, &ex);
 		return 1;
 	} else if (r != X86EMUL_CONTINUE) {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fe43718b751b..80dfb3c6268b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5342,19 +5342,21 @@ static bool rmode_exception(struct kvm_vcpu *vcpu, int vec)
 static int handle_rmode_exception(struct kvm_vcpu *vcpu,
 				  int vec, u32 err_code)
 {
+	int r;
+
 	/*
 	 * Instruction with address size override prefix opcode 0x67
 	 * Cause the #SS fault with 0 error code in VM86 mode.
 	 */
 	if (((vec == GP_VECTOR) || (vec == SS_VECTOR)) && err_code == 0) {
-		if (kvm_emulate_instruction(vcpu, 0)) {
-			if (vcpu->arch.halt_request) {
-				vcpu->arch.halt_request = 0;
-				return kvm_emulate_halt_noskip(vcpu);
-			}
-			return 1;
+		r = kvm_emulate_instruction(vcpu, 0);
+		if (r <= 0)
+			return r;
+		if (vcpu->arch.halt_request) {
+			vcpu->arch.halt_request = 0;
+			return kvm_emulate_halt_noskip(vcpu);
 		}
-		return 0;
+		return 1;
 	}
 
 	/*
@@ -6080,6 +6082,7 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	bool intr_window_requested;
 	unsigned count = 130;
+	int r;
 
 	intr_window_requested = exec_controls_get(vmx) &
 				CPU_BASED_INTR_WINDOW_EXITING;
@@ -6098,8 +6101,9 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 		 */
 		smp_rmb();
 
-		if (!kvm_emulate_instruction(vcpu, 0))
-			return 0;
+		r = kvm_emulate_instruction(vcpu, 0);
+		if (r <= 0)
+			return r;
 
 		if (vmx_unhandleable_emulation_required(vcpu)) {
 			kvm_prepare_emulation_failure_exit(vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index caff8534267d..5f7f87ff4d17 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4865,7 +4865,6 @@ static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 {
 	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 	void *data = val;
-	int r = X86EMUL_CONTINUE;
 
 	while (bytes) {
 		gpa_t gpa = gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access, exception);
@@ -4878,16 +4877,16 @@ static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 		ret = kvm_vcpu_read_guest_page(vcpu, gpa >> PAGE_SHIFT, data,
 					       offset, toread);
 		if (ret < 0) {
-			r = X86EMUL_IO_NEEDED;
-			goto out;
+			if (kvm_prepare_memory_fault_exit_for_range(vcpu, gpa, toread, false))
+				return X86EMUL_MEMORY_FAULT;
+			return X86EMUL_IO_NEEDED;
 		}
 
 		bytes -= toread;
 		data += toread;
 		addr += toread;
 	}
-out:
-	return r;
+	return X86EMUL_CONTINUE;
 }
 
 /* used for instruction fetching */
@@ -4912,8 +4911,16 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 		bytes = (unsigned)PAGE_SIZE - offset;
 	ret = kvm_vcpu_fetch_guest_page(vcpu, gpa >> PAGE_SHIFT, val,
 					offset, bytes);
-	if (unlikely(ret < 0))
+	if (unlikely(ret < 0)) {
+		unsigned long attrs = kvm_get_vm_memory_attributes(vcpu->kvm, gpa_to_gfn(gpa));
+
+		if (!kvm_mem_attributes_may_exec(attrs)) {
+			kvm_prepare_memory_fault_exit(vcpu, gpa & PAGE_MASK, PAGE_SIZE,
+						      false, true, false);
+			return X86EMUL_MEMORY_FAULT;
+		}
 		return X86EMUL_IO_NEEDED;
+	}
 
 	return X86EMUL_CONTINUE;
 }
@@ -4957,7 +4964,6 @@ static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes
 {
 	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 	void *data = val;
-	int r = X86EMUL_CONTINUE;
 
 	while (bytes) {
 		gpa_t gpa = gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access, exception);
@@ -4969,16 +4975,16 @@ static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes
 			return X86EMUL_PROPAGATE_FAULT;
 		ret = kvm_vcpu_write_guest(vcpu, gpa, data, towrite);
 		if (ret < 0) {
-			r = X86EMUL_IO_NEEDED;
-			goto out;
+			if (kvm_prepare_memory_fault_exit_for_range(vcpu, gpa, towrite, true))
+				return X86EMUL_MEMORY_FAULT;
+			return X86EMUL_IO_NEEDED;
 		}
 
 		bytes -= towrite;
 		data += towrite;
 		addr += towrite;
 	}
-out:
-	return r;
+	return X86EMUL_CONTINUE;
 }
 
 static int emulator_write_std(struct x86_emulate_ctxt *ctxt, gva_t addr, void *val,
@@ -5098,7 +5104,7 @@ struct read_write_emulator_ops {
 static int emulator_read_guest(struct kvm_vcpu *vcpu, gpa_t gpa,
 			       void *val, int bytes)
 {
-	return !kvm_vcpu_read_guest(vcpu, gpa, val, bytes);
+	return kvm_vcpu_read_guest(vcpu, gpa, val, bytes);
 }
 
 static int emulator_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa,
@@ -5107,10 +5113,10 @@ static int emulator_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa,
 	int ret;
 
 	ret = kvm_vcpu_write_guest(vcpu, gpa, val, bytes);
-	if (ret < 0)
-		return 0;
+	if (ret)
+		return ret;
 	kvm_page_track_write(vcpu, gpa, val, bytes);
-	return 1;
+	return 0;
 }
 
 static int emulator_read_write_onepage(unsigned long addr, void *val,
@@ -5139,6 +5145,8 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
 		ret = vcpu_is_mmio_gpa(vcpu, addr, gpa, write);
 	} else {
 		ret = vcpu_mmio_gva_to_gpa(vcpu, addr, &gpa, exception, write);
+		if (ret == -EFAULT)
+			return X86EMUL_MEMORY_FAULT;
 		if (ret < 0)
 			return X86EMUL_PROPAGATE_FAULT;
 	}
@@ -5151,8 +5159,14 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
 	 * i.e. if accessing host user memory failed, but this has been KVM's
 	 * historical ABI for decades.
 	 */
-	if (!ret && ops->read_write_guest(vcpu, gpa, val, bytes))
-		return X86EMUL_CONTINUE;
+	if (!ret) {
+		ret = ops->read_write_guest(vcpu, gpa, val, bytes);
+		if (!ret)
+			return X86EMUL_CONTINUE;
+	}
+
+	if (kvm_prepare_memory_fault_exit_for_range(vcpu, gpa, bytes, write))
+		return X86EMUL_MEMORY_FAULT;
 
 	/*
 	 * Attempt to handle emulated MMIO within the kernel, e.g. for accesses
@@ -5602,6 +5616,8 @@ static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
 		res = -1;
 	}
 
+	if (res == -EFAULT)
+		return X86EMUL_MEMORY_FAULT;
 	return res;
 }
 
@@ -6416,6 +6432,8 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 		r = x86_decode_emulated_instruction(vcpu, emulation_type,
 						    insn, insn_len);
+		if (r == EMULATION_MEMORY_FAULT)
+			return -EFAULT;
 		if (r != EMULATION_OK)  {
 			if ((emulation_type & EMULTYPE_TRAP_UD) ||
 			    (emulation_type & EMULTYPE_TRAP_UD_FORCED)) {
@@ -6528,7 +6546,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	if (r == EMULATION_INTERCEPTED)
 		return 1;
 
-	if (r == EMULATION_FAILED) {
+	if (r == EMULATION_MEMORY_FAULT || r == EMULATION_FAILED) {
 		if (kvm_unprotect_and_retry_on_failure(vcpu, cr2_or_gpa,
 						       emulation_type))
 			return 1;
@@ -9210,6 +9228,8 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
 
 	ret = emulator_task_switch(ctxt, tss_selector, idt_index, reason,
 				   has_error_code, error_code);
+	if (ret == EMULATION_MEMORY_FAULT)
+		goto unhandled_task_switch;
 
 	/*
 	 * Report an error userspace if MMIO is needed, as KVM doesn't support
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index de540af1fa24..4128cdb71869 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2641,6 +2641,9 @@ static inline u64 kvm_mem_attributes_generation(struct kvm *kvm)
 	 */
 	return smp_load_acquire(&kvm->mem_attrs.generation);
 }
+
+bool kvm_prepare_memory_fault_exit_for_range(struct kvm_vcpu *vcpu, gpa_t gpa,
+					     size_t size, bool write);
 #else
 static inline bool kvm_range_has_any_vm_memory_attributes(struct kvm *kvm,
 			gfn_t start, gfn_t end, unsigned long mask)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8283b2415adc..326bb8e144b7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2485,6 +2485,30 @@ static u64 kvm_supports_memory_protection_attr(struct kvm *kvm)
 #endif
 
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+bool kvm_prepare_memory_fault_exit_for_range(struct kvm_vcpu *vcpu, gpa_t gpa,
+					     size_t size, bool write)
+{
+	gfn_t gfn, last;
+
+	last = gpa_to_gfn(gpa + size - 1);
+	for (gfn = gpa_to_gfn(gpa); gfn <= last; gfn++) {
+		if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gfn)) {
+			kvm_prepare_memory_fault_exit(vcpu, gfn_to_gpa(gfn), PAGE_SIZE,
+						      write, false, false);
+			return true;
+		}
+
+		if (write && !kvm_mem_attributes_may_write_gfn(vcpu->kvm, gfn)) {
+			kvm_prepare_memory_fault_exit(vcpu, gfn_to_gpa(gfn), PAGE_SIZE,
+						      true, false, false);
+			return true;
+		}
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_prepare_memory_fault_exit_for_range);
+
 u64 kvm_supported_vm_mem_attributes(struct kvm *kvm)
 {
 	u64 supported_attrs = 0;
-- 
2.52.0


