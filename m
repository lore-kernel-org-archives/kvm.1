Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E08427FB1
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799868; cv=none; b=I/U2H43gT70ZgYR8Ve2a8/Az62PxTGeYzhu9Tali9Dol/e4d3G2cnw60easouwiyQfCMBz1+ROaqXaLZxhiNsVVPRvcNzULuOVN61/TcfkCV+T9ctlCDmLsv7Ins+2QicwsEzQALvf61y280+Bozf9PGTevKOwaO9zq4pnbS5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799868; c=relaxed/simple;
	bh=8LcfHWlPiRLeBmOzU9vGGv4EbjPyHeH3olbOBNC2Kx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lIYERtKNnPRvKPoHEYIBckASja/ScAYcmsJIkW16F0inTQcaeZZEkrMvLZjtz5FuBrXK/W7GU/eb9EyyW+BKb7ef2vmlf/cameWhnO0MAa8+DAuuP+DCfBPc6MQPdhT4WscjFPHR57wPBb8gPQTTejTH0Ky2HUopen6T9xmPqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5zBVM/1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k7Z3m8nb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5zBVM/1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k7Z3m8nb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784799865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tD9r13MXqpkctapd3kVKw58/yj0JDaoTRqy5Ai0sP+c=;
	b=P5zBVM/1gHG1vSXMKrAp6TzivQ+k3yKVIdhyF5ikeag0nt/NXWVDMb0D6UeWtyK3ZByoZW
	7CNI1SDuSnuKs4az6uHYmhPYuhoLbL+Vaz3Ll2gbZxpo2gTyJxobOVqBLKL5N6+SOECXym
	hjSTdkEAcli5prS32JlBBcHu0X6szYU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-u4hVf2rGMUqU_dMnN6krpw-1; Thu, 23 Jul 2026 05:44:23 -0400
X-MC-Unique: u4hVf2rGMUqU_dMnN6krpw-1
X-Mimecast-MFC-AGG-ID: u4hVf2rGMUqU_dMnN6krpw_1784799862
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so461210f8f.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784799862; x=1785404662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tD9r13MXqpkctapd3kVKw58/yj0JDaoTRqy5Ai0sP+c=;
        b=k7Z3m8nbcXdWjG785v86xAH7y5kNFPqozIM2mJ38d6xO5UOr9jZooIwYTFMf2Ut3x2
         2cM4WDQW/s6r5mEeEo4BgaY1LiMhooQccc8DjAtr6Wqrm2nO+kXdWhyLsXx/bNPVa6jg
         maIs0/KveURDZPr1F/LV/zDhKEqSU/DKUH1ydNkb1TCJkUZ3r5y0ZfKEschXgORDIaHL
         y843Qa4UEzvbSP26QfiMtaVu3HclekmeBBzSsr2R5M1LPRHRrdhNrXDGwMm3P0E5X3Gb
         f253X7hW6qYUhoc8RPvSsywX0P+5k/OtisvALAleQo06CvlAvFzFzyDbKH/EVSND+Fbv
         O3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784799862; x=1785404662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tD9r13MXqpkctapd3kVKw58/yj0JDaoTRqy5Ai0sP+c=;
        b=qSa34uUc5h83K0VlEQ12bZRKPSm9S1uTZaI5Wt9hJ7jKi8mI1LxmA/QFhXanUHTzJ8
         84bU2VrpIzsXCLxe/KAsmMd47oIlQr40UUmMqLtVQ3Bvh8k1+yB8gtQgl9UQmERm0kHV
         DYzXp11dNuJaNODYSPScM3h0OzKjXpAGx3SBOBS+xBfpJLL2/eLFcroHgspX1vPgZCV0
         79yFMAxIiuquEyDFUOFPjd3Wh9yLWuq0Spmxl+Xz0Mz78aOWNBUZOrcX5NH4tFbLB5L7
         aUlHadKh85IFBjKLHAGOL1hCfbeJ8U4UrSaM7aAmJMU+UNgtgEdOZ9UYsCkiGuGcfsoj
         CR7A==
X-Forwarded-Encrypted: i=1; AHgh+Ro9FFjJ/m0FoiVHiINmUMLugkxfMfoNhPGcLCeULuLxsY2ieOo3B6RNPHozCj887UFOz64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSb046ejaZN92baiEtNEnQuMF9EIbMNTN57qmEFQqjcGLmZa5/
	XY4lBi2tk3pINVggtgRFB59i3oXT9yJQ6QB6z08fk+AL9QIki3O2LX1VxZ2cbbviWDq3uSUctiZ
	CI+BFQ4V7SOUAWJvvGJDxjH2WDqGFhNvfks55DPfrg3iwfZtYzbb4Wg==
X-Gm-Gg: AR+sD13jNfly+TMmMyfTdvCcb/2+Q7npIhSR1gvXbFCqIoUUkLT90UMQZNcV4FtMvAY
	baUCtCn7hQNlDRn29+OjfcVhsLkrLCHcKtL+pqrd/+qgq0vDVo+CLj7XcExQPT663B4Ke1i+xqr
	zsqjGBIkNMBFaheWJKfZgnEabQ9dFt7ezOL1CvW+VJCIUBRa3ZZwd2frsHSJbJJu/nqJ5CtEkB2
	kHSbgiF8bnsJwBJ9pUxgU4N/Tz//8h5b5k8O3czkX/OtSQWxA7KtoeIbHwVkCYqkJhmO05/KWjO
	4YZBzB2YrZyBrSCt2B3CWNXWPkZ1Q4txZ2ftOlSIr8rM+CgauaQUKWWxcNSbHtgkkQWuYCLmwtd
	ZJHw7Fhtt1pb3e8B2It/3nspJR+THOix+sCYIe4SttLq2vVsBSdcLC0rqbTgLmNT09g==
X-Received: by 2002:a05:6000:27d3:b0:47f:9266:9bde with SMTP id ffacd0b85a97d-47f9266a0b3mr754363f8f.4.1784799861864;
        Thu, 23 Jul 2026 02:44:21 -0700 (PDT)
X-Received: by 2002:a05:6000:27d3:b0:47f:9266:9bde with SMTP id ffacd0b85a97d-47f9266a0b3mr754332f8f.4.1784799861338;
        Thu, 23 Jul 2026 02:44:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bdac28sm13099297f8f.16.2026.07.23.02.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:44:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
	Alexander Lougovski <alougovsk@redhat.com>
Subject: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if NPT enabled
Date: Thu, 23 Jul 2026 11:44:19 +0200
Message-ID: <20260723094419.630204-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Red Hat is seeing multiple reports of Windows memory corruptions
(and consequent BSODs) with hv-tlbflush=on, on AMD processors only.
The crashes, while extremely rare, happen even with a stock configuration,
but with Driver Verifier enabled they can be detected after approximately
200 VM hours.  In particular, Alexander Lougovski measured the following:

- on AMD Turin, 15 crashes in 3300 VM hours

- on AMD Milan, 2 crashes in 500 VM hours (there are fewer hours
  here due to the host being smaller)

- on Intel Sapphire Rapids, 0 crashes in 8000 VM hours

- on AMD Turin with full TLB flush (not exactly this patch but
  similar), no crashes in ~2 weeks of run time which should also
  be ~7000 VM hours

For Turin, the microcode version was 0x0b002162, which (assuming
this is the same issue) should not be affected by the problem listed in
https://knowledge.broadcom.com/external/article/419026/bsod-on-virtual-machines-running-on-amd.html;
on the other hand that problem should not apply to earlier processors.
AMD has not provided any information or analysis yet, and when we asked
we didn't know yet that it reproduced on Milan as well.

As to the workload, Alexander threw more or less everything at the same
time at the VM:

- a full Windows Defender scan every 30 minutes

- a disk I/O job

- a loop doing repeated mmap of system files (mostly to hope that
  it triggers some consistency check in the Windows memory manager)

- SQL Express 2022 + StressDB (1.6M rows), with the host doing queries
  (75% write/25% read) via sqlcmd

Driver Verifier is able to detect BSODs more or less at the same time as
the pages are freed.  They mostly happen in the Windows Defender filter
driver, but occasionally also in the networking stack (e.g., afd.sys)
or elsewhere in the filesystem stack (e.g., fltmgr.sys).

The flush is issued from kvm_hv_vcpu_flush_tlb(), which receives the
cross-CPU requests from the Hyper-V TLB flush hypercalls via a kfifo
and is invoked by the KVM_REQ_HV_TLB_FLUSH request.  The mechanism is
the same for both Intel and AMD, and the handler for both vendors is
a simple INVVPID(ADDR)/INVLPGA instruction.

Because the request is handled on the destination CPU, there is a question
of what happens if the VM is migrated across physical CPUs.  In that case,
the INVLPGA instruction would use a stale svm->vmcb->control.asid; but
if anything that might do an *unnecessary* flush (on an asid that's being
used for another VM) and then pre_svm_run() would force a full TLB rebuild.

So, for lack of better ideas, this patch forces a full ASID bump in
svm_flush_tlb_gva().  To avoid paying the price on Intel and also to
avoid unnecessary loops on AMD, the flush_tlb_gva op now returns whether
it did a full flush or not; kvm_hv_vcpu_flush_tlb() takes note and exits
its loops immediately.  While there is an obvious performance impact,
about half of the benefit from Hyper-V tlbflush is preserved (10% vs. 20%
on the SQL Server workload).

kvm_mmu_invalidate_addr() is the only other caller of the flush_tlb_gva op.
The change would have a performance impact on every intercepted INVLPG and,
for nested SVM, on every L1 INVLPGA.  For INVLPGA specifically, this covers
the same suspected issue but for nested hypervisors, so it is correct to
apply the workaround; for INVLPG on shadow paging, instead, the impact
would be stronger and, due to lack of data, for now the use of INVLPGA is
left in place in svm_flush_tlb_gva().

Analyzed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Analyzed-by: Alexander Lougovski <alougovsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/hyperv.c           |  7 ++++---
 arch/x86/kvm/mmu/mmu.c          |  2 +-
 arch/x86/kvm/svm/svm.c          | 27 ++++++++++++++++++++-------
 arch/x86/kvm/vmx/main.c         |  4 ++--
 arch/x86/kvm/vmx/vmx.c          |  2 +-
 arch/x86/kvm/vmx/x86_ops.h      |  2 +-
 7 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b517257a6315..eca04d4b974e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1751,7 +1751,7 @@ struct kvm_x86_ops {
 	 * Can potentially get non-canonical addresses through INVLPGs, which
 	 * the implementation may choose to ignore if appropriate.
 	 */
-	void (*flush_tlb_gva)(struct kvm_vcpu *vcpu, gva_t addr);
+	void (*flush_tlb_gva)(struct kvm_vcpu *vcpu, gva_t addr, bool *full);
 
 	/*
 	 * Flush any TLB entries created by the guest.  Like tlb_flush_gva(),
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 1ee0d23f8949..5ec1bf28a195 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1974,6 +1974,7 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 	u64 entries[KVM_HV_TLB_FLUSH_FIFO_SIZE];
 	int i, j, count;
 	gva_t gva;
+	bool full = false;
 
 	if (!tdp_enabled || !hv_vcpu)
 		return -EINVAL;
@@ -1982,7 +1983,7 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 
 	count = kfifo_out(&tlb_flush_fifo->entries, entries, KVM_HV_TLB_FLUSH_FIFO_SIZE);
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < count && !full; i++) {
 		if (entries[i] == KVM_HV_TLB_FLUSHALL_ENTRY)
 			goto out_flush_all;
 
@@ -1991,11 +1992,11 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 		 * pages to flush.
 		 */
 		gva = entries[i] & PAGE_MASK;
-		for (j = 0; j < (entries[i] & ~PAGE_MASK) + 1; j++) {
+		for (j = 0; j < (entries[i] & ~PAGE_MASK) + 1 && !full; j++) {
 			if (is_noncanonical_invlpg_address(gva + j * PAGE_SIZE, vcpu))
 				continue;
 
-			kvm_x86_call(flush_tlb_gva)(vcpu, gva + j * PAGE_SIZE);
+			kvm_x86_call(flush_tlb_gva)(vcpu, gva + j * PAGE_SIZE, &full);
 		}
 
 		++vcpu->stat.tlb_flush;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6c13da942bfc..bea5499fc9f1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6672,7 +6672,7 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 		if (is_noncanonical_invlpg_address(addr, vcpu))
 			return;
 
-		kvm_x86_call(flush_tlb_gva)(vcpu, addr);
+		kvm_x86_call(flush_tlb_gva)(vcpu, addr, NULL);
 
 		if (tdp_enabled)
 			return;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f..0bd63970305b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4222,13 +4222,6 @@ static void svm_flush_tlb_all(struct kvm_vcpu *vcpu)
 	svm_flush_tlb_asid(vcpu);
 }
 
-static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
-{
-	struct vcpu_svm *svm = to_svm(vcpu);
-
-	invlpga(gva, svm->vmcb->control.asid);
-}
-
 static void svm_flush_tlb_guest(struct kvm_vcpu *vcpu)
 {
 	kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS);
@@ -4236,6 +4229,26 @@ static void svm_flush_tlb_guest(struct kvm_vcpu *vcpu)
 	svm_flush_tlb_asid(vcpu);
 }
 
+static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva, bool *full)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	/*
+	 * INVLPGA has had errata on Genoa and Turin, and even on older
+	 * generations there were reports of Windows BSODs if INVLPGA
+	 * was used for Hyper-V tlbflush.  Use it only for shadow paging
+	 * where it seems to be okay.
+	 */
+	if (!npt_enabled) {
+		invlpga(gva, svm->vmcb->control.asid);
+		return;
+	}
+
+	svm_flush_tlb_guest(vcpu);
+	if (full)
+		*full = true;
+}
+
 static inline void sync_cr8_to_lapic(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 83d9921277ea..f204a0fc0a57 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -535,12 +535,12 @@ static void vt_flush_tlb_current(struct kvm_vcpu *vcpu)
 	vmx_flush_tlb_current(vcpu);
 }
 
-static void vt_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
+static void vt_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr, bool *full)
 {
 	if (is_td_vcpu(vcpu))
 		return;
 
-	vmx_flush_tlb_gva(vcpu, addr);
+	vmx_flush_tlb_gva(vcpu, addr, full);
 }
 
 static void vt_flush_tlb_guest(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3681d565f177..e27084d30a5e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3374,7 +3374,7 @@ void vmx_flush_tlb_current(struct kvm_vcpu *vcpu)
 		vpid_sync_context(vmx_get_current_vpid(vcpu));
 }
 
-void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
+void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr, bool *full)
 {
 	/*
 	 * vpid_sync_vcpu_addr() is a nop if vpid==0, see the comment in
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 409858074246..17595d52985c 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -82,7 +82,7 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 bool vmx_get_if_flag(struct kvm_vcpu *vcpu);
 void vmx_flush_tlb_all(struct kvm_vcpu *vcpu);
 void vmx_flush_tlb_current(struct kvm_vcpu *vcpu);
-void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr);
+void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr, bool *full);
 void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu);
 void vmx_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask);
 u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu);
-- 
2.55.0

