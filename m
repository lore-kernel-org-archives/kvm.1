Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F330F803
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760512; cv=none; b=DuAIimiQ6ytIWEFm36acPzvuuOoXeHG3PC2WDb97uPp9l7h21EL1Baqji4CinLKavSF87PeLCGg2k1ODAjUmED/ys6fuADliLny0pyyUVoiCl6xWYBqAoBVRlzCbb44VLB2wRPh5FWGUd1c420/0GhyMnSXQyppRAU3wRA6eWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760512; c=relaxed/simple;
	bh=oi+mUvzPfK8LlpJUTvPXE7+uPtnRh4ldWTv67DSosQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Aqk7jA7rs8LGSfWwHlXu8bvWt6m5K1zWUdr8oz4q50esl7AGQ/nEjofjqU5fsWl+P/ghL9f3wkqcdCGCtpLLaPPn8kd1FC78vde75DWPUQE9FCMekfD77vytZi/em/3MPwRBbLX62JD4Oqs3jl4ZnzLjEy8M9LUNDd5uCQo9bos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnokjCWd; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnokjCWd"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82ce34a78edso1348438b3a.1
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775760510; x=1776365310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9vrnjsb38GnSnF5fq9GbywTKmgIirXool5yzcQOMGs=;
        b=mnokjCWdmAS79uaw4X6d7JbpqNjbP01673wWbZo+I2N2W8thbtVHWIFECuRNRIAHOD
         KfhW0hKYP/OAPCM049qdZDBm3ytEgWhI3IldKE+yHepm+IPaY+1KSlNWXPrTRMnyiBAN
         7oHH3eCrNWrsx4PUFvAmZ3aiUQDI90i/6TNesVbZVz+HlJmUsKaNBYy4JCWm3D1IgdR4
         cdjRD/MzXZS3F89juP2lq+jRToDgiB8/+bRCI/TyN7AfTO54Vem9gve56v4ACUdpvAJb
         u4awZLv92dOLFLFoZ7fPHYDzB65FzI7//BRfiBK6/Q8Kea62A8/D/HjmjRVUY/Ec5H/x
         nunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760510; x=1776365310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9vrnjsb38GnSnF5fq9GbywTKmgIirXool5yzcQOMGs=;
        b=Rc9FyNPotdwua3kOVgjvvT1wHyV9Yte6uSZQ4XdTteA8o4WZkZCF+sRSJ+syA7n0gb
         R8+A2u3jmvd88v56mkvxhNKhqrh6wW9Iovw33APzkSdEBeCq0tYwdRrIAY5cX9dOjK9a
         jm/seljQPEIgg0oBcS7n+WRlQDEzbXuG6T802R2U1j17pdpZ96ZB0FXRf1i5RffQwSns
         KiYxVCyp4ibQltY14Li6Z04TRJFx45u2xIhjbwkHXZDMLEKLCHI9RWvTP2ISTJl0Tuim
         0PT6o8iGWwtrEuOxMKrVGjnF5q3ne7KLECJ/ANghWIRm/4a/ShohFf7KPBjsXdw837Lr
         hQqA==
X-Forwarded-Encrypted: i=1; AJvYcCWOZJTvAlPuq6vtavE+NuX0kl4WzoOMuWgSyvzxb0oY5G6MTovitu5tg1wcGyvuPkIsqwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyL3M2lbst+sP6oUvcDyjGmfS8RJqeFILBisyJqxh/ssyVgaBV
	zZ71smQh0ZsKFkkxUrt3PXA0utJxi/3oKoIKuYXr1qs9zeEzMgGCh5fHHAcqaQHJ20hcmM9Q/uu
	qT46Frg==
X-Received: from pfcg3.prod.google.com ([2002:a05:6a00:23c3:b0:829:8b7d:2b76])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2283:b0:82a:6461:6d15
 with SMTP id d2e1a72fcca58-82f0c375d5cmr286204b3a.46.1775760509995; Thu, 09
 Apr 2026 11:48:29 -0700 (PDT)
Date: Thu, 9 Apr 2026 11:48:28 -0700
In-Reply-To: <adc1IrD8uqWdaOKv@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com> <20260310234829.2608037-13-seanjc@google.com>
 <adc1IrD8uqWdaOKv@yzhao56-desk.sh.intel.com>
Message-ID: <adf0fHP8sSk6j9G4@google.com>
Subject: Re: [PATCH 12/21] KVM: SEV: WARN on unhandled VM type when
 initializing VM
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 09, 2026, Yan Zhao wrote:
> On Tue, Mar 10, 2026 at 04:48:20PM -0700, Sean Christopherson wrote:
> > +	default:
> > +		WARN_ONCE(1, "Unsupported VM type %lu", kvm->arch.vm_type);
> After pulling the latest kvm-x86/next, I encountered this compilation warning:
> "arch/x86/kvm/svm/sev.c:2954:30: error: format %lu expects argument of type long
> unsigned int, but argument 2 has type int [-Werror=format=]",
> 
> So,
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 75d0c03d69bc..ca09c06d1e80 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2951,7 +2951,7 @@ void sev_vm_init(struct kvm *kvm)
>                 to_kvm_sev_info(kvm)->need_init = true;
>                 break;
>         default:
> -               WARN_ONCE(1, "Unsupported VM type %lu", kvm->arch.vm_type);
> +               WARN_ONCE(1, "Unsupported VM type %u", kvm->arch.vm_type);
>                 break;
>         }
>  }

I'll squash the above.

How did you find this?  E.g. did you cherry pick the commits into a different
tree or something?  AFAICT, thanks to commit 11bb4944f014 ("x86/bug: Implement
WARN_ONCE()"), WARN() and WARN_ONCE() currently don't have any validation of
the format.  I posted a patch to address that gap[*], but it's driving me crazy
that I can't reproduce the issue without explicitly removing the definition of
HAVE_ARCH_BUG_FORMAT_ARGS. :-)

[*] https://lore.kernel.org/all/20260409182941.1912856-1-seanjc@google.com
