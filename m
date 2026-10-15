Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327747ECCF
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053101; cv=none; b=BwBXrwH6VTt8cqK7+Z26FMmS0FV4HwkbiOfxb3T1BYCJSmMrmZlKZgxpeMS7fdeF4yvWm94hEd0N/2bk/sITOqlkgMaykFCuwsT2EJChoicws9ME+zgERpc8M5+d5pdWL72sqrWg8ApNvS52qeiIEd+RjcbynW6fCKB+gTps5HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053101; c=relaxed/simple;
	bh=6f8L/XKgNbWcP+l1GujSXmEOuuyEy+i5ZMaIDRxTrds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWRLRYk7N+m61MbqyL3OBYk5y1kz4kxUVwe5yFmeMNaMqTv+0bn3jSZLyApbTDuwteCDFrBwP5/2wfY4YHQnWk3gzGCeec5NjoETV6HpmBQB7kLnThz0oqzx2q0pjIX9JgHVRi2trF43RFHAqTg29aNDYjEybVpynXqZF1DjRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NiiDARhm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbMm4QAm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiiDARhm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbMm4QAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792053099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYcOuCD0Qzf9L3Al+IVedCpzElpu1ACJeY366xjNKo8=;
	b=NiiDARhmKhxWWcokyDfu7ZKwNmQJ+MyBj8NYglVhuJXPvcD37x/yjykJblIT5QFgP0jJud
	PahZaK6B45N9P8uRP0VPcwkXsikmBC1lMlP5UIxmsPpwOZOSwcjRhlPO1BIaHscC9p9iCP
	DH0dct34Ouhhd/4ueA7IHo4QpU9uCDQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-kweR0IrOMweTIkZwqxsDkQ-1; Thu, 15 Oct 2026 08:31:37 +0000
X-MC-Unique: kweR0IrOMweTIkZwqxsDkQ-1
X-Mimecast-MFC-AGG-ID: kweR0IrOMweTIkZwqxsDkQ_1792053097
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1813fea7dso73904325e9.2
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 01:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792053096; x=1792657896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yYcOuCD0Qzf9L3Al+IVedCpzElpu1ACJeY366xjNKo8=;
        b=IbMm4QAmU2YH3Qt8BPy/5SXzxWbNpg3Yt3kAP0yWhI39a7W4lN2zzaKAALEo1dqtfB
         ybdOwxSt51aKK56YTvfHx7Pid035lt2uKQY4H3BY4PrrK/1DKIFBSZxqv2yIk5g8THci
         +GBlJh73zXCCGyypvVWCevMU8U2zUdCfpR6QdtdnCimylkb7pSJ2muRsCQfYBgAg7eDW
         Xr0pXaLK+FwY8lyeV4DzSZOLa3BV6kP4/paFvQvB87D3/fuPRsECuSSKQkqO5Ynveqeh
         NayKwgDutXq2U2FzplFNB56X0GhIiKzp5qx4Jh7oJ1Xb9huKWNfjJlPCmoH5KSAK7dRx
         rHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792053096; x=1792657896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yYcOuCD0Qzf9L3Al+IVedCpzElpu1ACJeY366xjNKo8=;
        b=WR1SvZeQJ5d5FJFwQr85qol6nFVa+mhZUc3WzZIMg7GiCy5ZyxrA4ggMA8cgJmNPtr
         onwzreAtsV4Y2p1B8crOIXoYrNCnpv5jmIEj5/SUL0+QTpnhezFguSmd3UqiUHdDgZ03
         DygXGygDhZhM1FZfmZhxR+wp9Kr2sVk5LhqYr0e67sYAMXKPz2PdAFZ7ddTvkyIau/Aw
         EJlBn6ixTWRfNbh7KCJlozzkTwyJQijKdAwtt6NSu+ZgPSzB5fQ2MxD+4ORnPk7Sks9L
         k9xWIuqSaoJAtGQUu4po/CVt7KDEp6gHPh/y4mOWiRYeMao3w41aelVssgdjBNbaIbsE
         B2wQ==
X-Forwarded-Encrypted: i=1; AKwUvBySR9F9H+rY3ZUKCGTwPvljJAwGzwsH/ygx4rrcumofMP/4QTXKBKUFyPSgXYuyf6jPjMQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrZcllV47H/3sdoznJglATC0e81QcMjFzlNGzpuLQWyx6NgehB
	iZKGlZdJZvPu2bVxjCwHFc16+Fn6lwx+D+qKCcnhtGstJdY397pyjL4Rd42cWjXLdLVW5uspFrx
	ab/gP0gy+hRAUMKjP7lbKMVMcloj/ipxwCBv6YQBgWMlaS8EGiGLpAQ==
X-Gm-Gg: AYBFou22pmdQqSvGMNHS/XZe/U1/rybYo1G5PKWLwWue0yLxAgPAVkicwp8Glkgs573
	QjZTmhdartUZIacQtlzOLEosG/NJ1YjXX4g+ZIhugw3EVnUkE1V0d5UCKbZpD8tpoDgXblfUoC8
	IsGnkgQK4+/oqqBAhMqdg6mOQ6HBoRT85CEZpGVYPjxLfA+wzNNX5gVaIEA0FdTzYWoBhRjC49O
	A/NWGFQPXXpHmQLyr9OQe1mM7dPWBZ+v0vUh+NIKsFuY5RqS2GXdkzkH2R9lhdgOiCy14Z6QHqP
	IMh9978M0uEkyip809qAfT15hIfTH1o6Xx6eHzsEc57eRusK9hC9MeJHmJMipMbZc4muKB+pxIw
	NVfo8lCs86sbiEoaPyOkihGhjm4tkLs9KSprZNRF4tLrnXFvh+fijUKuR7bJYiNajqXbYGtk+eX
	PuyXzU
X-Received: by 2002:a05:600c:3ba8:b0:4a0:174:579e with SMTP id 5b1f17b1804b1-4a18e4ab221mr422133075e9.28.1792053096376;
        Thu, 15 Oct 2026 01:31:36 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba8:b0:4a0:174:579e with SMTP id 5b1f17b1804b1-4a18e4ab221mr422132635e9.28.1792053095953;
        Thu, 15 Oct 2026 01:31:35 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bf63567esm74917325e9.10.2026.10.15.01.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:31:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 2/2] KVM: x86: Reset MMU back to the root MMU when leaving guest mode
Date: Thu, 15 Oct 2026 10:31:23 +0200
Message-ID: <20261015083123.790030-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015083123.790030-1-pbonzini@redhat.com>
References: <20261015083123.790030-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Always reset a vCPU's MMU pointer back to the root MMU when leaving guest
mode, to ensure that KVM doesn't try to run L1 with a nested TDP MMU.
Dereferencing the MMU between putting the vCPU into L1 and restoring L1,
or even pivoting on mmu_is_nested(), would be a KVM bug, as the vCPU state
is guaranteed to be stale for one flow or another.

The risk of immediately resetting the MMU pointer is that doing so could
introduce a regression if either nSVM or nVMX has a correctness dependency
on buggy code, i.e. if KVM relies on the nested MMU being live between
leave_guest_mode() and the calls to nested{ept,svm}_uninit_mmu_context().
But for such a dependency to exist, KVM would either need to explicitly
check for nested TDP or make some very blind assumptions about the MMU.

A manual audit of the code confirmed that vcpu->arch.mmu isn't dereferenced
in the described window, and hacking KVM to poison the pointer and WARN if
KVM tries to pivot on the pointer with half-baked state didn't trigger any
splats while running KVM-Unit-Tests, KVM selftests, and Linux guests.  I.e.
running with these hacks didn't trigger any badness:

  static inline bool mmu_is_nested(struct kvm_vcpu *vcpu)
  {
	WARN_ON_ONCE(vcpu->arch.mmu == &vcpu->arch.guest_mmu &&
		     !is_guest_mode(vcpu));
	return vcpu->arch.mmu == &vcpu->arch.guest_mmu;
  }

  static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
  {
	if (vcpu->arch.mmu != &vcpu->arch.root_mmu)
		vcpu->arch.mmu = LIST_POISON1;

	vcpu->arch.hflags &= ~HF_GUEST_MASK;

	if (vcpu->arch.load_eoi_exitmap_pending) {
		vcpu->arch.load_eoi_exitmap_pending = false;
		kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
	}

	vcpu->stat.guest_mode = 0;
  }

Signed-off-by: Sean Christopherson <seanjc@google.com>
Link: https://patch.msgid.link/20261001214356.3825100-3-seanjc@google.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/regs.h       |  2 ++
 arch/x86/kvm/svm/nested.c |  8 --------
 arch/x86/kvm/vmx/nested.c | 12 +-----------
 3 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 447f0ec3e63e..b29dd24a4531 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -463,6 +463,8 @@ static inline void enter_guest_mode(struct kvm_vcpu *vcpu)
 
 static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
 {
+	vcpu->arch.mmu = &vcpu->arch.root_mmu;
+
 	vcpu->arch.hflags &= ~HF_GUEST_MASK;
 
 	if (vcpu->arch.load_eoi_exitmap_pending) {
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index f9090b601efa..50f12cdeaa7c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -119,11 +119,6 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.ngpa_walk.inject_page_fault = nested_svm_inject_npf_exit;
 }
 
-static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
-{
-	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-}
-
 static bool nested_vmcb_needs_vls_intercept(struct vcpu_svm *svm)
 {
 	if (!guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_V_VMSAVE_VMLOAD))
@@ -1432,8 +1427,6 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 
 	nested_svm_transition_tlb_flush(vcpu);
 
-	nested_svm_uninit_mmu_context(vcpu);
-
 	if (nested_svm_load_cr3(vcpu, vmcb01->save.cr3, false, true))
 		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 
@@ -1549,7 +1542,6 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 
 		svm_switch_vmcb(svm, &svm->vmcb01);
 
-		nested_svm_uninit_mmu_context(vcpu);
 		vmcb_mark_all_dirty(svm->vmcb);
 
 		svm_set_gif(svm, true);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 5165275128fc..6f18c236e3c6 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -525,11 +525,6 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.ngpa_walk.inject_page_fault = nested_ept_inject_page_fault;
 }
 
-static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
-{
-	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-}
-
 static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
 					    u16 error_code)
 {
@@ -3770,10 +3765,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 vmentry_fail_vmexit:
 	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 
-	if (!from_vmentry) {
-		nested_ept_uninit_mmu_context(vcpu);
+	if (!from_vmentry)
 		return NVMX_VMENTRY_VMEXIT;
-	}
 
 	nested_put_vmcs12_pages(vcpu);
 
@@ -4833,8 +4826,6 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	vcpu->arch.cr4_guest_owned_bits = ~vmcs_readl(CR4_GUEST_HOST_MASK);
 	vmx_set_cr4(vcpu, vmcs12->host_cr4);
 
-	nested_ept_uninit_mmu_context(vcpu);
-
 	/*
 	 * Only PDPTE load can fail as the value of cr3 was checked on entry and
 	 * couldn't have changed.
@@ -4998,7 +4989,6 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 	vcpu->arch.cr4_guest_owned_bits = ~vmcs_readl(CR4_GUEST_HOST_MASK);
 	vmx_set_cr4(vcpu, vmcs_readl(CR4_READ_SHADOW));
 
-	nested_ept_uninit_mmu_context(vcpu);
 	vcpu->arch.cr3 = vmx->nested.pre_vmenter_cr3;
 	kvm_register_mark_available(vcpu, VCPU_REG_CR3);
 
-- 
2.56.0

