Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395301;
	b=aHpOS9j2L9tFv21F5laTAr4BF3nLHvYmEHKnoIIQidJe5Kdm1/hJ7xLPuikeAjwZlzfY
	 8l6xPwdd6h5OxDBxjHDVaSBXpjgw4Y8AJedST6lNBeCf8Q21DInIW+rX79UcQxtuwQUG2
	 anoWGynyYQG0xQ/xO/OvN9x3DIm6KN+7eb5wBdrhvydbaEmpOihOxQZGSP0t1SkgtrP6A
	 cCbd7+7cmnYZaz0MzmF5OZzWxksuzYvXQmLh7y/YWxqnJKA+AEcpodsCY2yhasgjFH3lm
	 Y5i/M12BYLPXEid1GjbC6GcRsYgIPHr7Lit4qDpaq1QhsegtoKFH6EYhkrPcfyVSzgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=5FKhrgmuBOI6zmiBkedaxKopKidBxwZmFCvEG3c53fo=;
	b=4wOiF/zU0gLYdZIDDHrXMJE4oev/BCY5UYtBjPWLRkeY5lfb4DIfubxwjNGxNdNytuxl
	 rpfpZge1PP5mY0Rr6YHp/CJQ8Zrbbz/YNlaJl/9lOXWUoHZSEvcdvFKyYIcZ/8vcjdZjW
	 Yk8q0i7AIr3oEksvtjPlldxLAVnkcrxNmgbpGLKyAUpNvgFzp6JV63Kq4hL1n+jLQQv2I
	 xlHTT/0Afvwpv18mqXrscoppNF5M/zoPsAMnGmkvQ8UgYBmy33JnFi9Y6h67LGRSmCpqj
	 I3nOSQx99RHiqsv2Fbs+NT3KjYpGb3Ajh2n9llyP2dtmRnGR9iNlXqzVJAuvOt40YMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="ere2/lcc";
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF660701D2
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ACF660701D2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ere2/lcc
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3adad90c894so1232663a91.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395301; x=1794000101; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5FKhrgmuBOI6zmiBkedaxKopKidBxwZmFCvEG3c53fo=;
        b=ere2/lcc27eNxrxNs+g/wtc7nCAhUB6ExrqPny7khKZ7U9gJDx6jNpKUW45FB9WFiO
         Jns71PT+ZtwZ4wW8G/DUQwRrukq9/6q0Ai/b9Yr6Me/oE7dM97JSajHR1qAdUT6+a5B1
         OIHGmJXlrc6rwa86724IhFutpisdDBZ39YjafvmdGNd5i/D6V50mDPG0wPcd+P1stBzD
         p4lVPQ2XIIDXHXXhp8xfaaY+CCruhAeQiMHKCBD/N5tHFrfoBrDMxjcbg7ALtaHpsNHc
         zq7X+u+fv0nMLRpuyG5pvIyB+gudbNmn3zGoSyGTJUQlr4vn19GAZmMkTHwinTiAhDrT
         gT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395301; x=1794000101;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5FKhrgmuBOI6zmiBkedaxKopKidBxwZmFCvEG3c53fo=;
        b=RlVzeQyX5rprFQ4ZC+b7YgsTxDeWkrBkq/MROVNP406HdUo7wGWE5gUEV/lHdBOfDW
         5ORJhORskMX2bVu4x2mQk67HyOcLFP8p0wbyLWldlFdYCjkYfap0aMeE+hkKH1xbjs8v
         3Em/P5hjrBTFW39cX2TJOZ6IvfaTbMLiNXSzyLo3g5PmnlCVan6dVRz0rrLG4UsyIvmn
         ml7SpS11j8H5wmWHy75+HOLgPRbc9lCMNhP2DKJQbiK1nMtmeuiwXWRdBtspiNJHeYUe
         tbKcjV7tzmdeU9UQBgDcQmwEkXKnAKEJ+tuWojSLV8J3/6e9XuPp1sjdQL2PJqxsGMW+
         PyIQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6t4B88+FAKHxiNwLHRd7Jdy24u+Al2gCClYmyxd1ia/c6eUnwEJsI4bQr+YI/hHg22ao=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcrHCJFDxT4ZvZNexYAYRuM4vMqb9FEQGTUG8K9biUM3RkvoAY
	FSssmew7a4tJhxsIwXMmT9krjSRDggwAFTRzGNqnzQGihv6lh6B0un7iNK99BGZSDB7foTMioh+
	KkGp0cA==
X-Received: from pjbpj10.prod.google.com ([2002:a17:90b:4f4a:b0:3ad:6c5f:feb0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e70c:b0:3ab:2737:3393
 with SMTP id 98e67ed59e1d1-3ae89835d94mr2921939a91.40.1793395300614; Fri, 30
 Oct 2026 14:21:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:21:10 -0700
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
Message-ID: <20261030212112.2598640-23-seanjc@google.com>
Subject: [PATCH v4 22/23] KVM: nVMX: Don't load+put the vCPU when freeing
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
2.56.0.385.gac671c819a-goog

