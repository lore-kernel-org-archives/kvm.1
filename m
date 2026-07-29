Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA513B0589
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337954; cv=none; b=EhvzxiriEA6GMOnzHIW1o/1gCO5Ghzq0TFCNHq5kVHDEDejjYMuhdOGbEvNAYKmmwN4Lumc7BS/FEgNrRCox35QFn4Zpvy55UK7CMXekpx0B5J/SLylo7DBG+dgdq3E4JLrlULdsWTp2sYppK04Pxl1vW+STcjTE2iWxEdHu2Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337954; c=relaxed/simple;
	bh=OcqSaTeLFBw/37oYMtNHG50Md6M29m6rUY9fQn9TwYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeLqseejyZAYMQ6CBme2YrOJ7dKjZ26jPrCRpftv5aRsmWJ2jS5NmwvOBpjX8D+wJHAGLTO/Jzpz2VS8oMmDZ1lyESFzPAEyBWC+qgSEZ+TO7B2YHBjdfVoH6sqXU42ndjWEjJ25CVzD3I7lXyAOQy0JeuqktCdA3661PUdUsTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pqUixAIj; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pqUixAIj"
X-Forwarded-Encrypted: i=1; AHgh+RoDxab80aVtC39h237fqA6J5D0ur1cdLXitHcT8YPcLC3RuIEdN4p7QhDEXJ9wEP5tr9jM=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785337950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GZkD05VF0k87b16ZMBfeT0j3aww6dW2ILKTzqN3+UtU=;
	b=pqUixAIjzsUSNj3ecmiUj4vwLEvkHGgKOWj0uzMBXBKISr2g0dmCiFJuIqJrW/Z2GVlccH
	CDEqXuU6FUYYfouBXnJh7Zj2oAnRW7wG91tRhv4CPMRqwz/Jnr7uK8yu6aEJJHZ4+BDZD3
	dZqLO8cZ/ROGpF02zvXAFuxMkOSIBDk=
X-Gm-Message-State: AOJu0YySAPZTg0Af/SH2+UGzQpj722GBQXz7/LO5JECOKwkv16gi6o+W
	qIp3B1FtlLxNpzvsBy25srGlTQ/ikiwhDW2NxYTqsz1NeLJdN9vIWwj6oJ9HSbFJaoQa7XPnDLv
	WbhlUTMOutiPTYWlaHEemVmKRYtkkDWBf9iqLM4RZ
X-Received: by 2002:ac8:7e8e:0:b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-52b350e5e9dmr111891cf.3.1785337931850; Wed, 29 Jul 2026
 08:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-hybrid-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp> <20260720-hybrid-v9-1-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260720-hybrid-v9-1-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 29 Jul 2026 16:11:34 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxy6f2EPhtOkHju39hGi91ZM5heu5ZA0upmmDxBq2GstQ@mail.gmail.com>
X-Gm-Features: AUfX_myxJfjxAZR1tFLm51zrI58rRpwUPxuAUzGX7sj7-3UdzYo6Sjg9A4wrAHA
Message-ID: <CA+EHjTxy6f2EPhtOkHju39hGi91ZM5heu5ZA0upmmDxBq2GstQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/16] KVM: arm64: Serialize repeated vCPU initialization
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
> The initial KVM_ARM_VCPU_INIT path holds config_lock while resetting the
> vCPU, but repeated initialization of an existing vCPU does not. As a
> result, reset_mdcr() can race with VM-wide PMU configuration and
> overwrite MDCR_EL2 with a stale counter count.
>
> Take config_lock around the repeated-init checks and reset. The vCPU
> ioctl already holds vcpu->mutex, matching the established lock ordering.
>
> Fixes: c8823e51b534 ("KVM: arm64: Fix MDCR_EL2.HPMN reset value")
> Closes: https://sashiko.dev/#/patchset/20260710-hybrid-v8-0-621409f3a592@rsg.ci.i.u-tokyo.ac.jp?part=1
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

> ---
>  arch/arm64/kvm/arm.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 50adfff75be8..a06ea39f57b1 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1652,29 +1652,26 @@ static int __kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
>  {
>         unsigned long features = init->features[0];
>         struct kvm *kvm = vcpu->kvm;
> -       int ret = -EINVAL;
> +       int ret;
>
> -       mutex_lock(&kvm->arch.config_lock);
> +       lockdep_assert_held(&kvm->arch.config_lock);
>
>         if (test_bit(KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED, &kvm->arch.flags) &&
>             kvm_vcpu_init_changed(vcpu, init))
> -               goto out_unlock;
> +               return -EINVAL;
>
>         bitmap_copy(kvm->arch.vcpu_features, &features, KVM_VCPU_MAX_FEATURES);
>
>         ret = kvm_setup_vcpu(vcpu);
>         if (ret)
> -               goto out_unlock;
> +               return ret;
>
>         /* Now we know what it is, we can reset it. */
>         kvm_reset_vcpu(vcpu);
>
>         set_bit(KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED, &kvm->arch.flags);
>         vcpu_set_flag(vcpu, VCPU_INITIALIZED);
> -       ret = 0;
> -out_unlock:
> -       mutex_unlock(&kvm->arch.config_lock);
> -       return ret;
> +       return 0;
>  }
>
>  static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
> @@ -1690,6 +1687,8 @@ static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
>         if (ret)
>                 return ret;
>
> +       guard(mutex)(&vcpu->kvm->arch.config_lock);
> +
>         if (!kvm_vcpu_initialized(vcpu))
>                 return __kvm_vcpu_set_target(vcpu, init);
>
>
> --
> 2.55.0
>
>
