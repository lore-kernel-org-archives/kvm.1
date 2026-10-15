Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610A4595720
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096202; cv=none; b=NJW0Fi7qxt8/6p1MQ3EfMLidRTkdF1KwYsKC45riAt0IOVDFoaqZBIgLFmNnIS/41pN4x73n/AyD0PEhNkS/1qMnDMsmpKpnvRS4ewbSGqwJ8xADgycePSQD9+nCBKjNXhGx4BPmw/AApJYXl2W+xdqnSP8lg2HRsgKkscJ/XGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096202; c=relaxed/simple;
	bh=AnWvkEZB0Mh2hR655+wFEh0edlqzTPt9eZGsVBC3sIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVOWFTbMt8lhf/JO3px/uQlqdY0Du0cBnNPqshYO5ZJf+IeKm3FGk+tE6njJguPX4YZ0LIR6HZnSA4JFe/paJqcoUAez+m2G082ZhIVrIPljbT4nBdR2/ASImd30YU1Ekx8kR0b5H8TNlFYUTZSL67xYwgUMg3QFFTu8NCfQ6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=maHPPjwP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="maHPPjwP"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab41538192so4060493a91.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792096200; x=1792701000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hC1vzj0wb9nSvP5dG5VN3FVLkN5u4HFXb/F44tEkOzY=;
        b=maHPPjwPyI8uwRQgVAuwUbr3jz5qy/FjgG9BV1iGvyiXIocEraFM66K1wvlJI4CkPR
         iocFYlAlxWQDm6wDAl9bB2WBHUGfQLRo6I/cZ3tDeg3frQf28oJi+LsqSIQB0xlzipaf
         +0mJRqYqTcYDbZ5ugWS7GQBZztVVJDuxWJQ8YlInEXn4WzlQ5wmoBf8kvdvFBOQSyc5A
         cOsawJYJQC+2Fp06UDmKjG7vCv5IglbHKgQF99ukigUgO1ZC5GB9ymXb67IpC6znZEr0
         vINJQ6X0YFoZ2n955/Y0NYS9ilCunHiW+EH0On+wZ8UACSSvAHonL4TU0/hLxKALVSn7
         Novg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792096200; x=1792701000;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hC1vzj0wb9nSvP5dG5VN3FVLkN5u4HFXb/F44tEkOzY=;
        b=cLakYKUeHufkQa7cg9PqJSaYtsUQRiinMbTSwygw7iUCbHzdt0t5IpT1wpHa6Hn2ro
         2Z3xpLHgs7Xde5UQf502gyMW+pcmQU6sn56zIfBW6rDrAFoBxUFuFlRwMhibADlV90OO
         GZKdk3V2UxetcfqC7S0oYtC3dYtyuaU0STaRUsTyvITaOnCi6lVlxAbgxx/vWKhfIjtx
         0iok5NZVIfrCiq6S5EIG3t9joUOlkLf5aOhbC83q6QiYWeHnY2to2+ubMXyjqeB1Z3gj
         gpkNTvIKcpYjWTzlejx4tEXTvN2H3WK339FMWa0EWeQ4jbf4EAkBNZ5qf0KlWxaKuy94
         xEoA==
X-Forwarded-Encrypted: i=1; AKwUvBzB7JH2S9a3qvOqobUuvXXxAYNRgmVtZVi9EXcl0tJ+i7uK2MPy1v7jMX7eev2owx3R3sE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBDuKc/THSSiperGy+xkSupg6dV8eiu6rQT+kYnRBS5pqH7+IU
	CymzSX0kCEPmUmzJnisJipOIK3Bd0CrJ5AaiLPMdA1Z3ZDiGBiGsPvevzfl+nYHco6M=
X-Gm-Gg: AYBFou2NC64dstGuDmCkoeEyi66QrSdjJ/eNJQGhfjZBL4XIJZCKDKc40pKr98peSGc
	Pi867eDj1Zrz7X7QEs70EGLabjqRo3AWCvSeNllLGkCInxwM2ddB7phEDPcnYX/WkSglizZxJw6
	a3SL2Nt4anrgHkiANhVw3ZnXiNFHrRJklr9h2M5B6b2v59Dak44+JHoXv+v/rnWqiKGPUn85KhF
	XlC8+icXmGPXxT0jx9Qr6wxlybrcDs5tbjJ3mW23qZBac+9tr9t/Ek79VxH46FirRrkSc0jpgob
	nv/Q0cNmAY5ENWwZv3N1otiA2aF8luGIT3WcSA9FfFYzHTBvtxFMpo6n6uvg766WYDu1stVgndT
	FMcgsciY7V7Grf2Cg+JdaCC6pAR5M9jGHCyJEMl7a7q/YdK3px8jHmYsyaEaxzNfEl8zK+2Cl0+
	uS5KB7WwQujN+szZpTcx9pNdC7iPhh92w8TMFn9FQz6fyzDs8qc10n44JVNcO/9lvoCqZN2Y/d2
	hOtiWW00702
X-Received: by 2002:a17:90b:5805:b0:3ac:8446:c1b5 with SMTP id 98e67ed59e1d1-3ac8446c284mr4303030a91.31.1792096200290;
        Thu, 15 Oct 2026 13:30:00 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:48ff:8de9:17ca:1542])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc38b457esm846312a91.0.2026.10.15.13.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:29:59 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:29:57 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v4 06/24] target/arm/kvm-rme: Initialize vCPU
Message-ID: <atE3xY22XqMkaEJG@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-7-mathieu.poirier@linaro.org>
 <a3a01282-bf89-46b8-b15c-9dc5f93053ee@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a01282-bf89-46b8-b15c-9dc5f93053ee@redhat.com>

On Fri, Oct 02, 2026 at 10:53:58AM +1000, Gavin Shan wrote:
> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > The target code calls kvm_arm_vcpu_init() to mark the vCPU as part of a
> > Realm. For a Realm vCPU, only x0-x7 can be set at runtime. Before boot,
> > the PC can also be set, and is ignored at runtime. KVM also accepts a
> > few system register changes during initial configuration, as returned by
> > KVM_GET_REG_LIST.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/cpu.h      |  3 +++
> >   target/arm/kvm-rme.c  |  9 ++++++++
> >   target/arm/kvm-stub.c |  5 ++++
> >   target/arm/kvm.c      | 54 +++++++++++++++++++++++++++++++++++++++++--
> >   target/arm/kvm_arm.h  | 10 ++++++++
> >   5 files changed, 79 insertions(+), 2 deletions(-)
> > 
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index e3f931dba26b..6bbc942f9a59 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -1054,6 +1054,9 @@ struct ArchCPU {
> >       /* KVM steal time */
> >       OnOffAuto kvm_steal_time;
> > +    /* Realm Management Extension */
> > +    bool kvm_rme;
> > +
> 
> This field seems redundant to MachineState::cgs since all vCPUs support RME
> (Realm Management Extension) when MachineState::cgs points a valid instance.
> So I'm wandering why we need to maintain the redundant information here?
>

It is redundant, at least at this time.  I have removed it in favour of
MACHINE(qdev_get_machine())->cgs where cpu->kvm_rme was used.  With that it was
possible to get rid of function kvm_arm_rme_vcpu_init().
 
> >       /* Uniprocessor system with MP extensions */
> >       bool mp_is_up;
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index a4a5e195c196..f7c2cc786e2c 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -69,6 +69,15 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
> >       return 0;
> >   }
> > +void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
> > +{
> > +    if (!rme_guest) {
> > +        return;
> > +    }
> > +
> > +    cpu->kvm_rme = true;
> > +}
> > +
> 
> This could be simplified to:
> 
>       cpu->kvm_rme = !!rme_guest;
> 
> >   static void rme_guest_class_init(ObjectClass *oc, const void *data)
> >   {
> >       ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
> > diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> > index 88cbe8d85c41..5fde96f9b281 100644
> > --- a/target/arm/kvm-stub.c
> > +++ b/target/arm/kvm-stub.c
> > @@ -119,3 +119,8 @@ char *kvm_print_register_name(uint64_t regidx)
> >   {
> >       g_assert_not_reached();
> >   }
> > +
> > +void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
> > +{
> > +    g_assert_not_reached();
> > +}
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 33c3763aebfa..b4c6da1fb9f3 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -2015,6 +2015,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >           cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
> >       }
> > +    kvm_arm_rme_vcpu_init(cpu);
> > +
> >       /* Do KVM_ARM_VCPU_INIT ioctl */
> >       ret = kvm_arm_vcpu_init(cpu);
> >       if (ret) {
> > @@ -2169,6 +2171,29 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
> >       return 0;
> >   }
> > +static int kvm_arm_rme_put_core_regs(CPUState *cs, Error **errp)
> > +{
> > +    int i, ret;
> > +    ARMCPU *cpu = ARM_CPU(cs);
> > +    CPUARMState *env = &cpu->env;
> > +
> > +    /* The RME ABI only allows us to set 8 GPRs and the PC */
> > +    for (i = 0; i < 8; i++) {
> > +        ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
> > +                              &env->xregs[i]);
> > +        if (ret) {
> > +            return ret;
> > +        }
> > +    }
> > +
> > +    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.pc), &env->pc);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >   static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
> >   {
> >       uint64_t val;
> > @@ -2280,7 +2305,11 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
> >       int ret;
> >       ARMCPU *cpu = ARM_CPU(cs);
> > -    ret = kvm_arm_put_core_regs(cs, errp);
> > +    if (cpu->kvm_rme) {
> > +        ret = kvm_arm_rme_put_core_regs(cs, errp);
> > +    } else {
> > +        ret = kvm_arm_put_core_regs(cs, errp);
> > +    }
> >       if (ret) {
> >           return ret;
> >       }
> > @@ -2367,6 +2396,23 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
> >       return 0;
> >   }
> > +static int kvm_arm_rme_get_core_regs(CPUState *cs, Error **errp)
> > +{
> > +    int i, ret;
> > +    ARMCPU *cpu = ARM_CPU(cs);
> > +    CPUARMState *env = &cpu->env;
> > +
> > +    for (i = 0; i < 8; i++) {
> > +        ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
> > +                              &env->xregs[i]);
> > +        if (ret) {
> > +            return ret;
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >   static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
> >   {
> >       uint64_t val;
> > @@ -2478,7 +2524,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
> >       int ret;
> >       ARMCPU *cpu = ARM_CPU(cs);
> > -    ret = kvm_arm_get_core_regs(cs, errp);
> > +    if (cpu->kvm_rme) {
> > +        ret = kvm_arm_rme_get_core_regs(cs, errp);
> > +    } else {
> > +        ret = kvm_arm_get_core_regs(cs, errp);
> > +    }
> >       if (ret) {
> >           return ret;
> >       }
> > diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> > index e7c40fb003e4..d95381c13afa 100644
> > --- a/target/arm/kvm_arm.h
> > +++ b/target/arm/kvm_arm.h
> > @@ -240,4 +240,14 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
> >    */
> >   char *kvm_print_register_name(uint64_t regidx);
> > +/**
> > + * kvm_arm_rme_vcpu_init
> > + * @cs: the CPU
> > + *
> > + * If the user requested a Realm, setup the given vCPU accordingly. Realm vCPUs
> > + * behave a little differently, for example most of their register state is
> > + * hidden from the host.
> > + */
> > +void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
> > +
> 
> The comments here look outdated. This function simply set ARMCPU::kvm_rme to indicate
> RME should be supported for this given vCPU. So the comments would be something as
> below.
> 
>     /*
>      *
>      * Mark that RME (Realm Management Extension) should be supported for the given
>      * vCPU if user has requested it. Realm vCPUs behave a little differently, for
>      * example most of their register states are confidential and invisible to us.
>      */
> 
> >   #endif
> 
> Thanks,
> Gavin
> 
