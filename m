Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41601EB9F2
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775078182; cv=none; b=hZ0eCWO6jCXi7j90zrq1DHqTmMCwMjpwBrSrxao4G2tSlHuM7mK/Dfyoqv+xD9izU4mr/evKLbOZLRHj1BBoMOb6qDbkQZivnDP0D5AI3bsM1YIw+AybBMzFExR6nhysvw3EWts7ipq7Bvugvj/phPsO804hMs0AyiDcwzD66rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775078182; c=relaxed/simple;
	bh=l6iX1nTTLN/2uZkvSFq8geykaFQBjso9ZjDDB1VMUM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ae4T3oC+p63w6iDRV0BT5mhlKHKQjP6oQs5rVi8Ou+SYWU2nKrDidvXURa+lR7bmiyPb62Mf/g1+mdVdYqM/luho8F59VPMoErv6CTxLHiQGwG0bUopSLO+hQaLPT2khFxkO4UWThZH9XavtKkx9+gcCFY+7CzsDWiGEe32ZJak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QvsIVPub; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QvsIVPub"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82ce1c395ccso441931b3a.2
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 14:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775078181; x=1775682981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ebhOtBJLLq955jMRQ0doD/9JGBRayn9HmmZNW0XQhFg=;
        b=QvsIVPublX4qQPIgSGS1MDedO5t2sI5YArEUv7IyNTNF0PxhUFSFdBicnH7j5RWAHu
         9mBrW1wvCxJ68CFHF8gy8WSFf8FZjkas3YXJ7D27jzfTlJshdkkSKwr/iDZLKvyfu+Qy
         q81ISHQFWIyjUj3QithW670sR4PtNqYaJHWKtQbnrudr+lgiuYYMx8Z+4UpNzl66k9Q3
         02LNaH2mVEX7Tdhc4lcyephislGwaYHj4ibptbpTwXSM9wCfUTBSQ77jg5GhsproJ/aI
         ycieIL7iEgorfS5juVtutoFRddQ4s2t5zZzNJkZFC/H7f/w2eZ3jdYzB6l9NdeFdV4/Z
         NrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775078181; x=1775682981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebhOtBJLLq955jMRQ0doD/9JGBRayn9HmmZNW0XQhFg=;
        b=lWCPFGNyMXG9Te42Vg3+MuldokWv7BxMeD8DUDjI0oWa9CEgavotNflc1d+gc6ISJG
         1lIKGBDDEFDeYgXKhaup4es4QRQO0F5yMrNTuIFY4OP1gJcEJn8OF8O3bWQ6yNDFJbF5
         0eHrXY+KnCYxr4zhrsiNUlPQK/lfZkSFjWxl65xhGh7RxIOxUBkNW/68urJ1H6ToDR+a
         ymJ+EnEqNqrlBYfmMTFkwD1lbmNtAld5D/vXfupE18KxaEWcJ+kmnk37ehJfU8oBAVT/
         NQF5L68Df0PyuKVFMTjImzDEoRf2TBl9wHk6vFZWLlmNW6VWswqofSe8m01JWfnz0iux
         yfgA==
X-Forwarded-Encrypted: i=1; AJvYcCXOq/uEfyFwRZK8p0qe98eVrOshq1DNHI39HTKORDdtIrO2zYlSqeFsWZCIij1LIZI0jgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5QDyEakUXJKJdZImZt7FkjYFNolo+kqUYspdsOrIdsj1J5x4N
	r4D4LS0E2Fvot8vJuj3GUrLaIrCdLImhPzb54HncXMerKTN0QyTVClOFw+Fq59kYS5F3KHmsCdP
	zml6BAA==
X-Received: from pfwy21.prod.google.com ([2002:a05:6a00:1c95:b0:82c:e41e:8959])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8b84:b0:82c:ec1b:9e15
 with SMTP id d2e1a72fcca58-82cec1ba300mr3372988b3a.1.1775078180972; Wed, 01
 Apr 2026 14:16:20 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:16:19 -0700
In-Reply-To: <CAKcXpBzJ=ZNL=_XJBoG9sFXb0pt4JrF0wP3u_2eQSx-FizbOcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com>
 <CAKcXpByCeeqCg9gMnsNzz1hhS36gZuJ6YsBAMBZJWG0n35bcRQ@mail.gmail.com> <CAKcXpBzJ=ZNL=_XJBoG9sFXb0pt4JrF0wP3u_2eQSx-FizbOcQ@mail.gmail.com>
Message-ID: <ac2LI_UPPrf45vmp@google.com>
Subject: Re: [REGRESSION 6.19, BISECTED] KVM: x86: kvmclock rate-limit removal
 causes IPI storm and high guest steal time
From: Sean Christopherson <seanjc@google.com>
To: Lei Chen <lei.chen@smartx.com>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, kvm@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, pbonzini@redhat.com, 
	Igor Raits <igor@gooddata.com>, Jan Cipa <jan.cipa@gooddata.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 01, 2026, Lei Chen wrote:
> Hi Jaroslav,
> 
> I apologize for the late reply.
> 
> I have reviewed the code and identified two scenarios that currently
> trigger the KVM_REQ_GLOBAL_CLOCK_UPDATE request:
> 
> Scenario 1: kvm_write_system_time
> This code path occurs when the hypervisor (such as QEMU) adjusts the
> time, or when the guest writes to the TSC.
> 
> Scenario 2: vcpu schedule in kvm_arch_vcpu_load
> If this function triggers KVM_REQ_GLOBAL_CLOCK_UPDATE, it indicates
> that the virtual machine is not using the master_clock.
> 
> Those two cases are uncommon. Could you please provide your dmesg and
> help check which code path triggers KVM_REQ_GLOBAL_CLOCK_UPDATE?

I'm also mildly curious as to why KVM_REQ_GLOBAL_CLOCK_UPDATE is being
triggered, but I don't know that it matters.  E.g. fixing the underlying flaw
(if one even exists) could fix Jaroslav's setup, but it won't fix setups where
the "uncommon" cases are unavoidable, e.g. on setups that _can't_ use a master
clock for whatever reason.

At a glance, explicitly ratelimiting kvm_gen_kvmclock_update() seems like the
simplest option to address the regression.
