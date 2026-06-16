Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126312356C6
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639691; cv=pass; b=TF5opPmgEYkhapB+KwaOcpSVhJd5aODewUKJE61hbN9N0zlgkLydJeIWP9sNRvQkVSqFggrW9rw+YkI90oPekQpxfn4wTp+DeKQyt6LIawYRSwD4KkpksMx0Lgs4aCyf0JHFYOEqP3Kb5ykxU4e8XHYTuGhVweOtaqVP1sBhTJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639691; c=relaxed/simple;
	bh=rOreL9cMPNKjQLcaTXTeQFF75y3HOUoqRBuOPg2jGxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTgywdD2GgmWuZphkss4CxrBEVUT34LpVMPDktwtx9FlSHcyGWycjMDBjPGjBI3RDqjaeNPjQKF6h5Ii2VO4LmBAJ81BZJ6dbzS30wKs1QId3X7c7N/vZ3yKueSqJ3cRzEzGkVritCQlJwYIxKNNSnhJbRyy1g8IJIGsdLLudrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJugmJJK; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJugmJJK"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so3069a12.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 12:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781639688; cv=none;
        d=google.com; s=arc-20240605;
        b=dRdfL4nWxJqXMjaOer58VdWBe+45FmxOyaY8zhB0qCORYQdzuMVh3Bcff6aKZnyYPq
         VJWdzVRo5HwnNnNkSJKrsmyCWioOtJ0MUy3qkMK3Br5iW7L+KLVpMJhu3ZhEIAzOvq3J
         ONMdYIOeuJC/XcqlYG4scHQxPGWdEh3TPmLtGtrECKxQ4XHcQZsktPuwbsaVw6aowC9h
         Tcl7lacFLuPqXbXehroH2bMKtEcMnSSY5cT+vUrW4wN42m3V/LMs1jz37qVfeCyraNna
         nsPKC8ynWg3JLJjmxp0NSkvAfYM3W+Q812CuWYVbgoFxpjVjRxhzFdIljt53yj+DdL+K
         2wMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l/CgDRXCVmcvg8qX3Y+6ACmme2uqTw2HX6Xact+DTl4=;
        fh=IGuiwqyWdWNnWUbkIrlSdKxOhMaU3Ej2LI+KyM9nhac=;
        b=KWpiQAJkX3L3HIMgdWzwbnqv0S0b99iyHeapIHD/LyyMsWbTaNbRI1uKoJT668mLZ3
         7sdP6ekotm7hnKxPWlXdGCPdedXhHRjce6UbFWfNQzRde38Wljj+AEgrZuRIp4HazcR/
         pFB3N3+73xnOuqYA7foOiTgFKS9J85uCy0yZIWJGJ+kSLQW+glyHq9cHoyrOUFuznewj
         OUh94tTEAuNeDdarz33fnqajznbMQFN0W/B88vg3h0/nyc1vBVm9jFA1w+zV3sqiejge
         HpRDr+HmD5Ty0MNegv/KLwtJ+sNWdqr8r4kxupQnWu99xexYE+VAIkefGkD90zXPuJaV
         86iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781639688; x=1782244488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/CgDRXCVmcvg8qX3Y+6ACmme2uqTw2HX6Xact+DTl4=;
        b=wJugmJJKu9wb9tAOzjTtZkv5y8j08It+IAjUWRVd5xQlBNRrNcVDVl5sem5K0GcWn6
         0SIsf9cXoW96/3SXcJA2Zp/9v0ZR93x+rrc8wgzn3S8OR2ugj56e/MK6kfcESKhhdp4i
         xnwHaNJZsg1AFNaMBwPqtjxeMvI4IKIoQf/GZy+NBMrZhrJTwsmpKS8DEPaEkSIem+WJ
         F9WY6eRhXisG0k0E9FT7kgY0hdz9w4k0ef8ZiSXlwB0J4MYf0cvDAxOgFLlcOD1SyI07
         cGlRXNbOO3E0eJ3vezId5OVi6y8rKVYHGnpSSS/DsaV8iz8VCAlZKovk9IhKT7TjL+5t
         pwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781639688; x=1782244488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/CgDRXCVmcvg8qX3Y+6ACmme2uqTw2HX6Xact+DTl4=;
        b=PAn2D7zXjCUV5wtzzWCriI0EQHRyumcg/d8MrkiXJThLqgd7cirmuWGhkjHZI1bgar
         XIghpnDTsJxbnIj6dmVPOtMwPlGRUzM2WTZCwTUOITWCB8yZli51JsnMpqBI94caqHdp
         lwpTpakRf8C0vc34n6to2NXKaIPaSoAwBTCYNp1+g2bQ+77n4ns+eJQtnq6/UCduS14D
         ujRXWO3iQ3cjUCsIP31Vf5kRdVx6Jz6BmFyEiURmuKNZcyr4YCnGzYvJNhjOrxJRJ1JZ
         CxcKhSlpyV85PJWxuVXlnOsGaIttB6eGhpvqYS8tgxLa0UQVSsPQOpdwqrWl5WkDRa1K
         m8kg==
X-Forwarded-Encrypted: i=1; AFNElJ/ENdyd6rK7d0O1urOOL9IKYlGVzsIR1HPNmMNsdxOHfL6HPM4o3Ccq6OcHSaay3dqa3w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQeVY7SKbS1Fs3Xh8GwDEuuzQoGKeRTRyVf6xPv5mw2a6nvWAF
	dw735AlulyDNpRtVLuGyWX69AY2SnYbtJHPxpR+NFyWVuiWLjSJ3dfnRhraVFn2gjMyf3EnoRja
	axE6eWsYZgwNq5J6cav38t33cROfWR5UmuTwjx4msZGduxdx5wc5YGMvBXFw=
X-Gm-Gg: Acq92OFwnNp+TVk8jR0F9xKxvigEIPlcTzvwLj1eXS5NK5T0p5Xg/DmoAbMPKseXxXe
	NNplaNI32Hm5v69dHIEh3Tfh9Pn9YuIKPYqIilhglZrx7vwwbvCI1kdXYD0PZ4ftY3xsuWjuuGJ
	RgNOrYnuu5pqu8AUJ/a2RCpQqS2lzwmUOcBGRBBXzuheCX9x8NZ1k7UxZ89iWkhCAkkPfXA4Zrg
	LXgGKfvI6sKhaxzK5N38M49PiaNw4UZR81rBB57j0wCEkZS3oHG4qzXqxpuk6wALB/cLW31R4OD
	bWz7cjVTvEJg33kTAw==
X-Received: by 2002:aa7:c919:0:b0:693:3e06:8f4d with SMTP id
 4fb4d7f45d1cf-695476eb895mr8776a12.2.1781639687910; Tue, 16 Jun 2026 12:54:47
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-25-yosry@kernel.org> <20260616013031.53DAC1F000E9@smtp.kernel.org>
 <CAO9r8zPA6B72RDWeBMHqv1xz6o9dDHEEjwnMjwAwVwA=5qxaKg@mail.gmail.com> <CAO9r8zM1aKR6VzOhVq1_xTH5ZhSUBzYh-tr+ZzO_L4o28iy9OA@mail.gmail.com>
In-Reply-To: <CAO9r8zM1aKR6VzOhVq1_xTH5ZhSUBzYh-tr+ZzO_L4o28iy9OA@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 16 Jun 2026 12:54:35 -0700
X-Gm-Features: AVVi8Ccl5w4C_y5y0xOjMjz0BTS525Kww8pR3RSPvd9mlFGLN-xlUMmMlMC5JwA
Message-ID: <CALMp9eRS0EyqPqWZNkS0U=iH4mSt0snD44ufgXw7wvs9+o=a4A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 24/25] KVM: nSVM: Use different ASIDs for L1 and L2
To: Yosry Ahmed <yosry@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 11:28=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Tue, Jun 16, 2026 at 11:14=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> w=
rote:
> >
> > [Omitting the previously reported issue]
> >
> > > > @@ -1557,6 +1550,8 @@ void svm_free_nested(struct vcpu_svm *svm)
> > > >       if (WARN_ON_ONCE(svm->vmcb !=3D svm->vmcb01.ptr))
> > > >               svm_switch_vmcb(svm, &svm->vmcb01);
> > > >
> > > > +     free_asid(svm->nested.asid02);
> > > > +
> > >
> > > [Severity: Critical]
> > > When the hardware ASID is freed here during nested SVM teardown, does
> > > svm->nested.last_asid also need to be reset to 0?
> > >
> > > If L1 disables SVM, svm_free_nested() is called, freeing asid02. This=
 ASID tag
> > > can then be reallocated. If L1 later re-enables SVM and uses the same=
 L1-managed
> > > ASID, nested_svm_entry_tlb_flush() will see:
> >
> > Hmm if L1 reuses the same ASID, it's up to L1 to explicitly flush it if=
 needed.
> >
> > That being said, KVM needs to flush ASIDs when first allocated anyway,
> > otherwise we risk reusing TLB entries from a completely different vCPU
> > or VM. This series correctly does so for L1 (calls
> > vmcb_set_flush_asid() when initializing vmcb01's ASID), but not for
> > L2.
> >
> > So yes, we need to make sure asid02 is always initialized (and reset)
> > to 0, but not for the reason Sashiko mentioned. It's so that the first
> > nested VMRUN using an L2 ASID always does a flush (as L1 is not
> > allowed to use ASID 0).
>
> I think VMX might have the same problem.

This code *should* take care of it, since vmcs12->virtual_processor_id
can't be 0 if it's being used, and vmx->nested_last_vpid is
initialized to 0:

> if (is_vmenter && vmcs12->virtual_processor_id !=3D vmx->nested.last_vpid=
) {
>         vmx->nested.last_vpid =3D vmcs12->virtual_processor_id;
>         kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
>         return;
> }

However, Gemini points out that last_vpid is not cleared when L1 does
a VMXOFF, even though vmx->nested.vpid02 is freed.

Per the exhortation in security-bugs.rst, I am treating this issue as publi=
c.
