Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083701F938
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814758; cv=none; b=NnDx8hIbnruCOjjG1kDytn1CYYovsS0/nLVlWYf+t2opi1xVsK22adqVY55bhwEAzVE8j1taoUpVFMNB4S3p9D2KsgcYs1w5PzLuHKHiV81Wm25EbVjnnMrAFbPgaIQDaULful+hE6ZneR3qy1kGkukkvTKE+hhUIqbXG2ZX0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814758; c=relaxed/simple;
	bh=+M2lq8eXiQpWBpa+2ZtEAztL2BJXiQ6mAIcL7vywVEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cv+wfx+wOFsJKqg1zj/k+Bgp+LU24fI4AgNtFu6Qf0t259uFKMcE7TFcCSHrkjmGVMGySmuAVffZP14oF8fEyqmDl1j+x7k52BJkmsJq/9X1brwyFE2NhCfl99RnuOKq4FQeooDsYDchhmu0ELkBa+qaPqscwXKDJ22kWLTQs/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYcBYR09; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxJgXgBK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYcBYR09";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxJgXgBK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787814756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zKar+nG5lsoxvqM8uItXzpn6DuwsTlDLsEfEBv9+YYg=;
	b=RYcBYR09E9TwNgzXvewl9SHws5XQr+RsMJGyMXfdOEiDF7+YU3iT4zoBBgrpGZcHI8WtmJ
	FKUnbe7zhqfZkAPZlgwH8meS7ct6Z2gngJ95AwsNIe7HtMe5PP5yrwIbSl2hZ84Z5zBnY+
	cFbwgTwZDdas+sWNybtIvohyTZUEzVY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-VXHn7lnXM8SCODOZJ0n8bg-1; Thu, 27 Aug 2026 03:12:34 -0400
X-MC-Unique: VXHn7lnXM8SCODOZJ0n8bg-1
X-Mimecast-MFC-AGG-ID: VXHn7lnXM8SCODOZJ0n8bg_1787814753
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49808ea1b64so4820915e9.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 00:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787814753; x=1788419553; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zKar+nG5lsoxvqM8uItXzpn6DuwsTlDLsEfEBv9+YYg=;
        b=fxJgXgBK2nrilfCan+XEljyJ/15SZXqzCeLYosrRmwT2z4K5GfDA40FHMEcuwaIk9f
         Tu8C2mUXVRPz0GVJhJGRutjOWqX6qHz6nRmPxzagHSy+FteLeiS1L6YY+YOS9tIBdRWA
         pIatOwxueE0nCvtxV8vJlAGEjoM18lCajB6YXdljP/CQoJQ/yHs9tED4zlD67mMNWYiU
         SX72N1zw5EZH9HLJcYi/n3AYIkzIYs7y/vxMA2RpFLpqrZUjl1kEsGH71XuadqovB+ZK
         wU8oCLNh6bSgV4K55NldlHjxDaVHr0Lt8Fw32Jmy6ELoh3qYutHdvoqFlBVXE998ddlH
         Aj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787814753; x=1788419553;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zKar+nG5lsoxvqM8uItXzpn6DuwsTlDLsEfEBv9+YYg=;
        b=hwp21XLtgFVs4XJZP5qM6IIrWwz+C7Nh8q3p6xWnGykDqpMFHEBmyvFTcQ40gq2QhB
         C6G9OPBS+Gxfq+VNXzhAMJoy0hmPUAi7AMFvRU4S0CZwHLdkqsPxDfveGNCRjVaUNCE6
         DlGnzlxt1JtcA1igFi87/ezxRxhLorcJssyP38uJ3+fHllwr2Ld34OGdt8/P2eyouvLu
         H+Z7E3r72lix22ra9QUdq8TdvmjZfIIXCcow+7hCm1sugCTevZY/FoWrBMrGtUf+N+yQ
         dfia9e70izxpV73lEnmb5436RnwXh1+rKMNaxJjp9KkP0bHSxSKwYN4RZtIbnuLUw6Co
         dpWQ==
X-Gm-Message-State: AFuF++kY+k8m8KVg5/dywz8rENbJlpMNstT5P5FQYsXwKecNU4wiRdoX
	4z7ya18OGFEfqvOmbaNW5DgeMBdNONEDjTUnZXGmZBJeCfyY9h8tMniUy5dBIz/mEDMUZNZuJWV
	OMyGFy0O/hHEl8r1PDpdHnOwmZ6nQPoNgyA4rtMVQYdCDWhqFISUY1Q==
X-Gm-Gg: AR+sD12T2EP/exxfknqYPuBmGOY+xi64iDJRgbMcT9f2KJcvDz3aD3wg0BDrJxxmeeb
	R/sXvhJ2Td7b8t9PgKR6eyW7Nj2t5EU3s+t6ia5talcwzWxAa5kz/8lz4GeujwUrrZJIJp8hibz
	GU4g+SrRedh6PzN7x6dM9CpHu2UhFJaCjltx0TM0J3tWAm6u4ZutCQ+4Y4U4ZNR/e6HBfjVbPiU
	mxwMLdNufhiA3XXi6czj1pDtJyviFdODZ2ONw//mQm0YWxGI2r9Qcg3w7c1PQ+a9z/Cfz4kyM5R
	hIxqVyNTmvhfzI4lc0mTD/eU5fuoRh0vAt/oJSIRTu9G4cJUfLymAk7tkiQTIzDflL6R7DAMYJs
	=
X-Received: by 2002:a05:600c:3b25:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49b0dfcd4c2mr41981075e9.6.1787814752598;
        Thu, 27 Aug 2026 00:12:32 -0700 (PDT)
X-Received: by 2002:a05:600c:3b25:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49b0dfcd4c2mr41978785e9.6.1787814751222;
        Thu, 27 Aug 2026 00:12:31 -0700 (PDT)
Received: from 172.16.32.78 ([95.12.116.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b465226d8sm29209475e9.0.2026.08.27.00.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 00:12:30 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Teodorescu
 <fane@google.com>
Subject: Re: [PATCH] KVM: x86: Zero reserved synic flags when delivering
 message to avoid stack leak
In-Reply-To: <20260826184449.814130-1-seanjc@google.com>
References: <20260826184449.814130-1-seanjc@google.com>
Date: Thu, 27 Aug 2026 09:12:29 +0200
Message-ID: <874iggnijm.fsf@172.16.32.78>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Ensure all reserved flags are zeroed when setting the msg_pending flag as
> part of SynIC message delivery, as setting only msg_pending can leak seven
> bits of kernel stack data to the guest.  E.g. gcc typically uses a
> bitwise-OR to set the msg_pending flag, without initializing the on-stack
> variable.
>
> Precisely zero the flags, e.g. as opposed to zeroing the entire structure,
> to make it somewhat more obvious that the flags *need* to be zeroed.  E.g.
> it would be quite easy to misread the initial read of guest memory and
> think that zeroing the entire structure is completely superfluous.
>
> Fixes: 3a0e7731724f ("x86: kvm: hyperv: simplify SynIC message delivery")
> Cc: stable@vger.kernel.org
> Reported-by: Stefan Teodorescu <fane@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/hyperv.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 604651cb2739..8d2669d8ef34 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -802,7 +802,9 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
>  		if (no_retry)
>  			return 0;
>  
> +		hv_hdr.message_flags.asu8 = 0;
>  		hv_hdr.message_flags.msg_pending = 1;
> +
>  		r = kvm_vcpu_write_guest_page(vcpu, msg_page_gfn,
>  					      &hv_hdr.message_flags,
>  					      msg_off +
>
> base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

(although, I kind of like the idea of zeroing the whole structure with a
comment that we don't read it as a whole from guest's memory too)

-- 
Vitaly

