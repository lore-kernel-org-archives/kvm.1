Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A23515DB
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825848; cv=none; b=If0N85JzBgEmV/OCeTm1PD+tez71/F7UE2jySfR9h71Y8k8T7QU+lDzjhHmd9V1RhqU17Ta1AoQYpbmo8awwQKT0Gt+i829j/w7YEBSDDWWwG4JRzqwg4TV6Px++OkOA1AKXqdunp+32baURTxMzsW84ZThcLhOCq3V8WoV+hkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825848; c=relaxed/simple;
	bh=OP86gqWBs1F+IxhZYPwbYBrMbA+NzUQssBROCMV4CWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCWWcxomeE+UEHlmVJU9viL5Cx4uWra/gxsMMSwuBh/1meHZwcuAmZJviNwzpRA4QaXLiDqmNHUGlsPpQR25dlLdxkyu4mSYkpbK2/9ODMb2z4Imt/gOQ4un7+uKmWkkB0ZLRf/4XJ4XYTm/Q6Wbvq1JP9PVXTee6cXOpRj7umk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKLH+tAt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKLH+tAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD061F000E9
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825847;
	bh=N5OgqDi/R6k7Lr+ZyMJ0vzWhfp22InkmWhQO7EH3lfM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NKLH+tAtlfATzhKLywivjXSVl8SewM3VwwSq3DP8GbC/rNYZ0kEGOBD3POKJ01irZ
	 q7ZXg7tmLx3owk7K+NA58B78CkKve0bf9L1gorcLbvw7VTA9i7DmW15Dxei1GtIU8K
	 0j4vEDixxw6E+GxvZ76TJhND+gtv1v7R73mLBFmiFFCXywHxqu885Mi+SHMi3mK5L+
	 47DRJKylsVbJl8wvgLavVetntGiaLeqW/IUQIxTSKNA4Q3ebdtWnmgnj4MdgXCESUf
	 ZEzzsbuVg0mnzBAfhpgoSbWSVH41CdUXd73oBW35lmngUAPcSMBnkYQMChsOTtUCtu
	 GCswabUIodZuQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15d111ca99so102514566b.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 09:57:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RozkYBODHEdRfNafJehGnuUO6XuzF2bx4iymEIBqmfT49ydPNsnn18rpDYlefld9r2f0pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsUueuHaC6tAK3vugaPEiSMyLA6P4e2s5dsFTzTxwyuWZlTYPG
	9dfm2DNSQCi225fRjY6Cl6oMQllpdwNNCd0AOvEX3pZOBX8N1MVDtzNBh6PT0SuY+em3LHwE0YY
	ix6U2wjgX3Hx5ECR0fS/Rtb7qy8PA1HQ=
X-Received: by 2002:a17:907:804:b0:c16:16b9:98fa with SMTP id
 a640c23a62f3a-c1c508a74bdmr169285266b.5.1784825844688; Thu, 23 Jul 2026
 09:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
 <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
 <albJNb-akQJ97Yor@google.com> <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
 <amE_nPDem-imSfqF@google.com> <CALMp9eQL7y5chFEDCrqMR9CbJgiJxXN1hVzxVzojsr92AWnqrA@mail.gmail.com>
 <amFf5MAhc8sUqeYV@google.com> <CALMp9eSssBCuTTWdr1qT2c4Nto2PQO-QOBnobcx2kTnuQaOB1g@mail.gmail.com>
 <CALMp9eQi=604LVn=ZMnzoUy55LVb1qorKzPKm5HVK_ACsPuP_A@mail.gmail.com>
 <amIgLeMCAH2vB4ot@google.com> <CALMp9eSgfL8C7SU+j6+c5s64end-n4uHh=uXtTpDVJ7RcvLQgw@mail.gmail.com>
 <CAO9r8zMukfW2b5tjYarpkpPH0osA_+QEEMRq8k5R8B_WFG_yYQ@mail.gmail.com> <CALMp9eRsJeByu4U8NZQhnKM7BaKziyLUix6J3XGCEMZyiar=vA@mail.gmail.com>
In-Reply-To: <CALMp9eRsJeByu4U8NZQhnKM7BaKziyLUix6J3XGCEMZyiar=vA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 23 Jul 2026 09:57:12 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOtzSscMx_PFuABkXzZ=xgGOcioegKzgYscXa9WiobySg@mail.gmail.com>
X-Gm-Features: AUfX_mySQPUIvVDujrVu3uv2WuXHR65j80drAdpBfGaWYVUjjJHGWgWlMRMF6QE
Message-ID: <CAO9r8zOtzSscMx_PFuABkXzZ=xgGOcioegKzgYscXa9WiobySg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 9:54=E2=80=AFAM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Thu, Jul 23, 2026 at 9:32=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Thu, Jul 23, 2026 at 8:57=E2=80=AFAM Jim Mattson <jmattson@google.co=
m> wrote:
> > >
> > > On Thu, Jul 23, 2026 at 7:07=E2=80=AFAM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > On Thu, Jul 23, 2026, Jim Mattson wrote:
> > > > > However, since KVM completely ignores NASID, it would be sad if
> > > > > migration were blocked because the target has a lower NASID value=
 than
> > > > > the source.
> > > > >
> > > > > That's an argument against changing it without some kind of users=
pace
> > > > > opt-in. Increasing it seems safe, but if userspace just reflects =
the
> > > > > value into KVM_SET_CPUID2, then an increase would block kernel
> > > > > rollback.
> > > > >
> > > > > In any case, I think the new value should be a constant so it doe=
sn't
> > > > > imply a migration constraint. Perhaps we should adopt the highest
> > > > > value reported on a physical CPU to date? I think that would be
> > > > > Bulldozer's 0x10000.
> > > >
> > > > Or keep KVM's enumeration at 8, then find somewhere in KVM's docume=
ntation to
> > > > describe KVM's behavior and provide guidance for userspace, but oth=
erwise make
> > > > it userspace's problem to solve?  I'd be a-ok with that.
> > >
> > > That sounds best to me. Document that KVM ignores the guest NASID and
> > > commits to always supporting 2^32 ASIDs. Advise userspace to populate
> > > NASID with a power of 2, and perhaps mention that hardware has only
> > > reported three different values over the last 20 years: 0x40, 0x10000=
,
> > > and 0x8000.
> >
> > I agree that documenting that KVM supports any NASID value from
> > userspace is needed here, so that VMMs can set reasonable values and
> > migration pools are sane.
> >
> > That being said, I still think KVM's enumeration should be increased
> > from 8. If KVM's enumeration is just a hint, then it should be a good
> > one imo. Current L1 KVM will flush everything (L1 + L2) every time it
> > runs out of ASIDs and pumps the generation, so advertising a small
> > number of ASIDs leads to L1 unnecessarily hurting its performance.
> > Newer KVM (with this series) won't suffer as much.
> >
> > I think we probably want to pump KVM enumeration (e.g. to 0x8000 or
> > even 0x40) *and* document that it's just a hint and KVM effectively
> > allows any value.
>
> How do you do that without breaking rollback?

KVM's enumeration is just a hint :)

Also, in practice, even if you rollback the CPUID presented to an
existing VM by userspace should never change, right?
