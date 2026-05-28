Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1937C11B
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957197; cv=none; b=mwy9FSb96Lkrp2VNEgYMt3ffZ24288zkKU2fDUQks687xBemGgLEGPew1EFg8dI2tLY74BzNDDdnr9nMtpJXYI01GJxYQHEEJk893ug8Tl/lsHLCqG0HDChV5ImCgoufD9/5n+cCcXXA9kd/EBysRN2jjTY6btwmOtubTpF+Ahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957197; c=relaxed/simple;
	bh=7GdQw5SLYrsS5UKv8ze/lD/58ciM8ZFoJlksNNx+fxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlQlmotj5PhPqK7WxYK0CxCmw6t+LKXQTI+lUXBY40OG6y41VnCTpmxi6QSNICtDS+uZMdasS47pslKe+QfGSNV8AwBOZ0NfC2DzSfLzmOD2cMgz0gGtNiDjxZfV/iP7S/yNLHWxwXHlzAsJbgG+y+J/VSZEaaUy37MzhWOoCnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RXidwMWI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXidwMWI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779957194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XPTp0KLvnLjZiUygF1MJmNSJsB1SeYDUG9YOTlntX4E=;
	b=RXidwMWIssYrOeOkPgKqLC8yhfTI0Pfa5dCWL1xwJpiOVW6E9euNCxkeCp6201L5Xrx99R
	qZOwqZn/aZcjKOTTfyaIVSyG8edT5Xsv5eKFCuAjBuQ5ea/qi13/Y5qOuDuMNB2ELKgVR6
	/9u1cLLL0h7yKtDXqEyAnobcC/dgDs0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-RFN6KkSROEmDMjXlOmE4ng-1; Thu,
 28 May 2026 04:33:10 -0400
X-MC-Unique: RFN6KkSROEmDMjXlOmE4ng-1
X-Mimecast-MFC-AGG-ID: RFN6KkSROEmDMjXlOmE4ng_1779957189
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A0AB1956056;
	Thu, 28 May 2026 08:33:09 +0000 (UTC)
Received: from [10.44.32.217] (unknown [10.44.32.217])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5271230001BB;
	Thu, 28 May 2026 08:33:08 +0000 (UTC)
Message-ID: <bfc136b4-106b-41dc-a161-b39ca8d63161@redhat.com>
Date: Thu, 28 May 2026 10:33:06 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] KVM: nSVM: invalidate cached PDPTRs across nested NPT
 transitions
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20260527120600.20696-1-pbonzini@redhat.com>
 <20260527120600.20696-4-pbonzini@redhat.com> <aheD8XjfMrL9wGFa@google.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aheD8XjfMrL9wGFa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 5/28/26 01:53, Sean Christopherson wrote:
> I would rather use kvm_clear_available_registers() than add yet another API,
> which isn't even a good fit here since SVM never expects the PDPTRs to be dirty.
> 
> Though I think it's a moot point, because nSVM should be clearing *all*
> lazy-loaded registers.  It just so happens that PDPTRs are the only such "register".
> 
> I haven't checked to see if this would actually be correct, I'm just mimicking
> the nVMX code.  But conceptually, I think we want something like so:
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e74fcde6155e..0c6ab00766b1 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1303,6 +1303,8 @@ void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb)
>   {
>          svm->current_vmcb = target_vmcb;
>          svm->vmcb = target_vmcb->ptr;
> +
> +       kvm_clear_available_registers(&svm->vcpu, SVM_REGS_LAZY_LOAD_SET);
>   }
>   
>   static int svm_vcpu_precreate(struct kvm *kvm)

I actually started with something like that.  nSVM should indeed be 
clearing all other lazy-loaded registers too (except there isn't any). 
I ended up doing it the other way for two reasons, both boiling down to 
PDPTRs being weird.

First, the PDPTRs are cached processor state but not a field of the 
VMCB; changing the VMCB should have no effect on them.  For SVM, changes 
to their cache state are purely a result of writes to CR3 or CR4.PAE.

Thus it seemed more explicit to single out the PAE+nNPT case when 
loading CR3:

	if (nested_npt)
		kvm_register_mark_for_reload
	else if (!load_pdptrs(...))
		return -EINVAL;

instead of the slightly more opaque

	if (!nested_npt && !load_pdptrs(...))
		return -EINVAL;

Second, with nNPT it's not even entirely correct to cache them at all. 
Strictly speaking they should never even be marked available, that way 
you'd go through load_pdptrs() on every PAE memory access.  Thus 
kvm_register_mark_for_reload() could also be tied to the CR4 write, but 
in any case not to the VMCB switch.

I'd rather keep it like this but yeah, it can be done either way.  If 
there were other registers in the lazy load set, relying on 
svm_switch_vmcb() would make sense but you'd want to add a comment above 
the two instances of "if (!nested_npt && !load_pdptrs())".

Paolo

