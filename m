Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794949783;
	b=xShMT9XDxR1jvVbI/m8Ep3RX2HEoVzsmqiEcLUZfZ0vJnVq6FjwRxgUzM9VzaEr3jBZl
	 ASaGpcMl+7VAvbEjAHlmCaiV6J7FLlkXTcVoKUJJu5B6tzgoHdWcFngZmHWx4M7vEf+84
	 3Pk+9Zx5S87UbJ9zvcjjEPBcWrGlJiJuB39f8zRL/wcgVBb2pOXLdcD+jZT7FHPsiKLOG
	 Jo9srhC6XVK35nzd8Vr2GihqAiZjwXI+PaxnnWH6Ls9DLOZAPCOB2gP1LA92XiPcs7/wM
	 oq1fLO70ylcmSPH1cVmx8dKu1rIUkvpEuFkWz38K6wJSKa/C2HhUtgHZ9ecar6ay1lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794949783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=T+072KEeIi6BYvL7fBfuUdg+p0qRxX15CFfLlb3m+bU=;
	b=rWg0aa0wd36qlvpbq9lcQgfSNsixqRYy2yE6uaJAViQ+meWrrqE8F/MZh5C76ZyUSvlD
	 uaU/gvCSMPU7OYBiOMMRG+riVzwfTuw+W3/McqDGkqxs90TTsXP6TweJotnjfb1VP+L5/
	 VpIBfsM5hjQJU6By9RpxSIYw+cQ97qBAck/vJU7oxv/Hz3L7XGaa0LXfE0mjWt1aM71G/
	 rEt0LTbZ5gVvcmEc4ETUHriAxBITQOD5qG0DIrxG25qT8xox7E3ugXi14MkO+SjZlNNa1
	 fxFwVRBEPPnspL9GCU0kwuk7MgvHuvVhaDnqMfuPXBcHdRTFtEYhwGRmNWqcm6czEMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="j9Yu/+RH";
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0578606A8B9
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0578606A8B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j9Yu/+RH
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdb90a6230cso141723a12.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794949782; x=1795554582; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T+072KEeIi6BYvL7fBfuUdg+p0qRxX15CFfLlb3m+bU=;
        b=j9Yu/+RH+cK1i8j6kJie35+l42hOopqj38OTGChZR9jsHIfATz8WwbkwMNXLkPLjmJ
         lpOcq7G9sQOo7pn/z1dvnGBXB+Om/YaLnTyXSSJ9owRFWqeNXunE79aowhhPmw98JEIb
         S3wzSo+VV+/vPC0ABDY0d9A50NIuNqlHxy94ToEVMp9+PD/HqOPMwh0jPRV+eAjCoszs
         IrOJdxOjsN72twOmmCpOxt9SCL4l1zbT4nbZUI/RdJD+16pBWp8IDnCAU7yGh6czemrO
         ovo28vzUV1scKFB3WIfjWLM60w1Y+1ovdjFgMNuGEZCRwLwsjvQbLVkCwvUolFxnx2jK
         8XdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794949782; x=1795554582;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T+072KEeIi6BYvL7fBfuUdg+p0qRxX15CFfLlb3m+bU=;
        b=alpmoMpNopLLCa05grUHpGqEv4TDuTE2vlAWDXt67M4aUe8AR0uNF7EpfkkU8o+p5S
         DHBA3ra2Q8jq+wKK4iT2DJQ/v/z1GsrubBIHXhm0V7XVIKezkPO8WAZT1mn0aIhmigB/
         56UzEovtUfpb8uw4RyrTy8/Zi4A7FA1kbOabyVoY5B3v/BL7dPuDYCDtmwP+bbqdDLYL
         Wd5jt1fZwbpLtqCIEdedHfnX83aa/kq4PXsTT/c3wiFOP7PNY2rfxqvG1+bZALQLAVi5
         aGC89/smEsi4KLLQC9aPut1FXYcHs2slAZuN+xIqGPUUlHgvc7RXxy7RgSoarGsjQMqf
         IiPQ==
X-Gm-Message-State: APuU4Z+cHPWSzT6wwhr2QVpNdCLzEYbuQ82kp4klOEh0IVdLDJYZUgD/
	rPjz36NY15s0mpReOopmID1q+pjqF8s3eiYlTzMAoLNzrNoEBuDgJZ455oo2H6m1oTV3a2XOrEg
	1a3rzfg==
X-Received: from plog15.prod.google.com ([2002:a17:902:868f:b0:2ea:d63d:f2c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f790:b0:2e9:460e:ca57
 with SMTP id d9443c01a7336-2eff7529757mr4886135ad.15.1794949781800; Tue, 17
 Nov 2026 13:09:41 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 17 Nov 2026 13:09:34 -0800
In-Reply-To: <20261117210934.7765-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117210934.7765-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117210934.7765-6-seanjc@google.com>
Subject: [PATCH v2 5/5] KVM: x86: Initialize MMU+PGD before loading PDPTRs on
 nested transitions
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	syzbot@syzkaller.appspotmail.com, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Initialize the MMU and PGD (root) before loading PDPTRs when emulating a
nested VM-Enter or VM-Exit to ensure the MMU is up-to-date even if loading
PDPTRs fails.  If a nested VM-Exit fails to load L1's PDPTEs, and L1 ran L2
without EPT/NP, KVM can run L1 on a freed MMU root, i.e. the CPU's page
walk is a use-after-free, if userspace blows past the KVM_EXIT_SHUTDOWN.

                              root_mmu  vmcx01  vmcx02
                              ========  ======  ======
    L1 runs                   R1        R1
    VM-Enter to L2            R2        R1      R2
    memslot deleted, L2 runs  R3        R1      R3      R1, R2 freed
    VM-Exit, bad PDPTEs       R3        R1
    KVM_EXIT_SHUTDOWN         R3        R1
    KVM_RUN enters L1         R3        R1

Unconditionally initializing the MMU if KVM sets CR3 is a-ok, as the nested
VM-Exit paths need exactly that behavior, emulation of VM-Enter generates a
VM-Exit on both SVM and VMX (i.e. KVM is guaranteed to load L1 state and
re-initialize the MMU), and RSM+KVM_SET_NESTED_STATE defer loading PDPTRs
until the next entry, i.e. don't load PDPTRs and thus can't fail.

Note, pre-checking the PDPTRs isn't an option because they come from guest
memory when TDP is disabled, i.e. the PDPTEs in memory can legally change
between the VM-Enter and VM-Exit.

Fixes: 1dc35dacc16b ("KVM: nVMX: check host CR3 on vmentry and vmexit")
Fixes: d82aaef9c88a ("KVM: nSVM: use nested_svm_load_cr3() on guest->host switch")
Reported-by: Chris Mason <mason@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index b43ad11f061c..1cbc7b9f6ef4 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -204,23 +204,29 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(load_pdptrs);
 int kvm_nested_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 			bool nested_tdp, bool reload_pdptrs)
 {
+	vcpu->arch.cr3 = cr3;
+	kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
+
+	/* Re-initialize the MMU, e.g. to pick up CR4 MMU role changes. */
+	kvm_init_mmu(vcpu);
+
+	if (!nested_tdp)
+		kvm_mmu_new_pgd(vcpu, cr3);
+
 	/*
 	 * If TDP is enabled, then the PDPTRs either come from the VMCS (EPT)
 	 * or are read from memory on-demand (NPT), i.e. aren't loaded here.
+	 * Load PDPTRs *after* initializing the MMU and PGD, to ensure the MMU
+	 * is initialized even if the nested transition ultimately fails.  On
+	 * an emulated VM-Exit, failure will put the vCPU in a shutdown state,
+	 * but KVM still needs to keep the MMU up-to-date.  On an emulated
+	 * VM-Entry, failure will generate a nested VM-Exit, i.e. L1's state
+	 * and MMU will be explicitly loaded.
 	 */
 	if (reload_pdptrs && !nested_tdp && is_pae_paging(vcpu) &&
 	    !load_pdptrs(vcpu, cr3))
 		return -EINVAL;
 
-	vcpu->arch.cr3 = cr3;
-	kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
-
-	/* Re-initialize the MMU, e.g. to pick up CR4 MMU role changes. */
-	kvm_init_mmu(vcpu);
-
-	if (!nested_tdp)
-		kvm_mmu_new_pgd(vcpu, cr3);
-
 	return 0;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_nested_load_cr3);
-- 
2.56.1.703.gf848ed807c-goog

