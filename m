Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DFC41E6B3
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057517; cv=none; b=iRkt1uwYhB21kEbplAKeewW/0VQEch4GL13lq0Dr9zfYnD/CkuUPTis/FpWZFpKIrTcCRSKO5YP3P0WKHpki41SpRk5nVsUobRBgorNzpVKBYVzpXwcOTWoGbXVjJyzz4SGaBSEuwBl16k0DF+Iq1TtvGz/ZIUAanx12E4cAmBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057517; c=relaxed/simple;
	bh=F2LcxpyeXbAZ6yQuz9HOO9xrrEoR3dr2RspAi9wdfm4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bfFjJkB+T5d1TF73O8DFiyoKs+qJ8h8Rl3ksgHsBrMre84nq57LNXD1dUc8f3CI7Ci+1MT9knw1jqyb79DU5cSg77SeakrFPxsymZbfsIQVKkwh4+5uVRdDfI5u90VesMAEkb0nig+B8TTXbp8awjeaT00XH07U8xp57ihEeTCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQQghNLm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQQghNLm"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-848551b54f5so9009933b3a.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784057516; x=1784662316; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WqLINI4cFEscy/WZPHG4l7ke5CIh8W6rLK+pWJB8PLY=;
        b=HQQghNLmPJbqKTTUjZRV9F5lqFbgwepH3HyWhW1iqCym5+pFIiCDV0t9sq4piJRcov
         /NQ2Ef6MRZR+afhlk9xSOoMQfb/p+0wCWmhQLThoDf8VWJNTQclct87Of3wO55xFO4A7
         5C4+XKAE0sjSigETK/d+hRAeEVfu8lOPzpt0JmKgSDzONEmrXgRGRYX5iaJd1lErWCVq
         KtiUKTCQxHUIlpPy+OYZXJtyV/butn6sy4xE9SnFc8Y2gBZOiUU1sNxEoczGsSj5cRKH
         b8e1lQusKxPBB8Luq1LLOJA6EHy6NTN5eT8724MPoA8aX3Y8nmf3gSyg0vvH2k3UhPLq
         PrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057516; x=1784662316;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WqLINI4cFEscy/WZPHG4l7ke5CIh8W6rLK+pWJB8PLY=;
        b=pAqiVGM3mDuWJWLQ2/7tP+dG9XFpwdLeqNMlogtY7RKUUY6XxI2k5Ugu1IUKQNehvI
         uFAu6uTAq2NH7tqIFxv1tMFVTCx8UgDz9GVN4LyAlX+3+2Lr+2jl2E46LGC/Gw3MGDWs
         vGd3FOqN6LSv46y1ndVk+i3AZQX8YP9P1rAytf5pkh73lYQgh87Qwp6iIfDRvZZH+AHY
         IqWRE9If/qGd2fnHW54FmUgU7gL/TCZ7GJYogZPTLRIwMSIfllDZ7JESkUMY5klBnHBJ
         1FS4AWKoKfkfAx9+KgggiCRldZnylOhcBDfZ3gxSJ26iPnOv5z9inCaEUh3AzffSeUbw
         1mRw==
X-Gm-Message-State: AOJu0Yz/obQRjqI0rBIzI3/Ieooaa/ffX4bYUddhqNqz5OqfyBOX9HtR
	Ri1hhghgMOAJ4WW21o/E2t/xMVwsN+WYHipmUQc3zR4bVen4p9jIxzedEZwoCBmR3JDZkowYc+W
	nwrW02w==
X-Received: from pfbdf3.prod.google.com ([2002:a05:6a00:4703:b0:848:4733:fed1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b4f:b0:847:b16b:46d9
 with SMTP id d2e1a72fcca58-84889638249mr13298024b3a.34.1784057515437; Tue, 14
 Jul 2026 12:31:55 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:41 -0700
In-Reply-To: <20260630210156.457151-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630210156.457151-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405424478.3139621.10082262087500923351.b4-ty@google.com>
Subject: Re: [PATCH v2 0/3] KVM: SVM: Fix a (very) unlikely UAF for GA Log IRQs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Xiao Wu <xiaowu.417@qq.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 30 Jun 2026 14:01:53 -0700, Sean Christopherson wrote:
> Fix a potential UAF due to freeing vCPUs while they're still reachable through
> the global hashed list used to handle GA Log notifications.
> 
> v2:
>  - Defer adding the VM to the GA Log list until a vCPU is created (KVM only
>    needs GA Lot notifications to wake blocking vCPUs), so that removing the
>    VM from the list can be done during pre-destroy without having to handle
>    the scenario where VM creation fails at a later stage. [Sashiko, Xiao]
>  - Drop the stable@ tag, as it's not clear to me that the bug can actually
>    occur in the wild, whereas the changes themselves are somewhat risky.
> 
> [...]

Applied to kvm-x86 svm, and I even remembered to drop the avic_vm_init()
declaration.

[1/3] KVM: SVM: Make kvm_x86_ops.vcpu_precreate() hook fully AVIC specific
      https://github.com/kvm-x86/linux/commit/8b47740b3ae0
[2/3] KVM: SVM: Do all per-VM AVIC initialization during vCPU precreation phase
      https://github.com/kvm-x86/linux/commit/4fa9a3767d1a
[3/3] KVM: SVM: Remove VM from the GA Log notifier list before VM destruction
      https://github.com/kvm-x86/linux/commit/78684b65fcc0

--
https://github.com/kvm-x86/linux/tree/next
