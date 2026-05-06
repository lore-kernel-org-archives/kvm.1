Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B543ED5DA
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072133; cv=none; b=bc7OcC+kL4BLAqIUS2T6daVVFrAkt55tw2eLd5JB+MAzH0nF7qH7P/UdyK5u+n1ETV+K3/1H8pIscrWItBDtgM2x84pZqFGJBaN+kX4/GFUtZl30veonnWhyB/8zgFcPKqmWEhFE4zY7OpfcSQAQSddD0lX8vLbfFK1Jmh+MDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072133; c=relaxed/simple;
	bh=BJQMw0Dh46S8PcBKryF9N9BDyA2dfY6w0ySC4+x6YQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rzn6G7Knn1EiQRkzoX001S7fhpV5K9CqJoEyqb2166SoFZoNqN5kj3GUlNwpN8yrcd4KrcG1l3+S6tsIgoyX+seh7lDx2Dmwp302tyWwnyLfuMgn3ttieos77NZX69l2aXl8GREftrcFtKCLfzXwmoBWbFCCXTr2uwpMe6bu2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNNJek/q; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNNJek/q"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f7bec24fdso3618112b3a.2
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778072126; x=1778676926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcBCFuoSCXIkQ6NjTEoF6df40RIio8PzOnuLVmySm0w=;
        b=kNNJek/qVwx7B6BdqZ8D2laqugoDxbkmL5kk1wFe1xhK2lfhB0Q4ufGVl0sruYUCic
         cQRogcTZQRmLEAt86yYmkasdo5X9tZu7FaMG5VqU4t38jN06+OerU2SQjAl51GxDitOI
         8PRsobdws6Nn+WrLdUtLiiS/27bpi+szpNLDWQ0W4RYznZbCYgktq/I97Gt/DyLLgwpg
         JkCgqPE4C72wSXL3YczbT5XDLMBm1zr4da0vWH7MPfs8M26JA4F6rR1V4InauRmkJedt
         +Caf1O/6zYIb+2TW7Cj0325VcYsxnE+DdTv7WXB3bjQjYHbjWQeCVG084v/toxyxHSei
         ItBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778072126; x=1778676926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcBCFuoSCXIkQ6NjTEoF6df40RIio8PzOnuLVmySm0w=;
        b=KQxuj3Wwjtw1VGl8zI9eGjy3Qt0sYLaQGRAV59SwDcJ5tG1lzTKPQxJ9lFbqzXFZST
         Wi4c2CkB8gz46ElgaY9wXnERqxqWt+FB6SA0S5rr0hLlWD2tqGePlPi1TvU8i+OZIw7u
         Fkd66o+9X/QtInb/Sm2BWtcxHSMzfw6KG01pQOAF+XcspTRpwG8HaGn2UuFAQkPehbFj
         9u15CHD1rpGlHjjwuEe1PuIKMZiPgJcV5ZEAs45yb4Nar1jnd3CzhUWkbaBcaHkgxuuV
         R40u6i/cV+Cm3UG7C5QVv/FkKIOUcZH4yhmcOGd9C3jjFpwrA9HxcBCHUbZp9vS8gJpE
         nfnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cbtSeCMyKIjxm3HizhvgDDILrbB2XbOZ+fQFEBRnq2wdHzDSRAEt/CMNtxygYlgH13aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDtZEFV3ynt4T4P1PsOSbf9k0E16Rf8Rc4jdO6ErHwmMjV9+/f
	piXHe98+w2rY09gxphEG06vIwwJO621uVM02bGwZhqB+rjAMvVtwiacdZ8ED1x44pFE3bUUQU+l
	Jaibruw==
X-Received: from pfbhs6.prod.google.com ([2002:a05:6a00:6906:b0:82e:7f41:df84])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2990:b0:82f:390a:69df
 with SMTP id d2e1a72fcca58-83a5dc5df2emr3180240b3a.35.1778072125801; Wed, 06
 May 2026 05:55:25 -0700 (PDT)
Date: Wed, 6 May 2026 05:55:24 -0700
In-Reply-To: <f1c742e0-41c1-4bdc-867c-a768a5eb89c5@leemhuis.info>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adVGrJaRlRooO4su@google.com> <20260409142226.2581-1-lei.chen@smartx.com>
 <adf8Q1VSeAMMyCa_@google.com> <f1c742e0-41c1-4bdc-867c-a768a5eb89c5@leemhuis.info>
Message-ID: <afs6PJzU3rHZwGv3@google.com>
Subject: Re: [PATCH v2] KVM: x86: Rate-limit global clock updates on vCPU load
From: Sean Christopherson <seanjc@google.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Lei Chen <lei.chen@smartx.com>, igor@gooddata.com, jan.cipa@gooddata.com, 
	jaroslav.pulchart@gooddata.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 06, 2026, Thorsten Leemhuis wrote:
> On 4/9/26 21:21, Sean Christopherson wrote:
> > On Thu, Apr 09, 2026, Lei Chen wrote:
> >> commit 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
> >> dropped the rate limiting for KVM_REQ_GLOBAL_CLOCK_UPDATE.
> >>
> >> As a result, kvm_arch_vcpu_load() can queue global clock update requests
> >> every time a vCPU is scheduled when the master clock is disabled or when
> >> the vCPU is loaded for the first time.
> >>
> >> Restore the throttling with a per-VM ratelimit state and gate
> >> KVM_REQ_GLOBAL_CLOCK_UPDATE through __ratelimit(), so frequent vCPU
> >> scheduling does not generate a steady stream of redundant clock update
> >> requests.
> >>
> >> Fixes: 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
> >> Signed-off-by: Lei Chen <lei.chen@smartx.com>
> >> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> >> Closes: https://lore.kernel.org/all/CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com/
> 
> Was this performance regression ever addressed?

Nope, not yet.

> Looks like this fall through the cracks, but it's easy to miss something.

It's in my list of patches to apply (probably for 7.2?).  I didn't want to squeeze
it into the initial 7.1 pull request for a variety of reasons.
