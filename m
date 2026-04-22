Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD42E06EA
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894293; cv=none; b=jZFIlEWaxEeKSO9tynWsoBrehfjlSR6X5dhMaGv2H27o7T6Lb2sXawBjBzfYwZj3XfqENe9q4HnlMSbAxVmeaeEsizvtCE84JU4xqyMYnMNtc3465hxJCHOl9ogAauV6b39J6R7412UeFUyJB4/RK9+H1YReiphpc/1cPLk/zps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894293; c=relaxed/simple;
	bh=tHYNhcrXG1XEwoPAwoxoq/s4pgG+IT1N0bFfoOKoqYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxCLf0YM3hGYuf2aoscb+o50frVBbVHQ4C11JChmX7157segAZzn3jbp9/1zml7Co59kiuD80VeaP6VyxMpMKaBbUcSb2AK/7KFe+/pSIubU3+lAwfEHVBC1sZyJQkDlAOPHIiDePPOGlN+LwZHOlo2zw/zyx9f/drpUHVAKXKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOP6RuAC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOP6RuAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230F1C2BCB7
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 21:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776894293;
	bh=tHYNhcrXG1XEwoPAwoxoq/s4pgG+IT1N0bFfoOKoqYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AOP6RuACIcZPxmkODQRmn51eVuQsVRiEJcut386x6NOsrYmiHyskQl7Jq0zUUVP07
	 06TVvhaDrdL3tQil/TDZ27cGazRldtqJSmPPRZtgM7Qng8r34cU4wDgxZTRcJqKgRs
	 9WIZi6IOsyL9WAPsPmRFVfQzx5PDX2the7vuheOaqgNahXmQgi1RAONrqWwbGeiV1H
	 1Mwr3R/hGjqWg/VbH8AceVNSSuekskl0bu8sWEPAM2IPh5uXeT2rMBF41cfArSOkQa
	 yV4MbHRy57U/hvGYhFxF+vyBZM6/R3teZaDh2zGTdixZLlDF19XlSwKqYdyVbIpYAb
	 +TieqYwxquvsQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9d9971d059so879204066b.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 14:44:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ94ROEe28TOauhuM+MngKUzM+ARiednJPtk6OJgmSghQPMtSTHmlaBdVbBYo/sBOteOYfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyioKZB/JpDnn20njMEvpC3OC3I8Shyj2hCzTXguBjnHZIYBWvA
	2RpRoZlsRKvQCvYPjBhK9kzCPnpHJGWQDdJXWE90OkgvUqyMM2n3MtaK/L4ky6TfxDXP0qhE4iv
	NJwpNyxTwjvaLy3Ev4jXcOkhyUxLIKHo=
X-Received: by 2002:a17:907:6091:b0:bab:7f2b:c5d1 with SMTP id
 a640c23a62f3a-bab7f2bc736mr177582266b.9.1776894291977; Wed, 22 Apr 2026
 14:44:51 -0700 (PDT)
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
 <aegV3ELp20DlC5Ge@google.com> <aekrJrSRoclZoBo9@google.com> <aekw1S5Gdkyx8teC@google.com>
In-Reply-To: <aekw1S5Gdkyx8teC@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 22 Apr 2026 14:44:38 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPhxn9dUKoXwM2JHF4TwG+PeTd8GhDO_kqG+kuwRW1g=g@mail.gmail.com>
X-Gm-Features: AQROBzCKceysO9ivAzqon0z-yXd-OerC3R6DcybrV6wprQiol2CvCARtsqKQBy4
Message-ID: <CAO9r8zPhxn9dUKoXwM2JHF4TwG+PeTd8GhDO_kqG+kuwRW1g=g@mail.gmail.com>
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

On Wed, Apr 22, 2026 at 1:34=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Apr 22, 2026, Yosry Ahmed wrote:
> > > > Perhaps we just need to rename the functions (e.g.
> > > > kvm_vcpu_map_page()), or more intrusively pass in a size and do bou=
nds
> > > > checking.
> > >
> > > Definitely the latter.  Or both I guess, but probably just the latter=
.
> >
> > I think both. I think renaming to kvm_vcpu_map_page() (and similar for
> > others) would further clarify things, especially with the introduction
> > of kvm_vcpu_map_ptr() below.
>
> I don't like "page" it's too easy to incorrectly assume "page" means "str=
uct page".
> There are KVM APIs that do use "page" generically, e.g. kvm_read_guest_pa=
ge(),
> but for this particular case I'd like to stay away from "page; there's a =
_lot_
> of ugly history around mapping "struct page" vs. "other" memory in KVM.

Maybe kvm_vcpu_map_guest_page()? or if you reaaaally wanna be clear
about it kvm_vcpu_map_page_sized_chunk_of_guest_memory() :P

I don't feel strongly but I prefer we put "page" in there somewhere,
up to you :)
