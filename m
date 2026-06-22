Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE7EEB3
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782170629; cv=none; b=WqwpPrQwR7ut4avoWxIBcnT2mKmk8UqAJt/bI9/x0MtYV4/qLUQ2/Fdgjdwoy+zoDGQwx6jp/zSRs9yNeJix0ceg9H/yzasp1Qda7QvMr/DD2cIYL/gO26QYQ5NFaYWGR9RQ+DClm8IJXP/iuUGzZLd12Hn1wMu9tTerGYJlsVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782170629; c=relaxed/simple;
	bh=iT76L4fVr9ilJU9xRM8ws1sAqll6cvyzaUE7RZDtkJI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b7OAD5P//TERh6JmRKywaps3uPyoB5DdHq0EunepdS5p87WLxleXgWjuWKkzTckCKkExYs/r2IXdf40KrT+kNhvM/RSYgqMnRLc7sPCOgSN0yPnpQY3JPHG2FpzpkUoX22qBS0GD9ZOtuqfXVUDZgCq3Tgx/WcTUu0w7zVZ/qOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rwg9UTgA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwg9UTgA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0532a6588so43324645ad.0
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782170627; x=1782775427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1l368LEMViqYsAYRY3CcxbJd6IIQZRI4794Ia7jsAaQ=;
        b=rwg9UTgAjiLIC2oHa24cU4iyDCJ9lrnkotKyNmL7O5co46Xd4k8NdUKak4tqWshpj2
         udMLpmUgTQQcRCAs+cPS3lvG3gArVLSZcS5nr9t9entKUJlhHTUgJgIqObmzxFglBk+l
         mcN+lM4nIeeTfXRr00n0TkM3JW3iYAd2fCBwJMDSf+A21+nQgcNWGrhQ/4++iaoK5SkF
         KB2Onx7BiK3y9M1VJsRIVp+Ip3GHalcqtAx5IH0JwQ8kZfPdloRA40rhrOM3MH+u+gXe
         e6tUdAehgZRJy24W5Rn0Da1HuOQlmyemta+fbe8Se4Qz1OKpKFQj7xU65pp7MDu3RgDT
         H31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782170627; x=1782775427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1l368LEMViqYsAYRY3CcxbJd6IIQZRI4794Ia7jsAaQ=;
        b=s+DKEnLlARbhr4xo8yRz4dETeP2DP0DLxHZaO3NXSLMxKXItXSGP8IzYLP7lt5jnkg
         n1gt7/ugh8bKsPWwmwKBTLkQD5pZAlgzvFdkh/KskNajOZIFDhJL8j0v33OJKJv8v+tA
         n0fDcMVrfw5pugtnDrRijoUocO3ghoj5Lh7Jw8ltX7QP6GPwmDMj0a8umZQgZZxnLzn8
         +VNXkAujbz8Jk92DoHSTbl7+ru58H/GI/4KAtuH2G6JPiJ0F1eExxM7I4g/Da/x0VON5
         l+10G783YLiOubG9blgWb9huRjheTe353h67hvyoDxZmjiIE6IcUJngGVs9Qolud/MH3
         U9rA==
X-Forwarded-Encrypted: i=1; AHgh+RojHQMO70yO0mSKv7U4StDuhGsq49EwobTlTFuApzirt/cJdw4Hud1mI10m6vGq4XXGES8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAUvgv2+ULEF4v2/sGCSBQ6lMarTOcCMmiMzfUD0lEAGLPBQyl
	tGRhkoBct0WP09/mE7sTmE8C8bKR0tE4iMF9t36fsncg2PPBJMBrmj9SXHg+itIhBF5NO6mqp3d
	8atnLQQ==
X-Received: from plom12.prod.google.com ([2002:a17:903:3c0c:b0:2bf:1486:2669])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f691:b0:2c6:a172:55a6
 with SMTP id d9443c01a7336-2c718f4ffa7mr171684595ad.9.1782170626901; Mon, 22
 Jun 2026 16:23:46 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:23:46 -0700
In-Reply-To: <20260621133708.3454718-2-mike.malyshev@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260621133708.3454718-1-mike.malyshev@gmail.com> <20260621133708.3454718-2-mike.malyshev@gmail.com>
Message-ID: <ajnEAkFGyJWmomhq@google.com>
Subject: Re: [PATCH 1/1] KVM: x86/mmu: Emulate, don't kill the VM, on access
 to a disabled passthrough BAR
From: Sean Christopherson <seanjc@google.com>
To: mike.malyshev@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Sun, Jun 21, 2026, mike.malyshev@gmail.com wrote:
> ---
>  arch/x86/kvm/mmu/mmu.c   | 16 +++++++++++++++-
>  include/linux/kvm_host.h |  8 ++++++++
>  virt/kvm/kvm_main.c      |  9 ++++++++-
>  3 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 91843e9224d04..115e2c4db5fa0 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4759,8 +4759,22 @@ static int kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
>  	if (ret != RET_PF_CONTINUE)
>  		return ret;
>  
> -	if (unlikely(is_error_pfn(fault->pfn)))
> +	if (unlikely(is_error_pfn(fault->pfn))) {
> +		/*
> +		 * A passed-through PCI BAR is backed by a VM_IO/VM_PFNMAP
> +		 * mapping whose fault handler refuses to install a PTE while the
> +		 * device's memory space is disabled (e.g. the guest cleared
> +		 * PCI_COMMAND.MEM). The fault then fails even though the memslot
> +		 * is still valid. Treat such an access as MMIO and emulate it so
> +		 * the guest observes Unsupported Request semantics, matching
> +		 * bare metal, instead of killing the VM with -EFAULT. Genuine,
> +		 * non-pfnmap errors still take the fatal path.
> +		 */
> +		if (fault->pfn == KVM_PFN_ERR_PFNMAP)
> +			return kvm_handle_noslot_fault(vcpu, fault, access);

I really don't like this.  It's an ABI change that affects years of precedent,
and the ABI it creates is very haphazard.  E.g. why should PFNMAP memory get
emulate MMIO semantics for this case?  And a PROT_NONE VMA really shouldn't get
MMIO semantics either.

I would rather have KVM exit to userspace with KVM_EXIT_MEMORY_FAULT and fill
run->memory_fault, i.e.

diff --git arch/x86/kvm/mmu/mmu.c arch/x86/kvm/mmu/mmu.c
index 26ed97efda91..aff6b82b0fdd 100644
--- arch/x86/kvm/mmu/mmu.c
+++ arch/x86/kvm/mmu/mmu.c
@@ -3534,6 +3534,7 @@ static int kvm_handle_error_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fa
                return RET_PF_RETRY;
        }
 
+       kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
        return -EFAULT;
 }
 
Huh, knew I had a feeling of deja vu.  I even proposed this as a fix a while
back.  I don't know why it didn't go anywhere.  Maybe simply because no one cared
at the time?

https://lore.kernel.org/all/Zr-8M9rYplgN6IS3@google.com
