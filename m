Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D43233149
	for <kvm@vger.kernel.org>; Fri, 13 Jun 2025 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749823090; cv=none; b=FV4MF2OfJptkLRk0dU+KN6CcuVbV+k9RLfwISMCvzfq7qMUDHAT2ZFVo1pvrfsEeg2RfFK4f4ytOkc5qhiVlAw91HabFdpsrVKwZ6KF9UrFSUWb6HxVk+oduLZWCs4xbreAPJ0O7klKCzILaZhsAamOB5c/GuGTmdZWaPbvnyGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749823090; c=relaxed/simple;
	bh=5bMCUhx2FJDvCL3dmyeWzgVODh/Wh2Gp5mOcFXa8+No=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=btROPPiwWmcc9/70Tj8lgMPMyy+H/P6/Ri9fQLiwZ4N4XOHzrhiL2Z0rlgoHSWtrwlFuKBBp9aW7RMAKnhWBTJv6+bKp6hdSa8HH+cSwu+6cRlgPqqyeqYjmevIzL2to/PDma2RYOQAKZrzg24Fv3gPZcdWFDIMNlDtLoheEnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=snR3cfTR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="snR3cfTR"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74877ac9ca7so1764190b3a.1
        for <kvm@vger.kernel.org>; Fri, 13 Jun 2025 06:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749823088; x=1750427888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cw34bWGdNs6U3Zmr/YWwfuHV5hoEENlr6dqR1JyEE6w=;
        b=snR3cfTRcs1a7ysEURvNkUhJcxG8t7ST8f2CkEDruMUeo7yMQS6yXrg0eCBhRo8foD
         t88eKxPnVrPr/D0bkdfWDCI4eGU9eGQ8vkjuDhxHIeiDH3GNjfHkrv2zJpZHBvLqM2rC
         EpdaLlZM8AEXhyvOFPCTmkHezBoQ7WmnQJFO9ueZkL7gQFo3TBOx1uuiOjMFfXra0+1j
         MNXlm6vCUW4ms5fO3sU9tZ28exjh0y95nGrJM6SXIQfsvcCP7Dk4GEMZqQysL1OX53nE
         aHIAuW0WulZhJlXZuuU9YSNGg5PK77AYkkjfHVibIj3oaPkpHr7xK2ziJjzaeOxuepuy
         Fevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749823088; x=1750427888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cw34bWGdNs6U3Zmr/YWwfuHV5hoEENlr6dqR1JyEE6w=;
        b=HzLHmGRLwe/knp6YIBzRuRmPkatMaM/rZs6jWBPKINyDxlhWziuMctUexQ8T2zuLgL
         jV6ogC7NzP7zGJkpXShyz0Zwu9LFQKrME7KbBlDNHKBKk+ga8onNjz5lPG+FMnuK6ACa
         +vEV01adQZKOXtJkRKONw7iqg9RGvW+PjKi6WVhkZAbXsB6F7UADZ0OQOfItZi5mhFGQ
         O5EFCFsMn2Yk5SZetfPOh/PK7TqCc3OgFxcgCBqKsFfvw79qVaV2WyiZ52XIwGDv/Dzj
         Ws2u9XqvuH7+xII6sNt/nYk7fyyLXKhe7eSD9naWLFloW4PKeHIu6EZzVPW/1Ewemaeh
         lxZQ==
X-Gm-Message-State: AOJu0YxQolF+N+++FWh7fXxEJG8K8MNRxPpVF0bLl++8CNLy3kbEn+t+
	m88U+x05EvjX9sFXEj61Ir28xHJQP2B6AZuwnqoroC9ooRQhUN/c8ba0vsXL6jjm6A063OxXVR9
	UcGj6kw==
X-Google-Smtp-Source: AGHT+IEcfXkTGRbkHRYdyT8D30MoPwDEoq+7AlXGLoG8amQXdRCwWKDLujzKvgNaM96tWefKmXgidNIDqIg=
X-Received: from pgbfe14.prod.google.com ([2002:a05:6a02:288e:b0:b2f:a20d:7451])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a42:b0:21a:cc71:2894
 with SMTP id adf61e73a8af0-21fb95d7e05mr1060858637.17.1749823088565; Fri, 13
 Jun 2025 06:58:08 -0700 (PDT)
Date: Fri, 13 Jun 2025 06:58:02 -0700
In-Reply-To: <20250613111023.786265-1-abinashsinghlalotra@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613111023.786265-1-abinashsinghlalotra@gmail.com>
Message-ID: <aEwualvoLvbtbqef@google.com>
Subject: Re: [RFC PATCH] KVM: x86: Dynamically allocate bitmap to fix
 -Wframe-larger-than error
From: Sean Christopherson <seanjc@google.com>
To: avinashlalotra <abinashlalotra@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, vkuznets@redhat.com, 
	pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	avinashlalotra <abinashsinghlalotra@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 13, 2025, avinashlalotra wrote:
> Building the kernel with LLVM fails due to
> a stack frame size overflow in `kvm_hv_flush_tlb()`:
> 
>     arch/x86/kvm/hyperv.c:2001:12: error: stack frame size (1336) exceeds limit (1024) in 'kvm_hv_flush_tlb' [-Werror,-Wframe-larger-than]
> 
> The issue is caused by a large bitmap allocated on the stack. To resolve
> this, dynamically allocate the bitmap using `bitmap_zalloc()` and free it with
> `bitmap_free()` after use. This reduces the function's stack usage and avoids
> the compiler error when `-Werror` is set.

Can you provide your full .config?  It's not at all difficult to get this function
(and others) to exceed the frame size with various sanitizers and/or deubg options
enabled, which is why KVM_WERROR depends on EXPERT=y or KASAN=n.

  config KVM_WERROR
	bool "Compile KVM with -Werror"
	# Disallow KVM's -Werror if KASAN is enabled, e.g. to guard against
	# randomized configs from selecting KVM_WERROR=y, which doesn't play
	# nice with KASAN.  KASAN builds generates warnings for the default
	# FRAME_WARN, i.e. KVM_WERROR=y with KASAN=y requires special tuning.
	# Building KVM with -Werror and KASAN is still doable via enabling
	# the kernel-wide WERROR=y.
	depends on KVM && ((EXPERT && !KASAN) || WERROR)

And also why kernel/configs/debug.config bumps the size to 2048.

	CONFIG_FRAME_WARN=2048

> Please provide me feedback about this patch . There were more warnings like
> that, So If this is the correct way to fic such issues then I will submit
> patches for them.

As above, this may just be a "bad" .config.  
