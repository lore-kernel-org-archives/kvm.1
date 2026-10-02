Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCBA326939
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 04:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914000; cv=none; b=IPPFeyJx1mmAEKpWA9/H0xz4Ey0/4/PzTO22nxXYTeACjaR5XFi50E6ocJdtRpdXVl84rAIVRnQe7PgGLMfsX0KiNleT/Sn3bEcl4Nt8VQZxKfJjP8qY0RwsZXeP3VgQ36hidD3JgqYwXulJjhfnQVH3hPArUgB4eQHqkrueHVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914000; c=relaxed/simple;
	bh=wZY/xGOox8yPgwlKZ5T7149KrXcOX7xFvW3irzmjDDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJd/Zd3WDD8bVUa7uaDcvYShWYcHz9FcvgWQrNVO0qhqRnLjHGfZOp24fEW0h/vUduJULihUzRGShsgDaaJ1u7DRpF167ANJRzozsCjFRaIbIP/nOCzZ9lbI4ZHRitVnQbfwmYnNAC/c9aEi1HGEkHYhnTflhdD87SLRPl0HKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OL1f1mKX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MP0u2tvB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL1f1mKX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP0u2tvB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790913995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gs7YJR2mPXTbKCewLFBLQH9fuzpBXhw+3Y9+5ECj960=;
	b=OL1f1mKXOKO7OGHFaYqGJHBHxmerEfa6tl9bzOonyoeTV1JIdlHwU0bdzOhIkXUpVU7QLI
	y+9EHLOZMzr7ncgRGJxybRhZ+wvnOoEN1vG7eNCKMYGR9jJ9UAIvxDbsC8X+N7sktp2t7P
	14SjP61LVsZnu2CWvo6KKV7jz1xb7dU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-zkROgFYYNtaOBVrpQC3_PA-1; Fri, 02 Oct 2026 00:06:34 -0400
X-MC-Unique: zkROgFYYNtaOBVrpQC3_PA-1
X-Mimecast-MFC-AGG-ID: zkROgFYYNtaOBVrpQC3_PA_1790913991
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39512608fb1so11462881a91.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 21:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790913991; x=1791518791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gs7YJR2mPXTbKCewLFBLQH9fuzpBXhw+3Y9+5ECj960=;
        b=MP0u2tvB6yon2dz+mYGV1cCW6+LG49lsctXfs8G34Fo0+k+ul38z3cpIT2gv1YwvXx
         Y65ptwdM9rEj5Z032Z449znnS6ruNq76UfsiKHaPtFVfqeCjLmfP+BSVCZdjcMAOvnT/
         2amKFewBnGywPNzR1/fFv9QVKX8l0LjrYPksYhxtMQjYbaxSUDxOIhaO4bHcUm4TcRwC
         141VmoKf1subapG7MXQ8m4sFNovEofHFcDuy0z3ZfRCT2poJkmceIK/p02HxADv2TqQu
         fp/gWCJ2cmGuNPcIg1Xd1j4RiKqLNqAmWKVnb5RTeMLSkFIt8p8K30AJgqdmTPkE6WoY
         44xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790913991; x=1791518791;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gs7YJR2mPXTbKCewLFBLQH9fuzpBXhw+3Y9+5ECj960=;
        b=WW/I6lW/FI60kqICY64I5X7TFYJ6lZsBbWu5qPkk7xXzdHXuwoKYdCMKJXBT2UveAK
         T8pCB+klO05tP4w4Ju9ZPEmItc6AErRuqWC7wVo3/LsjJFEm3KwBIBselkglpQ0vwmeP
         XJwQctYiyK18jJU564o5ww3vi/ZG02AZLp9D5/Uzhcmj7pSkMiez05CjTr29FwlFPfcx
         mbnZNXTPXM5E3FZ/CaZaN4JuXAGc5DeEiK8q2QL5jYAj2a8aN2Pv1KOkiOJDOdbpi9xT
         Az8Hi/PAUJxZWo7nI2XnrvV2cst8Y+UncHiuxlweHJhm20kJEtIbVtkXFnitKyn5brLf
         piwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwV76leDgSSfwSBBs1S5b6/FjNdmuZuodb66g6ecMz9hh4TwIOFIJbErwvngqXPESKjtR4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLd+K6cu8KU4f8MjfJ+2uU/O6wqeXFjDSt46o7Qr+SBHb0HueXV
	Ux8CGOnQ753GCgjibkRTNnMUx6OF3TlgQPqXL6xy0OH4eRAGvdHAK9LdCbn93ZuVRVbbibUMP6D
	xb3IYa6+MtuFKV/eMLAsnxBWz183CmoBm/4KIbz+rnApteOIcSOOmDw==
X-Gm-Gg: AYBFou0wbfeynrUQPkQ9IP3Wh6TPADZ8zBSIZ5VD2e0gF+7wXp1bY5MHESZHI55enJ4
	hJMR+Z/tgquqsF+frscHXS6/Tv8jJEaVt5IcYJCxpGhpWYelQS89MOmlN7vzFE6CTd+CcwRpK2E
	BEcssgVY5t0MhJKgxNtFs5vE/6szHNi5v3Y8ucoF17SU885wkWJcbZWyT1daqE+1wpd5r9pVTrZ
	CDWVIJFOaFMwbBKYI/Az/OmYJU6bB1xjlT+cQZ2YsrvOzt2i0g9nBTgGruz7/mRVVZlpyRF0Fd1
	rbYLCL4U7pnh5k7KP42C4quNy0JpMTv1k4D8IqAZagl7rZWzG3q8Ad9cT6fQVTxYz6V0qL2ZGiE
	REq6mV4rizXe1V4/klq7noUZfFhXVbD3RkdPZmHqmaA==
X-Received: by 2002:a17:90b:1c12:b0:3a0:4444:ef1e with SMTP id 98e67ed59e1d1-3a6ceaeb09amr1510013a91.29.1790913991217;
        Thu, 01 Oct 2026 21:06:31 -0700 (PDT)
X-Received: by 2002:a17:90b:1c12:b0:3a0:4444:ef1e with SMTP id 98e67ed59e1d1-3a6ceaeb09amr1509996a91.29.1790913990647;
        Thu, 01 Oct 2026 21:06:30 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6cd5dc4e7sm2120673a91.11.2026.10.01.21.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 21:06:30 -0700 (PDT)
Message-ID: <eda8ee8f-5f17-4144-b21e-b1d990ee3270@redhat.com>
Date: Fri, 2 Oct 2026 14:06:24 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 12/24] target/arm/cpu: Set number of breakpoints and
 watchpoints in KVM
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-13-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-13-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Add "num-breakpoints" and "num-watchpoints" CPU parameters to configure
> the debug features that KVM presents to the guest. The KVM vCPU
> configuration is modified by calling SET_ONE_REG on the ID register.
> 
> This is needed for Realm VMs, whose parameters include breakpoints and
> watchpoints, and influence the Realm Initial Measurement.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/arm-qmp-cmds.c |  1 +
>   target/arm/cpu.h          |  4 ++
>   target/arm/cpu64.c        | 81 +++++++++++++++++++++++++++++++++++++++
>   target/arm/kvm.c          | 56 +++++++++++++++++++++++++++
>   4 files changed, 142 insertions(+)
> 
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index 83ec95c290f6..9ed65eb090d7 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -76,6 +76,7 @@ static const char *cpu_model_advertised_features[] = {
>       "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
>       "kvm-no-adjvtime", "kvm-steal-time",
>       "pauth", "pauth-impdef", "pauth-qarma3", "pauth-qarma5",
> +    "num-breakpoints", "num-watchpoints",
>       NULL
>   };
>   
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 6bbc942f9a59..d256d66a3e1b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1173,6 +1173,10 @@ struct ArchCPU {
>   
>       /* Generic timer counter frequency, in Hz */
>       uint64_t gt_cntfrq_hz;
> +
> +    /* Allows to override the default configuration */
> +    uint8_t num_bps;
> +    uint8_t num_wps;
>   };
>   

May improve the comments to indicate: these two fields are only needed
by RME-vCPUs.

        /* Override the default configuration, only for RME vCPUs */

>   typedef struct ARMCPUInfo {
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 4e8c47253086..18adb06d78ad 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -666,6 +666,86 @@ void aarch64_add_pauth_properties(Object *obj)
>       }
>   }
>   
> +#if defined(CONFIG_KVM)
> +static void arm_cpu_get_num_wps(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    uint8_t val;
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    val = cpu->num_wps;
> +    if (val == 0) {
> +        val = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
> +                         ID_AA64DFR0, WRPS) + 1;
> +    }
> +
> +    visit_type_uint8(v, name, &val, errp);
> +}
> +
> +static void arm_cpu_set_num_wps(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    uint8_t val;
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint8_t max_wps = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
> +                                 ID_AA64DFR0, WRPS) + 1;
> +
> +    if (!visit_type_uint8(v, name, &val, errp)) {
> +        return;
> +    }
> +
> +    if (val < 2 || val > max_wps) {
> +        error_setg(errp, "invalid number of watchpoints");
> +        return;
> +   }
> +
> +    cpu->num_wps = val;
> +}
> +
> +static void arm_cpu_get_num_bps(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    uint8_t val;
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    val = cpu->num_bps;
> +    if (val == 0) {
> +        val = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
> +                         ID_AA64DFR0, BRPS) + 1;
> +    }
> +
> +    visit_type_uint8(v, name, &val, errp);
> +}
> +
> +static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    uint8_t val;
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint8_t max_bps = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
> +                                 ID_AA64DFR0, BRPS) + 1;
> +
> +    if (!visit_type_uint8(v, name, &val, errp)) {
> +        return;
> +    }
> +
> +    if (val < 2 || val > max_bps) {
> +        error_setg(errp, "invalid number of breakpoints");
           ^^^^^

Code alignment issue here.

> +       return;
> +    }
> +
> +    cpu->num_bps = val;
> +}
> +
> +static void aarch64_add_kvm_writable_properties(Object *obj)
> +{
> +    object_property_add(obj, "num-breakpoints", "uint8", arm_cpu_get_num_bps,
> +                        arm_cpu_set_num_bps, NULL, NULL);
> +    object_property_add(obj, "num-watchpoints", "uint8", arm_cpu_get_num_wps,
> +                        arm_cpu_set_num_wps, NULL, NULL);
> +}
> +#endif /* CONFIG_KVM */
> +
>   void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
>   {
>       uint64_t t;
> @@ -807,6 +887,7 @@ void aarch64_host_initfn(Object *obj)
>       kvm_arm_set_cpreg_mig_tolerances(cpu);
>       kvm_arm_set_cpu_features_from_host(cpu);
>       aarch64_add_sve_properties(obj);
> +    aarch64_add_kvm_writable_properties(obj);
>   #elif defined(CONFIG_HVF)
>       hvf_arm_set_cpu_features_from_host(cpu);
>   #elif defined(CONFIG_WHPX)
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index ca25b707a0a8..93686b038263 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -912,6 +912,56 @@ out:
>       return ret;
>   }
>   
> +#define KVM_REG_ARM_ID_AA64DFR0_EL1     ARM64_SYS_REG(3, 0, 0, 5, 0)
> +
> +static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
> +{
> +    int ret;
> +    uint64_t val, newval;
> +    CPUState *cs = CPU(cpu);
> +
> +    if (!cpu->num_bps && !cpu->num_wps) {
> +        return;
> +    }
> +
> +    newval = cpu->isar.idregs[ID_AA64DFR0_EL1_IDX];
> +    if (cpu->num_bps) {
> +        uint64_t ctx_cmps = FIELD_EX64(newval, ID_AA64DFR0, CTX_CMPS);
> +
> +        /* CTX_CMPs is never greater than BRPs */
> +        ctx_cmps = MIN(ctx_cmps, cpu->num_bps - 1);
> +        newval = FIELD_DP64(newval, ID_AA64DFR0, BRPS, cpu->num_bps - 1);
> +        newval = FIELD_DP64(newval, ID_AA64DFR0, CTX_CMPS, ctx_cmps);
> +    }
> +    if (cpu->num_wps) {
> +        newval = FIELD_DP64(newval, ID_AA64DFR0, WRPS, cpu->num_wps - 1);
> +    }
> +    ret = kvm_set_one_reg(cs, KVM_REG_ARM_ID_AA64DFR0_EL1, &newval);
> +    if (ret) {
> +        error_report("Failed to set KVM_REG_ARM_ID_AA64DFR0_EL1");
> +        return;
> +    }
> +
> +    /*
> +     * Check if the write succeeded. KVM does offer the writable mask for this
> +     * register, but this way we also check if the value we wrote was sane.
> +     */
> +    ret = kvm_get_one_reg(cs, KVM_REG_ARM_ID_AA64DFR0_EL1, &val);
> +    if (ret) {
> +        error_report("Failed to get KVM_REG_ARM_ID_AA64DFR0_EL1");
> +        return;
> +    }
> +
> +    if (val != newval) {
> +        error_report("Failed to update KVM_REG_ARM_ID_AA64DFR0_EL1");
> +    }

These two checks could be combined since we needn't to know how the write has
been failing.

        if (ret || val != newval) {
            error_report("Failed to update KVM_REG_ARM_ID_AA64DFR0_EL1");
        }

> +}
> +
> +static void kvm_arm_configure_vcpu_regs(ARMCPU *cpu)
> +{
> +    kvm_arm_configure_aa64dfr0(cpu);
> +}
> +
>   /**
>    * kvm_arm_cpreg_level:
>    * @regidx: KVM register index
> @@ -1128,6 +1178,12 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
>           fprintf(stderr, "kvm_arm_vcpu_init failed: %s\n", strerror(-ret));
>           abort();
>       }
> +
> +    /*
> +     * Before loading the KVM values into CPUState, update the KVM configuration
> +     */

Can be squeezed into one line:

        /* Update KVM state before it's loaded to CPUState */

> +    kvm_arm_configure_vcpu_regs(cpu);
> +

The newly added properties ("num-breakpoints", "num-watchpoints") are only needed by
RME-vCPUs, but they're also visible to the normal vCPUs. So do we need to bail without
adding the properties if RME isn't supported by the vCPUs in kvm_arm_configure_vcpu_regs() ?

>       if (!write_kvmstate_to_list(cpu)) {
>           fprintf(stderr, "write_kvmstate_to_list failed\n");
>           abort();

Thanks,
Gavin

