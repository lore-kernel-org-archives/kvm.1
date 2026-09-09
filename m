Received: from mta0.migadu.com (out-228.mta0.migadu.com [91.218.175.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D1A348C7B
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788923384; cv=none; b=W9jWDv8DLV38jQeHzIQMQW+nQd3o1z/fmcf75yrPDDfTTGN5DNKJTfdYToeyMuNDD2MvD2NMLVz8O1LoQRvcX3iTlFt8/GIT4UJOA3wTiD1c2w7+N19xb6pk8x3FC2RyKmsZSKVZaFUi+m+6OASrBjx9Cf2IyzMwgoKRfy6YR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788923384; c=relaxed/simple;
	bh=RXrQnKUEg3IUJ+OP/axxe71l8wKhriuY3ujhvm5zR18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWVlGmhMMEXGScfGxAeK/018uf+591q8JMVU8nZ6zbv/wdbHhuI+V08+yhyWfMOqF2iK+s0ba65AMk5sLYYsJ38nFU1K3luo3u+OciycEhYe/bKQECfRh37TrBOmCHoVzSCqKgZ9IMm2Ts4tGmvuBlCDWK7oef7nK3iuLvDeVvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ePDZRaaF; arc=none smtp.client-ip=91.218.175.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ePDZRaaF"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RXrQnKUEg3IUJ+OP/axxe71l8wKhriuY3ujhvm5zR18=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788923375; v=1; x=1789528175;
 b=ePDZRaaF8MIFDlDp5IQ5LMWQkbMkg0P6uBIsU7r65G00SNDEp5Ww2lrWxi2l1zvXXXI0xdk+
 ucnBMRYIUoOR1Cpxp5wcTv+aIE1GElOVhxnvu+N0ZJ6FC15reiVwjx7K3YLbpXGKIqbXvUSgEzR
 lRkPmLAJCB3T2k9w6MRg9fhY=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7f6c250d02df995e;
	Wed, 09 Sep 2026 03:09:35 +0000
X-Mizu-Trace-ID: 7f6c250d02df995e
X-Migadu-Flow: FLOW_OUT
Message-ID: <afc3cd9a-e0ef-4508-9def-e3cc4998f1c3@linux.dev>
Date: Tue, 8 Sep 2026 20:09:30 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SVM: Clear AVIC Physical ID table entry if vCPU
 creation fails
To: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Dmytro Maluka <dmaluka@chromium.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20260903062856.2090499-1-naveen@kernel.org>
Content-Language: en-US
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260903062856.2090499-1-naveen@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/2/26 11:28 PM, Naveen N Rao (AMD) wrote:
> If vCPU creation fails after kvm_arch_vcpu_create(), the AVIC Physical
> ID table entry corresponding to that vCPU continues to point to the
> freed APIC backing page which can result in UAF. Address this by
> clearing out the corresponding AVIC Physical ID table entry in the
> vcpu_free() callback, similar to the VMX commit b41f2ca6c060 ("KVM: VMX:
> Fix stale PID-pointer table entry left after vCPU free").
>
> Though unlikely, it is also possible that svm_vcpu_create() itself fails
> after the AVIC Physical ID table entry has been setup if memory
> allocation fails in svm_vcpu_alloc_msrpm(). Clear the entry in this path
> as well.
>
> Note: this change depends on commit 97d65b544f48 ("KVM: Check for
> duplicate vcpu_id as early as possible"), which ensures that a vCPU with
> a duplicate ID is never created. Otherwise, a valid AVIC Physical ID
> table entry for an existing vCPU will be cleared.
>
> Fixes: 44a95dae1d22 ("KVM: x86: Detect and Initialize AVIC support")
> Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> ---
>   arch/x86/kvm/svm/svm.h  |  1 +
>   arch/x86/kvm/svm/avic.c | 10 ++++++++++
>   arch/x86/kvm/svm/svm.c  |  6 +++++-
>   3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index e958943b8162..790bd96a9791 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -954,6 +954,7 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb);
>   int avic_incomplete_ipi_interception(struct kvm_vcpu *vcpu);
>   int avic_unaccelerated_access_interception(struct kvm_vcpu *vcpu);
>   int avic_init_vcpu(struct vcpu_svm *svm);
> +void avic_vcpu_free(struct kvm_vcpu *vcpu);
>   void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
>   void avic_vcpu_put(struct kvm_vcpu *vcpu);
>   void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 3b037e385523..bc2c699380b3 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -885,6 +885,16 @@ int avic_init_vcpu(struct vcpu_svm *svm)
>   	return ret;
>   }
>   
> +void avic_vcpu_free(struct kvm_vcpu *vcpu)
> +{
> +	u32 max_id = x2avic_enabled ? x2avic_max_physical_id : AVIC_MAX_PHYSICAL_ID;
> +	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
> +	u32 id = vcpu->vcpu_id;
> +
> +	if (kvm_svm->avic_physical_id_table && id <= max_id)
> +		WRITE_ONCE(kvm_svm->avic_physical_id_table[id], 0);
> +}
> +
>   void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu)
>   {
>   	avic_handle_dfr_update(vcpu);
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ea647938a2a6..c2a2ae7d8ec3 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1337,7 +1337,7 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
>   	svm->msrpm = svm_vcpu_alloc_msrpm();
>   	if (!svm->msrpm) {
>   		err = -ENOMEM;
> -		goto error_free_sev;
> +		goto error_free_avic;
>   	}
>   
>   	svm->x2avic_msrs_intercepted = true;
> @@ -1351,6 +1351,8 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
>   
>   	return 0;
>   
> +error_free_avic:
> +	avic_vcpu_free(vcpu);
>   error_free_sev:
>   	sev_free_vcpu(vcpu);
>   error_free_vmcb_page:
> @@ -1365,6 +1367,8 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
>   
>   	WARN_ON_ONCE(!list_empty(&svm->ir_list));
>   
> +	avic_vcpu_free(vcpu);
> +
>   	svm_leave_nested(vcpu);
>   	svm_free_nested(svm);
>   
>
> base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97

FWIW, we had the same bug report from kres. This patch fixes that.
Verified on AMD beragmo with x2AVIC enabled and a reproducer that makes 
KVM_CREATE_VCPU fail with EMFILE after the entry is published.


Tested-by: Atish Patra <atishp@meta.com>

