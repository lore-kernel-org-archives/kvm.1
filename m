Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC6F396B76
	for <kvm@vger.kernel.org>; Fri,  6 Mar 2026 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814923; cv=none; b=Crl8iAoNgngXqMq0mvgj9m9OhAEKjlKWvppMHiIVZflbfSNSOPlMSBPfhz0R75bDKX6sr6Swy8e1MuVP9ApA7BjeI82vM0u4N96oNdXxoHQ5n4PcWeXT7PQze51ubMfo18ZZ468WM1lMvMMyBJUmU8ZJTurZRtJa2orYdlVKKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814923; c=relaxed/simple;
	bh=Dn7lHsHJzgWeOdy/kkyhlFzB8fwBn38eRfLOB93zuxU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OxCDgKDpvWBZhxVB/0Fv5difPFoZBgtoFPkU2kvwqUMOhLyDed6LIQPKH2STlfLYSNJGhJ+NtQpADmp3MTbg5nFvVa57I79XK5HWQYJyEIptqFcFkAFI8u/0ToZlK4kmp9CAiB/vnlW4Yrso06R3K5xckRfSKmo8XpL+pIwTNIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dh6dLrI6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dh6dLrI6"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae59e057f1so64532625ad.1
        for <kvm@vger.kernel.org>; Fri, 06 Mar 2026 08:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772814920; x=1773419720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DquZyRH4SqVhjA3d7wMGbHzzOoe5pUQf3Zgxi/ZUE08=;
        b=dh6dLrI6regOmIYgTPzwm06GC4KGoODf3FXkbHDEAvWimRyDBOHggDgDaUhjcTmj63
         LcJa58POEJXKCaX2LN06oTfcNGFAVN1DFpOeiHB+a19yWYQem37SPNWHlDBuwlPG9Tj2
         KWkk34YYobKN/tQtJW6ae9bQjnpSJXdl/iJfsysx50a3gr7Wd8a/iEZwX1TkCgx68JYs
         waioiDtr85zPDqAnACJ31wc0zFiahtOOPRavdiJvhhCsvDN3Wn0rcDm94VQ+IrHfwWYb
         3JqJcQ3wOrDJjsoG+CB7YOjQ3OwC/KT0nLg7lHWiSqy4pXvb0SEo2fVyoYk0fE66fc6V
         mP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772814920; x=1773419720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DquZyRH4SqVhjA3d7wMGbHzzOoe5pUQf3Zgxi/ZUE08=;
        b=sFUmxhq2Vnfhb8qAeiKWwGS7MPbSl6hCBoClMzeeEZb7JDJY5dSUpPB/2s29TRzx1Y
         kj67EBxqMw974AuiSQUaYcdYFCs0y0nAJpo6OElsTHrtZEQisNcAnpy1T3iYQiZrCdcX
         GQYqQ+NLA9OrSH7aAdz3skHxv3KfnN0Hru9dwReWQAAClFkIYqNm1FvUSi6KeRcr3Aif
         zD2Fxp0rrbZHsP6MrgqDhQdX+YpZ46iBhU8nZYqtja7SiBb4T2wKAuAHzfB011vCueXr
         x93M1VhpOULbwRnhfpxjuvRsS7dWHh6j9pJs/IZYUINjALv5+e+IQBVs6LGKOsXCzSIq
         jhwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcPvtoUKs9KCKWfkOWu3Vj2o/jvjVWGVItPPX20CddGzKu2pbLgtQt5Jted7wXFHUF+aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL11nCgzwL5nO7wHQLuaKR7zV9Am4BDVuxt/KcmvXme2/XiDiw
	JNPvIqvc2kL69B65lnnmTHzi2usRx9BsdEzIsOqQe+3u3aLWdhQ2VdXhbgglmgU5gSCPz/VezZo
	r6GOwLQ==
X-Received: from pldr11.prod.google.com ([2002:a17:903:410b:b0:2ae:4482:4ee0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:13d0:b0:2ae:6778:9dba
 with SMTP id d9443c01a7336-2ae82458a43mr30977535ad.41.1772814920418; Fri, 06
 Mar 2026 08:35:20 -0800 (PST)
Date: Fri, 6 Mar 2026 08:35:19 -0800
In-Reply-To: <CAO9r8zP0qkjkEMYMc=sW+k+f+HGQMzh0H_Y0u3BeqqcraGYWcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303003421.2185681-1-yosry@kernel.org> <20260303003421.2185681-27-yosry@kernel.org>
 <CALMp9eSMtzDJn7tGtbj=zLYpcU7Tc7XjcWBRZH7Aa5YihSmN7g@mail.gmail.com>
 <CAO9r8zMhwdc6y1JPxmoJOaH8g1i7NuhPo4V1iOhsc7WFskAPFw@mail.gmail.com>
 <CALMp9eRzy+C1KmEvt1FDXJrdhmXyyur8yPCr1q2M+AfNUcvnsQ@mail.gmail.com>
 <CAO9r8zPRJGde9PruGkc1TGvbSU=N=pFMo5uc78XNJYKMX0rUNg@mail.gmail.com>
 <CALMp9eQMqZa5ci6RsroNZEEpTTx_5pBPTLxk_zOBaA8_Vy4jyw@mail.gmail.com>
 <aaowUfyt7tu8g5fr@google.com> <CAO9r8zP0qkjkEMYMc=sW+k+f+HGQMzh0H_Y0u3BeqqcraGYWcA@mail.gmail.com>
Message-ID: <aasCR-YNNkoT4axo@google.com>
Subject: Re: [PATCH v7 26/26] KVM: selftest: Add a selftest for VMRUN/#VMEXIT
 with unmappable vmcb12
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 06, 2026, Yosry Ahmed wrote:
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index b191c6cab57d..78a542c6ddf1 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -1105,10 +1105,8 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
> >
> >         vmcb12_gpa = svm->vmcb->save.rax;
> >         err = nested_svm_copy_vmcb12_to_cache(vcpu, vmcb12_gpa);
> > -       if (err == -EFAULT) {
> > -               kvm_inject_gp(vcpu, 0);
> > -               return 1;
> > -       }
> > +       if (err == -EFAULT)
> > +               return kvm_handle_memory_failure(vcpu, X86EMUL_UNHANDLEABLE, NULL);
> 
> Why not call kvm_prepare_emulation_failure_exit() directly?

Mostly because my mental coin-flip came up heads.  But it's also one less line
of code, woot woot!

> Is the premise that kvm_handle_memory_failure() might evolve to do more
> things for emulation failures that are specifically caused by memory
> failures, other than potentially injecting an exception?

Yeah, more or less.  I doubt kvm_handle_memory_failure() will ever actually evolve
into anything more sophisticated, but at the very least, using
kvm_handle_memory_failure() documents _why_ KVM can't handle emulation.

On second thought, I think using X86EMUL_IO_NEEDED would be more appropriate.
The memremap() is only reachable if allow_unsafe_mappings is enabled, and so for
a "default" configuration, failure can only occur on:

	if (is_error_noslot_pfn(map->pfn))
		return -EINVAL;

Which doesn't _guarantee_ that emulated I/O is required, but we're definitely
beyond splitting hairs at that point.
