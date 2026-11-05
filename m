Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905658;
	b=h2HLaHqmex1l+PCMpnMmdVm3QztVm87R4SpWTlyDNhomvV/kcATszEcZYKD9xhxM7NOG
	 WgGQzMsYcL8+UC5ikL2xhJk2giqCFbIl6PchlGJE42wgbM0nYdb6QGE2vqn3Xc28/CPSd
	 2x/0vA9eSzj0Apu7wS+SbK/NDMrZGtq1KnhVWVt0dXUulI985Mhn2mxOmGJ5Qj6hUfW16
	 6h/fko47TGYG3nSl1xNnYPcaMj4f+6U7PTwmVbooo8RJ8iNiNsqhKeF76VSdPvrwOFhOn
	 qwg31JwpVzCYRk2Gl4ynKEMkTnhJaba29fxjxPDBGjUQg0ddHQph7kfVdWHqpBl2fxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=RImlfGZRhzIDr+NgSiSBCyFCeHOPnTqcBiVWF5DlQGM=;
	b=EIX1tt6dGbzrFLvjI14HBT1quUVifpKEJKiYsE37dtQwotLhLLF5kHJXsE+8TzdOzkR2
	 CRri6WWqFtp46SI68TXX3Cr3KA5xvi7Ixu7bwODmc0Tv5/HZmhN7grWJ4YnjnIoINTqM3
	 cdF2Ejlg8VINSLObGbqQYHB/vl9cDyozHoBwnER49AVyJ8tpQn6X82TvZ91Y1SH+zI4lc
	 g+HO4KktmOb6xxFuhs+e6T6NzNpikWv0CgwZoPFtef7HPCQq5GOfEnc17fzpsWyxAsJfn
	 E5hoZ+wwVY7M86Xq8NrqSw9hfhQs+THctx50U3cARzq69YXkE9iBf1K+/p1TzOJW2Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AdJhLm6m;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2B1606A329
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 19:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A2B1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AdJhLm6m
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed08b07232so19818955ad.3
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 11:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793905657; x=1794510457; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RImlfGZRhzIDr+NgSiSBCyFCeHOPnTqcBiVWF5DlQGM=;
        b=AdJhLm6mql34JAg3z0aFAtzRel/U3sZykYE8DFCd1DuPZmWksgOM7QthliAKD2CEIu
         NPkoeg31Vb1lrbpacwm1oXOL/o/SjnefV72IGayZsF2bYXDqYzrevgG2hXa1u0S991VZ
         hglGSgsGGXiNwyiVTPVae1OUBW36Btf3PQjWLa5UC/9RPaFzS6csnn+OiusgNhX/LSC1
         PXh6q29umyNjwLlm3bGse3rjJ2ei2vy8pkOUgl/tAJ522pXaiQ3XVZzgzYpoNKOd04A4
         mVAx7Ob96gzoCUs1dGpxi8AophvY7lDgJtdk5rxXN6tsMXoyJPJ9jHfxmMVVcyMM8rDk
         JEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793905657; x=1794510457;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RImlfGZRhzIDr+NgSiSBCyFCeHOPnTqcBiVWF5DlQGM=;
        b=jpZr1GU7wSVTT4uJGXw+MU0ppHzgACuCc0p49cdcjspZfc09buMnxHGcyxj8xRfQEZ
         NKV225e7wmyNQ8onOQ7khbthd3O1LlSQ7Kd4v9V9hyRiPgMTsfwKDQWfOFpeUZ38N6Ie
         ytL7QkEGvAm7TtxxNRp4uyUrxC+INusLBFLfxa7pYIfedFPfdSjK0FF2m/HlptVTr6cp
         Xvl0XAChRtAtJ/2ePuIEoO1AomABRvsBSwAcR2HcyqmVpGBYBJpVNUvCkXkVxd8/XrER
         viGcxS8c9Qy6AY6xENmInlVN6MfHoKTXAznfAphFGJ/0YjrNs1ZpDnND1AwylCReOyvL
         kkoA==
X-Gm-Message-State: APuU4Z8IXLfg6VbQ9Ge6XZljVrYTnIsn6H/NeJC6wZVkjPYNlFjq8DNd
	1/FSa4DM48vMxQY0vpDJedsyRmLBrAUyNtv3JnnRC7xicuYU6ArTF/KyCR7E2/XlpD56ILKBtkC
	OciAeAA==
X-Received: from plbmf12.prod.google.com ([2002:a17:902:fc8c:b0:2e8:ad52:30e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18b:b0:2e8:93b5:c555
 with SMTP id d9443c01a7336-2ed40e29864mr5181435ad.61.1793905656447; Thu, 05
 Nov 2026 11:07:36 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  5 Nov 2026 11:07:32 -0800
In-Reply-To: <20261105190733.3741959-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105190733.3741959-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261105190733.3741959-2-seanjc@google.com>
Subject: [PATCH v2 1/2] KVM: nVMX: Do eVMCS consistency check on secondary
 controls iff they're enable
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manuel Andreas <manuel.andreas@tum.de>
Content-Type: text/plain; charset="UTF-8"

Check that the secondary execution controls are actually enabled before
performing eVMCS-specific consistency checks, as the secondary controls are
supposed to be completely ignored if they're not enabled.  Per the SDM:

  If the "activate secondary controls" primary processor-based VM-execution
  control is 0 (or if the processor does not support the 1-setting of that
  control), no checks are performed on the secondary processor-based
  VM-execution controls. The logical processor operates as if all the
  secondary processor-based VM-execution controls were 0.

Fixes: a83502314ce3 ("x86/kvm/hyper-v: don't allow to turn on unsupported VMX controls for nested guests")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/hyperv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index fa41d036acd4..2b40ac32ff06 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -169,7 +169,8 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
 					       vmcs12->cpu_based_vm_exec_control)))
 		return -EINVAL;
 
-	if (CC(!nested_evmcs_is_valid_controls(EVMCS_2NDEXEC,
+	if (nested_cpu_has(vmcs12, CPU_BASED_ACTIVATE_SECONDARY_CONTROLS) &&
+	    CC(!nested_evmcs_is_valid_controls(EVMCS_2NDEXEC,
 					       vmcs12->secondary_vm_exec_control)))
 		return -EINVAL;
 
-- 
2.56.0.567.gdb80ae8cd5-goog

