Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729308;
	b=vEXd9fOe6RWsufueTrEE8eEASdV6Q2qya0m12xpYCC/iYKzSBlB5x6H2gf+dM5wayrU7
	 iH2+jZcuMAtNBJgMgBpf4o4tS0hbLiGdOexCzmVkjzOGbOoM/4Cxxkp3amg6v8/5/5H5b
	 T/nvEARszLsOY8oyPG14us6OmMXpReLecUH2WqGnPJ8gwEJadL4bHVzV9yb/CsNRlsF2Q
	 uxa8kOqFzIC9oztDBJSf6n0/a6Rf6rNWrHIqz63/lJgDB9nPr2UET8vwqvFOhh2U1T1UR
	 oWyld6N1osSVvNkd34z6UNyEVS2ZPz3MdWD7sE842dwUJLt8yG/wD31ae0Zcsu4A3zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=aIKiDgYd/jXgONymQ12SSZ5b8e5yxBJKR0/jjx24Mc0=;
	b=jqW1+q2xMLvM9mcaqIDN9Tuhi9softpPkbP5pSuOFPb8TkbCWAzVoFvC26y6yeKLHSor
	 9HzKIyXnDIoKn8tBjTPf0upYFUI4UbzK+suaKzUgEzYpnbW6uKX4JNtaDOMmSV/Odd7Q5
	 WlVah2Bj5pV0tReO1wDDKWj6qdQIPVm2xwSA4TAqTTzNOgvhWqvdnwu6DmnEZsfAYv675
	 tAchDTb6Yd/fsWHKxLCWHWgOWeMSSv7eGYKZMFE+vztrZ93aiBx8pR8IyjqDVYVLNCvR6
	 ny+hVKo5xSo1QdsrMXKLzHJP2EZbO4ZXO6+n7O9Yt8MJsG7+T6v7bNbBCjGj9hmi0EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pjM0am6+;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE85606A324
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 18:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCE85606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pjM0am6+
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso7455806eec.0
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 10:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793729307; x=1794334107; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aIKiDgYd/jXgONymQ12SSZ5b8e5yxBJKR0/jjx24Mc0=;
        b=pjM0am6+Rgo2yftlp1GqexQpoRm3ayyV/7AWG7PKMkJQsjd0PErZQhxXQs8yZ3P2d2
         F1LWKPTElCoMg80tzCyajDHBoIWj2AQkTCcyJYnUlH86v+UcMcNf16aie6lFnMqLck4r
         ISoVW7lI99boYuR9+B2t2FVY3vFtWHb4tBMi5+HvUznELrAetM/zlvxol9iIGYuuypw+
         ks1JGzr/mVGXvfIouELVug9utfJaibpL6i+BkTYBTVi92Ps58z6e3ujbzFZslHVUyKTD
         +z6bxcR6JbaDl3e6mipTVr080MF4zDSGdLS6yvZY+n5wX3ELSPeu5Np4nSvBDiOVHtZ6
         jYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729307; x=1794334107;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aIKiDgYd/jXgONymQ12SSZ5b8e5yxBJKR0/jjx24Mc0=;
        b=HvwdC/fKdUXDhs7Aitcqb+T1QXjqJ7UY1Bw8tZo79k5Q7TdileM6qkfTTQ+mAuRDNU
         2uAehtVWDupLUqdbBjyGLcY3jCmrVTJ35AJWq0QRURbaflc4Cnba3s4+NQNzqbNh65H+
         BHi+gAqua3k0yoE9Gk2BYRe9lr4QkppgIKNsSBRUbMhTefmL6i4otIrxClZbU6Un57zT
         /wWlMJCr4Pr9rLAlFHwNC6PETjyLZmQgzVubITeMZXy+jzzeP65Inui261ZUB03wURxN
         +TpQGnGAL4DzzfPps8EgXD1BnDObUz0qqhUc38bKOPIUm+38FdRd0WztoHAVPSM+2Hgm
         VgJA==
X-Forwarded-Encrypted: i=1; AKwUvBxjPoePGm6sfttqi2e+7pbNWjrju8esFFCkm02wMeqBmEF+M+HL7LABjefjEOvbDsUE66U=@vger.kernel.org
X-Gm-Message-State: APuU4Z978nkd0sysXOL2Tn85lBTMhSnUopragpYFBUXuZAX0iCftPj3t
	XFLEd7JipUByXKUzUwt3FHkVTl9G3Rdq5tSxYdvNZYj85Bt73d1Chdv0
X-Gm-Gg: AYBFou3e8nJidPrn+lt/lXFr41u3bRPxDG8UJS36/zrnSTudfNlDIc2DpjesTDs/Fos
	GWeTrP1arhyQ7vjCKz0MsqZAEi9y3LqDlUvD+ffKRVc1wf1HcXPoTnXgESICsv7j0aGP6f5Kxy6
	aqPWb+xuaJ3YFDPpvIDd2uIqKGmuFhvFUGopeJZ3hxJisWbkk46WYP58TXPJ5kUIupOeUU5Xa8w
	8+9eN5mOUPPd7Cj8n37JErWoKuHAhTSI3EzwuYsO0hAly82bI63G1rKaFSs8SSE929XmAoQt0Vo
	/lG94FjaymetvSnukjpnr1lp0/cvUY1WvEbTZ78Mr9Gjbzx8xFnrXpq53mewzI7kGVCliVztBk8
	la/ONtFuB3MEr57j3ABtdYcUfEyOwfTpxKz+L+8pvs3U5bKyy/u4oGsk7Z8sXtgvMnF7wd0EGrW
	HByXgi5VnWnAdG4i5nw4uJvCFQdk1Df/SqlKhjHYfd3xMxKdpIdREHKRid6xIdwWwB8f5izoDgv
	2tgd2wxpIS2tcsSsxkeVBZ1IzNr1xaiwguQrupWC9LW3BXIIsVOJHUMO3i0/UOmscBWrNqAcuRV
	7Kj2GTc7EuX2KvvVBUXK5eASFf2TorU7TTT0y8zkK9hUXZiy
X-Received: by 2002:a05:693c:87c6:10b0:367:5e31:ce29 with SMTP id 5a478bee46e88-36a42404ab3mr21838555eec.20.1793729306698;
        Tue, 03 Nov 2026 10:08:26 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a96172sm44904557eec.27.2026.11.03.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:08:25 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH v4 03/23] KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
In-Reply-To: <20261030212112.2598640-4-seanjc@google.com>
Date: Tue, 03 Nov 2026 22:51:44 +0530
Message-ID: <tslx6dav.ritesh.list@gmail.com>
References: <20261030212112.2598640-1-seanjc@google.com> <20261030212112.2598640-4-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Sean Christopherson <seanjc@google.com> writes:

> Flush/zap every memslot in kvm_arch_flush_shadow_all(), i.e. when the
> owning userspace process is exiting, as KVM must ensure all associated
> memory is unmapped from the guest.
>

That's true and yes, this looks like a miss. I guess it must have gone
unnoticed because after the owning process exits, and when the vmfd is
closed it will issue a teardown. So the escape is only until the vmfd is
closed...
  kvm_arch_destroy_vm() -> kvmppc_free_radix()

The change looks good to me. I have only tested this on my qemu+dev
setup for now. But will give it a try on real hardware as well.

Thanks for taking care of this. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/powerpc/include/asm/kvm_host.h |  1 -
>  arch/powerpc/kvm/powerpc.c          | 11 +++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 708a32f89776..50a42f80e5f1 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -910,7 +910,6 @@ struct kvm_vcpu_arch {
>  #define __KVM_HAVE_CREATE_DEVICE
>  
>  static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
> -static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
>  static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
>  
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 9194cf492d1c..9e9d0865c2f6 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -764,6 +764,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  	kvmppc_core_commit_memory_region(kvm, old, new, change);
>  }
>  
> +void kvm_arch_flush_shadow_all(struct kvm *kvm)
> +{
> +	struct kvm_memory_slot *slot;
> +	struct kvm_memslots *slots;
> +	int bkt;
> +
> +	slots = kvm_memslots(kvm);
> +	kvm_for_each_memslot(slot, bkt, slots)
> +		kvmppc_core_flush_memslot(kvm, slot);
> +}
> +
>  void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
>  				   struct kvm_memory_slot *slot)
>  {
> -- 
> 2.56.0.385.gac671c819a-goog
