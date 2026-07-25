Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9742F9984
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785015216; cv=none; b=MDs+KxcY2VhkDJtugZRxb22GMCtWuYtif12/kDMn5vKaUckUKCcxJCFzvsX6+faeFYVe3MtpeMyywOHQ6ANS8KPYPYNYak1kx/wrBKP8JRtVWVQQLFuidQdMF0iDe3NcmSYjjdH9tkNRN7AhkviIaqk0MDcanNNhLcDIEWZNs6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785015216; c=relaxed/simple;
	bh=3eTFd+LJNi6mLsvarswrfEHEhjqlWSzvOhKLJWRRSjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0HJxpja0spnLb4XNDoFp2bzYymVuv7ilLmCH9WEOZrhMG+T8p5WqHKAx5tzF1SwKzZ5x9MSh5oJoJU862QYzMBwWxqkSsGE7wPJkWaIAutP82LUctwhxN2zwUrEBEaTUMUzSxMlIHwnPxoBRyIxebCvWS3/+2tFXEyD48Q2l1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jagyBJzA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jagyBJzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654EF1F00A3E
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 21:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785015215;
	bh=nildwvJW0t8mv7GB/eMKUpYMlOJtCITAgrOfZD8hPHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jagyBJzAma0IrNURleYxryw20DaIeE19hwBKr1GoBXk2s2mDBC7bTeytCQY79U05Y
	 swm/ctywRYcwb0+oAFblT0xoCgmmIsnGponM5feBLQMjNiMAJWEK0XAxyiWRG8eaK0
	 aWvRhgSRQhS9tLtxmnhmlDPiKj0kEKRxIKFiaZLpADqwBkNAR1O634ie66QWFx6JzE
	 t6RSkXutPMPXP0KMOmtXHZMS1qu7+GdMTnM4mYsDvxZyPzn6hx6Z9P+8yxUQk3piCI
	 1B2a3CGAz2R9BCu/pAY91msrv8gJZZ/5jfIHBl/Y9Ny5CkwYwRqaJrsEzvglaPoujz
	 z8b0kQmUjSSQg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15e592da74so177646366b.1
        for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 14:33:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoyaH0K4rZk6gff1vxlPnkChSl1Vg6kAhAsf5xf2As8EGGzE0snirSulT/nkKPpyA9hx8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqfOcRrvr14W/1luxvy9rScTs8ECWKn7xIAxq16IpjoI5Yp6+9
	Bsuc73rNDDrxGu+T8lcmeYfmJUUCjVGWaivbGYp0RYdejpfdRLD0v79KqmeD5AVDxwibQ03AfKj
	mKVPW9jvlIqKa0DB3CAMkg99FFbSKCCg=
X-Received: by 2002:a17:907:6b06:b0:c16:386e:6b14 with SMTP id
 a640c23a62f3a-c1f1f433379mr131351866b.57.1785015214285; Sat, 25 Jul 2026
 14:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723094419.630204-1-pbonzini@redhat.com> <CAO9r8zM=Mb=eTEFGF0G-POvwwbSr7e8SN6zcDp=GstzKtBKcow@mail.gmail.com>
 <CABgObfYhsq-h4t=onAhCrbUX3p0beFM9jvj3bCKY8r2bRs=y-A@mail.gmail.com>
In-Reply-To: <CABgObfYhsq-h4t=onAhCrbUX3p0beFM9jvj3bCKY8r2bRs=y-A@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Sat, 25 Jul 2026 14:33:23 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO6CiKo57aqZpbOKwfoS-xGvuAg72AN8-M7MO6u6P8B7w@mail.gmail.com>
X-Gm-Features: AUfX_mxUCJ0378bSrxXTIhOC4Sr6spbV5Ygj8Q3gh4dKEg8-pxkoLC_t8duZ0ew
Message-ID: <CAO9r8zO6CiKo57aqZpbOKwfoS-xGvuAg72AN8-M7MO6u6P8B7w@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if
 NPT enabled
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Alexander Lougovski <alougovsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 6:32=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Il sab 25 lug 2026, 01:44 Yosry Ahmed <yosry@kernel.org> ha scritto:
> > > +       /*
> > > +        * INVLPGA has had errata on Genoa and Turin, and even on old=
er
> > > +        * generations there were reports of Windows BSODs if INVLPGA
> > > +        * was used for Hyper-V tlbflush.  Use it only for shadow pag=
ing
> > > +        * where it seems to be okay.
> >
> > Is this an actual errata documented by AMD, or is this just an
> > empirical observation?
>
> There is the VMware knowledge base in the commit message that requires
> new microcode:
>
> > > For Turin, the microcode version was 0x0b002162, which (assuming
> > > this is the same issue) should not be affected by the problem listed =
in
> > > https://knowledge.broadcom.com/external/article/419026/bsod-on-virtua=
l-machines-running-on-amd.html;
> > > on the other hand that problem should not apply to earlier processors=
.
> > > AMD has not provided any information or analysis yet, and when we ask=
ed
> > > we didn't know yet that it reproduced on Milan as well.
>
> and I interpreted that as an erratum. But we reproduced it also on
> Milan and with supposedly fixed microcode.
>
> > I ask because the APM says:
> > ---
> > The input address is always interpreted as a guest virtual address, so
> > INVLPGA is typically meaningful only when used with shadow page
> > tables; it does not provide a means to invalidate a nested translation
> > by guest physical address
> > ---
> >
> > While this is terrible wording, it seems like KVM should *not* be
> > using INVLPGA when TDP is enabled
>
> While it is certainly an odd case, here the guest has requested to do
> an invalidation by GVA on its behalf, so INVLPGA should have worked.
>
> "Not typically meaningful" is a friendly hint to read the manual
> twice, but reality seems to be more like "doesn't actually flush the
> right entries" when NPT is in use. Especially since Intel has INVVPID
> for the exact same operation and it works just fine.

Yeah I agree that it makes sense that INVLPGA should work if we are
just flushing a GVA on behalf of the guest (e.g. guest making a
hypercall instead of INVLPG).

I think we probably need clarification from AMD about what the
intention is. Is INVLPGA expected to be broken when NPT is enabled (in
which case the wording in the APM needs fixing), or is INVLPGA
expected to work but is actually broken. IIUC the erratum you referred
to should already be fixed with the new microcode, so maybe there's
another problem with INVLPGA?

The third possibility is that INVLPGA works as intended but the
Hyper-V code in KVM is broken in some other way. I am not sure if we
can ask, or if people at Microsoft can answer, but it would definitely
help to know how Hyper-V handles these cases. Does it actually use
INVLPGA to flush GVAs on behalf of the guest with NPT enabeld? If yes,
there's a good chance it's KVM that's broken here?
