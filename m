Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A7039D6E7
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750737; cv=none; b=D91EkappqJ0ENxDWxxzonLF5+D6z46vCIwJedM3fGypR46GN0uAqGM0AtNQ+0Z8meNhqzm9jILIJTH/B+oSKZySZMo/G2r07fHKDEnhRVaNtwksM0xyyEk5afCz/T3n+M9+x5CrBWm5Rk2Kpii41VRBCwVk1RZfGKpywWZy45Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750737; c=relaxed/simple;
	bh=S9H6MRusD6avBUInDfJE8IczOr92FcNXoIC2QmNtaOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0G9bQyHGGdjlQxl5bfQUcuihNoxDSmhgDJLIGmlXmHaN/5roD/8o5FasZEMOWAWbg2taBUO4b29UypTKO22a4FP10ye6511pW6gnbj8NDnE/gxxkm+LiHEZSV8hHER8YebibGxM5zis+tB8xVv0z4Gd0o5s0NsGcQ0fHQkCblQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKY7GCV1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKY7GCV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778750735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zZf/XNv2Ho4cOk0XPWos/XPF8krPk3jxMhgxhH5/NPI=;
	b=KKY7GCV15NjqI4U60xBdMV/gjPF3VoHCMgz6xeIHSZJGghO6rT5L3i9P3uKebPbLBFzJ3A
	DWY+yWhdPRDa+5uYE1SK+bzMatFzkIpSYtjAqLEviq5ory48FP33nxQCHOnuxNfKv9toQA
	NYRjyBSy6JqCiAjsa2fOf3310Cw7fFc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-okzCN3x8NZu7wUfk_sCCmQ-1; Thu,
 14 May 2026 05:25:31 -0400
X-MC-Unique: okzCN3x8NZu7wUfk_sCCmQ-1
X-Mimecast-MFC-AGG-ID: okzCN3x8NZu7wUfk_sCCmQ_1778750730
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44E5E1800343;
	Thu, 14 May 2026 09:25:30 +0000 (UTC)
Received: from [10.44.34.0] (unknown [10.44.34.0])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A59B30001A2;
	Thu, 14 May 2026 09:25:19 +0000 (UTC)
Message-ID: <a57836aa-2644-4e6c-881c-83e26402a235@redhat.com>
Date: Thu, 14 May 2026 11:25:17 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm:queue 4/24] arch/x86/kvm/vmx/vmenter.S:98: Error: invalid
 operands (*UND* and *ABS* sections) for `*'
To: kernel test robot <lkp@intel.com>, "Chang S. Bae"
 <chang.seok.bae@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 Farrah Chen <farrah.chen@intel.com>
References: <202605141102.53Vk824r-lkp@intel.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <202605141102.53Vk824r-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 5/14/26 05:20, kernel test robot wrote:
> Hi Chang,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

This is my fault, the 32-bit macros needs to use __VCPU_REG_RAX rather 
than __VCPU_REG_EAX (and so on so forth).

Paolo

> tree:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
> head:   2b5e4245e1d31fd0858bb7abbd82af85a6457c33
> commit: d1d1534a7ef4694a6a7b079c80e661dd66d04e9c [4/24] KVM: VMX: Macrofy GPR swapping in __vmx_vcpu_run()
> config: i386-buildonly-randconfig-001-20260514 (https://download.01.org/0day-ci/archive/20260514/202605141102.53Vk824r-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260514/202605141102.53Vk824r-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605141102.53Vk824r-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     arch/x86/kvm/vmx/vmenter.S: Assembler messages:
>>> arch/x86/kvm/vmx/vmenter.S:98: Error: invalid operands (*UND* and *ABS* sections) for `*'
>>> arch/x86/kvm/vmx/vmenter.S:98: Error: invalid operands (*UND* and *ABS* sections) for `*'
>>> arch/x86/kvm/vmx/vmenter.S:98: Error: invalid operands (*UND* and *ABS* sections) for `*'
>>> arch/x86/kvm/vmx/vmenter.S:98: Error: invalid operands (*UND* and *ABS* sections) for `*'
>>> arch/x86/kvm/vmx/vmenter.S:98: Error: invalid operands (*UND* and *ABS* sections) for `*'
>>> arch/x86/kvm/vmx/vmenter.S:98: Error: invalid operands (*UND* and *ABS* sections) for `*'
>     arch/x86/kvm/vmx/vmenter.S:105: Error: invalid operands (*UND* and *ABS* sections) for `*'
>     arch/x86/kvm/vmx/vmenter.S:164: Error: invalid operands (*UND* and *ABS* sections) for `*'
>     arch/x86/kvm/vmx/vmenter.S:164: Error: invalid operands (*UND* and *ABS* sections) for `*'
>     arch/x86/kvm/vmx/vmenter.S:164: Error: invalid operands (*UND* and *ABS* sections) for `*'
>     arch/x86/kvm/vmx/vmenter.S:164: Error: invalid operands (*UND* and *ABS* sections) for `*'
>     arch/x86/kvm/vmx/vmenter.S:164: Error: invalid operands (*UND* and *ABS* sections) for `*'
>     arch/x86/kvm/vmx/vmenter.S:164: Error: invalid operands (*UND* and *ABS* sections) for `*'
>     arch/x86/kvm/vmx/vmenter.S:166: Error: invalid operands (*UND* and *ABS* sections) for `*'
> 
> 
> vim +98 arch/x86/kvm/vmx/vmenter.S
> 
>      88	
>      89		/*
>      90		 * Since vmentry is serializing on affected CPUs, there's no need for
>      91		 * an LFENCE to stop speculation from skipping the wrmsr.
>      92		 */
>      93	
>      94		/*
>      95		 * Load guest registers.  Don't clobber flags. Intentionally omit
>      96		 * %_ASM_SP as it's context switched by hardware
>      97		 */
>    > 98		LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
>      99			  %_ASM_AX, %_ASM_CX, %_ASM_DX, %_ASM_BX, %_ASM_BP, %_ASM_SI
>     100	#ifdef CONFIG_X86_64
>     101		LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
>     102			  %r8, %r9, %r10, %r11, %r12, %r13, %r14, %r15
>     103	#endif
>     104		/* Load guest RDI.  This kills the @vmx pointer! */
>     105		LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, %_ASM_DI
>     106	
>     107		/*
>     108		 * Note, ALTERNATIVE_2 works in reverse order.  If CLEAR_CPU_BUF_VM is
>     109		 * enabled, do VERW unconditionally.  If CPU_BUF_VM_MMIO is enabled,
>     110		 * check @flags to see if the vCPU has access to host MMIO, and if so,
>     111		 * do VERW.  Else, do nothing (no mitigations needed/enabled).
>     112		 */
>     113		ALTERNATIVE_2 "",									  \
>     114			      __stringify(testl $KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO, (%_ASM_SP);	  \
>     115					  jz .Lskip_mmio_verw;						  \
>     116					  VERW;								  \
>     117					  .Lskip_mmio_verw:),					  	  \
>     118			      X86_FEATURE_CLEAR_CPU_BUF_VM_MMIO,					  \
>     119			      __stringify(VERW), X86_FEATURE_CLEAR_CPU_BUF_VM
>     120	
>     121		/* Check @flags to see if VMLAUNCH or VMRESUME is needed. */
>     122		testl $KVM_ENTER_VMRESUME, (%_ASM_SP)
>     123		jz .Lvmlaunch
>     124	
>     125		/*
>     126		 * After a successful VMRESUME/VMLAUNCH, control flow "magically"
>     127		 * resumes below at 'vmx_vmexit' due to the VMCS HOST_RIP setting.
>     128		 * So this isn't a typical function and objtool needs to be told to
>     129		 * save the unwind state here and restore it below.
>     130		 */
>     131		UNWIND_HINT_SAVE
>     132	
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

