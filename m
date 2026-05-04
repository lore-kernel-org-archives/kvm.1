Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D63D333D
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923789; cv=pass; b=Vg/QhhgxZozjF9MUMWvX8eL/UEx2Hy/2bzTnL24Vd6mASKqeKEFGwCmxff9i2mwt6I9bhVsz/08LfgWC2kP9VzK9a83m+Y+j8N4ku8MgJgIMd012e4BqVk08XG5b0aawTG7G5vnksaOwEqwFvPexvdkImC946IyT3M1loGIkwyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923789; c=relaxed/simple;
	bh=r9Tc8+D8AinjziQ4OFrUbBHEoIMfVWrL6WKwzmW7VEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBBuFargtkBX1vKlTe0USIphSDuDNyhdQJHqxYZOcpTKNrU5FezCgB1yTu/siFRNkAKitQzAwSaGEIRuW1g/DEpdZrtEaMKy8GfllMcJeVitF/XBON+fHQ/U/Xa4Z91G1MtDsrJ31aSV4i9cfX3ek/rxj76hMp3WI7noW2DnydI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OHqp/RY7; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHqp/RY7"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso499a12.0
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 12:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777923787; cv=none;
        d=google.com; s=arc-20240605;
        b=SCQ3tQSDp2t+n2UMZXOR0alAVgj2SeJ10LihcClIvt9yzM3auPp3//miaAY1jxED9E
         GW/p/+qAjHIZvhwWBTHQ8S+9uBakqD1NX8j+vlYdDvfwqnvPBZWNFGihAySf7RIYRKoR
         6Cb7qanPZ2gDsgZlxtnhdzpkf9IxDAlS70ZVWSWtWQT4gbzx3gz8u829aVV95Iv3eCWI
         FcWcuWz03Oi6nLlavoKEi5BWVAz2KoWFUWEQ2m234eLvXzw37R9FSLv3KRD+fOWPGWNO
         25+CCVCcp6c1Fqb2uFCWmNhH5dXZbsDKCNKmrY38xvcgdsSZOEuy4IEbEcsAjtNzI4Qx
         28lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fVo9WZIwpblsiv1wQ6q4YKWmAXmautadgAuM0akTBn4=;
        fh=DSAQOlcjn8L1vEB+PdL2xT+Gkfk71mFJvte7K4iZdhQ=;
        b=Ul1Jx0AAR8KUbU3PLxG2Up6sPxZGycpM0vp3pDJUW0466OkQXNxjnb9F42CA5eUsh2
         l5Io/6fdvM5XhAeREqzDLzkfz8GhD19UxBRl58pK6wlUDCSqqXzOdvgrj4vS2gfzQ14b
         JlBUFgdFEDxUq5yf+vqlMekS8/KMUkSXLlfDdX/5MmANtcAP10OQrXiVxfRXyJstiCZz
         gxTUo2BVAganZ03ZbVs2aBudRT676TRaJFq4v5QAxjR/TXCQrd9i1t8U5/HDj8h/hEfO
         GJmD2XjWKtGl8IvP87sbedGdNztsn222NhucYONDQNRvHSBdfGj44YzUFT90YayRaC7K
         vNew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777923787; x=1778528587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVo9WZIwpblsiv1wQ6q4YKWmAXmautadgAuM0akTBn4=;
        b=OHqp/RY71OCg5IjdCIKMcKX+JUyKjez6ebJq8jlAI+fYWeXcMm3aNOtYKEY+t+b585
         J2T5WZXU6IE6l8DX3y/1K1MEi7V6btzdXMsVjMbRobU4jY7RgDd/ODYftx2V0mqogJzc
         Bze5FMnflCTgYH6ZxPGRqNFq3pIqHZoScPUHX0XWVn3DrDngSYZvtlZY+qypJc8PBuAQ
         n91A65NvKQB2yBQZxjMHrZmTkHSCO/bM0SIEc4dVTwMjl5vf5ofb/JA1p+gcDZcT0pbT
         KSMH8rXRpNEOJ0aNXpK68dzC4aCIfkBcbwfylI1jqQBxYWcp+D6vCoBrSwMhmZbp0+jv
         2E0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777923787; x=1778528587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fVo9WZIwpblsiv1wQ6q4YKWmAXmautadgAuM0akTBn4=;
        b=QNRAZcZKopewZr2nM2dRn+EodM3BpgCuOZjj+7AQPDInumIoxNih877DeJtvakCnn1
         S7HzgWgZmV3cXbwZqejycZijTL83Ml4szobQ5aYMOIrVlQFnca3dQOqfNBjOzdF9Rbqz
         zFAQ9ekX7vNOPNgabyDomJB3Ej4y/qNKD4mM6a8Ufw5gLSfZc/Sb8mGxChCL1u5ysJy8
         n5i9GS50o8oDjaFxwmZpye1n3ByEhee2fvMXpnnGCeTzmxwNNbeHf4vDn0LgI3pytqcH
         NhhHp8y5332Q1pGsy569tC5MvALU1B1vwTxCT3ncH0YfeAImPA1XNsUIDkoaEOUSgvNO
         kenw==
X-Forwarded-Encrypted: i=1; AFNElJ/NdkrYmJZxVcCr5TCMWaCNenj47TDgzsCRrI8m8Jz47vLvUlh05woPp10OqKYcu/wLxNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFOcdgRNtFHWgN3nnGr9eEvhM1sRiLhelVVHzpwl/k1E7NGnJq
	Nv6qDEq89nuW2V2a3KAIVwNX8neAKxFFu7ka5TB+Qhu8c2n0xCzlzGGzR1UH+CaHOiD/0pHPi7+
	0btexYbDWqI/kIqDA5WaR/m+FL2PszmOqHydUEpf2
X-Gm-Gg: AeBDievzKwkyD6rSdMAkZaoaU2U4YaGNYdKmw4QJGI59vVipmsddqL0FOH6uSsL09qD
	QAcZJjymIE1xuzV2P/9hpL0uqEdra5jYIOR+uq0MCu7QLNfddsJDBumsCRMYOaMjPS+qNJMOr7P
	s7EOFfdb4F/VJkdj8mKHAduq9hNixvII2f246xpugLpPEl0delkagEIobbdV+ZrTeZisMWC/6r1
	oBVma3yA7n5QiLQQMR07H+CH3eH4j1sc5N9zHFco4wUx0+mO9YOTmZ25/bQpLMChC7E5hq3JXkN
	hFoNlgCHf+HsB3+nVmrmVKgKeN6w
X-Received: by 2002:aa7:c7c4:0:b0:660:efc9:900a with SMTP id
 4fb4d7f45d1cf-67cc44de9a7mr10687a12.10.1777923786071; Mon, 04 May 2026
 12:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com> <20260423150340.463896-5-seanjc@google.com>
 <CALMp9eSt-ZDCxhyVjEiov2475ToZ7M_94HSpKg6hqrh=m3iZAg@mail.gmail.com> <afjU2ZbwRq7Jig0w@google.com>
In-Reply-To: <afjU2ZbwRq7Jig0w@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 4 May 2026 12:42:54 -0700
X-Gm-Features: AVHnY4KBRrG6P6Ug3x2co3Is7udBMHdxYXoEqBKCo9xlDUqBrgoanrcIb0zRhzA
Message-ID: <CALMp9eRBcyLZJrcK+RqpSn3efPP62kuD00pDzQv7kRDBjkbqJQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf/x86: KVM: Have perf define a dedicated struct
 for getting guest PEBS data
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 10:19=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, May 01, 2026, Jim Mattson wrote:
> > On Thu, Apr 23, 2026 at 8:03=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/cor=
e.c
> > > index 7403ca721b6a..04d9c51335d7 100644
> > > --- a/arch/x86/events/intel/core.c
> > > +++ b/arch/x86/events/intel/core.c
> > > @@ -14,7 +14,6 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/export.h>
> > >  #include <linux/nmi.h>
> > > -#include <linux/kvm_host.h>
> > >
> > >  #include <asm/cpufeature.h>
> > >  #include <asm/debugreg.h>
> > > @@ -4992,11 +4991,11 @@ static int intel_pmu_hw_config(struct perf_ev=
ent *event)
> > >   * when it uses {RD,WR}MSR, which should be handled by the KVM conte=
xt,
> > >   * specifically in the intel_pmu_{get,set}_msr().
> > >   */
> > > -static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, v=
oid *data)
> > > +static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
> > > +                                                         struct x86_=
guest_pebs *guest_pebs)
> > >  {
> > >         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> > >         struct perf_guest_switch_msr *arr =3D cpuc->guest_switch_msrs=
;
> > > -       struct kvm_pmu *kvm_pmu =3D (struct kvm_pmu *)data;
> > >         u64 intel_ctrl =3D hybrid(cpuc->pmu, intel_ctrl);
> > >         u64 pebs_mask =3D cpuc->pebs_enabled & x86_pmu.pebs_capable;
> > >         u64 guest_pebs_mask =3D pebs_mask & ~cpuc->intel_ctrl_host_ma=
sk;
> > > @@ -5052,7 +5051,7 @@ static struct perf_guest_switch_msr *intel_gues=
t_get_msrs(int *nr, void *data)
> > >          * wrong counter(s).  Similarly, disallow PEBS in the guest i=
f the host
> > >          * is using PEBS, to avoid bleeding host state into PEBS reco=
rds.
> > >          */
> > > -       guest_pebs_mask &=3D kvm_pmu->pebs_enable & ~kvm_pmu->host_cr=
oss_mapped_mask;
> > > +       guest_pebs_mask &=3D guest_pebs->enable & ~guest_pebs->cross_=
mapped_mask;
> >
> > It would be helpful to save this mask somewhere, so that it can be
> > used when calculating guest_pebs_idxs in x86_pmu_handle_guest_pebs().
> > I think that code needs a fix similar to the one in commit
> > 58f6217e5d01 ("perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest
> > with vCPU's value.").
>
> Blech.  This all feels like a losing game of whack-a-mole.  Proxying the =
PMU
> through perf is a mediocre approximation for non-PEBS events, and it seem=
s like
> it's downright awful for PEBS.  Ideally, we'd just rip out all of the per=
f-based
> PEBS virtualization support, and only support PEBS through the mediated P=
MU.  :-/
>
> Absent drastic measures though, saving the effective guest_pebs_enable in=
 the
> per-CPU tracking does seem like the least awful approach.  Though I don't=
 quite
> understand why we can't use GLOBAL_STATUS for x86_pmu_handle_guest_pebs()=
.  I.e.
> what happens if x86_pmu_handle_guest_pebs() only processes counters that =
actually
> got marked as overflowing?

x86_pmu_handle_guest_pebs() is called in the path where we are
handling GLOBAL_STATUS bit 62 (GLOBAL_STATUS_BUFFER_OVF_BIT).
Individual PEBS PMCs are not configured to raise PMI on overflow.

Moreover, I believe kvm_arch_pmi_in_guest() returns a false positive
if perf is using NMI for PMI, and a PMI occurs while between
kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ) and
kvm_after_interrupt(vcpu).

> Regardless, I'm not going to try and address that mess in this series.  A=
FAICT,
> it's not urgent, and I don't want to snowball into a broader cleanup.

I'll let you know if our instrumentation changes that sense of urgency. :)
