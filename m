Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D53B8944
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784928585; cv=none; b=pJ+VG28Jx9xuq8q1fay9HLQaiKn+6p+CWIU2pqfWbChq8bUR0gadW/VspWybZ+/mMvaPR0ulh1cGSsDwY0Wz0tRwn3kSJMHF70nILoApNNZzyMwjcS50Fm4waa3DgJcOcMtaxF+b3W0N9UkyNvGIGZqyrcnI5KQDG6MUujH4kys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784928585; c=relaxed/simple;
	bh=R8kivS+PAT8BTHF7UsSksEuqQUzOURbJU+P2fAuFGUg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PyOSocRCvr5U2uV6h92Wb9iAK7Yd4vd3NeG/9tOH8mZop46x2NFUXtyow3LJVLi3Uw4PQVu4cmidtoA5Fqyu48KfRamL3bjR+qis/gcjI23Kt9JVFglmY48zJt/3ecV8jsHbkyQ3Esf3Y17E2nLQClGAc6SXHo5gp6Pyd2z/HTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=euRxa9UZ; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="euRxa9UZ"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85798977dcso1314596a12.0
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 14:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784928583; x=1785533383; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LeEjIRradrtHITbFsKRpe0yq9gWXW7YqA8y6Nt7MYfg=;
        b=euRxa9UZYByAEZ8NdwDRanjH/Q38iYh/zlccg4xx+7YrkpFQl8yBEhVFdXsldxsXnT
         U7yabo0bk8AD1vqMNGXo4w7u3WNkvX/MwOiQ9J5xqptvq/4oSD850Yo1HxDvJF6Nh16D
         XWgR4Z7NVglSm6LE6GnAaUmAlzZNfg1rbS0IeeumkgXYLpjDYjJyaW5PBpxKapShS1xA
         NAtNNNpzZBnteKPTal8dPQ/qsxOSkTgBVhE0pg1wZYkoW4Fitcu32BYM7wgvCtaDdY6b
         dLL9B4L5Gj1d9ysHZ9b8TrVEQrwZyMpWkxdjL8DZgKj1t9hFbKJof+90xVpztDYZ9eAI
         yaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784928583; x=1785533383;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LeEjIRradrtHITbFsKRpe0yq9gWXW7YqA8y6Nt7MYfg=;
        b=rW5PyfARjtcuId2zafnjYW1pODJE5ExAkXyLx+aLrH4hkYu96bFWnWGtSnv/qNRNlq
         /TgoRM9YNqUSHkaT84EDkea6rVfSnjt8pYrsTnBDdwLTQYFzVoSJE+KAkIuaOL+p6Nt8
         /J/w5strs7zBC/eXXdHAUmFJv0TPj2HF9wS9PkrRklbgsPcBkFk98vSGkSwoJ57rDL1u
         k+s+3k4HnXFpRKudYZMFIxm2i7K0/4z4V2R+vKOuxQQZU7dvjqGca+5vVEfQNpx639u9
         0S89/w0xlWHyA+I0g3YLZi7l5c0v+VasIxzQXkolHgxG8DTd0bjxWWSILActhH50+f/5
         7yzg==
X-Forwarded-Encrypted: i=1; AHgh+RrkHE+6mHOh/pnemUwp4EsEjrNFA2C3OtuBJuR1oZH6BWpvbb1eOo4GxDkUTP6o+bfJ/fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqUSR63hpEWIzItZKLb6QtUv+KgIlOYQrlycWrhAnD3nOXbEb
	gpD0oyS7+TpQ/KbC0R4Q6c+njqj2PTha6mNDW0I5IXFXUontlQo2pwtst+2aPeC8cw7Cl+Z3RdN
	45EX+KQ==
X-Received: from pgbcm9.prod.google.com ([2002:a05:6a02:a09:b0:c85:8035:8b21])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d52b:b0:3c3:e411:418a
 with SMTP id adf61e73a8af0-3c67e164e76mr39234637.70.1784928583222; Fri, 24
 Jul 2026 14:29:43 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:29:42 -0700
In-Reply-To: <20260703212145.343527-13-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703212145.343527-1-dwmw2@infradead.org> <20260703212145.343527-13-dwmw2@infradead.org>
Message-ID: <amPZRkxTLE-rZcJf@google.com>
Subject: Re: [PATCH v6 12/36] KVM: x86: Restructure get_kvmclock()
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

On Fri, Jul 03, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Simplify the use_master_clock condition: the open-coded CONSTANT_TSC ||
> cpu_tsc_khz check is unnecessary since use_master_clock can only be true
> when the host clocksource is TSC based, which in turn requires a stable,
> constant and synchronised TSC across all CPUs.
> 
> Given that, the get_cpu()/put_cpu() pinning is not needed either: both
> the TSC read and get_cpu_tsc_khz() are CPU-independent when the master
> clock is in use, so drop them.
> 
> Wrap the entire use_master_clock block in #ifdef CONFIG_X86_64, since
> use_master_clock is never true on 32-bit (host_tsc_clocksource is only
> set under CONFIG_X86_64), and declare hv_clock inside the block so it is
> not left as an unused variable on 32-bit.
> 
> Use 'continue' on the master-clock success path so the non-master-clock
> computation becomes the common tail, avoiding a goto and label. When the
> clock read fails (e.g. clocksource transitioning away from TSC), fall
> back to that path rather than proceeding with uninitialised data or
> spinning in the seqcount loop.

Please split this up.  The changelog suggests there are at least three logical
changes here.  Yeah, the series is big, but smaller patches helps with review,
even if it results in more total patches.

> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kvm/x86.c | 42 ++++++++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 50f088570dab..37b1f8192842 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3203,40 +3203,38 @@ static unsigned long get_cpu_tsc_khz(void)
>  static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
>  {
>  	struct kvm_arch *ka = &kvm->arch;
> -	struct pvclock_vcpu_time_info hv_clock;
>  	unsigned int seq;
>  
>  	do {
>  		seq = read_seqcount_begin(&ka->pvclock_sc);
>  
> -		/* both __this_cpu_read() and rdtsc() should be on the same cpu */
> -		get_cpu();
> -
>  		data->flags = 0;
> -		if (ka->use_master_clock &&
> -		    (static_cpu_has(X86_FEATURE_CONSTANT_TSC) || __this_cpu_read(cpu_tsc_khz))) {
>  #ifdef CONFIG_X86_64
> +		if (ka->use_master_clock) {
> +			struct pvclock_vcpu_time_info hv_clock;
>  			struct timespec64 ts;
>  
>  			if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
>  				data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
> -				data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
> -			} else
> -#endif
> -			data->host_tsc = rdtsc();
> -
> -			data->flags |= KVM_CLOCK_TSC_STABLE;
> -			hv_clock.tsc_timestamp = ka->master_cycle_now;
> -			hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
> -			kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
> -					   &hv_clock.tsc_shift,
> -					   &hv_clock.tsc_to_system_mul);
> -			data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
> -		} else {
> -			data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
> -		}
> +				data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC | KVM_CLOCK_TSC_STABLE;
> +
> +				hv_clock.tsc_timestamp = ka->master_cycle_now;
> +				hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
> +				kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
> +						   &hv_clock.tsc_shift,
> +						   &hv_clock.tsc_to_system_mul);
> +				data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
> +				continue;
> +			}
>  
> -		put_cpu();
> +			/*
> +			 * Clock read failed (e.g. clocksource is transitioning
> +			 * away from TSC). Fall back to the non-master-clock path
> +			 * rather than spinning.
> +			 */
> +		}
> +#endif
> +		data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
>  	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
>  }
>  
> -- 
> 2.54.0
> 
