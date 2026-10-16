Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC723D1CA8
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 22:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792191216; cv=none; b=TIc4iPcKFMn8AlDJHvfAI5YRE5aPvVJsx+vieX21psNXV00ox6XB0/KDsWsDiTtlwEwxxtM98o/ydJNsceENXVOJYa2106wnV1InbqVlWOZOGs1PJvxuebiI38JT1aYDlVC1ahrsXI3pL1zrTLHtZgJQQI2Is1a0ahQL3K+ZaNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792191216; c=relaxed/simple;
	bh=Qv7hgPZ7ZU/3KCanfItnt/Lo3MWHFzfYc7jIr4M4SXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/61uvRgEFjSOmeLom2sbolad4ODt5xn/MajFFlrjjZIgTv28E9LYIYo3ocRQaOY4zah48Q6YTperohWHbSWsVE367+OpR35Jhc3IfyUbTH2QnpCjUGT+dcSf1drkvKV/pqU0t+TYaNkwLFIdfCG6pa6EzMPFGdgGU/OUc4HRkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=in7XwrYq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="in7XwrYq"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so261097a91.0
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792191214; x=1792796014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jFbt1hoixxjPVWE023X/7skdt6GJW42bri8Snk4vWz4=;
        b=in7XwrYqMVlnp6+tRMrHl0UCI4YLA76XWIH4GflmWUXxh1uTfgpTGbS9+nHCb4ISdu
         rst8hYsHYP5tPy2CQ1Kaxc99pnBsjeCssop+3NKpEhrNQxd3q/5U30cHTrdoOTxdRq94
         egeRMRx3VBVBW31EBqcWTW25xEwrlXvXJGfEkP6SGdty77dyIH2KXnaKd6v68yxSVmB2
         ada0lzuK6VdWhQAo0Hc3AMBcYgHTVAiRSLjZQlzloAhiUA1dTI0Vj+dANHxYre971dOf
         lQ3lTkjRCEzfGn9cHlfVaQvdxBlrrPd6Q/N0Y5hxxpABKQHn9IOl+DuJA35zg1oHw+XV
         1+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792191214; x=1792796014;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jFbt1hoixxjPVWE023X/7skdt6GJW42bri8Snk4vWz4=;
        b=cLD5uijFcXLRHhEj+xpdOEshdgyYcJVCsJ5kIUpfQzKeXV4ug6BX+uEzVR9m76Xva7
         e+8frfgG4UQ2y9M/E+ApiIrtpAzHL92GqpbFWD4E1ZxhNvp6i8z6sMz+A6XUxhUaRaI1
         TChztfVyGZzn4fyKLsd4xylWGOpd/CODj24UJ1Gnx9J3vocfjn31wegtCXvDT/eID/vi
         1JA9bHvs3u15VEuKHIJzKmqY0qmL+ViaitWnP0AiQMiBKX9pK8w69qWdEb7+/lJFXrlL
         D0Q09J6eGBURI/b7LBuoBVXYsL76t2XJGhLaZ0++eKY+coFmR1aUbO0OIMueSlPZMQ+6
         /JYg==
X-Forwarded-Encrypted: i=1; AKwUvBwaBRUWfY9l1PHfLHEBSK3Qr2ibfppIYeaZs9iu5vm3bGVp9lxJ6sZ1TZzkC9pzpRG6bxo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJorXOgDj95W+CiVgkm1xeTnrWKbjoYvc8QR5y+yinzim31oFzV
	ddjMK3BCDGUJaVFm754oyahLilN16AO2UWdXj+TkWvnluGpVXZTjPYzMJD/BNt0M8qg=
X-Gm-Gg: AYBFou2EHk6e1FbY4iH1+jbd7swU8+dGzhe7AUs8GmkwNiWk/ygcetwVAIjS2V9hF8v
	zstyOBrYIIkhd0va2DCU68Tf7QCnacdXfBUqK3SNtB2zps89Wu9fLapwLbv+/B+OX8HEuzYgjd7
	GfSIMphhsy819an9e+z/N2gBh3kUxE7J4jbmc8hQrgFpWLmELZ/sIZYvqfi3EoJ35DUksgUKcl3
	GZDEqRPGv0+CyXfQct/+vlYJ7LemHhIgtnjrDs+haq/cUMryyeHlQnIyPPdkFGXu1nv4bWtRdOq
	Kz1n8O3BlmvixDIA+cTmHUBpYQ0s2Q9bS0KhrHoLRTvDjkFuOfg17aQVpJCvtl8IjqvZ8u8WRO9
	GzUXpzlCqy99Vr2gJzF1YVOwDx8EsuuPPfNAbv+184IgB7jJ4OawzT46NqSEbf1Lz8uYacdemTT
	bBY3dljmjQNHBC8FSM/RrJx+q4szWMU8j8iFvE9W6o4MSVv9Dgj7nxAl9Yr0BgMtq5rnKXrSch2
	A==
X-Received: by 2002:a17:90b:4f8e:b0:3ab:d26b:c2e9 with SMTP id 98e67ed59e1d1-3acef1451d2mr1122422a91.33.1792191213780;
        Fri, 16 Oct 2026 15:53:33 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ff2f:8a9c:5623:f753])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd9c4b4eesm3634255a91.2.2026.10.16.15.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 15:53:33 -0700 (PDT)
Date: Fri, 16 Oct 2026 16:53:29 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v4 12/24] target/arm/cpu: Set number of breakpoints and
 watchpoints in KVM
Message-ID: <atKq6YqMMzzft2r1@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-13-mathieu.poirier@linaro.org>
 <eda8ee8f-5f17-4144-b21e-b1d990ee3270@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda8ee8f-5f17-4144-b21e-b1d990ee3270@redhat.com>

On Fri, Oct 02, 2026 at 02:06:24PM +1000, Gavin Shan wrote:
> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Add "num-breakpoints" and "num-watchpoints" CPU parameters to configure
> > the debug features that KVM presents to the guest. The KVM vCPU
> > configuration is modified by calling SET_ONE_REG on the ID register.
> > 
> > This is needed for Realm VMs, whose parameters include breakpoints and
> > watchpoints, and influence the Realm Initial Measurement.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/arm-qmp-cmds.c |  1 +
> >   target/arm/cpu.h          |  4 ++
> >   target/arm/cpu64.c        | 81 +++++++++++++++++++++++++++++++++++++++
> >   target/arm/kvm.c          | 56 +++++++++++++++++++++++++++
> >   4 files changed, 142 insertions(+)
> > 
> > diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> > index 83ec95c290f6..9ed65eb090d7 100644
> > --- a/target/arm/arm-qmp-cmds.c
> > +++ b/target/arm/arm-qmp-cmds.c
> > @@ -76,6 +76,7 @@ static const char *cpu_model_advertised_features[] = {
> >       "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
> >       "kvm-no-adjvtime", "kvm-steal-time",
> >       "pauth", "pauth-impdef", "pauth-qarma3", "pauth-qarma5",
> > +    "num-breakpoints", "num-watchpoints",
> >       NULL
> >   };
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 6bbc942f9a59..d256d66a3e1b 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -1173,6 +1173,10 @@ struct ArchCPU {
> >       /* Generic timer counter frequency, in Hz */
> >       uint64_t gt_cntfrq_hz;
> > +
> > +    /* Allows to override the default configuration */
> > +    uint8_t num_bps;
> > +    uint8_t num_wps;
> >   };
> 
> May improve the comments to indicate: these two fields are only needed
> by RME-vCPUs.
> 
>        /* Override the default configuration, only for RME vCPUs */
> 
> >   typedef struct ARMCPUInfo {
> > diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> > index 4e8c47253086..18adb06d78ad 100644
> > --- a/target/arm/cpu64.c
> > +++ b/target/arm/cpu64.c
> > @@ -666,6 +666,86 @@ void aarch64_add_pauth_properties(Object *obj)
> >       }
> >   }
> > +#if defined(CONFIG_KVM)
> > +static void arm_cpu_get_num_wps(Object *obj, Visitor *v, const char *name,
> > +                                void *opaque, Error **errp)
> > +{
> > +    uint8_t val;
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +
> > +    val = cpu->num_wps;
> > +    if (val == 0) {
> > +        val = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
> > +                         ID_AA64DFR0, WRPS) + 1;
> > +    }
> > +
> > +    visit_type_uint8(v, name, &val, errp);
> > +}
> > +
> > +static void arm_cpu_set_num_wps(Object *obj, Visitor *v, const char *name,
> > +                                void *opaque, Error **errp)
> > +{
> > +    uint8_t val;
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +    uint8_t max_wps = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
> > +                                 ID_AA64DFR0, WRPS) + 1;
> > +
> > +    if (!visit_type_uint8(v, name, &val, errp)) {
> > +        return;
> > +    }
> > +
> > +    if (val < 2 || val > max_wps) {
> > +        error_setg(errp, "invalid number of watchpoints");
> > +        return;
> > +   }
> > +
> > +    cpu->num_wps = val;
> > +}
> > +
> > +static void arm_cpu_get_num_bps(Object *obj, Visitor *v, const char *name,
> > +                                void *opaque, Error **errp)
> > +{
> > +    uint8_t val;
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +
> > +    val = cpu->num_bps;
> > +    if (val == 0) {
> > +        val = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
> > +                         ID_AA64DFR0, BRPS) + 1;
> > +    }
> > +
> > +    visit_type_uint8(v, name, &val, errp);
> > +}
> > +
> > +static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
> > +                                void *opaque, Error **errp)
> > +{
> > +    uint8_t val;
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +    uint8_t max_bps = FIELD_EX64(cpu->isar.idregs[ID_AA64DFR0_EL1_IDX],
> > +                                 ID_AA64DFR0, BRPS) + 1;
> > +
> > +    if (!visit_type_uint8(v, name, &val, errp)) {
> > +        return;
> > +    }
> > +
> > +    if (val < 2 || val > max_bps) {
> > +        error_setg(errp, "invalid number of breakpoints");
>           ^^^^^
> 
> Code alignment issue here.
> 
> > +       return;
> > +    }
> > +
> > +    cpu->num_bps = val;
> > +}
> > +
> > +static void aarch64_add_kvm_writable_properties(Object *obj)
> > +{
> > +    object_property_add(obj, "num-breakpoints", "uint8", arm_cpu_get_num_bps,
> > +                        arm_cpu_set_num_bps, NULL, NULL);
> > +    object_property_add(obj, "num-watchpoints", "uint8", arm_cpu_get_num_wps,
> > +                        arm_cpu_set_num_wps, NULL, NULL);
> > +}
> > +#endif /* CONFIG_KVM */
> > +
> >   void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
> >   {
> >       uint64_t t;
> > @@ -807,6 +887,7 @@ void aarch64_host_initfn(Object *obj)
> >       kvm_arm_set_cpreg_mig_tolerances(cpu);
> >       kvm_arm_set_cpu_features_from_host(cpu);
> >       aarch64_add_sve_properties(obj);
> > +    aarch64_add_kvm_writable_properties(obj);
> >   #elif defined(CONFIG_HVF)
> >       hvf_arm_set_cpu_features_from_host(cpu);
> >   #elif defined(CONFIG_WHPX)
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index ca25b707a0a8..93686b038263 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -912,6 +912,56 @@ out:
> >       return ret;
> >   }
> > +#define KVM_REG_ARM_ID_AA64DFR0_EL1     ARM64_SYS_REG(3, 0, 0, 5, 0)
> > +
> > +static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
> > +{
> > +    int ret;
> > +    uint64_t val, newval;
> > +    CPUState *cs = CPU(cpu);
> > +
> > +    if (!cpu->num_bps && !cpu->num_wps) {
> > +        return;
> > +    }
> > +
> > +    newval = cpu->isar.idregs[ID_AA64DFR0_EL1_IDX];
> > +    if (cpu->num_bps) {
> > +        uint64_t ctx_cmps = FIELD_EX64(newval, ID_AA64DFR0, CTX_CMPS);
> > +
> > +        /* CTX_CMPs is never greater than BRPs */
> > +        ctx_cmps = MIN(ctx_cmps, cpu->num_bps - 1);
> > +        newval = FIELD_DP64(newval, ID_AA64DFR0, BRPS, cpu->num_bps - 1);
> > +        newval = FIELD_DP64(newval, ID_AA64DFR0, CTX_CMPS, ctx_cmps);
> > +    }
> > +    if (cpu->num_wps) {
> > +        newval = FIELD_DP64(newval, ID_AA64DFR0, WRPS, cpu->num_wps - 1);
> > +    }
> > +    ret = kvm_set_one_reg(cs, KVM_REG_ARM_ID_AA64DFR0_EL1, &newval);
> > +    if (ret) {
> > +        error_report("Failed to set KVM_REG_ARM_ID_AA64DFR0_EL1");
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Check if the write succeeded. KVM does offer the writable mask for this
> > +     * register, but this way we also check if the value we wrote was sane.
> > +     */
> > +    ret = kvm_get_one_reg(cs, KVM_REG_ARM_ID_AA64DFR0_EL1, &val);
> > +    if (ret) {
> > +        error_report("Failed to get KVM_REG_ARM_ID_AA64DFR0_EL1");
> > +        return;
> > +    }
> > +
> > +    if (val != newval) {
> > +        error_report("Failed to update KVM_REG_ARM_ID_AA64DFR0_EL1");
> > +    }
> 
> These two checks could be combined since we needn't to know how the write has
> been failing.
> 
>        if (ret || val != newval) {
>            error_report("Failed to update KVM_REG_ARM_ID_AA64DFR0_EL1");
>        }
> 
> > +}
> > +
> > +static void kvm_arm_configure_vcpu_regs(ARMCPU *cpu)
> > +{
> > +    kvm_arm_configure_aa64dfr0(cpu);
> > +}
> > +
> >   /**
> >    * kvm_arm_cpreg_level:
> >    * @regidx: KVM register index
> > @@ -1128,6 +1178,12 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
> >           fprintf(stderr, "kvm_arm_vcpu_init failed: %s\n", strerror(-ret));
> >           abort();
> >       }
> > +
> > +    /*
> > +     * Before loading the KVM values into CPUState, update the KVM configuration
> > +     */
> 
> Can be squeezed into one line:
> 
>        /* Update KVM state before it's loaded to CPUState */
> 
> > +    kvm_arm_configure_vcpu_regs(cpu);
> > +
> 
> The newly added properties ("num-breakpoints", "num-watchpoints") are only needed by
> RME-vCPUs, but they're also visible to the normal vCPUs. So do we need to bail without
> adding the properties if RME isn't supported by the vCPUs in kvm_arm_configure_vcpu_regs() ?
>

I added a check for confidential-guest-support in the get() functions of both
options.  I also addressed the rest of your comments above.

Thanks for the review,
Mathieu 
 
> >       if (!write_kvmstate_to_list(cpu)) {
> >           fprintf(stderr, "write_kvmstate_to_list failed\n");
> >           abort();
> 
> Thanks,
> Gavin
> 
