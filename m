Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BBB24A078
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 03:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702431; cv=none; b=I56fV0rS03wzCcxmKkO5D+FqB+g+HJt2UZdDaG9M5WoMkbiklhdgq7MzM+tBd8uv3kovKc9D+LF4dCJif3Q70gUwXuVgh0bGVYsQiqS0xJJF2XF9rdgAozuwNUdXmD3iCe/NOSdjB+HH2vZGNiwwQ8r6A5b9939PF7rmwTBSzMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702431; c=relaxed/simple;
	bh=P/9XJHKuSs7a9FPgvrUzgU168SAQmzHvWBvo94L/T24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3sSwEwh9EdYMmkQnayhLwKutlCunFh2geJkyRkdsUOAkE1lmg7fiWy2lBrkapSFSGD5n8XO27IeYwU/bSrKFut55Gvfr8h9C/AirbDk9P4vinNTGzioJdLhlKay1t6cu7girZpUvCf6fKRkTlkEiXv/6Lv/4MJyXO4eAw9ookM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=QgiW9fYQ; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="QgiW9fYQ"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc88a9b9so306023fac.2
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 20:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1789702429; x=1790307229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dvN/1Ulyn2DGSDvqPsms6iBfcOMu/r1nIHwq2MEcZZg=;
        b=QgiW9fYQoOY6vWzP9Q+FfdI1VFjA1jTqomc90RO6eGz6WSWZmexqw7Bfij5UYlgY+a
         Hhc/gVMYqzj7W37QJvAl1MXlQ/A9xt9DGSPvyseV775sufbijQc6WiFo8iwNleE5Ce4u
         Bfj+HARFY9BIilWQX14WB2PwPgKCIAr1acvrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789702429; x=1790307229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dvN/1Ulyn2DGSDvqPsms6iBfcOMu/r1nIHwq2MEcZZg=;
        b=Xw3hlHjjNDz9pS+SNHiQC+bx37CiB6ysYzIvhApy50h9wsEizvQmBxOLalrWmIamQJ
         eJh1kIp5Xs7WPYcKg2pt/6eC6hkFTbPQDw5lXQKN9zzdVKwIxT22LuXpbWouF0ODz/Eb
         G81Ks/O56pumEgSGdtjGjubPJ/Jwri5nafCpxZujef98SBvSq64QtwbVX/gmhmKxafBO
         vCzLfS1I+2xqSx5xDAEog+uzjErz8J6fw0x7Vz4INiqrYKV+0hMyQOwk3qGd+0b67I6b
         T/bcZecbo2U1m7srvDFzj696Gfh4uOvpZQy4JgU2OEGaX7N6byIf5UyZv9xaAqza8PS+
         FoxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZEW3+JROnNO8Q3Am+r6e4/wuOUqDbgnpzUB3QvdKDAb8joW6FpCAQuQDWDj8AERjLosA=@vger.kernel.org
X-Gm-Message-State: AFuF++m5xZnFDMHmuGtkoc2BcRC862V3+qACpvhmbdvRCgAOOTfWe40S
	X+VeG60wLIinycNKP7LMRuhbeUiwMvYXx6cuqj0LZgEmqSiacQ8SpVpa2oYoc3WYbxM=
X-Gm-Gg: AYBFou2XtLqkny1PlDd2y3NnJYi6WWJMa/1/uxNaHdVpqQFvGHxpPyouL3fdRjhD9Vt
	3oI3TAeTjzb+iFmDL95VRvHcqlGFd2apIRr2uJWPdS4RdzQmpvxzxMNYMLzTq3c1lau29xQI2B+
	Pu2xHLaN+H4e62ygl8U4N+r4l7aqtmmQfK2R2GESCgDpxHVmRpRBXVZRrQAxpY89dzsKd8JUGZ8
	AxugskUq0FTKHVLafE4ca8objWfPbDA60JjPoI2xRrk0hmdnIPcx7EYPlKErVH+8Ru5tbxY1i/0
	c3NTJaiws/ca+ry7KG9sqrUiYwJdWb6ZbeBW+7NMj1a6yHP4W6UlroEtezfBvg/6EN/97dr0Idt
	34tKdP/9H7KHTXNbbeR2zsnnqVNEr0CYWIWp1h6KskoHo3eqbdTCCuUcVu4yKahkJgMWmbhCAE3
	lFOu7eGQHgMvmy1jKt0N87AkAU03dRYs6ujLIZvfInJQPWi6XAfwgvVb8NXNc7uMe75MzYEgg1F
	1fZIfrpPu0NipV73r8VfEEYScJR9BsbXaRJXcDhhqiUpp89Z7a+TQ==
X-Received: by 2002:a05:6808:c298:b0:4be:282:6f7a with SMTP id 5614622812f47-4ccf925d0a1mr1596378b6e.40.1789702427884;
        Thu, 17 Sep 2026 20:33:47 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4cd6a44e8d8sm158757b6e.14.2026.09.17.20.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 20:33:47 -0700 (PDT)
Date: Thu, 17 Sep 2026 20:33:44 -0700
From: Kyle Zeng <kylebot@openai.com>
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v3] KVM: x86: Restrict saved GPA writes to hardware write
 faults
Message-ID: <aqyxGC1kwlFO8Z4x@com-75606>
References: <20260915222625.99965-1-kylebot@openai.com>
 <20260915224104.4EB441F000FF@smtp.kernel.org>
 <aqnNAsGF_iUQsVX1@com-75606>
 <aqrqb-lz2f0gCwuF@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqrqb-lz2f0gCwuF@google.com>

On Wed, Sep 16, 2026 at 12:13:51PM -0700, Sean Christopherson wrote:
> On Tue, Sep 15, 2026, Kyle Zeng wrote:
> > On Tue, Sep 15, 2026 at 10:41:03PM +0000, sashiko-bot@kernel.org wrote:
> > > > @@ -6454,7 +6456,18 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> > > >  
> > > >  		/* With shadow page tables, cr2 contains a GVA or nGPA. */
> > > >  		if (vcpu->arch.mmu->root_role.direct) {
> > > > -			ctxt->gpa_available = true;
> > > > +			ctxt->gpa_access = ACC_READ_MASK;
> > > > +			/*
> > > > +			 * Always allow writes for SEV guests, as the guest's
> > > > +			 * page tables are encrypted, i.e. KVM can't walk the
> > > > +			 * guest's page tables and so must always use the GPA
> > > > +			 * from the initial fault.  Restricting use of the GPA
> > > > +			 * to the access type that faulted would prevent KVM
> > > > +			 * from emulating RMW operations for SEV guests.
> > > > +			 */
> > > > +			if ((emulation_type & EMULTYPE_PF_WRITE) ||
> > > > +			    (cpu_feature_enabled(X86_FEATURE_SVM) && is_sev_guest(vcpu)))
> > > 
> > > [Severity: High]
> > > Could this lead to an out-of-bounds read and type confusion?
>  
> ...
> 
> > Is there a configuration that gets past the initialization checks and
> > demonstrates an incorrect access? I'd like to establish that before
> > treating this as a functional issue.
> 
> Eh, doesn't matter, my suggestion was terrible.  I forgot that is_sev_guest()
> needs to check embedded data; I was thinking of TDX and SNP VMs, which have
> dedicated VM types.
> 
> I think the right way to handle this is to track if a VM has protected page
> tables.  That'd also help communicate/document why KVM has this weird behavior.
> 
> Untested...
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 30ffaa65f589..90c950c12900 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1166,6 +1166,7 @@ struct kvm_arch {
>  	u8 mmu_valid_gen;
>  	u8 vm_type;
>  	bool has_private_mem;
> +	bool has_protected_page_tables;
>  	bool has_protected_state;
>  	bool has_protected_eoi;
>  	bool has_protected_pmu;
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index b56c39c53c98..7f544658b1cc 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2955,6 +2955,7 @@ void sev_vm_init(struct kvm *kvm)
>  		kvm->arch.has_protected_state = true;
>  		fallthrough;
>  	case KVM_X86_SEV_VM:
> +		kvm->arch.has_protected_page_tables = true;
>  		kvm->arch.pre_fault_allowed = !kvm->arch.has_private_mem;
>  		to_kvm_sev_info(kvm)->need_init = true;
>  		break;
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 014545c1839b..35022f308e06 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -616,6 +616,7 @@ int tdx_vm_init(struct kvm *kvm)
>  {
>  	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
>  
> +	kvm->arch.has_protected_page_tables = true;
>  	kvm->arch.has_protected_state = true;
>  	/*
>  	 * TDX Module doesn't allow the hypervisor to modify the EOI-bitmap,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f36b952624c8..7e5e2e587086 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -33,7 +33,6 @@
>  #include "lapic.h"
>  #include "xen.h"
>  #include "smm.h"
> -#include "svm/svm.h"
>  
>  #include <linux/clocksource.h>
>  #include <linux/timekeeping.h>
> @@ -6412,15 +6411,14 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  		if (vcpu->arch.mmu->root_role.direct) {
>  			ctxt->gpa_access = ACC_READ_MASK;
>  			/*
> -			 * Always allow writes for SEV guests, as the guest's
> -			 * page tables are encrypted, i.e. KVM can't walk the
> -			 * guest's page tables and so must always use the GPA
> -			 * from the initial fault.  Restricting use of the GPA
> -			 * to the access type that faulted would prevent KVM
> -			 * from emulating RMW operations for SEV guests.
> +			 * Always allow writes for guests with protected page
> +			 * tables, as KVM can't walk the guest's page tables,
> +			 * i.e. KVM can't get the RMW protections for a given
> +			 * GVA to see if the write side of a RMW operation
> +			 * should be allowed.
>  			 */
>  			if ((emulation_type & EMULTYPE_PF_WRITE) ||
> -			    (cpu_feature_enabled(X86_FEATURE_SVM) && is_sev_guest(vcpu)))
> +			    vcpu->kvm->arch.has_protected_page_tables)
>  				ctxt->gpa_access |= ACC_WRITE_MASK;
>  			ctxt->gpa_val = cr2_or_gpa;
>  		}
> 

Hi Sean,

I think the proposed patch will cause regression in legacy-SEV.

The new flag records whether KVM can read a guest´s page tables. The problem is that the patch sets it only when the VM is created, but older SEV APIs enable encryption later.

A modern SEV VM follows this sequence:
  Create VM with type KVM_X86_SEV_VM
  -> sev_vm_init() sets has_protected_page_tables = true
  -> initialize SEV

A legacy SEV VM follows a different sequence:
  Create VM with type KVM_X86_DEFAULT_VM
  -> flag stays false
  -> KVM_SEV_INIT enables SEV
  -> page tables are encrypted, but the flag is still false

The `is_sev_guest()` check recognizes the second case because it reads SEV´s actual active state. The proposed replacement would miss it.
That matters for an MMIO read-modify-write instruction. If hardware faults on the initial read, KVM grants the saved GPA only read permission. When emulation reaches the write, the incorrect flag prevents the SEV exception from applying. KVM then tries to check write permission by walking the guest´s encrypted page tables, which can fail and break the guest.
An ordinary hardware write fault still works because EMULTYPE_PF_WRITE grants write access independently.
The fix is to set the new flag when SEV initialization succeeds. Copying or migrating an encryption context must also set it on the destination VM. Setting it for every DEFAULT_VM would be wrong, because ordinary guests would then regain the vulnerable write shortcut.

V4 will be sent separately to address this issue.

Best,
Kyle
