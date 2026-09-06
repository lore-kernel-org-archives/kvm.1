Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2C364E88
	for <kvm@vger.kernel.org>; Sun,  6 Sep 2026 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712186; cv=pass; b=FyLBsAFHWUeIme9EhxsdW3Ls5MEq2lLri9k6gVul42b7KACdsDrOaEd6EPtS97VV8vAFxFObUSyLnp1SJp6D1Xqdckm8Fz+YdjyFxRCIHHSTHsrsqoiRe7dPT56hXqt4oDS9VLI8ncuX3A+2Fbvw6kEG3+efmObGufIE8WvE/Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712186; c=relaxed/simple;
	bh=xsSKiOspqG/+MtQ6W1neljIxJh5ynRg01+19OLjolSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxTKHJ2EHTY7hmlDe4/YIuua78V4NL+3xJWwhei/HJ7cy2jrQwGyauzW/6iHwTS/yZmWs7bR5uQP9xmPKo/MxV5tSBVuH9LQiMyAFbN10VyRye4dStl7FOjVCCpUZPqlmFY0VI2dHyIHnk9ORsNBCIFtdUr1qfTFqDJhIeGz9Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GWePuTp4; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GWePuTp4"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a613a6bcd8so6329a12.0
        for <kvm@vger.kernel.org>; Sun, 06 Sep 2026 09:29:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788712183; cv=none;
        d=google.com; s=arc-20260327;
        b=A3m9wtcCj69yZpuwN4qWXkfdbn4v8pZ/D0lSZLPe8rRL86Db/V+Q49GICXVXZE0aLq
         ye9WcwKxJzkEOC4u//Pno4T52L80bAai4A425IytYRhtcHuxjlG1k/akAPpMi9G1Qn4i
         5auKIqV+nzFVP9pqnfXz9t12MVZk4mtGIRERwjHVTSO8tptFoSXCQxttcTWaD8idkFK4
         /t6MqUoDdqXo0W7kQB58B2oXM0xqQ7VSBHGURre9gnztTXV3oJTS0PO6jbTvcnZAJAXV
         8gH/FwD7t3A2XWtv+2YBRmCB2wUTOOolITf4IWYEMNS3FwAmWb9Y7/rNpCPHKlUl4Le3
         nK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Um0Pe18GpPgK3b7kgderSLxwrHj3TqfaAiHEwFEfg9w=;
        fh=s/nrpVEgP93NB+p7xuDRDeclBYntDeAAgXSzkFNOGcg=;
        b=l03dLW5oRCMPikGDjqUKnz940W5Srr+o5PVp+pOS9CD3dnf+UCogDYhPL+YN1T0Kgn
         txwP5zcr0RQnOw4GEkP7c5CXE5cSGWoI3gu31ph0SBgN6xSnitl341ssXUWpJaatHkM/
         Ly8Dem/1dmkd97/1sU7FiruvUJUzTjUb6FdPcY2qzw8SDSYTnaq+K2eQ8/+F9eeKA1qW
         iRfO1OVJHzLBn/CFExCYCAso746DvJza4tK1gU8dvaJkxnhOXXsPikUEVzpX3V1HHFvI
         MMiiw2Wj7Al5E4LsXVE0XW5IWc+GdIj54twau7pVgDtVtgtSP3PCz1aC8M6Z5E4thWIG
         jMzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788712183; x=1789316983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Um0Pe18GpPgK3b7kgderSLxwrHj3TqfaAiHEwFEfg9w=;
        b=GWePuTp4DyHrmoN8RLCVlXAjiCAR/3l1vV/63TROXgeraA2vNAIlYSw/TaijwUXHok
         81FwDN/HrJCCReCymBaJGEuJNS09kC1iOyQpuOTXgoPfVUODPsOIMxPTXKFsbMl/C3JM
         AO1X34qSdgEz6IepWDXHn6AejkbWcAAz57CENDd7x0AYjxtZDHu928woYrHYxpnpwru2
         X66QUawfG0NBVnHgzgTPAHSFK2ypFht9ikySCIHD3Xw4t1y8z3T+wqP/rsppziWJWHtE
         3GnyF3bknUmgvqsg1KTL426+BFOdQo+J3OtVW2yAMVHZ7GPMIOg/jd0Nfd8jx3p2MP7c
         xnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788712183; x=1789316983;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Um0Pe18GpPgK3b7kgderSLxwrHj3TqfaAiHEwFEfg9w=;
        b=qtyXCEUkiiljAvcZyNnw/W7X4fKrnF1sTF79v0tFxQEUfWZr5pGeZLEqJojkUIzM+R
         3F7slPuKyKXjM8utyYZwai4mB8f9LaUiZ6zL0NZz1XYY18LSfep1QWFmSRFQhyMaWDph
         N4brg4OD9EtQuoDzE/Z3v9qhKGLxDw7SttCHBdPgpwYKwi3ScOjYWC7tf7SDbbE1MUZ7
         QB8SdU65vx/cE9nXmbPBvuauYVHUjHV76Zmi5CaclCVlQmls77xhmpu21TXR3gtrLjOI
         rvN/qeLLXdd4HHO5Y3ShBcS6XADkyREUGSXWo2lbxGsxKxn+w6eHXMKa/4Jv53zRLBQ3
         +eCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPF86IY3El8KiG+/x4i23HyUgQ3/mPb+XtMcV2nBEmMRfnR8T48laxKANtw52lgktHeaY=@vger.kernel.org
X-Gm-Message-State: AFuF++lDRR2ADcoswB0r4jtAYoGQlCqGQhZAH8G8Y9ndH1bqunpF8JXo
	E3YxccBpj7NNcqNqUE7jF85uFlrhjSBbns8nqDmi78wKnT5PU7v/BQS847h0RCGR0OFIkTSNm61
	5jJDKhnBWHmjrHGmwr4UV09ETk/WIlUlFH1GhQu+j
X-Gm-Gg: AYBFou1ciQtf0uYdBA1pEaxMGyECxgwsFCvRhgfkEe3AI1D3dwZlEIfweehUrKaI/aK
	pB7ZvYh0D78pBxwm8hfozsjbE+9e/YEo79P8KShtI4Q3ioR+MwHbkwymhOtqPoIdg2l3P6KE3nM
	HQqKhOp/p++Zt8iQIAgWLoXQcv/KpS9acUDpJpMbI+inCVxLFf/gGJbXBFyUJFwvjH6vNIgQwfO
	SNRwAeTB7sEI+r45+dLEOTsLoyb+DTuIiakk3yaNCANei744eqw7iBR4AiSiRlGXAy52AxOilIa
	fdP+USEWok6Mho4IALyduNabdwEZdeFL6BH6QtGBDX8jKJ7Fcpcv4uM=
X-Received: by 2002:a05:6402:3105:b0:68a:e1ba:9cc0 with SMTP id
 4fb4d7f45d1cf-6a7f68270famr34473a12.8.1788712182134; Sun, 06 Sep 2026
 09:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824123954.315112-1-zhang_wei@open-hieco.net>
 <20260824123954.315112-3-zhang_wei@open-hieco.net> <CALMp9eSmrHdLpOi9-xQvcRUxyVN-8CG2MKWnxKfXFaBBDztzNg@mail.gmail.com>
 <38bac307-e0c5-4a93-98c6-140b1c52d41d@open-hieco.net>
In-Reply-To: <38bac307-e0c5-4a93-98c6-140b1c52d41d@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Sun, 6 Sep 2026 09:29:28 -0700
X-Gm-Features: AcwNN1UgWSO6Yjn-R8pVimjApTkTKNe-q72h-YE1U5LYb4CD7YKT9-WMQSoP4ck
Message-ID: <CALMp9eRYa86-jcgeWsZeiMev8T+wt6TSZk4TN9rqLtcD0uhZOg@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO for
 emulated intercepts
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 7:24=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco.net=
> wrote:
>
>
>
> On 9/5/2026 7:07 AM, Jim Mattson wrote:
> > On Mon, Aug 24, 2026 at 5:40=E2=80=AFAM Tina Zhang <zhang_wei@open-hiec=
o.net> wrote:
> >>
> >> +
> >> +       vmcb->control.exit_info_1 =3D exit_info_1;
> >> +       vmcb->control.exit_info_2 =3D 0;
> >> +}
> >
> > Can this entire function be integrated into the existing switch
> > statement in svm_check_intercept()?
>
> Yes, that makes sense.
>
> >
> > And, if !guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS), should
> > exit_info_1 be cleared for these intercepts?
>
> My reading is that exit_info_1 is undefined for these intercepts when
> DecodeAssists is not exposed, and KVM previously left it untouched. I
> would therefore prefer to preserve the existing behavior and update
> exit_info_1 only when DecodeAssists is exposed. That said, do you see
> any reason why KVM should explicitly clear exit_info_1 when
> guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS) returns false?

You're right. The APM says, "Note that the contents of the EXITINFO1
and EXITINFO2 fields are undefined for intercepts where their use is
not indicated," so pre-Bulldozer CPUs would probably have left them
alone.
