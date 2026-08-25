Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B337E5DE
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681215; cv=pass; b=SchGMeHB6vmCch6YT2wN6W6IifP4yr32tTjBc9PeBf2gPYQXQD9x5CVy7Ftm3jyaP90dAC+I6jYwFgom+abPjqyHBFieViF6lldlixzKGq1ii9WOJ9uB5mxeuCDafWRCHX1rpJRmfAJEASoceQcoIXMhWgGjncuwP7rXOw5l6TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681215; c=relaxed/simple;
	bh=0uL7MCW0qeeLr8z/9ii/U6tJWU1HTXtjC4HvHqgJAP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0bVNvaFIIi2LoYDJcjvGgfU2RCO/nzfdGQTCO8LdanYTQRjmqIoGc7caB6pfE9sJfQ3pYIyc/WYi4yRp0RHhzH5Q700DR7uu+a8bzqE7t8eXVQou2vZCKonsR3jFAlC0IIUfa+ZuA/8rtmdTIAH60ase8Oh8zr2YHAbnqdq58o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PlRN+cIQ; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlRN+cIQ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c197eaaab00so851689566b.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 11:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787681213; cv=none;
        d=google.com; s=arc-20260327;
        b=q5IRAIz4p7idSDCITJMU9qYnTPC2xeOI9fDC3BBclJQ8By3XElZnukWp4VGgJ7GuDE
         5J++FTdhUcZWCRf67f6JImBDjBEwBmYz8gprnkEKivCKXrxeTGtSU+2A3Xr8PnYf9byt
         djuNK9V/Ga6HU8hUxHBFqmhOl/aDgZQm8VIpH7QYn/zwYXPV6YOnHZashef7oa6u3lV7
         CquKMjEiuXaz5gKJ4NZ47PKn2LmXrDiG5w5sa/wCxR7TzX1I1h1myWaNHft+RccDP9AS
         0uL2JK9BpYVOQQ87QBvRy+IpgI8ZGKlCUrQV3cuWNtbboHexgYbvdYyHbzuTLDpe7I/r
         avEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hiUjNjrrNe3BB9qnJkoHXwV002FhgZjHOjsfn6vnCus=;
        fh=tmlnsDBPqRHd7ironJejYQiCBy654TIfDsEHrSAci58=;
        b=ac86qGbpa+cVHgdT6aCtYQna122UyRXnPhpxiCoqsB8ZObGIu3Iz0vyztjkDF6VPE9
         WNltCCBfJrh9HKLr9UVnRHDmkA/2sZ4mxljJlwQAUTbZYOPdAIv5SIbr3TWCo4efiOQu
         I76VYdwNLFDnWY5RvDvdIcvbxByANx9Nxs68O2Wz4SUwCG1xVi7KSb5yrq3etYLdEifk
         k+bglVrLcDz11csHyE/0lvrqHVRuAU9KDiE0PSYf7LEvjzcPRntV/LDVVsx8tiKicvvz
         HdeJjfvv/lHzY9P6M3T20TACK5xnXTHd/5CQexnX0WoX7q9DGGpIG0agOfv34jT/L4k8
         MWww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787681213; x=1788286013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hiUjNjrrNe3BB9qnJkoHXwV002FhgZjHOjsfn6vnCus=;
        b=PlRN+cIQ+qsMeT+jbfQwDPT+qMuFk/IyTB7rxkSKHUceByPUDmKd1t+02Uc18+eZGS
         vJebICxGuSqE7n2SvKDJwkOUbc1y+5JfJ8eMQsw2HoQCpHFLRqMXrmizjhtN546SyOIl
         0SuJiQlB5LGSbod+nOMJX588NIvqj0hGtZB4Uf4FA01MwvhMNucmClMH17kOUx2DzVPp
         FjCNYFyHIPzPGE77CjX5JlXtq0dD4XO0fIB+eb4hsCq7Hr3NuzHpobG8vOgpv6bsIYpg
         PCU3k5gGf/V3jNUJKVtNzM4R08RCfaT7bEKI8aoIiTTZwuxhcVh36HYnMDiw7cwKlX1T
         ae/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787681213; x=1788286013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hiUjNjrrNe3BB9qnJkoHXwV002FhgZjHOjsfn6vnCus=;
        b=Cd8sZ4l2oL0Thk6cZ7Q4G0BSAiu5vo5kW95zULsZ7uzkso2RzeG4f9dkzVX+Y+4FX8
         nH9oiMWQ1bjm5HcKYELKa6E7Bq8VD3JJWDwtdRzV71NIYgPJm7n/gIHAX8U5cK2xDMYI
         8kmIE6dLDJXfkGmx3G7wOiboFYRgFqKPZy7u0gb1TiCNiIh+eSft5RBTg0vOKvi9y2eD
         ZatwxdPygPJsFFKIFLNZcZD04wkmJwmDUKS2I1sL+Y+emlQ8PH75AOCQY0j1J3ucjLmx
         VuFui1rU5sjuntE4N6JQZG6lWclR62LDvMieeW73xhLClSQD9xOfr5p8XUfqNT2HgtB0
         6c2g==
X-Forwarded-Encrypted: i=1; AHgh+RrIhlcjtH0YFDGLG+YQSIMK4bP+Pl1NrSjD87nKLM1F5+stT4PlzFOoIoUOn/qHpehmHSg=@vger.kernel.org
X-Gm-Message-State: AFuF++knaPUgWTIfTVYi8OmMCwBcwIvJ8Z+yCmO8A75yo8q4AEwmoCie
	qomnkhVAQeiExGO9IA6xm4k9C+mVNrPhQNDPsZVav1+rMZr4zBOy5ALmf2hVy2aQprtWVMo2GY+
	KD6dpF25i3xKBbXpQvJsKHIYfefP3to7sVvSJTWQ4
X-Gm-Gg: AR+sD10CxyR/4hlvg9ZlvyCDrmzcP+W3GcoLu/ijy3rflAZmDIrFgm2CSdkGTFnm73K
	CDUjjRdSdhhcXRCF8PhUAaJGkuTjwG7UG/+nadG9XuHQwtFoMEnTaRDgUG6AokR+1BAlQpbVegd
	5Diph5eNHnCKCkfIvjTPyLkWMQ38jvWiOmTJjP+28RxBLqVrZIx1kWN6uURFbvkfEZEYg/HqHcF
	PdzTf9CSKlAsH7ePouAgc8P/9iRMxKRFq0gybr8Q3sLdAhEuIsfNpVvhGxGcl9YbUiWuP5hfl+i
	IwpOlFe+sJ+aJ6j40HqWQjSuWpifYrJFUtsKnX8BhHCaGMquFyZQptY8UzvxBX9A/z0m7tlz+WD
	6hC6BwiDYDux/rQ/SATJF1jlDrwqGu00SdzyGyGU6UAQotFybkJZ8s9974BlelNwC/cf7hwDln4
	Una6UTG47JFjpi
X-Received: by 2002:a17:907:1c87:b0:c21:180c:d82d with SMTP id
 a640c23a62f3a-c250c3bfa5dmr43918066b.20.1787681211947; Tue, 25 Aug 2026
 11:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825140159.70997-1-mamarang@amazon.com> <CADrL8HUcr5Fei1PX179bkFmMJ_S+eD267SVgc85cm-rpcahwmA@mail.gmail.com>
 <GV2PR06MB10711C9FE46F33B0613DCB66FB9AF2@GV2PR06MB10711.eurprd06.prod.outlook.com>
In-Reply-To: <GV2PR06MB10711C9FE46F33B0613DCB66FB9AF2@GV2PR06MB10711.eurprd06.prod.outlook.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 25 Aug 2026 11:06:14 -0700
X-Gm-Features: AcwNN1W2iTF0mK_fDpcAZFQ3QdOykWwGa_lvxxv8Vq6BgpyorCQO2Nhvfe9GdGY
Message-ID: <CADrL8HW8br9KuYoELj4id84ib_tGZrBh3zZGbjerHuM8uiN7hA@mail.gmail.com>
Subject: Re: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page faults
To: "Marangoni, Marco" <mamarang@amazon.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kernel-patches@amazon.com" <kernel-patches@amazon.com>, "Mancini, Riccardo" <mancio@amazon.co.uk>, 
	"Zoumboulakis, Michael" <zoumboul@amazon.com>, Marco Marangoni <marco.marangoni@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 10:38=E2=80=AFAM Marangoni, Marco <mamarang@amazon.=
com> wrote:
>
> Thanks for the replies!
>
> On Tue, Aug 25, 2026, Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Tue, Aug 25, 2026, Marco Marangoni wrote:
> > > It's worth mentioning that I also evaluated using the existing
> > > KVM_PRE_FAULT_MEMORY ioctl, but this doesn't work well for our use-ca=
se, as
> > > it requires the vCPU to be paused.
> >
> > What about if/when KVM Userfault[*] comes along?  I.e. pre-fault memory=
 when the
> > vCPU exits to userspace.
>
> KVM Userfault + KVM_PRE_FAULT_MEMORY is a valid suggestion, however if po=
ssible we'd like to have _both_ async page faults and prefetching.
> I haven't tested async PF together with prefetching, but tested separatel=
y, both improvements yield great results, so it would be a shame to have to=
 choose.

What if you used KVM_PRE_FAULT_MEMORY without KVM Userfault?

If you want to avoid pausing a vCPU, what if you made another vCPU
(KVM_CREATE_VCPU) and used that solely for prefaulting guest memory? I
haven't really looked into that before... I'm guessing there's
something fundamentally wrong with this approach.

If this doesn't work (and a VM-scoped KVM_PRE_FAULT_MEMORY doesn't
make sense either), then perhaps the TDP MMU prefetching logic makes
sense.

> On Tue, Aug 25, 2026, James Houghton <jthoughton@google.com> wrote:
> > I think part of the problem in this case is that UFFDIO_COPY will
> > install 4K pages (IIRC), I think a more natural way to fix this
> > problem is to:
> >
> > 1. MADV_COLLAPSE after doing UFFDIO_COPY.
> > 2. Make UFFDIO_COPY install PMDs when it is able to do so.
> >
> > These don't solve the exact same problem, but really userfaultfd
> > should already try to install PMDs when it can (#2). If we have #2, #1
> > is mostly a no-op.
> >
> > What do you think?
>
> Directly installing PMDs after an UFFD_COPY is something I already invest=
igated. I didn't mention it originally, since it touches exclusively the MM=
 module.
> For some context, with that approach, in the same benchmarks, fault laten=
cy on nested is reduced by 92%, and by 44% on metal, which is significantly=
 better than my proposal (which "only" improves by 75% and 22% respectively=
).

Did you or one of your colleagues ever post it on list? I'm curious to
see it. :)

> However, that approach only works when the copy is done in multiples of 2=
MiB, and for some Firecracker use-cases, that's a no-go (I can elaborate fu=
rther if necessary, but the main problem is an explosion in incremental sna=
pshots size when managing memory in big chunks).
> I might pursue this proposal in a separate patch, however I'd love to wor=
k out a solution that can be applied when userfaultfd works with smaller ch=
unk sizes.

I see. So we really are dealing with 4K mappings.

In which case, prefetching at 2M does seem kind of arbitrary, which
makes me even more in favor of this being mostly userspace-driven.
