Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396271;
	b=gMh1k4NX6ssvfkAjLV56fbY95U1Ni4IIWN4LJRI341tryAITDH5p5GHj5gVyJCliOjhX
	 IeTD+fytfn4uMyv/F3/m8biru4iJnVBMtTYwfWxEoKNCpMz/HDT9zennpfKgb0YsEP4l7
	 OHUiwZla0AUZmjTvs4rUGgNHeBscRVG8fuFuHqlRXunxa+orYRFCyWt+/0eOTY3vY7Xo4
	 arqB75b8iMur08aoF9jltkFerjl3jfW0+PviSD1ywJiQ1D1dPsgf9dgxkFsbcnOzhYHlT
	 PFCm6i9lFvWSq4TGIR7N9AnRK1e3zXNOIrt6vh7y0JXh3nYDSsNeyibjM4GvrPtDJuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Xhyg5cGPtjP9AGfE0CLRkt6sDAb9YKw1TbZgcTvrTXs=;
	b=mg/LFFnAyqQAfqG2dd+x+4i3HZqIepoNMqoDUcNJb8gwf2n7H4Ltfun0P/bECvbeI/C6
	 vE3o9f35nN2zIeLNVvJrTbARYcAKmk8aqxAx9sLI19+ktGl0BxUzm95b39WDCHF44xJcj
	 i77w3D0LsAy7+0KR5uPnTP+pp8WWWrVlErLokXTedaCZRUjJKY8rW8D41z3VClgMsXyKT
	 4VrHTq8MIDQzqpdtENLe2QJXuNKz6QSIXtWZF113sP0UhuPXUtis3J4pFpsy+SpWOJoan
	 ZgyxjVWYVJTsYjZxLv2ZFbi2r0Csu/EPMwDCq4XdbsgkCKgDY/0Jd9usPQwCq3hwQ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=awqH94wq;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F5606A323
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B0F5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=awqH94wq
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd5ca3840c5so1220393a12.2
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793396270; x=1794001070; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xhyg5cGPtjP9AGfE0CLRkt6sDAb9YKw1TbZgcTvrTXs=;
        b=awqH94wqEZhCQvpfloo3dpfVfXMqbHChw37m5kRq57aQXaUTbKjZGrZQOomvCkWttv
         BMLr7VOlkro0PfN38oOEMO1YvlwONM3ZS1I9jUbnoKg3xnJ/AUbU+A9PM8zpNYgtvAKx
         dHlDddMAj6gllny66hP2wOQ9VgEQq54pTPKT98u/QPPXkLhXnDgx5ANx1dYtrkxm0q+a
         z7bCWSdrBaIT8ef9+MhjBW7RLkIjGQfQHcyWh6mhBeL/AQ1SGocuchnQAlc4wMzs5YqW
         D8c+fRwhfbM2hhOLJ6FOzb1cKdZ/ReqTKOx1iYRuqSkL1MCuq8SoHR/RP5B5f+36xn82
         uZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396270; x=1794001070;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xhyg5cGPtjP9AGfE0CLRkt6sDAb9YKw1TbZgcTvrTXs=;
        b=xKUlkKmcfDW3Tu1FAEzoUjg16s1ptmkTQoeufHOYcAH9siLcZQ8tr5ZiNBoQCVEmyC
         wZapn+TG+aEEq78HdJmUaVg9ljLaTUJviiWBfiDthdwcIiclMGehI/JtM8pLj0jvbqOd
         DVX8wp7XsmRSWisV7FJ+o3wziW1aazY4ARPxkM0JlAIT4JmTCJZRv7RnMkY3O58usvax
         Fye7BRZkPuP7WvAx1NxRX2Qge36rbHyYj40whhcNcHR3nkAT3mnGxCgAtnju0pf68EeN
         p8DJyARTC+4T/iOKCobqvmOusNzDnwWrbY09oIK4FyRWCkfhdBgr1SlCEqRPbb+X2ZDP
         wTPg==
X-Gm-Message-State: AFq9FYKR3JaMj2a/cWL7hcZDToCEmpo5kSFSVOHusUhW+X3dwSNL8qT5
	f4tl9mFRDcdJFIVEoBkkD4ZKo05uiAhiOvaUJ2kKYMt2ZiK7S3nG4PEGx4eh4BzxYtaSKjDFdHr
	TszlNeQ==
X-Received: from plfz5.prod.google.com ([2002:a17:902:d545:b0:2e2:f305:e980])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5cc:b0:2df:accf:e873
 with SMTP id d9443c01a7336-2eb36415081mr41010915ad.4.1793396270447; Fri, 30
 Oct 2026 14:37:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:37:43 -0700
In-Reply-To: <20261030213747.2611815-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030213747.2611815-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030213747.2611815-2-seanjc@google.com>
Subject: [PATCH v3 1/5] KVM: nVMX: Preserve L1-owned bits in CR{0,4} read shadows
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When emulating an intercepted MOV CR{0,4} for L2, i.e. when L2 is toggling
CR{0,4} bits that L0 intercepts but L1 does not, explicitly preserve
L1-owned bits in the vmcs02 read shadow instead of subtly relying on the
interception logic to preserve the bits.  For straight MOV instructions,
relying on the interception logic works, because KVM would have synthesized
a nested VM-Exit to L1 if L2 were toggling L1-owned bits, i.e. if L2 were
explicitly changing any of the shadowed bits.

However, for LMSW, which preserves bits 31:4, and conditionally preserves
CR0.PE (bit 0), the effective value being set by L2 can diverge from the
read shadow *without* triggering a nested VM-Exit.  E.g. if CR0.PE=1 in
"hardware", CR0_READ_SHADOW.PE=0, and CR0_GUEST_HOST_MASK.PE=1, then a LMSW
with CR0.PE=0 won't VM-Exit, but will preserve/set CR0.PE=1 in "hardware".

Explicitly preserving the shadowed bits will allow using handle_set_cr0()
to honor L1's guest/host mask when emulating LMSW.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..544b7840897c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5629,22 +5629,19 @@ static int handle_set_cr0(struct kvm_vcpu *vcpu, unsigned long val)
 {
 	if (is_guest_mode(vcpu)) {
 		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
-		unsigned long orig_val = val;
+		u64 mask = vmcs12->cr0_guest_host_mask;
 
 		/*
-		 * We get here when L2 changed cr0 in a way that did not change
-		 * any of L1's shadowed bits (see nested_vmx_exit_handled_cr),
-		 * but did change L0 shadowed bits. So we first calculate the
-		 * effective cr0 value that L1 would like to write into the
-		 * hardware. It consists of the L2-owned bits from the new
-		 * value combined with the L1-owned bits from L1's guest_cr0.
+		 * L2 is writing a CR0 value that isn't modifying any of L1's
+		 * shadowed bits (see nested_vmx_exit_handled_cr()), but *is*
+		 * modifying L0 shadowed bits.  Set the "hardware" CR0 and the
+		 * read shadow using the L2-owned bits from the new value,
+		 * combined with the L1-owned bits.
 		 */
-		val = (val & ~vmcs12->cr0_guest_host_mask) |
-			(vmcs12->guest_cr0 & vmcs12->cr0_guest_host_mask);
-
-		if (kvm_set_cr0(vcpu, val))
+		val &= ~mask;
+		if (kvm_set_cr0(vcpu, val | (vmcs12->guest_cr0 & mask)))
 			return 1;
-		vmcs_writel(CR0_READ_SHADOW, orig_val);
+		vmcs_writel(CR0_READ_SHADOW, val | (vmcs12->cr0_read_shadow & mask));
 		return 0;
 	} else {
 		return kvm_set_cr0(vcpu, val);
@@ -5655,14 +5652,13 @@ static int handle_set_cr4(struct kvm_vcpu *vcpu, unsigned long val)
 {
 	if (is_guest_mode(vcpu)) {
 		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
-		unsigned long orig_val = val;
+		u64 mask = vmcs12->cr4_guest_host_mask;
 
 		/* analogously to handle_set_cr0 */
-		val = (val & ~vmcs12->cr4_guest_host_mask) |
-			(vmcs12->guest_cr4 & vmcs12->cr4_guest_host_mask);
-		if (kvm_set_cr4(vcpu, val))
+		val &= ~mask;
+		if (kvm_set_cr4(vcpu, val | (vmcs12->guest_cr4 & mask)))
 			return 1;
-		vmcs_writel(CR4_READ_SHADOW, orig_val);
+		vmcs_writel(CR4_READ_SHADOW, val | (vmcs12->cr4_read_shadow & mask));
 		return 0;
 	} else
 		return kvm_set_cr4(vcpu, val);
-- 
2.56.0.385.gac671c819a-goog

