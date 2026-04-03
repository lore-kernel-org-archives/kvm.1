Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48C1B4244
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232252; cv=none; b=ECff6wLhLbj+e7Cb5CqE9LgigtUI56S6O30GQedhGONVX7gAWiJebgoiIh25+mAqpCjrQ6kvkcf1XqsIEZUo5mMxnRnKs7le0LnSBtlR1eRn9Yt9zpLNqt2DtbELp8z9uMizuw4eB3WehM8p9xdDX3ZW5xi0fC870inWw2GxNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232252; c=relaxed/simple;
	bh=gq/kcoZSdx0TwVI7zhvsAC93ldRcVu+9V8YzLxYOzNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tL+1v+KQuDXwPmP+i3BpFenBRyzq9kTh/IJs/Kv5hESKxfs78N+gPyHtas4LKjr6M7fCXok7q5U1l5qTg92cHZmDK9yOSDUcg+b6ssQEtKtiMSzRcnHswMqgF0L25XF/PPJRlghWWs0PBqdJlScFYGQerCngbTusREs59wwKxAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdeZyQx0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdeZyQx0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775232250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QmDOLbX7faryoK+4zAPbk4328xMyeX5JK8OrBNtSI4U=;
	b=GdeZyQx09xQ+NErGRGvYpzMK/8gvYP1A93lD2J+suPisVHSADcD3n6cT6oFwpGdJtJ87lW
	EJQWCKO5W2LPZHxM4pfOdcV6cbH3TSDoux972YKg4kfCQ7CAhz+XU2RZkJLfg+Lter58z+
	dtf8pwm8Kk47PP4Io1HmG5g52L6c2nc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-W0TZIVc7MvSMyVkj2FRHng-1; Fri,
 03 Apr 2026 12:04:06 -0400
X-MC-Unique: W0TZIVc7MvSMyVkj2FRHng-1
X-Mimecast-MFC-AGG-ID: W0TZIVc7MvSMyVkj2FRHng_1775232245
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E779B18002C8;
	Fri,  3 Apr 2026 16:04:04 +0000 (UTC)
Received: from [10.44.48.32] (unknown [10.44.48.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DAFD1955D70;
	Fri,  3 Apr 2026 16:04:01 +0000 (UTC)
Message-ID: <88e9d7f0-35b8-4559-9f4d-c7daf1af6012@redhat.com>
Date: Fri, 3 Apr 2026 18:03:59 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
To: Sean Christopherson <seanjc@google.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, kvm@vger.kernel.org, x86@kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>
References: <20260311003346.2626238-1-seanjc@google.com>
 <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
 <ac75iuf9gHIhvm9u@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ac75iuf9gHIhvm9u@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 4/3/26 01:19, Sean Christopherson wrote:
> On Wed, Mar 11, 2026, Paolo Bonzini wrote:
>> On 3/11/26 01:33, Sean Christopherson wrote:
>>> Clean up KVM's register tracking and storage in preparation for landing APX,
>>> which expands the maximum number of GPRs from 16 to 32.
>>>
>>> This is kinda sorta an RFC, as there are some very opinionated changes.  I.e.
>>> if you dislike something, please speak up.
>>>
>>> My thought is to treat R16-R31 as much like other GPRs as possible (though
>>> maybe we don't need to expand regs[] as sketched out in the last patch?).
>>
>> The cleanups in patches 1-4 are nice.
>>
>> For APX specifically, in abstract it's nice to treat R16-R31 as much as
>> possible as regular GPRs.  On the other hand, the extra 16 regs[] entries
>> would be more or less unused, the ugly switch statements wouldn't go away.
> 
> Hmm, yeah, but only if XSAVE is the source of truth for guest R16-R31.
> 
> Do we know what the compiler and/or kernel rules for using R16-R31 will be?

On the compiler side, they are enabling APX only with new enough -march, 
or with -march=native if the host has APX. This, by the way, implies 
CONFIG_X86_NATIVE_CPU is currently hosed on Diamond Rapids and newer 
machines.

 From what I remember of Chang Seok Bae's presentation at Plumbers last 
year, right now there's no plan to have the kernel use APX, except 
possibly through the usual kernel_fpu_begin/end.

> E.g. if C code is allowed to use R16-R31 at will, then KVM will either need to
> swap R16-R31 in assembly, or annotate a pile of functions as "no_egpr" or
> whatever.

__attribute__((__target__("no-apxf")), yeah.  Perhaps it could be done 
(kernel-wide) for all noinstr functions, but I think we agree that it's 
not a great idea overall.

> At that point, my vote would be to use regs[] to track R16-R31 for KVM's purposes.
> IIUC, we could largely ignore XSAVE state at runtime and just ensure R16-R31 are
> copied to/from userspace as needed, same as we do for PKRU.

If it can be done efficiently when APX is not available, I suppose 
that's fine.  The KVM code is nicer for sure.

But until the kernel starts using APX, I would do the save/restore near 
kvm_load_xfeatures(), because __vmx_vcpu_run()/__svm_vcpu_run() would 
have to check whether xcr0.apx is set or not.  This is much simpler:

	// runs with host xcr0, so it can assume it includes APX
	// alternatively it could be a static_call(), to only invoke
	// the function if at least one guest enables APX in xcr0
	if (static_cpu_has(X86_FEATURE_APX))
		kvm_apx_save(vcpu);
	kvm_load_xfeatures(vcpu, true);
	...
	kvm_load_xfeatures(vcpu, false);
	// same as above
	if (static_cpu_has(X86_FEATURE_APX))
		kvm_apx_restore(vcpu);

Writing kvm_apx_save() and kvm_apx_restore() already now in a .S file is 
fine but I don't care too much.

If the kernel starts using APX we would have to do the xcr0 changes in 
two steps, one in kvm_load_xfeatures() and one (finalizing the APX bit) 
right around the assembly code for world switching.  That xcr0 update 
would have to be in kvm_apx_save/restore, which would have to 1) be 
rewritten in assembly 2) be called from within 
__vmx_vcpu_run/__svm_vcpu_run.

But it would be premature to do now the two-step save/restore of xcr0.

> If R16-R31 aren't generally available for C code, then how exactly is APX going
> to be used?

Only in userspace, at least for now.

Paolo

> Understanding the usage rules for R16-R31 seems fundamental to figuring what to
> do in KVM...
> 

