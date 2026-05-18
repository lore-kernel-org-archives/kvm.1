Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC53E00BB;
	Mon, 18 May 2026 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092276; cv=none; b=tJezLVgG9lmsGOO8KAmwG9EkNBRPGtpGjPDLcIfcD8AiuhkQKk4DcYGUBkDolKgxOIj9SBbPlDO4EH2OpmffLNeUVi/EFRThzD7jcDa/EjlNjR0e/RdJeu8M3jmmR35R7JITmrslzfSpiC74TqZPd9/JWT35akclLWbObqEss0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092276; c=relaxed/simple;
	bh=d5BRpIzONiFycGWrVQ6G7WPVm7yxvxoGCcQ8cuM8tGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuVYwxua8M8QQsiZKxIQTAHXAC1j74lGgw+KVRx4v9W8dO3VDdetGy1EzYIHqb+WGQNsjMY8I0vKGaNbRX5sWyJUc/dyIch3oS58VLX/fcj2scnP68me/YmHMNa+DNep8FwN4Hctt8uINdvvReSWb/R2BXJwnpJJIa7IlnYMss8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=b+V9aKB6; arc=none smtp.client-ip=115.124.28.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="b+V9aKB6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1779092264; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Ml//VcpcK6nN5KaD+E2Rd1lM0M8q/+Pu4hPT5T4uUSA=;
	b=b+V9aKB6w55kDs7DHjN9Er9eXgejVNhDPuEBnCvxBWI8UBO+xVTOi4VvOKTkWk9Z4duiJsB0nuGQzsGREwJfo1WkybB12olfiI20ChmXNAdaPCNvYgxLXs6VBbano9A4nacfG/50XRak3WwluCqbRO5CZ1e9Kofq4yn+/fRYZWk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037021130;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---.hZqhtAB_1779092263;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.hZqhtAB_1779092263 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 16:17:43 +0800
Date: Mon, 18 May 2026 16:17:43 +0800
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH v3 01/10] KVM: VMX: Refresh
 GUEST_PENDING_DBG_EXCEPTIONS.BS on all injected #DBs
Message-ID: <20260518081743.GA24112@k08j02272.eu95sqa>
References: <20260515222638.1949982-1-seanjc@google.com>
 <20260515222638.1949982-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515222638.1949982-2-seanjc@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, May 15, 2026 at 03:26:29PM -0700, Sean Christopherson wrote:
> Move KVM's stuffing of GUEST_PENDING_DBG_EXCEPTIONS.BS when RFLAGS.TF=1 and
> MOV/POP SS or STI blocking is active into the exception injection code so
> that KVM fixes up the VMCS for all injected #DBs, not only those that are
> reflected back into the guest after #DB interception.  E.g. if KVM queues
> a #DB in the emulator, or more importantly if userspace does save/restore
> exactly on the #DB+shadow boundary, then KVM needs to massage the VMCS to
> avoid the VM-Entry consistency check.
> 
> Opportunistically update the wording of the comment to describe the
> behavior as a workaround of flawed CPU behavior/architecture, to make it
> clear that the *only* thing KVM is doing is fudging around a consistency
> check.  Per the SDM:
> 
>   There are no pending debug exceptions after VM entry if any of the
>   following are true:
> 
>     * The VM entry is vectoring with one of the following interruption
>       types: external interrupt, non-maskable interrupt (NMI), hardware
>       exception, or privileged software exception.
> 
> I.e. forcing GUEST_PENDING_DBG_EXCEPTIONS.BS does *not* impact guest-
> visible behavior.
> 
> Fixes: b9bed78e2fa9 ("KVM: VMX: Set vmcs.PENDING_DBG.BS on #DB in STI/MOVSS blocking shadow")
> Cc: stable@vger.kernel.org
> Reported-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> Closes: https://lore.kernel.org/all/b1a294bc9ed4dae532474a5dc6c8cb6e5962de7c.1757416809.git.houwenlong.hwl@antgroup.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 1701db1b2e18..a0a0ccf342d3 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1909,6 +1909,24 @@ void vmx_inject_exception(struct kvm_vcpu *vcpu)
>  	u32 intr_info = ex->vector | INTR_INFO_VALID_MASK;
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  
> +	/*
> +	 * When injecting a #DB, single-stepping is enabled in RFLAGS, and STI
> +	 * or MOV-SS blocking is active, set vmcs.PENDING_DBG_EXCEPTIONS.BS to
> +	 * prevent a false positive from VM-Entry consistency check.  VM-Entry
> +	 * asserts that a single-step #DB _must_ be pending in this scenario,
> +	 * as the previous instruction cannot have toggled RFLAGS.TF 0=>1
> +	 * (because STI and POP/MOV don't modify RFLAGS), therefore the one
> +	 * instruction delay when activating single-step breakpoints must have
> +	 * already expired.  However, the CPU isn't smart enough to peek at
> +	 * vmcs.VM_ENTRY_INTR_INFO_FIELD and so doesn't realize that yes, there
> +	 * is indeed a #DB pending/imminent.
> +	 */
> +	if (ex->vector == DB_VECTOR &&
> +	    (vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
> +	    vmx_get_interrupt_shadow(vcpu))
> +		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
> +			    vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);
> +

This matches a version of the modification I had considered earlier.

Reviewed-by: Hou Wenlong <houwenlong.hwl@antgroup.com>

Thanks!

>  	kvm_deliver_exception_payload(vcpu, ex);
>  
>  	if (ex->has_error_code) {
> @@ -5485,26 +5503,9 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>  			 * avoid single-step #DB and MTF updates, as ICEBP is
>  			 * higher priority.  Note, skipping ICEBP still clears
>  			 * STI and MOVSS blocking.
> -			 *
> -			 * For all other #DBs, set vmcs.PENDING_DBG_EXCEPTIONS.BS
> -			 * if single-step is enabled in RFLAGS and STI or MOVSS
> -			 * blocking is active, as the CPU doesn't set the bit
> -			 * on VM-Exit due to #DB interception.  VM-Entry has a
> -			 * consistency check that a single-step #DB is pending
> -			 * in this scenario as the previous instruction cannot
> -			 * have toggled RFLAGS.TF 0=>1 (because STI and POP/MOV
> -			 * don't modify RFLAGS), therefore the one instruction
> -			 * delay when activating single-step breakpoints must
> -			 * have already expired.  Note, the CPU sets/clears BS
> -			 * as appropriate for all other VM-Exits types.
>  			 */
>  			if (is_icebp(intr_info))
>  				WARN_ON(!skip_emulated_instruction(vcpu));
> -			else if ((vmx_get_rflags(vcpu) & X86_EFLAGS_TF) &&
> -				 (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
> -				  (GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS)))
> -				vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
> -					    vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS) | DR6_BS);
>  
>  			kvm_queue_exception_p(vcpu, DB_VECTOR, dr6);
>  			return 1;
> -- 
> 2.54.0.563.g4f69b47b94-goog
