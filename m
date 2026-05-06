Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A66307494
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101927; cv=none; b=b+0rb6b4bbRqftLWg3pmDLnJwGR1aEpQJsRrLnwrjmY0JSsWPDicspoYohHWtNusrcwHH26E57LBblHwmAK0sbdEcX29oPVseYPwrbQsTpMmCPT0pCJ91hSh1XfhUrXqWHAqcOeXzFiB8oXmzqkae5OUavEflFwGJT+/N/QAgxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101927; c=relaxed/simple;
	bh=sHR07WL1m5zVcVatfqAZreysr38pm86A5uG5VHPTcow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FBRj1pwimLYYgIOmlaFu3x1+o8AxiF1fk8wfb5WjpaWaZwmhNz6FICOtaTbSXBOZkNy8QrU2ranTOirKEghJXakauAE7b012RqIdFnBxXksz3ytYhQhYC0UNJze/j4JA9iEtN+KbARbJNFB9BHwg0X5PNLcu8gvNoKKwW6Ck1ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8C3nMyG; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8C3nMyG"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8234c06a10so40745a12.3
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778101926; x=1778706726; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=koo+gvWEynmD8LVuys6S4Q56WvY82whGU0uBjLzglQU=;
        b=I8C3nMyGAQVSNRsoGN1mmLzbvmA5Nrd2NpHEXxK/9JcpaRvIfBxwuB/0dBcjB8LxFm
         W433ZQqcaYLToUx9zfdElwtuWYw1Zszr5lTWMFZDMgymx/NbHQclrBE3XyhJTMMPbtHw
         2LQg1NRYdnMfTtGANUM0TJrIDFLyFtln1Ui5xAf/Ii1bgHT5X8bSz4OzvFVQ0eIqFblp
         Ggcz0Gr8c7KE7ktp4lbtU/4UbkPF2wtmCgt1rzCDHi1UejAyCK79hBSkmmGwDUjrTbn4
         8o/Ha/DnAxgujmLG9ZByn6ovUNl1vWOhv8GZLpWwR6piT8ZbxRozsmZa9BK4FsmYOc9M
         yDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778101926; x=1778706726;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=koo+gvWEynmD8LVuys6S4Q56WvY82whGU0uBjLzglQU=;
        b=WSETRxOhmjRCVzyjxwCeZxHIWYVsetVXVg4WjypvpYqYzGjssi3rP1RvlRSpI5l3+r
         jfWH/1yHOYkqC+KZV7cOZc6BKbNHrDcrGSFr/ZmvNJtThFo8hCCJKWvfs0oBs/B94UOl
         9POkCw3mehdXdvFBD0jEVE8/NGBzFDSpmYegko7wwHJr/TF7TI3rIlggv+zEM9MrGskS
         RoYVff4lOrl12bV/rrSMLqUkTsWubNdnMdOrJQbehpBGeUDiu28U14/QYkBYj/Cg8iu4
         4LulUZOfRKtixrg/T6wEJJPZ4vxskM58leoAVPnZkr3tHpoAYM7ku8eiXjoPmgu0mCi9
         LKhw==
X-Forwarded-Encrypted: i=1; AFNElJ/IftXtuoykcJIv0ovePEclHj1id2TCwCEM6rOzgnEOVkTteCnwGHIQIWPmN28OC6SZdho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNPAp0V4aoOtgmouzL3eCfzhwAOcV3nhF/3oaaKj2dwtTRNnNt
	8DsNadoVd55M8T4aV1E0bWeFhR1YONwsN8akGbTzM7Bz8vTo+f6T8rAN++DTQiB/WxMVPWU3xr1
	2QG+wfw==
X-Received: from pfaz15.prod.google.com ([2002:aa7:91cf:0:b0:82f:7bc:70a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a106:b0:398:a934:9be6
 with SMTP id adf61e73a8af0-3aa5aa816bdmr5634887637.43.1778101925715; Wed, 06
 May 2026 14:12:05 -0700 (PDT)
Date: Wed, 6 May 2026 14:12:04 -0700
In-Reply-To: <20260506185510.2723091-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506185510.2723091-1-seanjc@google.com>
Message-ID: <afuupCOAeaO9A9y7@google.com>
Subject: Re: [PATCH] KVM: x86: Swap the dst and src operand for MOVNTDQA
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josh Eads <josheads@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 06, 2026, Sean Christopherson wrote:
> Swap the MOVNTDQA operands, as MOVNTDQA does NOT in fact have "the same
> characteristics as 0F E7 (MOVNTDQ)"; MOVNTDQA loads from memory and stores
> to registers, while MOVNTDQ loads from registers and stores to memory.
> 
> Per the SDM:
> 
>  MOVNTDQ - Move packed integer values in xmm1 to m128 using non-temporal
>            hint.
> 
>  MOVNTDQA - Move double quadword from m128 to xmm1 using non-temporal hint
>             if WC memory type.
> 
> Reported-by: Josh Eads <josheads@google.com>
> Fixes: c57d9bafbd0b ("KVM: x86: Add support for emulating MOVNTDQA")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> I have updates to the xsave KUT test to verify the bug and the fix.
> 
>  arch/x86/kvm/emulate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c8c6cc0406d6..0bb832a76868 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -4450,7 +4450,7 @@ static const struct opcode twobyte_table[256] = {
>  	/* 0xD0 - 0xDF */
>  	N, N, N, N, N, N, N, N, N, N, N, N, N, N, N, N,
>  	/* 0xE0 - 0xEF */
> -	N, N, N, N, N, N, N, GP(SrcReg | DstMem | ModRM | Mov, &pfx_0f_e7_0f_38_2a),
> +	N, N, N, N, N, N, N, GP(SrcMem | DstReg | ModRM | Mov, &pfx_0f_e7_0f_38_2a),

Aaaaand Josh pointed out that I wasn't paying attention and stomped all over MOVNTDQ.
I'll figure out why my KUT changes didn't detect this, and send a v2.

>  	N, N, N, N, N, N, N, N,
>  	/* 0xF0 - 0xFF */
>  	N, N, N, N, N, N, N, N, N, N, N, N, N, N, N, N
> @@ -4481,7 +4481,7 @@ static const struct opcode opcode_map_0f_38[256] = {
>  	X16(N), X16(N),
>  	/* 0x20 - 0x2f */
>  	X8(N),
> -	X2(N), GP(SrcReg | DstMem | ModRM | Mov | Aligned, &pfx_0f_e7_0f_38_2a), N, N, N, N, N,
> +	X2(N), GP(SrcMem | DstReg | ModRM | Mov | Aligned, &pfx_0f_e7_0f_38_2a), N, N, N, N, N,
>  	/* 0x30 - 0x7f */
>  	X16(N), X16(N), X16(N), X16(N), X16(N),
>  	/* 0x80 - 0xef */
> 
> base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
