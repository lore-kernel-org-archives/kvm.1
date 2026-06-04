Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7B4C6EFC
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593780; cv=none; b=GONqGoU1j53lrENfwtgw4kS3p/WeDSIqVmY35PcIT2fjA/b8mRDbfwRV9kCD4JVqjmucbY+yRhPVVVF0Prhrxo3uKgonBSSpfRWZMNn4wTjnfnXo9hoPjNQHEj2rSj2By8fGcTdGkDiqNAC//JmOSWHcSN9R5L+lKd5xeJEQM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593780; c=relaxed/simple;
	bh=AhQK675Yv/iwPXwqMrmv1Nwu/2jFO4tCsdflTEVyPM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vEd9Otj3mNMQ85YoZ3NcCl/qbcSfBwy8xrWrwdnQD+i8EmcMuGKne9XVlwK2vmR5KN7smhKarY3kEtC3lAyk9BTX1eXBcB3vRBaYnYnP2ADG/PlnwgcNgKoahL/O7abfVfEjdsGoNrrH+xAUClJND7Vt9To9/pKnz/5IB8pcv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rPLQMI5z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rPLQMI5z"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c36f4b76so10325965ad.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780593778; x=1781198578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O64NDjfMzI51Ryen2hmstoyQBHQinBYW+3MlX/bgX8Q=;
        b=rPLQMI5zDF4BMny1W4G97wV9R0hETyDOjQEmbnQ9eoJvDNAOE5rRfJJu6fFwfE5nP2
         ttiLFj6LmaFz8jTnR3/UFXPsQttp2Q+GzfcyJBR1FQAA5Gb0GAbc240na5dV1kr0IY6W
         8CdB3+uI963gmxnbuNF3bPfg/KOMfKcq3OtUw8vuNbUbzafTe4iZJjx1uJctssU/DRGu
         2KBRMNCwO583d5/dgrke10HS8Q4bnatliawcZH4gFHuiaxN5BC2r5lYFdSLoRZb3qKqn
         94trDHXXudYLXBIRIwvYn2T4PjAZ3m495wft4VGDhawEhpKzL1EHgxUzf9e6KHtPm354
         uTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593778; x=1781198578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O64NDjfMzI51Ryen2hmstoyQBHQinBYW+3MlX/bgX8Q=;
        b=NXPe/mNT6UsBjCGy8X0wmguzPdMnqj00vKJqDEKKKjIqDeCdPFaCk/LDmOCzINt4dq
         xKfqoX3lA03X67OA25XHWVsbA+IBNVlcbcBlIJWtim0czBqEuGPNKGoJTUqsdFLPji1T
         ZIv7T33TC4+4vlMlhfvpf1PYoZ9gmnvflhOCkkM/18Q8H/WIvnNvVZAjXDA3uddR1hUr
         DkQBLeCZlWTeVNudPNGD0ropjInvVmYLtAlgcHttry5P1YUfHUw2MZxMJG/35MIh1phh
         bLiCOR4WpmcNrMFiLE9ioeZ0gUR6UAtbnc1wTa3u4F9sBQa7dia+IowRWy5ZIAhZENVG
         8bog==
X-Forwarded-Encrypted: i=1; AFNElJ9tNZ26FtOOEq74OXt2egxH37qsUQ/GYLj+eiSeuMlH7tcsBGamLHIWszXINxZD6/8y/A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykqxsefhRKZyeGoIQYkhqNCm0EZZ0rFb0lPLLU6iQFUARbph+f
	sW30aOyWH2oW7CI7U31ajdpWChWLgHp1l4ZGU0gnW2imat2T11z7+aaQg0uNfUvu6YftpuGuxwo
	59XUAmw==
X-Received: from pgbdo8.prod.google.com ([2002:a05:6a02:e88:b0:c85:82f6:34d4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:730e:b0:398:b95c:51ed
 with SMTP id adf61e73a8af0-3b4cd03dd4emr44237637.35.1780593778275; Thu, 04
 Jun 2026 10:22:58 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:22:57 -0700
In-Reply-To: <20260604020143.748245-15-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com> <20260604020143.748245-15-jrhilke@google.com>
Message-ID: <aiG0cTYFHrQcwcgz@google.com>
Subject: Re: [PATCH v5 14/21] KVM: selftests: Verify non-postable IRQ
 remapping in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Josh Hilke wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Add the -n flag to tools/testing/selftests/kvm/irq_test.c to route a
> portion of device interrupts as NMIs (Non-Maskable Interrupts) into the
> guest using an alternating pattern of 4 NMIs followed by 4 regular
> interrupts.
> 
> While this adds coverage for NMI injection, the primary goal is to
> validate KVM's handling of non-postable interrupt delivery.
> Specifically, the transitions between posted and remapped modes.  NMIs
> are used for this purpose because they are a reliable, architectural way
> to force these code paths.
> 
> Co-developed-by: Josh Hilke <jrhilke@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  tools/testing/selftests/kvm/irq_test.c | 44 ++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
> index de8c29baa2b0..ed48562318bf 100644
> --- a/tools/testing/selftests/kvm/irq_test.c
> +++ b/tools/testing/selftests/kvm/irq_test.c
> @@ -17,12 +17,15 @@
>  static u64 timeout_ns = 2ULL * 1000 * 1000 * 1000;
>  static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
>  static bool guest_received_irq[KVM_MAX_VCPUS];
> +static bool guest_received_nmi[KVM_MAX_VCPUS];
>  static bool irq_affinity;
>  static bool block_vcpus;
>  static bool done;
>  
>  #define GUEST_RECEIVED_IRQ(__vcpu)	\
>  	SYNC_FROM_GUEST_AND_READ((__vcpu)->vm, guest_received_irq[(__vcpu)->id])
> +#define GUEST_RECEIVED_NMI(__vcpu)	\
> +	SYNC_FROM_GUEST_AND_READ((__vcpu)->vm, guest_received_nmi[(__vcpu)->id])

Add a wrapper macro to simplify/consolidate the core logic:

#define GUEST_RECEIVED_INTERRUPT(__vcpu, __nmi)	\
	((__nmi) ? GUEST_RECEIVED_NMI(__vcpu) : GUEST_RECEIVED_IRQ(__vcpu))
