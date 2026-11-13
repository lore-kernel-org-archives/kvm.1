Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548334;
	b=nKPLbFHPwwbXwo13irarZEwPrVV1R7pc2HMdYvPdGywS1lAFWG6ZEFpJAnGis/hedeST
	 sg3+y3qQsizdg1ZNS2TmWlK0skqcCJ2+B5pIh+mPhWNcTXGrOCLCKwRaxhVQys3Sqtn6S
	 ZE0Ahym8SYsKHJap35LkRnL326+Thz0hgC6Mtdxi84+l09FXaQE+lpfQxdczoXk9PUVFV
	 yPI2cSdsLK+3IKJYrSHBPrqMdOSlgWxY92MNYrMdSjPq4oWZFh+mkTOG6chO5/7LFbrwa
	 3gzZ1dw6gtOi6B/9HZ9FzfcTSwEJCnE979COgyzdLmCe74Y91GfVVJ+t7O/HYBPn8Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548334;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7PX0i8pHtQvjRW9g4b9HdYeYIOynvMYnFBHislzODRA=;
	b=HmtBngvhfsM+rK/61RFW1D/VPEUJ6YUa1rhkgfoqgs6qDlTjXjeO/2PH+bs74PQzsSSM
	 UvB9mUeNtpSJ3kgcjMkB0Rf462llhloHHvfqKo+EfZ2knS9ZBW+XvnjGW+wnVYxCkKVeC
	 lmuUjAHOzSS2dB/IeHCx4s2ZsuidZJoGUnZIZaAbcrUoDZUWF0AD8MRtDIVLGzewFHq9y
	 w8MkdCCC0mA2eRc5InfiBIIAKiDFWWfKmJBOI6MmNDm3L+bg2HnmAXoZV/IjRtP4JZONa
	 9VsRwuN3cWISFcWxJOfHbXT3URIVeBxswUYXmILFqo7lcGJ5vh0RidnojNEDxMTadCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dx9iK5mh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB919606A321
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dx9iK5mh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1231F000C6
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794548333;
	bh=7PX0i8pHtQvjRW9g4b9HdYeYIOynvMYnFBHislzODRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Dx9iK5mh5JGcPC1a0kVPN0MNX3vUf0cyPnz2syKaP1lW+7/k3bsBh+qUdP5S3AyWB
	 6gPJtg48CUtuGZCwTSuoNI27WH6s27lEJKCbYulv5Qw6/I3AWHSv1ketUDXg9lSwJ0
	 lg9LctMrUfqNWkNsJyoQSQwPL20WRFxMvM3hpbIi5DD32+SxhQzYFTZkaZUWxwtUKg
	 fGw3JPcyF1Zx+iGFmUAY1Ph1280Xky4OhmC8qvRakRz2BjH0zGAuWLn0EBR0yZxkD0
	 ihjR/gKUhCBpxPL7vPfTSrT1PvTYd3LIFcV89fdxoGg1kD4S228WNY8y/pEX+KdftN
	 MlHOTe7gOiY5g==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c40e30c26a4so113646266b.0
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 21:38:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGcj1BbjGEVohqO/3XORyfDCaqPg0J9a1wd7SRu0++wTrdVDKohsaEIy97nZ5D7pPXBU9g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PeBJxC3lVVK5AnBiiCpBogi78QtpHIstEzF3QFHPWgEA3gszm
	7EEvDKYLvi5EewWinNGhevrll7mb00RxMAV8jrwwzec+7WhX6+1mc+PjXep0x1v1CmSla9x5DMa
	5W+HEhM8PVl0oapeNmm6EtLbjNWVLITs=
X-Received: by 2002:a17:906:9c89:b0:c2d:c6e7:9e9a with SMTP id
 a640c23a62f3a-c509634a669mr114095166b.11.1794548332730; Thu, 12 Nov 2026
 21:38:52 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112212628.265262-1-jmattson@google.com> <CAO9r8zMkKXRT0N18haYG+=jyO6FvL7VE84-=n9kpm7vnARH5UA@mail.gmail.com>
 <CALMp9eRmJ8BpWHrveE=nTD6vF9OrB=OiwNA15_4Df-=kUzmMnA@mail.gmail.com>
In-Reply-To: <CALMp9eRmJ8BpWHrveE=nTD6vF9OrB=OiwNA15_4Df-=kUzmMnA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 12 Nov 2026 21:38:41 -0800
X-Gmail-Original-Message-ID: <CAO9r8zPUT-G4P3zWv02NUifs8c=NgBbcMn7PHzyp4j51bK3ung@mail.gmail.com>
X-Gm-Features: AclHuK8Y6jUiihNT_B2hmRUXB3Vg7dnIolE7NbO65Dtqe_M1bU3FpupggVD9ulw
Message-ID: <CAO9r8zPUT-G4P3zWv02NUifs8c=NgBbcMn7PHzyp4j51bK3ung@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Gate CET state copy in svm_copy_vmrun_state()
 on guest SHSTK
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 3:17=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Thu, Nov 12, 2026 at 2:41=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Thu, Nov 12, 2026 at 1:26=E2=80=AFPM Jim Mattson <jmattson@google.co=
m> wrote:
> > >
> > > Like nested_vmcb02_prepare_save() and nested_svm_vmexit_update_vmcb12=
(),
> > > svm_copy_vmrun_state() should gate copying s_cet, isst_addr, and ssp =
on
> > > guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) (i.e. the feature is adver=
tised
> > > to the guest). Instead, copying is gated on
> > > kvm_cpu_cap_has(X86_FEATURE_SHSTK) (i.e. the host supports shadow sta=
cks).
> >
> > This is a bit confusing, nested_vmcb02_prepare_save() and
> > nested_svm_vmexit_update_vmcb12() are about vmcb12 <-> vmcb02, so L2's
> > state, while svm_copy_vmrun_state() is for L1's state. I think the
> > patch is correct, but the examples are confusing.
> >
> > Perhaps a better example would be __kvm_set_msr() and __kvm_get_msr()?
>
> Or, perhaps I should just drop the examples?

It's probably useful to mention that without guest_cpu_cap_has(vcpu,
X86_FEATURE_SHSTK), the MSRs cannot be set, but I am fine either way.
With either changes to the changelog:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
