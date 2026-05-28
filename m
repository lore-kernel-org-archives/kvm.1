Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816DE317158
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993214; cv=pass; b=rpTtNjHi6QV3J2QOOPXL7rXmXO4dvHWSuLLIiHQogdwYYeN2qthuO7d3YhpubPW3NAkPU36plDcjJ1Wle4Q1swdJS8Mg1jECkmNc4I7rhz0XhFKmHJy5xlBVa60F9U5uDOPl3/0PFLPr2Flmt4uVDDWgsD1fEpwgztwrPr7GIKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993214; c=relaxed/simple;
	bh=Ppb817bzRtNdqefsX9PQ7sZnHjM/MR5bByGhoQxVaUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcwXlcWZ0SZ76RY7duTliUF13KMveVnV2x/ykRADlkPgD0kqmSDCxDqJygcsTMLdyAbZfVeKgOYimNRoYSLPIuZ+q11yGon7nSu8MsUFg3Y62JuyEOyf8PEykum1jJmLwV+V0Qn4+2xDQL9vLAo/fZC98hNF24pFZdvjzERlstw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=La9+GTH7; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="La9+GTH7"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-516d1ddcdf4so3691cf.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779993212; cv=none;
        d=google.com; s=arc-20240605;
        b=WC6cTMPX2pWQYi6ZJ+bM38qzKV5/SgjcFfEDDDcPNFKswWjOFhhYL5iH7hA6N0wO/D
         mZJzK9aA9E77ZF2xjaJ61Lgy+qfix+ccMWgKIZW0nG3Wun491H8AUoQAVt5GGwd+yZoF
         z16IuoktuRjDBNf72HSzmowHAftFMtp3dyo3axn71TYp6pkpgfzHsAqe4DoSCiBgIYUg
         OyThztHEYc7JRZy7zcjkhRQWE/sB6IqrXPpwHuhksBpJYgeLAWfB1AjsB9WnJn4Ktw7L
         EF/Bt9GhsZEg7mQvzP+LfFzClwsKLP08lkLqWrT9fbcWwDWRbaA69aP/vPLaDHlVu5bj
         agjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8GUHjGyui/Ils6qL59KIp+/r5MshBC/5T8zpHUnaWbQ=;
        fh=EBc7KIBj53jAQHhxLIujeF0z4nI+MiaamDmBhbFQZ98=;
        b=MyZnTFhe6ozm+qupHOcIfDvtrJM5oS+mZtVfnu/MlrNAeMtyNnZT+SMoqaAy+CAnZM
         nHF/628v0cAHHVnJvCxMEcLhXE/0W7l8/sIgUmPaUEeG+J1T8ShFmjXV3/aeRKmlUjnq
         sVI7IDprFnND5IJ6csSUwV7X2rhoRY5rZbBSOEynLfcxT73rBvpv5HaZq+Leebw9a02G
         +3YeFfyVzFbngaqnjtCxJyLX0N55n8WHxges4pITLgCG2qUh3MIgQRUXdbP7kacGYpS4
         ErOhbS3EvXqCuWmQECyaLlUqcK8J3scjNZw1Ti5LVHp3anNuuVeF16DBOPxVvYqPLcQX
         uo1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779993212; x=1780598012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GUHjGyui/Ils6qL59KIp+/r5MshBC/5T8zpHUnaWbQ=;
        b=La9+GTH7x8cbq+O6G9wlQl2KAct/SSea+zRVAI6HmT1OBwNcJmkAq2hp2kFPbZIeqk
         7WM2yS+Nrv3Nt5TGOqwc5axaog45CEvemXW3gut1CHxQxHmIQrCXWbvojMPSuaLJTu58
         mbCVrLwsZFMIW8WiZbUqg5njULH90nnTwVfJj9nU02jNwakqkoUCnju4otoi2NjGnDcc
         wykjEB1RXE8JEEzUu8+dUlR6fXfV3seoaAoTPEKJDxEd8CoKZhgmGFPF1gKTLME9gwNB
         +MErOL8my+DvrTbulTsiDtU9YCtFpjLvBY3/xpF0HmUb3QZU2OHrUd3DEEfUWw3+1PA9
         Nnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779993212; x=1780598012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8GUHjGyui/Ils6qL59KIp+/r5MshBC/5T8zpHUnaWbQ=;
        b=MXwZmyfDZcRWwlC+Z5L3mDNrpdbCcHFVW5poBlvdvzhwvYp/FJXt9V1JU495baPnPd
         wA31fkNh3RLMqMN2355DqaTqY5OBgOsgTwXDnGdt5wtiTTZ7hiT1hHDT6+JjSRv5pMj4
         Mwk9yno9n0Wzz0uM4FkPdjREvskol4vAsNZjAkwt3rZ2ejTuMOA3XMnpfYr6X0jHhZ/6
         xZhnSgkYztjI57qRkBvS/xR0U5O3xc9g7zbCCqI50HyawdYZ7l+UKXzZF481ow+4ELXe
         YwkepdKJYT8xl2ePgRxbAcx7js74Ne9ICO2IIImvxK2ozmWe6CRIIVQOMjq/esgILJIY
         UzRg==
X-Forwarded-Encrypted: i=1; AFNElJ/QIGzrN89l2mBK2HRx08S7QsOJC6vRsiDJtdQUR9S/28w9Fjvg8SG6LqLGY+gKkfI8TlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwaV1mM5PBYRe+pByfxWuEpqKNSQgWtp9Rk8nO46NfFhdOT1ki
	Ma3muh8ijrLw81Oy6EKQSjI1M6A/+BUf+/SMNoN64pTFsY1KT32dQpdmigCU3GXw0774V7Y8M4G
	I6JbWr+IiZN74m1gB8Ns3Tx8wT1hn9iyEO6Yt+pCC
X-Gm-Gg: Acq92OG4eQac6Ro2OR26JY2UP9DCyf6BnLneCnE2z43unnn9MK5PnmC38sGDaV3uwbL
	57KdFh89Xt5Sgs8EMPz/5rSNMh+nMz+29XoxL4T4bewk8wvGq7xg+QMf/2Hj0p4dzlXO7ACA7tA
	tNHLq370X3v6q9J7Ox0XI35NPtOqj+Dsf5DIj5LrgXY6SPhv7n1Hn2rphGrFSxQoF/ifr3uSeB1
	VYKMSe2mYeNCiVadY9ZhcoPHPApoMjFeqajm/wADc3fafFbm0SSyyUESPp4s8tCxEcpSRCibUOm
	6ZtOLx3bAfBlmEXLMA==
X-Received: by 2002:ac8:6887:0:b0:516:4f62:85e6 with SMTP id
 d75a77b69052e-5172c8d7f31mr216891cf.17.1779993211840; Thu, 28 May 2026
 11:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527120600.20696-1-pbonzini@redhat.com> <20260527120600.20696-4-pbonzini@redhat.com>
 <aheD8XjfMrL9wGFa@google.com> <bfc136b4-106b-41dc-a161-b39ca8d63161@redhat.com>
In-Reply-To: <bfc136b4-106b-41dc-a161-b39ca8d63161@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 28 May 2026 11:33:18 -0700
X-Gm-Features: AVHnY4I_A-NZ8KOxwEGlELAZ4I4SMhhZA-pCOPIuInR6T-gqryQwaXKU52mRN9I
Message-ID: <CALMp9eQrvHjO4RtWYdqDtzWiXvBgfZA93FxM9nB3KVF8syeZjg@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: nSVM: invalidate cached PDPTRs across nested NPT transitions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 1:44=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 5/28/26 01:53, Sean Christopherson wrote:
> > I would rather use kvm_clear_available_registers() than add yet another=
 API,
> > which isn't even a good fit here since SVM never expects the PDPTRs to =
be dirty.
> >
> > Though I think it's a moot point, because nSVM should be clearing *all*
> > lazy-loaded registers.  It just so happens that PDPTRs are the only suc=
h "register".
> >
> > I haven't checked to see if this would actually be correct, I'm just mi=
micking
> > the nVMX code.  But conceptually, I think we want something like so:
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index e74fcde6155e..0c6ab00766b1 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -1303,6 +1303,8 @@ void svm_switch_vmcb(struct vcpu_svm *svm, struct=
 kvm_vmcb_info *target_vmcb)
> >   {
> >          svm->current_vmcb =3D target_vmcb;
> >          svm->vmcb =3D target_vmcb->ptr;
> > +
> > +       kvm_clear_available_registers(&svm->vcpu, SVM_REGS_LAZY_LOAD_SE=
T);
> >   }
> >
> >   static int svm_vcpu_precreate(struct kvm *kvm)
>
> I actually started with something like that.  nSVM should indeed be
> clearing all other lazy-loaded registers too (except there isn't any).
> I ended up doing it the other way for two reasons, both boiling down to
> PDPTRs being weird.
>
> First, the PDPTRs are cached processor state but not a field of the
> VMCB; changing the VMCB should have no effect on them.  For SVM, changes
> to their cache state are purely a result of writes to CR3 or CR4.PAE.

Huh?

The SDM says, "The behavior of PAE mode in a nested-paging guest
differs slightly from the behavior of (host-only) legacy PAE mode, in
that the guest=E2=80=99s four PDPEs are not loaded into the processor at th=
e
time CR3 is written. Instead, the PDPEs are accessed on demand as part
of a table walk. This has the side-effect that illegal bit
combinations in the PDPEs are not signaled at the time that CR3 is
written, but instead when the faulty PDPE is accessed as part of a
table walk.

So, they are only cached as part of a partial walk, just like the
entries at any other level. And, unlike Intel, changes to the PDPTRs
in memory *may* be visible in a future page walk without changing CR3.

> Thus it seemed more explicit to single out the PAE+nNPT case when
> loading CR3:
>
>         if (nested_npt)
>                 kvm_register_mark_for_reload
>         else if (!load_pdptrs(...))
>                 return -EINVAL;
>
> instead of the slightly more opaque
>
>         if (!nested_npt && !load_pdptrs(...))
>                 return -EINVAL;
>
> Second, with nNPT it's not even entirely correct to cache them at all.
> Strictly speaking they should never even be marked available, that way
> you'd go through load_pdptrs() on every PAE memory access.  Thus
> kvm_register_mark_for_reload() could also be tied to the CR4 write, but
> in any case not to the VMCB switch.
>
> I'd rather keep it like this but yeah, it can be done either way.  If
> there were other registers in the lazy load set, relying on
> svm_switch_vmcb() would make sense but you'd want to add a comment above
> the two instances of "if (!nested_npt && !load_pdptrs())".
>
> Paolo
>
>
