Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395294;
	b=wrvfkX2btviw/sqFqaqAwCo/9O3ICV0RAAg2mwuCTXLqAIBADg5l7wtHuOtAfu31QAID
	 aFvD2fMfYG0iz6KfETcCjWBBAAI0rdoBDaHk5ioezihvkj3iimp2IqGj+BCe8Xmt3fV8C
	 bm5hncu5TAzlOgFTiEw7UQO416hde+/ovXm9Vq1mJUZ03CZC3dpp5aFAAzRfIcrlLnnXv
	 sCbmSLtz5KkODhDLe8ZxVFFyAEXR8KzRWd5UMCfSVgvrwvED2hXByxir4FQJoNtlK9UnF
	 f6x+I10W3gjPBQ5gvVNvf/Se+9OseI5vX6xniiuTz1p9DE16sNCLh1XV0v107j1SIZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=ThXh/PpZVawaCwOY2TL0ZJCsO7ZffHOqKGZR+ZoMMAE=;
	b=AUdDHPgfo0IpqijXowLWaAys6eEqEjjH7jWGdydi5gfeP0gYdMtVID6nmdu5GGxcbUpo
	 y9+wXHzbCaUskiUb5JNFt4Kv2jpnoc56FP2up+AMX+sn/U5vWPUudCSPVy9Pcz7wcQIe8
	 e1AelnrH5RcsiaenJQn4/ed0/1S/c660KiIrlq8LQTkHNGv+PXGe/JQd8Qyi7ar6EQprL
	 6jUmPBUskqf3AQVDfODml+PBZJ0+HqFo+OZeh66Ei2DIDOuJ0A/ttX87AA3Cl2QVPx+ce
	 UxznJdZ8KqT+O4HpvNwxaaH/P1cwnJNmC0NwnbrNVeYAdf9eUJVhpO7jE8rAqqe71xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RkmU8gSO;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A8606CE6F
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE5A8606CE6F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RkmU8gSO
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ab926c236aso991093a91.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395293; x=1794000093; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ThXh/PpZVawaCwOY2TL0ZJCsO7ZffHOqKGZR+ZoMMAE=;
        b=RkmU8gSO0fKC8a0ylR/zmMRN0+f1wOiV0ZSK9VQM48njxcic4M/Me1oWDqfYvvbBHT
         kuO/BM3dAYhHqXPA5SOULgl7mb1qfhuRSbD9wkzqa918qY/KPFSeb9mA0fLrYQPYP7dl
         x1Vb0NCuzNtN2PgI02VTN3G6YLlSKbgHpvi5/vdDxLJ5AZKZ9nCuvAsOrvVsdNGAUsst
         KY7SagjkwMgxtazTZJvFM1kmjZ+WgXzgYaZ1yVN3HQPTfPRuHgriB8GrezRdMx4wmA+y
         Q9/M09AEIiEktcNS1QfXI3bh9URB4XP1wKWofO2hrK0pu6mgTV/lfR7bUM0cozNtI8iM
         OmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395293; x=1794000093;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ThXh/PpZVawaCwOY2TL0ZJCsO7ZffHOqKGZR+ZoMMAE=;
        b=msDvJfmPpyS9zVW7XC7XqvvjzddlkRYqnmEpEaur6UdvF9dMh0zArCjlBmuG0alnqF
         3SfJVLhCgMvGItwUJ0KO8xNgO4PIjukaUouZas5uoHxEIgjNpV7fHAS+iAC6da17TCho
         SL8VWQ/OIdJ+yaRVgsk88hB65sBhxTPZiVbGkbQ8M51MfVdzrNvjyvlHLr1zgtT4NoiO
         qQzvAV4myBVKRbnXBNiyKXtfFVp7NdlxuOFjjpRQJAmPmBSlJ24N9nmwAN/lF+WrTAhY
         wpqTVN+K7SUSBrhuveX1OmgYlULk5UoDRbBmxrrLk3eD/YwXVLuXtWWKL2KNvpW/jK+q
         vhOQ==
X-Forwarded-Encrypted: i=1; AKwUvByJigw3lTjs14bRuiJjVZG70UBKarp8zC0FNUrFyxPRo/sh3YAK8eolr/uDiMrgo0hW7gY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4FoHVJzOzSEdsAR04w0yIM8cb1qzA8NVG+Cna2QytNA2A0zqk
	lPNaoxLYZWfx+iprBfYQJCOmdNZKxrpzq5L53pMjWnAoqPp8LLJE5vGF/jghtdF4Kvvu+oL/oM4
	KxCTQzg==
X-Received: from pjbir4.prod.google.com ([2002:a17:90b:4684:b0:3a8:74c5:5a5c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2741:b0:3a0:e4ce:31fd
 with SMTP id 98e67ed59e1d1-3ae896f8304mr3027164a91.10.1793395293218; Fri, 30
 Oct 2026 14:21:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:04 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-17-seanjc@google.com>
Subject: [PATCH v4 16/23] KVM: VMX: Explicility free vmcs01, not the current
 VMCS, in vCPU free paths
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Explicitly free vmcs01 instead of the currently loaded VMCS when freeing a
vCPU, as relying on loaded_vmcs to point at vmcb01 is unnecessarily risky
and confusing.  E.g. during vCPU creation, the error path relies on setting
loaded_vmcs and obfuscates that it should be impossible for vmcb02 to be
allocated, let alone active.  Similarly, if KVM were buggy and left vmcb02
as the current vCPU when freeing a vCPU, operating on loaded_vmcs would hit
a use-after-free *and* leak vmcs01.

Because KVM isn't buggy, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d433cd846ac4..2ef1f634e7ec 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7515,7 +7515,7 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 		vmx_destroy_pml_buffer(vcpu);
 	free_vpid(vmx->vpid);
 	nested_vmx_free_vcpu(vcpu);
-	free_loaded_vmcs(vmx->loaded_vmcs);
+	free_loaded_vmcs(&vmx->vmcs01);
 	free_page((unsigned long)vmx->ve_info);
 
 	if (vmx_can_use_ipiv(vcpu))
@@ -7614,7 +7614,7 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 	return 0;
 
 free_vmcs:
-	free_loaded_vmcs(vmx->loaded_vmcs);
+	free_loaded_vmcs(&vmx->vmcs01);
 free_pml:
 	vmx_destroy_pml_buffer(vcpu);
 free_vpid:
-- 
2.56.0.385.gac671c819a-goog

