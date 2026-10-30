Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394219;
	b=BrpH812PuHAzKVdKNeVm0t+clfE+np0/XX/4tDFdEOeHVbsrDpooAERgArJ201OqDsUK
	 nf+pAsTLLFeLAKkciUpUbV3Y8yjkLs1B5E82dFpEUTEHbGpCVu5RUnimrNsfLV4rdKr9P
	 f6Vv6hkrkeJ1C2IiGFwa4MVK+jcXtRuy0+fVL3q/quOgDj4pS9ruaZuhJvDHB0TSQo4dh
	 BgrNd320XhbOoz6q66ce0J1HuKaGZqaOOv9M60EyQkwdwLwT5Ua0l09XqlhGaqoeuXeH1
	 /eNdeaFTJK9CvaxAFVIoC57KQo3BsTLaIRQIe4XbMrvFYDmPoPnoCvWM9KksjNF0RMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=ewb43Uvomg/tIuEU/p7qaUSF+JjKwFlhid12RrCUYb8=;
	b=FcbEeIbIMk7Ss6JGtyhioTMIr9jKGxfAe9ly27jBSGyHDuuBxfMmNWZOQGvei5ygIfOy
	 jn+93rmwHCm63AVPzE2Gu9nnmoaaAoL1LRImkWvQxJQ1g75bR/OEJn3B/4B+5vVUbKd9a
	 04hrqaEV7qWEN9mqkjSFyzNAk/GvJEiuCUeIztAb7xBcffRi9lrxcpAlRk/ay8+Sw7oCR
	 oH6uQowi0ifZXcSntqV1ocYlDL12b32NUO36FtisWtCb0CZATbcBqgotTHtJg/odyl4a3
	 zyYPI9ExRuoZciOh2Ye8PT9OhMbFvxJ60i1zOqHznB31RuF/FWDtLlI+gOzmBpqWdTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AGwlVt10;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47822606A31E
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47822606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AGwlVt10
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e942b1cc86so12858365ad.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793394219; x=1793999019; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ewb43Uvomg/tIuEU/p7qaUSF+JjKwFlhid12RrCUYb8=;
        b=AGwlVt10Vx2c8xkECrQXp5F9nNEI8B7Wq6FEL/TNjHNLmeGnq2dgiWVVneWtMl/ONB
         X127B+0lMgHIOB0ZKJCsQs4PG7cfKZRZks/AQuS+CiaJBHrm+6PItdqRa7gKLm0VC/Dn
         0Rx1qTVwRJ1m5zFg9QTh1EQ2TNV7cMfR0wnVKe+SRfVEBspwgXSX1J4BlM94EsJtoll8
         pf9vRLwd8WYx7SKx4pXzi/hz1oYGxPUCFFCflspHu45iwnzCcgCBXA7rIzlZ6pXFkR5v
         v8QvUZnG2FSRbmVXIWWNVyRS8ZIUJYSy0bNFEdQJNUTi4NcmlraDzV0Ys0MOZ47KCpeE
         SKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394219; x=1793999019;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ewb43Uvomg/tIuEU/p7qaUSF+JjKwFlhid12RrCUYb8=;
        b=pPYWVC8e+/5yWUFI/tne9iYW4/9yUSZn0EG+eyPlrI/BbO0gpuXgQUMhSxSelpocow
         XtKIa7rNSfP97n7jDvAhFjLWph1mFB5lFpa1i4oVFjhNPx1TEMh8JQKNHgQMBjRVmVZP
         2HRfq+1K+dbfZj5+qJ0k4Q1jNSbiHLYDSNyPP5pCd4KRkk0ispaNL0EGoNxKw8n1n/4l
         +kKzQZgTTPjkqg6NjkJU9I+tiEXupRPi+XBLFnjyFS6jCapv8IUPDoOp9v+lP6LjGkvl
         B1ZqakIYFHidyPVfhW8P84ZMJadTKChviKP/8Cx5BdQDBV2M8Uq+vs/66hbJD8Z2fQOz
         wOyA==
X-Gm-Message-State: AFq9FYKzMDtN4oeiEy4ioVz0dH3ZPGGJpc3vZPqmKUIi0Ewvb3lx0r+y
	ALJxFogr1arp81sW3zgerC6TiYejzpqXIIWKdnnsObEiq0oXD9rnAfYqsDQAsgfqJFfd7yvSUDN
	tLzBgWlRs77xYJw==
X-Received: from plgx6.prod.google.com ([2002:a17:902:ec86:b0:2eb:4a7:306e])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e88d:b0:2e2:c55c:90c with SMTP id d9443c01a7336-2eb3650b7b7mr35700475ad.64.1793394218381;
 Fri, 30 Oct 2026 14:03:38 -0700 (PDT)
Date: Fri, 30 Oct 2026 14:03:21 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030210321.3019901-1-jmattson@google.com>
Subject: [PATCH] KVM: SVM: Stub out MSR_VM_CR to return VM_CR.LOCK and ignore writes
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 4a810181c8bc ("KVM: SVM: Implement emulation of vm_cr msr") added
svm_set_vm_cr() and svm->nested.vm_cr_msr solely because Hyper-V wrote
to MSR_VM_CR when running under nested SVM [1]. At the time, Avi Kivity
noted that the MSR needed to be exposed to userspace for save/restore
[2], but it was never added to KVM_GET_MSR_INDEX_LIST.

Moreover, KVM's emulation of MSR_VM_CR does not actually wire up any of
its five defined bits (DPD, R_INIT, DIS_A20M, LOCK, SVMDIS) to their
architectural behaviors (not even checking VM_CR.SVMDIS on writes to
MSR_EFER), checks the wrong bit (SVMDIS instead of LOCK) when locking
bits 4:3, and never resets vm_cr_msr on vCPU reset/INIT.

Replace svm->nested.vm_cr_msr and svm_set_vm_cr() with a simple stub
that returns SVM_VM_CR_SVM_LOCK_MASK on reads (matching typical
bare-metal state after platform firmware enables and locks SVM) and
silently ignores all writes. Document the lack of MSR_VM_CR
virtualization and the missing #GP faults on writes in
Documentation/virt/kvm/x86/errata.rst.

Link: https://lore.kernel.org/all/1267034360-5907-1-git-send-email-joerg.roedel@amd.com [1]
Link: https://lore.kernel.org/all/4B8650CF.6@redhat.com [2]
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 Documentation/virt/kvm/x86/errata.rst |  9 ++++++++-
 arch/x86/kvm/svm/svm.c                | 29 ++-------------------------
 arch/x86/kvm/svm/svm.h                |  1 -
 3 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/Documentation/virt/kvm/x86/errata.rst b/Documentation/virt/kvm/x86/errata.rst
index a9cf0e004651..8dc9c3435752 100644
--- a/Documentation/virt/kvm/x86/errata.rst
+++ b/Documentation/virt/kvm/x86/errata.rst
@@ -84,4 +84,11 @@ memory.
 
 Note, this erratum does not affect AMD CPUs, which fully virtualize CR0.CD in
 hardware, i.e. put the CPU caches into "no fill" mode when CR0.CD=1, even when
-running in the guest.
\ No newline at end of file
+running in the guest.
+
+VM_CR
+-----
+KVM does not virtualize VM_CR (MSR_VM_CR) on AMD CPUs.  RDMSR always returns
+VM_CR.LOCK (bit 3) set and all other bits clear, and WRMSR silently ignores all
+writes without raising a #GP if reserved bits (bits 63:5) are set or if
+VM_CR.SVMDIS (bit 4) is set while EFER.SVME is set.
\ No newline at end of file
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44..be9de34ea6b5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2954,7 +2954,7 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = svm->nested.hsave_msr;
 		break;
 	case MSR_VM_CR:
-		msr_info->data = svm->nested.vm_cr_msr;
+		msr_info->data = SVM_VM_CR_SVM_LOCK_MASK;
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
@@ -3015,31 +3015,6 @@ static int svm_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 	return 1;
 }
 
-static int svm_set_vm_cr(struct kvm_vcpu *vcpu, u64 data)
-{
-	struct vcpu_svm *svm = to_svm(vcpu);
-	int svm_dis, chg_mask;
-
-	if (data & ~SVM_VM_CR_VALID_MASK)
-		return 1;
-
-	chg_mask = SVM_VM_CR_VALID_MASK;
-
-	if (svm->nested.vm_cr_msr & SVM_VM_CR_SVM_DIS_MASK)
-		chg_mask &= ~(SVM_VM_CR_SVM_LOCK_MASK | SVM_VM_CR_SVM_DIS_MASK);
-
-	svm->nested.vm_cr_msr &= ~chg_mask;
-	svm->nested.vm_cr_msr |= (data & chg_mask);
-
-	svm_dis = svm->nested.vm_cr_msr & SVM_VM_CR_SVM_DIS_MASK;
-
-	/* check for svm_disable while efer.svme is set */
-	if (svm_dis && (vcpu->arch.efer & EFER_SVME))
-		return 1;
-
-	return 0;
-}
-
 static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -3262,7 +3237,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		svm->nested.hsave_msr = data & PAGE_MASK;
 		break;
 	case MSR_VM_CR:
-		return svm_set_vm_cr(vcpu, data);
+		return 0;
 	case MSR_VM_IGNNE:
 		kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
 		break;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 6d0242966dc8..91acddf12082 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -214,7 +214,6 @@ struct vmcb_ctrl_area_cached {
 struct svm_nested_state {
 	struct kvm_vmcb_info vmcb02;
 	u64 hsave_msr;
-	u64 vm_cr_msr;
 	u64 vmcb12_gpa;
 	u64 last_vmcb12_gpa;
 	u64 last_bus_lock_rip;
-- 
2.56.0.317.g454f8302e1-goog

