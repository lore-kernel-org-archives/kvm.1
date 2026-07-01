Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844F03A5433
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942464; cv=none; b=uyilwGn2XoC8XbiFHAb3wn8hDLpxo/dKnYdk8Dmunp/9flgnQwdKPmLb5hGE6gCw+SsWiYWhkGioRqv+jQuqe66NB48bg2S8IPnoX9NSJbQY8XSlMZBJ0uxShEY/aEo1KpayewcSzvFlag/AD9VYFdidF6W1s0/n9fjxJrAQrHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942464; c=relaxed/simple;
	bh=s6Cr8zkyzrstP1cxKPxKWWNP4yvLxKRkyvcOWVE4+90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gzWiWtx9uKO1Dk6wCi9Fwq499CaXD/13BxLpMEke+Pn2DQbw5RN2jlqcMVAz0InSqhcS1MOgVOtlOKWdpymq9AesbRPfZIGNrOQTMVWiE6FopN19D0PcEa/6M9oVhpiljkfDC0L7X/nrun4il7FwC4eG4aTb2GKnIHEIGf1RMEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rVpsp6AZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rVpsp6AZ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c804e38c65so21351385ad.2
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 14:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942463; x=1783547263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zcs7QN5Kd/BsLm+PUgFcojzf1bXkoGYIJwLkqkM7zHA=;
        b=rVpsp6AZSOy/NLznGTKp2Pw0DZ0B+eF94ddmhpHVgoxEcys5CrnXYKghzp3ABlufZF
         1g5AedcwCOYpu8w4IjF2J9wDkww5bJFp6KEUHRuqyno36Noz4OAjLa8DUFJL8n/YdrqU
         a8VxfcQAbUtpiBel3y07+M6myY0PYPjLlRtpS8nLFQbkUYuL94DgIpp475jnWAjq+Wdh
         hUizv2HLC1hdwRwlSccQzYDddIQjKqlMWg17WvSQvPMQZhz3F5Pr6qdiD6wVTVYXpSk1
         fOzpNm89My0UVP3OTI+55vYxTZqldejdJeDdcz8IT1pm2o6o1txbfhCvM9OzVmeDxkME
         bf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942463; x=1783547263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcs7QN5Kd/BsLm+PUgFcojzf1bXkoGYIJwLkqkM7zHA=;
        b=dy4747k6ZSh2RTTIGczqgLF4xTQ8PzYwvpfnDveHFtELEzZLH990nrdBo0BIhv5TZ5
         2ao59WrSp4Nhq7S7b9sIbuU5gnbi0LlE0fq6nBkaShvk8qE3b2kcBW4CzzUSQ4fIXBy8
         +QVggnXDMR/AKUoFwLsdmO9MkIY4kk9OZYm+P2cQOVGrzSsajue3Xip/1yojwVmAbuok
         gjXN87NHiKRMw0l/b6vuy1syD2n0z0gzZM1ssHEGJc/lrhGaszMSo3eAn9H0vB0mpNNi
         SQ7l7fAlOEYqgYogOcXC5ciZny4mvOyJTGcXyAXH/aYcaSuCR1/T7AdSWGDda36K3bpU
         K9wQ==
X-Forwarded-Encrypted: i=1; AHgh+RobdF9GlzND+nxH3KSo0plnXSha1t/mCQwX/RIbkc22w23jX/fXCUvnbb5uqCfXx/VF08U=@vger.kernel.org
X-Gm-Message-State: AOJu0YybKwC8LHHr8ATv6iqvZi4vbkiigYRLDQUHeX2hplspQNkkVGh2
	N4cT6i9eSdNwKxb6Q9vgPXdlKJnUCEm0F6TaDDZ2/bIfi3L1vBqE2UkiGAdRjMaK6XU+6Yx4czq
	vty+SXA==
X-Received: from plzv3.prod.google.com ([2002:a17:902:b7c3:b0:2c8:7fe:29ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32cc:b0:2c9:c083:cd49
 with SMTP id d9443c01a7336-2ca7e69dfe3mr34635215ad.14.1782942462488; Wed, 01
 Jul 2026 14:47:42 -0700 (PDT)
Date: Wed, 1 Jul 2026 14:47:41 -0700
In-Reply-To: <20260608145455.89187-9-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260608145455.89187-1-dwmw2@infradead.org> <20260608145455.89187-9-dwmw2@infradead.org>
Message-ID: <akWK_duG7ZsIekt7@google.com>
Subject: Re: [PATCH v5 08/34] KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the
 documentation on TSC migration
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 08, 2026, David Woodhouse wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c1897d939da9..6337f9b9d7ac 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5930,6 +5930,9 @@ static int kvm_arch_tsc_has_attr(struct kvm_vcpu *vcpu,
>  	case KVM_VCPU_TSC_OFFSET:
>  		r = 0;
>  		break;
> +	case KVM_VCPU_TSC_SCALE:
> +		r = kvm_caps.has_tsc_control ? 0 : -ENXIO;
> +		break;
>  	default:
>  		r = -ENXIO;
>  	}
> @@ -5950,6 +5953,22 @@ static int kvm_arch_tsc_get_attr(struct kvm_vcpu *vcpu,
>  			break;
>  		r = 0;
>  		break;
> +	case KVM_VCPU_TSC_SCALE: {
> +		struct kvm_vcpu_tsc_scale scale;
> +
> +		if (!kvm_caps.has_tsc_control) {
> +			r = -ENXIO;
> +			break;
> +		}

Uber nit.  For consistency with KVM's bizarre pattern here:

		r = -ENXIO;
		if (!kvm_caps.has_tsc_control)
			break;

> +
> +		scale.tsc_ratio = vcpu->arch.l1_tsc_scaling_ratio;
> +		scale.tsc_frac_bits = kvm_caps.tsc_scaling_ratio_frac_bits;
> +		r = -EFAULT;
> +		if (copy_to_user(uaddr, &scale, sizeof(scale)))
> +			break;
> +		r = 0;
> +		break;
> +	}
>  	default:
>  		r = -ENXIO;
>  	}
> @@ -5989,6 +6008,9 @@ static int kvm_arch_tsc_set_attr(struct kvm_vcpu *vcpu,
>  		r = 0;
>  		break;
>  	}
> +	case KVM_VCPU_TSC_SCALE:

Another stupid consistency nit.  Probably do this?

		/*
		 * TSC scaling information is read-only (it's a reflection of
		 * the TSC frequency, which can be set by userspace).
		 */
		r = kvm_caps.has_tsc_control ? -EINVAL : -ENXIO;

> +		r = -EINVAL; /* Read only */
> +		break;
>  	default:
>  		r = -ENXIO;
>  	}
