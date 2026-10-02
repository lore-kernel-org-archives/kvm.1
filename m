Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A704DAF8C
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955320; cv=none; b=mXRBk2lZysNPvv7ci8GhhEDLw14K9qt1IPPzJrHBlEuSj7CGTq1Mt++/kg+gm25MUxboxFFcfS6Ikvg6DQ7tNvWO5uhJMWKJDPgseMRUwLngVGq+G5fI4KPapzvd1A1U5hbnQqY/15dG49Yu5ZnnarbNv56VdOsXJ3q1R9kZWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955320; c=relaxed/simple;
	bh=bgMeIh1vpMW5r0Z2UUaueYfyJsodKGJ3R8+jL/Snwco=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RXS5zxuKYVD59kFYJyK8qCd3CHDWWSZOfXZY8kCU6AHRlts+u9F6PMwAEgro94CKN9h1i6500n+iHU/tMsniW5/2rC0tNMQQyw2RzZrpnQ4rNyQDaa/yESmDTxaofkcv89fMctdM9s4PUDE/9XtJMVfBEAWX9TvizPSQg1d4i6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nNudwIvh; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nNudwIvh"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e2ebeaa0a4so24672415ad.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790955317; x=1791560117; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ulPJ+yIIyvNEzuRqB5Fotp1huOAGEZ6P6NiuujPsDU=;
        b=nNudwIvhhu5usQa6iKxaCWlojQRbykbKapf29CHEmEuiT1EL7/n83bJbhV6qo+9Hmz
         DEBW9h6W/HqPQYSZ4Nbme1n8hGR/PrSIfydaS3h81mIqyfQ9qRYRO7zM1XG6ipcKakRr
         1UTZocn1KbLTYGjmGHvUcjdP6vQszd8C2/xJKMQbAnFHdyM6pv48I3lT4LqB8ZuE9eDf
         /O3xtakI9fZQ5vSJ1jEsQxeVKKBuUkB5lCuRVEdhm25vJDw7jvzmESYLkGypU6vu2zfU
         MKOqFwr/ZT578n6+QTuD74+qqMHZcElfAM8PHJVJ+fhat6J8nKYfJ4pD0+f+zTpB69nP
         ehug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955317; x=1791560117;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ulPJ+yIIyvNEzuRqB5Fotp1huOAGEZ6P6NiuujPsDU=;
        b=WLJe5rqklt0/Xvt+xG/PXmXsF2z/OmJbIXQiq9uLBBvuFFFJ2BT6bJjCib6H6V4X1C
         EP3mOJMpsw5Zo0wtuHfIX3pgqCGg56vvNVa0/Uob0t/EjvxJo7oXyZgeSgl9+ZGACko6
         VrBcVWobA/ZfY3nqsYW/Um9Tdswmr6lECN4rY36/1qAgC/hxqHBZ4DmamaZ6JrvMxkEp
         FYUKRX4ANYyWmy4N9iCk0SX0/yOg8s3zCjA0kJJL2YUILKlhlthgTcVx9GeGVi1D/sNd
         TpBqKXHHIYgjDImw/i/+shm0MsDxz9dSoFbHrLn5YgyEEXjFaZtonArWljazLWD23n+d
         cIfw==
X-Forwarded-Encrypted: i=1; AKwUvBwJOlyI1okxPbPAWgXQmMqFC/I9GSQGr2TK0knN+povaSAdpa6j5zmhPPOp2ZC/ELvTqKM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIivMBF2Il3iWRdVTHbmu1ZUgTqvcpoJa8GkUhno/tDnfeJhskY
	ZrdiWmkE5Oby3aRT4jLCPIZdby42MpgtEufwJ/mf2aoesVpOvKQAQ4XfJWkziT2X6oI/X1z8Khi
	MZ7mYnQ==
X-Received: from plq5.prod.google.com ([2002:a17:903:2f85:b0:2e2:f17b:1655])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8c3:b0:2df:9305:8909
 with SMTP id d9443c01a7336-2e49b6ab32dmr26853235ad.17.1790955317254; Fri, 02
 Oct 2026 08:35:17 -0700 (PDT)
Date: Fri, 2 Oct 2026 08:35:16 -0700
In-Reply-To: <20261002151942.491680-1-bruno.produit@trailofbits.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002151942.491680-1-bruno.produit@trailofbits.com>
Message-ID: <ar_PNEIvsQMQPMLg@google.com>
Subject: Re: [PATCH] KVM: x86: Cancel PIT timer on failed creation
From: Sean Christopherson <seanjc@google.com>
To: Bruno Produit <bruno.produit@trailofbits.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org, 
	Kyle Zeng <kylebot@openai.com>, linux-kernel@vger.kernel.org, 
	Dominik Czarnota <dominik.czarnota@trailofbits.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 02, 2026, Bruno Produit wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> Cancel the PIT hrtimer if PIT creation fails after registering the PIO
> device. This matches normal teardown and ensures the timer no longer
> uses the PIT before its memory is freed.
> 
> KVM registers the PIT's PIO device before registering the optional dummy
> speaker device.  If speaker registration fails, a vCPU can have already
> programmed channel 0 and armed pit_state.timer through the published PIT
> device. When I/O bus registration became fallible, its cleanup did not
> cancel the timer before freeing the PIT.
> 
> Fixes: 090b7aff2712 ("KVM: make io_bus interface more robust")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
> ---
>  arch/x86/kvm/i8254.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
> index 1982b0077..b7875345f 100644
> --- a/arch/x86/kvm/i8254.c
> +++ b/arch/x86/kvm/i8254.c
> @@ -793,6 +793,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 flags)
>  fail_register_pit:
>  	mutex_unlock(&kvm->slots_lock);
>  	kvm_pit_set_reinject(pit, false);
> +	hrtimer_cancel(&pit->pit_state.timer);

Given that the timer can be armed if and only if the PIT was successfully registered,
wouldn't this suffice?

diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index 1982b0077ddd..33d772c7160b 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -790,6 +790,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 flags)
 
 fail_register_speaker:
 	kvm_io_bus_unregister_dev(kvm, KVM_PIO_BUS, &pit->dev);
+	hrtimer_cancel(&pit->pit_state.timer);
 fail_register_pit:
 	mutex_unlock(&kvm->slots_lock);
 	kvm_pit_set_reinject(pit, false);


>  	kthread_destroy_worker(pit->worker);
>  fail_kthread:
>  	kfree(pit);
> -- 
> 2.53.0
> 
