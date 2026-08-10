Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F33AF66E
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370861; cv=none; b=B+vn20I2njDej+yaHHsYwB1st9C55OXGqrb7PyivJJthjaMJEYvIlUta015kIU76YMbuayAtQJg+DseSGIuRjNKmY62Z+skwEJJp0JKtvHM2o5CF5KNUn/KnURd5odj+lLrNZIdf2ufeQvmxO39/3xPP4llrfzYaB1RwYs1caeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370861; c=relaxed/simple;
	bh=t1Txx5sP5rjbtyEZIqhukkWiABdroyLY9ierQdCxkwA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ntTmyynFvousvxSjyYU7RCRk+yJAITa1iRzDpu8eLd8bnBUXqo/VRftbuEM9aYL7Y/ft3bQhr8S9pHtSC9hQwZsmTcrJRGw2eIbhzCmRw57d04evqVaVQQn8W8LSFvymPF+z9Lo8Gba3H5biEJSTplkEBh5euXnbgovrxwRbHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUwo/+8Q; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUwo/+8Q"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so2550945a12.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786370859; x=1786975659; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PrLr+WVvghUQuf/OY4c2fRyfsehtJvAKrMA4WcW1Fx0=;
        b=mUwo/+8QisQlpL4de6IZQGN8Z02Xxq4r7YMT6eoek9j3bIAqs6qp2o6ScGrOKZ2FzX
         CfopVw2yn1pb7bfR37oqda61gJxOpgInubmO6ecABf0QUfOpfpdqVSyy2yoz2B2n5yul
         g85hBLm5ynYX0ETVfnppMrIzFoAcKN68DjXRMGVHlkrudkaliAlyCtKjZ9V1dIT965SJ
         uk/i091dQmNJy8j4vS/z/PGQJTxhYIWm9AsBh053SIXtkJ8Yf02K43nRY/Kov3v1RQ+G
         mfZt0FAbj7SgdeUl/TC3pZy9tDcpdU2/AGFh9jt7Ohp/L4n+86XXBtZZiAGBJT6jfrTz
         Vu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786370859; x=1786975659;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PrLr+WVvghUQuf/OY4c2fRyfsehtJvAKrMA4WcW1Fx0=;
        b=luhkOsts2CJ1ejmLARHE+viMtOUpNAl+2exCf1KBD1CmYbeHI77H0Yu5Z3DdnVyffP
         JFXLJS4yjMWwTXJoMD9aO2VwpVHQ/N+G0lCp9FDfgZephTs/QYHCXWZp1sBJ5TehJuZO
         SZi7AXSXR+ms3IznXeMpShc81Ru8tOEysW49oflf2L3abPp6SkcSR7yuYu1o7L88+GwE
         R5KR8LXTjT7QGfoZuyO+VmW7TxTkcX9bTqYkxok5oPwoyhj0JQvu+Eh+0sGQnLy0Mwbj
         dOzpSWRP/hQMavodByBA+q398ecQuBw3aBJi6jPH79pB90hjDNXrO59pJwOT7gQwFfrY
         zAVg==
X-Forwarded-Encrypted: i=1; AHgh+RrwwqVRV/Wg1Bmsy0yiJL0soNJ7w5tSgc6Q9qVZEIM/wnZi17UyJzMAZh7gLChQjaDK2Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1BiFaavz1mkHiHKQ5xmTdEGGWVe3tRgI9NxtmCOBpLr9v1XjD
	fcaPPu+2WHjJzz4M3yDbqpbBsfAHRHW1aWgINaK9ZXYL20X7Pw37i9DcS5sFokK2qsp0CyzF8cN
	jqsPWBg==
X-Received: from pgv28.prod.google.com ([2002:a63:155c:0:b0:cbe:3002:6608])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:da11:b0:3cb:9a16:b159
 with SMTP id adf61e73a8af0-3cc1a0bc37emr2552599637.6.1786370859292; Mon, 10
 Aug 2026 07:07:39 -0700 (PDT)
Date: Mon, 10 Aug 2026 07:07:38 -0700
In-Reply-To: <20260807071026.195503-1-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807071026.195503-1-gokul02k@gmail.com>
Message-ID: <annbKnNqQvzyn8tp@google.com>
Subject: Re: [PATCH] KVM: selftests: Compare the entire XSAVE buffer in the
 SEV smoke test
From: Sean Christopherson <seanjc@google.com>
To: Gokul K <gokul02k@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 07, 2026, Gokul K wrote:
> compare_xsave() stops at index 4094, so the last byte of the XSAVE state
> is never compared.  Both buffers handed to it are 4096 bytes: the host
> copy is a struct kvm_xsave, whose region[] member is 1024 u32s, and the
> guest copy is the PAGE_SIZE shared page that guest_code_xsave() runs
> XSAVE into.  A VMSA synchronization bug that corrupted only that final
> byte would go unreported and the test would still pass.
> 
> Bound the loop with sizeof(struct kvm_xsave) rather than an open-coded
> length, and make the index unsigned so it does not mix signedness with
> sizeof.
> 
> Fixes: 8c53183dbaa2 ("selftests: kvm: add test for transferring FPU state into VMSA")
> Signed-off-by: Gokul K <gokul02k@gmail.com>
> ---
>  tools/testing/selftests/kvm/x86/sev_smoke_test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> index 6b2cbe2a90b7..c7af27954356 100644
> --- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> @@ -90,9 +90,10 @@ asm("guest_code_xsave:\n"
>  
>  static void compare_xsave(u8 *from_host, u8 *from_guest)
>  {
> -	int i;
> +	unsigned int i;
>  	bool bad = false;
> -	for (i = 0; i < 4095; i++) {

The fix looks right, but this is so bizarrely wrong that I can't help but wonder
if it was somehow intentional.

Paolo?

> +
> +	for (i = 0; i < sizeof(struct kvm_xsave); i++) {
>  		if (from_host[i] != from_guest[i]) {
>  			printf("mismatch at %u | %02hhx %02hhx\n",
>  			       i, from_host[i], from_guest[i]);
> -- 
> 2.54.0
> 
> 
