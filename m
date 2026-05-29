Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421A3C13F8
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093368; cv=none; b=cdnfpANrpCZowXim1UDeFCNiAJqesLl9aFu94NOVC/oYvR3TihI36uK5eSBX1o4g/ovu1xQLkUgpXYJ4yv/1ajnv27CdhxuM/UY7pvSEloNArlR/1wclVTeuVMpHD3xVOQ4IxYIe4eI16tUDcWkFtNFos65xzaz7fqulnNojX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093368; c=relaxed/simple;
	bh=kHQdd89SpJpJbZYHLaSOdch/rT72KJmxA2Z0ED5ycMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RsJqUCuAk4PRKZEKU3gSWX8NBsJiVgAAatrkluBGV3jAxErQVYqjIexm5xZeXbP2hQfIKCGWSG3aT8wiz5ywRSDq1ySQH8wH0wWQkqGlomaeU7ib8E93WUxNjxodKRTuq7Tw8PpLxCHORAhsFaMiSjoyoVQO2zEKtGqjYbtORtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0fdLgfW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0fdLgfW"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3663cbff31cso9707242a91.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093367; x=1780698167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6RQHD5fTjvOKMw+g+RyJJ/KDM3+OIdVSezR/Zl8r0J0=;
        b=R0fdLgfWOBdT5OtgTCeGyrxtPWrxLUuFjAwfa0kr+Eb2S4i4+773kFvlOhqmaj+5qK
         9nMES+jz8PLxHT6KeNAJe4zLdqx9dlp+No6FyrsBPzN/VGSa1mcBTdvjV6+Aj5SjODN+
         j7T+wM2thm3X4t4hXFb64Lj1yrdyOIX9hVmNmvD/vuQpLlo65vJL1S5k9WquVB3svXIS
         2LueXMuIl17/FQufuifoUtx6NPEXC1GJ5jWJ7AA7DR1XZCwAjLYdUeidt+q/J83jYTLU
         fw5mmTeF0AmPsuMSvrMM+M//yCCBMfng8A6emhfRRh2SeZCp9v1uktin8797j7y0ljIb
         gObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093367; x=1780698167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6RQHD5fTjvOKMw+g+RyJJ/KDM3+OIdVSezR/Zl8r0J0=;
        b=NIsW2HNnqRc/n9lHDv22qjubmjSYDEWEh2wvsII2kcWSAozMUaD3RF1KW800Ld9WOr
         5Lg7+iSPnBt5TJ3v74QM+xQ9wb2UJUmcMgy6CGewZZ+UgYv9xXSv8f3PyIv/19dwSN9b
         oDvMaRHUoCwG9vZjjGUHK67LaKPzXm5i06nXUu4y/sox/N0su+Syghh8VfGOWNs2v9JY
         4kuH/XgVsMTzvy0vHVQ1IX4xlxMscfjuMwSdoiUPZOKT2Z2aObczJnyil5OmzpTMzEnD
         1QtGprR8IGJq17HRjoevImXs9AjYr6ar2R7vIYnWnB7lWQ2pKDniWiSVgum2xghBZn7v
         FqWg==
X-Gm-Message-State: AOJu0YxC1jEEccB8rwzeEyaodCFKkHRSj/qdGZyQrElXEGbmT1fVGMev
	O8O6wsYqLHlr26WV8It1jGBl0gKBQQ8H3Xz65P0DheKiW31MNoac2jRSiuoE1zEkE+9ZOF2XVGB
	S6QjBNQ==
X-Received: from pgnp18.prod.google.com ([2002:a63:7f52:0:b0:c80:dc0a:9f7f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:20c3:b0:3aa:ec28:edc6
 with SMTP id adf61e73a8af0-3b428248dcbmr1208955637.39.1780093366486; Fri, 29
 May 2026 15:22:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:46 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-4-seanjc@google.com>
Subject: [PATCH v3 03/40] KVM: x86/xen: Don't truncate RAX when handling
 hypercall from protected guest
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Don't truncate RAX when handling a Xen hypercall for a guest with protected
state, as KVM's ABI is to assume the guest is in 64-bit for such cases
(the guest leaving garbage in 63:32 after a transition to 32-bit mode is
far less likely than 63:32 being necessary to complete the hypercall).

Fixes: b5aead0064f3 ("KVM: x86: Assume a 64-bit hypercall for guests with protected state")
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 6d9be74bb673..895095dc684e 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1678,15 +1678,14 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	bool handled = false;
 	u8 cpl;
 
-	input = (u64)kvm_register_read(vcpu, VCPU_REGS_RAX);
-
 	/* Hyper-V hypercalls get bit 31 set in EAX */
-	if ((input & 0x80000000) &&
+	if ((kvm_rax_read(vcpu) & 0x80000000) &&
 	    kvm_hv_hypercall_enabled(vcpu))
 		return kvm_hv_hypercall(vcpu);
 
 	longmode = is_64_bit_hypercall(vcpu);
 	if (!longmode) {
+		input = (u32)kvm_rax_read(vcpu);
 		params[0] = (u32)kvm_rbx_read(vcpu);
 		params[1] = (u32)kvm_rcx_read(vcpu);
 		params[2] = (u32)kvm_rdx_read(vcpu);
@@ -1696,6 +1695,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	}
 	else {
 #ifdef CONFIG_X86_64
+		input = (u64)kvm_rax_read(vcpu);
 		params[0] = (u64)kvm_rdi_read(vcpu);
 		params[1] = (u64)kvm_rsi_read(vcpu);
 		params[2] = (u64)kvm_rdx_read(vcpu);
-- 
2.54.0.823.g6e5bcc1fc9-goog

