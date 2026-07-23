Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E2326D55
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 02:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784774807; cv=pass; b=T0a3XDlBl2lGDv7ITUdgzDV1o/jyqevFKtv2z9sgfE+ldQ+LEiLL2Gkp4wijzM5JQ4QkmNC+YoEr7txh+5FCqbfgBaMMVI4YyI4epzqdEdCY7goy6sr9B3QpDG635M/j4L+qpbDw47dZnVbX99AhxxI2o2f4Z9TA0dJ83nWGg9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784774807; c=relaxed/simple;
	bh=kdmk4lR7uTcEm9/XUMkQ5VZciR6/aQPrwVQLu6B5iek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7y1Nxqqi8z2v/XtfGVgv+6YGDCc0EAS0JyFWpiZXLA2oFOMUEQR77pmUd2yONmRqRk0LRER8GpOi1Rm7pMwhM++kGC2W70s7uk+by/m+cTLxH5B1dro3LSEyUX2KyGMQWFOqEAsCxWHZgtQ/M2L5w7uN4Xr+t9M23o3iBOn7r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+/3A6rT; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+/3A6rT"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69f21b7f6cdso4903a12.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 19:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784774802; cv=none;
        d=google.com; s=arc-20260327;
        b=G+jG86dvty2/4mTZB1zPvhrZhWri/cbHNGCkECV6w9f5I3ApykAfX8ivxnaxuAivQF
         GMizg7MadWbUpz+bqL212cO659rt2Xzyk/BmW6N9OEejKNQV48h+BSR523bXYiBdh+o+
         f2L4cwUnL+HN1aNoNWM++w1pr9cxgvT1Dpdo0qIhGKrNxucMSavzGx8aN2W1brvd5RIL
         p9WiEgzRPxfpwHjSLpxCCBGMOnkev+Wu9dQ0zTevPMewWai5gs37jn7VbFir0wb7vJpN
         zrYjQKWveNUi5bWBdw80enAq/KBRVVh9pI5i++qjuDj27lmFdwWlH/nx8bXe1ItbCEy3
         UwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/TQ7+fJH2pBPjOPJfLKTre5jNB0iNHmYrL07T2lCWks=;
        fh=eRYoSqe65mpp2UBdgHctAIN7g1Jujn9Y0U4d21zGBog=;
        b=T1EOTIg1QJnp9cdq2Dtad/3ENaNXLj8+3TNJD2NlGtBD7l4YEHyqSRSJKYvT9b2qZA
         sk0xmIlA0XPWg2RPFdt2t7DW/QYdDXDY23r1KwoESYF59k6AqqZsain8f0RVEC+LIZzC
         8wbwfTQhEodwFRYqqjHKA9GRvD6aIGrzVHisYIQSKUHswzL5rVVc8nq765w++kkmKzEo
         hnEQCOofAMfYnfci3jGnFi3fo4zZTYdELV2W2ydtcS59RVeePbDyUYJrci3FlNP8aO1g
         Gpj7KPdMUurW12WLDCuGk5H3Sqf5TzURcrjzTNhEOLvQ+LE49NQn9SRHbhMSKLi1X4MX
         1lQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784774802; x=1785379602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/TQ7+fJH2pBPjOPJfLKTre5jNB0iNHmYrL07T2lCWks=;
        b=L+/3A6rTlRefuf6fd6gtHk/Rqhsd0FujUSIWyXqoHZ/lRLqGw5Odo4d6p5mMlOpXo+
         1EaSomqMtkrRGaqPYWpZA/uWvRqOTI5DdtfojYpRMqetDrlwbGwNROPECyWc/HFKUiE0
         f9S10Ws/x7sscjude6uPVtyRs4CAIl2kQH9sat1TCGPM1H5spSNvB2g0YFc5xlIXPMz8
         yX2QLaO/7P+bCAoOEhMZrztEdyzwhwJ5g6IP1fQqZiJypCFSrn/w7bYMMZH2gbV6nESx
         LTxM6WHxU5/pacM4VgdYpWTVMxQwoP0JvEUofp1BFLDp7Wy4xxy/nvDHaGWrxX8jM9/Z
         dV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784774802; x=1785379602;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/TQ7+fJH2pBPjOPJfLKTre5jNB0iNHmYrL07T2lCWks=;
        b=bvRBi97zpbuba9J1l1Z/kPW1cvaHVFdyLEx4tDoDaiDDQ/pCI91s1uZwBLw/27RxK6
         ToPAIsMV8RVJl0ZrAn92NIwjIngUaIxJUnraDTvQHi63TOKjFrf2FsjO4ttYBTztxs59
         hhsKY6eEUsClUxvK+O+2mMLI9wp5Z8zfqhbfPdUkWsmdtd0ZvAIckpNr6rInIMIzJPK4
         VY8Rg+Ie7PdsBy5RVfXNA4mQiiAIrbJypqZkgVwNVFiCsSlxQYK2tDLPBVl7PNg5xZfp
         DNqUE7L21+vHpTJTIBFMvZXr/i2WGuIyrj/ZNJDLPsl5lVe4McOfAbVciEEEVPKpMbef
         bIwg==
X-Forwarded-Encrypted: i=1; AHgh+Rr7JRzZ7p9pIjMqLxea6zlPXmnvppB4mU8btqOeqf8fcxkd78iOSRQq0ThyYDi+T20VxDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/xJn8CyQ4XIhuiUAL89TkYMsD0+pFFZWTwX8uqcR2oDIukOQb
	C1Qs4FZx6v5hOApp+N9/uWxrsBHHWAmiAc5WCUYyiVVR/qIGkHKVZXRg+fVdyYIOkwJdplghoRy
	Ciu2Lelbr01NFZ47oSw/wG0gD0JocJ5dM5DglwCRS
X-Gm-Gg: AR+sD10KPcRiaFxhJB++gCERrAWeXWJ0iMSdH9Nj+oeTMuN0WRkZGUx3RsUZx4Vf83S
	JwhVOWkrzJxoK1ntMTW4cGY9FylAdmH+hCPqscq06jZhFV5K/7XmjusllAfqORqQlxWvAiix6PF
	ks3yAkFxZl3l8wFU/ZUAjDTJBwtunCl9HfOJuyGQ8Ch3N6HM85pw5pbmRqZiMnDMyvG+CR7s3un
	AJmVT7BThJLtXn+r1CeRt55VVDE1amVnZcDVLJdZNBCH1JhJeGMPePlRgG1kg==
X-Received: by 2002:a05:6402:a6c9:20b0:697:5678:bc77 with SMTP id
 4fb4d7f45d1cf-69f6cd0cdb9mr17090a12.9.1784774801335; Wed, 22 Jul 2026
 19:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-3-yosry@kernel.org>
 <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
 <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
 <albJNb-akQJ97Yor@google.com> <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
 <amE_nPDem-imSfqF@google.com> <CALMp9eQL7y5chFEDCrqMR9CbJgiJxXN1hVzxVzojsr92AWnqrA@mail.gmail.com>
 <amFf5MAhc8sUqeYV@google.com>
In-Reply-To: <amFf5MAhc8sUqeYV@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 22 Jul 2026 19:46:29 -0700
X-Gm-Features: AUfX_mzfC-Wq0TWGAUjv7qQke6ZO51sJQ6gahjnxmjyb81f9kl2ta1H4oktn76Q
Message-ID: <CALMp9eSssBCuTTWdr1qT2c4Nto2PQO-QOBnobcx2kTnuQaOB1g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 5:27=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Jul 22, 2026, Jim Mattson wrote:
> > On Wed, Jul 22, 2026 at 3:09=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Tue, Jul 14, 2026, Jim Mattson wrote:
> > > > On Tue, Jul 14, 2026 at 4:41=E2=80=AFPM Sean Christopherson <seanjc=
@google.com> wrote:
> > > >
> > > > > What complications?  Advertise the lowest common feature set for =
the pool, just
> > > > > like userspace has to do for literally every other feature.
> > > >
> > > > The problem with passing through the number of host ASIDs to the gu=
est
> > > > is what to do when the combined host plus guest usage exceeds the
> > > > number of available ASIDs, particularly when FlushByASID is not
> > > > available.
> > >
> > > But that doesn't have anything to do with the number of ASIDs that KV=
M enumerates
> > > to L1.  As of this series, the number ASIDs KVM will consume in hardw=
are is a
> > > property of the total number of vCPUs in the system (one ASID per vCP=
U, plus one
> > > more for nested usage).  E.g. if KVM advertises 10000 ASIDs to L1, al=
l 10000
> > > (10001, if ASID=3D0 counts?) of the those ASIDs will map to svm->nest=
ed.asid02.
> >
> > That's not the only conceivable implementation.
>
> But it is what is proposed in this series.
>
> > KVM could advertise 64 ASIDs to L1 and reserve the corresponding non-ze=
ro
> > ASIDs for L2 VMs (i.e. the first L1 ASID is 64). Then, vmcb02.asid =3D
> > vmcb12.asid & 0x3f.
> >
> > > Of course, that completely undermines my statement about suboptimal p=
erformance:
> > >
> > >   And potentially suboptimal for performance.  There might be a legit=
imate reason
> > >   why a CPU generation advertises X instead of Y.
> > >
> > > My bogus assertion about performance notwithstanding, I still think a=
dvertising
> > > what hardware supports is the simple, sane approach.  Because at the =
end of the
> > > day it's just that: advertising.  Userspace can do whatever it wants,=
 including
> > > peeking at raw CPUID.  E.g. if we want to pull a stupid and emulate t=
he behavior
> > > of ignoring "unsupported" ASIDs, then we'd need to do that based on u=
serspace's
> > > defined CPUID model, not KVM's advertised support.
> >
> > But you could refuse a userspace CPUID model that claims more ASIDs
> > than KVM supports.
>
> Nah, that's not the KVM way.  For this one in particular, there's zero re=
ason to
> enforce anything.  Practically speaking, *if* we want KVM to act like har=
dware
> and ignore unsupported ASIDs, then KVM *must* allow userspace to define a=
 max ASID
> other than exactly what's reported by KVM_GET_SUPPORTED_CPUID, otherwise =
migration
> pools become impossible.  And at that point, disallowing a larger max ASI=
D adds
> zero value.
>
> If KVM claiming support for an explicit number of ASIDs is a sticking poi=
nt, then
> I vote to zero the output in KVM_GET_SUPPORTED_CPUID, but I'd prefer not =
to do
> that because it will break reflecting KVM_GET_SUPPORTED_CPUID directly ba=
ck into
> KVM_SET_CPUID2.

If KVM supports any userspace-provided value for NASIDS, then
shouldn't KVM_GET_SUPPORTED_CPUID return 0xffffffff?

> > And __nested_copy_vmcb_control_to_cache() already ignores a bunch of
> > unsupported bits. I don't see how this is any different. That's how
> > the hardware is implemented. Intel likes to fail VM-entry. AMD prefers
> > to just ignore hypervisor stupidity and move on.
>
> The issue is that KVM has played nice with unsupported ASIDs for years.  =
If we
> want to change that, it needs to be quirked.  And I just don't see the po=
int,
> because KVM's behavior isn't outright wrong: the APM doesn't say what wil=
l happen
> if the hypervisor is being stupid.

The APM doesn't say that an out-of-bounds ASID causes VM-entry
failure. What other possibilities remain?
