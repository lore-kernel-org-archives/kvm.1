Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338173403F8
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824366; cv=none; b=V5Giqp6jhOpeeockv3mABDwKiCnDscgjXTBfQdNT7qPf9fFvhzU87UrO5fArueWu3ARHGMEYVBUtCShvWoigtz9JbgzAjF/Rayi+WSgWLBji+i7WNCFwFd5G7mTa0nazat9aLJTyzwP75+tzlpyHnY8Ew9pPxzF9LtW7JHMkayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824366; c=relaxed/simple;
	bh=PbNwBUnboC588bqU1f5TRjLvM8apMwFuKNk55kTBxc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWKOkTUgmf88NPPC3Henx/A55rqrpLnNBQErLKRajcMhA9c2+/MhNrX6Z0w8MirBZ/Rz7YL2gUfrOTpbLG5xg9U+7j6ozcMszviGhY4H71gtJwv+3GPuwlAtWu0jFUeGXk6pk7MHDezygb4xTmJfZk9dUsIPJH3X1muZdybUq/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqnZwtkY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqnZwtkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181EC1F00A3D
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 16:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784824365;
	bh=1xkZZ3v4DeEq2DpP9IHH3755SskzAylJM3I1S2S5Jvw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RqnZwtkYQcRrpNmuAfMm5iPKez0XtqPPbyuR2TaMU0ocKDsdn+fJEabESRbu1OBT9
	 a3NT2rs8KT/pYgCtRp+Ps5sSuLoIwyU40n8czvO8SueMmd6vdsDRN8xMVQH7ggabI7
	 u/TGlhbqelgbFaio0fVQgWCdYJNHgwphMUGS6ozel5tzRqmy01QbIT1NsPQJoKSGb/
	 Kx/TFQetb6ytKvmzO3qp21IEx07Z5WVa4ma2y6vHKyGV22gjqOsVPVtM55lKH5oZbB
	 jTAfSRU7G1EEA/ui8mnUoF8Amb9vlY7uMEkhq2Zf2ot/Csx9Qg8FRrVKbYr5PMqFCl
	 jSyZRXd7T2eSQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1c52d920b8so123482766b.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 09:32:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrSpG1oOzBT06DpX2Sjq/h3u0r6K88FhdeDGtuM5n++ObGS5lrf1vUQCfAB9/6DMd1fAPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/F4Jy+8AWaDCO8AH9FVQW3Az5hjltFd8deWJJt7Mnhvuz7Gp
	lkoXDbsGVtS3MeHwI6VDqTwPVpLKulNwevBP5nhFI+LRGe7r/toFw8yz7LQzQlt5VwFKd9oyWEQ
	JauiZOeWHXCFnlevZmIg+nC+m06RfLm4=
X-Received: by 2002:a17:907:98d:b0:c15:bea2:d209 with SMTP id
 a640c23a62f3a-c1c506e8a4cmr146769566b.4.1784824357187; Thu, 23 Jul 2026
 09:32:37 -0700 (PDT)
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
In-Reply-To: <CALMp9eSgfL8C7SU+j6+c5s64end-n4uHh=uXtTpDVJ7RcvLQgw@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 23 Jul 2026 09:32:25 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMukfW2b5tjYarpkpPH0osA_+QEEMRq8k5R8B_WFG_yYQ@mail.gmail.com>
X-Gm-Features: AUfX_mwW9ptVR62kKAb0tkoTMOunH4r-B6V6pNyKerJK91cII2PzUl-muFMlqco
Message-ID: <CAO9r8zMukfW2b5tjYarpkpPH0osA_+QEEMRq8k5R8B_WFG_yYQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 8:57=E2=80=AFAM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Thu, Jul 23, 2026 at 7:07=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, Jul 23, 2026, Jim Mattson wrote:
> > > However, since KVM completely ignores NASID, it would be sad if
> > > migration were blocked because the target has a lower NASID value tha=
n
> > > the source.
> > >
> > > That's an argument against changing it without some kind of userspace
> > > opt-in. Increasing it seems safe, but if userspace just reflects the
> > > value into KVM_SET_CPUID2, then an increase would block kernel
> > > rollback.
> > >
> > > In any case, I think the new value should be a constant so it doesn't
> > > imply a migration constraint. Perhaps we should adopt the highest
> > > value reported on a physical CPU to date? I think that would be
> > > Bulldozer's 0x10000.
> >
> > Or keep KVM's enumeration at 8, then find somewhere in KVM's documentat=
ion to
> > describe KVM's behavior and provide guidance for userspace, but otherwi=
se make
> > it userspace's problem to solve?  I'd be a-ok with that.
>
> That sounds best to me. Document that KVM ignores the guest NASID and
> commits to always supporting 2^32 ASIDs. Advise userspace to populate
> NASID with a power of 2, and perhaps mention that hardware has only
> reported three different values over the last 20 years: 0x40, 0x10000,
> and 0x8000.

I agree that documenting that KVM supports any NASID value from
userspace is needed here, so that VMMs can set reasonable values and
migration pools are sane.

That being said, I still think KVM's enumeration should be increased
from 8. If KVM's enumeration is just a hint, then it should be a good
one imo. Current L1 KVM will flush everything (L1 + L2) every time it
runs out of ASIDs and pumps the generation, so advertising a small
number of ASIDs leads to L1 unnecessarily hurting its performance.
Newer KVM (with this series) won't suffer as much.

I think we probably want to pump KVM enumeration (e.g. to 0x8000 or
even 0x40) *and* document that it's just a hint and KVM effectively
allows any value.
