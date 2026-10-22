Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678062;
	b=Zy8NttIfaedHWqdVoRWfx6STs2S88R5Gd8yumHNnC7dexpOwoMhTuesqZ4LnMIVAlVAz
	 PxCcNYwER9iOpXVBeEAgcjBCvhUxC4YzezQZJc6aOUJW+FvM8IBbH6SJMCwNPe/chW2Wx
	 EnBCtrBuMpujoFu3Vo6L2u/SsuvuVLNwgAFfWMeKJq5XeRfWsbk6sZm9BVE1hXDB5nAVs
	 xaV7dcBGPWXN7Ik3sS34fNp1d+yG0MOr9OzZKqmafBo+TrSaiEgEaZl1aXuCIj8VnX85J
	 /5r07J92dOQV3ujfsbEUAYsv5Ec0Sn9TTFZuyXRicUqW5WRZHMR2WBIq0dSgStp1ObQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=L2bk+XyfwlmCA3CKyWFm6QRPY6WWogRK1aqIm5Z8PyA=;
	b=r2RqoVYq1ok3NhVQ7s6Kr3EO0RFxZp2CppTFDnYhJ6xkAt2CrGMcNJYkpy5bWOSLVBRu
	 PyLovebfqG7e+wj6RoT1w5OOqsNI04jysMuuemgeZvqH1jHj2QrUzviKK2mgc8X5VOYSo
	 RrZ/FMYEV+GWcruE+lcHExd+ZP7xIhHb7E49kKhmdkr4Y0sk43v0HLcm5ArjmC0GhbqPd
	 NXoJQxrL95nPGTQqOSkXZ0FAxyJ2QPypGWR8ayB66gpO/d75k8KN6ccLdv2KfnrmyCcMi
	 DfkEieTcaSC1IDgPvnQ1N0Ka2M4yPHh7hvAQiUqSiWvH/4Ns3jXGrYIO2vGURoGccyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=m80Y3cHY;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1355A606A321
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 14:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1355A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=m80Y3cHY
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a46f0f158dso1464690a91.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 07:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792678061; x=1793282861; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2bk+XyfwlmCA3CKyWFm6QRPY6WWogRK1aqIm5Z8PyA=;
        b=m80Y3cHYCV3Bl/jTqvzKFvEaQVG5/sszQP0gu6TSx8jOrHqhGFb/85jUuqb7+WkGni
         X88+TZnJjA89hYTXPYASN0SktYfaLfxyXXew15uGcxKMD2H3Rk49ZelJjXBG0UORucvf
         A+BYE50f7nqLeV3MHu4GHqxZb21M9zbQ9Ufn3sD+i7Kr6VPTvEJ1v0sbw7mskzgmS3jo
         jzYT/vrdrT9mUgue+Nh9TRBHT8Bek4aGOdZS36kymHWF7YhSiSOM32yk/wGYZkr01Ycm
         4LRQQOcHQ6wojgiRXwnF1sjtNdVWb9Dd6tWM4iaOYsmIauRDJAfciBGo7ocxGp12XYkh
         Bspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792678061; x=1793282861;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2bk+XyfwlmCA3CKyWFm6QRPY6WWogRK1aqIm5Z8PyA=;
        b=jtS2rJQp5F7ESBvxTB45Kb55G319XHZGNzSheVmO3KxIWNOBnBooLT6YzpwCa13LJX
         y6Ll8+H2H9m0poZhQdZGIcL1d9uu57A2oRTK5/HWAkJnIEaNZ7rjcJCWd8ZJtZlSC2B8
         DJnrDdg00Xv+MeaegNNwT9Et31ZpLOUxKREfh8tVs5LMhApyh3iVZybWk0sFOXPr2S4O
         TJkHcSpiSnf0RiVWanrCavO5NibQ268cBHOHKrPRMlq5BNqqQfo6ep5U5vv/ci7GjAJP
         wa4bLVfCbydsanaeeJXyDH0us/unOqeLpFzgEezbya72XR770o8CFuzKGEP9UkqCbBly
         mP9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxHF5D/Fe5MDxIgAnACQ87ztwLYxmRDVcfzVAY3lu+itcTackt2uVQENyzZtLh3I17pYYA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3ZH5IB5dQ8ml+iN53ShI6c7p+wo/4Ny35d0gAqIK/L7PSMLal
	l1SNVO4+EzyqsaGLVO9wtizGTY1f7EYeK1h0zRY3voLKveH0Hac4BMHUyi+eR5kOXIlz2b+L+X7
	vf8rZkg==
X-Received: from pjgp5.prod.google.com ([2002:a17:90a:4285:b0:3ab:fd4b:afa8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a48:b0:3ac:8b67:185b
 with SMTP id 98e67ed59e1d1-3ada6c8dfb6mr1430284a91.26.1792678061114; Thu, 22
 Oct 2026 07:07:41 -0700 (PDT)
Date: Thu, 22 Oct 2026 07:07:40 -0700
In-Reply-To: <20261018115229.315110-1-pablo45154@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261018115229.315110-1-pablo45154@gmail.com>
Message-ID: <atoYrLz3gQK8WTk9@google.com>
Subject: Re: [PATCH] KVM: x86: Initialize the PIO bounce buffer on PIT
 control-port reads
From: Sean Christopherson <seanjc@google.com>
To: Pablo Azuaje <pablo45154@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Sun, Oct 18, 2026, Pablo Azuaje wrote:
> pit_ioport_read() bails out for reads of the control word register
> (port 0x43) without writing to the PIO bounce buffer.  The read is
> nevertheless reported as successful, so the guest receives whatever the
> buffer happens to hold -- typically its own bytes from a previous OUT
> or IN on the same port -- as the readback value.
> 
> Real hardware returns undefined data for reads of the control word
> register, so keep KVM's behavior well-defined and predictable: zero the
> bounce buffer before returning.  The read is still reported as
> successful, and returning the guest's own prior IO bytes as a
> pseudo-readback is observable state with no architectural meaning;
> zeroing is the least-surprise choice.  

Hmm, IMO, returning all ones is more appropriate and would be less surprising as
it's more obviously an error, e.g. mimics bus aborts.  Unless someone objects,
I'll fixup to that when applying.

> This is also hardening rather than a security fix: the leaked bytes belong to
> the guest itself, never to the host.
> 
> Fixes: ee73f656a604 ("KVM: PIT: control word is write-only")
> Signed-off-by: Pablo Azuaje <pablo45154@gmail.com>
> ---
>  arch/x86/kvm/i8254.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
> index 1982b0077ddd..a4c23962f161 100644
> --- a/arch/x86/kvm/i8254.c
> +++ b/arch/x86/kvm/i8254.c
> @@ -522,8 +522,16 @@ static int pit_ioport_read(struct kvm_vcpu *vcpu,
>  		return -EOPNOTSUPP;
>  
>  	addr &= KVM_PIT_CHANNEL_MASK;
> -	if (addr == 3)
> +	if (addr == 3) {
> +		/*
> +		 * The control word register is write-only.  Zero the PIO
> +		 * bounce buffer instead of leaving it untouched, which
> +		 * would feed the guest whatever it last wrote (via OUT or a
> +		 * previous IN) as the readback value.
> +		 */

I'll shorten this to:

		/*
		 * Control words are write-only, arbitrarily return all ones,
		 * e.g. to match bus abort semantics.
		 */

Because this code really should stand on its own (which is the whole point of
hardening this code) and not describe the emulator's rather obscure and subtle
io_read cache behavior.

> +		memset(data, 0, len);
>  		return 0;
> +	}
>  
>  	s = &pit_state->channels[addr];
>  
> -- 
> 2.53.0
> 
> 
