Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FDE364EB8
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696966; cv=pass; b=Ybt1CP/8Jofpy7hqdh1ZnmiGs42mXX0SyGrA3+FeJIBpxZI0zVm5b55rOx/LkWZiCaA0R27GuT+217+j4ZhTcac/PxLLs1Sub4la+OefHr2lcOsmW8l8ZckCkWV68yvgLjiq9iiKqZZUQ4D9y9GGB7+9jQUOA9qn/PUmBnCUnwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696966; c=relaxed/simple;
	bh=fDN+i4W1t/RzbgL6qklPOpn1NFT7k4pdgH4SxDMEqCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbEvoomiArLSq28P2df8VvA6O8+cGnFvdQ856pPORvACAgQJQBCJFBT1695B3zdXFlWuLBj96XMC9kBoCKwtdhaDFwE4WgeSNeLetOSCCcwjOTMcVegvQpNg+tbsywD04TzqMcgHELjEObXBPk3Va6BPg1RkBhfU8bXW2dm4xno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WhKaOmRv; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhKaOmRv"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c10ed63c0so253581cf.1
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 08:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783696961; cv=none;
        d=google.com; s=arc-20260327;
        b=HymzZ61aTSNAHJGzC+fO2Wt6MMg0/AixF7kbM0Ts4HqMNdzNzfBcDwk8AvgquGlfwq
         agtRIrQvfl5wjqXe8/cdTj9lFQa/ZBzqheE/b5P++HOm5t1NisMfBv8gfsMIvt93PfF/
         wVapoGvi3J/Xh9JJKf5YiFQ9Z/XO9RVW2mlijfsQZQM6iXl6erIqsgyKm/e1mkeIYJ88
         c2veDWD4f9Zvh3eF6zjnphUFrBfpiSHL594ML78vYUX00zYUilKoGpWbQl/9RDV7hh9W
         NVt9H4ETToINPwkyDYDahkwFW9vSTwJikLLePCKjTtF+8ztWYTic259YQirfYg1EHPd8
         ilqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oe8g84Q8QptvLiJ5nnnO9tvGuKAJrxC0mI9I1ZBQI0A=;
        fh=GahlIG2J1dMtGjvCiy3GXbRMff6pfrqQnyu0pbf2Img=;
        b=DjhBW7UdIAN5nH9GOX6IXi3SEVO21KsJ23qv0Bp+Rils0EulG85JRFaDciERRJnkue
         LkVWl1vcwWTjRfJtjkDo55o6iwAdwYB9dec5kL9uLaIz1DNahM4wzcGlI42gzla0cwdx
         RsLcmBaLJ3xTPpBNyxzjRMVQz1oxZFDaUg6jLlFYC0vMezPCnEac6VW+f26cD1d8VMCz
         dul0JXsJqYhI7fQeVjC832RcCPfuQpc38l0SLxqVPpYKMcqK693pBxztex3Pf15UmbqK
         9i5YigiyBZeDJjWHobn2f4PDwt21BMkDN7KWSkNFJfLPPtph9cJOdFgW4kU3Pcs5i0P1
         UcAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783696961; x=1784301761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oe8g84Q8QptvLiJ5nnnO9tvGuKAJrxC0mI9I1ZBQI0A=;
        b=WhKaOmRvPKZkHUZdxebSbhJwSaCBsrTtUGHJ+prltGT9yjUEswnws+86FwbUwm4DmF
         uoTwsNyjzXSOQlhn9ACQXqneZtgvJpUdqMM/bh8sPVlSkNvrK1Ua4J/ViEQ6WbLKohEX
         Sh6NracXYC3PZKDzdEUYxvLS4DutzzkAn6dejdV293M3mHv4OIdML5JD/TQuqhpLBV6N
         cjeyMQBfCYmUIO1Zd3wzWkM+MyvJZuyXgUHXiV2CkI1vk2+lOUO/OR17JpqOEcZZ49YH
         IqfPgSZPLi+fVTW1lkgUX3bmL9cA8twkZSxQBQG0Zf2ZHXCd0AL8ZPAbdqlKShnGeFgI
         UGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696961; x=1784301761;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oe8g84Q8QptvLiJ5nnnO9tvGuKAJrxC0mI9I1ZBQI0A=;
        b=Ba4+qIErgnLwYz5t20X7S8+JqBbw/xFbbXZA7mlfA0Fu65OgWnQlC8J0GPTCF5ugDs
         l5WpOOzZAaVOFtXwEXu2jbTjtr8QGoHDg+zalJAvEhb9uqka/YpfAM98qUNxmFCObrZE
         cbwVshxbsfUOETL9O4Lk1ZHSxGrum7gv4mNoXvzhEui5blosKjWRYJ+kjc7FmT7im3Nf
         QHCom/uxh9MaiyZV9VFXytpt5mv5G6TacRqtl3cSzVvaPChRlGSNQIploiQ+PlXItLbX
         jlpJgbZwj0Xzak8ZVdBm5ZF0u8KTRIyKuEQLvqIqiVkpKlr2aO+YY6fXDPI/yROImCPC
         53xA==
X-Forwarded-Encrypted: i=1; AHgh+RoANJ8AiSzLHkG5IybgutkEoyr5b9Sel9dUrtQZJT6ICzEPgcSzBN/LNBR1mm34OpgmqE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwovOGBia/CjnVjYdW57Qt5jnhleScUQr7dbgR51J+LM4cnk5zA
	SKK4vXrE4qkx/cskEDAi7Nlsr5ISxSbplc6gAOMvzaokoU53tYeb9ozV4nL2Ecm+owdERL5yZ0x
	1eLkwAu2omCmWSxdW2h/uATV433kul4qzDpm+s+sF
X-Gm-Gg: AfdE7clYi+hCM0nmUbT9rAumgHmaWuJf3vn9eDuarcGlN3G3c3IKTWygD1YS8rMnhcX
	gCBPPVgfgL4YtLsbOW7RSAMcH9I5OLIEcLzGNSTRdWHT8gjlo0oLPddtbearC+MIZ8WME+kw2QU
	9RmPqEM5MFY2hBk84ZWFaYFvGxfsniDaHcPtJM9KSbBvCBBB/5B7vApVmqp8/ZJeKijv189J/Cf
	7mVQdYueqpA7TeN5Hl16tKKcIKCbdnl8wQh/eShE631wXGa7SL9rE8zb1fXlFtCfv8x7/N6
X-Received: by 2002:ac8:7f0b:0:b0:51c:6b7:d3de with SMTP id
 d75a77b69052e-51cac52fd6emr8894411cf.5.1783696960645; Fri, 10 Jul 2026
 08:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-9-zide.chen@intel.com>
 <32a1e1d2-c437-4cd1-8455-43fa9082cb50@linux.intel.com> <CALMp9eQR4rFTSDMrOSHsLXsKvTdm9BbhorMEK329RqRk5Rr7Og@mail.gmail.com>
 <5760cb18-739c-4907-b582-60933d11a72d@linux.intel.com>
In-Reply-To: <5760cb18-739c-4907-b582-60933d11a72d@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 10 Jul 2026 08:22:24 -0700
X-Gm-Features: AUfX_mzYFStNT62ML8GuCFiGJ11e3qf9ECVoRGiFZzb4vSv922cqNEvby0d6z1A
Message-ID: <CALMp9eTs1A73DUDQwO_mHDQF8UfJQG2B_GgJczdu2uxdazG+KQ@mail.gmail.com>
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

On Fri, Jul 10, 2026 at 1:08=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 7/9/2026 8:35 PM, Jim Mattson wrote:
> > On Mon, Jun 29, 2026 at 7:36=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.in=
tel.com> wrote:
> >>
> >> On 6/30/2026 7:19 AM, Zide Chen wrote:
> >>> Add a test case to exercise IA32_PERF_METRICS, i.e. architectural
> >>> support for Topdown (TMA) Level 1 metrics, enumerated by
> >>> IA32_PERF_CAPABILITIES[15].
> >>>
> >>> Only check for non-zero metrics, as they are derived and depend on
> >>> the workload, CPU model, and host scheduling, making precise
> >>> expectations fragile.
> >>>
> >>> Extend the PMU selftest to cover Intel fixed counter 3 by bumping
> >>> MAX_NR_FIXED_COUNTERS to 4 and validating basic functionality.
> >>>
> >>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> >>> ---
> >>> ...
> >>> +static void __guest_test_perf_metrics(void)
> >>> +{
> >>> +     int retiring, bad_spec, fe_bound, be_bound, sum;
> >>> +     u64 global_ctrl, metrics;
> >>> +
> >>> +     if ((guest_get_pmu_version() < 2) ||    /* Does guest have GLOB=
AL_CTRL? */
> >>> +         !this_cpu_has(X86_FEATURE_PDCM) ||
> >>> +         !(rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_PERF_METRICS=
))
> >>> +             return;
> >>> +
> >>> +     wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> >>> +     wrmsr(MSR_CORE_PERF_FIXED_CTR3, 0);
> >>> +     wrmsr(MSR_PERF_METRICS, 0);
> >>> +
> >>> +     /* Enable fixed ctr3 (TOPDOWN.SLOTS) and PERF_METRICS. */
> >>> +     wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(3, FIXED_PMC=
_KERNEL));
> >>> +     global_ctrl =3D FIXED_PMC_GLOBAL_CTRL_ENABLE(3) |
> >>> +                   PERF_METRICS_GLOBAL_CTRL_ENABLE;
> >>> +
> >>> +     GUEST_RUN_PAYLOAD(MSR_CORE_PERF_GLOBAL_CTRL, global_ctrl, "");
> >>> +
> >>> +     /* Check test results. */
> >>> +     metrics =3D rdmsr(MSR_PERF_METRICS);
> >> Could we use rdpmc instead of rdmsr here? rdpmc is a preferred way to =
read
> >> counter value.
> > This is in-guest code, so the unintercepted RDMSR will be much faster
> > than the emulated RDPMC.
> >
> > Should we rethink that preference, or add hardware support for
> > selective RDPMC intercepts?
>
> Hmm, in current most cases, rdpmc and rdmsr should share consistent
> interception configuration for PERF_METRICS except host and guest have
> different counters bitmap.

I'm assuming that Intel wants to reserve the right to cover other
resources with RDPMC in the future. Unless we have some way of
determining, through a hardware enumeration, that all readable
resources contain guest state, then we will akways have to intercept
RDPMC.

If I'm wrong, and Intel is willing to guarantee that no new resources
will ever be added, then we can let the guest execute RDPMC natively,
when the guest owns all of the counters and  PERF_METRICS.
