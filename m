Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F4D37269B
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517792; cv=none; b=MZrZ2SMoRrKq2O6qyjMv9cgHBzXKvn40xDXgbEct+HfM43hif12fH/JdQ35j9vHIJs9mT2fmrQhOHn5X68EqfImYJH2yWabeHNehbMDyEILY62LWuUPn0DAEnlX1txf3G/TSKgyL9e3oPWJtNIgQV8FidqhmGtyPv+j/twMSyRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517792; c=relaxed/simple;
	bh=SC3W3f8odNqmLPQ5jk9l0PDzMsaA9uPQMtpPxXIHo10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h8TREYqwJo3hDZA++CNvysGNcnOzcv7mD2SSYcFbVeP9qVYX16bG127FoyQlcQIMWSH+ugU/oXQ6X+yoRPrnfhFLu7Ek5HNyz8pfse0iodw0mMXtHk+Zja7kNiJW4ORQaGblu9AsrRIZTI8QhsSL3A9CHAlb8VgDphgXjJx0xC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SEqIyxfY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SEqIyxfY"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-848452dd146so1803367b3a.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783517790; x=1784122590; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BsuMXMKCfagFyuFxdoKczu47VXQMXKuH3Dpr7pHjR+w=;
        b=SEqIyxfYDx44zaMEheELIsRfB7Ck+g3lROg0RtzqAZCDAkZXdl2Azs8TMldfBRNQ+z
         3fOEs6nQGoIMiUm/zgctLXwpPx64Kzp2RZwJ/5InDvmFa4Dz3ZnAdZ/ed11oEMrug44v
         WTv8X6b38NBU58r46QpzDDHI/z53vboNx6HXFwhtVsCoZ+YK4gdRLys3e2eVp1NzM51a
         hs4G3WSX9jEZjhUNyQQzuKseAAT26jgd55sXL5V53j/Wjntx5Tn1d4efnCN4Rgio9gK+
         1J1ZCtNyvlhiJyBsdQPxkxHCtfFL5Dszgn5ltp/BoqsBJraLNV//RJZGHwo8+Jhyw/nU
         soqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517790; x=1784122590;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BsuMXMKCfagFyuFxdoKczu47VXQMXKuH3Dpr7pHjR+w=;
        b=s7UxidrMkp4S170nrnRPmDTQTMRwKoTBnddBXcChn9wTHVPSoWJHXxHqvWFDouyLSF
         9OypBFYFC1xRoX/SESLcuQdV+H6Ez23NwpYR2w8/xTQfGn+WuKnNrKsbJ1/99b6xVTVw
         ACUaFUgjBL+Kk/Oy+9zpxzFV0W1uiQCew4hGaJsNfoLx3umo722df8fvm+SYp7o3jP1p
         zvvPryMRvNKWrB87khUyzW2m4flXGrN9Gr0jIaYiNN1BeWIABdvg0RnZVPabwVVYbfMo
         6YKS89rNf7do9xHi5VufB94Nry95DOHmOnSGfbETROYV5FduxZ/PtDjGBcOY/LpdwuBo
         N6mQ==
X-Forwarded-Encrypted: i=1; AHgh+RrVu9g5JU4gtZNMzbXIk4vOVQrdaNV49JiKVClrXdZWzzBs8wTgzzUY5dn5libC0loP+Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN7AYScXkg9Ps4HgXKccxann4hWkHrmnYsI1JZimT+FHVfNUVi
	fcq2IEtFEtjmTsqFsrS/PpWIjcam1UG0zl7aUHm88Ic49PqaXmivZ1hoVOzQjYZMlcuz+0sq3vE
	XoWN9KA==
X-Received: from pfuw2.prod.google.com ([2002:a05:6a00:14c2:b0:847:7ffd:ce5e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12d8:b0:845:cf86:9469
 with SMTP id d2e1a72fcca58-8484327c8a2mr2415200b3a.29.1783517790268; Wed, 08
 Jul 2026 06:36:30 -0700 (PDT)
Date: Wed, 8 Jul 2026 06:36:29 -0700
In-Reply-To: <20260708091408.12106-2-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708091408.12106-1-sarunkod@amd.com> <20260708091408.12106-2-sarunkod@amd.com>
Message-ID: <ak5SXWcvtVLL0eKs@google.com>
Subject: Re: [RFC PATCH v2 1/5] iommu/amd: kvm/svm: Improve API between SVM
 and AMD IOMMU
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

This should be two separate patches, one to rename the @cpu param/field, one to
replace @ga_log_intr with flags.  "Improve XYZ" is the equilavent of a do_work()
function.  And I'm having a hell of a time trying to review this because of the
overlapping churn.

Actually, if you insist on a "flags" field, three patches: rename, convert to
flags, add the dedicated RUNNING flag.

On Wed, Jul 08, 2026, Sairaj Kodilkar wrote:
> The name "cpu" in the parameter is misleading as it represents the
> physical apicid of the cpu. Hence rename it.

Hrm, I was going to suggest having KVM pass in the actual CPU instead of the APIC
ID, because the fact that the IRTE takes an APIC ID is an implementation detail
that would ideally not bleed into the API.  But unfortunately KVM uses the entry
in the physical ID table when filling amd_iommu_pi_data.cpu, so taking the APIC ID
probably is the least awful approach.  :-/

> Introduce flags to determine the state of the vCPU (running or not) and
> posted interrupts.

> This is useful as following patch overloads the apicid (formerly cpu) field
> to determine GAPPI destination when vCPU is not running and it can no longer
> be used to determine if vCPU is running or not.

Rewrite the GAPPI behavior with --verbose to explain *why*.  The only reason I
could suss out the why is because I already know how Intel posted interrupts work
and so could intuit why GAPPI would want to keep the APIC ID valid.  Without that
knowledge, this is unreviewable.

> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>  arch/x86/include/asm/irq_remapping.h |  4 ++--
>  arch/x86/kvm/svm/avic.c              | 22 ++++++++++++++--------
>  drivers/iommu/amd/iommu.c            | 24 ++++++++++++------------
>  include/linux/amd-iommu.h            | 14 ++++++++++----
>  4 files changed, 38 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
> index 37b94f484ef3..40a2206a33c0 100644
> --- a/arch/x86/include/asm/irq_remapping.h
> +++ b/arch/x86/include/asm/irq_remapping.h
> @@ -35,8 +35,8 @@ struct amd_iommu_pi_data {
>  	u64 vapic_addr;		/* Physical address of the vCPU's vAPIC. */
>  	u32 ga_tag;
>  	u32 vector;		/* Guest vector of the interrupt */
> -	int cpu;
> -	bool ga_log_intr;
> +	int apicid;
> +	int flags;

Why use flags?  This is on-stack data, packing booleans into flags adds no value
IMO, and makes the code way harder to read.

>  	bool is_guest_mode;
>  	void *ir_data;
>  };
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index cdd5a6dc646f..7862b13c5409 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -932,6 +932,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>  		struct vcpu_svm *svm = to_svm(vcpu);
>  		u64 entry;
>  		int ret;
> +		int posted_intr;
>  
>  		/*
>  		 * Prevent the vCPU from being scheduled out or migrated until
> @@ -949,10 +950,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>  		 */
>  		entry = svm->avic_physical_id_entry;
>  		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK) {
> -			pi_data.cpu = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
> +			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
> +			pi_data.flags = AMD_IOMMU_FLAG_VCPU_RUNNING;
>  		} else {
> -			pi_data.cpu = -1;
> -			pi_data.ga_log_intr = entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
> +			posted_intr = !!(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);

"posted_intr" is misleading, and IMO flat out wrong.  Even when a GA Log Intr
and notification is logged/sent, the virtual interrupt is still posted to the
vCPU's virtual APIC.  I have no idea what you're trying to capture with this
code.  And that is yet another reason why this patch needs to be split up: so
that you can explain the reasoning and logic behind this refactoring.

> +			pi_data.flags = posted_intr << AMD_IOMMU_FLAG_POSTED_INTR_SHIFT;
