Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60628F949
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938587; cv=none; b=WhuQ2+EXdIr9eqRMbP8K7mtrUhFDOufu0MtMQoaXRIpFhLeDowr1iu21X9OBErJzdj9Cu7mE56zRlKxMiWRQBgfSMRStT4SMGRwt43ZeiVhz/0dUUMi34gQraUODh+n03qOzzcxOLKAqcT0D22THZC8VaMJ4V/v9rS4zACCkm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938587; c=relaxed/simple;
	bh=MJHAY/0lOZtESReKmEZbrT/tBa8Uv8X4qGxYXF2Xvm4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L+GO8RJCbOxoljm8Mp++2NAxqd0VHBBj05PGG5tz5vR1Ptglm6WPR57AnrDwHRmeSzggs7AlmQaO1+6E7w4ygCqoEoLX3yIA7OK/YqQfUjX3hfRkjEk6/+94ptuLGau+OnLlJBbDXqL5rb8h+EtxtBINhDltaAF2aqGC/DrW1Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VwfB1yqm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VwfB1yqm"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c80f89b64bso16879145ad.2
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 13:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782938586; x=1783543386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul4KfkOuOrRVfcOqe8UUYQTjm8np2xMi7aWFEy9eSTw=;
        b=VwfB1yqm00QIqg/S42/9JTfGZe9/EKbHe+FtDGHxY23fc62s9CUL/emsZghT9XB2jY
         KKl/htZiejIevLAfnxG7JydFsJThnhvaGgQIJhpgnvfQ8U9qLIh8jG5r610gMiwL07GY
         iKJyMMgxZsPog4eKe+0ZcCH2lVw+kuR29/gFpCQpqFz6V59mkYoMnIIbC7gVQHC1427j
         pfc3z1nMgrXK0Fy6ryR6V2KhFU/t4upNUlUIilBEuJnHd7v8MB6kbD0Akka0tfj1HBsv
         LO8qCSxt1gr+p6YLcxmsrKJQ8BZk/m3E6aWM6j+HECBmqY5BYmGZFNGnGBwWuWyBoqJ8
         9OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938586; x=1783543386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul4KfkOuOrRVfcOqe8UUYQTjm8np2xMi7aWFEy9eSTw=;
        b=QBBDEvrBKKG2MKZ/Ebqoj4gtaEsxUeHZ7zLfkqk2i+byXxt2WgX/ENRc4aM7AlIIgs
         +J2jmk37V+eWFFvsVL4g9toxQpuE5oHP/SM+40q6dHp1dLjWEtF9tMkK/xihnxzmPpw2
         TS0harS4pgs1LYjG4tAIRkSowNbXQEGcJm1up4vS9EAf9ESZhfohXcer09qAjHyjkPeC
         Zz+AXcASTnyGl1Sg0dL0NmZIYRJncgRso85e6ctIGIv1mjFc0Ho3OQ8ZZYIle8MU1XSk
         yyz8ZuVLVLBCvSBpeE+5klVQevbG57jbSWQnconHiZmeF6vmtcsmWFCCpULrullwR1r3
         ELBQ==
X-Gm-Message-State: AOJu0YxrgXwLJ8V4mZDlDWHMsesjM/ENR/mRRSJuBLyoJ4HMR3koKECN
	+a0qR6B7U1EtKCsRRbtcfHDgki/Kc8GbYKAY6UhCqYrNQ5TDksZvZ+Vle4kVktdNX9Mf0CvExdC
	O7zjQRA==
X-Received: from plbla16.prod.google.com ([2002:a17:902:fa10:b0:2bd:4b8c:fd31])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e785:b0:2c9:c16f:eda6
 with SMTP id d9443c01a7336-2ca7e8a899dmr38410135ad.39.1782938585487; Wed, 01
 Jul 2026 13:43:05 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:43:04 -0700
In-Reply-To: <20260701200318.B83061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com> <20260701193212.749551-30-seanjc@google.com>
 <20260701200318.B83061F000E9@smtp.kernel.org>
Message-ID: <akV72B0ORjG1rOch@google.com>
Subject: Re: [PATCH v5 29/51] x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does this change inadvertently leave the BSP's kvmclock enabled when
> powering off the machine for ACPI S4 hibernation?
> 
> Looking at the final S4 power-off path in hibernation_platform_enter() in
> kernel/power/hibernate.c, it calls syscore_suspend() but does not call
> save_processor_state(). Because this patch removes the unconditional BSP
> kvmclock_disable() from syscore_suspend() and relies on
> kvm_save_sched_clock_state() (which only fires during image creation),
> kvmclock appears to remain fully enabled during the S4 power-off.

No?

  hibernate()
  |
  -> hibernation_snapshot()
  |  |
  |  -> create_image()
  |     |
  |     -> save_processor_state()
  |
  -> power_down()
     |
     -> hibernation_platform_enter()

I'm not familiar with the /dev/snapshot interface, but I gotta imagine userspace
needs to do SNAPSHOT_CREATE_IMAGE before SNAPSHOT_POWER_OFF if it actually wants
to restore state after S4.

> [Severity: Critical]
> This isn't a bug introduced by this patch, but is there a use-after-free
> risk with the stack-allocated waitqueue head in the async page fault
> handling in arch/x86/kernel/kvm.c?

And I thought I had a problem with scope creep during review...

> When a guest task waits for an async page fault in
> kvm_async_pf_task_wait_schedule(), it waits on a stack-allocated struct
> kvm_task_sleep_node. Concurrently, when a waker CPU executes
> apf_task_wake_one(), it unhashes the node via hlist_del_init().
> 
> The waiter checks hlist_unhashed() locklessly. If it observes the unhashed
> state before the waker is finished, the waiter can break its loop, return,
> and destroy the stack frame. The waker might then dereference the
> deallocated waitqueue head to call swake_up_one(), potentially corrupting
> stack memory.
> 
> Can this sequence occur during concurrent page fault completions?

No idea, definitely something to sort out at a different time.
