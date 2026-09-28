Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726724D7D59
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604110; cv=pass; b=gVeIaUvmNqxwxCg+W50KGbGB2RbUGffc5uoZvjeC3pcdBZvEu0bg39iAXjOeSV5MXNri9Yz8OL2tL2DFkwTefa24ie9ZiRTx9Bi6SeFo794U8WCjo4yp8GU69Scli4l3HemHB16ptJhOgECCPv2Ex4hT5M8TcHGLlrnkZuR9MQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604110; c=relaxed/simple;
	bh=g/9FLDAua0C/8CqfTr7Fn8gQSHiF4d0O4k+A5Uh+fvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqktnzeMjdPE93eR5EqxkLOUhmKWQrctSUpmrneZZPSMMn3Sqp4GithIl+QTcnm6o5Nr6dNTsOvvCCjvb8eoy+kX1SfWlip0XCEWB/0iF0SKNryyMX0XIisVhGNrzW7iniyLE/8Brnc0SN8YQ5/LfaKcSSMdp/gAxr0MRy6KNVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HmbbfdGw; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmbbfdGw"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-673335b89a0so2563854d50.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790604107; cv=none;
        d=google.com; s=arc-20260327;
        b=bsHTqSrg68XGszWKbjk9P5YRpzI1Px0V99I5QeGwwkNDL839vk82/vAnsR+4YsXmDs
         sP2XTWFf3moOte3Ff37Bg9UVW/BT4ynmO4rQ+4bop1635cxwtLmwDVVektGXP0OP42hd
         xj5nv2FmvUyTqf8ArZ6TkBNqzN4t47HXgkJaswkMEpMSYRfya1kztOQCvTn/IsA7GaAl
         JLimXD/lNf3WMsrEIPzbc0SFAsqNPw7ZfXUjiI60nvkicWLEwfkxKQcqVjB+hetkAjyG
         TUvhpEfvMS2xy8AIYBtiLXDBIUramsfeWQrjDtkU+HwmWFRA/ukp/IXRcJj9KkvPrK55
         k33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gVo78a/wlP80EbN8BDeCX3xsqSYxql3c+VM4RzW0dd4=;
        fh=R2WNriay9JIQNqfMdQDDEgahXugfEj/c9Jffr1DDwYM=;
        b=NQzKyTRYXadSZwaAE721sIm0J64zjM8L9C+pvmuzY7Dw23HbOuG40QwSEMmuM87Qgf
         crHj0CYGCIWdEm54Txat1HHkzcXB54oxud5plQcRI75FRREnKk5AXrWhsxHp6R30eYhy
         njKWSMWEkYwTOxp6qi3+fwWWqsXZOqBZrcy4YXtkZB6oMkGj7J63h/TvgndMW6pONCHf
         AmCaz2/uaJfkEJOaQdLxFr2hJh0it0/1YtNcxsDXQZ1FixpXS527/LvlgKfQRCtfw2Vg
         AdEMO1fd/zJX6f5xuAG1DmUK8LlEvLB4eYQi47ysKg45oNvaxy+Brc2rRLCveA3hADSh
         ykLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790604107; x=1791208907; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gVo78a/wlP80EbN8BDeCX3xsqSYxql3c+VM4RzW0dd4=;
        b=HmbbfdGwK2J2z4CHxZvpvcFoiTEogeMr05hInE0RQ6770uR0ejIWZQuRBSAFboZ/dc
         rJrLZbFVbDvUdrlli0Jr73ljl0kwUgg+Pm61uC+3hzMY3Cjnqb4HECmy4vUp9JMr9E+u
         7SWLnSdnt7ZVYefD8+l7dQS1kVV/4SP+Fxe+TyoQuFhuJcxyzfq3ChuPzD4D4TTjzRcd
         hND7tH3V1Ksw3TWUbueO1G/uMin1rTDBeNIriKMS8mLu9xAXMSwphWzrTcdrCXq5ckup
         DYb6hVpQ+jVHl+YbtjRzW0vIfdEEwFTBEFbogSLn/xLydJUpPlI1R7nh9Ugb/SY/mlK9
         8iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790604107; x=1791208907;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gVo78a/wlP80EbN8BDeCX3xsqSYxql3c+VM4RzW0dd4=;
        b=lMdz6aqbi90XkiHYiSbQxSHXQvjK/ald520ALC1zR4okYT+A6hMsI83jzW4wQDoLJj
         YX9rsWlbcjBHVhNqr1msDakBA4ZsQTpdwHcwlgd7/D9lkqM/YHYF+HHl6npzaUHOiMYj
         RiiZ5JI2VBaQxy+lz0d1nIhWVqxm6yfWdF/yQlZ6Scwl7/URM3mXAp2ng25nqSBDkT6v
         te8R44zZye0DHaOikMnBBsWTwT9jOhWs4VYLN+FF0X7nzpi8LWEpWIJ6IwOkvpTkYzpc
         rAuo4tu7g05V4A8+k/mmdKmwz0hvra6Tv4Js9U28+EKJJl/6XCcFtCRMedaBDznQjgNK
         Lo3g==
X-Forwarded-Encrypted: i=1; AKwUvBz2zCogSloAUvWC8RwLh6PWH19RVeyiRwJJbsd3qylN1l0zsMqXHStKBLhBj9hO0tZbWCg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6QmHeX9NkqjzbqmRJ/agrWaSMG1S0KmLs9J3XOt6nmHVg3VHi
	0WJDd1t2dVpstB3t9cR9TerGvxBIzbHIDO7fLrVcWHE84rkM50bKKCUkHJnnbJl0u44/EQQeH5r
	4+dpC7mIoaKp+G2wmTGq1qhzJCLQMwoDm9yQRblcJGO6DrkKtkQkUrFo=
X-Gm-Gg: AYBFou2b+L5t+rikjs45fy1dpi5nR8LxeCO8COTRifdQ/D79QvP/eFfawUkISQna/BI
	uvqzvZ0Io+CWPcJ2JaR4AHYgP5U7UW9GViMKWMwrR73yzSKh/RyVjcKWTuwYo78/xuWegEgnV5O
	RIW6xpZ48W3yafyv9epvZ1dkVqUWW2vrq+NoFzxyZSFsE5n9b+/pIIX533YWdURMyJ6c/CjSVUv
	HgD84mPfgB6Uzx8k5V6cw0FvI3zZL+e8jitMueXv2i2ya4oKqy4+1tJ7oHCqZYmBlYiYHi8SJ81
	Typ1sEuMcOvSPrt2Qr+IGpeOnAbvPAox3L2qNotbUlV+shgAZQXyWBFtSc1EN9L1s7lFt1ZDrhB
	OCLNlMsBiRssJFjyYmGCgekeOFqfB817Nmo1ui8JF
X-Received: by 2002:a05:690e:169e:b0:667:b503:4d2e with SMTP id
 956f58d0204a3-672ed1d4e4bmr6799180d50.37.1790604105100; Mon, 28 Sep 2026
 07:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com> <20260924173051.2117637-1-coltonlewis@google.com>
In-Reply-To: <20260924173051.2117637-1-coltonlewis@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 15:01:32 +0100
X-Gm-Features: AclHuK-1ibztR8QVF_T1w6zQp7WvVuCy3F9mqxT4-ubotzdPTVl79C5Fj0zkGKo
Message-ID: <CAFEAcA9Rwrffx8bYiOxrtQGdg31QAz1oBm8okzpfqHZ6yK0Y7A@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Enable KVM PMU partitioning and counter limit
To: Colton Lewis <coltonlewis@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvmarm@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mingwei Zhang <mizhang@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Sept 2026 at 18:30, Colton Lewis <coltonlewis@google.com> wrote:
>
> Add CPU properties to configure KVM ARM64 PMU counter partitioning:
> - 'pmu-partition' (bool): enables KVM_ARM_VCPU_PMU_V3_ENABLE_PARTITION
> - 'pmu-num-counters' (uint32): sets KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS
>
> When 'pmu-partition=on' and 'pmu-num-counters=N' are passed via -cpu,
> QEMU enables hardware PMU partitioning and reserves N general-purpose
> event counters for the guest prior to calling KVM_ARM_VCPU_PMU_V3_INIT.
>
> Note that this patch is an example to demonstrate the KVM ARM64 PMU
> Partitioning uAPI [1]. That is why it aborts immediately if setting the
> device attributes does not succeed.
>
> [1] https://lore.kernel.org/kvmarm/20260924172928.2110956-1-coltonlewis@google.com/
>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

FYI for next time around, QEMU patches that depend on not-yet-accepted
kernel ABI changes should be tagged RFC, please.

> ---
>  target/arm/cpu.c | 20 ++++++++++++++++++++
>  target/arm/cpu.h |  4 ++++
>  target/arm/kvm.c | 32 ++++++++++++++++++++++++++++++++

New CPU properties should be documented in docs/system/arm/cpu-features.rst .

>  3 files changed, 56 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index f58a1db843..7538c6a24c 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1359,6 +1359,20 @@ static bool arm_get_pmu(Object *obj, Error **errp)
>      return cpu->has_pmu;
>  }
>
> +static bool arm_get_pmu_partition(Object *obj, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    return cpu->kvm_pmu_partition;
> +}
> +
> +static void arm_set_pmu_partition(Object *obj, bool value, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    cpu->kvm_pmu_partition = value;
> +}

If your getter/setter are only updating the struct field,
you can use a DEFINE_PROP_BOOL to avoid having to have them
(compare arm_cpu_has_el2_property etc.)

> +
>  static void arm_set_pmu(Object *obj, bool value, Error **errp)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> @@ -1604,6 +1618,12 @@ static void arm_cpu_post_init(Object *obj)
>      if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
>          cpu->has_pmu = true;
>          object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
> +        object_property_add_bool(obj, "pmu-partition",
> +                                 arm_get_pmu_partition,
> +                                 arm_set_pmu_partition);
> +        object_property_add_uint32_ptr(obj, "pmu-num-counters",
> +                                       &cpu->kvm_pmu_nr_counters,
> +                                       OBJ_PROP_FLAG_READWRITE);

What should we do with these properties if we're not using KVM
(i.e. for TCG, hvf, etc) ?

thanks
-- PMM
