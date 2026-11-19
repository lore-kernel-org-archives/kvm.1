Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795125395;
	b=TBsU0z3GaT6vjzDnN2TFAQFl4i0HGuvbdFDuflt7Yq9Rh2oC6jCt+TrA+2GlKXaFwqr7
	 kVhZh6W0kuABvZEcq+IgpKJSbu9bDpiwJUY08vZTJCUbQBWr8sROZS3+wFWWlkfjA+enf
	 ozUq9NnIjyI9iH0qaNJxXPuisuG6nwkPEN3i7KUNhvAKgaJhSMNI1FTOftpiFLWSQYFqx
	 k1LFGSDbttJ49a1CsaRJJzFLp33pXQy5Rm8EWIX//er/RWmEVEjbgP9+6I4ZiHgk7chyw
	 GfhRW+E5lbv4yls/9Zd9QOGSb/tMQp6nkOgKLC3igOWGqiDj9Ct3U9zWSWPPM3geIyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yxs6JL3pF22H/C2YwUuAOHRTehpjECwvENtuPXYZfL0=;
	b=DEzndi0emECInLUhux7DuHLbDC9nR5q/8veM0Bp0rjR1SL09y7H4UqiUrBZ8Zo6w6PK0
	 t2fBDL9unuhNSXRL+bRFltM+UQyHwWHu20blkEfz9yQLIlaXDp9RCHGIYN+JHRtAx0DO/
	 B1yhhiQvcjzdouinjuvh2/2aTPK1x5JxuSztljVuuYMc6Xho8fEjpgPQRGR53CUpQuqWk
	 hFUne3kkQHm6/skCAhKrTeeTqVbZt7RqO19CFo0BqjjS8aI8EqX+JAZHCwQytw/zcHbgH
	 awdtliutVslkVo1YEIkVK3DlvMV6T1HmBcrQ+wN1BLUycV4qliHycC8fls0ps/izdVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="J5E6V6/C";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D956606A325
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 21:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D956606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J5E6V6/C
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6ba2a448540so3609a12.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 13:56:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795125394; cv=none;
        d=google.com; s=arc-20260327;
        b=exBGVlAxex63a76yaoj9MeMmxEAiTXh63mxcFm4L8jP/iuuUi60iTDFoSLnVXTS0+3
         CgBrMEV1IHgCHohWi6wcIhAV4lN8TSukqS0XqMlAmomg8jRXBeR7DM+neM25Xy5rfwa/
         quarzOXngoCiHeZeWcgZwbcGgVFzcKDdHALa7oDt4wJcyh8+JKnKe2g1paepMBbPn7cg
         DqFLkNEWRW2lqCpwprh0Y5LHlEuoFgMVT5aVXZGENX/TYShPc3XENV4k2mXAWPjPhT7w
         sgxzZx8ED4tHntG9B/K3gmoqSPTdDUN2mi98SZ1nn+F5xwZEv7b/7ufiLfcfymxsqf6s
         tX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yxs6JL3pF22H/C2YwUuAOHRTehpjECwvENtuPXYZfL0=;
        fh=8ZbnlXLYAmsq0S55EldQRJULeqOrcDN10izTlHRsXd8=;
        b=hpRDGh/RsGbJyjyZh/y5YUfdwHOAW75o7DBm9q208FSbid0lJMfexVhjWd3jZ50GZn
         hicf9x44qSLPQa27eAZjsZn8hpZGvE9TV55SIcOoO6TQxeteNvCW11bvKTyHCzTgS5N8
         bWFmMnpWzO7RFfMGzdEx1cK3js1wETpfXjz5wbeqIWZ4PPeVrsrdHqh9xQu1XdMgavEZ
         vQDwzYiPmF75ufwAeIjIYh6OTnENI8qdQFkRLtvyTN0Azm4yAAI4/A7GsqDbOOc+AZap
         1Ux3eEQZ/lkZfEN7UMSp0jKmnUrQxT3Aes8o/+7S1CfkUkgLjcUS5Jxt2kTuQ0Z5AIh6
         gnMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795125394; x=1795730194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yxs6JL3pF22H/C2YwUuAOHRTehpjECwvENtuPXYZfL0=;
        b=J5E6V6/CBNULRxAlvZDKa/IgvWpYGizuhVZ7+6TfyPqssvWnBXzE4Z98BHp3rxpTom
         ScNEXtZ6FOt1bH6qWWl2VK5MEUhZ4DcOSvhJsjOA/3DIcV4iUlnLh3biOIhBi5lN3tVf
         2+GjfVtNlBfQTtD7Ut7/JH1uwXYBbIwNs7ExLY4lu4d/9TcYXmtnXjg6y8VojHTI2b4R
         kIFvdT+3lWxKA2DiCoeuNDjds+sk/DdW6UO1VevHKNOtrxa+9EM5yjEPRJa7iIphvomN
         xRu9NmLJxdH8OxlLROldO4CGpQ+YHkt7VgUYoDes05MJzoRMYuGlkyu+PveQdnt/PoG2
         LqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795125394; x=1795730194;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxs6JL3pF22H/C2YwUuAOHRTehpjECwvENtuPXYZfL0=;
        b=t5FfJnqhA45rNf/J97DmPlMrCSd+FvVRXrpEnm7FkwtsOyvgII05Z9gd2u9GKiHuKN
         r+m0frKV9bbkzrep2xu3q+RZSy8MvJbqfz7685NEbEoEoDjmiSO+HOXXLKpK+pdzu2X5
         muV3/VccKMvJHweHKo8szZ3ChqhBDdP5Rdn2WQL7HitKlgz3aZjGcIGW9UHS6l9IA8ow
         Pza7LokbhsWDmiAf+leKxQwN/f7fFv1olU29KbUCKfazhXbcCAjml1cwEQjsKD22wStZ
         yHRJubFAcrh8uc9q9XB8p64lC3lojuQWJVWOBTAAGRCOsFLvxLXvn07sWBWnd2Lsokab
         +Q9w==
X-Forwarded-Encrypted: i=1; AL+hErG1px1xvU8ya1HR6w2WyQ3YEmA/mda/VgOD0ICcsyvgSOEaefBRMhl5OISGg3c4XFz2ClI=@vger.kernel.org
X-Gm-Message-State: APuU4Z88GwwG0LAw8WwoFBsIim9HfBVwbruaU8wyf3mKjlEqVa5E/gR2
	K3W4RqAFcj/7biuR1jj5ipSt1hqzk+g6XdRH6c5POaXmjMXOP7fDPKMxZHt0gUGST3j7T+ecBhV
	VNTwgvcWe2F9BED/G7GiJRXBrAnd6/v5BrbPaTwDe
X-Gm-Gg: AYBFou0od6rzBi6DTvRuyLWwzyDvYWHs9LJyQWlWleqe+53wWNNdNG3MozmBSVtFAwo
	FRcFqS3AzOCTh7gGDDzbGU0zuiUPd2yhU/IuApS6YY2kEyvUw/nsvb/nvNGYmo8GuTpRrjNkWyF
	f1rABe3oBwzOVPLJFYTvcBfPaMHkMI5mA5/YG1AUG2C49LXhSlFyFyLiZyAmmwOyOzcWMSpJyXJ
	6lzw2scz2AlGXnre+BIcb9C/YpeAnvbcKNaoyzw3qL3PRR+SdJRlvKJu0bXq+HzzJlchjMv6eHz
	7dIiwj25erJmTJnJKSR1H5nioHRzqUzyulDj2/9C/alfGwFMqZ3JKuRsrh2APrWhQty1Ka67H5p
	eJpGg7RaY4N80o9qBazUxA/ywaEj7L9dyOK3rvxEwaPbyoDhRgc1zOpNJc3nXY3R1f/gqaO9KgB
	ZuRA8BWVPwKDIWLIPf4qf6hKT6UsCvyYjr1uiqIiM1PttzljFmDXnltg==
X-Received: by 2002:aa7:d155:0:b0:6b7:7598:67f9 with SMTP id
 4fb4d7f45d1cf-6ba3d4d761fmr8020a12.8.1795125393329; Thu, 19 Nov 2026 13:56:33
 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-5-shivansh.dhiman@amd.com> <CALMp9eS+vfR=Gk5QhLFrCZ4MyCq1YrunViB=tB5OLo+L8Ka+OA@mail.gmail.com>
 <e09b97b3-7439-4b33-8c2b-033ba131a0a8@amd.com>
In-Reply-To: <e09b97b3-7439-4b33-8c2b-033ba131a0a8@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 19 Nov 2026 13:56:20 -0800
X-Gm-Features: AclHuK8l0rEFGZgNwI2wXL6n3pHzDpAujXNRh4CfQ1shCRuwx4eK_gkcw-lm9Hs
Message-ID: <CALMp9eQSicA=nOaxOrU37Z1ROPYFhwKgBMX-Pav=qqvb+WUDew@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] KVM: SVM: Enable hardware-assisted LBRv2 virtualization
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 12:33=E2=80=AFPM Shivansh Dhiman
<shivansh.dhiman@amd.com> wrote:
>
>
>
> On 22-10-26 05:04, Jim Mattson wrote:
> > On Mon, Oct 19, 2026 at 2:07=E2=80=AFPM Shivansh Dhiman <shivansh.dhima=
n@amd.com> wrote:
> >>
> >> Enable V_LBR so hardware saves and restores the guest's LBRv2 state in
> >> the VMCB, and pass the LBRv2 MSRs through (by disabling interception)
> >> to the guest while it is set. V_LBR is enabled lazily, only once the
> >> guest turns on branch recording, just like legacy LBR keys off DEBUGCT=
L.
> >
> > For a Linux guest, I think lazy V_LBR toggling is a bad idea for guest
> > context-switch when LBR is in use:
> >
> > Context-switch calls perf_pmu_disable() -> amd_pmu_lbr_reset() ->
> > perf_pmu_enable().
> >
> > The PMU disable clears LBRV2EN, so V_LBR is cleared. As a result, KVM
> > intercepts all of the LBR MSRs written in amd_pmu_lbr_reset(): 32
> > stack writes plus LBR_SELECT.
>
> Thanks for this. You are right, and I've been spending time experimenting
> with it.
>
> I profiled the guest context switch and counted the intercepted MSRs on
> the host. With lazy V_LBR, each switch into an LBR user causes a VM-Exit
> for all 32 stack writes and for LBR_SELECT. The reset then becomes the
> largest part of the guest context switch.
>
> When I kept V_LBR on, these VM-Exits disappeared, and the reset took
> about the same time as on bare metal. The same workloads ran several
> times faster. For a guest that has LbrExtV2 but does not use it, V_LBR
> on adds a fixed cost to each VM-Exit, because the CPU saves and loads
> the LBR stack.
>
> I can see two ways forward:
>
>   A) Turn V_LBR on at KVM_SET_CPUID whenever LbrExtV2 is exposed, and
>      keep it on. This is the simplest. But a guest that never uses
>      LBRv2 pays the cost on each VM-Exit.
>
>   B) Turn V_LBR on when the guest first sets LBRV2EN, and keep it on
>      until vCPU RESET. A guest that never uses LBRv2 pays nothing, and
>      a guest that uses LBRv2 has no VM-Exits in the reset.
>
> Personally, I think that B is better because I do not wish to increase
> the current overhead of a VM-Exit. Which one do you think is better?
> Or do you see a better option?

I agree that B is better, since VMMs will routinely expose LbrExtV2 to
guests that never use it.

Note that KVM doesn't have a post-creation vCPU RESET path;
kvm_vcpu_reset(vcpu, false) only runs during vCPU creation.

> I also have two questions about this:
>
> 1. Legacy LBR. V_LBR also covers DEBUGCTL and the legacy LBR MSRs, and
>    KVM toggles V_LBR lazily on DEBUGCTL.LBR. Must legacy LBR keep the
>    lazy rule, or must it use the same rule as LBRv2?

Legacy LBR can keep the lazy rule. The four legacy LBR MSRs are
read-only, so there is no 32-MSR reset loop on context switch, and
keeping legacy LBR lazy avoids paying the 256-byte LBRv2 save/restore
cost forever if a guest only briefly enables DEBUGCTL.LBR or
DEBUGCTL.BUS_LOCK_DETECT.

> 2. DBG_EXTN_CFG. For non-SEV-ES guests, KVM intercepts it only to see
>    LBRV2EN. With option A or B, KVM does not need to see it after
>    V_LBR is on. With the reset fixed, the DBG_EXTN_CFG and DEBUGCTL
>    VM-Exits are most of the remaining cost of the guest PMU disable and
>    enable. Is it acceptable to pass DBG_EXTN_CFG through while V_LBR is
>    on, as KVM already does for SEV-ES guests?

No. If future hardware defines new bits in DebugExtnCtl that KVM doesn't
virtualize or advertise to the guest, passing the MSR through would let the
guest enable an unvirtualized hardware feature and would break live
migration when svm_set_msr() rejects those bits via
DBG_EXTN_CFG_RESERVED_BITS.  That's the same reason KVM keeps
MSR_IA32_DEBUGCTLMSR intercepted for non-SEV-ES guests.
