Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536123ED5B2
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600536; cv=pass; b=dyD7Uzno+ud5pbU4/PBBIH2yHX5qYgLzhRdrnGN1C+uM1Ng7IV4mqKAVqcCrpWk52TYxuarLue3P1uPOc1xs+lr3ZjUODNlQfzilFxkDKDTtxjO8K7SDJsJqI99S2KjPgpwuACX0WiozvMFCK0rXLAzd/cwtxS/wAbi4GHcv140=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600536; c=relaxed/simple;
	bh=eokRNj+CzwBk4d/OXJhoVmSnD13JjXmvuRxQy9yUpuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYjmqeOLGS9jf7RjSTZjtRXKYKJqJlpV42hCs2+wJQEDQtvHOEEn4Rq6OldvRc6hmYiaIDyt8UWZEbVMPRtwp6KIaFkzcmfD2UXZqKkxm5XuGSUPQN+Igbx9l3DeOITWw/H146oTRJw5W5FJDs7gCd08y2jdOhTTurXpGu0VySQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VGXkYE7S; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGXkYE7S"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so11413a12.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 05:35:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783600533; cv=none;
        d=google.com; s=arc-20260327;
        b=VjAI9rYj1NgI5d2MzEhtbr1K6SGE7DREM+Rkjfaxar3D4Lb2Qklkam3zHWvN1tIVNN
         VujY30jB1Dy1q4CaoI6uJhln8/pOEHGtWjdty4RpooXeTLrbTKT76YFrbcKT1yL/04Rs
         /lxxEbwnK2/dBdfwbyYHfHjLEZHYVmWOe4qKN/QUFHoGOfmUIQEbLnLRmIca/ezSsYmE
         ejsUMzwkj6DcpDkLsT0BEYG+ncn/ng7pTZfx1Mgrm9Src2NyFPWVyykouaXldpFJqles
         TEwUadgI2pA6y/3lmZ+whl9bCu9Lvj1YOj355jsCx3tx5p8alV6tUq5YADpE5vg86FGi
         73cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T+3sBxzy9rZ76iM+HEwJr045hqmIkmQAIGdEWDOC5nc=;
        fh=ouPNXPFx2d1USv5nImYIPMFRIhSkR5xb/wYBbNrZszs=;
        b=gy4OolMmCLGxflYGkfT/I7O1ct94jzHJuZnEwgh82RsbaACOSVEqfdxM9gY1D22aFF
         M52X74C/UdYoau6LntvetshMZEN3bZVrJKzQzMgvz/AHS2jRrUFnYfM3mCNJGWtC78aJ
         hEadrs6qd1JUDalQwooyJ3ayHF7EjkDUyLrKQpGAIkiBOQ6aW1dRbpFDam5xwJJ0fmRA
         Y2ltMetCzf8JKezF260RSHaMUVdSQ/kIYS+Ro/Hc6lexRZ/mIWtKOk7E48Dfgd0jtivf
         /aXFtpqeydzH3vL2nXzGlvQ3oGSLBywVdUIPIfmmDtggp6xUBfYCjMPB/O7GWXEP/ofk
         RgmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783600533; x=1784205333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T+3sBxzy9rZ76iM+HEwJr045hqmIkmQAIGdEWDOC5nc=;
        b=VGXkYE7SuC2BZGJt5JFc+KAdOLQsy7RBzw0sq/Be1M9aDea7CAYgdimDwQH5R0eTjD
         UxxnMAad+nCd1sN+OamjO/IqSTO+dQDqZxPOXufQLaQP5mTHj4spQAxS6sMy+XPje0vg
         02tZWxQjuRvjeorr6fSu0eEyooBdY7OAQbwIfmFYjWDSQQDj3N7O6pZAE80JfMwerNhR
         SqL/TrEtfXgYeNK3OPXvmb6cgtSI7MWYm9oMdElynZtnLtMzql2z8IkBt2Tb0pEL7Nn4
         l8MKEuoZ213F01Vf6ZLScorTCFy2nnDTKt6PDRHj1PFSkS8Pd5RsaCy0f++ypHpdx5Nf
         Hg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600533; x=1784205333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T+3sBxzy9rZ76iM+HEwJr045hqmIkmQAIGdEWDOC5nc=;
        b=JeFWk3Fz7aRsf9EG87ZoSVyCXMS1VPI1pvSWX/Ffgt4BQAvQP+CoseAbwq5ku2F2Wi
         BDeTx9Mp5BnE8iqlA5NDcxGbcn1lpR0v8Xrl4kBlzQzC5SYtoYz0ShOxf0mLp1Xy+fOz
         BYe3vhbfwZBgfcYWgbRxaQklni2rf3gVhz7p2oE/ZxJ0eTfXhlSlz/6lFoqwJVsgC9Ig
         8qUFeU+svbsgq0k66t77Wjc3zT82ctndvb6tlNGs6hAil/CkGGl7XSvI+I41t0E5H0Vz
         tZ+MxrXwEr8wOvtFdxR2JGaTE/LsKrYaGM5wnQpCsM+ifz0h+6jVuXnyOYj4LnyYmrSg
         +96A==
X-Forwarded-Encrypted: i=1; AHgh+Rqg9AsOVhvujNiyNwFEt89mBPIjoZ6dVjLZIziC8PFD0jiPVKIY0fgi9cyDE3e3u6F2Fkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGCInewWkEZllzk8VdHiK1NqmX1vHN0jt0s5QxjawFR038kAbc
	j9SbyM9UWUbBi66jBIOpV/2dtrXchBK7HXxCDi97JrmjdPsxkmPrd2bpl8nZaGRYPw1a+cNdeKr
	/8+QD/NEgu2ppV9RcGBwcPxK7055bLrJBaENfZjw7
X-Gm-Gg: AfdE7cmB2+PJVWjDU94O7TVV2cZVZ/su+aooIjL1hJsiYK9jrq+qG9Eo9QWlbm1tsZ9
	o291OMUP9d2hjCezTjUSNXlmw1aOXvTDzaBYWyrAogiNP28ffktI4NmX1UrRVl6hpfB5MV4oo+b
	g1qZ3/X89SGGGE/5iraIJxZGEJKZ6UwDIch/kh1q7/iE2v32/FsrnPXiPwb7GUltXdjByvcMHsl
	lvakzVU1P8FDwG1c019U6tPuQ5b0feoR9ASQ4eBMlDwNKBC4JDYZdj1wYfVakvt+nqQ2kME
X-Received: by 2002:a05:6402:20d2:10b0:695:4751:c044 with SMTP id
 4fb4d7f45d1cf-69bfe5b771cmr47844a12.8.1783600533028; Thu, 09 Jul 2026
 05:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-9-zide.chen@intel.com>
 <32a1e1d2-c437-4cd1-8455-43fa9082cb50@linux.intel.com>
In-Reply-To: <32a1e1d2-c437-4cd1-8455-43fa9082cb50@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 9 Jul 2026 05:35:20 -0700
X-Gm-Features: AUfX_mx_t5tmlexrgnIPYarK6PS8ufr5t8Cz55PZLKuUPFfecWEyA5LxBSzIMZc
Message-ID: <CALMp9eQR4rFTSDMrOSHsLXsKvTdm9BbhorMEK329RqRk5Rr7Og@mail.gmail.com>
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

On Mon, Jun 29, 2026 at 7:36=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 6/30/2026 7:19 AM, Zide Chen wrote:
> > Add a test case to exercise IA32_PERF_METRICS, i.e. architectural
> > support for Topdown (TMA) Level 1 metrics, enumerated by
> > IA32_PERF_CAPABILITIES[15].
> >
> > Only check for non-zero metrics, as they are derived and depend on
> > the workload, CPU model, and host scheduling, making precise
> > expectations fragile.
> >
> > Extend the PMU selftest to cover Intel fixed counter 3 by bumping
> > MAX_NR_FIXED_COUNTERS to 4 and validating basic functionality.
> >
> > Signed-off-by: Zide Chen <zide.chen@intel.com>
> > ---
> > ...
> > +static void __guest_test_perf_metrics(void)
> > +{
> > +     int retiring, bad_spec, fe_bound, be_bound, sum;
> > +     u64 global_ctrl, metrics;
> > +
> > +     if ((guest_get_pmu_version() < 2) ||    /* Does guest have GLOBAL=
_CTRL? */
> > +         !this_cpu_has(X86_FEATURE_PDCM) ||
> > +         !(rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_PERF_METRICS))
> > +             return;
> > +
> > +     wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> > +     wrmsr(MSR_CORE_PERF_FIXED_CTR3, 0);
> > +     wrmsr(MSR_PERF_METRICS, 0);
> > +
> > +     /* Enable fixed ctr3 (TOPDOWN.SLOTS) and PERF_METRICS. */
> > +     wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(3, FIXED_PMC_K=
ERNEL));
> > +     global_ctrl =3D FIXED_PMC_GLOBAL_CTRL_ENABLE(3) |
> > +                   PERF_METRICS_GLOBAL_CTRL_ENABLE;
> > +
> > +     GUEST_RUN_PAYLOAD(MSR_CORE_PERF_GLOBAL_CTRL, global_ctrl, "");
> > +
> > +     /* Check test results. */
> > +     metrics =3D rdmsr(MSR_PERF_METRICS);
>
> Could we use rdpmc instead of rdmsr here? rdpmc is a preferred way to rea=
d
> counter value.

This is in-guest code, so the unintercepted RDMSR will be much faster
than the emulated RDPMC.

Should we rethink that preference, or add hardware support for
selective RDPMC intercepts?
