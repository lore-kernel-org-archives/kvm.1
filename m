Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BBA2FFFB8
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775240340; cv=none; b=UibJMBYL1rx/3CSEBUKjOKAHar2x9XSqL6ge8Cabcc3cKVrdsxnv5+a/Ayr2VkRlxNJ/EGOoJiMPwABKd2lSM/7sshshgH3JAqJax+sVGOSQh5TveC11fPOFijIXzA88xDCoR1KxsFGXc6hkSTIV8FI/Ku30luMXo2W2HIw5KVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775240340; c=relaxed/simple;
	bh=d9fKYrqvm9ZHBMycKk5RMsjxR4vI8S4HZQmJk/NMbws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fwO2MMINDF+yRE3S2PSwcMgSZxQr+sQkcdPjgK3OvSP7uhG7l9tRio9ewCJ6MM9X1pq0e5DthrL7gDx+5XIvmDwIuCrQDAFlRAdZUvH/7w+OjmpHVSx2PakULyxNNwJArob/hUWViBUiVlEBFwRaq6UrgFQ80TSqskzMKlyDDbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l37S/32R; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l37S/32R"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c769e2b1bd0so1133945a12.2
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 11:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775240337; x=1775845137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p/7vx0Uuo6no7a/ymxenB3UXpA7SrTt89T79ZimZz8o=;
        b=l37S/32R0BcQEQ3XjsM813qBV586jphPrh9S5BqW9APxLF6qnlnjWLlWsuDiHhyTp2
         nr9hJc9NNwnTgbUFkAoAnvFyA3K+MnR4mvx598vL2eapDOnIXJQZubFI3ZcSVbCp1Nry
         elCqMiZcOFvvLJYg3gnad0bnMBaUHc1qM/EaQpPBFXSk9zjkv5K2VcOMG0PwGea1BAMK
         FrPFFZEBSFQpnp9RjgEfHSMLb9WFLzsBngwhDZElHrKOH/Tyu6b/RVcPYX4YzFwQ5u+5
         pEgSjKEi5hkmjJPJRP3I94Lqr5uRWHf0oEEstTG+SezCWAgg6I2jByPTvz97qh8dOVAN
         PjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775240337; x=1775845137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/7vx0Uuo6no7a/ymxenB3UXpA7SrTt89T79ZimZz8o=;
        b=tB+TnZR2E+unBhiC2O5sBPR3O66ug+YCN78yBpzO4+xI/ISXYC/4I7v2ImBfGeMtbL
         /SFLATZqV6OBRCnJw9sd2pJOcx444bADQUDUMFLm2APdMXB0pU3V/SBUbgFwNI6I87I2
         g1cn8MGKiHyNDmSLj4dD5yAcexWjDRMXz4nikMG0KIwA3bmzRjz1an0xGdSMmkhB/tR3
         UfsnXPbG0ue8kf1RUTkKXHLvCmnTUiQi/YkhGwTdmoAKB6NSf1etwkJjn/C+6ALt70/1
         SMKzrx+26LtkOuWGyddwrjhbe4qqT27WEr666CrvF+uWNMKpSvlzRKoEdYEGhWeutSiz
         GvNg==
X-Forwarded-Encrypted: i=1; AJvYcCUebt9SOjJLzQEyDX5huD1c4lVhXrOWMUQwUA6enDDPE+GpeqSQIFsoyS8KzZKZyROwFSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzenE3xjHarkCFJZlxr4an8KHkNf49s1BjQtufuMv4PhEi4aYXZ
	UJTp20sV6W1R6/HvtOHLoyyK3+73PlYHOIf2M0Yc9EjspjgqBB40fWKF7gvX32BUpboUGarwXqN
	2IOyWNQ==
X-Received: from pfwz16.prod.google.com ([2002:a05:6a00:1d90:b0:827:45df:8f74])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a0b:b0:81f:852b:a925
 with SMTP id d2e1a72fcca58-82d0da4594cmr3624925b3a.1.1775240336723; Fri, 03
 Apr 2026 11:18:56 -0700 (PDT)
Date: Fri, 3 Apr 2026 11:18:55 -0700
In-Reply-To: <20260316202732.3164936-3-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260316202732.3164936-1-yosry@kernel.org> <20260316202732.3164936-3-yosry@kernel.org>
Message-ID: <adAEjw56f_4cuUNR@google.com>
Subject: Re: [PATCH v4 2/9] KVM: SVM: Refactor SVM instruction handling on #GP intercept
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 16, 2026, Yosry Ahmed wrote:
> +/* Return 0 if not SVM instr, otherwise return associated exit_code */
> +static u64 svm_instr_exit_code(struct kvm_vcpu *vcpu)

To make it very clear what this is doing how about:

static u64 svm_get_decoded_instr_exit_code(struct kvm_vcpu *vcpu)

>  {
>  	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
>  
>  	if (ctxt->b != 0x1 || ctxt->opcode_len != 2)
> -		return NONE_SVM_INSTR;
> +		return 0;

This should assert to ensure there's no collision with '0', i.e.

	BUILD_BUG_ON(!SVM_EXIT_VMRUN || !SVM_EXIT_VMLOAD || !SVM_EXIT_VMSAVE);


> +	if (!is_guest_mode(vcpu))
> +		return kvm_emulate_instruction(vcpu,
> +				EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);

Since you're moving this anyways:

	if (!is_guest_mode(vcpu))
		return kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE_GP |
						     EMULTYPE_NO_DECODE);


Actually!  Better idea, for this code and for the page_address_valid() checks:
invert the checks to reduce indentation, i.e. end up with:

	/* FIXME: Handle SVM instructions through the emulator */
	svm_exit_code = svm_get_decoded_instr_exit_code(vcpu);
	if (svm_exit_code) {
		if (!is_guest_mode(vcpu))
			return svm_invoke_exit_handler(vcpu, svm_exit_code);

		if (nested_svm_check_permissions(vcpu))
			return 1;

		if (!page_address_valid(vcpu, kvm_register_read(vcpu, VCPU_REGS_RAX)))
			goto reinject;

		/*
		 * FIXME: Only synthesize a #VMEXIT if L1 sets the intercept,
		 * but only after the VMLOAD/VMSAVE exit handlers can properly
		 * handle VMLOAD/VMSAVE from L2 with VLS enabled in L1 (i.e.
		 * RAX is an L2 GPA that needs translation through L1's NPT).
		 */
		nested_svm_simple_vmexit(svm, svm_exit_code);
		return 1;
	}

	/*
	 * VMware backdoor emulation on #GP interception only handles
	 * IN{S}, OUT{S}, and RDPMC, and only for L1.
	 */
	if (!enable_vmware_backdoor || is_guest_mode(vcpu))
		goto reinject;

	return kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);

> +
>  reinject:
>  	kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
>  	return 1;
> -- 
> 2.53.0.851.ga537e3e6e9-goog
> 
