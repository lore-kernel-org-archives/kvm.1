Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700857;
	b=1ANIX9CNBpGXu2nh709RIHqsK9dXOkr7ONymwbK5CxvzRHN9YFgpoj0Vdm28j7EvPq+N
	 kLvlPv4hy8v+/ztbz6wnnK/x9m79UymP8wPhs9pa0Evi4getYWne57rtGt0V9C/FbP0lN
	 QNH7gJTgpQ1zBT2ghW3diUMBcxYVGKscU/dXySaodqfIZRRbxtBLanED1+vxEQjX3AX0/
	 6583CFhmaKn1ppt5sBNjLpNV2jG6AnfUeD/dcPN0PoxgVWk2UX/ClirtD+KRLH6B03W/c
	 RvSTl5EO374afVszTq+jHfEEa1Fk/nkz3imhBuXX5Dy6sUf7IueHDehwtlOj7GeEjKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=CmlLUlHh19saemg7b3QpaN9wK1Oa5vIw+YCFEOWdibw=;
	b=jme+Oqsn1gxCiMLwQahsC5Z9880LkErKdkR9nao+drg4GcQ+BRgu745tU6kzW0/nxSK0
	 /DYjtPiMPxB+e9tudqaair5uEECmYvwT0uSAm1+xrMhBBCdwS/znLmdgWw2+DIl5wokmd
	 +C0Ss1tB8ilrsnID5UWkslj0Bc/7ez8BRvpVn0O7TZ0mdsQyzp8FQmKodRvbUueU/wK2G
	 WEr2Bqr/ToN57/sscJTkrkh6FPasPs3kMV2t6Ekcy6yAWDvh6+60mNRaeJxGUljGP+lHS
	 B8ay0XStCTGnJRUr3VQ6sjb2XDrj8EG61PxSh/ewUG6ySJAkPzChpJIfPNfRh56qk7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OfxH6KeJ;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64C606A31A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 20:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA64C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OfxH6KeJ
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-88c768885b4so304518b3a.0
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 13:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792700856; x=1793305656; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CmlLUlHh19saemg7b3QpaN9wK1Oa5vIw+YCFEOWdibw=;
        b=OfxH6KeJ7E67dvFuBfGD9iyfsgfriMJHxkJvWXC6G0hjmQDrS9CoeYgEu+ffPUr1//
         84SWNiFXCxJU3PQnH71Q7GPEOMMvfXKddLW/GAm5c65KrSw/mQyH2q0jjcYcLYN06jyk
         tJqBAjqsg/gSwUC0yqgT6QWlbmjWWR7opoeAsMIPvwrQEJZ7bZpIX7+jWHWCWqTFxSXn
         B8GV7THukFvINvVQ4VJJESPzpIKi+ceP5DTkbCogYMFSOixMxXTgyDvwHIjY5hkOCPCI
         BqMs9mAk+n7RQnrbZhIeS67J0Z4maZV4jbYZm69GXcycd/7u2FlBGd/qvJCPZvq1QEVa
         y2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700856; x=1793305656;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CmlLUlHh19saemg7b3QpaN9wK1Oa5vIw+YCFEOWdibw=;
        b=LBx5bSkWNvdQlw9gJI8LZhsdDMNmxTMx3LO50JhJ8Mueesnan3XJcRkqk7XI5gjL2V
         uGQSdkBrMftkOtv1z840DXjCgCcl4hKWj3oNLE6BwJ+qzsxLows3JiDFYugzZZC6C3r2
         eiQC4z/jc+kegqu2qMaNrHJKzNCJCxOEnujp4wfp4rXxBjsbcZrNLFxw+2TkvIc7lK+K
         tAVh1/uEPLYQZ8EvExhuxF+gvSFIMgwXEFVIxcD3aQMO8tNegEd5WfqGIrM0PsVzrr0/
         uRV+KAcUWAHd70GlFRpD0rRPDh3ElwN5XltgD/B1iyO2KwhE/PzsVI+4VwbKWvBd9zF9
         dZRQ==
X-Gm-Message-State: AFq9FYK4k+hfhfKoL3Ot9VxrsK4EDHVw27oX6ofL5My+kcQoXvHX9cKW
	pscCMJson/EUzVPupXGjRSrCTbw9PkZQhnDaWks/fhXcVAaR0w10KLeoEtdOVQyhZ2pUXnQXZj0
	VO7GYxg==
X-Received: from pfbb9.prod.google.com ([2002:a05:6a00:ac89:b0:89f:827e:eb47])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b16:b0:89f:e248:5727
 with SMTP id d2e1a72fcca58-8a2c5e3a37fmr256625b3a.6.1792700855792; Thu, 22
 Oct 2026 13:27:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 13:27:33 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022202734.592745-1-seanjc@google.com>
Subject: [PATCH] KVM: nVMX: Nullify cached vmcs12 pointers if entering VMX
 operation fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset="UTF-8"

From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

Nullify the cached vmcs12 pointers after freeing them if "entering" VMX
ultimately fails (because of an allocation failure), so that if a stale
pointer is consumed, KVM hits a NULL pointer dereference instead of a
use-after-free.  I.e. crash the host instead of providing a potential
guest escape vector if KVM is buggy.

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
[sean: rework changelog, drop stable@]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..3509a84acde2 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5463,9 +5463,11 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 
 out_shadow_vmcs:
 	kfree(vmx->nested.cached_shadow_vmcs12);
+	vmx->nested.cached_shadow_vmcs12 = NULL;
 
 out_cached_shadow_vmcs12:
 	kfree(vmx->nested.cached_vmcs12);
+	vmx->nested.cached_vmcs12 = NULL;
 
 out_cached_vmcs12:
 	free_loaded_vmcs(&vmx->nested.vmcs02);

base-commit: 164405e8e9a0378c7e1aff2254625a6553a291f1
-- 
2.56.0.257.gf7497c7d27-goog

