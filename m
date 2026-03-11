Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E14E2DA759
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773262217; cv=none; b=QAY6FwDtzLYtQ0yjm99/f9RZ/CMSmyNBSkEI1tnnG4DiXTu0s/unlp/VN0iruOwIedmrDCBHfRfZ5RsqSd+iaAGXfJYYEM4Y/D8CMOSnrwRK42A/m7uUsDaZQ9PoRh14T6/rJTUSAHars0/MgDpEs7lO5bT1Xh3linpeGWWzg9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773262217; c=relaxed/simple;
	bh=9vUVXFhaxjT8B8YHSADsXQqUGg9lvFPmYG7hKwYrc/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIGFGf6HGVRZojzXd2XHf+h9DWBF+CP+WNM/OaC7yDd25CiZUVgoLXeqf2oEkOMbE1SjJUymLxGC6rQtC5Ee2NW6PhRa/hHT6zWzHylNBRx3AiCCBue0jqvZhGafPW7RXX9dPPTpwbYcwSCfj4IQtSyWoA3RMHaZdvnplQkRmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4AkWSU3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4AkWSU3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CD2C2BC86
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773262217;
	bh=9vUVXFhaxjT8B8YHSADsXQqUGg9lvFPmYG7hKwYrc/Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u4AkWSU3aWels8DdCNI/02rcCeSdnQkEvtMEE0SPRCxvTEKAyzYUZVwSOhCc6EaRZ
	 ariCyFl8nw6ORxBS4dw4iCw07WOvWoxqg/KOCZ2whpkMmKqZVTgRDpTeG62GI5Jki9
	 FLx8nCULJhukwjH5tyde0/C1Wj9uQEtUU8bNM+rhwgozrBAIwyXAFq1JZMgJvyKN7p
	 ypsZaX/3ZCP1TmQr03RxW7q3srKYTvidhwFYnXj44H9bMMqL1UNcfxSZapb8LjVs8H
	 8i4rJgW2xoQRR36bmhItcbNf6rV2fw5THpQVa22BFCX11qLQ4BXkdRIP5WX+TlEwn6
	 YCQZzQeTSR5pg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-661cfb9f3aaso340663a12.2
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 13:50:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4ScW8fZ+xFGp/0Kx1EKrPSBu2oAC3WmTX+1qffDaEiRidTkMQPzPQy1MuBcCYTO8Aqxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5QG5KgXp7DT+HxtCaGevL5R+QgT0LVgUY0a73yza0bM7PpqOJ
	hxTrLTR/97cTK7AsvsQdzYjoIYmLiK0s7OuOfo4scYbSPHgrCLK6U/dmw4Bib8r2AyqAZuF74bc
	llqztPoxCGsFW4MG+3H+RizUzm0Bk6t0=
X-Received: by 2002:a17:907:2d2c:b0:b96:d85f:40c4 with SMTP id
 a640c23a62f3a-b972e167ab6mr238709366b.12.1773262215062; Wed, 11 Mar 2026
 13:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306210900.1933788-1-yosry@kernel.org> <20260306210900.1933788-2-yosry@kernel.org>
 <CALMp9eRWwPwUSyQmizy8i2tF1CVO4iLY6x0vX1OoPUiRdCm4NQ@mail.gmail.com>
 <CAO9r8zOhaDeYWq_6TNdPGyEE323o_8xsWTozGdro9Oni8310kA@mail.gmail.com>
 <CALMp9eScswzFak+PMOcaDXM-W+cXtkG7fQ=jadq__+5JeqYcTQ@mail.gmail.com>
 <CAO9r8zOK5+xmkf3FsWRz2wHcUCN30GJ9kfZx-K7DAa1HNGhRVA@mail.gmail.com>
 <aatyIPwz9ePKdzJx@google.com> <CAO9r8zMxk9yUiYoosnDygr_oeeRYHz3f7hWLm23c5Q0m-DXnWA@mail.gmail.com>
 <CAO9r8zNHYswypRmHVT5Qn5hFU9-HU1t=Gs3qAh05xRNn5krPXQ@mail.gmail.com> <abHTE5uyEZ4cW-fc@google.com>
In-Reply-To: <abHTE5uyEZ4cW-fc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 11 Mar 2026 13:50:02 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNxtSbHjp6EkQ+QbKavL1hn1WQXgQQ+d2=6AZkW9-mVXA@mail.gmail.com>
X-Gm-Features: AaiRm51wYnktYsrMFn2RommgfZfy73RztSIkzUiPCsKRrGbpKC2AYtWXp28FHv4
Message-ID: <CAO9r8zNxtSbHjp6EkQ+QbKavL1hn1WQXgQQ+d2=6AZkW9-mVXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] KVM: SVM: Use maxphyaddr in emulator RAX check for VMRUN/VMLOAD/VMSAVE
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > Sean, I intend to send a new version today with 2 main diffs:
> > > - Use cpuid_maxphyaddr() here instead of  kvm_host.maxphyaddr.
> > > - Use a common helper for checking RAX for SVM instructions for both
> > > the emulator and gp_interception() (see response on patch 4).
> > >
> > > Holler if you want me to wait for further feedback.
> >
> > I just realized I cannot just do cpuid_maxphyaddr(ctxt->vcpu) in
> > check_svme_pa(), because vcpu is defined as a void pointer in
> > x86_emulate_ctxt. Looking at commit c9b8b07cded5 ("KVM: x86:
> > Dynamically allocate per-vCPU emulation context"), I cannot tell why.
>
> To prevent dereferencing the vcpu object in emulator code.  It's kinda silly
> because common KVM is tightly coupled to the emulator, but we try to contain
> what the emulator can do.
>
> > I was going to move emul_to_vcpu() to arch/x86/kvm/kvm_emulate.h, but
> > maybe we should just make this a normal struct kvm_vpcu pointer and
> > drop emul_to_vcpu() completely?
>
> Heh, talk about scope creep, that'll open a much bigger can of worms and subsequent
> discussion.

Ack.

> Honestly, why bother keeping check_svme_pa()?  Can't we just do the checks in
> svm_check_intercept()?  E.g. vmx_check_intercept() already "injects" #UD for RDTSCP.

Hmm svm_check_intercept() isn't semantically the right place AFAICT,
and more importantly, it's only called if the instruction is executed
in guest mode (i.e. in L2+).

> Ha!  And dropping check_svme_pa() would technically be a bug fix, because the #GP
> is supposed to have lower priority than the #UD due to EFER.SVME=0.

That can probably be fixed by calling check_svme() before checking RAX
in check_svme_pa().

I think we should keep check_svme_pa(), but we'll need to extract the
vCPU from the emulation context one way or another to check
MAXPHYADDR. We can cast ctxt->vcpu or pull emul_to_vcpu() into
arch/x86/kvm/kvm_emulate.h and use it.
