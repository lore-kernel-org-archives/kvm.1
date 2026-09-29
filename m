Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B34D7978
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716866; cv=none; b=nbD5JXEaXcExVdHl2A9Q5rHa+E6F014ES8YqOpC9Umo51MlOempxlJ8dSivaVpEoRJO00k+0qm0m1lNIJQEWtmpsvgIUZ7T0ALdcdZdAS40zOP6baaVmug91ROoemC+MmiW+92fTBFVsSyqxbE9/ouL9X6/EfrX/IZvIfv6mw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716866; c=relaxed/simple;
	bh=6BHhuneI2m6PepV2hBBz3P939R94zEXTyStwRvRBf9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tgsX0+OlRsT/c1xKF1tKhyGAzRLW2k7qCgRGIitGSYI91j5K6bXeYPzyw/CUCLMMb8RLfjxxKvchhCZb5qQHJW75cpSzdhSSmkq1if+lkDT7DU/gWHYjwvDTPzZrL6+qdDYb/uqONEoA8L4dGY/59b+drY4070/6z1xlYAh+4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RIptGPmg; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RIptGPmg"
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4c467e19391so9282901b6e.3
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790716863; x=1791321663; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lDp8WWU/0UlLYBNjAv5MLJXqSdTj0yxp/bLRhzLI/Qc=;
        b=RIptGPmgAVFHukpII5hEjnHUuQMm81z0m8PsEVWz6cA+ri/hwBGpBp1oUjYx5PoyqP
         datHX1ow4zdef4a5m9Jogm8HEhNsCIEhV5o+7OI9uN+mQPNwRV+5scFpOuD6CTY5AkkA
         SjXGql50LLNL3Smg4JpJhaPDQSVaqfrjv22oN35NQPTT14WeTsXApNA44sntqyz/SWDb
         MYTcaS9kY9FDuv0wOAHh/dwDpl3h1NC8F1RI+ZHY2N7zI86H5Qa285JOU7FlqCdUnoHl
         rYiLADHE/+xtgQ1eoVbtbzwuH/kj4mdfBD3NgzYuxc/9B0TFYwOjWQleJe0WNBEHBU+/
         bksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790716863; x=1791321663;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lDp8WWU/0UlLYBNjAv5MLJXqSdTj0yxp/bLRhzLI/Qc=;
        b=aesERGqSZWAr2/71krfp6oDnkqAGkAFgVCQ2W4wDuV/Gf0OVHRqjzxQ05xbqRgEzMi
         Fo/EfL8+dMBoF68J984LOffgdVK+ZkQC3bvbXkTrqZ6kR/3kty0r9NFyg7BimTBmM7ms
         mfarqG9REbu/ih9QB1AAv8ibMDzZG0O9qfdqhtf+6F2qxOMylHE7zGbnHjvSGVUU6UtR
         PnMDMKg0MYXEw+JeQzJGNDLP8MknTjdUCddPbE4Efe3mXZDu5WI5BBcneJ1kW/JVeINa
         pXMavAUbomuTcIBcIuZcPjxsujseLqOSSvr4Hf5hTsjxV743SLUr2BobE7Oshu3q3ndp
         EKoA==
X-Forwarded-Encrypted: i=1; AKwUvBxUomJTUaLiYTLQbeueasRmzY/T7V+kDnqFbdR7bZzrk43s42S6phDkL/a2fuzSkMFF+cc=@vger.kernel.org
X-Gm-Message-State: AFuF++nMzCrUJ/n4Uwh3cCwpFQhyscVn+MkQxZIPR6CKA1J2v3JQtw9K
	5DU5T+Ufj2UuwJauWiTLwKJAlTpMwYg7em046UPwXjxszyNk5GOCLd70KFo5CXT0mGmHn9WNoZF
	9eOudWA2uzcyBYUf8rcP0O8kvgw==
X-Received: from ioia10.prod.google.com ([2002:a05:6602:888a:b0:9c4:b6b4:bf53])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f21:b0:4bc:336d:7494 with SMTP id 5614622812f47-4f0751c3a87mr763966b6e.30.1790716862759;
 Tue, 29 Sep 2026 14:21:02 -0700 (PDT)
Date: Tue, 29 Sep 2026 21:21:02 +0000
In-Reply-To: <CAFEAcA9Rwrffx8bYiOxrtQGdg31QAz1oBm8okzpfqHZ6yK0Y7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
 <20260924173051.2117637-1-coltonlewis@google.com> <CAFEAcA9Rwrffx8bYiOxrtQGdg31QAz1oBm8okzpfqHZ6yK0Y7A@mail.gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929212102.3659389-1-coltonlewis@google.com>
Subject: Re: [PATCH] target/arm: Enable KVM PMU partitioning and counter limit
From: Colton Lewis <coltonlewis@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Colton Lewis <coltonlewis@google.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
	kvmarm@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mingwei Zhang <mizhang@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

Thanks for reviewing!

On Mon, Sep 28, 2026 at 03:01:32PM +0100, Peter Maydell wrote:
> FYI for next time around, QEMU patches that depend on not-yet-accepted
> kernel ABI changes should be tagged RFC, please.

Ack, sorry about that. I will tag future versions with RFC until the
kernel uAPI is accepted.

> > ---
> >  target/arm/cpu.c | 20 ++++++++++++++++++++
> >  target/arm/cpu.h |  4 ++++
> >  target/arm/kvm.c | 32 ++++++++++++++++++++++++++++++++
>
> New CPU properties should be documented in docs/system/arm/cpu-features.rst .

Will document them there in the next revision.

> > +static bool arm_get_pmu_partition(Object *obj, Error **errp)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +
> > +    return cpu->kvm_pmu_partition;
> > +}
> > +
> > +static void arm_set_pmu_partition(Object *obj, bool value, Error **errp)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +
> > +    cpu->kvm_pmu_partition = value;
> > +}
>
> If your getter/setter are only updating the struct field,
> you can use a DEFINE_PROP_BOOL to avoid having to have them
> (compare arm_cpu_has_el2_property etc.)

Thanks, I will switch to DEFINE_PROP_BOOL.

> >      if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
> >          cpu->has_pmu = true;
> >          object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
> > +        object_property_add_bool(obj, "pmu-partition",
> > +                                 arm_get_pmu_partition,
> > +                                 arm_set_pmu_partition);
> > +        object_property_add_uint32_ptr(obj, "pmu-num-counters",
> > +                                       &cpu->kvm_pmu_nr_counters,
> > +                                       OBJ_PROP_FLAG_READWRITE);
>
> What should we do with these properties if we're not using KVM
> (i.e. for TCG, hvf, etc) ?

PMU partitioning is specific to KVM, so moving it into
kvm_arm_add_vcpu_properties() (which is only called when kvm_enabled())
and naming it "kvm-pmu-partition" per the KVM VCPU Features convention
in docs/system/arm/cpu-features.rst seems to make the most sense.

For the counter limit property, would you prefer that it also live in
kvm_arm_add_vcpu_properties() as "kvm-pmu-num-counters" (KVM-only), or
keep "pmu-num-counters" general so TCG can also use it to override
PMCR_EL0.N in reset_pmcr_el0?

Thanks,
Colton
