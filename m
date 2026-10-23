Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789249;
	b=AI5nabtveVvBdDkgi5Da7OhxhcUN6vl0rmx38jw6hd/vNPYS0RWgggvgSGBte5bZpri+
	 dUhRYfT9BZBFwbuPRsjxMI/8opgLDgY51S4tWHYnM9HV50rEo6zhuLltki6ya3LnagZru
	 y0nrbx6m/vbqYD8iZU+licekYfAYRKfg2hWahMwKIhJHhYvk4AcWUDXk7GnD9ud0EWU/Q
	 YGXlLnSyRwjtJGmuGRMVR7aSy8n3Ucfc85mKlV94IkLbSsXmc4oKPXg+0DxsODrcrXDW9
	 6Gs4yAnm4yCI5myPPIfws6I7GhCIU+LtH0zdjS6T8a4YVROfbRRuv+IIb7mVpc5zx2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789249;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=fO9tCv+Dk6N+Wu3Qpc9SroVvJnnr+VUFnmZ0sB7IXg8=;
	b=VytgpQsbm/Jg/Ww65AP6lj/HSKZdgbGiTBIziBSqDDDM/Pq7dCLt9CdAAYUxex2e5dx/
	 qv0gdDB29KYq3j5MOMbB55LYdMZikyNVX75+qw4U3i4iLGrBdAEfOT0Q0aMYqRz96olAn
	 DxF5b+jQ5DTH913P3p5czhFOR5oTEy2rorRXLFWjQt5mmgDrOKq2beWL9271Sfot6PMsT
	 mr5oJrLEUbz9ObHEk7tXxlUWTWKOnUoxsrJY2f8RDL1P1OHvY3GCSGSTxjdRpwgIuFqhG
	 eQ07VV7pe0xDLUjuwjxlVdIMaVHf8sAxgMh8iHT7sADBIuyx2FHNHZ0CkKUBV9JymFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MOFkdYyK;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0E606A328
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 21:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BD0E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MOFkdYyK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792789247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fO9tCv+Dk6N+Wu3Qpc9SroVvJnnr+VUFnmZ0sB7IXg8=;
	b=MOFkdYyKUOwlzN8N4oXyHn/XDqvsrRTd9S5tIRQPJx9vlepbN4Fje0OC45iYKsU8uqb/v0
	9T/s91qc+hoKvRkyW7SWm0+c8ckms32f3OPMenespbKbfL281MBaempWUXO5vZhayhd6aS
	CTXFq9lWZ/dkMVL+vZD9WCp5wELByng=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-lfVUmV-uPeW1doAq3MUDGA-1; Fri,
 23 Oct 2026 17:00:43 -0400
X-MC-Unique: lfVUmV-uPeW1doAq3MUDGA-1
X-Mimecast-MFC-AGG-ID: lfVUmV-uPeW1doAq3MUDGA_1792789241
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACB7C18007F1;
	Fri, 23 Oct 2026 21:00:40 +0000 (UTC)
Received: from [100.90.56.12] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D5D9F1800480;
	Fri, 23 Oct 2026 21:00:36 +0000 (UTC)
Message-ID: <bd608c7c-676a-4b65-97dd-626d0e8a5514@redhat.com>
Date: Fri, 23 Oct 2026 23:00:34 +0200
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel Shadow Stacks Versus XFEATURE_MASK_GUEST_SUPERVISOR
To: Dave Hansen <dave.hansen@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, John Allen <john.allen@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, peterz@infradead.org,
 kvm@vger.kernel.org, binbin.wu@linux.intel.com,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Bae, Chang Seok" <chang.seok.bae@intel.com>,
 "Mehta, Sohil" <sohil.mehta@intel.com>
References: <2f0560df-69fc-4fc1-81fa-447e289ec2df@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <2f0560df-69fc-4fc1-81fa-447e289ec2df@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/23/26 21:03, Dave Hansen wrote:
> So, I'm working on kernel shadow stacks. I have some nice optimization
> code like fred_update_rsp0() for SSP0. It avoids WRMSR's on exits to
> userspace if FRED_SSP0 hasn't changed, just like FRED_RSP0.
> 
> Well, turns out that FRED_SSP0 isn't like FRED_RSP0 in one very
> important way: it is an alias for PL0_SSP, which is managed via
> XFEATURE_CET_KERNEL which is in:
> 
> 	/* Supervisor features which are enabled only in guest FPUs */
> 	#define XFEATURE_MASK_GUEST_SUPERVISOR  XFEATURE_MASK_CET_KERNEL
> 
> So, I was running along just fine in my nice shadow stack kernel going
> in and out of the kernel just fine. But the first time I did an XRSTOR,
> the XFEATURE_CET_KERNEL feature got set to its init state. My SSP0 cache
> didn't notice and I tried to run userspace with SSP0=0. Much hilarity
> ensued on the next kernel entry.
> 
> The most adorable part of all this is that I have KVM compiled
> completely out on my config. The "only in guest FPUs" code is biting me
> on a kernel that can't even run guests.

If you want to quickly work around for your !CONFIG_KVM kernel, I would do

#ifdef CONFIG_KVM
/* Supervisor features which are enabled only in guest FPUs */
#define XFEATURE_MASK_GUEST_SUPERVISOR  XFEATURE_MASK_CET_KERNEL
#else
#define XFEATURE_MASK_GUEST_SUPERVISOR  0
#endif

and a small adjustment like

         BUILD_BUG_ON((XFEATURE_MASK_USER_SUPPORTED |
                       XFEATURE_MASK_SUPERVISOR_SUPPORTED) &
                      ~XFEATURES_INIT_FPSTATE_HANDLED);

That will get rid of the bit in XSS.

> Any thoughts on what we should do?
> 
> Actually context switching XFEATURE_CET_KERNEL seems kinda silly in a
> lot of ways. PL0_SSP can always be derived _and_ it isn't actually even
> needed at context switch time, only when running userspace.

True but, just to understand, what is the performance like if you 
actually use XSAVES/XRSTORS to update SSP0 on context switches instead 
of WRMSR+cache?  Hopefully the microcode does a bunch of optimizations 
as well.

> I could just aggressively blow away my SSP0 cache any time an XRSTOR
> touches XFEATURE_CET_KERNEL. That would be easy. But it also seems silly
> that XFEATURE_CET_KERNEL is being blown away at _all_ during normal
> context switches. Heck, it goes further than that because:
> 
> fpregs_restore_userregs() does:
> 
> 	restore_fpregs_from_fpstate(fpu->fpstate,
> 				    XFEATURE_MASK_FPSTATE);
> 
> Where XFEATURE_MASK_FPSTATE contains XFEATURE_MASK_SUPERVISOR_SUPPORTED.

The actual mask used by restore_fpregs_from_fpstate is tighter though, 
it's "fpu_kernel_cfg.max_features & XFEATURE_MASK_FPSTATE".

Can you replace fpu_kernel_cfg.max_features with some fpstate->xyz 
(sorry too late to think it through :)) that has CET_KERNEL for the 
guest FPU and not for the regular one?

> So a "restore_userregs" function is blowing away supervisor state.
> 
> IOW, I think we're using XFEATURE_MASK_FPSTATE a bit too broadly.
> 
> I'd like to get to a place where only the KVM code even has
> XFEATURE_CET_KERNEL in its RFBM.
That I agree, but I think it can be handled in 
{save,restore}_fpregs_to_fpstate().

Paolo

