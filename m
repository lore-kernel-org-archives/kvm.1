Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EF53DE441
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843394; cv=pass; b=q2a57L8hQQMME35oYLRm5o4Zk3S5cLszTc3zBY92wdBGPjpnqHmi2pSJ0ZkBUBuDyj6Cuaf2F/DifKmqLvvjrNw67E5SYsiG2cYaTeMWmIIQd5lrbLjcwwMZzMI/eDB9kxZxR6xxsAkmyuKlIN3xzTIOxCSe/YC92I9e+6QQqfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843394; c=relaxed/simple;
	bh=NXntaWlH3vQ/ae0QsdX6wpm4Mc9Mf7XyJq5cUmeC/4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuOnM0ZvaRXGTBW2E/QnNktoKMaorfr/9YH4CqrEajDkprXMAhJGKL/n/RIi96muBDXHDgAxTeetv1oEvVOsINTTjzDKs8QBVNq5xgevXN1CV4f2nqxtniXhmi0DVO5tP35bcYDRKprJP4UtSOYbGVLsAzfJ+nwduWpfDTsZwrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h8PDrN8Q; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8PDrN8Q"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so1569a12.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784843391; cv=none;
        d=google.com; s=arc-20260327;
        b=h+vWCu4YpFym62bYdLcC4BOuNCckjiSR2Tva6/nOHf12XQT8X42HQuMvMampAKh961
         X8tx47fG7llqCKhMZYe5BisvTyANQ1lvnmv2j6/8fF51A2bNq4XcIjBgWl90rgShKX2l
         i81EusmiBEhT146ulB+KoXXAeO9jsBBLj4x/QAv4bpEPtke0PQpqwAmTZneM+wothYX3
         CY642HNL0Y6mJFZYOjFHZO3MrhDQXqxjgLLzAqNvEaw3Wd8brzT9qtrgQti3zL/S2cV3
         6Sxg82FIyG7kpd9tslFqHtNZXzI0ayOKfFYe5qLbSRserDd1o6wB5ZhOl9KnNWPXo46O
         WgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n7z1EdKdDB71dQapwr73BM4UoNv/fqbfRBSOIHSsrCI=;
        fh=847QlwD+JWVJnAikpHGFKx8umB6o+QBneBGwempXW5Q=;
        b=jvJOZ4JNJy5FECVrhJwRAKIguayR4XFiIJqoMlt/hsNRktTy2vSOtCoFVBeXFDTmeM
         Reo437sQxHxV6Qi/9R8GgS6x9pUAC42T2i7bx8aHpJUVlaM2xh6FWbYpZl7v5uHyw+KF
         qBrcbRQVgY2ZMzr18WOHNkIboLwcNdlFNUWnkCxS2AdPSbtdlMW4iTu+z38uPboY+dnq
         DDm9NXSueT8lH6ciNA8bP2z4XQ1b6BIlCVa5/BQFoTFoLfaSh6LfIDz3yE1qCJK+EEm4
         ZNcgjCJ3YMQK901LdUw9hjON3qZhGVQ1Im1gw+HfcQKpHyfIu/+khGw1V2wYmwI+ShTX
         tXpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784843391; x=1785448191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n7z1EdKdDB71dQapwr73BM4UoNv/fqbfRBSOIHSsrCI=;
        b=h8PDrN8QGZg2GED8zjmF4Av37pO1v4YkE6TzrgVEZw4tq706rI33erMKMtJYKA+KI0
         bfNf/NLwVutKkDz+3Ed6Go/WFsrorjL4i2PrxYS9QnadqqZY3+52a92lDUDhRLmtTvg7
         PqfC8ajc7n1NtLWirvfVv1KVuGmBH3F+7IYdUwZWcONzxcqNCz1UMlgRSdtItTl5wHi8
         yRpVIx3n4gEf90FkRubfHbBPOOXIitSnrQjYlJD6BOi3vL6og/+keoM8WSJ+Bf8DnxM3
         nCkWc7v/kIhVvrOCGuM//b+31IJ2Tn5w4/tMaU4jZe2/Of6o3IxNBCuUVl5qAD2SKtfD
         J53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843391; x=1785448191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7z1EdKdDB71dQapwr73BM4UoNv/fqbfRBSOIHSsrCI=;
        b=OpotgyDNdGBSFJW7nf0trg54q9/7OoYNXV0YkV5QadnZuqhuzDy8D7Tl03WMqDd7xQ
         dVFO/6syvgf8KLxTVY/c28PJl84BESPN2qCRgokKNOZx8s7G3pf0GWQrXiFrp5e2n+66
         mrUfjP3cJfUB0oHFS/VBxp8z6yIT2/fj3BXwtyH3MSRURdH0HVivQ78/oNuMZdRclR11
         HIBB4tFMp3880TJI52HC70J51ANGl64J2TaXCwxnErGcSWAOhRHGkJ2cCKTiptMloAoh
         DqaIgwFIiEtHhT5fmIeR9hoSPTPsAl+I0yRUobkgJMjsRrDDd5lAea7a5zIPgAAbGX+q
         1zIg==
X-Forwarded-Encrypted: i=1; AHgh+RqDevNbKj766qxloSkHqE4BSaKXWxrq1uKz+ymVBIJBo/0umsKRHPDgm42gxP3PnlU9yeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlafsC4YG263KZcWqemYl8I5mD694ctlUVVfmWqKdUw9o3MMsV
	MtlNx08iwUdUL7Xb4zBy+NCuDeXHoKHyCm7RRtzLmPBAI1g3KBObECVDcgJLxuC9Pac/ZVNlZcM
	oSQXrpVAMbLvJfO+SmtoyYjF+l5uM2NOrZKuGVlN0
X-Gm-Gg: AR+sD12oAa/9VJGuXXtsMm2hmb2yyzUZQinm9NJrPIsg3/aa3wMgnHRlpqBF9w1qDe8
	Wp/QI7O4wYrq0aFpfUu6B7T1Up5zPoMJz68Knn0FHjqQJvkHG9dGvO8XFPPeVTd9XbMAZBilugo
	jf5X8wDpwW6uAHpIZsEM9JYFy4hzHftu8tHm2PBYa/4ngBkst6yx/z1B/P0m1Sv3MC1ECYMBZZw
	eZFenpzy1znEsX36pGJo5jqCWZ3gVMq9TnWMcC54BdXbNg2p/YekgEhM1ih4A==
X-Received: by 2002:a05:6402:2153:b0:697:9254:a66b with SMTP id
 4fb4d7f45d1cf-69f8eeaf7camr18393a12.6.1784843390183; Thu, 23 Jul 2026
 14:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707183405.15571-1-zide.chen@intel.com> <20260707183405.15571-10-zide.chen@intel.com>
In-Reply-To: <20260707183405.15571-10-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Jul 2026 14:49:37 -0700
X-Gm-Features: AUfX_mxhUpw4tknODIt7xHU4KQrggRWgOaJJolkeP-1QL1-J6t0_kriq-ZHYrDg
Message-ID: <CALMp9eQ7QwV_bmgCCwQuEMu64Qqi0oMAyoH=p=gkt8Z9RLYVTQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] perf/x86: Remove num_counters_{gp,fixed} from x86_pmu_capability
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 11:44=E2=80=AFAM Zide Chen <zide.chen@intel.com> wro=
te:
>
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Now that KVM has switched to bitmap-based PMU capabilities,
> num_counters_{gp,fixed} can be removed from x86_pmu_capability.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/core.c            | 2 --
>  arch/x86/include/asm/perf_event.h | 2 --
>  2 files changed, 4 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 65349819ba43..5bcd2a48d2b3 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -3132,8 +3132,6 @@ void perf_get_x86_pmu_capability(struct x86_pmu_cap=
ability *cap)
>          * base PMU holds the correct number of counters for P-cores.
>          */
>         cap->version            =3D x86_pmu.version;
> -       cap->num_counters_gp    =3D x86_pmu_num_counters(NULL);
> -       cap->num_counters_fixed =3D x86_pmu_num_counters_fixed(NULL);
>         cap->cntr_mask64        =3D x86_pmu.cntr_mask64;
>         cap->fixed_cntr_mask64  =3D x86_pmu.fixed_cntr_mask64;
>         cap->bit_width_gp       =3D cap->cntr_mask64 ? x86_pmu.cntval_bit=
s : 0;
Our internal Sashiko says:

This isn't a bug introduced by this patch, but since KVM is switching
to bitmap-based PMU capabilities here, I noticed an issue with how legacy
AMD PMU intercepts are calculated in
arch/x86/kvm/svm/svm.c:svm_recalc_pmu_msr_intercepts():
/* Legacy counters are always available for AMD CPUs with a PMU. */
for_each_set_bit(i, &gp_mask, AMD64_NUM_COUNTERS)
svm_set_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
  MSR_TYPE_RW, intercept);
Does this fail to re-enable intercepts for counters in ~gp_mask up to
AMD64_NUM_COUNTERS?
If a guest's CPUID dynamically disables previously enabled legacy counters
while mediated PMU is active, the intercepts for these counters are skipped=
.
Could this leave the guest with unauthorized, direct read/write passthrough
access to host performance counters?
The code just below this handles the ~gp_mask case correctly for
MSR_F15H_PERF_CTR by iterating over host_only_gp_mask:
host_only_gp_mask =3D kvm_pmu_cap.cntr_mask64 & ~gp_mask;
kvm_for_each_set_pmc_idx(i, host_only_gp_mask, AMD_GP)
svm_enable_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
     MSR_TYPE_RW);
Would the legacy MSR_K7_PERFCTR0 handling allow a guest-to-host privilege
escalation and information leak without a similar fix?
