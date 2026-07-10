Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597811CA9
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643383; cv=pass; b=c7knOir2H+xbTdtXXix9GHlI8s9VdptG6q5BZaACxNjGIklYMCBQEKfbvrux5uh7wyChVsjLi44XdHUkGcjuNi8/Pzby7ur5aRKEswHf98i01Iv1QmGMNyBmfCl+C0zU2wWjl9M8ltqQyVYO22shpCcN7BFpZodN/u+XtpMlU6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643383; c=relaxed/simple;
	bh=BBOxaPmM/01vv+CsTj8a2UQ6N2oadeCRstpSSslF1gs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/CWGoNBGXMzkH+o9MESMYKS5l63Pp9oqHdZ7FtRowfWyLz0rDIYFxbIgndp1ABdT/RAi+x1/dWQR40qXynJxDwULI6aHbYq7PeoiI2AjEjBz+TdsWIL+6ocYXxkP8NJm6PhstivlAbd04aoEbnrPzWxyK6zYv15CyNvpzDP0X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLTWQZsk; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLTWQZsk"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84861fc51f5so234623b3a.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 17:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783643382; cv=none;
        d=google.com; s=arc-20260327;
        b=JuQwm3+lNAVpQ5lsF8UW0BD7z24GSKES7M5MZJ1CkWe6RTaWl+x8mNU7l6af1NM5hB
         qnnfcsTapkBW1fShDTJORF8vaXk3TZqL3U2JJi0ks8E4VEk029yPXmDDqHgffbhUu/vv
         ZLmBFEEL/9ssvyKvISujQKc/viPVGd5g+wXrzYv5qF9EhUmH1mitm3rlPJlAMK4M1Hdk
         EjiXjL2KmfpU1HzJo82HUc4bJr5ssCKdY8MnPC2rdpOEKVauq9nblYlrY5n3ekqa0WaN
         QSv8Ab75cXbvWh84CtKg+lhL+0meLeDmWHg+VZW8a/OMb4vL/G+furgA5YZhF3qW1g2a
         AxHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6eKQoPNuaY1tGYHzSoxY+PT5XlE0M22tyAx+QiEVcTE=;
        fh=n/xVjRsPLSx48DK0mlLV8S98n4Bay9rv1xBpMnS6M6Y=;
        b=VfZHuPAj/XAjuVZFcw/YkwVsa+EW65HhQO7c56JAOLwSZju7+K9b9ZVVzgSe9txDbQ
         2xpEpmuX48Js3cbaP3KUFom/OC2lMOc0Pe0BO2x9HOJ0vwcXgkmmYq2pe0DyCyF1DPr0
         ltU41yncjP48nQuwzMDX0d/Gqo8dY0oDehqtWX3F+ODdQ+8xeofmsXLBOxeSEN+m0d/K
         AXIibDlySCV7tVF2eI6QF5L+Q4as6b/u1BTtyvxPgpNTrLgLKOb5Ja0ceWEu5S/Anq1u
         yi9hP3tdFkRghEN+wZQqozBx+mtGNSpBSYHeqwU5DdnGpzz0DJxucU3+r/01XURUWlvF
         +mpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783643382; x=1784248182; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6eKQoPNuaY1tGYHzSoxY+PT5XlE0M22tyAx+QiEVcTE=;
        b=eLTWQZskDaYXR55LnSO+gckyr+hYwlrMbcHB0CTxJxUkSuAzL1J+OEaYeuLlF+K4DV
         FHZRuQdldpK5dbJqizfQVkcOIepGoGjUS/KdTj9rTFTgGJ9ix6V81imdbGYpx+ZbPQuf
         6u+NNOEedTUw3uyLcW8bSms+TcrZHhxDdfJOlKrvA1rhLgaOlvFTa5+0qCYFvZGJgg/V
         /yWQomfXBGvAdPk+p5nAPQArWEhube5VQKXCW3ybOjtODK0RlCb7THlElOY+4wx3Z6w+
         VQGYqzCJBsRkWm7j395mmQxG209o7jHctFKmtp5AmOpxL22qZPGOhg+Ok5g2VKuZQv9G
         JVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783643382; x=1784248182;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6eKQoPNuaY1tGYHzSoxY+PT5XlE0M22tyAx+QiEVcTE=;
        b=YojSvJvtlI+FFDnqMiDsHKysgWRbkYfyNJ7qOknoYezV0TfQWJt2anr8EnRShosSlL
         nesj0D3dekj/85pzVHymdlunOYOWmqPYEEv9mW5dt4Ru9wJhGaD1ekJcYoxo4HX7jxnp
         S3QMqm2Y4LOYwDj/CyyZOvugqmtD/y14QPVDKzRFAnwsP+dqMN7A+OBL0ZkJRRXhNGWj
         383LkzRtIcCLt4TUVXuJBcHq7aN8emjev+74YhK+2iVoA7Lld59sXeTorK6/XNCy0/Gk
         mWP5c8Hdn6HYxQd8Knt1HW8AVcn8lZ11ijv16qz3LIFgiRnnmT1Eixe1GHq2lY52byaN
         oG4w==
X-Gm-Message-State: AOJu0Ywc1VxB3u4EHgA6Kk10jHAeMaJa/CMWAVOIX6Caeuj+N7W+fbDC
	dogr1JSgZaVp2U0sQ+TchcWqOdMRV2ePMT+QpzXlcGGUoRG5Do7+DW2KZaNP5gWGgSorI0WxD1A
	fgnN2VN4NWz3NNiRrpTH4z7TjoJx4+kNw4zvQwZAE
X-Gm-Gg: AfdE7cm2dVy+BHSGm963M1onYEqBX4CEkuPiuuJZpbUHcxP+Rn26lzX5TC8jUIaPmHl
	G1knrqE9LK8CPrIi+9xndlxV1s83h3/C3oIeFck82uy3PutQirqV5xNwdwTKuXsADxmdXLCoeur
	cEzC29pQqI7a3JYacYj2UdVwCewdouPTeGnj1WlucdGyB/6nSqsUS3eQUIA3ZEwOKBzGQHurnx3
	GiU2FG17nazXIQ+mAk7JPtcHiCVv+/Xw+aZXRG4+URrse/v6JZt+F9cbdW5MllJdTCQH/BJrmBF
	dhbJkIRrgqCwrVqFY4XzA8HusBtNJOKg/zIp8xRS3PPp86709n1cqXBmONzmN5QUwIOUFQ==
X-Received: by 2002:a05:6a21:39a:b0:3bf:9abb:a8be with SMTP id
 adf61e73a8af0-3c0bd0f9e0cmr11588986637.41.1783643381236; Thu, 09 Jul 2026
 17:29:41 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 17:29:40 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 17:29:40 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260709211523.8BE3F1F000E9@smtp.kernel.org>
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-18-seanjc@google.com>
 <20260709211523.8BE3F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Jul 2026 17:29:40 -0700
X-Gm-Features: AVVi8CeC7912GNUZ12uLBsKZMA9Jkkk0PAaOu948lFfSF_ZlWtbKRgZ3tNU-gS4
Message-ID: <CAEvNRgEyefHztOrhpzZ9cPjr_Rc1XkfXE7ak_WX2P_=t_JZJSg@mail.gmail.com>
Subject: Re: [PATCH v4 17/18] KVM: guest_memfd: Align the gfn as well as the
 pfn when "preparing" a folio
To: sashiko-reviews@lists.linux.dev, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [Medium] Aligning GFN down without validating memslot boundaries introduces host out-of-bounds physical memory access when preparing huge folios.
>
> Pre-existing issues:
> - [Critical] Concurrent execution of KVM_GMEM_POPULATE and vCPU page faults allows unprivileged userspace to trigger host hardware crashes and guest data corruption.
> --
>
> --- Patch [17]: [PATCH v4 17/18] KVM: guest_memfd: Align the gfn as well as the pfn when "preparing" a folio ---
> commit 5debe95f8712f79807df583e8d5e927a97b4c012
> Author: Sean Christopherson <seanjc@google.com>
>
> KVM: guest_memfd: Align the gfn as well as the pfn when "preparing" a folio
>
> When preparing a guest_memfd folio, this patch aligns the gfn as well as
> the pfn to preserve the effective gfn+pfn pair. This prevents a mismatch
> set and unintentional guest crashes due to assigning the pfn at the wrong
> gfn for huge folios.
>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index cd7a795834cb6..4082cde3f3fca 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -87,8 +87,8 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  	 * checked when creating memslots.
>>  	 */
>>  	WARN_ON_ONCE(!IS_ALIGNED(slot->gmem.pgoff, nr_pages));
>> +	gfn = ALIGN_DOWN(gfn, nr_pages);
>>  	index = kvm_gmem_get_index(slot, gfn);
>> -	index = ALIGN_DOWN(index, nr_pages);
>
> [Severity: Medium]
> If a userspace caller creates a guest_memfd memslot with a base_gfn that is
> not aligned to the huge folio size, will computing the index from the aligned
> gfn result in a misaligned index?
>
> When passed to kvm_arch_gmem_prepare(), couldn't this cause the iteration
> to go past the end of the huge folio, resulting in an out-of-bounds host
> physical memory access?
>

This sounds like it would be a problem. We could perhaps leave this
until huge pages are supported?

> [Severity: Critical]
> This is a pre-existing issue, but I noticed a potential race condition
> between KVM_GMEM_POPULATE and vCPU page faults in this same file.
>

We're good, vCPU page faults can't happen until the VM is finalized,
populate must be done before finalizing.

>
> [...snip...]
>
