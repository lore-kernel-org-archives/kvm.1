Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C816D401A22
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511415; cv=none; b=DtZa9jepXr04pyBvI7ddORdnpOaudsC3sxnb+ZxOXGXMQdMxAmkEBN9kSGe+pPJTaCJLVAaYC6KCUYOHdjHM5O6u4NjWtxZjYQDGeilPymcy703oVajw4IIq592wYhLIR+74JUJTKx3x1zxb27/KGwxAGBhjnjQ01yQB3+v7oro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511415; c=relaxed/simple;
	bh=6QbD0KdntPAOBlp1gqVVbVIOh04vCqIv+AyBkim+7D4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SmCZAKrpQ/mT7O5kxuHm+3SLGnMSPIWyDUL+jW6yhmjv7erU9rCrGd229DTwgartYym5YoL1c+KaZSSkesxKFvK6/Bx6Iqd5nRtGAmtzD8bUDWNqorcA54bvc9rUR+SK2UrE2mj4pBo3VrO1g8CcCHYSTAvt1Jk4jkh51M3otQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bNnriXHm; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bNnriXHm"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83836443305so2475836b3a.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778511412; x=1779116212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hc/tHvBAZ7rfi0mrKl6+ves4TiRX7s2hRGBIVlRocHM=;
        b=bNnriXHm3kcMLzlnR15I119XoAN8X80LyNWSunqM6roS6NWYZxQyzEesOAEc/u/VRx
         jvdU09DIkkgodg04tWeeKw1u6s0t4x/CO+bTo9Xc+V8nnpYKzL8/Pyf8Ps36FNu0+pke
         uLIWQRhVKnQpwmxAqD4JmoKpyOaUOUQcjizxMS4KHCPPbScO3e6hZiXDB3TFOK4zqRBh
         AB9C6A9LpiNGzFg8bdrdM8K1PNaXBkthnNnFxF93vBXvhn8MPlDmVHX8L2DZDwrV1Rmi
         FlJqUAwrAMkCdVo41iEz4ubTN2KCDKZyx3pL3M+vt+5b8tC+O9QuY7d45zqc7uXoK6NB
         DmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511412; x=1779116212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hc/tHvBAZ7rfi0mrKl6+ves4TiRX7s2hRGBIVlRocHM=;
        b=ZF0nPLr3gwqTw7uenqDYtlZrAd+PY6naUmRda+FAZPtohQ3sBOpYStMPLuez5UJpl/
         wor73Y1Yvx7+aP421xbUvLajCMfoCeMNbKIRF+XZP0a+X2rLnK8lc4VlqgmGeVepD2pD
         tbA0XqH5oThBpUUaNUZWlXAu1gkEwN5+bCq7zviW0ORcubz3WZKlANr/JygBvrQfq297
         KdquB6bc3naiJpEnG/zJL+Q30o/EjI1sgR/FyfhtFG4eeGmr2seUFQUuHOJBeTpebxvG
         1AxcI8ULUL+yesbgUpD7RDMcZok8ifHsMzDmsLxTDdp3nzQ40gukN1AteF9wtVkFRzrj
         Z0zA==
X-Forwarded-Encrypted: i=1; AFNElJ/7Ag6UAlw+O4qJrVXLhKTD7yra0oEvYeJ5ei9ExbgaTP0nw2p7d/SoQ7XdOkLi21bG6wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKSeRl/nQMaMiQrSUTwwQXLH10BGxCO3QEzayS1KOe0YQSSd9C
	HudF+uHG8pyDynnyxUxXrCNHaZWZJXXWqINEqz52iCR7AKhhZGA07vXCKWDv9zLIrtSIHGZon6q
	ZMJZumQ==
X-Received: from pfnn24.prod.google.com ([2002:a05:6a00:2b98:b0:835:4568:a5a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:994:b0:82d:29f:d003
 with SMTP id d2e1a72fcca58-83a5b6d2051mr24008046b3a.12.1778511411573; Mon, 11
 May 2026 07:56:51 -0700 (PDT)
Date: Mon, 11 May 2026 07:56:50 -0700
In-Reply-To: <20260511143426.1242013-1-piotr.zarycki@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511143426.1242013-1-piotr.zarycki@gmail.com>
Message-ID: <agHuMh96_kDr3ENG@google.com>
Subject: Re: [PATCH] KVM: selftests: sync_regs_test: use KVM_SYNC_X86_VALID_FIELDS
From: Sean Christopherson <seanjc@google.com>
To: Piotr Zarycki <piotr.zarycki@gmail.com>
Cc: pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 11, 2026, Piotr Zarycki wrote:
> Use KVM_SYNC_X86_VALID_FIELDS instead of open-coding the same three
> flags, ensuring the test stays in sync with any future additions.
> 
> Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
> ---
>  tools/testing/selftests/kvm/x86/sync_regs_test.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86/sync_regs_test.c b/tools/testing/selftests/kvm/x86/sync_regs_test.c
> index e0c52321f87c..8f9239f9d357 100644
> --- a/tools/testing/selftests/kvm/x86/sync_regs_test.c
> +++ b/tools/testing/selftests/kvm/x86/sync_regs_test.c
> @@ -79,7 +79,7 @@ static void compare_vcpu_events(struct kvm_vcpu_events *left,
>  {
>  }
>  
> -#define TEST_SYNC_FIELDS   (KVM_SYNC_X86_REGS|KVM_SYNC_X86_SREGS|KVM_SYNC_X86_EVENTS)
> +#define TEST_SYNC_FIELDS   KVM_SYNC_X86_VALID_FIELDS

Explicitly defining the set of fields to test is very deliberate.  (a) we want
to detect ABI breakage, e.g. if KVM removes a valid field.  (b) if a field is
added in the future, the test likely needs to be updated, i.e. would break if
KVM extends KVM_SYNC_X86_VALID_FIELDS.  (c) KVM_SYNC_X86_VALID_FIELDS probably
shouldn't be defined in a uapi header; for all intents and purposes it's a KVM-
internal details.

>  #define INVALID_SYNC_FIELD 0x80000000
>  
>  /*
> @@ -255,7 +255,6 @@ KVM_ONE_VCPU_TEST(sync_regs_test, req_and_verify_all_valid, guest_code)
>  	struct kvm_regs regs;
>  
>  	/* Request and verify all valid register sets. */
> -	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
>  	run->kvm_valid_regs = TEST_SYNC_FIELDS;
>  	vcpu_run(vcpu);
>  	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> -- 
> 2.54.0
> 
