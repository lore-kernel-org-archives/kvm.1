Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659445C6E4
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142107; cv=none; b=OT/BzIPS+jI5VvsWR8aJNwrkiVE3Em7slIX7JwIY8ql4mYttJMnmFPHrJJxrhKWWoM/pLX8fFuZZreulotuIjOca+EwNsAhMU40XZp24qsDgJHnQGGgBJ/8tOE4AScLrZS3GX5EPFi+qR2VEkWb23AUMnlKWPUhYVwDPdgX6Tuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142107; c=relaxed/simple;
	bh=1aFWAGrpTIBK2Mt94zjHekqBcvdGk/mQ6ZF7irl0IoE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LLTkupJ7DASiZ/wQZpyFr3lyTI4yNtfoSzDqMS9OmsVUtuIMLgHTAiTZ2KC5X6cLQ0f6S9+C99QG5sABzkNxP+HukpFTFUYcYjqWlPjjbFbjYv8Q4ec5B7+iFZ5RdxKMO5xNagWZo68WUk1uPD2ERNUmFXJS0ZlZWach5OIkYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sVvgnYr1; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVvgnYr1"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-868db1b2c64so1707224b3a.3
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789142105; x=1789746905; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gxrI/n0niL2zwrom9/nOHQQoHVQ21iUxnlLyaQOSRp4=;
        b=sVvgnYr1GcaDEqYJUicU1LQrj+PwaXPuwE3WQGt3MPeUNxf9txJEZhG+845ONkV3s7
         wI4g28Yh/YitDhNSkLAaprI1sSvqcNG3zIUpLheAlQZ7yoJYNZDVCu0zBKf2nc6anelk
         9OtXDqufDxrXaBf1nz4lybAJMq+eUOBM/D9/8EetJHL5nGq53Gv6zTRnNbt0VdB+1jLf
         SGKdIPiBXhw5rnVIMhm72atGwWdDZfQCPrS8F4fbgpK3r2sQc6bnVuGrjbl3lzUer6Qj
         BSRFJKpOAO/H9shYeIsJ70yJpzYz0AiBNaNtbBR7uroeFY7yUUKdX5Q0IAGEFptd3tNp
         oEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142105; x=1789746905;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gxrI/n0niL2zwrom9/nOHQQoHVQ21iUxnlLyaQOSRp4=;
        b=nwwVjqu9s6sWLTCbkJAMrzGZ+FDXR8uqZNxHFUjVM7MZEZbl0UOdiZ2uJ48FNMRZqH
         hLQSX/MEcvKCUDSXuEVE2I/qLdUhDxoUrlxx4GvAlbXeclhJWZDdTvXeWA3qt39qDd+m
         o/5r0F2X6/FeZMCp1YVMWltUju3h9bUlbz3nsBZQrmFUP3IADusSaP7VP5k5iKqbfEhG
         1ifjK9CnVkpHW9DSmHjPEudZ/7kzeWzfzSia9bOTyW0+ml0s4ezAGfZQeCaCUpFOSxY3
         1k42mh0R+AbeM2vbUIE2LehVIUUAcAGusb6EYu9fVCc0veC2VTjl8K41K1cfo/w0mt3q
         WvAw==
X-Gm-Message-State: AFuF++mURd28SfszTXJJIurElIpOQPNfFMStdF779ieYKO9w60rDLVjd
	fcyWQIZH9y/EreTAvAI9cWT9z8EghmosO/TXMUCHlxJfgGi5nhOvu5Zp/ztHIegQI8QUAVvQijk
	Yqa8ijQ==
X-Received: from pfks3.prod.google.com ([2002:a05:6a00:1943:b0:86a:a7e4:b95b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1a94:b0:86a:8e9b:46c8
 with SMTP id d2e1a72fcca58-86b2c0ec0fdmr7188944b3a.0.1789142104797; Fri, 11
 Sep 2026 08:55:04 -0700 (PDT)
Date: Fri, 11 Sep 2026 08:55:04 -0700
In-Reply-To: <20260904003522.9988E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904002423.3154436-1-seanjc@google.com> <20260904002423.3154436-16-seanjc@google.com>
 <20260904003522.9988E1F000E9@smtp.kernel.org>
Message-ID: <aqQkWLXliGRL_YcZ@google.com>
Subject: Re: [PATCH v4 15/17] KVM: selftests: Add __vmwrite() and use it when
 initializing optional fields.
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 04, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch fails to convert all blind writes of optional VMCS fields to the non-asserting `__vmwrite()` in the common setup code, contradicting its stated intent and setting up a test crash.
> --
> 
> commit 2bdd2a9b67ebe18b99a514555581198b78d1fab6
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: selftests: Add __vmwrite() and use it when initializing optional fields.
> 
> This commit introduces __vmwrite(), a non-asserting version of vmwrite(), to
> allow writing optional VMCS fields in common setup code where success is not
> guaranteed. It prepares for vmwrite() to unconditionally assert success in
> subsequent patches.
> 
> > diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
> > index 1a8515de42b06..b6bd9423e6768 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/vmx.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
> > @@ -252,7 +252,7 @@ static inline void init_vmcs_control_fields(struct vmx_pages *vmx)
> >  	u32 sec_exec_ctl = 0;
> >  
> >  	vmwrite(VIRTUAL_PROCESSOR_ID, 0);
> 
> [Severity: Medium]
> Will this blindly write to the VIRTUAL_PROCESSOR_ID field using the asserting
> vmwrite()?
> 
> Since VPID is an optional secondary control that may not exist on all
> hardware, this could crash selftests with a VM-Fail assertion on unsupported
> hardware once vmwrite() is modified to assert success. Could this be converted
> to __vmwrite() similar to POSTED_INTR_NV?
> 
> > -	vmwrite(POSTED_INTR_NV, 0);
> > +	__vmwrite(POSTED_INTR_NV, 0);
> >  
> >  	vmwrite(PIN_BASED_VM_EXEC_CONTROL, rdmsr(MSR_IA32_VMX_TRUE_PINBASED_CTLS));
> 
> [ ... ]
> 
> > @@ -356,8 +356,8 @@ static inline void init_vmcs_guest_state(void *rip, void *rsp)
> >  	vmwrite(GUEST_GS_SELECTOR, vmreadz(HOST_GS_SELECTOR));
> >  	vmwrite(GUEST_LDTR_SELECTOR, 0);
> >  	vmwrite(GUEST_TR_SELECTOR, vmreadz(HOST_TR_SELECTOR));
> > -	vmwrite(GUEST_INTR_STATUS, 0);
> > -	vmwrite(GUEST_PML_INDEX, 0);
> > +	__vmwrite(GUEST_INTR_STATUS, 0);
> > +	__vmwrite(GUEST_PML_INDEX, 0);
> >  
> >  	vmwrite(VMCS_LINK_POINTER, -1ll);
> >  	vmwrite(GUEST_IA32_DEBUGCTL, 0);
> 
> [Severity: Medium]
> Will these writes to optional guest state fields cause test failures on CPUs
> or nested hypervisors that lack these features?
> 
> Fields like GUEST_IA32_DEBUGCTL, GUEST_IA32_PAT, GUEST_IA32_EFER, and
> GUEST_IA32_PERF_GLOBAL_CTRL are written unconditionally using vmwrite() here
> in init_vmcs_guest_state(). It seems they will assert failure on unsupported
> hardware. Should these also be switched to use __vmwrite() to avoid crashing?

VM_ENTRY_LOAD_DEBUG_CONTROLS and thus GUEST_IA32_DEBUGCTL support is required by
KVM.  I'll fixup the others when applying.
