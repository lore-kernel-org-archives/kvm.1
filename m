Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185252DCF74
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057502; cv=none; b=t82MnbOAQXvZ34MwH5vBtdp4fHfiVPPKxuZafhIy9jI8iPooa9qeRxXkYAH6TrR837E9MZXlQpkLl5x7lFLz0CSYOCfadXNK0t7CWkxrZQOUulZ8kAbSOQRd4YJgE5jqjgljtAd/diNmjObFL2+TIEpdMgc4GxeEbsmZ/g3Nhac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057502; c=relaxed/simple;
	bh=esTqwQ6RUkxH8eHvhLy/0BvQsUNarCQz2xHwlYNhs+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HTEIruQADZUAGxNJ8zOf7nk0TuhcoNNqogJ9u7VTeAbJ2+7MI7Fsqz99+bJrhqXG4T7pJKU10DvZPbqhIVnuS8QIWZakRnPQ71SagimuN/fC4JnUX9NyeXLI6CMMM13dbpxKYYSTfaPkVm2C3+Y2DX9yNghhSUnvzsnNqiccTYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+Ejz7DC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+Ejz7DC"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c856470fe9fso1228651a12.2
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784057500; x=1784662300; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e8llG4Le65PKJz9M7DaALJn7M1/1ycqftlvD5ZJlp84=;
        b=Y+Ejz7DCkf4kyZZvSwSDfNIAc5aN55n3vpLgYzJyMjNeJw8cmo6dqFWBwTeJpBnPqU
         6d5uUIrKgDDfUZolNXIzVHSvoW/nbFtvuczKIoIe7uxWiblNBQ1qMWH9l4sGyjycCg/t
         tkXdWQCfbzMQg6QJUso1SCEofHIcvEVQDGPfVWe58xeovLXycou5jxvBWynW/jYMpnuE
         2U2FPiN3JlRAk5pRC5NcIYo2QT/DdwLcjJfATYunDYLcct7a7Ae3NZcpxldT95TXyH2G
         D9Dn/LyKWkShzZ8+/MY80q2fM+8Bsy4A74b8aaEbWiliJT08W4HI7GPR8HmVsenGfZru
         QwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057500; x=1784662300;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e8llG4Le65PKJz9M7DaALJn7M1/1ycqftlvD5ZJlp84=;
        b=TnLpHy9UOJ3QJOaX0wYL/T/cPHcRykLjKQuYtc23DDH0mXHX8+ZQQJkq4aR1lczPf+
         jJsvzNVnhOKa9OIZsqCgOJZuXYAhZivma0ZerldSrkB1WLzuNs6i0HCx3eWC2KZrsbeg
         O/9A29PRVJmdNq+HGO4cQEXTlPMAbKHU8vgJmkZzhGrQ8EJhrDIo1EOgpihWAD0U934Q
         zdPmbqUA0JG8Mm5+5Kkt/aFVAiHTKAAsBE2+dwt4QPas6EDXk2/LyLZqeedF+grraDYC
         v9boCI6V7j4WMFKmRZAASHj+DuIHPlqO7LAYyA4Q+zj3vnTbmQOf2qlQXRpEWlbY4Kk0
         N1NA==
X-Gm-Message-State: AOJu0Yzmwrj/+LJDVVbaNsEZHpu4hLqiNvc1eqQaDslEgQLEnFucjWGo
	uOVg9tH1O0xC7mcmaXCAZcRgRGHWmjoOV3VuP2+9P8zkW91p/NXRcySyUaUg06AL32beWfOAxVR
	eTnP5Ow==
X-Received: from pgee15.prod.google.com ([2002:a63:1e0f:0:b0:c88:e5cb:265])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1798:b0:3c0:9c1a:8952
 with SMTP id adf61e73a8af0-3c110b35019mr15146889637.74.1784057500271; Tue, 14
 Jul 2026 12:31:40 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:35 -0700
In-Reply-To: <20260707150706.1198541-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707150706.1198541-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405256153.3110605.10912197744078652443.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: selftest: Fix steal time w/ non-glibc builds
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hisam Mehboob <hisamshar@gmail.com>, Aqib Faruqui <aqibaf@amazon.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 07 Jul 2026 08:07:04 -0700, Sean Christopherson wrote:
> Remove unnecessary usage of pthread_attr_setaffinity_np() in the steal time
> test so that it can build against non-glibc libraries, and opportunistically
> expand the test coverage by pinning the test threads to a random pCPU instead
> of hardcoding the pin to pCPU0.
> 
> v2:
>  - Rely on CPU affinity inheritance. [Sashiko]
>  - Add a patch to in to a random CPU instead of CPU0.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/2] KVM: selftests: Drop superfluous use of pthread_attr_setaffinity_np()
      https://github.com/kvm-x86/linux/commit/3f339b70bb59
[2/2] KVM: selftests: Randomize pCPU in steal time test
      https://github.com/kvm-x86/linux/commit/2351e814e1e1

--
https://github.com/kvm-x86/linux/tree/next
