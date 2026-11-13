Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577725;
	b=LLpLrdx7P6KpMvEAaEqyPvLVSo8w48urOKuCvGogYdJaGKhYYR+rc+dSYjKoYZaoC47Z
	 NLHjCpt1eWtMzxWFr3hH5orb9+Y+vUEq72q41CgXKTuAbNJs3/iAzDTAioUqoLK6SJ7S9
	 xNYlP+fJYKoChnhOkoCPpedN19LyNrcMedC1T/AZlXPsu3Tu2+UCfOptRpWXMS2SX5kmk
	 hb7Be5JmZ/N+MPzM2GS8tuiqZNGvBEOKP1H9Y3q1qzyO2Bj6Lgrn4GlJ5MvZbmrVB+XQm
	 +62wrlSIZpk/wOaopximsxcLQcimUZl9s1eSR0yKkmCWtVYk7tIpKVxGu/mXroegfPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=AP0XwMHx6rTXkwguG+yt2WQaymwZ4K34wFaqNUKI46o=;
	b=EHXgLGiVJR0/DoxIiUxoJxAV77Uo3kR5P2DcauinEhaRqyF9m2CpV2Yp0Jx9O0OyNsCZ
	 Z0r6jaaGI1g7848HrG3S0dgU0XOagLCEk5z9bP7LBFjweh9YZpucn1As395On3oxCMat2
	 Yd01fFUQ28rsMGmTe61WjOCwMe/22JjpqRdYPKheZ+GOdrmcGmZBxxuh6PjlXyRdEUZCR
	 QE5AxEXmqcjlZVZ8AMT8Rd8D+CskuMJa+KsFXWEUQqLhsZQCcvP74x/23PXvH1yNtiaDZ
	 pypErV37lrnY7aaAQAtozVK8ge15jNdXW69a3L2+/T87I649tAEASsV77L8sAfK95xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TbePuknP;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B802606A339
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B802606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TbePuknP
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea446ea8c9so15380405ad.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577724; x=1795182524; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AP0XwMHx6rTXkwguG+yt2WQaymwZ4K34wFaqNUKI46o=;
        b=TbePuknPBXYHo+RZyb/1rCrfdAXXS6fpsm+ap+/pFdXQrYWrKDjOsBssrYbBLufTmg
         lY+BCIW//rftv7ucWnLXH+MfskNv7DTsgpCfyc78TiJHdaWwKJujZI8zt1SxpPhR10zx
         sKfIZK+8W1eQadSE6tD2pXNkfNomuxkniO+86Qd/pHeD9WQUWih387qiqZzRmsdj3rH0
         wIrfejzUlGyBGpACqoxDJ7lcYqUk2Nveiqg39x/xGE1X9Uuo1wR3Gw4U6u4A2IPNasre
         n5NO6A7AT3pcaXVNjYPaXc64OZUI9N2x821Raep6f8ZJ/hXt+/VDq2KLJgfMaiYO7zOu
         e5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577724; x=1795182524;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AP0XwMHx6rTXkwguG+yt2WQaymwZ4K34wFaqNUKI46o=;
        b=WUYfnW8CeR6BwUXlA/UoT7s2nFO1vcQEGW34sWOMAIcrsKXhr8Pfp4W6P/F218Y/n5
         XzCYdOhO1KBmvKnAJ6s74QLNpzDZxYHvJQZQH+icJ0NkQblPvaJ5OL0YlG1KYjxFQYu6
         Qx7WNLcSFM1f75PiwAOnkadHW5w1IVziVflcEmHcVHUq15PjkoUPdfJjYkPtfIS3xIGj
         mATO/QASiSCeG/dSRNm0SMA5SBZtIXdzKGQX2XAqqPVoLAculjY5i7SrtnP1jsWmZEmQ
         rfOSYMrANrDKvE/H6joadu377/FAgdKg5sY1sPqNChxL+bPWgZU/mrgwSQrBFCzM/6EV
         L4Dw==
X-Forwarded-Encrypted: i=1; AL+hErE2oRUHQnzBgdCr70f/uR7IfD+xaZNrRbobYWu80Whvcvw38zar2/dRARW2chmiHuWQvMo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9U0SsnrS9VL3nA3OhQjmiRqrxn6OryLubREYmFL5SKvPecineK
	zi4LZqdkUE2iXRkC8631ZU3+El5GPi4d4heqRCQwpLUzBCmDT2ivURhlFGzvO+TDlp1JCiVc6Y/
	nWUszTQ==
X-Received: from pjbcp15.prod.google.com ([2002:a17:90a:fb8f:b0:3b0:a4e8:cfb8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3912:b0:3b0:a7b5:c044
 with SMTP id 98e67ed59e1d1-3b1b087b35bmr1488456a91.1.1794577724117; Fri, 13
 Nov 2026 05:48:44 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:28 -0800
In-Reply-To: <tencent_6EE8901CBE1ED363CBBA2E8CEC6D88D19F09@qq.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <tencent_6EE8901CBE1ED363CBBA2E8CEC6D88D19F09@qq.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441794610.77862.7904519184101802738.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: coalesced_mmio: reject zone sizes that don't fit
 in an int
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Hang Nan <2122295973@qq.com>
Cc: Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 28 Oct 2026 09:59:56 +0800, Hang Nan wrote:
> kvm_vm_ioctl_register_coalesced_mmio() validates @zone->pio but not
> @zone->size.  The u32 size is handed to kvm_io_bus_register_dev() as an
> "int len", so any size >= 0x80000000 silently becomes negative.
> 
> coalesced_mmio_in_range() bails out immediately for len < 0, so such a
> zone never matches its own range:
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/1] KVM: coalesced_mmio: reject zone sizes that don't fit in an int
      https://github.com/kvm-x86/linux/commit/9afe49408a4e

--
https://github.com/kvm-x86/linux/tree/next
