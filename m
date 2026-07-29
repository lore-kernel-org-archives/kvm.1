Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD7238DC4E
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338259; cv=none; b=txmkmapekVqJfso4EKQWDIHsOVU0q+iAZXDwvvuifOifhvGWk31oLwc+5ZLiy0LI0EZJOcEKQP9Sd5o2E9yxfEje1pqderWWiXFxlWudQFuHjB1SbUBoDupjVzB33jcRjhpuSJ/SeA96ZhF8I4dYqhsMxTdfr3HU+hWli3UVBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338259; c=relaxed/simple;
	bh=+h9sttoR68rx+GrC/rxmaOenAHYFlJ1Bom+m58CnNCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6tHcsWbb11A2/kmIBg4SPlzJ0cbsWLTBBn7kOSGhJPYdniqq4XNDy3oMfzH5cqQt0MUvOdEye71WImqixj+yjwXAikL07xNYdmNuidDtIBkJSbWu99JXWfuOaNI8sGdSU0bQq4AprKlAnixmTgAK7+CHIMr1KSnay66W/D5qpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XU+kipXS; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XU+kipXS"
X-Forwarded-Encrypted: i=1; AHgh+Rr0QhLHT5BOmqqsOU1wTuq/Kn6xgQKST/EUVB2nDzbqkAK34P44jvRNmP1gMYRfPOcqdNU=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785338255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ti+NqKDTLfm/nZ8f6EX1KwjNP1iMFipkmncvpp1Cax0=;
	b=XU+kipXS78JNa6F/lrJHp9s6e+D9iOU+Agczx5iA3BFXnicG2jTuJjVEbA98qI37wh+IpH
	D+R2+nNnPOk+COsS51Aw7jTFe6qegHRAhooUohJPFzZDVVap0ZO3d7+WnOHpQHF42OtJco
	RTZpI8TRC19RWZSMa7HoY48ufF8eL7M=
X-Gm-Message-State: AOJu0YwbDD/jTLvXkr6GRq+6B6cuLgUZL+nOdLrdMBB8kYs/LpmndNZ1
	ECEae7gczYx3c7X/UR/jTYiWjEVhsdk3QlCu/W0oNtw5eyasijjjHoR0A02FBtPS4JOVDhk+wwz
	v7b8H9GnjgxpsUKdJKplFUzVYsxvwrH8chh2AStXi
X-Received: by 2002:ac8:7dc4:0:b0:528:3186:5799 with SMTP id
 d75a77b69052e-52b35089d24mr441161cf.10.1785338243657; Wed, 29 Jul 2026
 08:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-hybrid-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp> <20260720-hybrid-v9-2-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260720-hybrid-v9-2-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 29 Jul 2026 16:16:46 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwCFXkQ=VHjQt3zt0TORh5YwPVCPBqFqTJF7YULxM-11g@mail.gmail.com>
X-Gm-Features: AUfX_mxk11pzy6CU19PtboDUtDrd-zS8qSEKUP6-qNGENZgdWGBbQJn1zZ_m4NQ
Message-ID: <CA+EHjTwCFXkQ=VHjQt3zt0TORh5YwPVCPBqFqTJF7YULxM-11g@mail.gmail.com>
Subject: Re: [PATCH v9 02/16] KVM: arm64: PMU: Stop updating MDCR_EL2.HPMN
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Eiden <seiden@linux.ibm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	devel@daynix.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Mon, 20 Jul 2026 at 06:39, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> KVM allows userspace to write any value to MDCR_EL2.HPMN. However,
> kvm_arm_set_nr_counters() rewrites HPMN for every vCPU whenever
> userspace changes the PMU or its counter count. This can discard a
> value previously restored with KVM_SET_ONE_REG.
>
> The architecture only defines HPMN's value on warm reset. Stop
> rewriting it after vCPU initialization and update nr_pmu_counters
> directly instead. reset_mdcr() continues to initialize HPMN from the
> counter count current at KVM_ARM_VCPU_INIT.
>
> Fixes: c8823e51b534 ("KVM: arm64: Fix MDCR_EL2.HPMN reset value")
> Closes: https://sashiko.dev/#/patchset/20260706-hybrid-v8-0-de459617b59d%40rsg.ci.i.u-tokyo.ac.jp?part=6
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

> ---
>  arch/arm64/kvm/pmu-emul.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> index 98305bbfc095..b5df6843dbcd 100644
> --- a/arch/arm64/kvm/pmu-emul.c
> +++ b/arch/arm64/kvm/pmu-emul.c
> @@ -1022,30 +1022,12 @@ u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
>         return bitmap_weight(arm_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS);
>  }
>
> -static void kvm_arm_set_nr_counters(struct kvm *kvm, unsigned int nr)
> -{
> -       kvm->arch.nr_pmu_counters = nr;
> -
> -       /* Reset MDCR_EL2.HPMN behind the vcpus' back... */
> -       if (test_bit(KVM_ARM_VCPU_HAS_EL2, kvm->arch.vcpu_features)) {
> -               struct kvm_vcpu *vcpu;
> -               unsigned long i;
> -
> -               kvm_for_each_vcpu(i, vcpu, kvm) {
> -                       u64 val = __vcpu_sys_reg(vcpu, MDCR_EL2);
> -                       val &= ~MDCR_EL2_HPMN;
> -                       val |= FIELD_PREP(MDCR_EL2_HPMN, kvm->arch.nr_pmu_counters);
> -                       __vcpu_assign_sys_reg(vcpu, MDCR_EL2, val);
> -               }
> -       }
> -}
> -
>  static void kvm_arm_set_pmu(struct kvm *kvm, struct arm_pmu *arm_pmu)
>  {
>         lockdep_assert_held(&kvm->arch.config_lock);
>
>         kvm->arch.arm_pmu = arm_pmu;
> -       kvm_arm_set_nr_counters(kvm, kvm_arm_pmu_get_max_counters(kvm));
> +       kvm->arch.nr_pmu_counters = kvm_arm_pmu_get_max_counters(kvm);
>  }
>
>  /**
> @@ -1111,7 +1093,7 @@ static int kvm_arm_pmu_v3_set_nr_counters(struct kvm_vcpu *vcpu, unsigned int n)
>         if (n > kvm_arm_pmu_get_max_counters(kvm))
>                 return -EINVAL;
>
> -       kvm_arm_set_nr_counters(kvm, n);
> +       kvm->arch.nr_pmu_counters = n;
>         return 0;
>  }
>
>
> --
> 2.55.0
>
>
