Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAB728A3FA
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780761643; cv=pass; b=tgiCs0WoO3vJ0JjF4HKu5nrD4eEjdIz10SfvgskVqrMc1ldKELyLGLBcBOpLmBTs6unreYr1YeSLPXveExUib87EQz9gjcsjNdjTRdB6TJCTAYgPPGJpU7+3B+FZfb8kEw5qmIiLlbBpbFEm1YSsnbloe2vGVndhPkQnMwiCC/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780761643; c=relaxed/simple;
	bh=i4rew88Flxyki9IDpI/92K3Ph4V2Q1lSJDrrGN9sl4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+vIKRnWxxiMVlnkd9YO1q9RevNXa9VkRcqOxZ7ZkE9yo9gQAxBHkvKxhfyxvabfNhRGPsFPCNK5nWEAxWfMuxP8NhLBZm+LhICz14LoNK7W7oLQXuFqLiWz1kyse+n7jDf0QFwHJYF35xMFJJkCgPI0gmfyrZJYyrIKfflWnlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qtmzFbMc; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtmzFbMc"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68cb445dd5cso16758a12.1
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 09:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780761639; cv=none;
        d=google.com; s=arc-20240605;
        b=ErBZUJ+hfColCoLtrNx/zMLQeiaQGkpaYHQkuNEY8pldAXbMHTt1FwlopeopreFv8k
         /b5Rf9LRGQekwKIF5WsRBJWXhj0rNNGqktWQOXjaJ3psBkVgBo0VwbTb39JxNTh0VWP/
         U5L6Dsu5m1uHruwBdWJawcoMBiR2DW0bwJn8uMYGY4YF+5yRwKmVall5l3nzlFMijp03
         rf8AayybQsrlRRp7XdCprIXxSc0QuUvJwxwPLfIZKobkA1xbDN6E1W7vTB04md+3pUg3
         GV3gCrt9dzPnJJA1PXrXdHKLvUm5aIm/eRLC1Hu9YwAbt1KXo9edX6hoCxj5rtjCCjVZ
         3DhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=57MeYUfE5UfGozU/Hio7UqMWK4IkSftfIzxvJeTlNdE=;
        fh=yXNVcp1R08vJXOo8GRcZ/gPYeY/jPyNk+44c8mLVaPw=;
        b=I7CToC9XbbHrpkYyeq3KttPUa51lYRBayAkfNgfyuQLktgYDb/zOIt9D9N8dHUWlMg
         iOUvxB+Bm+FPr4hdNejm+fSzsPJCGjFYzq6/7RK7DRsZw08anXLRswyknOYXYZ0MIIRL
         RV47/qN2E+CdIfeygq5JrnVO8z+xNniv3+eX5YeVsCRPpDn9y4tj9qgi+Ka+6aoyVDLw
         uJPQjvS4tUboqvfigBCwaDRcxzf85lkNUBLg2QZT0+kt1069XuTr6SKSXxYYOkMkwYeN
         MMkTCYHwbk4Sb5byVsqkgtCB148zv71HqDk1+5F7mqpTLkpDxmdvW/2qcGVAkiBJ7TV8
         mOcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780761639; x=1781366439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57MeYUfE5UfGozU/Hio7UqMWK4IkSftfIzxvJeTlNdE=;
        b=qtmzFbMcf5OQlqYiqmSnF1htmq5vzpPoEgjr24mt4U+OLIDxUfcZEhVpd3EAD42bVF
         r6IG9gxEvBLklC7TGpZR6aU4NBZhQ1soZ9qFh5AGplnNjLDFrblsq54Z/J3pxU/VlyEl
         Ut82gkV5bcvViQfrSHzVbpmFfoTl5gOlhlg40U4UNek0eeI7IoUza85oFrkKwFn3OHCt
         ZDvTgaix2zc2V6VhysyegIENaYrFH3jHClszFsE9afOxtudQYxfEM7s4GRshiMhXZG4u
         sqMgKjBPCKKlHGD8zFujh/jldoR7eciG+uO7FL7if9LTHoaSSsGC6Q0ovkDZVNLDPs+I
         VH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780761639; x=1781366439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=57MeYUfE5UfGozU/Hio7UqMWK4IkSftfIzxvJeTlNdE=;
        b=nNOrVDJ0bh/EoATl3dcRdLffmdgCFq534pFjfZ4asP/KcVyitRNmnf9J8Wm4EXxkmM
         2XxP/mXmjnFIE6HaZw4B6CNEfduNwLmYrhIagJY2d+ElWF6OhC7OFPHGq5Ke42Y9937h
         z3Lyu3UT7tfA7gMV3sMTdv8ZvDEgK31ottQzVHZRTvpkKJoY99T2yv3MNBr9x6Xpj7IS
         YA4EmC08p8KYfmBCRZLO+JEdDBVhAKcbpoUkQ1JY/+VIbu/nTrR/XC2nJyvo3D1MyERi
         SGMF7bice1Z7GA2Z55IHSk0R1noYT132Zb5Zmf78L0JcS9VExIKDrVfO08SlqYZKZDsM
         cBHg==
X-Forwarded-Encrypted: i=1; AFNElJ9r7gQNg6beCko3AMWNiRiSY6nWG0mOKPTu64iFvbDWI4hhsBaq0B1ZNk6MigAqINVn41o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOnrb9H+zm3BQ/9oj1MZjpnVFsTB7woeMvM6lojuXX3YZ7IoS
	b41MOygkCcP8Tfd/pUnzlY7Dewr3JXLv/YB9WzqNgXW+pN6gOlyZGJmd4AjzJffzgSaiXajk6bO
	Q5sgSyOvfmL4/S4rvXtieaBm+QArE6HOn5S0LKaxr
X-Gm-Gg: Acq92OG2qhocq8SrYvn+M83SXx3o+AarhzzCilekK0SkFikKPGxJiquJ05obJet+iZD
	xJXgKujQCVhOrGzOw2JBQ5XupQFBAwhEVBKuZJn5YG+aaQPtfwQkjvRb01L1+KjBdjw/7pw1XKA
	Ht784mPD9uZJfgC36tfdlIDyM1vE0DxW4WDtDk9osUQmjg1IoDrQczIdXlHmpg50avvDli9ETGC
	MAQx3N8j2tO75PRHUn0Kn4D4UVPCUnOqIL+W3rp5z/EhED2JBGzZCakMxGOJB8CjBS5jHbD5MTB
	MCujdPIrVPbYff1yOg==
X-Received: by 2002:a05:6402:a382:b0:67b:7d05:60b8 with SMTP id
 4fb4d7f45d1cf-68fe9275289mr115181a12.10.1780761638922; Sat, 06 Jun 2026
 09:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527174347.2356165-1-jmattson@google.com> <178009472318.880870.7878635650921105255.b4-ty@google.com>
 <CALMp9eQ-8h2F4HO8S666mJF3QzyH=0b30kC=n_9p7SMbBhxCMA@mail.gmail.com>
In-Reply-To: <CALMp9eQ-8h2F4HO8S666mJF3QzyH=0b30kC=n_9p7SMbBhxCMA@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Sat, 6 Jun 2026 09:00:25 -0700
X-Gm-Features: AVVi8CesUChtR-NwwSdAcU77cBFMJbKq7QwRjpAY4cHdu5oVJkkbFJqIsISYYVc
Message-ID: <CALMp9eRHC-N7x2ZK3_dk0xg5WaokQFeGuL5qoAQGqpG60bJY4g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] KVM: x86: Virtualize AMD's "disable CPUID in usermode"
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com, David.Kaplan@amd.com, 
	binbin.wu@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 8:12=E2=80=AFAM Jim Mattson <jmattson@google.com> wr=
ote:
>
> On Fri, May 29, 2026 at 3:47=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Wed, 27 May 2026 10:43:42 -0700, Jim Mattson wrote:
> > > AMD's "disable CPUID in usermode" feature is analogous to Intel's "CP=
UID
> > > faulting" feature, but it is advertised and activated differently.  T=
he AMD
> > > feature is advertised via CPUID.80000021H:EAX.CpuidUserDis[bit 17] an=
d
> > > activated by setting HWCR.CpuidUserDis[bit 35].
> > >
> > > Add virtualization support for the AMD feature.
> > >
> > > [...]
> >
> > Applied to kvm-x86 misc, thanks!
>
> Oops! You haven't sent a pull request for this series yet, have you?
>
> Our internal Sashiko asks:
>
> > In kvm_set_msr_common(), the MSR_PLATFORM_INFO handler uses cpuid_fault=
_enabled() to prevent the host from clearing MSR_PLATFORM_INFO_CPUID_FAULT =
while CPUID faulting is enabled:
> >
> >    case MSR_PLATFORM_INFO:
> >         if (!msr_info->host_initiated ||
> >             (!(data & MSR_PLATFORM_INFO_CPUID_FAULT) &&
> >              cpuid_fault_enabled(vcpu)))
> >             return 1;
> >
> > If a VMM restores MSR_K7_HWCR before MSR_PLATFORM_INFO during live migr=
ation, and the guest had enabled AMD CPUID faulting, won't the write to MSR=
_PLATFORM_INFO fail if it doesn't have MSR_PLATFORM_INFO_CPUID_FAULT set?
>
> Sadly, I think it's right. Even on AMD systems, MSR_PLATFORM_INFO is
> enumerated by KVM_GET_MSR_INDEX_LIST. It does come before MSR_K7_HWCR
> in that list, but userspace is free to restore the virtual MSRs in any
> order. For any sane AMD-hosted vCPU, MSR_PLATFORM_INFO will be zero.

Never mind. This Sashiko observation was on a backport to a branch
that doesn't have commit 1ded7a57b805 ("KVM: x86: Remove ordering
check b/w MSR_PLATFORM_INFO and MISC_FEATURES_ENABLES"). Everything is
fine at tip.
