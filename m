Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE1382361
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258018; cv=pass; b=WT7OoeSknkM+tPGVcQH+lyjklo2vlyUJUUFNn3ocFJ+sKuexKu9f83Rv0JY/u/mjdgYoTv9AbQtO9uWGf1nviKsME9GGtla9YZ/lZxPSqcRvHqjh7sm/K5E11gpRGqzJRvU90d0udHfMz9xvpVSQlDx4vUQtM884own0xWHBg6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258018; c=relaxed/simple;
	bh=LW+9VRqZobJwP0PeOeVYPcYO6+HdVBVvV4EobpgdWFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COjYDzUoDpIj3rNwXlNI3g1m0bAArxpljTzFTsZOQ2mC1bpXMU+dEgDuIW1Tp3JetUBNV2sIlEpT0MJBviSvvgD+Q83SETDqCP17brIe0VHKr6MGDWMcyKl0NgiD9kBFlr10x9/LwoM6QrxfH3qKwkEajwcfxyXThKI3I46xFbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnU3xGDB; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnU3xGDB"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso34952a12.1
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 06:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776258014; cv=none;
        d=google.com; s=arc-20240605;
        b=KyKYAkCpIW6PSW5Lw69dGIUgHALyY0fEpBN/KxVcPUOFvX3WV72eSdpSsC8m4HiWj6
         tfL/qs++OamyRvoPh0ST910+YMBNYh8LIZ1J2yphIn77MXb4/B166vtSRH7YIoxyWZ+B
         /SQQ8QGl1qqDR6LgX/KHYM/hqZm5zOMcdgHGvY9XPd6fJEEPr3YsKXyH5q00lhZPjx3P
         xHCb2C8t2cUSGqA/v9I8G3ZgqFff0ZtCK3GqbR4E8D3tvd5N8G/3lQEowS5n5kTDMYL+
         zx/r6YSlOZSJ3G8CIS5W5IcMO1WkArVptOJUsxzRIVdBRzdImahuzBko6llx66CfxcoX
         XA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JCNaaeYnrpr4S5ml/FPDiY0iZEzrTwHWX5KjR7Kb5uo=;
        fh=MI2/yP7bvNILK4yinox2Zm78/VeOH6BiRR8vieWdiAU=;
        b=EvGCp0vcvlbwcByFG4137SkUlyctGIF1VUuH9ublguGvcVkAUglCEvAKq6NaWe1LS9
         H4qfNJ1jzKKp9Vh25lOm54j+lKxSLm/CGJrs6VQ3F/XICryS3hbgQialaW+N64gLOc9L
         kcpBYwDlMWPn4UtQ22zBC6GL8m16sfhrYBisPQSt503C3jJZrHPe319ctHrfzyp2diS5
         h4lWCT0Y5+oLoNZSdPo9PVruITCXmTn2OyBgxLnnJ6hcsndqFcP5Pjh8W4J4tcCEj5Oj
         JW6R/0LS0OF3ab2byNlwTHnMfcPQpiA2SA4wvsWaoWUGceEvMWwzbN6npM+WSrrYkNk5
         WO7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776258014; x=1776862814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCNaaeYnrpr4S5ml/FPDiY0iZEzrTwHWX5KjR7Kb5uo=;
        b=ZnU3xGDBb4awF4H9RFL/K8PP8PNvFNsS4KYC2UYZHqTHELlbmnmVauNcX4Q1v03POL
         OIMVDuRmH2lWV6cTyp+pjgHMtJnUPDmcX2SLSAayGdwJGoI2bgfJR8l2wRrKpn7HzTgp
         isduyzsywd7xfuYjfdMA8XVenO5BkrmLDnrl6w4i+vhd5Z9cRLuqcKwIFsbPDXzU6QkX
         kVg2dRI9nKy+9l63DZksDZfKOrilJEkTJHD/iaV+c6jmK/FrUtaP4a7H+vFTgo6kh3wQ
         wdp3qHLRehzjZ8D4C2iLAL1f5OOYkUAon+DAyyOBBrHCpSQNHbgMWM/kD+bwMrAiKbUe
         aQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776258014; x=1776862814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JCNaaeYnrpr4S5ml/FPDiY0iZEzrTwHWX5KjR7Kb5uo=;
        b=XRDg9BCYMNiOW/t5Y5rBTsLxo44z64EY3CuQJtQ7GdRBShNbdMEuOEw4PvDWJfTwex
         rJa/0ILRMN4ND2hs1vP06jgFuD4jdeU56c15+YvhwNkNY/iqtxkovEfyOeTX4ePv+K83
         OI98OnxnvqIRoqwS4gt8Ies8yXKywqSk8N1jrKdJ1JXszpDAa9mt7ahiODPM3BOlzRJz
         0Z4PkgsbntMa/HoI8io7nd9gbNI6onS0MX+o6FVbwPs26aL7Gyk4DwzoFUgslnkqKzuT
         gUnWdN9XnHOQujiorlLXQnN80+YkhkDGibmdw4SV+LrhIAana74EKMMs/JL+Kb5hcYl3
         dlWg==
X-Forwarded-Encrypted: i=1; AFNElJ+bIr4RVnUhAu/iS+2KvQYQSVWkn08HZOeqhfP8N7yFpg1KiszaQbIo/I3JDV4/asw7Dg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNfVzrCWjzPzkJU0bx/ZpVMmhLdpx1z7DiOmWDl4MUA9KXlRYk
	TT0fDfs7XbYFCMMsJlfMVvT5ucVFBBMyNc3BMAUjswsU1sSSQOhFKNAf9XZ0VS9nmm9U+vvAolY
	ldeq/27QQXX/wON+o5VwvVOAjz+zqwHRIa8U4k9jz
X-Gm-Gg: AeBDietIZRhP43LncVLPIh9pstV6mWtTxmBXkkj7Ey1/Y0usg1LExzWRkMr8JJpZD7z
	YdjBFaFmkGrbyfpicDxLGtNosU7uk5dtIsnRCwq5ZBfZ1GRNWdKAtSF+gi8N2UVOURwNFGURw+7
	cjLl08eAj8YJ/z1RmxGojqubLJv+tWjRZa4p33JLViuapaOErpJVRa4+5PuQMTJikvSZmK9VG8S
	i7eFXvg4MpigBwxQ9hMK0+4gp0SvyCL8TF7dyCF7UvN1UZ4iq9rmUWyvcpRxhBJCOAPUkFtxWD4
	59dHx8C94YwMlATAHkxwZ57XkFOkLz2CDod+MPY=
X-Received: by 2002:aa7:d79a:0:b0:66f:d653:92c0 with SMTP id
 4fb4d7f45d1cf-67230d8b373mr28560a12.1.1776258013088; Wed, 15 Apr 2026
 06:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com> <20260414191425.2697918-3-seanjc@google.com>
 <CALMp9eRxd=-xotnr9rLYhHtVK6G5oGAbXByXgpt078G8mWQEqg@mail.gmail.com> <ad7Ei3FsFSm8C8he@google.com>
In-Reply-To: <ad7Ei3FsFSm8C8he@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 15 Apr 2026 06:00:00 -0700
X-Gm-Features: AQROBzA_EzQ3euCNq8tdeVNjJ7rCBtxF_H_9qgmPaOzI01_Fog9ihiTjReTuZnc
Message-ID: <CALMp9eQW-3cd29yduDmFzo+HyKZB951jSxf0bV85zLT+x9iF+g@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf/x86/intel: Don't context switch DS_AREA (and
 PEBS config) if PEBS is unused
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

On Tue, Apr 14, 2026 at 3:49=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Apr 14, 2026, Jim Mattson wrote:
> > On Tue, Apr 14, 2026 at 12:14=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > > @@ -5065,6 +5056,28 @@ static struct perf_guest_switch_msr *intel_gue=
st_get_msrs(int *nr, void *data)
> > >         if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
> > >                 guest_pebs_mask =3D 0;
> > >
> > > +       /*
> > > +        * Context switch DS_AREA and PEBS_DATA_CFG if and only if PE=
BS will be
> > > +        * active in the guest; if no records will be generated while=
 the guest
> > > +        * is running, then running with host values is safe (see abo=
ve).
> > > +        */
> > > +       if (!guest_pebs_mask)
> > > +               return arr;
> >
> > I think this has an unintended side effect. If DS_AREA and
> > PEBS_DATA_CFG were previously listed (because pebs_guest_mask was
> > previously non-zero), KVM will leave the stale entries in the MSR-load
> > lists.
> >
> > KVM only clears MSR-load list entries for enumerated MSRs with
> > matching guest and host values.
>
> Argh, right.  This as a delta change I guess?  I'd love to overhaul the i=
nterface,
> but reworking KVM to play nice with core_guest_get_msrs() would be much m=
ore
> difficult.
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 20a153aa33cb..3244d5589981 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5059,22 +5059,20 @@ static struct perf_guest_switch_msr *intel_guest_=
get_msrs(int *nr, void *data)
>         /*
>          * Context switch DS_AREA and PEBS_DATA_CFG if and only if PEBS w=
ill be
>          * active in the guest; if no records will be generated while the=
 guest
> -        * is running, then running with host values is safe (see above).
> +        * is running, then simply keep the host values resident in hardw=
are.
>          */
> -       if (!guest_pebs_mask)
> -               return arr;
> -
>         arr[(*nr)++] =3D (struct perf_guest_switch_msr){
>                 .msr =3D MSR_IA32_DS_AREA,
>                 .host =3D (unsigned long)cpuc->ds,
> -               .guest =3D kvm_pmu->ds_area,
> +               .guest =3D guest_pebs_mask ? kvm_pmu->ds_area : (unsigned=
 long)cpuc->ds,
>         };
>
>         if (x86_pmu.intel_cap.pebs_baseline) {
>                 arr[(*nr)++] =3D (struct perf_guest_switch_msr){
>                         .msr =3D MSR_PEBS_DATA_CFG,
>                         .host =3D cpuc->active_pebs_data_cfg,
> -                       .guest =3D kvm_pmu->pebs_data_cfg,
> +                       .guest =3D guest_pebs_mask ? kvm_pmu->data_cfg :
> +                                                  cpuc->active_pebs_data=
_cfg,
>                 };
>         }
>
That looks reasonable, if a bit obtuse.

Reviewed-by: Jim Mattson <jmattson@google.com>
