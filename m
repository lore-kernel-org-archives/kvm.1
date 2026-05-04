Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3536493C
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915180; cv=none; b=FEaraEz/f9OLKyMn9TsjUPecKP1/sa9Q6aeQb6R88ICgUaDJrm65IS+AXU/GiEda3muNHcSyOD61xp0QBDxjtaG7B8cm6bFEDtEUv+npbf624t2lud7jZmDeMw+V9tQ//KVvlcDnryuTd6mXUZQG+G5iYI2Bz/+6qPhuqSCbnog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915180; c=relaxed/simple;
	bh=q33JnXHamn3yHmbQqlQ5u0qnzQ406gGyfem/dCAS8Ic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TmZcpI1cIEJ8vEiVxdenotXCM893mCHoFgnmsVexm8wTQUwjxqzo147HaHwHP3cy5hn6rmRd4TeoWZWs+tE34jBBOl6ewuH5gAAIo2koXQJ6UTTdAkemwFObNCEaEauPJzpklU4XdibXyrC60v/xf2c1ZcHi1u93S8CY6NoQXEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lwEEs19k; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lwEEs19k"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7977177675so1775867a12.0
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777915178; x=1778519978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEhjY4LCRdjhEzxsvBRPL2vX01RIKvj6KyW9DxF7734=;
        b=lwEEs19kyqUePlcZ04xSRtLscvRfr7XxryEzCHzJ/GFw/fknHnjBdoVM78Q9MpvzHB
         CoaaTofRaNLXFfEh5c2X8GNHwNmwt3/wWwLCkbIyKrrDQ27kqHIeN9AzREEgQ3Sj7dQ2
         2cAnAyT7KEFYubaop0q6MOiBva+pO1vOwPFZttHicWQlaaTMtLSGkcqH+q2ugFUP1JES
         Z5IpbE+qrLfb5apMSh80td/PFwPsnpiLdy1Im1t3a3xTzNiDXJFqeS6WvpgiO8wfYA75
         E/0mY/4ntMpKMmsUnfxbMmVumeOFnp5ow33ivCLdxGIAJ2KDmDF4hOIT5ED50QPX+69q
         7YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777915178; x=1778519978;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GEhjY4LCRdjhEzxsvBRPL2vX01RIKvj6KyW9DxF7734=;
        b=GToPI9k7Tg1YajjEp4mKajjXAWevrdGCvgv9QHljH6Pc5z+INvHWCfl/t8yNBx0o6v
         jw37ahSusy+Ga5E3i7hksaJ81qm4baEjyUdoL3n5Ov72zxnqO3RrE2gC3/HP0lVs7Gzo
         gafKc9jicjYklluUIpYb9MExPgYBCAUhXSVHcWPZY1FfBU/OPOIS/T8FpobE93VmdvC4
         lTzQIHNFh6Wkt5Z/FhLHaaEV5xAB6PtV+B8iInz94EbgEc9Ys9vRXSh7kOnti6FKWPqa
         rOLV3htwv3f70Fkk8mQvl+qrFZ+YtGt7RBBTdSHq5mjuMRqNySewsFqIiw/8rO+pjYdG
         l23A==
X-Forwarded-Encrypted: i=1; AFNElJ9A9Kjl6hKcTIkp6upIZUNSyZ8KkdQHRsX9SY7qIKFMK/pYZuG7Otg2dAujVDo65xi9CQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywer/wWC0BeHJSS/emCe3ALvm3wRuFrUU9CiIRmvVxTsRVmQYZT
	FZEsQVZDulqHqFNJWweZyDWU0xkaL4foeIiMCnYv8yoRtVS62en1jiqDwsLZBE3y2GkeiBvsBio
	120pOpQ==
X-Received: from pffy27.prod.google.com ([2002:aa7:93db:0:b0:835:37a2:5ea7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b91:b0:834:efcb:12b4
 with SMTP id d2e1a72fcca58-8352d1fcf27mr10371914b3a.28.1777915177342; Mon, 04
 May 2026 10:19:37 -0700 (PDT)
Date: Mon, 4 May 2026 10:19:35 -0700
In-Reply-To: <CALMp9eSt-ZDCxhyVjEiov2475ToZ7M_94HSpKg6hqrh=m3iZAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com> <20260423150340.463896-5-seanjc@google.com>
 <CALMp9eSt-ZDCxhyVjEiov2475ToZ7M_94HSpKg6hqrh=m3iZAg@mail.gmail.com>
Message-ID: <afjU2ZbwRq7Jig0w@google.com>
Subject: Re: [PATCH v2 4/4] perf/x86: KVM: Have perf define a dedicated struct
 for getting guest PEBS data
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2026, Jim Mattson wrote:
> On Thu, Apr 23, 2026 at 8:03=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.=
c
> > index 7403ca721b6a..04d9c51335d7 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -14,7 +14,6 @@
> >  #include <linux/slab.h>
> >  #include <linux/export.h>
> >  #include <linux/nmi.h>
> > -#include <linux/kvm_host.h>
> >
> >  #include <asm/cpufeature.h>
> >  #include <asm/debugreg.h>
> > @@ -4992,11 +4991,11 @@ static int intel_pmu_hw_config(struct perf_even=
t *event)
> >   * when it uses {RD,WR}MSR, which should be handled by the KVM context=
,
> >   * specifically in the intel_pmu_{get,set}_msr().
> >   */
> > -static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, voi=
d *data)
> > +static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
> > +                                                         struct x86_gu=
est_pebs *guest_pebs)
> >  {
> >         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> >         struct perf_guest_switch_msr *arr =3D cpuc->guest_switch_msrs;
> > -       struct kvm_pmu *kvm_pmu =3D (struct kvm_pmu *)data;
> >         u64 intel_ctrl =3D hybrid(cpuc->pmu, intel_ctrl);
> >         u64 pebs_mask =3D cpuc->pebs_enabled & x86_pmu.pebs_capable;
> >         u64 guest_pebs_mask =3D pebs_mask & ~cpuc->intel_ctrl_host_mask=
;
> > @@ -5052,7 +5051,7 @@ static struct perf_guest_switch_msr *intel_guest_=
get_msrs(int *nr, void *data)
> >          * wrong counter(s).  Similarly, disallow PEBS in the guest if =
the host
> >          * is using PEBS, to avoid bleeding host state into PEBS record=
s.
> >          */
> > -       guest_pebs_mask &=3D kvm_pmu->pebs_enable & ~kvm_pmu->host_cros=
s_mapped_mask;
> > +       guest_pebs_mask &=3D guest_pebs->enable & ~guest_pebs->cross_ma=
pped_mask;
>=20
> It would be helpful to save this mask somewhere, so that it can be
> used when calculating guest_pebs_idxs in x86_pmu_handle_guest_pebs().
> I think that code needs a fix similar to the one in commit
> 58f6217e5d01 ("perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest
> with vCPU's value.").

Blech.  This all feels like a losing game of whack-a-mole.  Proxying the PM=
U
through perf is a mediocre approximation for non-PEBS events, and it seems =
like
it's downright awful for PEBS.  Ideally, we'd just rip out all of the perf-=
based
PEBS virtualization support, and only support PEBS through the mediated PMU=
.  :-/

Absent drastic measures though, saving the effective guest_pebs_enable in t=
he
per-CPU tracking does seem like the least awful approach.  Though I don't q=
uite
understand why we can't use GLOBAL_STATUS for x86_pmu_handle_guest_pebs(). =
 I.e.
what happens if x86_pmu_handle_guest_pebs() only processes counters that ac=
tually
got marked as overflowing?

Regardless, I'm not going to try and address that mess in this series.  AFA=
ICT,
it's not urgent, and I don't want to snowball into a broader cleanup.
