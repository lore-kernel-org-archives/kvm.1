Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F70C38F65C
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982525; cv=none; b=b7FrqKHCk0f4v9G0Z1eInBsRz5X+Aabe60LCzRmieLz/WH7zVBWM2FkgvV1BhTqI3+D6v0X3etkN86MQa95f+vPfXhmS48yANjVHvQcJjAmoSHaq1Os1m9TEP+S5PaG3AsLvhPABj+XYgeOYdBOo70xHH8cBDgQbDV0RVTghxC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982525; c=relaxed/simple;
	bh=+FJ5FLJcEXm4rAPFPTJEhGYEkMnrX7SvZZ5VX9XiGfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KP2i8fkSIQXbEaTqTIzOw+VD7EVhX47R8ZwTAUezHskXv/bz8U7WpxxX1vDrJ9gxfQkehFONXS82YVIndMZi9cWUCPPBr9RS/BmOnii0uSPNiu1tEizBllB9sImkfAOyYBOFSCI0HppXgTvgG+znTEyUOS1kmBQnTsrWNTKF9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7QIKybk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7QIKybk"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82cd9fa609aso762363b3a.3
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774982522; x=1775587322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz/A+PqaaRYnfto3SVdrefA60vgOfGvRg58Zg5Q2MyA=;
        b=k7QIKybkQzYY3lZtVDwe6pBeKr+m0doM0cawB+TrSkWzUPb7SIwz4VvZ78CsjHv53r
         d/SFOE3MmrYWZgKWaHdq7YM1+JhHxeqkJH37biChRUP/PhbMniNElliVvunovvn8HNDV
         Z5zdC5Qqi+MD1ey7iEN3gcVzjMmC2dxVtM/06IiNln+TVzVV3cdv8Ml6NMc6Zcqc3JOO
         gmXfCZgvpiCGPKfpiDiM/5cCDxyPXW2azwWJ84ppQpfcrXHWtVHZ1XgN4ykMie6E1Tq5
         nA8JvTXSFqj6dT1q9OlfzxP3dWGwAEXNwo5uUv+oExFgm80IQoR7tsMOxnG/YZMef28P
         1YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774982522; x=1775587322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz/A+PqaaRYnfto3SVdrefA60vgOfGvRg58Zg5Q2MyA=;
        b=DuSMIfEuVviM4tqSPNH0jfk50VipfYxk/JDw3el23XE5S3MIL53d7RC9l8LAoi2rov
         ryBFhF/YZPclxEvQ9CuSvOjxvoSB9Gp2p/tfLWhKZLxMOz7L4XD7F6Kd9ZqFFoMn3Hbp
         M9psClGcson7BVCuQTVW/KYRZXYRnuYLhlKE+amcq/5/7E7C/buD/vkV3XMwdiu+bOhK
         L3AEEyF9IcG2k3U1KnIWIuEj40z3d5J5NQIpwkfBlqFfh8nnazLIA/8divZb0SLrcLuG
         PVAQgO7S7V6jKzbtTfusV1wizHTnJ70AaloowokXA+pweTvTR5ZlCdvTSI08+fvGduPx
         nRnA==
X-Forwarded-Encrypted: i=1; AJvYcCVycSLJzCOVsLEsEO+d4TFN3W3+kECy9ovpWXoYRf0UdfAeKcxzqUzszA8o4hlzmba0Z64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCrOqdI9DUBi6Bi6tqGXzBYUh61pbeXZR9q3puPQz4XMMx0Vht
	FaNjWy6PS7QfLLFL+h8tSAuLyBx1rL0tXQ9LRTuM5B+5oTYmsxr6KWpR1NviAIUX2ttAIXYPmq7
	aQPq+FA==
X-Received: from pfbct24.prod.google.com ([2002:a05:6a00:f98:b0:82c:6e7c:ac61])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94d5:b0:82c:9c5a:4c32
 with SMTP id d2e1a72fcca58-82ce8943aabmr599684b3a.6.1774982521969; Tue, 31
 Mar 2026 11:42:01 -0700 (PDT)
Date: Tue, 31 Mar 2026 11:42:00 -0700
In-Reply-To: <CAG_fn=V4ZD8x40sXx2Ctd=LGzQEaeRMJF_yiA8Ekw2ZzuYcSMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com> <20260310234829.2608037-11-seanjc@google.com>
 <CAG_fn=V4ZD8x40sXx2Ctd=LGzQEaeRMJF_yiA8Ekw2ZzuYcSMQ@mail.gmail.com>
Message-ID: <acwVeCYISAoBbREz@google.com>
Subject: Re: [PATCH 10/21] KVM: SEV: Move standard VM-scoped helpers to detect
 SEV+ guests to sev.c
From: Sean Christopherson <seanjc@google.com>
To: Alexander Potapenko <glider@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 17, 2026, Alexander Potapenko wrote:
> > -static __always_inline bool sev_guest(struct kvm *kvm)
> > -{
> > -       return ____sev_guest(kvm);
> > -}
> > -static __always_inline bool sev_es_guest(struct kvm *kvm)
> > -{
> > -       return ____sev_es_guest(kvm);
> > -}
> 
> arch/x86/kvm/svm/avic.c is still using sev_es_guest(), isn't it?

When applied against kvm/master, yes.  I posted this against v7.0-rc2, which
didn't have commit 87d0f901a9bd ("KVM: SVM: Set/clear CR8 write interception when
AVIC is (de)activated").

If that's the only flaw, I'll fixup "KVM: SEV: Provide vCPU-scoped accessors for
detecting SEV+ guests" when applying (instead of sending a v2).
