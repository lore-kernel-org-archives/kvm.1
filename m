Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197AA39CCE1
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048830; cv=pass; b=Kdn5PX6wu/KSf1e6suTaSVvQ2BIBInsUydIUg90zdLBRDdoSDICg405AngPn6GzA8Oo5KFkiWG4W7hUnZn71j4Vydk3uU2F+Az+oz8RBRQ1jIdTq7wv2ccoJuS20uhqCx3+a7x8skzLBYb7puXP6KUhyLKvYYzhuZNxR3yQU1AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048830; c=relaxed/simple;
	bh=ua0S5PwAy06b/fo/+yzPoL7SaCEDVphqnBYH5degzyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pR6nPUI+1jcZsWOLrmUMQnY2g/zAbnxhS4NKIT0p8oigwPyfln5GqfdfkljlQdC3pnUK3yyRuMvf32HMOdEmocOUWt5RRX7a/mL9bDpGa1cuAqTAdGwBietprdf6AH/9q1W7NpdVCQ8uBKT4P0jdyu1r7mOtDSkiN1Q936W9jrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5xBbXMJ; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5xBbXMJ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso16658a12.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 10:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784048827; cv=none;
        d=google.com; s=arc-20260327;
        b=o5/XIWGQkSrp4zFqpCLXGMkvOFqoRTkEBMc/lTvmdufsIEvtlSVRJrpPrcQ4nDhq1m
         vsxGGSyod5aO2kZKNrv+J1GRsikm1kYTFwU5tpTAjjCvSsmK4IR6k9FINija56rLYSn6
         zxO2U0rBGFscsjAUbSRzfwMF5sZNadEXBjeOWYs3JXfogNNInCuvzkgl0uxXxaXcBCZT
         qW9zVtuAMYb4+HsF6XIi0KMkEgvNB3aWI4Tbv7nDCyAqkMhXx+mbG6AipVxLdGGWZ56E
         +YCITedjXeJWc2gNPxrkbfEy0YmOJFCwYWsgSR6SK3Xt6lWHfLyDpia8T2bUacOtGiBA
         cSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ua0S5PwAy06b/fo/+yzPoL7SaCEDVphqnBYH5degzyg=;
        fh=fNdoBRcFIP9XdSP1Dt14DEVOeuav37gXGUqVthUCAWA=;
        b=JyMBS5PVOqd9r4EX6bwBqHS9tVGGHzr7UX1YDHvhkUrLyagRAdDIHWowzlG9xagI2w
         YuJ5TbbO+KctCnGCJa6cGdxcd4LHcBagZJfASt1uyW5wxjNlr2/Smltlk5aPyhF4VGWk
         imPV+4ZzAlvDmIIEsJpNWFSnLUozMaJVktlMeUJgOROo8EJroWd8aHlRS7sfiHSxJERC
         pl4UzmUCK8fQi9V5ESbok1riA8sMFhkhbfOSAoyGtRPtgHmO245wDZJlNcmP0+5DNZAp
         KTafnfi5oOSasPDUrMivBO+8FOWeQZVPQM8Hx1Nw/3leVJP5ldtM/gsq4UmS85spug6s
         zw/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784048827; x=1784653627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ua0S5PwAy06b/fo/+yzPoL7SaCEDVphqnBYH5degzyg=;
        b=r5xBbXMJUlCIBt8ga35XaD8uR02lAAk9Gz3yVUI78TX3qevn91BDwGOqxv2uFd2Il2
         2qvA4zgLjYcuX227nNHtKRE6ARctA8mm9I1MpoXz1u7fTf7H5xOUGoBcu9RVY9Pqc/Yi
         V9LkfhfP/0fZeHCNa0tnALw/MXViKLVF/M3QUlUnvCS1mUYyD285nR/UQckC4QmDUrPo
         NJvETEpDysNfXyJffb6imMBvU2oZWz5s7RE2TKphzwQqRfrVMeSWKrvUYBa6Q60ipi3B
         2psIyfZPJGM5iclym2Vqz5svsY7nQ3Y5FGjYkcfz0O8mDeyJkq5d48VrgLyGyYwyoZsC
         w+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784048827; x=1784653627;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ua0S5PwAy06b/fo/+yzPoL7SaCEDVphqnBYH5degzyg=;
        b=raHIGEDE6plqxU9mGUw7EiSMscgwSTtUBuNdUWl3a9jEf/ZX62HMPRRjwEDHZqjaqb
         QBtlwEIcYSk5Z//GOCH3oajT3ZbVQ6drvFksjqLQqMAwE2t2LTgJBpMNeXRwO16wTKCS
         qjjXn3GBeWl3xY0quwPS3Iq5xD5ZeKnYABJUALDQbULus785F0YMC0/rK+kqR1LrratO
         zFu2nn9n1iaimL1ys8MguSEBMoAFexrkqIHAF4COaZ3YnaNM+5Nuzhaw9tNZgyBEVYSD
         7M2XGZHN705Ti2l3vOwKYrDgElJuWBQ/qH4qpB6BEktjNaFfcqxf+NhVV1ffNU+cLM67
         MkBA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3MZUO5L7MMdOeNbYPl06cJqWadOSg2gyaR7NNcQ5gqZVtyn0N+PPJz1D5mr5b+uskIAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzebEebfS/Iwno59BnxMxOuj29Zw9brH4Vc7npIrgIeEpsDbz7Q
	uJlSrYE8m30Kh+I1+25evjDLQPraaaz6XEkSgttTbyQDtcyBdzQfG59oQCDgyAEf0izbvjOA5/k
	UuGGvdQeHi00wBpzOYrcZ4J/Ldps9CGrjQq8Dajxh
X-Gm-Gg: AfdE7cmiltXftBWJzshMIrJXteX1PMRtDZtKTGW8QUhrJOa/091opxn2J5ThqSA69ij
	i7bdd7lLNjF3IJyFIztoSTfyAD+GjYVnfByuwSEFaGzptFJbBG5vYLf3YVnq4vJ6wM3xIxcgmfz
	0RDqJfkY3LmqNTytIF6sbEd5Hz+ik40du6uYx0Zoearg/s2Rp+mcZhIGfE9NBGxs/6GiyLKvTso
	eUSXGZMuvVy0/L7bbQATbXXpgLXbrNMmtp5lvkQmrlwzNezrpZ6w0syMRB/99K88M6vIYQF
X-Received: by 2002:a05:6402:e93:b0:698:ac70:31b9 with SMTP id
 4fb4d7f45d1cf-69ccf0cd08amr144151a12.5.1784048826589; Tue, 14 Jul 2026
 10:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-9-zide.chen@intel.com>
 <32a1e1d2-c437-4cd1-8455-43fa9082cb50@linux.intel.com> <CALMp9eQR4rFTSDMrOSHsLXsKvTdm9BbhorMEK329RqRk5Rr7Og@mail.gmail.com>
 <5760cb18-739c-4907-b582-60933d11a72d@linux.intel.com> <CALMp9eTs1A73DUDQwO_mHDQF8UfJQG2B_GgJczdu2uxdazG+KQ@mail.gmail.com>
 <212b058b-5804-4a00-a95a-67f58546fd9a@linux.intel.com> <CALMp9eQGTde_nbCtHN5E4GiuBKrcKC+Sq_6O_JoyHZCaf+S=rw@mail.gmail.com>
 <dc8adc2b-ca9f-4ac6-9f15-e9e954e90b15@linux.intel.com>
In-Reply-To: <dc8adc2b-ca9f-4ac6-9f15-e9e954e90b15@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 14 Jul 2026 10:06:54 -0700
X-Gm-Features: AUfX_mwrxSLXMo-jOcDUtgBu0rW2i4Wy8O2Xtk9eNo1eO8rEuoIledgTL-jIquw
Message-ID: <CALMp9eR0yXVPqOUZzoBSmGTpONojSALS7X-Rrq8QkaivnNgt8w@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] KVM: selftests: Add PERF_METRICS and fixed counter
 3 tests
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 10:28=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
>
>
> On 7/14/2026 1:11 PM, Jim Mattson wrote:
> > On Mon, Jul 13, 2026 at 12:12=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.i=
ntel.com> wrote:
> >
> >> rdpmc is the preferable way to read PMU counters since the better
> >> performance than rdmsr, and most of current code regardless of kernel =
or
> >> user-space already use rdpmc to read PMC counters. If we set the rdpmc=
 to
> >> interception by default, then it may cause extra performance hit.
> >>
> >> Currently I didn't hear there is any plan to extend the rdpmc to suppo=
rt
> >> more types for Intel platforms ...
> > Is Intel willing to commit to that?
>
> I'm afraid not. :(

Then, KVM must always intercept RDPMC.

> rdpmc is still possible to be extended to support more types in the futur=
e,
> but recently we don't see such requirements.

That's no comfort.

An alternative would be for Intel to provide a way for KVM to query
which types of PMC are supported in ECX[31:16], before or concurrently
with any microarchitecture that supports more types than CPUs support
today.
