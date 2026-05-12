Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03D316A956
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544798; cv=none; b=bqXu5APRUSfwJKQVbxdfGI4eYIKkkCyYsC4pC9Ly7Bfhlpt3i4rL+dKtPDIVH5dQmV6aPmjmRHs/JNxdbb00Gzn6mqCU4sL37bTfJGfwC36l4N5A2Zk2dHcDvxpmd6JiGNCozXDHPeOpbkJuH8dnH4evPoQCy173HNCVO6WUvhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544798; c=relaxed/simple;
	bh=HSBgfbObOgGU8ldj/hIKoGQPFZw89/D/MCoMiB8hSrM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YrgAT4MT6ehgmQGeOAZf1UafLVCVaeXAqNvrtEPRT683pYwwv3cWnhdksUKAzMyBXoSHpn2CykGcFyqbSKV8L/1W2Tmx/SPxKTaR/cQ/VTVYA+uMP4CWBdxm9vGN/bFIXdUB2xKcWl+0hGsncKJE5Sa8hHkD1y85w4RXoDhWD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ozf5Okxa; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ozf5Okxa"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8353df9bc7eso4663675b3a.2
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 17:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778544796; x=1779149596; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4JYEVaDRVs+or3txsBOsP9kx9Y7GV2JqrS69eG16uc=;
        b=Ozf5OkxaZnK3qbCCRRpx1mntF+0CrROwnsD5ZW26cc9z4VA0DEQ/nUtRt0n+z92x1S
         2GEic0CeQyDkfk+tp8ENN4AUS37jId372A/p2u27Dm2AzICO8JfcWGxzV9Ui2ccKIkJQ
         XJcSSDJzwnfZC91EC1y0ySuuhpRCvr3agPYiM/uKWb8NVsW2wh7yib7qStIq0BCL3T+1
         6ngDImOf9OHOwHWeHACCnl67hvkqfMNr5/blHPrGc3Lj+jtfKUxmdnIyz0JbNnNDTJJ2
         9Hd9GCX1bp9lYRtN19oikgZGKXQ86QfJ8IzC5Q6uGB0bv4xPsKD2+tQ8Y2NJDhw0zeoY
         7tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778544796; x=1779149596;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4JYEVaDRVs+or3txsBOsP9kx9Y7GV2JqrS69eG16uc=;
        b=dx1zpUwWE6VigAv95CPIC2EcWFIIDcvIISp2Ce8cS+bSAeesc23XwUYge05pntqcT3
         fNs4RREBOIC+cCrvZ1kc1fi+rxXtvIoMp+2jzH4OkRb4l64Kw6ILjvyn1XizOjiB1Bwi
         64dwyiKc3LzkjBPGnM8PjIWgXfTRoXPRi0iINIXP7N8Je6gMOVgyWvyEzdgFN4jF/7Hq
         CM7aBWThui1gsm3+qVT7sDRPOP5T1EaF9+QMDPm97SawsPF+GZhKtB0uwEyj73m9zBtZ
         7RDqNrolxkYo3P+7HHIjLkXsM4kh8XOp9f98Jrs44Lk7Vbf3ETK7GEcQY9MsTukh4nC/
         HaGw==
X-Gm-Message-State: AOJu0YyIhbDi8ajnxZbbhb5SF/1YDkXebVDgIb0BaRuLTtBp6je23LWZ
	6Ig8NJxDE4M0zEfuOiTTUKLfCiW7inZwRM4SmIlORKUnkNqqi5u9/uc+aNFmJ0HSDnVDU7PlL7H
	scRsrMA==
X-Received: from pfgu4.prod.google.com ([2002:a05:6a00:984:b0:83b:b70d:c021])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c0a:b0:835:3949:3c25
 with SMTP id d2e1a72fcca58-83a5d873e79mr27493326b3a.24.1778544795770; Mon, 11
 May 2026 17:13:15 -0700 (PDT)
Date: Mon, 11 May 2026 17:13:15 -0700
In-Reply-To: <20260102142429.896101-9-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260102142429.896101-1-griffoul@gmail.com> <20260102142429.896101-9-griffoul@gmail.com>
Message-ID: <agJwm8Vog6cSkNna@google.com>
Subject: Re: [PATCH v4 08/10] KVM: x86: Add nested context management
From: Sean Christopherson <seanjc@google.com>
To: Fred Griffoul <griffoul@gmail.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com, 
	shuah@kernel.org, dwmw@amazon.co.uk, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fred Griffoul <fgriffo@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 02, 2026, Fred Griffoul wrote:
> From: Fred Griffoul <fgriffo@amazon.co.uk>
> 
> Add infrastructure to persist nested virtualization state when L2 vCPUs

Please be more transparent with what exactly is being persisted.

> are switched on an L1 vCPU or migrated between L1 vCPUs.
> 
> The nested context table uses a hash table for fast lookup by nested
> control block GPA (VMPTR for VMX, VMCB for SVM) and maintains a free
> list for context management.
>
> The kvm_nested_context_load() function searches for a context indexed by
> the target GPA; if not found, it allocates a new context up to the
> configured maximum. If at capacity, it recycles the oldest context from
> the free list.
> 
> The oversubscription is hardcoded to support up to 8 L2 vCPUs per L1
> vCPU.
> 
> The kvm_nested_context_clear() function moves the context to the free
> list while keeping it in the hash table for potential reuse.
> 
> This allows nested hypervisors to multiplex multiple L2 vCPUs on L1
> vCPUs without losing cached nested state, significantly improving
> performance for workloads with frequent L2 context switches.
> 
> This patch adds the basic infrastructure. Subsequent patches will add
> the nested VMX and SVM specific support to populate and utilize the
> cached nested state.
> 
> Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
> ---
>  arch/x86/include/asm/kvm_host.h |  31 +++++
>  arch/x86/include/uapi/asm/kvm.h |   2 +
>  arch/x86/kvm/Makefile           |   2 +-
>  arch/x86/kvm/nested.c           | 199 ++++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c              |   5 +-
>  5 files changed, 237 insertions(+), 2 deletions(-)

Please provide concrete performance numbers.  They need to be isolated from the
switch to gpcs, and need to show how much benefit is provided for a per-VM hash
table vs. (much) simpler approaches, e.g. versus a stupid simple per-vCPU LRU
cache, a la KVM's pgd caching.

There also needs to be an analysis of the downsides of the performance gains.
If I'm putting the pieces together correctly, quoting a snippet from the cover
letter, the performance benefits come from:

  The pfncache infrastructure maintains persistent mappings as long as the
  page GPA does not change, eliminating the memremap/memunmap overhead on
  every VM entry/exit cycle. 

Which means that this caching effectively eliminates the security value added by
removing memory from the kernel's direct map.  If, in the long term, we're
collectively moving towards guest_memfd (for setups that don't want all of the
overcommit goodness provided by mm/), then the performance provided by this approach
is directly at odds with the efforts to remove guest_memfd memory from the direct
map for added security.

E.g. if the ratio of L2:L1 contexts is pushed high enough, it would be possible
to have the majority of guest memory mapped into the host kernel.

That then raises the question of whether or not we are optimizing the right thing.
E.g. if we can somehow make map+unmap blazing fast for "all" real world usage that
matters, then maybe we don't need this type of caching.

In general, this needs a _lot_ more justification on the design decisions.  A lot,
a lot, a _lot_ more.  This is too much code and complexity for me to even start
reviewing without hard data.
