Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22430569B
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411128; cv=none; b=emizzU7O7dOQmvq8hc5+m5NftWMGDQyMmfBquReAobSVYMzwjVipD1DhH5OgBOQPHAN07g+p3Nxt8AMyOuHG/Up8yh5ZUq2Q3LqfLZ5AFE+dHIaFS3s92hCaGgXqBvCjK8YS/ZVj283xTNDmlpKyDWecIyj6kevCP02qgsD6Lk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411128; c=relaxed/simple;
	bh=1PYPrh5cmW7j92HgEZsxX+MtgSZruUXIrXzPkSjifnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b+JEjB9ZCeE+SnRoRAPV5A9i0Fsv+vZ9aA5e0lYJhVtCZoN+RaGDbKPPRBR1C/07o9fscgbeCG/dr8OE8a8a1TQ2hBw3hmRye2UXDwBFqrHszDO09/Fx/hSfR4B9N56j4YUYaPQYJNknmd42Wyra5C3HfqTag5Av/VfvV50Qhig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wLj3yr40; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLj3yr40"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8923722247so151272a12.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782411126; x=1783015926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ytZubqtXwlHPvZAN+p1oFC5/Ov6kfqDqplPxrT9CpGE=;
        b=wLj3yr402erE2fLcvahXA8QdcIcUykM0SrGgplCZ7ZfFILjW48N4NAQtcza+0GImz3
         ubR65rUwRjC9AQJPv0fzCCmUEEVUhCUTwTgbCqitAt+rGeAn/ccHuQmzYf19va+m9ehl
         QaSHTQaC7a+pNTmGuBw5bDSFGHwwFNIH21zwiMnaw4K4rD5qCBwbMu9kUJ5LFU8aPakm
         SBj4TsMKACOYqShDtnz0oiHMyyi+Ji5jyJTdf3hHpmCWXRfy8vF8qlgk7OMl597Kt69H
         5zCs2MY28F6MHIy8uk5M8qmXceDe6QJWPh+hAzfc/8INzCYEjgWLBmNOsVxJaYub6xQq
         U3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782411126; x=1783015926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytZubqtXwlHPvZAN+p1oFC5/Ov6kfqDqplPxrT9CpGE=;
        b=HLdtGesW5OtOW8GtlPo+HIkpahhS6hSqlTvuvSTnLXTtBGdEP9JgcDtzQQqgIkFLyM
         xIEhvtfHsGuFuIIentQWGrwkG2CYaTqlUChc9/asKjFhy6Q2Ww/GBBRXSr1dj1rZZgDx
         sYkFzX87sk2Pk9FJAJQ37380X1HolHNN9aNbEoDFd0LmwJGRvQaE64ecn9Rl5b1Y0mMH
         w907cSHSUW2jkpUHOKqb4m9cLXjLN6pYTdQi11H0jToeCplXlr0eXgiHkp0SnyUPlo/K
         wyMYJEiebcwAGggc/dPAC9kQbtxfca4As9zecM+S3YAJXbQu0LFz1QCb19rcqU9Cu2aX
         MlDA==
X-Forwarded-Encrypted: i=1; AFNElJ/1vB1J5njLZ3CMrSMykE83JGj86h217G8VxCr/xJb4ZfzigYYmODlw5VDWWfMAvgHkCng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDg+EKr7CXp8mc46WEa+zxgnHoc6yEIMz+wpO9vH1c7bOa1jMI
	Qw0+6HlGvPOSxWh3/QerZs11KXzdm42gLnd3v9IQoBOuBWwaGEI+kDuwaiJasooaSu9C8YhK9Rx
	XFNa0eQ==
X-Received: from pgbfp5.prod.google.com ([2002:a05:6a02:2ce5:b0:c8b:ed9c:4468])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1bc1:b0:3bd:203b:b587
 with SMTP id adf61e73a8af0-3bd4b021e47mr4245885637.40.1782411125978; Thu, 25
 Jun 2026 11:12:05 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:12:05 -0700
In-Reply-To: <20260527-kvm-locking-docs-v1-1-4fe8b602ff47@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com> <20260527-kvm-locking-docs-v1-1-4fe8b602ff47@google.com>
Message-ID: <aj1vdb1VxNilPa9i@google.com>
Subject: Re: [PATCH RFC 01/12] Documentation: KVM: Elaborate comment on kvm_usage_lock
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Fuad Tabba <tabba@google.com>, vannapurve@google.com, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Ackerley Tng wrote:
> The original comment talks about cpus_read_lock() and kvm_usage_count, but
> doesn't explain why they are related.
> 
> Elaborate comment on kvm_usage_lock to provide more context.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  Documentation/virt/kvm/locking.rst | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
> index 662231e958a07..5564c8b38b9cc 100644
> --- a/Documentation/virt/kvm/locking.rst
> +++ b/Documentation/virt/kvm/locking.rst
> @@ -248,8 +248,23 @@ time it will be set using the Dirty tracking mechanism described above.
>  :Arch:		any
>  :Protects:	- kvm_usage_count
>  		- hardware virtualization enable/disable
> -:Comment:	Exists to allow taking cpus_read_lock() while kvm_usage_count is
> -		protected, which simplifies the virtualization enabling logic.
> +:Comment:       ``kvm_usage_count`` serves to deduplicate hardware
> +    virtualization enabling and disabling requests from different VMs
> +    being created.

kvm_usage_count does that and more, i.e. this is 'wrong" by being incomplete. 

> +
> +    Hardware virtualization enabling/disabling requires taking
> +    ``cpus_read_lock()``.
> +
> +    ``kvm_lock`` used to also protect ``kvm_usage_count``, but other
> +    parts of the Linux kernel holding ``cpus_read_lock()`` need to
> +    call into KVM to ensure that VM state remains consistent with the
> +    host's state. For example, when the CPU frequency changes, KVM is
> +    notified. ``kvmclock_cpufreq_notifier()`` takes ``kvm_lock`` to
> +    iterate ``vm_list``.
> +
> +    To decouple these, use different locks, ``kvm_lock`` for
> +    ``vm_list`` and ``kvm_usage_lock`` for enabling/disabling hardware
> +    virtualization.

I appreciate the effort, but honestly I think this does more harm than good.  I
already know what this code does, and the above confused me more than anything.

>  
>  ``kvm->mn_invalidate_lock``
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> -- 
> 2.54.0.823.g6e5bcc1fc9-goog
> 
