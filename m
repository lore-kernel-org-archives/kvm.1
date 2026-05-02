Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1A7946C
	for <kvm@vger.kernel.org>; Sat,  2 May 2026 00:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777680301; cv=pass; b=eEfM1WSHykFIjXX3tkaNvQioO/Rz2kIggu987hGSm086V1O86OvdXGmfazLeZ4KDEzzq3xsYSLqliURt4Ej32qISPWzz86D4wiMVRFiwqtaP9E1EC2pv8LOdKuLQcSYsQ4JHS7mSIFnsqNkVLrLZfUcBuuYNmbLvmNMHF+TQceE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777680301; c=relaxed/simple;
	bh=jmTIlqDIG+2F0eY0rS1JU8RB5gKbSRn+IjlGTZDRniw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQzfMuxtMi5c4j4EpIPzXrAuS8CuEWTNxkJ0bFfgaoqiJdSWBMhktqYZ6JD/zbHZho7G37fTA/20VKhaJJrOtUuhtSoMzIAj2PAzbq/q1ovE+rZE3y/cmfcUz8PSSJyXgdouUw7H6g8l4dH8IEqNCi2ZvaUJxG3Q/qdlBRX+XXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nronevRu; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nronevRu"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso1441a12.1
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 17:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777680297; cv=none;
        d=google.com; s=arc-20240605;
        b=Au1DSroscIf78+L608TXHM+akWwbJ9DCjLAvmHEl9h0x59gQjwtRZ3kYUJWYAYXU5W
         w7wYcv+/lsrSNwBEEoA4gkAyQrgO+VdSnG7wKCx01aMUv6d/1s3qVG9OCKAfipUUdLwz
         h5l51xdPBI+LT0h8B1x1DeYcNGWzL9L4EFpC5Z9numIgBFq5ycls1Bdm63Bmb/RMBYHk
         hBVTyC30Pbqr8LHwIa9lQmkEw7HVN1GQd36vhC06qhmn5RVhnlGZ43GIU2b6ptQCRt6E
         pzErkHPm4hJtS+7+G9u/iuCHgj9yFI3toM3JUH/9mq3jozZzF5XDW3ZM+heIziE9aNad
         4dcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BiMKE0Qc1DxW4ucWujV74L8Z61uu2FejYlr/YNQXWk4=;
        fh=f6i8COwecYJKqFDZk3b/e+tkeHGG64CszUgcW79TYyY=;
        b=MjzYPI0FQBG1xbRVhfMiNI7mB2adNW+wkFehTGqCwwZOIe75+vJ7yJmGXMFszv6ghz
         64DJInJMYWMUJvU1PJt0Bfa0vRyZ/xwRTJEyNmzBHoBNZ1UkUVu8H3VzXPoxJzPVkJGO
         9T0Eawq/7LRwgs//2yPC6eP2ros/hEcM/dwoqDFHZW1Jez4N85X8h50tv60CVZzcC6oy
         pY9SyEdgikQvHlC5Mcv8nv+3FxFsu02sATAy622V9OEi2DeQiSEa64c98CDVTA1DJ/gA
         yogCxGgplEh2yt2fghF7MrRKmUcxCYXd59F6ujvUt3OgaSMaZ0cqb4alazaThfANPKqz
         ck9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777680297; x=1778285097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiMKE0Qc1DxW4ucWujV74L8Z61uu2FejYlr/YNQXWk4=;
        b=nronevRu2lKBvXZMA4+w1LG6/B98OZddxZukCSWvBQdVCFdO8pw8sbQWwvAh8XiyMp
         ADLq9OVAXH0Xxs46757UkllcnOv1nNM2dmcHQxzVLHylVhxYttTFEEAxwg3FQJs3VRhg
         17U1AJVMovjqFgLKEtOGQwAFB+wyNUUT/Ose0t6NmWyD+i5POra1kCVncM/020454owu
         EghtXs7ir5X2Czf4oNqxzlp6ofbGLUYvYMAU5A43tm3YGTghUMZSdDMuUB5SGiueWn0e
         MEDLZp3RCy7MexwtKh8keLCXwQKNqNqJcUO5Z1J7pTdwTxllyIEgwxWl14cFhTf3A/2f
         dnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777680297; x=1778285097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BiMKE0Qc1DxW4ucWujV74L8Z61uu2FejYlr/YNQXWk4=;
        b=WzWiPoh8Pig0OA/+M3EaxrXjE8z0th8Wo0lgn6Kk2BOjfTP+fVwziui8+5UrYWKaLx
         Fxs92p42M8H+1/NXxEdsMv/IeWcNXQ6fvUhUe7l3AKWCAMjkEjiUN/j+h8iTnDGjK/dR
         N1ew7R4uxLvd7o9l53unQZMQ58VZKQVmqiMJNVpbcXZmpGkI6/ntpOQ2FvRcken9vFYQ
         hoRbzg/4yTyIgdAXPmyjbU/xLF/nkizp/VqBCOke3hFDW0HNFF4rifCtKlDwEWb4o38R
         dYIrRDyeT+QBWtpGb8ASz8VmIPfifaMvYUqCtR/Vxr7ZK/sBl4mJFmpHHyauQ8q7+g+/
         k32w==
X-Forwarded-Encrypted: i=1; AFNElJ/U36KMf4N74OaI0QY4DACtkPfCz8jL0N5QXQbCdf/TRe4ZpH1MBZlOmbdrmCH1O/1MNd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFr04qvJUTCqq4Av+Dhjeq3VodGzfkQY6o4tAGNbhKTbBYEVyf
	Axy2geqbYO4kNNWbuW/hdQ5xGzUwYM45mEskfwcSMbYPOGAvmIHiynTE2i0MOxKVepSI4m2yBEC
	G7FJpo962uQpOJINE6ebZ6pk2aQM6m8QzYe8Mu+HF
X-Gm-Gg: AeBDiesDqioBQjKepcKu2dDam59vd+StWrK/K+BFaMOUqzeJ41948S9gUvEtRFJ8Dja
	2CC4qi05MEMawOOMbbXdom/upNngHw3S7JrnjIUTn+mmeUP0sZhxxYL9xy+3JbEZFoQ583LQK1Y
	srfsKEKGHnKUu5SJTxshDqv2vwKmzRs0O9NctgMevjx1U0L2mSI5M06HltfKbkJ099eYBMFw0pa
	l23wKZLKmLo4gFHSjZV1VXkW2tTR+p4EB9NlsduPOfwZ4ZboVoCzp04PGoptvyCtDyp5+9Vi/K3
	f1hnTFYE4hqXZhvDGurMGciOkPWL
X-Received: by 2002:a05:6402:148c:b0:678:a5c3:4d12 with SMTP id
 4fb4d7f45d1cf-67c1df8eb77mr10027a12.3.1777680296929; Fri, 01 May 2026
 17:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com> <20260423150340.463896-5-seanjc@google.com>
In-Reply-To: <20260423150340.463896-5-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 1 May 2026 17:04:44 -0700
X-Gm-Features: AVHnY4LR57kQ_JJz2IVwy7QXTY7cpNVRpOebxhP2Ymd9SP-YstGqP92VpD8VPNc
Message-ID: <CALMp9eSt-ZDCxhyVjEiov2475ToZ7M_94HSpKg6hqrh=m3iZAg@mail.gmail.com>
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

.

On Thu, Apr 23, 2026 at 8:03=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Have perf define a struct for getting guest PEBS data from KVM instead of
> poking into the kvm_pmu structure.  Passing in an entire "struct kvm_pmu"
> _as an opaque pointer_ to get at four fields is silly, especially since
> one of the fields exists purely to convey information to perf, i.e. isn't
> used by KVM.
>
> Perf should also own its APIs, i.e. define what fields/data it needs, not
> rely on KVM to throw fields into data structures that effectively hold
> KVM-internal state.
>
> Opportunistically rephrase the comment about cross-mapped counters to
> explain *why* PEBS needs to be disabled.
>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> ...
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 7403ca721b6a..04d9c51335d7 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -14,7 +14,6 @@
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  #include <linux/nmi.h>
> -#include <linux/kvm_host.h>
>
>  #include <asm/cpufeature.h>
>  #include <asm/debugreg.h>
> @@ -4992,11 +4991,11 @@ static int intel_pmu_hw_config(struct perf_event =
*event)
>   * when it uses {RD,WR}MSR, which should be handled by the KVM context,
>   * specifically in the intel_pmu_{get,set}_msr().
>   */
> -static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void =
*data)
> +static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
> +                                                         struct x86_gues=
t_pebs *guest_pebs)
>  {
>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
>         struct perf_guest_switch_msr *arr =3D cpuc->guest_switch_msrs;
> -       struct kvm_pmu *kvm_pmu =3D (struct kvm_pmu *)data;
>         u64 intel_ctrl =3D hybrid(cpuc->pmu, intel_ctrl);
>         u64 pebs_mask =3D cpuc->pebs_enabled & x86_pmu.pebs_capable;
>         u64 guest_pebs_mask =3D pebs_mask & ~cpuc->intel_ctrl_host_mask;
> @@ -5052,7 +5051,7 @@ static struct perf_guest_switch_msr *intel_guest_ge=
t_msrs(int *nr, void *data)
>          * wrong counter(s).  Similarly, disallow PEBS in the guest if th=
e host
>          * is using PEBS, to avoid bleeding host state into PEBS records.
>          */
> -       guest_pebs_mask &=3D kvm_pmu->pebs_enable & ~kvm_pmu->host_cross_=
mapped_mask;
> +       guest_pebs_mask &=3D guest_pebs->enable & ~guest_pebs->cross_mapp=
ed_mask;

It would be helpful to save this mask somewhere, so that it can be
used when calculating guest_pebs_idxs in x86_pmu_handle_guest_pebs().
I think that code needs a fix similar to the one in commit
58f6217e5d01 ("perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest
with vCPU's value.").
