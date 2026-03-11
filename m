Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D776F367F3A
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189241; cv=none; b=BzIcimPD9kuySX55RDvT8vcxc1Paz46+F3eZCNHMhUBWlZ2ACJMptAEC3jwdaKKL5nHRv8t84TCt+yyxS1/U3CfoBJOl5u9yoH90PM8mNihK8iYehNo4A1bza45bEcdougC/nohEyoHN7uOr2hw+ikzZRlT3THC7n3UOKyymEBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189241; c=relaxed/simple;
	bh=LACfdw/zW10Jq2WOM8fA9MujAFua+8h+3eY59ooXrwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ldNjSZRDCLnrQw8lVX0wo705RnlvXoZjxsYud0XxFiimdtAIcXmEY27sR3P7xsxvoQX3EHmNQ5H1IoZIR/qh0PsB9LdVcpGnwGNDC+IjmerDAosPEAgEd1kqSPr5M5e68xbTjPIDCdlm8cz4+BUsy+5+bAZMR2omA2wCSH2EdpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jkbq/2Jy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jkbq/2Jy"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35984ef203bso10097736a91.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 17:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773189239; x=1773794039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/u7P5DGbuL3/Pf42zn0rgLVQxjHAQYab6nCFQbQkuh4=;
        b=Jkbq/2Jy60rHeJbj+EUjMqftsPLmsFxLbPQISUAmx+Tb4oDaggiwou+y23HYkV9SJp
         tj10gzwwt/36E+/VsCe6UUVoZa/8jBw2NN7wuHBi3v4UvccoHAP6w0fhwSLuFUcfOa8K
         Id3IS9gt7B/Luukm5zsbgFUoxQt7bUCS+o9cql4qGBXMPpEDhmF2uyUcpse8NWS9USLZ
         Su+/Jqam+X0hOGsLeG8Q/c3gPYoH8QUjg02NY2T9mc9r9t6ko64FEmhTrDcCG3jdqvbP
         n1BZweUVBAowPAv3Vym3SmEzNXl8GURlsMT6OSKCIxUv1oqGo6D0wqzwq3QL94J2pyZd
         hKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773189239; x=1773794039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/u7P5DGbuL3/Pf42zn0rgLVQxjHAQYab6nCFQbQkuh4=;
        b=pm9bePfFAmLtwmVOjnjvjuuoDFv6W3e6D2JUbQr5mEW3oWEmS50BXT8DaFZh0ESKNM
         us4ozChoCw8hveO6LeJh0TudEBT8oJ7eNbDrc8xYQBH3FOXQuY4RU8RUTkTt/8P5zlZq
         GELVSl/SHvx39+UtKj2zlEnmzs/kthxqHL5OTBW9I2czHgGGD+dOPnLnrqmTqhotRqvF
         IWqnj0hCJJ7Iu1Ifm8zxW9DMTAqC66iJ7+nydFMpWPRgu3PqsCOLglqxcXyBYSxrBdMg
         TuYRctBJZ8EIXJ3p0NYtDOl6eFdJ9hwhpweVCDWeSZ1Xt7HYG1JYbdA/vYlWDv4pMeVu
         13nw==
X-Gm-Message-State: AOJu0Yx8rAmindPfojCLl4qkZZEzfK6r3xW2sPgPqCVbF1M25d1w4OtC
	ua7KxG+CUN6GQXUBQIAWBZLI1dnnVBOUrfv8QlXsG+fdefI/KoDaXnf+LD9xCQCyXxKX92AiXc1
	e/9vRow==
X-Received: from pgbs189.prod.google.com ([2002:a63:5ec6:0:b0:c73:999d:a1d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d83:b0:359:981b:5dd2
 with SMTP id 98e67ed59e1d1-35a0124d192mr631149a91.14.1773189239132; Tue, 10
 Mar 2026 17:33:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 17:33:42 -0700
In-Reply-To: <20260311003346.2626238-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311003346.2626238-4-seanjc@google.com>
Subject: [PATCH 3/7] KVM: nVMX: Do a bitwise-AND of regs_avail when switching
 active VMCS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"

When switching between vmcs01 and vmcs02, do a bitwise-AND of regs_avail
to effectively reset the mask for the new VMCS, purely to be consistent
with all other "full" writes of regs_avail.  In practice, a straight write
versus a bitwise-AND will yield the same result, as kvm_arch_vcpu_create()
marks *all* registers available (and dirty), and KVM never marks registers
unavailable unless they're lazily loaded.

This will allow adding wrapper APIs to set regs_{avail,dirty} without
having to add special handling for a nVMX use case that doesn't exist in
practice.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 942acc46f91d..af2aaef38502 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -310,7 +310,7 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
 	vmx_sync_vmcs_host_state(vmx, prev);
 	put_cpu();
 
-	vcpu->arch.regs_avail = ~VMX_REGS_LAZY_LOAD_SET;
+	vcpu->arch.regs_avail &= ~VMX_REGS_LAZY_LOAD_SET;
 
 	/*
 	 * All lazily updated registers will be reloaded from VMCS12 on both
-- 
2.53.0.473.g4a7958ca14-goog

