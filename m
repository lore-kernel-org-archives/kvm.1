Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795565381;
	b=ie0uDdFwihEIgBv5b1sy2yxstyZv5a4K1qFaCW7po7qudq2un5w+TzQyaotohyFer+tf
	 98z8HeRRURr/Fu1SLu4GqqInHmjbHniGdwO7mE+Pzk+Cit1JCplbAkJvbKlk3B6qZ24XZ
	 8qAY2MTfJxKMpU6pX4ApzryE90bPpBJXALMkICx3fK131FC9m2AQkuloZ3EgJ0g9vlr4x
	 96oxTf7sDsPRs+HmiJJyChfIVA4ojPpqtloMR5L/xdVP+kJc1rjhLpQ6T1mRPExj+u0wh
	 LJV2yrEswQcvj0A1na733baCforvzAip49ZiqoaGYCXriloe1Yar7S2SHXhbTOefJYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=rntaW4qP7qUm/rpCDs8AkAc3u/q2bwtFH1Dwu9ED+9M=;
	b=GPwu83Fg9uPSttu0x8PaZlNwntMcl9cQFhop1zSu/VJAgFpa1TUmJVl5dfd7KPPovfwz
	 PdxvAUtKGDXn6ymDbE0TyFQ8Nz8t+xK0ge3nqBYS40WIQpl2oBh+xNMoTamALP90f/m4x
	 aRd2to3ln3VZsE5SSFfDArHh+9/cBvH5W393tYqdD6x1Oynd8mLmo1qhYcvi1juoTwn5N
	 XVZ+ljQ9yqANixtPBINqS35iMtedT4/z+g7zLNIbyz35xZPG5t0YlsqYBoXusOdnG2i8r
	 CWFp/q6Uzhda43wpHmlVVynSvWxLY/xOTtce4K+c2kiW+3/VKztaQ1Cemh0uxbXG3gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EoozwYOo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A1606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 00:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 723A1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EoozwYOo
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-921375f52b8so55279926d6.2
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 16:09:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795565380; cv=none;
        d=google.com; s=arc-20260327;
        b=X9cryNCS9m07Zx5nCNluWQA4mZJkPTOjaeGAfxB6EVczmGxqaWIkenlHTgSDSYZj2R
         4WqhZ6k8rwQjbtuAnBUoe/GHdWRBfBKIupgOxpVznXWtagHCYxPbTTW8Any2ftaRnJYz
         Wc5wCJlYLt73sp530bl2/ooUZzzJraIAudHFSdkoOv5rIPT7FTIUPHd7roEfXMQ6a8mZ
         wWNMGMT1FdBgeKY0rc+ynJWKrX/6HWz1BnCO4uRGFsdjFj8IYlPEWwF7rHJR9w3kkCMR
         9SlNEWNXG34C9HPd4yIU28dqtM8oP8Rot7OaqT/HfvlpHGR7N4NJcNptZatseuvbkokr
         +Lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=rntaW4qP7qUm/rpCDs8AkAc3u/q2bwtFH1Dwu9ED+9M=;
        fh=znCtlalE2FsdJ6iNu7wo7vd3qPkftCnSWZ4t6eR671M=;
        b=oNCYdpsoa9rkpDO5UMKlHeOny8fKWpG/aX27Bw/9eWtuzg1DOnXOnzZ0b+fiL4vEdt
         uZqptSwzloZ39lEEoxuYJrWw+Ag+a5y6tnl1lwYxXMT0ne0J63SszP+hKtFpYxFChOVB
         KZA7qhwQT396MDAyTuaAFTr8gA8aIxMjssXSjDe8G3ELcDjUxDULDK1WOMiGNIGEI1YM
         dQAj3MuCeg7Tk61yK6SzGH4Rw/Hz1rhQ9pzQYKS/UKqR0zVCygfXfWHfv/tzR6mym3q8
         q7HZcBscL9mrejcnxTOGLNqIVbgaXJduhS+IIGvywvLnTetJV6VU1xvsGHa52Q1Dg6/F
         CeZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795565380; x=1796170180; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rntaW4qP7qUm/rpCDs8AkAc3u/q2bwtFH1Dwu9ED+9M=;
        b=EoozwYOo2VCUVVRapq5PS7IaIBR4fcvD5QRF3ydamDfYc7rVeOovvIWGEc8cHi4pt3
         7iXgwXk46n6iZUsztTjdfdbNEEYYrvjuXYfN8BNAKXBHKde2LWKtTO2CXvJ4opCiVt61
         NgycPBdTTeDrXByUNhUhleu8ejvFbSvfXtsbnVQJekCSqBHUoOdD+vLpWoXKQAePrWSa
         2vAOpZPqnabHSvCLXF/vzzV3dkMUiHgTNnApg+h+Wvb6rm6152Fgc8TkHnmhQt8LcphF
         aNO2TcAF4uXgc52R6D/c108OKYGFaWzw7K9ISf01ognjwLvowVVf6feiychAtg0nbpQe
         HubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795565380; x=1796170180;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rntaW4qP7qUm/rpCDs8AkAc3u/q2bwtFH1Dwu9ED+9M=;
        b=RgPV3gRPjFsnZ1s8EWxhN/0iKDJnWoB7TZwNr0Cs+Ca034JdLR0nMcR2eyAjtul97c
         H9kqBqYQcla3pEyEdCK9wLXoxpaJz14ce0Q69zf1qrrWXJe5jw/apcEucgNT/ivnjS2D
         tdNcRldBQLU4jaklJYQJlLPX2dDvfcBNII3x0maAk2vvq1Vuoi+Sf7tvwGKm+7Px0Wv2
         +xP4O3eZF6zlGeZdCWRFA/icswQ5we0HprG5m5yTPjsrTxvgmQrg29eigaisnDvyvqRB
         hTv3om8AFz8J5DNohcLONgI0wLMisXMUFX9GRiwQG1llInN+HW/EyVXkfY9oAeMCDDH5
         cgqQ==
X-Forwarded-Encrypted: i=1; AL+hErFRUX3kEIKcn95RsAzHIWC1uaaKrnIx3NwTARu0MGANBTfI0H2S1/eLLlXGKc6WIZq9h90=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XOMpqN5ORXNp0VlhmjcdFMGvmmoBHZHSQtHTePJDdTTLDbGqa
	jyv7TyfhMu0SP+e+y3QImPKfW3amTKWZsVp45buPzJcHph331uZ4RLzMTA2p2qPcjY3AW4puOPr
	qMPReA/CnohSnsNGpBUUfcBo23iwsWBtw9KHl3cif
X-Gm-Gg: AZFdTZfkf4/OLk76x3MONizrGHCeTtv/MWJbUMopY6S07+fuKfdO40zlHVojn+241DY
	6uG6oDepbhaqvgI6YASwYQTjODCywtSQV2GlN9/LlD0poq0g7eygw7WN5SCeGBPFdEZfodBnOkl
	V0ZVUFoSl3mztccMsRef0BCzI43j5rnEOtJJzRWEbMgJl4YG8b8Y112F5/gqjTzus44bXJWbUkU
	rKcyDF22rReT3rlx1Y98/bFJHSNnEmB8dBTvxV2vryS1XvPBMWZBiXTBHT5noqhCrqOBiFinDJv
	ZtQcQvmIwO/DN+afiVnM4o1jTdekyD8z25G14JPIK1O4OLWvtaEuWbqEekPGh7gNqlIrEQHxXEQ
	67T6DRTv3DShPA5HF2eghq6JMjJoplzZKOwVgEy2S28Ty3NydUBSE5rBlGbcs71qdgN243SqzWD
	xXI5WZrlth0GQegBLo/M3sR0s=
X-Received: by 2002:a05:6214:3c9d:b0:91c:9316:f4e8 with SMTP id
 6a1803df08f44-92134baab8amr275174306d6.54.1795565379417; Tue, 24 Nov 2026
 16:09:39 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 16:09:38 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261123104233.95710-10-steven.price@arm.com>
References: <20261123104233.95710-1-steven.price@arm.com> <20261123104233.95710-10-steven.price@arm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 16:09:38 -0800
X-Gm-Features: Aa3M54oNKjHnmwhcyDiHaoxz_zNMiDJBoB2YChnt0u_TPYjP0NAb6dZlL994CUs
Message-ID: <CAEvNRgFQ5BXqU3KfPFT8bfZTW=RyvBw25z3GZtr3JA=Wv3Yqfw@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] KVM: arm64: CCA: Prevent memslot modifications
 after Realm creation
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kohei Enju <enju.kohei@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

Steven Price <steven.price@arm.com> writes:

> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Once the Realm is created, prevent changes to guest_memfd backed
> memslots, which can provide private memory. Validate these changes
> before KVM invalidates the old memslot, so a rejected deletion leaves
> its stage-2 mappings intact. Realm stage-2 faults will also validate
> the private memory backing in a later commit.
>
> Require Realm memslots to lie in the lower half of the IPA space, as the
> upper, shared half aliases the lower, protected half.
>
> Define kvm_arch_has_private_mem() so generic KVM recognizes Realm VMs
> as supporting private memory. Defining the macro also makes
> gmem_in_place_conversion true for every arm64 VM, so guest_memfd
> memslots are marked gmem-only even for non-Realm VMs. A well-formed
> KVM_SET_MEMORY_ATTRIBUTES2 request on a non-Realm guest_memfd now
> reaches the VM check and returns -EINVAL instead of -ENOTTY.
>
> Additionally, similar to pKVM, do not support dirty logging or
> read-only memslots.
>

Imo this could be split into a few patches

1. Add the constraints wrt realm memslots and being in the lower half of
   the IPA space
2. Defining arm's support for private mem
3. Imposing rules on memslot changes
4. Maybe some others, maybe I'm misunderstanding the patch

> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
>
> ---
> Changes since v3:
> - Explain the arm64-wide in-place conversion effect and keep the
>   general IPA limit comment.
>
> Changes since v1:
> - Preserve private mappings if KVM invalidates a Realm guest_memfd
>   slot before the prepare hook rejects its deletion.
> ---
>  arch/arm64/include/asm/kvm_host.h |  2 ++
>  arch/arm64/kvm/mmu.c              | 37 ++++++++++++++++++++++++-------
>  2 files changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 3ddeddfacd06..55673d08e3eb 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -1607,6 +1607,8 @@ struct kvm *kvm_arch_alloc_vm(void);
>
>  #define kvm_vm_is_realm(kvm)		((kvm)->arch.vm_flavor == VM_REALM)
>
> +#define kvm_arch_has_private_mem(kvm) kvm_vm_is_realm(kvm)
> +
>  #define kvm_has_mte(kvm)					\
>  	(system_supports_mte() &&				\
>  	 test_bit(KVM_ARCH_FLAG_MTE_ENABLED, &(kvm)->arch.flags))
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 800333a345cd..9af5fe6d87f0 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -2861,17 +2861,32 @@ int kvm_arch_validate_memory_region(struct kvm *kvm,
>  {
>  	lockdep_assert_held(&kvm->slots_lock);
>
> -	if (kvm_vm_is_protected(kvm)) {
> +	if (kvm_vm_is_protected(kvm) && new &&
> +	    (new->flags & (KVM_MEM_LOG_DIRTY_PAGES | KVM_MEM_READONLY)))
> +		return -EPERM;

gmem is already generically mutually exclusive with
KVM_MEM_LOG_DIRTY_PAGES and KVM_MEM_READONLY, so before this change,
pKVM is saying no to KVM_MEM_LOG_DIRTY_PAGES and KVM_MEM_READONLY for
all memslots, gmem or not, so this check makes sense.

> +
> +	switch (kvm->arch.vm_flavor) {
> +	case VM_PROTECTED_PKVM:
>  		/* Cannot modify memslots once a pVM has run. */
>  		if (pkvm_hyp_vm_is_created(kvm) &&
> -		    (change == KVM_MR_DELETE || change == KVM_MR_MOVE)) {
> +		    (change == KVM_MR_DELETE || change == KVM_MR_MOVE))
>  			return -EPERM;
> -		}
> +		break;

Not sure why pKVM doesn't allow deleting a memslot after the vm is
created, but this is no change from before this patch, the removal of {}
here is mixed in with the other changes in this patch.

> +	case VM_REALM:
> +		/*
> +		 * Once the Realm is created, we cannot modify any slots that
> +		 * could be providing private memory. i.e., guest_memfd backed
> +		 * slots.
> +		 * TODO: Handle trusted device private memory slots
> +		 */
> +		if (!kvm_realm_is_created(kvm))
> +			break;
>
> -		if (new &&
> -		    new->flags & (KVM_MEM_LOG_DIRTY_PAGES | KVM_MEM_READONLY)) {
> +		if (kvm_slot_has_gmem(old) || kvm_slot_has_gmem(new))
>  			return -EPERM;
> -		}
> +		break;

Imo this should be written the same way as the pKVM branch for clarity,
like

if (kvm_realm_is_created() &&
    (kvm_slot_has_gmem(old) || kvm_slot_has_gmem(new)))
        return -EPERM;

but that aside,

1. Why block creating memslots after realm is created?

Does ARM CCA have no way to add pages after a VM starts? This isn't
blocked for TDX and SNP so I think this constraint seems unnecessary.

2. Why block deleting memslots after realm is created?

This also seems like an artificial constraint, and it constrains the way
the userspace VMM operates when stopping a VM, like the memslots can't
be removed ever, the VM just has to be closed? (something like that)

> +	default:
> +		break;
>  	}
>
>  	return 0;
> @@ -2883,6 +2898,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>  				   enum kvm_mr_change change)
>  {
>  	hva_t hva, reg_end;
> +	gfn_t ipa_limit;
>  	int ret = 0;
>
>  	if (change != KVM_MR_CREATE && change != KVM_MR_MOVE &&
> @@ -2891,9 +2907,14 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>
>  	/*
>  	 * Prevent userspace from creating a memory region outside of the IPA
> -	 * space addressable by the KVM guest IPA space.
> +	 * space addressable by the KVM guest IPA space. Realm shared IPAs alias
> +	 * the corresponding private IPAs, so Realm memslots must reside entirely
> +	 * in the lower half of that space.
>  	 */
> -	if ((new->base_gfn + new->npages) > (kvm_phys_size(&kvm->arch.mmu) >> PAGE_SHIFT))
> +	ipa_limit = kvm_phys_size(&kvm->arch.mmu) >> PAGE_SHIFT;
> +	if (kvm_vm_is_realm(kvm))
> +		ipa_limit >>= 1;
> +	if (new->base_gfn + new->npages > ipa_limit)
>  		return -EFAULT;
>
>  	/*
> --
> 2.43.0
