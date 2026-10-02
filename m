Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E0D1CD2C
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790902450; cv=none; b=QaqYQ3T9zHhYYKwHMFojIZNF+K+dkCj26y1aMt7R0b8wxzX1R1uvuoZIrm4hP4Oj2E2Fo6NAQXf93Yw181HVlbvsgc4FrGTru0m2D2StcaYVYYPyyk9HBJNKVEuKd4Qop+nZse+pd/6itlstnXc1t6Jlt8soEBTxDnWf7dY1Gzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790902450; c=relaxed/simple;
	bh=EksX2CqolBGHByNdilkmlYYBx7edCAC4X01VmTEIdcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RltCBhoBV+EEz5dSDp+/0Injhift1DfKrS1AMedk8wp/IFhEfGcjEbmUw+hQ/NohmF1TayKBESzn2jHfb4gNnsxlMLFm2mlYVLTQh+M0qGscz1dlart+K7UIvYNAU2/8Ay5ZiFxqwB/SeeST36Yl4tiucT5yHvGWzSh5/zKkLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4XU0dzH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmY+kSH5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4XU0dzH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmY+kSH5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790902448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIuUoxFqAzBRNm/KfmC9YauHU6KyCv+jklWR5oFxcwk=;
	b=S4XU0dzH6y2l46YDVPgFMOv7t9YAAKd8sD+dcjriVdGPPYAvF7LDQa9KzvHgCc06BiVtuN
	I1KLkSvNcBNERo4zD7fw9hvqMNG2PlBG9A+Vaf0x3JKo5p/GJq3wm+8dVknhldUzxuguaz
	TNOvi/gcM14y1z3x7Rq22zMtVClUy8w=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-gwvp2Tn2PsOSjLO2cMpqHA-1; Thu, 01 Oct 2026 20:54:06 -0400
X-MC-Unique: gwvp2Tn2PsOSjLO2cMpqHA-1
X-Mimecast-MFC-AGG-ID: gwvp2Tn2PsOSjLO2cMpqHA_1790902446
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a46f0f158dso1644377a91.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 17:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790902445; x=1791507245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UIuUoxFqAzBRNm/KfmC9YauHU6KyCv+jklWR5oFxcwk=;
        b=SmY+kSH5D7NmZNYpne7+1q/bwzT8ChefXqIztIsYf0RezYTGv7JslMh9iyIpVlP4SS
         ld/D2PcK4zrRhYUuzZsON6Ug0Tjwcoeq8hruAjCE89taacSjyr+ROCswiOMsKr58mbav
         eNj+ydXgNImysOmXKQhHi/WYKAk7+JnSJs/sE31JvvP5WGjY59M69f+sbzYCjRUsIJD+
         IPJNHK0a7BqnV9g9lteXXShYNK0Q7Kxw5OOAtKL0IPGPo1gLJNlF0nntbVxF7rwfTKkH
         niE+431WZ317pjdRCcqyhuMvYkLiTfd8OGGch2x/O+dMCWhpgR6QU0zZdxzFNgo05CUm
         1gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790902445; x=1791507245;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UIuUoxFqAzBRNm/KfmC9YauHU6KyCv+jklWR5oFxcwk=;
        b=xNnnCKt1b633N0ewQczxUvmS7eayWp5yzefpxyO6ReMzFg52tTpbjpHipLAv5btFJw
         c3o7mVscT+6aOECnSsAhEidwdOt6zun8AwfO0pX2tXMGLkc2SloFcc3QDzZ/fzjlaiRm
         j9tBNRvzD6KrudnQ4J3J/99MhUll8V5I9LoOR60571VC9aX3rsjDX4UtaX3EdiHT7awT
         JQjZI7HljeIb4Cs5nswHTBcsBImU4hKCmfsRd2gYG4VzoX4icl+xG7zSKnbbDoO57zDi
         XrahHoIy/+pZZhLtZlJVO+bOkKswIzzpRcE/2i39sgBczwLQfinn5tKB5vz/d+PFNWDJ
         RrFw==
X-Forwarded-Encrypted: i=1; AKwUvBy+mJ4RdSDmj+egoosD6PLjj45TYQNYLs5zECJkxf/gBaWUMPrkhxMgcya3UT9dxUyECJY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOemGOBhBNUuiixHAUnXTpgnrxbuV6L0SMUxqfHOO4b1466nRU
	HcHTFtg7yqAEoTlh18Sjd49tQN9NNRGpFIZ1Ri3nL0V7e5W6OD0Y0Xr8p0K0+C5CN6+Pa0bfZmm
	ZuyzgQ8Ze8OvGTWpHd1/9nExXcUz/3X0bzgyzLPxLxNhAmGhm1tMPjQ==
X-Gm-Gg: AYBFou0XpooO0i7QkQ4y1PgjIX9R4n6vXR0gCZRg8vq5BIbuPYi9QjSTr5Q12bYP6SZ
	yOTLvumEw7N5+saDJ/j/0HYeUIkwLA9YutFunDZvzSNiweMmnn9snQDiq4E2TidmuXZFO7tdVLH
	sHqrSq2zwD10mXcDRWrNzYk17N1a6FTEQtgyngyVP/1IJI7NcT0hEKWzmBhVdeqj9g6lJ9S4NWk
	PKf8H5M3bgF76V4qoqvZCV8zhriNJecHf/KChLIZepFL1YYGXtUv3Qhe6GRs8S4QjsuSCb5nJkS
	o9orEGoPNRJypSgU2EBdRP0/0d8nHHTKuujAWzBVl/N1GnZw7l/y0DbDRj9mZj0bxfzFzOdxUIu
	RrtJbE7gOpQb4nU+dqMGWrkBnVBozS6GEEuXuXsIXoQ==
X-Received: by 2002:a17:90b:1c82:b0:3a0:c85a:ee12 with SMTP id 98e67ed59e1d1-3a6cec91c89mr805472a91.41.1790902445364;
        Thu, 01 Oct 2026 17:54:05 -0700 (PDT)
X-Received: by 2002:a17:90b:1c82:b0:3a0:c85a:ee12 with SMTP id 98e67ed59e1d1-3a6cec91c89mr805451a91.41.1790902444814;
        Thu, 01 Oct 2026 17:54:04 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f4709a7csm6448906a91.8.2026.10.01.17.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 17:54:04 -0700 (PDT)
Message-ID: <a3a01282-bf89-46b8-b15c-9dc5f93053ee@redhat.com>
Date: Fri, 2 Oct 2026 10:53:58 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 06/24] target/arm/kvm-rme: Initialize vCPU
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-7-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-7-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> The target code calls kvm_arm_vcpu_init() to mark the vCPU as part of a
> Realm. For a Realm vCPU, only x0-x7 can be set at runtime. Before boot,
> the PC can also be set, and is ignored at runtime. KVM also accepts a
> few system register changes during initial configuration, as returned by
> KVM_GET_REG_LIST.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/cpu.h      |  3 +++
>   target/arm/kvm-rme.c  |  9 ++++++++
>   target/arm/kvm-stub.c |  5 ++++
>   target/arm/kvm.c      | 54 +++++++++++++++++++++++++++++++++++++++++--
>   target/arm/kvm_arm.h  | 10 ++++++++
>   5 files changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e3f931dba26b..6bbc942f9a59 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1054,6 +1054,9 @@ struct ArchCPU {
>       /* KVM steal time */
>       OnOffAuto kvm_steal_time;
>   
> +    /* Realm Management Extension */
> +    bool kvm_rme;
> +

This field seems redundant to MachineState::cgs since all vCPUs support RME
(Realm Management Extension) when MachineState::cgs points a valid instance.
So I'm wandering why we need to maintain the redundant information here?

>       /* Uniprocessor system with MP extensions */
>       bool mp_is_up;
>   
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index a4a5e195c196..f7c2cc786e2c 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -69,6 +69,15 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
>       return 0;
>   }
>   
> +void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
> +{
> +    if (!rme_guest) {
> +        return;
> +    }
> +
> +    cpu->kvm_rme = true;
> +}
> +

This could be simplified to:

       cpu->kvm_rme = !!rme_guest;

>   static void rme_guest_class_init(ObjectClass *oc, const void *data)
>   {
>       ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index 88cbe8d85c41..5fde96f9b281 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -119,3 +119,8 @@ char *kvm_print_register_name(uint64_t regidx)
>   {
>       g_assert_not_reached();
>   }
> +
> +void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 33c3763aebfa..b4c6da1fb9f3 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2015,6 +2015,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>           cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
>       }
>   
> +    kvm_arm_rme_vcpu_init(cpu);
> +
>       /* Do KVM_ARM_VCPU_INIT ioctl */
>       ret = kvm_arm_vcpu_init(cpu);
>       if (ret) {
> @@ -2169,6 +2171,29 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
>       return 0;
>   }
>   
> +static int kvm_arm_rme_put_core_regs(CPUState *cs, Error **errp)
> +{
> +    int i, ret;
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +    /* The RME ABI only allows us to set 8 GPRs and the PC */
> +    for (i = 0; i < 8; i++) {
> +        ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
> +                              &env->xregs[i]);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
> +    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.pc), &env->pc);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
>   static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
>   {
>       uint64_t val;
> @@ -2280,7 +2305,11 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>       int ret;
>       ARMCPU *cpu = ARM_CPU(cs);
>   
> -    ret = kvm_arm_put_core_regs(cs, errp);
> +    if (cpu->kvm_rme) {
> +        ret = kvm_arm_rme_put_core_regs(cs, errp);
> +    } else {
> +        ret = kvm_arm_put_core_regs(cs, errp);
> +    }
>       if (ret) {
>           return ret;
>       }
> @@ -2367,6 +2396,23 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
>       return 0;
>   }
>   
> +static int kvm_arm_rme_get_core_regs(CPUState *cs, Error **errp)
> +{
> +    int i, ret;
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +    for (i = 0; i < 8; i++) {
> +        ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
> +                              &env->xregs[i]);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>   static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
>   {
>       uint64_t val;
> @@ -2478,7 +2524,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>       int ret;
>       ARMCPU *cpu = ARM_CPU(cs);
>   
> -    ret = kvm_arm_get_core_regs(cs, errp);
> +    if (cpu->kvm_rme) {
> +        ret = kvm_arm_rme_get_core_regs(cs, errp);
> +    } else {
> +        ret = kvm_arm_get_core_regs(cs, errp);
> +    }
>       if (ret) {
>           return ret;
>       }
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index e7c40fb003e4..d95381c13afa 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -240,4 +240,14 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
>    */
>   char *kvm_print_register_name(uint64_t regidx);
>   
> +/**
> + * kvm_arm_rme_vcpu_init
> + * @cs: the CPU
> + *
> + * If the user requested a Realm, setup the given vCPU accordingly. Realm vCPUs
> + * behave a little differently, for example most of their register state is
> + * hidden from the host.
> + */
> +void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
> +

The comments here look outdated. This function simply set ARMCPU::kvm_rme to indicate
RME should be supported for this given vCPU. So the comments would be something as
below.

     /*
      *
      * Mark that RME (Realm Management Extension) should be supported for the given
      * vCPU if user has requested it. Realm vCPUs behave a little differently, for
      * example most of their register states are confidential and invisible to us.
      */

>   #endif

Thanks,
Gavin

