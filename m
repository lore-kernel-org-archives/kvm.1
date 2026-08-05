Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCE375F65
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948736; cv=none; b=aikU00WfVDtNGdItCrpjyKDWtG4eul0HfW+kA6RSQp2EZElMf8cvM5laMVRklYY8xrP5C77x30yjxVpAb75iAcTGJ19klF2HfUCp5ijZdUjBnMGeDfAxQKLrlZ/ONWtYCU/JAdf3SHBLwnj7L+wbOm+KJClRnx2da2PCj20jorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948736; c=relaxed/simple;
	bh=pmjp1fyQk8GtgiG5KTih78HTvnIKMpL2AU2Lt+zdXv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OU5+EqTTtpoyHdFmo77stKvrHEiUy2qm92Gs+M7D2+W9udbemOAycu0LTLjGj70zGm8PSY0f9ezBQ4nalmPWxc3dzJtvw1bwqGjCzXwtdFOkxo4veG920z4MOYmGC1jBYV/PXondV6MAQa7RpdupYA0xP/ofxnRVCsKnHl8qQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpD14nZG; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpD14nZG"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84865f326efso1500501b3a.0
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785948735; x=1786553535; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o2GGvdkYnkkMqly/LuwEFC1oKwFLrXMppSjIDsjal6o=;
        b=OpD14nZG+PzulF2fGrrjs3NmN1PQtZXq3A1eXIx9OBpDONrzKXGN0TeeziYRaoFD/9
         7xz87SkJ161DUWWu7fptDsHxmIQx0Z5vROzU33+HtRZn+zcMAYarPiVR6R53MMNVEBtl
         m21WMtfW4PvZ5xvZ70L4zTQSdDQykxtaJbTtoAgI7JZ+Ak5jHs7+Bn7m4+qlIm8h9QBl
         bzMgJDpFUJFZRwrAvUxgezNf6sStrPRfvF1Df2snSvzNh0UFgjR/2EWP26F3PnXfS6us
         DSSwqJAkEUSfbesp7A4K/hT6i8PH/o74GOYPFH5E5iDrkdwpk2nXlfJiYHq+GXMF26dV
         +Mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785948735; x=1786553535;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o2GGvdkYnkkMqly/LuwEFC1oKwFLrXMppSjIDsjal6o=;
        b=a8/Y4qP3K8ctsK5bAdVkOYPFabEf3xLP1zsj3cB3GiqbSekL74UqKDq7seeSlCXV3z
         dNVQxdllzVp9QkqP5ynceUIdj5btedAOSIK0hv0XHA570sLx4ilQFalW32f/KBHaIUgB
         lrOWu4HvkLwwl9UUcpbnYxh24eu2P0++OdBDm1/thC+iThyOz8Q/j/4qjCSkr48yTWnx
         /WZ0+g4eISa5j5lZkM6ia2COpH6BhdHmTuljXcwD4XdDfGwkd5Zp6XEYQA0jhAdxxIKo
         2t/xaTFPOymef062RqTLFbszHyt9UNZss27VBC7nAgvJyiuhDj7nxGI0gX2WLjDLynEo
         7Aiw==
X-Gm-Message-State: AOJu0YxDWvtpN7JCn7ZKLCc/3zOhU7TNT4Jy41JSvsO7clafchpo1PPr
	dpTcb2W+OF0cl1S2iadMAIuQo86rBxXPRnzrGap5dFXVlnyIssJ1R9SPLyVqzuSiGNlEhRGaEy3
	/d3K8Fg==
X-Received: from pgnd13.prod.google.com ([2002:a63:734d:0:b0:cbb:5dd3:9904])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2c9:b0:848:498b:e0d4
 with SMTP id d2e1a72fcca58-84f2e12ce9fmr9433773b3a.38.1785948734635; Wed, 05
 Aug 2026 09:52:14 -0700 (PDT)
Date: Wed,  5 Aug 2026 09:46:13 -0700
In-Reply-To: <20260731171926.2629627-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731171926.2629627-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <178594834697.3639604.11123768104931379395.b4-ty@google.com>
Subject: Re: [PATCH v7 0/2] KVM: VMX: Workaround VMX preemption timer erratum
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 31 Jul 2026 10:19:24 -0700, Sean Christopherson wrote:
> Due to a widespread Intel erratum (e.g. EMR158), programming the VMX
> preemption timer with certain large values may cause the timer to expire
> earlier than expected. The recommended workaround is to cap the timer value
> to strictly less than 2^25 * CPUID.15H:EBX[31:0] / CPUID.15H:EAX[31:0].
> 
> v7:
>  - Ensure the timer doesn't exceed the architectural max. [Sashiko]
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/2] KVM: VMX: Bury all of the VMX preemption timer code under CONFIG_X86_64=y
      https://github.com/kvm-x86/linux/commit/d0dea3ed847c
[2/2] KVM: VMX: Cap VMX preemption timer to work around Intel erratum
      https://github.com/kvm-x86/linux/commit/0aaedada606a

--
https://github.com/kvm-x86/linux/tree/next
