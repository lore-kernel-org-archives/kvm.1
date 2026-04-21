Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD1A282F04
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776814904; cv=none; b=Zc93Wx4+ZlPrj05uTykdT1gr5X6i+bkIT9AqZZKKvm1G+0vcpyV0Ad6GY1w3ZltNeAHnqC6x/bl3m3WESeQcydvGeAU0ySeR1XJay38l5tghP5Mp9CX7nt3yWyTXBnv8CkawjLPddeitIl0LrRK3uxREznuqksX9zlRwV4pbYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776814904; c=relaxed/simple;
	bh=V8gY7U7FMdSdx1zKSaD45nVLoaT/83qo8hxPeKq/YSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNKj4vA5BmrS77zbJWR1KZaj+RT0aap9s2O7nMPqzVvVIcN/6pkTy9+7XlbrGuLCKvDXbx7NK7GTvZ9wSYpyCwVfhHROwkFNjRzw6kwHZh7In96Y0xRRA+F/jzvOIaIFyuPhVkJboOs9BIi+3zWtg0NjIvuH4CGLls7QWIfPcfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chHtQVad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chHtQVad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6D0C2BCB0
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776814904;
	bh=V8gY7U7FMdSdx1zKSaD45nVLoaT/83qo8hxPeKq/YSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=chHtQVad3EzPMgog7hxIzd+l2ieQEeEj1iJH0qjFpV3ivq6QjOBecoNhoPmYFtCgG
	 3h0bAawA5hpvrgjCrgL8LOvdMKxobNyKnOCYoaSgln6LF6k7KlBa5ybZ7sObJ8DsKt
	 6rra3i9koWqDODcYNlPOT2xkpdtAncqZvenepAHjg9OrhTKbTQSQhxCvq9LUo7GdPT
	 IZA57cE6CeD1B75s5lMPzRWtIFua2omZwXYiC/dssEfmI0L352LMlpLOlPBg/Q9r1T
	 eYBly1H6oMJvsEZBvwQwtcMK1/jjrgfC1KlKOJ8FZhdE7fGU667gHg8E2wpMXJjVnJ
	 f8RSdXplw/sSQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ba8472c1613so427616866b.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:41:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8jKa5SpLuOpUsUHHfxkDZNtwsRdvDB57ztMlsb3Rd9yi++fMDHqVrRAMFCcb1HyEhnW0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQzdtKoflNaIXlNBv+lAL19GfjZpQnxjs75s8fCI6/aoqLmmjr
	aMX4Om2nbaUjsfbGuq0Gqqu1C8pb+wqVJEV4gTlURVXc4/JxYo1G79E2X1MHk1EaFZBXBVVpeLO
	jiHTDvmjJr4nUdmMEaNzDSQBIoajWOWM=
X-Received: by 2002:a17:907:3d8e:b0:ba7:4cd9:ca27 with SMTP id
 a640c23a62f3a-ba74cd9ef49mr592307866b.41.1776814903254; Tue, 21 Apr 2026
 16:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com> <aegDJssx-ZvbfggI@google.com>
 <aegF59gToidudIUC@google.com> <aegIPGYPH-nxGsua@google.com>
In-Reply-To: <aegIPGYPH-nxGsua@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 21 Apr 2026 16:41:31 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
X-Gm-Features: AQROBzANd0h_q8XtUwKQrNkCW04xrdyRTc8bFj2qWgS95XTIw4zggBHJPj1Tje4
Message-ID: <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 4:29=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Apr 21, 2026, Sean Christopherson wrote:
> > On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> > > On Tue, Apr 07, 2026 at 05:11:30PM -0700, Peter Fang wrote:
> > > > Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() and
> > > > kvm_vcpu_map_readonly() so that they take a gpa_t directly, reducin=
g
> > > > boilerplate at call sites.
> > > >
> > > > __kvm_vcpu_map() still takes a gfn_t because guest page mapping is
> > > > fundamentally GFN-based.
> > > >
> > > > No functional change intended.
> > > >
> > > > Compile-tested on x86 and ppc, which are the current users of these
> > > > interfaces.
> > > >
> > > > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > > > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > > > ---
> > >
> > > I was going to suggest a WARN in kvm_vcpu_map() and
> > > kvm_vcpu_map_readonly() if the passed GPA is not page-aligned, but Se=
an
> > > usually hates my paranoid WARN suggestions.
> >
> > Heh, for good reason.  Adding such a WARN would be triggered by this co=
de:
> >
> >                 if (!kvm_vcpu_map(vcpu, vmcs12->posted_intr_desc_addr, =
map)) {
> >                         vmx->nested.pi_desc =3D
> >                                 (struct pi_desc *)(((void *)map->hva) +
> >                                 offset_in_page(vmcs12->posted_intr_desc=
_addr));
> >
> > The PI descriptor only needs to be 64-bit aligned, not page-aligned.
>
> To elaborate a bit, I'm all for adding WARNs in flows where something bad=
 is all
> but guaranteed to happen if an assumption is violated, or in APIs where t=
here's
> a history of goofs and/or subtlety in how the API behaves.
>
> What I'm against is adding WARNs because someone could write bad code in =
the
> future, or because KVM doesn't do XYZ at this time.  Such WARNs usualy ju=
st add
> noise, and can even be actively harmful.  E.g. in this case, ignoring the=
 PID
> usage, a reader might look at the WARN and think it's _wrong_ to map a pa=
ge in
> order to access a subset of the page, which is just not true.

Yeah I agree with most/all of your objections to my suggestions, it's
usually that I don't have enough context to understand how the WARN
could be harmful (like here), or am just being too paranoid or
defending against bad code as you mentioned. I was mentioning your
objections semi-sarcastically and intentionally bringing up the WARN
in case it's actually useful.

Taking a step back, what I really want to clarify and/or detect misuse
of, is that kvm_vcpu_map() will map exactly one page, the one that the
GPA lies in. For example, there's nothing protecting against the PID
address being the last byte of the page, in which case accessing all
of it would be wrong as it spans the mapped page boundary. This is
difficult to hit if you are passing in a GFN, as it's more obvious
that KVM is mapping one physical page.

Perhaps we just need to rename the functions (e.g.
kvm_vcpu_map_page()), or more intrusively pass in a size and do bounds
checking.
