Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42283CAE74
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494905; cv=pass; b=hV4ekm5ONXfBC0pe0toece8mbNgn3jlpj81fi4oSqo+raTU/p/60SO+zeCbWnkMJ7EGNZzwk3/3hbc8U5LJwMGaNkdey69q1Spfm2//Rs+2OUuBflgIDQdDrJG2tUAPySQ4DUk+t1y9f6xioWmEBm6kBLqsTnmvx24DejsoR0iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494905; c=relaxed/simple;
	bh=7HGI50f9YuPBVz2vVklNMOmm4X9/cnAUg5+U5oFFDD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgCgwFIIVX7n0kuJWtyJeBLo4Uq48dfngVw7ZCY3zIYhWqx59QEIqELI+kaGvbOi1Tf2sNc9b6Vsq22/JnDqE8rYDQWsLm0BmchnoziN9E1tCB0UtWZVoPvkGHa6vBc3Kyh1tDo/bAHhFsFY0RD/z3j2whWxW/AqOx9cL+gLyvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2O9oCi7; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2O9oCi7"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so2094a12.1
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 14:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791494902; cv=none;
        d=google.com; s=arc-20260327;
        b=N3QX6coad42sW/bCf3yFuBvqFJlGMY8ZcetsM4UnYussRfCvoNOXrLbWMgNRFy6w5z
         Z7K+3Mjlz+GaydWJiwZiap8ZAfjJ9TYb508MQlMRm0rnDSX/WJYK7eA6HgepRBxD12I6
         FQkQWqoBsLSdNRI+JWCKqAW05rrnl9DL6d/Ya/OHMCLNWfBRI4jzuQK904Q45zrg2iq0
         HUuqTUaNTFn/3qkJ2QUFFPn0MaLnMrpnjnAdS476SGChF5RIex6ge2TjW3L5hnVkByKO
         AboWEnEdLJ2JfQcfVl+6Y+CAB7OoSyNZdF/uL/EiVr88LmBRDMwcmS8w8ueSs7M5i4rf
         siXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lZ0yBhTFZgOmqcyTQ96kkONqAtxuMkNZwiGRj5yI9ss=;
        fh=zHglkbe9sq7Q99yE1fVEqZXTOA2bVyS3lnnVMr3fkPg=;
        b=IYXTB6OmLavwGCF/W7YdexvvjfBaB3Cdu+r48na5SW0ntyyOyRdbdSDvnS17HJ3apw
         6HjBxk3K0syXoKUSANEaW/ImvgGgkMCch8VPpcoP/wP7V3QOZcLfrLfxKv5SlLv7hsWo
         ejsq69bQFKoAJJ7OIxdda90R7gs8/APzd9c6fJs+aZaRz+ldZAd10L1yynjhJdoqER9o
         nPox6OhtljsrnKRH1n1+otdz0cO9u+CeO4onhdZMV8HHpZX2wZgKEiYblyDIB9hi0JaZ
         k3lbwjfGPiuEMVDZICwchSgP8gDDdoW+EAgwP+vfuMJ/oHo+ak5/2nPNiMBzx4cK0ojy
         dQhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791494902; x=1792099702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lZ0yBhTFZgOmqcyTQ96kkONqAtxuMkNZwiGRj5yI9ss=;
        b=J2O9oCi76VTNXBW6ff3HkUhtEsjc5J3iZPyHcRlazCfJEbVjji2vwAfyCoKyiu3gON
         /7YtlmmaSZp3Zjd3KuiD0bxwV51f9k3b1aKYpOaD+qauCFmP9qcgqHZ8fb+rd6rCjox7
         AGpPF2gHdZzVsDfKSxZ92w7DOchCz3HPnyIImTVD2MMqhQk+Bq3cVVfiUVUdIwzuxi4p
         kDJrNXzo+uSBt0IK4ipz7O3FeT+kjRXJEI6Jse/8tMmUY3hr7H8fOwZwNV5oaVpMAxKz
         OBz/etlC8Oi0fkcTnBmJkzrX0y2K7c/0OTiJ9HY556Z/4KGOn3D23sYlCpDLkPHHJRSK
         fuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791494902; x=1792099702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lZ0yBhTFZgOmqcyTQ96kkONqAtxuMkNZwiGRj5yI9ss=;
        b=jyCPtp9C3DthEbr7IOOO2Ow008otPPTCQt1sKvMWfwF4d2zu1vKOUD5ClYrc6kNpLO
         dl+5MUWE6pFAMrYsFim7jlOt4Frc8C+sMcf1GFgw2WJyq5hdWvvrGknTP7CjvJ7ynzHR
         JYVQ1Byo3ixxtXsmhnsw/PbnfCDG+bFh+O+oKA1KI3LnkFBX6qBo2v3zulJk7raTy3hr
         gpi5Brjzc2tiFt3a063ynUSf/9WNDbdGuCYUi/sv6s/+j8kRgr+UvHpU/OMeal/OGV2N
         W09el9sI8J54/xeOhvYt9Pu5Pkqz0K3Wq940sfe5GBuuO2wYsRSUcrrOqHW/KXt79VEJ
         7Slg==
X-Forwarded-Encrypted: i=1; AKwUvBzvSLJJeEUCx1RxwDbidUXbZEyUqoOlyAWalyMYycOAmVmM77tsZh0TC5iobZ9Fhqad5KU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJH+NRgZaZWKmdgGI/btvPY82yyInhP5f7ohUmsYsmn+vidOecH
	WQo9H/IEfGJeKJ2MeT4J+ZC17/FcxwfqqLg70jT4puKfO5fV9TobmNb5VVDEJsUnGEpke8zh4Os
	cCPSYSonW6WMy49OM3AIpOdFqVCIhA5HHy+e9KkbqjIRzXJdmKe0KOHT7
X-Gm-Gg: AYBFou0ZDZcrbT2uBH4YnbqHQ58XUh+bXd4lfdPElIWc5b9msk75QgNKasu54yDHuN8
	TxCQ89tFczCcPfgHRE6+SgU4MEKchs4iAHRQAdD87XOpSnPe0FhV+o32JYA0kr07EmzbT2YI4mY
	Ah+D56XaObdpG97qPnqcXTcrW2kdfj5HnRAoE76PON8iSV/Zd4GB+sc5NnkG6o9mfBK8ydrSYTK
	1oO0j/OWWLnaI9ALiJgOOxwEz4GSbHnUxDvMuB8Rrojoc5OFM7tWWaICiN+Ta/zH5jOAF28TTd+
	c3u4h3CrsH5AK8QKLpPtxuIFcjmtMQyZizBSp9ckHw+6N78jxy5T2Lo=
X-Received: by 2002:a05:6402:c553:20b0:6a6:8513:7e14 with SMTP id
 4fb4d7f45d1cf-6b1776e9dd6mr10799a12.9.1791494900028; Thu, 08 Oct 2026
 14:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310060022.15120-1-manali.shukla@amd.com> <20260310060022.15120-7-manali.shukla@amd.com>
 <20261008191950.816113-1-jmattson@google.com>
In-Reply-To: <20261008191950.816113-1-jmattson@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 8 Oct 2026 14:28:06 -0700
X-Gm-Features: AclHuK8b-225qeIPP_akfX56_fduZV9nLc7ACZDVhgD59aEr2hz5ZAVf72jgMnY
Message-ID: <CALMp9eRkd-kgBpWTS4nYHaCuDH-PPgB-zvtomBXv-GS7G7M1tA@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] KVM: SVM: Add support for IBS Virtualization
To: Manali Shukla <manali.shukla@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, mingo@redhat.com, bp@alien8.de, 
	kvm@vger.kernel.org, x86@kernel.org, santosh.shukla@amd.com, 
	nikunj.dadhania@amd.com, Naveen.Rao@amd.com, dapeng1.mi@linux.intel.com, 
	ravi.bangoria@amd.com, peterz@infradead.org, Sandipan.Das@amd.com, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 12:19=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Tue, Mar 10, 2026 at 06:00:18AM +0000, Manali Shukla wrote:
> > +     /*
> > +      * When IBS virtualization is enabled, guest reads from
> > +      * MSR_AMD64_IBSFETCHPHYSAD and MSR_AMD64_IBSDCPHYSAD must return=
 0.
> > +      * This is done for security reasons, as guests should not be all=
owed to
> > +      * access or infer any information about the system's physical
> > +      * addresses.
> > +      */
> > +     case MSR_AMD64_IBSDCPHYSAD:
> > +     case MSR_AMD64_IBSFETCHPHYSAD:
> > +             msr_info->data =3D 0;
> > +             break;
> > +
>
> These new cases should be conditional. Before this patch, KVM synthesized
> a #GP for a guest without X86_FEATURE_IBS. Now it returns 0.
>
> But, is this even necessary? APM vol. 2, section 15.38, says that when IB=
S
> virtualization is enabled in the VMCB, the processor returns 0 on guest
> reads from IbsFetchPhysAd and IbsDcPhysAd and ignores guest writes to
> them. Can't we just disable interception of these MSRs when VIBS is enabl=
ed
> for the vCPU, and let the hardware handle them?

Doh! As I realized later in the series, KVM_FEP requires that KVM must
be able to emulate reads and writes of every virtualized MSR...even if
virtualization just means "ignore."
