Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139152;
	b=TqUukheQD+BYAACaOZj9SVuUPSJrShyhdwqM08PZEzfbfjaBO4hz9e6C94ih0Li3Ckbj
	 +du1t4bMdpfXdhJHFZqB6cYCpIJ4Eu83yHSBQqHoXYp9Pguc2hD6srMR1joxCd+8Rv0ff
	 D4zHM1yUHD0HSEThu5PMejzp13kExwTX42zmcizCc7fsNvh7+pTlhrJmEQcwPj7zAOk5R
	 rs2AG2nJ7s74doe0FbiVHCwcK/bKmkFvT+N3Xzu9EPQ978nuiT7FzauocBPjrx4CYbS5F
	 Rg/kJerLr2MDteEqppgHW2UGvKwftM/T2smlLiBts+WY55vMe1vgV87pVclH9k/1SVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=uF+GZpKK7NjsO1exIpL/wQvgd3ehG85WpQ6BvbS1JDc=;
	b=OgsMBr8Pg1af8ahVw2J/eS/nXipZEpM9Y+gaeBH7IGmJvqiFVxfG8LarFpm1YfoENby6
	 iN8JC0OQiVJk3d3ohi0R+EDOv6fXMAYNLCwo5+iIB7n/Xr64fwJYlJPCQNAuAqtZl+th4
	 yNjVyCxCzt1j03i7vezJDhsHf7YOgeihYDEaWRire9OUQ1kotTz21zwCeNaGUxc6mO64d
	 6KbpQaF5AYRTZnfupkPGLOJqqsy+oZakNPLxsalImzgfK3bcNFadFAhQN2mGNyQaDEfR2
	 wGpGcw+NahIJsMjnxWrMzwZNEUSgh/fy4byFupczhC/ood2Qx53IOIFyxnB0O5cb0JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p6UGDPh9;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533CD60A3817
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 533CD60A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p6UGDPh9
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3adad90c894so368887a91.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139152; x=1793743952; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uF+GZpKK7NjsO1exIpL/wQvgd3ehG85WpQ6BvbS1JDc=;
        b=p6UGDPh9Ftza9g+YHhU9n44XQ4T6B4w6NuwLgO3M/Gq8IqHJ4mI4SJrSSxuEI1QS3o
         dOPsUJTwqH1Q4XGF8l7vNqurH/zycd6eILmoSohEK5A3zikP2SPPBNKn8hVS0aUKQRN6
         YigAUAQzOOgWBQ7BKUlAwU9tFu/sKbDEyVKUkL6Ez9dsN1r0jjifgVU+coS9nAz8+pZV
         LtBrtPMYSrkIm7VUtsKbLdf1xA4P84RsW2GZWzg3Q4v6bfCtaibM2hS3m5IiN36ptHuH
         to8VyrO1JJXlUQuSxg9Y5JxL0gSXzLdz2fp5x2bq2YtWT/jaIUT5IS5a8bSwgPRqkJNf
         vOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139152; x=1793743952;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uF+GZpKK7NjsO1exIpL/wQvgd3ehG85WpQ6BvbS1JDc=;
        b=FB+UjJVYUtgYBi1t9TltN1ON9zjrPBdGlSX0JeBVr+LEqM8UWejxq7LgFziJkDDXhM
         b1nL8G/9Bv32o28aBo+YpQq91+694tAf6ucuM4tPJ8L0ZtEla3S14kyLDC7iTd/HoGCv
         4vE5+EPvjncOIQeLm/B8/nCnd6+qAhWh5kbJxop6OSKwlBc2KD5rvycsemstoRSjvd21
         oDetuYFY1UYUvADXm4W3yxBqAnqHIG4ujHB1PLcSyHP/XbznWTMX3OTMPplDNHXjLMhP
         GAMlhNRNSz/uTYsSoIlN42kIFOmqyKTd1pX81mfnHJN+L7gn5B/s9ALV5l918qO9ZKsf
         A17Q==
X-Forwarded-Encrypted: i=1; AKwUvBwgCk0+dbKqXR/tslRBodlfxOR4YmUqaTP7fGYGZ3X97QpKSdTkoD9XZH1CZFRxGP8SA+4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLksmp5pV0iQtiIJbpjTU7xbJPiUkPQzBBxEIsU1wm9gAqJsJEZ
	lBoLCa96tLNvmcBetEx5I9I3A/UbqlCpoG+ENODQ64kXaaHIjQItS6DcAZIiKGwTZaFyRMAQjnX
	04QU40w==
X-Received: from pjyp3.prod.google.com ([2002:a17:90a:e703:b0:3a8:28d0:2510])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c5:b0:3ad:50a2:9abf
 with SMTP id 98e67ed59e1d1-3ae582adce0mr350233a91.38.1793139151657; Tue, 27
 Oct 2026 15:12:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:08 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-16-seanjc@google.com>
Subject: [PATCH v3 15/15] KVM: nVMX: Don't load+put the vCPU when freeing
 nested state for a dying vCPU
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Drop the vcpu_{load,put}() pair when freeing nested state for a dying vCPU,
as nothing in what was free_nested() requires the vCPU to be loaded, common
x86 doesn't require the vCPU to be loaded when it's dying (because SVM
never loads the vCPU), KVM now explicitly handles taking the vCPU off the
PI wakeup list (was subtly being handled by vt_vcpu_pi_load()), and the
rest of vmx_vcpu_load() has no effects outside of loading/modifying the
VMCS or vCPU-specific metadata.

As for put(), because the vCPU obviously can't be loaded at the start of
nested_vmx_free_vcpu(), "guest_state_loaded" can't be true and thus
vmx_prepare_switch_to_host() must be a nop.  Similarly, the vCPU can't be
blocking when it's dying, and so vt_vcpu_pi_put() is also a nop (and if
it's not, that would be a fatal bug as it means the vCPU would be left on
the PI wakeup list after being freed).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4a8f57eb3277..51183520f64a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -330,7 +330,7 @@ static void nested_put_vmcs12_pages(struct kvm_vcpu *vcpu)
 	vmx->nested.pi_desc = NULL;
 }
 
-static void free_nested(struct kvm_vcpu *vcpu)
+void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -390,14 +390,7 @@ static void nested_vmx_do_vmxoff(struct kvm_vcpu *vcpu)
 		free_vmcs(shadow_vmcs);
 	}
 
-	free_nested(vcpu);
-}
-
-void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
-{
-	vcpu_load(vcpu);
-	free_nested(vcpu);
-	vcpu_put(vcpu);
+	nested_vmx_free_vcpu(vcpu);
 }
 
 #define EPTP_PA_MASK   GENMASK_ULL(51, 12)
-- 
2.56.0.307.g5fe7bd680c-goog

