Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE332367D9
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904165; cv=none; b=PbBPTG0MX1WplJJozj3zVknGOD4Lbj4S6r/aeVhNbpz7ohqArARaHRkzLzt4z8I4LTjCJD1+B8FinAoY6wZld7I4VVAErFzY4KBajcMWr1HaJzNNabu+MmI0Yxdbw8fm4W/JUIGpyHEQIRBzNLSVfiSWt6OkPZi+Ib4aj2qSt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904165; c=relaxed/simple;
	bh=ZmLs2BImNTS697uuYKV7GL+d90yx02AqP4TYiwOmS4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nGZZdtueuHH+1CltxrUjifrjQUtZeb5ZGY+Nsv2UMnjbWxqPY8yhNJppCb05JT/E/g7SiAUSNvi7VqfGCPJ+x4R1dvDhu9iJJ2cZnKRJvbYHUVTMFFp/IQy6YXBhgWFwUwT2FiLvv2jZUP+ePzQiCwKDUYMsSfuZj5a73VGDCuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aabrwo6t; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aabrwo6t"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b9b8137828so123300535ad.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779904163; x=1780508963; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMYTk3hkl99ebNU+1sIwx3gm+Ba8Y+fSM7epDpi6c6g=;
        b=aabrwo6t3BvFD+3Eiag9ovt+MmHtLG6UBOGJeqWLkwywazVBzUuf4X/bhAkqnpxLlB
         jbNPmFI+5IjYogTjSPXR6mf4aH/vVFkX9L1ogUuYGHweuQZpJthEELhkpO/Fyr9sarF9
         SzmFtORKapy6lbkVVz6rqXFAAWjslrLRtKaFYbk3Tkt8ETr4eecXSNu9WFgBY6lYl8V7
         NeOU7TaiGpfbMANAQY6m/od8CxqcUOW7OmKRPFVD6ivjxH8fLYuLp3gNYfhkkaEefSZq
         jhOnf305JcVNKeZ8MhE8iCPNhJ3DvQulflCZYnRDa+6ge0PS/eIQPKr6fBIwsTtLe9H1
         KlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779904163; x=1780508963;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMYTk3hkl99ebNU+1sIwx3gm+Ba8Y+fSM7epDpi6c6g=;
        b=osvQ0k0e2rK05Ek6ZG4nOrdfvVanbr+KrTfCrhEDK3K35KRz2nGfEuAclk8vB2BV8s
         PEHFcmzM3QZgreFbaPVOIWCdKMRo5gGrJShH+++dn3gzyJBzze4NOp63ID8kQ3TkXKs4
         EXOSrbCayXHW4WRQiohyQgcLbzbVbwOhm1lXpUpenL6ASiw8NY5V7+x5bQcnotV0sD6b
         N99+2uD6PovpWJL2qgMlggLgE+94msuIMBvAPg1AbbtT/L/LQliR6btlPy00qtqbO35s
         BcNb0hXE1v0BrweLjsx1ghqIdxqpPuH48gr5gUPoRWxEWbaOTyIXimC45MUDEuYAOVyi
         f7dA==
X-Forwarded-Encrypted: i=1; AFNElJ/CQw7lLRXFfaKXG69JQCShn211r6P/193Ij29EOFax01h1KoShFINx78pBVJWL+I9mlUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eh2Xp7yvgwzS+eLNoMw2iRHwxmneOTixLnH6RF/KYu5e9axm
	1IN7wmDPkgkknav5/UTy+DF1R6wLuzqrxlCmC43CHpvCU+xiaIMrOkIiW/9NlTzjLZORqcn8I6e
	SQlV+tA==
X-Received: from plnz8.prod.google.com ([2002:a17:902:8348:b0:2bd:8434:6d14])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b0f:b0:2bd:63dc:b7ad
 with SMTP id d9443c01a7336-2beb05a227emr251077395ad.2.1779904163215; Wed, 27
 May 2026 10:49:23 -0700 (PDT)
Date: Wed, 27 May 2026 10:49:08 -0700
In-Reply-To: <20260227213849.3653331-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227213849.3653331-1-jmattson@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177989667583.4072071.5439471047016710005.b4-ty@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86: nVMX: Add retry loop to advanced RTM
 debugging subtest
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Yosry Ahmed <yosry@kernel.org>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 27 Feb 2026 13:38:34 -0800, Jim Mattson wrote:
> Linux commit 400816f60c54 ("perf/x86/intel: Implement support for TSX Force
> Abort") introduced a feature that temporarily disables RTM on Skylake and
> similar CPUs (06_55H stepping <= 5, 06_4EH, 06_5EH, 06_8EH stepping <= 0BH,
> and 06_9EH stepping <= 0CH) via the TSX_FORCE_ABORT MSR, so that all four
> general purpose PMCs can be used by perf. This feature is on by default,
> but can be disabled by writing 0 to /sys/devices/cpu/allow_tsx_force_abort.
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] x86: nVMX: Add retry loop to advanced RTM debugging subtest
      https://github.com/kvm-x86/kvm-unit-tests/commit/dbcb11d7f580

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
