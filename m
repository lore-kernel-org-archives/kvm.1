Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F053B058E
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358184; cv=none; b=QAY1H/wGcgb+SPUp7UsZezcRH8xZFuOxq2L2SB1QykzyQkHcOr7nGV9bdD5JMvEzmLMq7Mj7oYyseS3MxvgOpf+puq+n58RTUqvY9QoS77/YliyHyAjvrhGnpfgdtWh9++bpqnOxCsUbsLOqGLmlqHIQka4lHhOcZnXNW0rpQfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358184; c=relaxed/simple;
	bh=w7FcuUb/R/a0M+MGIXkGOPJph/mK2Z3sn5pARQ2613k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DTVO66g3tbdrth/Gi4dd3VFnA0m2FlBskw7Hqp2DCcgLb0YAxv7rH5C97usngUm4+aIYtXgGYnQTToJ9M3iEpChOAJn6+vMQKw7DlbZV4R201OjKXepo/8xX+6N6O46Mx9n5jnJ80VFxcdAFpwabJBR7XYJ/ykMUrnP3WwnTZLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PvxeQuwo; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PvxeQuwo"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc51591102fso734895a12.1
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790358182; x=1790962982; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FCqoqAPPOLCbKQSZIIdLUliCeSof0LliHmfhQs8+pog=;
        b=PvxeQuwoJCufCoSY8ZhArILBM4wgldqFV/S27hl/x9uhkg6UWFRWcha64TnUBltwta
         nqzidZnXXV7JVh4KM4656XuZSxdrAk6e5NZy0uXxiQIbliv/AcBbZzR/ntUBeysz9ru+
         g7e5yl7+r8KkjwSZY5XbjmgIe++NOld/iNT4DwdmZG2UlqCmBCCAuVxhRRvJwfn+AGBE
         nvRp42bNIRxj5pd+MVRXfW5fi7xUxoh8sLJoT7FRSwclLBDJpk2UGnnaN3nBTUm45+B2
         Fm8wd6r5q7mUIN50m4UPVF+2qkP6lWEe4kKh7s+FvN1U38wbTYSxxDd6ShkqcYUF2SeU
         aW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790358182; x=1790962982;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FCqoqAPPOLCbKQSZIIdLUliCeSof0LliHmfhQs8+pog=;
        b=bxh1fZEA1YrKKw+5qpiU6TYMJl0yEtcblAj/sWSsaeIxT0qZku5SsWwfbcKW0wy08Q
         T5Fl0p1CE04saLqVIgiDQ+OhTsR4Wowq0xO/J+eB6Cqrm0HEeKVmTkKBhTwN4UWnGOfa
         lS7hSkvG9DTtMdrPzEI+BMqPHRk2weWuxkT5dhCYDOZ637nBwA40GQX+Sf5SorLTSmjw
         nFJm5Q6qLU2wX4o1nSDqJXJg0433oRdwpgpPEzRZxYSHgnqZzs5F0NRGymoes8gLJ4CA
         iBrToaAWJT/VuhEezUVdnk6bkhuL/mL1EKrw4b+gbyhHhFYQoOJ7uGDRnOaEH1HOC6FJ
         EQaw==
X-Forwarded-Encrypted: i=1; AKwUvBxoeEO8+qllhWH4bpiApeJiuEE8n8lYxmFxMjc2ntPrCwW9ezAkct0vwGrgEycIpwiAZbc=@vger.kernel.org
X-Gm-Message-State: AFuF++m/dlJu7iDwEESObIdYnnDOz/VUCmXXssH0YcppnR/KKSbTldGb
	hfwiQkrnanZV1rssYDPoW8xW+0qtfle96yPAcm/Qqw4LCISPAvg3wC+TA/dggO1x8JYnzWjJfXI
	kghEXlA==
X-Received: from pjbml8.prod.google.com ([2002:a17:90b:3608:b0:3a0:ab35:7896])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d81:b0:3a0:b50d:50ea
 with SMTP id 98e67ed59e1d1-3a0b50d527emr2898459a91.28.1790358181529; Fri, 25
 Sep 2026 10:43:01 -0700 (PDT)
Date: Fri, 25 Sep 2026 10:43:00 -0700
In-Reply-To: <20260721050600.87268-5-shivansh.dhiman@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721050600.87268-1-shivansh.dhiman@amd.com> <20260721050600.87268-5-shivansh.dhiman@amd.com>
Message-ID: <araypKKIb0-Cp_iL@google.com>
Subject: Re: [PATCH v4 4/5] KVM: SVM: Turn DEBUGCTL_RESERVED_BITS into a helper
From: Sean Christopherson <seanjc@google.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, 
	kvm@vger.kernel.org, x86@kernel.org, yosry@kernel.org, jmattson@google.com, 
	thomas.lendacky@amd.com, nikunj.dadhania@amd.com, ravi.bangoria@amd.com, 
	santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 21, 2026, Shivansh Dhiman wrote:
> Replace the static DEBUGCTL_RESERVED_BITS macro with a helper,
> svm_get_debugctl_reserved_bits(), and plumb the vCPU into
> svm_copy_vmrun_state() so it can be passed to the helper.
> 
> The vCPU argument is currently unused (marked __maybe_unused).

There's no need to tag parameters __maybe_unused, AFAIK no compiler ever complains
about parameters, only local/global variables.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 9b1afa47c54c..dbde186ccb81 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -820,7 +820,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
>  		 * svm_set_msr's definition of reserved bits.
>  		 */
>  		svm_copy_lbrs(&vmcb02->save, save);
> -		vmcb02->save.dbgctl &= ~DEBUGCTL_RESERVED_BITS;
> +		vmcb02->save.dbgctl &= ~svm_get_debugctl_reserved_bits(vcpu);
>  	} else {
>  		svm_copy_lbrs(&vmcb02->save, &vmcb01->save);
>  	}
> @@ -1203,7 +1203,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
>  }
>  
>  /* Copy state save area fields which are handled by VMRUN */
> -void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
> +void svm_copy_vmrun_state(struct kvm_vcpu *vcpu, struct vmcb_save_area *to_save,
>  			  struct vmcb_save_area *from_save)
>  {
>  	to_save->es = from_save->es;
> @@ -1230,7 +1230,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
>  
>  	if (kvm_cpu_cap_has(X86_FEATURE_LBRV)) {
>  		svm_copy_lbrs(to_save, from_save);
> -		to_save->dbgctl &= ~DEBUGCTL_RESERVED_BITS;
> +		to_save->dbgctl &= ~svm_get_debugctl_reserved_bits(vcpu);
>  	}
>  }

...

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e9f2456982d4..ccf85ea79d37 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3164,7 +3164,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  			data &= ~DEBUGCTLMSR_BTF;
>  		}
>  
> -		if (data & DEBUGCTL_RESERVED_BITS)
> +		if (data & svm_get_debugctl_reserved_bits(vcpu))
>  			return 1;
>  
>  		if (svm->vmcb->save.dbgctl == data)
> @@ -5037,8 +5037,7 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
>  
>  	BUILD_BUG_ON(offsetof(struct vmcb, save) != 0x400);
>  
> -	svm_copy_vmrun_state(map_save.hva + 0x400,
> -			     &svm->vmcb01.ptr->save);
> +	svm_copy_vmrun_state(vcpu, map_save.hva + 0x400, &svm->vmcb01.ptr->save);
>  
>  	kvm_vcpu_unmap(vcpu, &map_save);
>  	return 0;
> @@ -5081,7 +5080,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
>  	 * used during SMM (see svm_enter_smm())
>  	 */
>  
> -	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, map_save.hva + 0x400);
> +	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, map_save.hva + 0x400);
>  
>  	/*
>  	 * Enter the nested guest now
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index d52010e4de97..696f1b4b8f8f 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -783,7 +783,10 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
>  
> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
> +static inline u64 svm_get_debugctl_reserved_bits(struct kvm_vcpu *vcpu __maybe_unused)

The polarity is cumbersome and annoyingly different than VMX, quite silly since
most paths care about supported bits, and the resulting code once BLD comes along
is downright ridiculous.  Invert the polarity so that we end up with

  static inline u64 svm_get_supported_debugctl(struct kvm_vcpu *vcpu)
  {
	u64 debugctl = DEBUGCTLMSR_LBR;

	if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;

	return debugctl;
  }


instead of:

  static inline u64 svm_get_debugctl_reserved_bits(struct kvm_vcpu *vcpu)
  {
       u64 debugctl = DEBUGCTLMSR_LBR;

       if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
               debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;

       return ~debugctl;
  }
