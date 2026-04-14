Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7DE189B84
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174256; cv=none; b=otfABCM+s9r+q7Mm+S3PUrUlATAd6x346gx066IcoL5Pg8EiETLQYeHvH//qZJog72xmMQ7WwN2A8UstjQVtJHoEqIqqPvV1Ak4803G0oxchYnfjVTpnYrQ74K99XQ4F4S4CkpM+0TnuQPRddL4Xmo+tQvoYS90fgfYQevPICUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174256; c=relaxed/simple;
	bh=FXyzhVd45QAGHhKvQiC316veEoapczrLxFSiWOE0fjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pv8AyFtDa2DXxkcOGRfAD3t1GM4pbt7vShZ0nvrGlT8nAk0n3q8b1paW+jg1DeevBNobc0bp22WyrSzEh00XX6Zx0tKPQh1d1X3yf8fFOmQfUz2x1QIXqSb5I49cjdw2SECOvu53CACghOrM8lSeSB1Bn0EwA5GIh0xPiMrKrpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OPg1Xs+L; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPg1Xs+L"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b24af7ca99so78458345ad.1
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776174254; x=1776779054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xk10vdZMvoF35vo2wryi4gcppRXNySBYTaE8DIavMRY=;
        b=OPg1Xs+LSxfX9JyBYrhrinHGucEcl6+761cOpmdXeBM4TM6ngdjSkxwaxrYtWKP2Mf
         CQPkcRlZ8BUfkLNtZkGE0dBtqZ+2gJfuae+0Rp4S8pOKurBGiHLq9O+acEa/03nbU7te
         c0Rlpv1xzqv3/T5TNW3AIXxZbiwKa2vrtxSTApgwXsHa/knSN+iwA7jqRM9sUtTWKa1E
         pQV+CPOJV9gh0FA0EdMonFHygZ/8PhDigDEm6wTz4WLOBlAX0butiS2HLavu2zw0sc7X
         4g8GLZvXFCN1loBEBRfBUL0afLkPhWhUW2hrraV6TzVxmWNZz76gmKdb2nitAaHR9Sj3
         btmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776174254; x=1776779054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xk10vdZMvoF35vo2wryi4gcppRXNySBYTaE8DIavMRY=;
        b=gbA7Mo+5CivxdizqwcjoweP2F5AnZ2UHjLqIogL9TSL8qnPJOpdgRGr3PWA6fLMS9j
         z/Jtm2cyHUVHvSc6IFxFeLfZhNChh033wLYTERs6FC/Uns4G9getPaosg7H32XKjICBV
         Z2PgHLa2sIQgb+tX+999esJ0M3wCVgmCfbGnrIDRv2OmQOBlywm1SF/7+SZinmpnGK9P
         8+kjrxoV3B1fAOU37owl7xN6sFG1i5gOZnRD/9cBHBf1FXsHMIoNbrLImuvuQL1QIP6+
         gC0Jp34maKY96ff8zrnX/c/hwAPwTD2/n3to9/QDnV86YmuU74FL3QjmQD6/JAZGez6g
         J/lg==
X-Forwarded-Encrypted: i=1; AFNElJ8JfyGZGFy/DUddEiLrKriGoCSEhGjuoPZaEaGX2G3LPKWJP5xvbgG9X4fxMsXErC/6oMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+FB5716mF2JhEw6twn8znGnJBBgBUH2Gdlui2ZMgllL2EU/4D
	401GHDqK8rXx8icE7F4t+tdJryboGLQScFTrH5WozbQce5+eQ7qbDNkgpqOwsxNy8xjdl6b0LEw
	kI6ADPQ==
X-Received: from pfbdi7.prod.google.com ([2002:a05:6a00:4807:b0:82a:ff5:27d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7486:b0:398:b346:b13
 with SMTP id adf61e73a8af0-39fe3d0dfafmr19709277637.16.1776174254172; Tue, 14
 Apr 2026 06:44:14 -0700 (PDT)
Date: Tue, 14 Apr 2026 06:44:02 -0700
In-Reply-To: <tencent_510B7687999B510DE0D00238024766980C06@qq.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409213333.1995382-1-seanjc@google.com> <tencent_510B7687999B510DE0D00238024766980C06@qq.com>
Message-ID: <ad5BsDdZ9FGpMIhH@google.com>
Subject: Re: [PATCH] KVM: Drop kvm_vcpu.ready to squash race where "ready" can
 get stuck "true"
From: Sean Christopherson <seanjc@google.com>
To: zhanghao <76824143@qq.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanghao <zhanghao1@kylinos.cn>, Wanpeng Li <kernellwp@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 14, 2026, zhanghao wrote:
> On Thu, Apr 09, 2026, Sean Christopherson wrote:
> > Drop kvm_vcpu.ready and instead detect the case where a recently awakened
> > vCPU is runnable but not yet scheduled in by explicitly, manually checking
> > for a target vCPU that is (a) scheduled out, (b) wants to run, (c) is
> > marked as blocking in its stat, but (d) not actually flagged as blocking.
> > I.e. treat a runnable vCPU that's in the blocking sequence but not truly
> > blocking as a candidate for directed yield.
> > 
> > Keying off vcpu->stat.generic.blocking will yield some number of false
> > positives, e.g. if the vCPU is preempted _before_ blocking, but the rate of
> > false positives should be roughly the same as the existing approach, as
> > kvm_sched_out() would previously mark the vCPU as ready when it's scheduled
> > out and runnable.
> > 
> > Eliminating the write to vcpu->ready in kvm_vcpu_wake_up() fixes a race
> > where vcpu->ready could be set *after* the target vCPU is scheduled in,
> > e.g. if the task waking the target vCPU is preempted (or otherwise delayed)
> > after waking the vCPU, but before setting vcpu->ready.  Hitting the race
> > leads to a very degraded state as KVM will constantly attempt to schedule
> > in a vCPU that is already running.

...

> kvm_vcpu.ready still exists in struct kvm_vcpu, but there are no remaining 
> users after this patch, so it looks like a leftover cleanup item.

Gah, I intended to remove kvm_vcpu.ready, not sure how I didn't.  Thanks!
