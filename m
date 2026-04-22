Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092411FC101
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776896357; cv=none; b=SaU6o3FwKESJvysqR5AIUfWR9bglyq7OawkRYk/3YeYP1j9aNuWii84GsvCxhMp1C+75vBSkB/RXywKerxlJpk3LA9uc4YH5l6rR03W0kS4omywHF9QkpSBKbQVe+9DU/suZn7PSCpZ3QaepgnVqV8HG6PnH478uqUHUBBBxAUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776896357; c=relaxed/simple;
	bh=3WTHeSeyj1uSyMyVXTGvKd+qQIkqa8yvnPyPSQt84wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJGdB5yaAV5i4JgPgNnL6Dn1j8hxboELO3y5cLBdR8vViJSSktNC4cK2laj2zTySule18KoITlwA8U3pdVc8AILTPpTe13EZazVGzbBe9bVdQRzrCz/nGCbpK9QdYApRz+CRhUHgb0mjXISMpoflAigBCBLhwFwdORtUvz/WpN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VND6/Q0x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VND6/Q0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC69CC4AF09
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 22:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776896356;
	bh=3WTHeSeyj1uSyMyVXTGvKd+qQIkqa8yvnPyPSQt84wc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VND6/Q0x5gKtDizHyEGZN6xhd/qs7aeqPuPlogPFoQW+oqwpYwC81C4HSrPayJETm
	 +G+OvyiThNx/l1518orVbtouSCS0TCMDM6gER1FnKlvDmuNdQQLQRsZ5rohnWscRxH
	 /Z/yuZe51Y1eBp1BPbsR1Sy6LGxuq56DMZCE+MLWnQBjw4gtsTf5f8RL9IQ6y/ZcmN
	 SvuQW6zW4huZWKxrWcX783gSkWGxbQ0S3KzC0C5bwTkqjq3Lo1NgB8UAb3Zhs58+Xq
	 5O3Y3rF7odsO+uA8XcPs5u1cg/tWw2Jw9x929tGfzDbi7DYE2B9j0J2iC/L4BebKFn
	 504VnpOkIZGaw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ba922426c5cso579995666b.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 15:19:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9zSjPiWqracXvjHOuZXNr7M57k79Hv6FUzLsFdspdK4GddRz9pnv0we5Uz6uwvQIs/wAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdkhX1aSyOHXT+ZtDH+GB32wEfNvkBd3iCCO9ZEt3eOU4nejFy
	+Dgvzn8RSDgzhTILLQAb3J94TXEfO+I625/HZo9pmvbzkMiaQw94EMJ4/bCx7zSFHminQTUu6UW
	UOg+lHVjPEPZuOYshPQVI0AzJJd125B0=
X-Received: by 2002:a17:907:cd09:b0:b9d:94af:10fc with SMTP id
 a640c23a62f3a-ba41afe9d6fmr1546883966b.25.1776896355511; Wed, 22 Apr 2026
 15:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com> <aegDJssx-ZvbfggI@google.com>
 <aegF59gToidudIUC@google.com> <aegIPGYPH-nxGsua@google.com>
 <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
 <aegV3ELp20DlC5Ge@google.com> <aekrJrSRoclZoBo9@google.com>
 <aekw1S5Gdkyx8teC@google.com> <CAO9r8zPhxn9dUKoXwM2JHF4TwG+PeTd8GhDO_kqG+kuwRW1g=g@mail.gmail.com>
 <aelI9_CAcZjGXj7v@google.com>
In-Reply-To: <aelI9_CAcZjGXj7v@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 22 Apr 2026 15:19:04 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO1p6tvT3BYaU+XvcqEBu-Dga=Ew_qvgzHk_q8P7fjyTQ@mail.gmail.com>
X-Gm-Features: AQROBzC0p0NpkLDMwb7vpD2dftYRsH_jFUFOETXLw6fnxs8RoojZv-m7XcDuopk
Message-ID: <CAO9r8zO1p6tvT3BYaU+XvcqEBu-Dga=Ew_qvgzHk_q8P7fjyTQ@mail.gmail.com>
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

On Wed, Apr 22, 2026 at 3:17=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Apr 22, 2026, Yosry Ahmed wrote:
> > On Wed, Apr 22, 2026 at 1:34=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Wed, Apr 22, 2026, Yosry Ahmed wrote:
> > > > > > Perhaps we just need to rename the functions (e.g.
> > > > > > kvm_vcpu_map_page()), or more intrusively pass in a size and do=
 bounds
> > > > > > checking.
> > > > >
> > > > > Definitely the latter.  Or both I guess, but probably just the la=
tter.
> > > >
> > > > I think both. I think renaming to kvm_vcpu_map_page() (and similar =
for
> > > > others) would further clarify things, especially with the introduct=
ion
> > > > of kvm_vcpu_map_ptr() below.
> > >
> > > I don't like "page" it's too easy to incorrectly assume "page" means =
"struct page".
> > > There are KVM APIs that do use "page" generically, e.g. kvm_read_gues=
t_page(),
> > > but for this particular case I'd like to stay away from "page; there'=
s a _lot_
> > > of ugly history around mapping "struct page" vs. "other" memory in KV=
M.
> >
> > Maybe kvm_vcpu_map_guest_page()? or if you reaaaally wanna be clear
> > about it kvm_vcpu_map_page_sized_chunk_of_guest_memory() :P
>
> And rename all the extensions to .java while we're at it.

Lovely.

> I can live with kvm_vcpu_map_guest_page().  kvm_vcpu_map_ptr() becomes a =
bit
> odd, but kvm_vcpu_map_guest_ptr() is even worse.

FWIW I still think kvm_vcpu_map_page() and kvm_vcpu_map_ptr() are the
best options. kvm_vcpu_map_guest_page() and kvm_vcpu_map_ptr() are
also fine imo.
