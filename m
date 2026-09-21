Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749049BD9C
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996597; cv=none; b=TqiEobMiQZFINh4qYrIwyOqQVcFGwyvLKauciNhb3t6oD9qTqtHkUSaBtjvxjGtVJTbwigdli6EEMZfNVjIoZirzba8EMNP8cnWNd+j5PpDLGrq7gAEz2TTJqqExIZ6xUBE2AVqYlfZuXElnCYnjreiNdhLjsJzX7XzzDIWZ6TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996597; c=relaxed/simple;
	bh=vpvALyL6DXZlGhmS7T7Gy8frY8hVGvqNq7gl4GIuhfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ksUAjwKxscsJV0MBvF+m6HyyO5FqhfRX1QoX3xUrrIeECr7WFIevun0AeM2OZkxODcScJpVRbn6qLWQtCC2FCp7Nxx89lDFx9XeY5VWX9ahI6HXDIyATwFbUn6Y3UFRHCNaRgphuLyO9sEJCcRfQsvfZPGIrvQSiQ3KeZijpikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ROi4MgyQ; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ROi4MgyQ"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so7493077a91.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 06:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789996595; x=1790601395; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v8bXDT9XWz0bdXvCQvw9Fzzfd6caP11XJvcoGX1EdXk=;
        b=ROi4MgyQ0CVV7pWYYha7KVYN6vPYhyCckG2grXTlkZSOxGiunjUvXCCLmgNVlyDF3C
         yTNapbpaC1Cx7qWulR3iZp5uGoIm3T0KezeOv4iid9iAM0/6Tln7Xi3a+Igx5ZzMxekr
         bUxj9WKT4qCg+jFrUF6RNnHBJv2O5Vk1Hpkg51jVifAWaOKInR3Cxa+XpyrrWKr2wlEY
         7nomIqaiUVZFmuDujT8+Ddc/HtRSi/kBJ0tzOZVCraVHIWvRwQerg40sB3ELzvnDAP9P
         ZLKggAt1CKVaulKXciDp51ae/45H1mipXfnk5V9Jg3O99Mh9ohjeMm2sRHxtMzYdv5Fs
         1jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789996595; x=1790601395;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v8bXDT9XWz0bdXvCQvw9Fzzfd6caP11XJvcoGX1EdXk=;
        b=l974EPdiKtIibhew03qi6+19mMlRF7yX5/0vPJAf9HQ13Dj0uNGpsmEfjdyZs/j0oD
         4iDWR5+dVCsCMEKyuj7C2KkAFhFT6TkM5ThC8lKjGuskYLL51ldY/F4qMad15c4Q8hND
         iraJazJEm2JMzq4PqMXwFSjwOOh5MO/IiC4t6J4LTGHdyLpNdIwxrHNxym5v/ZVcqN6P
         mgVAza2RYYV6F5RU0pDLH8Z3bHz9ugfjrRXQfjbetwKvTsItUMSpgJ9YN5GkGcnAhfCy
         93J+MpUqBHR708O64zKEOb0X13n5BJxvOjeNbE0DXXNHHhlKRx0xChrENLlyd25aXy/3
         BPuA==
X-Gm-Message-State: AFuF++mXHWJlAH4W6JmEK36KnTsV4NgpPWmUbpPidJVeUkqpRoWU2JT8
	XOJA7ul/wOcW+G2qcAVgvft5d8QSx8/hDr8HFUipPUCxb/FV7LWhlVaFAwGQZLbO+ql1ZpEYvw8
	tFfyV9A==
X-Received: from pjbor4.prod.google.com ([2002:a17:90b:39a4:b0:39e:1d3:781d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:180b:b0:3a0:3881:ead0
 with SMTP id 98e67ed59e1d1-3a03881ed91mr5596252a91.11.1789996595133; Mon, 21
 Sep 2026 06:16:35 -0700 (PDT)
Date: Mon, 21 Sep 2026 06:16:34 -0700
In-Reply-To: <d946de080e3dd34844a665c167179e4910fdc9d4.1789399214.git.prsampat@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789399214.git.prsampat@amd.com> <d946de080e3dd34844a665c167179e4910fdc9d4.1789399214.git.prsampat@amd.com>
Message-ID: <arEuMojZa_kv9VXA@google.com>
Subject: Re: [PATCH 1/3] KVM: SVM: Re-queue events that were never injected
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	pbonzini@redhat.com, thomas.lendacky@amd.com, kim.phillips@amd.com, 
	nikunj@amd.com, michael.roth@amd.com, ashish.kalra@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 14, 2026, Pratik R. Sampat wrote:
> When injecting an event into the guest via the event_inj field, a
> non-zero event_inj value on #VMEXIT means that the hardware was not able
> to inject the event into the guest.  This used to only occur for the
> VMEXIT_INVALID intercept code, which was a fatal error and resulted in
> the guest being torn down.
> 
> Enhanced SMT Protection (ESMTP) invalidates that assumption.  When ESMTP
> is enabled, VMRUN doesn't enter guest mode immediately; it stalls at a
> synchronization point until every sibling thread is either idle or has
> executed VMRUN for a legal sibling vCPU.  If an ESMTP timeout / illegal
> sibling exit / interrupt arrives while VMRUN is stalled, VMRUN can now
> terminate with the corresponding #VMEXIT intercept code, without
> entering guest mode, and thus without injecting the event.
> 
> For example, on a 2-way SMT core running vCPU0 on thread 0 and vCPU1 on
> thread 1:
>   Thread 0 (vCPU0)                         Thread 1 (vCPU1)
>   ----------------                         ----------------
>   Interrupt A injected to the guest             in host
>   VMRUN                                           |
>     |                                             |
>     v                                             |
>   Stall waiting for sibling                       |
>     |                                             |
>     |  host INTR arrives on thread 0              |
>     |  while it waits                             |
>     |                                             |
>     v                                             |
>   #VMEXIT                                         v
>   Interrupt B injected to the guest              idle
>   VMRUN

So how is KVM_RUN_FORCE_IMMEDIATE_EXIT supposed to work?
