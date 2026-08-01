Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9545120B80B
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785577914; cv=none; b=nyOWAIwr5w5+DrKWNcezpLSH6XapW8/B9jIfpz8zihfIPOMC6jV8IYjPNYzS6GDjmPkvs9uHvtcagD2GR8t9MaRBL4H7PZj0rkXlvfXt5wVkxlnhA+8GE2hIGpJrPfYLKyKw6qlINeV57095SvaQqE1VlyyuKg1R0XTGbgJumtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785577914; c=relaxed/simple;
	bh=yKljj4SYUug21tLfqZ9l0H49iuoeZFS5V5gXTGXAKVg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OeiYioilFfJA0jerzAPmTbzYtKXxY/VCerpxx8psdqiG5PZRh3EcIQMhiIXATquSDeSGzlhnHcyKXfSrVxay+vc0Ri4/ttb/DV/ijgnC6zf6I8Bc3YtLIw0ETV2AdinmZFpsbZQCKZfS4V/dPYd+k2HOHw2pV5V9uwpW0+HfYE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oc60jGEB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oc60jGEB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc61541f8cso30419025ad.0
        for <kvm@vger.kernel.org>; Sat, 01 Aug 2026 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785577913; x=1786182713; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IvDuzw2HHT6P+745ujwE5DH7nkh13wNIypUn+wAvqck=;
        b=Oc60jGEB/HbSdPqiyig0v+oQPdyM4CUN53LYfgXVfrxdj3yt4xl3JNBbnDrouD+my9
         PLrzt+7pt6dXRIv2HegduoFpGrv1j4ExUZfgpZey0cdf1pMbEclt8oR+eKj/4iBf5HJs
         9zxDBZqwUeeoTV9MbSMx3/LeXnEb5UZlsBaASGVyZ88qw4r5BpxWGTEKnxjpi1PbgHgd
         c21mVJHjC70FXCuqKj8yE5lSrLhJxTwTL8C3egK34tE7cGI9zrkDDZkJqHYI8tKxZ3w5
         mWeQolRD2PLnEWNYU+G0GjloWfppQaTitbSJfRDLObnS1A0YEMrl7Pon1KhHBniGpMEN
         +HYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785577913; x=1786182713;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IvDuzw2HHT6P+745ujwE5DH7nkh13wNIypUn+wAvqck=;
        b=GzHE0FpqLdzq97uNfa3L4oF5f7eoppBRUjO6p6hhcEN2eSLpLLeZFA1Q1O+DAk0xpL
         0PbCOPKHsTmrZhxu++ujMXQiGJAF/9MQZEfrvXqrB03fs/Js6rwY2/BYLEReRfgZo0uT
         U1LfH+yHRuflaqUFTPw5C9aJl0O4b8+rzAG3tQ40KeSKfmELkwDdO0qbTi5lkw3++KRI
         Mw2VD71/lnLGvD+KY52bk4xsgasNrNX7I0Y1/UCftaA7yYO5UYZH6yPyJ8herOcoD67E
         rfsYikXcOSocky7tt4UyOGg56KoFx4hKGKRk9KFk5vSF2JfFYJd2IOoFvigLFM2M5hQY
         05vQ==
X-Gm-Message-State: AOJu0Yygc2J3JQ2A3vn1Cb0HPMPj4qPrLwgTQnSCjqBrl8kiydbkYyk+
	1gEf+POELNE29XE7XZLyuYNaJjtl4ERxWC7wTUorEuazJNJOisPaeRvJSjvynQ==
X-Gm-Gg: AR+sD11ZVqCFe4ELQ3RAyEhaNtj8Hp/B+jWdVLWkcvRj3ScuSevXfDIenaDL+lXaKT+
	z7go+cMATHw2PElHXOfwlnQQ8RRwlAfmKuaHbLbMnx/z7kJfzKHo9npcqZ4aHEtxW2VRUAF55AS
	sse2f5CXABy5+mg0Poc+xAMpE6MnSe2B+Xo+fa++buv2jSnIGQqgPb5AJKMiLR/yFtJfZmRSaXD
	qp8Wow+gADrhz9mvq3UR2FOBY1LcKyXo+r9Fc4fRh3gOHdm1IVbRnvhCYh2i9UYQhZ0+bJLyoQ0
	ImlucZ48zJSLq+o8OYbP+q1qtqbeUP9ODT+3xH9Yopnb+RYMr7IsLJsfx+zj6yt4KU2+rRLFt/7
	OIp+536hJs8lukhP26+ebmSboUAESLMUOGQa7RW/c7TnXkRbegS1eP6wu5M8iYJPqBY4GtEulSv
	gGp/ojw/4WXApmMO89mG8W1kW2ltDTwsyUTLdUJPQTVonu7w18S5S4+hM6dXIM1Ft7umrZgm8OS
	WSlSk2jla15lObt8KS4
X-Received: by 2002:a17:903:3905:b0:2cc:80d6:b72 with SMTP id d9443c01a7336-2d0536caf12mr24874305ad.20.1785577912888;
        Sat, 01 Aug 2026 02:51:52 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb598sm16202195ad.51.2026.08.01.02.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:51:52 -0700 (PDT)
Date: Sat, 1 Aug 2026 18:51:47 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, dwmw2@infradead.org
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] KVM: nVMX: Don't load L1's host state when freeing a vCPU
Message-ID: <am3Bs0DjZ5kay9NJ@v4bel>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Don't load L1's host state when kicking a vCPU out of nested guest mode as
part of freeing the vCPU, as loading host state processes vmcs12's VM-Exit
MSR load list, i.e. reads an (index, value) pair out of guest memory and
feeds it to kvm_emulate_msr_write() with host_initiated=false. Letting the
guest emulate WRMSR against VM-scope state that KVM is actively tearing
down goes sideways in at least two ways.

Writing HV_X64_MSR_ICR sends an IPI, which for a non-shorthand,
non-broadcast destination walks kvm->arch.apic_map to dereference the
target's local APIC. kvm_free_lapic() neither rebuilds nor dirties the map,
and the map is freed only after all vCPUs are destroyed, i.e. the map still
points at the already-freed local APIC of a previously destroyed vCPU. This
requires userspace to expose Hyper-V's CPUID to the guest. Writing
MSR_KVM_SYSTEM_TIME_NEW activates the kvmclock gfn=>pfn cache, which leaves
the cache's list entry, resident in the about-to-be-freed vCPU, linked into
kvm->gpc_list; the next vCPU to manipulate the list writes through that
entry.

The vCPU will never run again, so nothing can observe the loaded host
state. Simply restore KVM's MMU pointers so that they aren't left pointing
at the nested MMU, and bail. nSVM does the same, i.e. doesn't emulate a
VM-Exit when forcibly leaving nested mode, and performs only the equivalent
MMU cleanup.

Bail just before the branch that splits the success and VM-Fail paths, as
leaving guest mode, canceling the VMX-preemption timer, and switching back
to vmcs01 are all needed by the free path. Canceling the timer is in fact
the only reason the free path goes through an emulated VM-Exit, see commit
b4b65b5642d6 ("KVM: x86: cleanup freeing of nested state").

Fixes: b4b65b5642d6 ("KVM: x86: cleanup freeing of nested state")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 arch/x86/kvm/vmx/nested.c | 12 ++++++++++++
 arch/x86/kvm/vmx/vmx.h    |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ddf6df7bee93b2..8d58547acb1887 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -384,6 +384,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
  */
 void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 {
+	to_vmx(vcpu)->nested.vcpu_is_dying = true;
+
 	vcpu_load(vcpu);
 	vmx_leave_nested(vcpu);
 	vcpu_put(vcpu);
@@ -5173,6 +5175,16 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	/* in case we halted in L2 */
 	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 
+	/*
+	 * Don't emulate guest-controlled state, e.g. vmcs12's VM-Exit MSR load
+	 * list, when freeing the vCPU.  Bail only after leaving guest mode,
+	 * canceling the preemption timer, and switching back to vmcs01.
+	 */
+	if (vmx->nested.vcpu_is_dying) {
+		nested_ept_uninit_mmu_context(vcpu);
+		return;
+	}
+
 	if (likely(!vmx->fail)) {
 		if (vm_exit_reason != -1)
 			trace_kvm_nested_vmexit_inject(vmcs12->vm_exit_reason,
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index dc8517f15bc463..2bacd3fe4c7ded 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -76,6 +76,9 @@ struct nested_vmx {
 	gpa_t vmxon_ptr;
 	bool pml_full;
 
+	/* Set when freeing the vCPU, to suppress emulation of guest state. */
+	bool vcpu_is_dying;
+
 	/* The guest-physical address of the current VMCS L1 keeps for L2 */
 	gpa_t current_vmptr;
 	/*
-- 
2.43.0

