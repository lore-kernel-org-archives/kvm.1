Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792689364;
	b=AHgo0D4wI6XGGx6x+sNpuO2t+zPstNnOLUfxN1m6hA3q3NCkavEo7m6G1KJuMqtvEw9H
	 s76JkEQTQ+by7FJSeIpV/+RmrVItxxbfhCNo32y0h1DgkND7DuKjckKHceRGuvWvlb3ED
	 sDpfEjDkNknqfv42WcHE2CcjMWP6mNOOh3t8EEmLPF4Ju5xpMLTYnrdSTY1zkVoRvIAjb
	 xLcPGPI/IvHWrO19cZZ7S6KjKnybr5zcZZqFgdMir43Up6sNRqeCi5sXDzDVnAJ99vLhd
	 j1Ifin+QkojnTTI93ew2XHHjvcHF5z250U6jNpQTJ5cbTnJ/j7V54GeoDxIxxXEjrWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=orOSP583y+dthBMPpY/InD7yqO0PC4Gq/OKcTL/XceM=;
	b=PmEQzWMq+6vC6o2oQ2VMF616OBTbklSzU4R3qscehWGg5QM06rG/ZT+hetNfmHxkNWTk
	 V3ShoASAIcTOW+YCmdRBvp04taZ+nwVmOu8U+90qZqm5FcEgTO85z3L4gNCCh3AzTiYOd
	 o5hEliX/gsoeeKtqPi8daqHgCg6KmrH94vPYDzmXmA4t8JXeTH16LB0sYJQL9FV2Zj5KO
	 oVbTRPtgv05GcNzVmsuN4koUQZcG/emyx8W82ORV340h1NAXEtZBY+9Gu1k9p+eHMHfMR
	 Adz4B1Lk/Ic0d7aV1oE9HwcsW+jhK6Tf709sdHxRMCoa6x73dJ4hLwrAWq8mp/R5t3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cKGmxWaC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C6C606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 17:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51C6C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cKGmxWaC
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so92a12.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 10:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792689362; cv=none;
        d=google.com; s=arc-20260327;
        b=JYYWeBFnNKTtHve0ami89UMDdWyQNaLlmSYmszAVGPUETP/UTMpjFWl9cBXlm3zFlt
         zoA5jOez+l27Ii0BPISoLMy9bTU+tLjQyDo/4UcnYy1EIpmpv0X/1r9Z04dZ3G6sk3f/
         WncdpTBqfu3T53kAW1zz26Y/1x/Fhz09b1cfIqsyQXt+iHKs0CCMjG+uRwCTHQjPuY3x
         M2S8RJt1235LxSJvIDz2uhrW3PuSLiH2b9ZwZmGn0mKifChhLH6JlwSq0qJ5wHhYp0Xk
         4LxztnqeOxfpkk+WalRJaJoT50x6mVrk8qFayLImxEs1Bm5m1xIyeuIcTzsMo3Wkc8oe
         tu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=orOSP583y+dthBMPpY/InD7yqO0PC4Gq/OKcTL/XceM=;
        fh=dB0szE+unGd3PWNynlrtRPVNXOFv+NrYaxd7KOa844E=;
        b=ctErQ8HCMziX1/IZQE8mV0WyT6yHuc6+t+Ua3MF/BrL08+EzzY9bJ14bBtgcZdWf8f
         A4epNXLsLGtEMI3crXUtdxEFwn9XmxiXVxO7uw7H4VXzMLklPjq52og1Q7HcfcdGybNp
         0+wEjU4Ehgg5otdJg9xaeBYfc4eTaoxdXZALaxTu+vDcMyQ9wWdUH0lZGWAmyDzcRQSO
         LPUBlgZ/jS+OLSghKfaR83FlVgxKcxDIVmKB75HSH/eWa1lohfVGPXzEeudDQAPk6Gf3
         k2yFon75xSwT4Rm7sSm8j4D/ca0hjWCm+LSiXi3UkVGYde/8Ox4Ecte3Xe0m624l4U1i
         Jalw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792689362; x=1793294162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=orOSP583y+dthBMPpY/InD7yqO0PC4Gq/OKcTL/XceM=;
        b=cKGmxWaCNfoZqipE6jfPcMJQduGrIftYnM/+Kp4oJODUDkU2EFzy9cbzNcnGPeZG/R
         hyYDPQ/H7YNC/MSNAxChPIe/KdwWUuPvAy3M/DLHzKliH/lbFcXk54oJn0pmfVyTOyZs
         7T0mQ8rGC9a6j/lnKPhF2Za/2kd4U7Ukgcmq93FFMcGaaoyT+4gLniyRsttmsE18IdYb
         16k1R/2UE7bqpyO9GviglctVHq+H5O2lq+YdYGyxCuRkGeA8InL+JpCp3/SoSGZ4b9AP
         CaEFeWfcCYypcSXiFst6ktCHjb65OwqjdQNuWyIkjRGWKYcLqGrPSjXEQvgiTthuBZYZ
         lh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792689362; x=1793294162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=orOSP583y+dthBMPpY/InD7yqO0PC4Gq/OKcTL/XceM=;
        b=GEiSFJz7KoQskgsc5x0wJl4yxrNLCM27xJqgRD762XcO74Ro6447GFLmMN41GnC3RN
         g0utFFSXEpC65CVs7NvchZ+7Fohha3QkttybOb2WqsqKcgn5JocNHMjZ3QoLXgdxr7XK
         rIV6DKa93ZXy9OwpEBJnCeQTzraYMINxaHsoAY3Ts/bghZdf0CjBg/XDQ1T43FEmenMj
         DaLSybOXo3iwa5KIdG2xDwiISNWvjgesiAdU5ynjpUg89uIYbcCPBJ7gpKX3/yA8nqeK
         Sd5JHe3OPIR6DAudsH/U8bk+kfcEZQ8gTEx7s2Bei2p/eKhc5QM1tfVWevP53o/ZNGJ+
         sKcg==
X-Forwarded-Encrypted: i=1; AKwUvBzve83noYQfKXE6V2EoT4ItxRpkoLkwEs7TLDjq/83un8OKntCmKziOqchFff+q08mo1WM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIVhdjsFwEmtwT0jU4Rc9Ij4RHaT0+fox8xAx4DZ9ErqgC67dU
	BGceYShCrxoSHXzFUNtQyGIP3BFj3TTk9kT94xJHGrMisl+fYKMC4uKnVWnlM7dx7Aiy+KrseS3
	DMoMU7qXokbHFh4+e4XSFPUxyvBS/9U1TfmGdAqhQ
X-Gm-Gg: AYBFou0P8ZQDkpf7waXNOjyKVeuxstXqtFj0c6+jVhXnKF8A0Ti7//Uuz+znVBfEG5i
	YVkgxvn7cwt0dHS5kJJWZ53Ie5itqoZMim9Xuc2cL4xRP6MJxHpq7uzEEoCoLORyCa8nrRVzdEr
	BWRSe4ce3oJRaQhE4oxSKNePOynTbdD8xmuaKQeireInZaVhXggJseAzBzQGyJ9a7bESEkHQYGl
	jOz4Sk8QZHA3YQnSRIVK7HcS716rowbVjIZGcoFxsbvgYJ36/12jfzh/zcjtAquRIYY2/1j5rub
	JGsopJkICYW0Yjfvu01nGY25H2cIyam/9YEX48eQWMhCZirIignTsiNFZqQZbvwhLr2evWRgE+m
	B1sEZMGyftm94pBKrqecWAhfmQ4+dJwj2Fgl2
X-Received: by 2002:aa7:d80f:0:b0:6a6:6ded:b4b6 with SMTP id
 4fb4d7f45d1cf-6b42032007bmr60520a12.13.1792689362023; Thu, 22 Oct 2026
 10:16:02 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260310060022.15120-1-manali.shukla@amd.com> <20260310060022.15120-5-manali.shukla@amd.com>
 <20261008175928.732268-1-jmattson@google.com> <a3eee649-0719-46d7-bd82-4dbdb1c98c8b@amd.com>
In-Reply-To: <a3eee649-0719-46d7-bd82-4dbdb1c98c8b@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 22 Oct 2026 10:15:49 -0700
X-Gm-Features: AclHuK-95CgjFtiyDe_Sdh0Xkn6b-26MsKY7c1Vl2_cpxsdC_uh3FOAcmguLPK8
Message-ID: <CALMp9eSAkO+JP=bir6zw4jOLUJba2Bh2hb_9ghD2AzJ-uN7nbQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] KVM: x86: Extend CPUID range to include new leaf
To: Manali Shukla <manali.shukla@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, mingo@redhat.com, bp@alien8.de, 
	kvm@vger.kernel.org, x86@kernel.org, santosh.shukla@amd.com, 
	nikunj.dadhania@amd.com, Naveen.Rao@amd.com, dapeng1.mi@linux.intel.com, 
	ravi.bangoria@amd.com, peterz@infradead.org, Sandipan.Das@amd.com, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 5:00=E2=80=AFAM Manali Shukla <manali.shukla@amd.co=
m> wrote:
>
> On 10/8/2026 11:29 PM, Jim Mattson wrote:
> > On Tue, Mar 10, 2026 at 06:00:16AM +0000, Manali Shukla wrote:
> >> CPUID leaf 0x8000001b (EAX) provides information about Instruction-Bas=
ed
> >> sampling capabilities on AMD Platforms. Add the new leaf to
> >> kvm_cpu_cap_init() using F() macros, which automatically gate each
> >> capability bits against raw hardware CPUID via raw_cpuid_get().
> >>
> >> This allows vendor code to simply clear entire leaf when vibs is not
> >> enabled, rather than reading hardware CPUID and calling
> >> kvm_cpu_cap_set() for each capability bits inidividually in later
> >> patches.
> >>
> >> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> >
> > The shortlog is not accurate. The CPUID range does not change; case
> > 0x80000000 already limits the maximum extended leaf to 0x80000022, whic=
h
> > includes 0x8000001B. Before this patch, leaf 0x8000001B went to the def=
ault
> > case, which returns all zeros. This patch adds KVM's supported bits for=
 the
> > leaf and a case that reports them when X86_FEATURE_IBS is supported. Pl=
ease
> > change the shortlog to say that.
> >
>
> Agreed. I will change the shortlog
>
> Probably something like this ?
> KVM: x86: Report supported IBS capabilities in CPUID 0x8000001B

Sounds good.

Thanks.
