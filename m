Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954A3A3E7A
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073403; cv=none; b=TaUtdivX5ZNZh3G/hgdo2O/NrsBi25oZm3lcKJw3HWiZXVtqFco6NOrUcmjeJPrPLivWwWMaoMD1ye1xShmjirWLunJPApGcsngGDeVS+Kw+hNNo0Tv0bFmg3/fc8MNl6xC3RYXAjhnF9yYsT9uAao7QmHTIifhTAYS23n0piEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073403; c=relaxed/simple;
	bh=joRLrHQ5PciVlyhcB33kf3F6lW7tZpKQ6/AfYULRl5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f3GRz7UG5qByodQgO9p7dOlj5MQ6hlTjZdOr86JB0TGG6A1ZIHmEidR0WwZVw13zGUysnuHbFbY/lGPJLLNI2SokWD/MkgssD/ws3GuTX1E1Ar2q0tMpFdxxNpt04IfEzJ0ED663dY8WTWLQM3p9THYavI+zwsTTqNncKVqaYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Np5AUfL2; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Np5AUfL2"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc73f47bdcso858825ad.3
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787073401; x=1787678201; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XT1Rr2HB3t99psvHxumchfGyXnfabp1WpWGCjDa/GZU=;
        b=Np5AUfL2O4OezMvs3azRdaKaZgofDKBPxJuu0gx4igsxAsunqdbTSIBKTChVeUSHtc
         b1nID7nGKvn2z7Z768olmyFLz634sw2VP8aXBPBQeABBdRTSoRVHvpiN7Qw7kvZNNg96
         aM1sezhQFogNBIQalFFSY5Tbxsk0/aN6d/H3ENx515V+7pWKa02VpeJBnHDrZzs5UcLZ
         F4l0jDAPyqhAJvEVym7GrDZsuQ7MdExkMaqK7PkTqv6Kjfxc8fOrxhizl1bho7fedVVS
         VygDaGsIgnGu2MkkS3DA2bguOxQg/EAU5ep2qI6aI5w6LA/bzll2zRN5G13Sg3R2PINg
         GBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787073401; x=1787678201;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XT1Rr2HB3t99psvHxumchfGyXnfabp1WpWGCjDa/GZU=;
        b=qm5WH3ZnYbVSA5sq204sHrhl20mpRSEmi1lcC01W2gmqmR7NH+hTeNJNxsFUx05zEH
         8YzACwB489AafC5xQ/JngmEpni2/rbidSSu+ktsea2ndvrlGn1kMQnWm1nXaMgU8GP3h
         HoaMOi3gYzHxrKkMiQIQFiq4xw6fuMNkUlkONeVwLR58HbrRsO8kJSf/b+QCJBNEpd9+
         PLNkCZIHoPJ2EpnfNdlHEnzqrONvWGm5idkoBtDDzeIlzfeB42vaQ4UKJXBUo3ofGm3L
         ie1//CnGBVrXPTrJRRvl+IUWekx/34506XgYxq+Dw8/zPhu9ng0v22UEObp3Vb/tx8YJ
         T2EA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0Tcs+BuZ8vkhmb3E0LWWFCLWQ/3+g/Q4LKE4woCLCEkBmCwf3pH2CqMEG9PYU1K7UmUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7SBDktDrf0tVtPCQ1+Sv52BeZIG2E02cC9iuXvUBVZOpEBcjz
	X+EVMO6WOm+UdWx1OZ0HsL339LMajOGxE+SxD6Yh9pa/7kgjNMeoS3By7QEfn4KFs9IGMEBL8fE
	G/dMNCw==
X-Received: from plbiy23.prod.google.com ([2002:a17:903:1317:b0:2ce:7984:4347])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a2e:b0:2ca:9d5a:8b6c
 with SMTP id d9443c01a7336-2d5c4ee9bf2mr149762845ad.5.1787073401220; Tue, 18
 Aug 2026 10:16:41 -0700 (PDT)
Date: Tue, 18 Aug 2026 10:16:40 -0700
In-Reply-To: <20260818170534.07B561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818165258.2613603-1-vkuznets@redhat.com> <20260818165258.2613603-5-vkuznets@redhat.com>
 <20260818170534.07B561F000E9@smtp.kernel.org>
Message-ID: <aoSTeLzhaWohymLf@google.com>
Subject: Re: [PATCH v2 4/4] KVM: selftests: Check VMPTRLD with active eVMCS
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 18, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Code relying on CPU flags after `KVM_ASM_SAFE` incorrectly evaluates them because the macro's cleanup instructions unconditionally clobber the flags.
> --
> 
> --- Patch [4]: [PATCH v2 4/4] KVM: selftests: Check VMPTRLD with active eVMCS ---
> commit d5821824a958c354147206d0cf6cf26eaeb71cc6
> Author: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> KVM: selftests: Check VMPTRLD with active eVMCS
> 
> This commit verifies that VMPTRLD triggers a #UD when eVMCS is active.
> It uses the KVM_ASM_SAFE framework to safely handle the expected
> exceptions from VMPTRLD testing.
> 
> > diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
> > index 047d02aa96889..e6adde3970d4d 100644
> > --- a/tools/testing/selftests/kvm/include/x86/vmx.h
> > +++ b/tools/testing/selftests/kvm/include/x86/vmx.h
> [ ... ]
> > @@ -336,6 +333,22 @@ static inline int vmptrld(u64 vmcs_pa)
> >  	return ret;
> >  }
> >  
> > +static inline int vmptrld_safe(u64 vmcs_pa)
> > +{
> > +	u64 error_code;
> > +	u8 vector;
> > +	u8 failed;
> > +
> > +	asm volatile(KVM_ASM_SAFE("vmptrld %[pa]")
> > +		     "\n\tsetna %[failed]"
> 
> [Severity: Medium]
> Will this setna instruction incorrectly evaluate CPU flags?
> 
> The KVM_ASM_SAFE macro executes xor %%r9, %%r9 on its success path, which
> unconditionally clears the Carry Flag (CF=0) and sets the Zero Flag (ZF=1).

Shame on me, I should know better after dealing with ba5ca5e5e6a1 ("x86/retpoline:
Don't clobber RFLAGS during srso_safe_ret()").

Untested, but I think the fix is simply:

diff --git tools/testing/selftests/kvm/include/x86/processor.h tools/testing/selftests/kvm/include/x86/processor.h
index 6e6f70035508..119715ffe93f 100644
--- tools/testing/selftests/kvm/include/x86/processor.h
+++ tools/testing/selftests/kvm/include/x86/processor.h
@@ -1318,7 +1318,7 @@ gva_t vm_alloc_stack(struct kvm_vm *vm, int nr_pages);
        "lea 1f(%%rip), %%r10\n\t"                              \
        "lea 2f(%%rip), %%r11\n\t"                              \
        fep "1: " insn "\n\t"                                   \
-       "xor %%r9, %%r9\n\t"                                    \
+       "mov $0, %%r9\n\t"                                      \
        "2:\n\t"                                                \
        "mov  %%r9b, %[vector]\n\t"                             \
        "mov  %%r10, %[error_code]\n\t"
