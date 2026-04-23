Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135A397E86
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967202; cv=pass; b=KW8eIvhCzdHHJoGdVu/73gKIxJWw0mhU6z5k0zjRKpHK9RN1RyoBf6GGy/SB0v34QEcoyGICtKFr5CvEQaqIWtShAMO/gNDgAerjq1Wmiu4Sv8p6Y0SLwEG3Rr0dNH1sbkQGsPfssjOaCfRod5XxuPLD0n2psEfkjJ5xowk93yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967202; c=relaxed/simple;
	bh=NjTID2EKzmwSsWceMSnq7CvcphPb7pNGa1lohgjflCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl07Mxq0ZdroOmVzMRAYPWxob0BuNCbPUttm2FsHOJ16ox+5cMSpXIctXZo+iRCEk+VR9/wXLwwoaWN0nMphPO5nk/rNrpyzY+F9T7OZfx1XfRqLNOULkm0k3qbiQGATqySzfJkjqwwBEvDDR2yps1mUe2KQFkYWPR4dUWFdsDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G8gRWNgE; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8gRWNgE"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso56677a12.1
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 11:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776967199; cv=none;
        d=google.com; s=arc-20240605;
        b=BPL4rL66plr9Bt5Z9g+TP5Ei7obh+QrfR9HS5yHAAczN4Mu0fcXNQ7Z3l0SmzvOA4g
         DS3nFkJv6Xo6ua4jLeCYZ4hcUYzZkV0vVWGuPeFrcCGYyOg/ECwYadPkVmdBWngn/3xz
         f0KngmMYxs9+KRuJaNgtrKlY/5nPWP3M83fqsPEzGp3LI7x5C8wNCgu48wf+HndUueJB
         agaWAlMNgIiQIfzM5c0qxCGk78Iu/1ifhSghT3sX7pAg0NQplPPYTyFl96KmI7/QrDNL
         ysraVzdgG5FSsdkNCDEEHfQ0+36RSnizHUqxk58a4A9WpbTRaDqTmc5o/vdfPY0MzmKX
         PBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PRXGXkrBT3IzTrNjLChryWldz16gsbb2ZziyyNHFu2s=;
        fh=YyGt6iw0ejGqz4sfikB2tWKOwYplDN7L1qY24Xn+zaU=;
        b=jXxd7W1ZsBpGZ+bOnu7p3OyXCGRBj5pnZpDTF56hm9RNSoGxGJRmAsdk1fkVyEctCt
         M0Dycnb5AuRPIafrUCMnRBQHlXVHmQQvINoHAF37GNpRpLzO5X4Q5MEmmsqQtW5aoKn0
         rFd/kpKnmiB4CNt2Tq+ewuFpUb10rtrO+jHDSVUT3okYrPdwXzAr4Y0XoKEWYtDbKMm1
         XDokm7wjlXXRyrvUX2KmPJmOEn0nOZ510+eO39BR47OA/keAzFeKJhz4aFZkuzoSEtlc
         btgvQt/c0hNhMftZoFP9a+xspt2ch+G7UUWEdL0TFeVxYJSKrs5lrrouvzgoOnPWUfKK
         5eYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776967199; x=1777571999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRXGXkrBT3IzTrNjLChryWldz16gsbb2ZziyyNHFu2s=;
        b=G8gRWNgE45PQE1ZjX4vx3PuctObN9m8ibgrPFFjU3AMWL8tfrEPF1aLgOHzlmr8iMS
         lRv6pXeuh55a3TWXndVp9VemQWFtHMdGVQKHPBHcOmfDpBDdMM+RiXv4MxWI8FaQpQcV
         WmdZKeM3gz6ZQwwWpzG8LbQ8AxmiFFjk/De9ZjjQP0hOKuxWXxQjUafjQKYVeJxVpx0q
         o8KP8EJRpyvOIQmnivNJfcOWCtfdBpRWP0CyILgSoCZrINIv4XAFhbdTeKIW7uzfFQkb
         dahSeVp13qqGYo2j7bCN3HQBjtU7UTtbFTWjVdSC3UUi6EQnqH1dxjacDTqzCzMq29Ga
         Yujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776967199; x=1777571999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRXGXkrBT3IzTrNjLChryWldz16gsbb2ZziyyNHFu2s=;
        b=pWREa5PlTl6Z1rctkZNMKDYbsZg6iN/UFZZj0BUfLqIXzRgIAbSIPLVaVCzE1KELLn
         9bUgTPpqWNiJ0y3ctltnOepbRw08kZ8SkiHzVTiXI2lcdW+WUnNn4/u1yPalhVahUi/V
         VeMMpwFlfAq4LC3Ze0t8w6+msR7E7CopMewSkffM5ye4JBxOmdZrNXrbBk/POYjXi/av
         jp670natwtojxyrqUlzOBIhdey5lmF9Qd/4yMbCKJFqhb4bDX80PJsgzqkbX6XtG/tsX
         fpEE3K6eRNkG+6o9sKxsXl7D5QtHs4UzBHI1lguEeFfcdDQdO+Ksr2mZa0xCUfZ1VSV1
         j3JA==
X-Forwarded-Encrypted: i=1; AFNElJ92rh0iWXpsDgTJ6reP1rWkfHr+9XcMsf5QQ/e53zDjfilWdK96xjdfrEJ/5olSpv3lW7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrNLfguj4ZeKnKDd/nvjW40C/t6LlBEwQZSTk2eKwiZRtwfd2e
	O2rT1MzXYcwytJxYcKIQbdZ2jrkOmOVtqSJG2BHi7ZAxnewXOswqkE1p1EF/v3OxNXZahaDme5y
	pYf6b1tFSzEzvHuudkT6biVF5vCaOvmv3C6qXQ67j
X-Gm-Gg: AeBDiet4logCCTf6L8QKce4huXCRjDVnJj08akpDdRT9061SyBMRZPboGCX/51QAcnJ
	cE/oYxHJXmnldS2oDC9UYVTWQG+SH4U60pv9lGa6UZaKF3OsRtd1WWP4wluhbhTKVbrGEufzR6t
	3CLG9v7KUnYvozObMUeIhrm1jEAUg8Pa6/mCs/0jMp2CI4SvW/vGYEmVkkdYqpnUHP8oZIVx5Wn
	CedS/b93ZE7Coi2d2OVNxniZtKJYJlTvl96Fh+XPRIiY8sqwgzPQtDyy3ny+5SoRRZd+4EbUtEa
	JXNjp8JLG/sQEOfL97ZV2pFlZUbY
X-Received: by 2002:aa7:c6c2:0:b0:66b:e078:5934 with SMTP id
 4fb4d7f45d1cf-67440727b3cmr284556a12.12.1776967198200; Thu, 23 Apr 2026
 10:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com> <20260423150340.463896-2-seanjc@google.com>
In-Reply-To: <20260423150340.463896-2-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Apr 2026 10:59:44 -0700
X-Gm-Features: AQROBzBYBLAbs4f342YyMsL7T-VPd2ig_Zd3qhHboPYFi6VME_NQMauvm2KHq_I
Message-ID: <CALMp9eSivf0oDdbgfLSY0zcvtMAV__da8ENCJk=QpEkEeUC1PQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf/x86/intel: Don't write PEBS_ENABLED on
 host<=>guest xfers if CPU has isolation
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

On Thu, Apr 23, 2026 at 8:03=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> When filling the list of MSRs to be loaded by KVM on VM-Enter and VM-Exit=
,
> *never* insert an entry for PEBS_ENABLED if the CPU properly isolates PEB=
S
> events, in which case disabling counters via PERF_GLOBAL_CTRL is sufficie=
nt
> to prevent unwanted PEBS events in the guest (or host).  Because perf loa=
ds
> PEBS_ENABLE with the unfiltered cpu_hw_events.pebs_enabled, i.e. with bot=
h
> host and guest masks, there is no need to load different values for the
> guest versus host, perf+KVM can and should simply control which counters
> are enabled/disabled via PERF_GLOBAL_CTRL.
>
> Avoiding touching PEBS_ENABLED fixes a theorized bug where PEBS_ENABLED c=
an
> end up with "stuck" bits if a PEBS event is throttled better generating t=
he
> list and actually entering the guest (Intel CPUs can't arbtitrarily block
> NMIs). And stating the obvious, leaving PEBS_ENABLED as-is avoids three M=
SR
> writes on every VMX transition: one each on entry/exit, and one more
> explicit WRMSR to zero PEBS_ENABLED before VM-Entry (KVM assumes the only
> reason PEBS_ENABLED is in the load list is if the CPU lacks isolation and
> thus needs a quiescent period).
>
> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation fo=
r extended PEBS")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/events/intel/core.c | 42 ++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 793335c3ce78..002d809f82ef 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4999,12 +4999,15 @@ static struct perf_guest_switch_msr *intel_guest_=
get_msrs(int *nr, void *data)
>         struct kvm_pmu *kvm_pmu =3D (struct kvm_pmu *)data;
>         u64 intel_ctrl =3D hybrid(cpuc->pmu, intel_ctrl);
>         u64 pebs_mask =3D cpuc->pebs_enabled & x86_pmu.pebs_capable;
> -       int global_ctrl, pebs_enable;
> +       u64 guest_pebs_mask =3D pebs_mask & ~cpuc->intel_ctrl_host_mask;
> +       int global_ctrl;

Is it worth noting somewhere that pebs_ept is not supported on any
CPUs with PMU version < 5, where a single event can set two
PEBS_ENABLE bits (cf. intel_pmu_pebs_enable)?

>         /*
>          * In addition to obeying exclude_guest/exclude_host, remove bits=
 being
>          * used for PEBS when running a guest, because PEBS writes to vir=
tual
> -        * addresses (not physical addresses).
> +        * addresses (not physical addresses).  If the guest wants to uti=
lize
> +        * PEBS, and PEBS can safely enabled in the guest, bits for the g=
uest's
> +        * PEBS-enabled counters will be OR'd back in as appropriate.
>          */
>         *nr =3D 0;
>         global_ctrl =3D (*nr)++;
> @@ -5051,24 +5054,25 @@ static struct perf_guest_switch_msr *intel_guest_=
get_msrs(int *nr, void *data)
>                 };
>         }
>
> -       pebs_enable =3D (*nr)++;
> -       arr[pebs_enable] =3D (struct perf_guest_switch_msr){
> -               .msr =3D MSR_IA32_PEBS_ENABLE,
> -               .host =3D cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_ma=
sk,
> -               .guest =3D pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_=
pmu->pebs_enable,
> -       };
> -
> -       if (arr[pebs_enable].host) {
> -               /* Disable guest PEBS if host PEBS is enabled. */
> -               arr[pebs_enable].guest =3D 0;
> -       } else {
> -               /* Disable guest PEBS thoroughly for cross-mapped PEBS co=
unters. */
> -               arr[pebs_enable].guest &=3D ~kvm_pmu->host_cross_mapped_m=
ask;
> -               arr[global_ctrl].guest &=3D ~kvm_pmu->host_cross_mapped_m=
ask;
> -               /* Set hw GLOBAL_CTRL bits for PEBS counter when it runs =
for guest */
> -               arr[global_ctrl].guest |=3D arr[pebs_enable].guest;
> -       }
> +       /*
> +        * Disable counters where the guest PMC is different than the hos=
t PMC
> +        * being used on behalf of the guest, as the PEBS record includes
> +        * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status fo=
r the
> +        * wrong counter(s).  Similarly, disallow PEBS in the guest if th=
e host
> +        * is using PEBS, to avoid bleeding host state into PEBS records.
> +        */
> +       guest_pebs_mask &=3D kvm_pmu->pebs_enable & ~kvm_pmu->host_cross_=
mapped_mask;
> +       if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
> +               guest_pebs_mask =3D 0;

I don't understand this clause. IIUC, it says that if we don't have
any exclude-host PEBS events, then clear PEBS_ENABLE for the guest.

Yes, any guest-programmed PEBS event should be exclude-host, but if
there is an inconsistency, shouldn't we apply a mask? What if there is
only one exclude-host PEBS event, but there are two bits set in
guest_pebs_mask?

> +       /*
> +        * Do NOT mess with PEBS_ENABLED.  As above, disabling counters v=
ia
> +        * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABL=
ED,
> +        * e.g. on VM-Exit, can put the system in a bad state.  Simply en=
able
> +        * counters in PERF_GLOBAL_CTRL, as perf load PEBS_ENABLED with t=
he
> +        * full value, i.e. perf *also* relies on PERF_GLOBAL_CTRL.
> +        */
> +       arr[global_ctrl].guest |=3D guest_pebs_mask;
>         return arr;
>  }
>
> --
> 2.54.0.545.g6539524ca2-goog
>
