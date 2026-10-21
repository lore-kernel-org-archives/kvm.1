Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584326;
	b=k3FOTvYBwv5SynbvBBHNWRECvbgx6RviAWl3wTncEtNDJTeVM90kqz1YSFApwvwO0R/H
	 LahavgvO9iJMD5dBVnq0IwNzQspcvjj9nTxVE1NEnRfZ1cMgQpJR4BN25kdQNwjr/NP0i
	 ynrA6ac9LGByz6A8Q56j7XMUP0NWC2SmuuzY+C2mxZDKzvjykY5FuKYNUWwocP1B4tzz8
	 DpDPSgUO1oOpjomKoNsZtt7TdBxCSbYgWDiFU4R7nTAwXb+34uUH/Z9XQaga/ZygRq7CI
	 tatviA7uPyr1l6QOTtMvZiqkmYbtmvlH5+Tz9Vgc9y/xO2VcEeD/OGENeVUUYWs3QAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=+s62Nwi08QqpXclEg6GElt8WEM0xJQibTaa69sU+UYk=;
	b=JFKslb5EzOar0VeLRzvNFnj/ezMYe1ah8Q4NhAb7aL4TcfEYlCpRQKFFamvpM0XnKrb5
	 Rlo+Mj6PHaE2E+5TV6UbJKZ94tuA2+rM947GYt0Y5SnYE6HjECiejQMjd++r1SoMsn2XH
	 uXIPI7eGY4csnwg+qpol9dcLnhUNt59CZiGXMXKXyxpa9Wy+KuUqMdbEbJSkR+O7FPxys
	 i3BzHo7YA6Mr+c7RkiyhtxCw8sibSrbila5qVe6kuvyfydvQKwMTXC7NhZmwpgPQyJU/t
	 i7iCpC6X6aALLBiUuqOhGwxqlrrlfeQckGqcu19XxI//4u5iFSgCCSXlq3znhabCPRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rqvvk7N+;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0EF606A319
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 12:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F0EF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rqvvk7N+
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a079256596so619922b3a.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792584319; x=1793189119; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+s62Nwi08QqpXclEg6GElt8WEM0xJQibTaa69sU+UYk=;
        b=rqvvk7N+vzmicoIaOSEX3Dgwlnavaum77hFxubYNxlTUgkAZ0mNHWUI2Q4ojn+AJG5
         oGaut4zxT9D87hq0InjuObaBmzaJbSFfocOuNeFGyLHFkiZTKf7tLqm+xFWfi5+a05We
         l7LIdZVLijGqEyAqH2q6vp+sNVQjJoYJq+mGRtIfH5ZqqSch5XcGj9NVjjQBVuQNn8Q+
         jhhi1WcZ044NdALzo9N4gW3T3wxwY9U4jsyMqvEQlDyZbN9ZNsl3EFEsS9KQLpJX5Or2
         Zcwe4WUAgP0HNdg/8IbICkJZNiIu/jjwJcVQXkcV0WT5F4ixOBqzIrLt3WA9G6TOjaTD
         XhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792584319; x=1793189119;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+s62Nwi08QqpXclEg6GElt8WEM0xJQibTaa69sU+UYk=;
        b=CRAzUUz0AoXG81uP0Ypo709nQ7U4qC6luy29TUNkERvUvVkuPbxsgfySKzLQHGA/En
         Cn/W1r5X2f+I68imRhcskMpW7/QaMhzCU2xnO/x1xte+UOhB9D5ov06tPK7weNapG2Gk
         illNNiP1j2fW1VJgx52Ht//rzD+1XeFEsfAmtL4ILAdxJW2RWla5iBnB6pZgA5Ua2TfM
         fnJMhZlvHSezeK/dZ/OiDAPYtxBGNVS6i29aIWWu+Z4riFLn8M0bA4hEUspsOPE3C+pb
         rfem8aM3HJFPUapZ0E34APH6qtB2jlcUrPHMSZPgdne9fnozyAD3SuEfz2IT906tUuN/
         vu5g==
X-Gm-Message-State: AFq9FYINIQeYBo3zUGea+LZvuo2b/5lqShULwowgdpueK15ApNoynKDX
	z+N4IoybybyHPx9WyrHYDFm4rdOaY+jVk3Eyo82j+j9D+YGndAvrgNjaGIqtCiGTH2FwObGt+fA
	/6z1VBw==
X-Received: from pfst24.prod.google.com ([2002:aa7:8f98:0:b0:8a0:7acb:abae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3ccc:b0:89f:feb6:5d5d
 with SMTP id d2e1a72fcca58-8a089d465bemr1396796b3a.33.1792584319027; Wed, 21
 Oct 2026 05:05:19 -0700 (PDT)
Date: Wed, 21 Oct 2026 05:05:18 -0700
In-Reply-To: <17ae73e9-c460-4ffc-9fc0-5fe2e8e1a08a@tum.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <f1f39118-2e1b-476b-9a84-ef7d56412bdc@tum.de> <atfxm7Tj7nYB_6Kr@google.com>
 <17ae73e9-c460-4ffc-9fc0-5fe2e8e1a08a@tum.de>
Message-ID: <atiqfqmzRhrlLGHc@google.com>
Subject: Re: [PATCH] x86/hyper-v: Don't WARN on VM-Enter if eVMCS sees
 VMFUNC[63:32] != 0
From: Sean Christopherson <seanjc@google.com>
To: Manuel Andreas <manuel.andreas@tum.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 21, 2026, Manuel Andreas wrote:
> On 10/21/26 00:56, Sean Christopherson wrote:
> > I think the WARN is correct, this code is broken.  Unless I'm missing some eVMCS
> > magic/quirk, this, and the secondary controls check, should be conditioned on the
> > field actually being used.
> > 
> > This, over two patches?
> > 
> > diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
> > index fa41d036acd4..a1daf8f2ec5a 100644
> > --- a/arch/x86/kvm/vmx/hyperv.c
> > +++ b/arch/x86/kvm/vmx/hyperv.c
> > @@ -169,7 +169,8 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
> >  					       vmcs12->cpu_based_vm_exec_control)))
> >  		return -EINVAL;
> >  
> > -	if (CC(!nested_evmcs_is_valid_controls(EVMCS_2NDEXEC,
> > +	if (nested_cpu_has(vmcs12, CPU_BASED_ACTIVATE_SECONDARY_CONTROLS) &&
> > +	    CC(!nested_evmcs_is_valid_controls(EVMCS_2NDEXEC,
> >  					       vmcs12->secondary_vm_exec_control)))
> >  		return -EINVAL;
> >  
> > @@ -186,11 +187,10 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
> >  	 * controls in bits 63:32, i.e. dropping those bits on the consistency
> >  	 * check is intentional.
> >  	 */
> > -	if (WARN_ON_ONCE(vmcs12->vm_function_control >> 32))
> > -		return -EINVAL;
> > -
> > -	if (CC(!nested_evmcs_is_valid_controls(EVMCS_VMFUNC,
> > -					       vmcs12->vm_function_control)))
> > +	if (nested_cpu_has_vmfunc(vmcs12) &&
> > +	    (WARN_ON_ONCE(vmcs12->vm_function_control >> 32) ||
> > +	     CC(!nested_evmcs_is_valid_controls(EVMCS_VMFUNC,
> > +						vmcs12->vm_function_control))))
> >  		return -EINVAL;
> >  
> >  	return 0;
> > 
> > 
> Looks sane to me. However, I still don't see a reason for this being a
> WARN at all, what exactly is the intended signal here?

That normal, non-eVMCS VMX added support for a VMFUNC operation that lives in
bits 63:32 and thus nested_evmcs_is_valid_controls() needs to be updated to play
nice with 64-bit values.
