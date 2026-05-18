Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE0B2BD033
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132368; cv=none; b=A7xMe+ZtYEmYJOPJXmOcqP7j95EVRSWT2TrmtXAV5I20OKqvjM6I4y/T9NQd4GbGA1iLwfTlNmsgsGAjMPN1z2jDd20GUIdpcxml5R5zeQ3jpzsGFGPpyW1mLez/IxX8N/7+lDJuAdPetc1VQMb9rntAFAMSM0bFy/mSunxRYfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132368; c=relaxed/simple;
	bh=REVQJycch2zp2jkqWOxi4TopcTyYu6TLFY7RIxTOBfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrbLo99JN3Lu3IO+qh+OzF1rbN+0ONjGb6VN+7H/kIqs976JZjxHR5ewDUYYM9cuw6puNhmUO9tdc28dV9gSWKKnMQf9yD0b1lvS6zQIP7NNk1U5itFINNkEK4PovT5LtOXctBpL3D/AuHd4IQuTaHV7mXkT1smiCmwmIUZgjgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOZfIijZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOZfIijZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DADC2BCF5
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 19:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132368;
	bh=REVQJycch2zp2jkqWOxi4TopcTyYu6TLFY7RIxTOBfs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aOZfIijZoG94yEPWfAfep1iKnrcqCowpDEHCktFFolcdXMPbCNxT2Vo5Yp2NDG3t0
	 XRGMHPrwvJ1BsaXuLxntM342peA14/iE+MffPIKSU6KRdkexOvSmikX1QhRrBXqbUh
	 d5eJYPHwXDNDFLvmyAxRoTOG0gsbfWchn7riNQKG8fucGOdbPtEK45zyC+oadiFKyT
	 zTRqYhVL+x80tTmHDRrQkc1GqmOgaKTK5eQ5FSJVzRqLE10x8npIroX8E4QAg7bVx9
	 EfZGCYkDo5/aSruVa0izuYKi4CHTKhakrCv8Y4QzMuR9UN2mStQEY/FeT6Umkq7hzl
	 O6SfK8haGBoLA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd85ebb368fso239460766b.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 12:26:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+HBVfzEmrfgcHNedUUiOhuT3mWXfeNH3BaxtYUHAODj5ZiViHhRfE2wxhLU7VuGdpWcak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGJJpd4AaSH6wJ3DvmEw9JsW9N0keEuvoI7NM0J399bQEvBd6
	hf2AdP3x4mfu1xgIVFuSQCSgiB7GDlOsD/Zhe2ekfYI3xue68SUi6kiHQjeI/HNkKACCnj0pLbG
	j1vDPhPrN606HabSh+Uz1PRWecTxhlyM=
X-Received: by 2002:a17:907:ea8:b0:bd0:4f6e:9b2f with SMTP id
 a640c23a62f3a-bd51780c078mr930492566b.1.1779132367085; Mon, 18 May 2026
 12:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518045916.2988667-1-nikunj@amd.com> <20260518045916.2988667-8-nikunj@amd.com>
 <agtGh82vLu4G6pWI@google.com> <agtgltn2wLNFrS2f@google.com>
In-Reply-To: <agtgltn2wLNFrS2f@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 18 May 2026 12:25:54 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNZd9XzkRmGs=7eP3=EHFXO=hPTtpTAxKuCcQO9am_kjA@mail.gmail.com>
X-Gm-Features: AVHnY4LV9rVJctKSerRR7uo4gpnAEqknm7_6s2w3sUe6njeeqTYCBO_qkn78Wzo
Message-ID: <CAO9r8zNZd9XzkRmGs=7eP3=EHFXO=hPTtpTAxKuCcQO9am_kjA@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] KVM: SVM: Add Page modification logging support
To: Sean Christopherson <seanjc@google.com>
Cc: Nikunj A Dadhania <nikunj@amd.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, bp@alien8.de, joao.m.martins@oracle.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 11:55=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Mon, May 18, 2026, Yosry Ahmed wrote:
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index 4ef9bc6a553f3..dd30aef9fc497 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -882,6 +882,12 @@ static void nested_vmcb02_prepare_control(struct=
 vcpu_svm *svm)
> > >     vmcb02->control.msrpm_base_pa =3D vmcb01->control.msrpm_base_pa;
> > >     vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
> > >
> > > +   /* Clear PML fields to avoid stale data in vmcb02. */
> > > +   if (pml) {
> > > +           vmcb02->control.pml_addr =3D 0;
> > > +           vmcb02->control.pml_index =3D -1;
> > > +   }
> >
> > I think the comment here is misleading.
>
> +1000
>
> > vmcb02 is allocated with
> > __GFP_ZERO, and IIUC pml_index should not matter when pml_addr is zero.
> > This is strictly for hardening as far as I can tell, especially looking
> > at commit c3bb9a20834f ("KVM: nVMX: Disable PML in hardware when runnin=
g
> > L2"), which introduced something similar for VMX.
> >
> > So maybe something like:
> >       /*
> >        * PML is never enabled in hardware for L2. Make sure that an
> >        * unexpected PML write would trigger a PML_FULL VM-Exit.
> >        */
>
> Hmm, I was going to say we should drop the code entirely, but I do think =
it makes
> sense to set PML_INDEX to -1 to ensure a VM-Exit occurs.
>
> Actually, even better idea, at least for nVMX.  Rather than write '0' for=
 the
> address, which is what I really dislike (bad past-Sean!), we should write=
 -1ull
> so that unexpectedly enabling PML in vmcs02 results in VM-Fail, i.e. don'=
t even
> rely on the WARN for safety.
>
> If SVM has a consistency check on the address, then do the same, otherwis=
e I
> guess just go with setting pml_index to -1 and WARNing on PML_FULL?

Wouldn't it be hilarious if there is a consistency check, but it fires
even if SVM_MISC_ENABLE_PML is not set? I honestly wouldn't be
surprised at all :)
