Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202734;
	b=aqwodDeiK/zRBof3p8Rrn2R/1v7V1CMCrNfM8NWRmXpBMHowhF3esVuieX+whU9w92IV
	 DVJEI9fDogMCqTTVtR6jseE8arsR7fEcC2HJ+Sr3I72sIvCR5fM29klLg8UQ15wU2Cqdx
	 7aFb1FiX8ftaXfTn0HihGIJ+jLZaNXG7abDIfVGzeChn/03yMPizI/GqqP3JtMxRMKw0q
	 evXT98YEvCbd3yR5jk656ao4nrr/r7pADN1hB9GkSyfWZQlAycfnpSEz9uXW/T+Y6PwFf
	 /U+DExF4IOy6KKL31luxKn2NMVRIJj8E3poHHsdTx4E9uoeE/Rb0TW2ml9ccCQk6w8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=1IS9bB79S6ELO3/6XYypihEImNKjKlv6tMYPTAYxBWM=;
	b=TdQYf4sAfVKkIcHLuLpzNwanTuuKQiTgrqe+LuukrOm4rFQs3dxz4NZBZ6pc5ulM4ZAS
	 dL6cmwspdOwI4O1KKRECWWn1MwhPrPM36H/hCjmlgWVu2pBbOwmV9iPiVWpx8PYUptxp4
	 kBnpbxu2xhMrJo7rNjPzcCkpcKHHBxxtsK/wFCbsErPE/ZfklB5tfPRC64um3JLcIkpLk
	 In7Ow5OCSBuQzfl69hm86gAgJdmyASzGkSFKVyx324cTTAiNmxquZT6hrMrcA4uLApnz7
	 oP90ElwiL2glIW2MggZ9tQZBIncs1ER6j2PTFt8Xs6XdQsaMDzdiSsaMAp6wsHOpwbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P52m1tCu;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F9606A323
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 05:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C39F9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P52m1tCu
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so2624065e9.0
        for <kvm@vger.kernel.org>; Sun, 08 Nov 2026 21:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794202732; x=1794807532; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1IS9bB79S6ELO3/6XYypihEImNKjKlv6tMYPTAYxBWM=;
        b=P52m1tCukE761aWyH02DuccwGLNXxEJHkzKsb0kG+eBy4GwBBl7L4AQi/DJfVfOqYQ
         4CYkp5AThDEMyORh4Z5vQG+z0rwNRFbX70PrcQCcItiGahcuHnh9v3KG2E3HkQpUDx1f
         lOV27Oyi9b5p5vDUxkwQsXTjCGxqOn7g2rzBba7ecJGZgvNR//iGmxoG6w2/ri5tbm5H
         yU73DsRp+blZAZ1DMNm7WlmQL9D0usA1+bWzpn0DOhJ6EoVr7ayvg5+n4e7fmDcBJkGN
         NatjWWp5iZQyTWn+A00Ono9MlxIc301c2WuYI4p06abSS8WfUcW0gODmCHRhQM7A3W79
         Cplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794202732; x=1794807532;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1IS9bB79S6ELO3/6XYypihEImNKjKlv6tMYPTAYxBWM=;
        b=XQPEDhUp2XEEdsquC1wSng20zNLtx0IHrTdvvpZNVKTfwHAOosHrOji9fDWifV39Lv
         7B83lM8P1SGjx3SfJGqVi3smOvexrNoDCWC8/gxxyeD6QX5Y+JOlO+gA6GwuuDXjGgFB
         yvfqw4u64fO26gKNKT3HtHlU7/BErZivf+yE+aEYv32xtx2hApfBrzAfyuFisBmeGG/w
         OruE1gb1jlddLWj8++xlEUIy40Dn6rZ/86PqfOlvYqQJvV1sHmbon9jFHw2qkAX/WY9J
         lYGlZ+ecjaJjWQSmd9YTjoKCKC8DE527SbSjCHhvPjx6B8KxfUsrEy+0agGfq/8oSGBL
         8O2w==
X-Forwarded-Encrypted: i=1; AL+hErFbj5LmmyUS3+V2w2CAGXZbM1Hlirq1UhyaNUNR4ouacOQCohlgVqJjb29p5D1XFuyIvWQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IGZh18hG3l2dI1R/cNKq6nh9mvEEcZFK+aPo1+QcduQMpkZly
	0SCOle8aXZHLGG6fa93QBUFaRWCwaPdF8J2IB6i0z4nQ9aXbgC+jt+Pz
X-Gm-Gg: AYBFou2o8ZYYzDMWRBJxyouAXbgIwrEl9iYlsM1M7fQpiusjz85kCCi7LpssTNmSdGx
	LYjzozYopimg4ozvj3QOMwsWH7OWxXK5DaOuZzKtpRGKgLLhlY8IzOOLAMl7gLaMtNaeuAxn45H
	+RfTcPezSy61mZvowyTWWh9QOEYnS2WqmqnuZ7UCHh54sAf7xxzVCtFxc27+i+2/pdRkrDdxlPZ
	RJt6mheBU5SSKeKPb2z5YBfZ0nG5xQHxFTsu0TpX8J/yDuGWMJ9A+ZLPVquWKi/K6eEi9nUSb0z
	qZiXcGF4vOd3kvvzX/l3kh8ahkngJkUzCcHYXdYHNImY7z6AzcseFvAbEYVcaQBqtKkn7CQvAXC
	4jPo3FOKtWIacB2htNagId/gn5YwdHfPK+lgApD4/fsrojE55EcN4gdI492TTo0fTPw9ukO11K+
	MFYjfXXXxPtGiKfuVI0Ty9z2fmGvq1n55PKgYevbEZUFnXglh70BJZQAYeG4BOZcbGTdmXDi0Cl
	GfTl483+vvSmOeti5yGGtG3e5QxrHcTJepK5bv/1+4ynxXipTRjZHAbCvPhO0asEKB0Busz3B/C
	BLnGMdd2lmcpBp+zLN82xTzBx3zFxxsy16ZIDoF9j2L2Ghhud6YGUapofKRGcrisSqj0ETMgQNe
	Napf3RtMNJNtd1otlmrP6DFZAp2zctdd6F9pXVLB2kESxVJIdr5/Ao6JxSZ+0zI1betKG8rTe78
	4E/UxPmljofNSu
X-Received: by 2002:a05:600c:8b6d:b0:4a2:729:f7ce with SMTP id 5b1f17b1804b1-4b963c6d1dcmr53426495e9.8.1794202731953;
        Sun, 08 Nov 2026 21:38:51 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b96cd012e1sm99903155e9.8.2026.11.08.21.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:38:50 -0800 (PST)
Date: Mon, 9 Nov 2026 08:38:47 +0300
From: Dan Carpenter <error27@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Karthik Bhargavan <karthik@pereq.eu>,
	=?iso-8859-1?Q?Cl=E9ment?= Blaudeau <clement@cryspen.com>
Subject: [PATCH] KVM: nVMX: Prevent potential user space corruption
Message-ID: <dab486f129c36ba1cfb322ceb56ec6fdef020ca3.1793959700.git.dan@cryspen.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

At the start of the function it does:

	if (is_guest_mode(vcpu) &&
	    nested_cpu_has_shadow_vmcs(vmcs12) &&
	    vmcs12->vmcs_link_pointer != INVALID_GPA)
		kvm_state.size += sizeof(user_vmx_nested_state->shadow_vmcs12);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This says if the three conditions: is_guest_mode(),
nested_cpu_has_shadow_vmcs() and != INVALID_GPA are met then we are
copying sizeof(shadow_vmcs12), which is 4k, bytes to the user.

Later, we check if the user has enough space to handle the copy and
if "user_data_size" is too small we bail out.

        if (user_data_size < kvm_state.size)
                goto out;

But at the end of the function it accidentally left out the
is_guest_mode() part of the condition so potentially we could copy more
than "user_data_size" bytes which would result in userspace corruption.
Presumably, users normally allocate enough space and we don't often
corrupt memory in practice.

Add the is_guest_mode() condition to fix this bug.

Fixes: fa58a9fa7497 ("KVM: nVMX: include shadow vmcs12 in nested state")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@cryspen.com>
---
This bug was found through our formal analysis work at Pereq.eu.

I do not view this as a very serious bug because it requires userspace's
participation in corrupting itself.  Userspace can corrupt itself
directly if it wants.  However Claude says it cannot share the
reproducer for this bug to anyone under any circumstances so I have not
been able to test a before and after.  I have run the kvm-tests on a
patched kernel.

 arch/x86/kvm/vmx/nested.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 879183c1bfa5..a9c126f702d6 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6878,7 +6878,8 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 	if (copy_to_user(user_vmx_nested_state->vmcs12, vmcs12, VMCS12_SIZE))
 		return -EFAULT;
 
-	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
+	if (is_guest_mode(vcpu) &&
+	    nested_cpu_has_shadow_vmcs(vmcs12) &&
 	    vmcs12->vmcs_link_pointer != INVALID_GPA) {
 		if (copy_to_user(user_vmx_nested_state->shadow_vmcs12,
 				 get_shadow_vmcs12(vcpu), VMCS12_SIZE))
-- 
2.53.0

