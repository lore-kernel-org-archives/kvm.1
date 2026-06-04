Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD334C6F0E
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594083; cv=none; b=UNK6l8e3VbrZgX0S/WHcykbFpuRGcT2NdUKQVlbK3TJGOeH5x4BOKRgdT6WsnCcY0V8PCk5isz7X3t8s8hOFP+fHKIrnEU7FzT2meuc3FNHLAV0NWsue/5w8ota4z+fSNohQj92LQ+BDHrebogCifZ9gyMUWfRKSeF2jApwBMfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594083; c=relaxed/simple;
	bh=M2T5ZxLA1JyjKgcvQpdxw8SCcHYr1mJ0zHofsSl1ww8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IvpGh4TbYs6R9bNOK4NGePpPkhBnqEFdFYRGKVKv4L0ApWCJ0dJ/uwcOAYtqwVEM3HahMCev6qheUgKRmaQ6JXW2w5Hio6YQHudGRnEtaGqF4BbzOJD1UsAgcg+U9+tPAaW9oE1xziu6Nru2ZoXlfMkST+ymh1+kkbWRvpJ15Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmF+GtC0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmF+GtC0"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8584e3fc96so569359a12.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780594082; x=1781198882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYJiLzugjQMK/35RUx1gXPZXJK9kZ1zLL4JhlYRYAi8=;
        b=rmF+GtC0xs6kaUmOC5Eym3tbKQcsK3OSjqWeSyIluc0m6SrxnQ4lVLbo7/2hQmfK1S
         duwH+Z9/aDajdicUdX00bE++mCePC/GYJHpm5cAaaD9KjlFl6jlUOernClXx2J89UVa6
         A8huGtVfCs8OSGDfKVTXbjSwb/gWZa/x8zaud4jjHJQHZu9LX0dh0TOFCDwTBeY748Eu
         273FL53fpOWVv5Zh/qE4qEgk3s0uul9dQObm0kFFju2a8U0l5NkPOavJT8S73bGFI5oV
         mW6zwZTYursNzVJsrOANWGR974TUHnLmfMqF+BN0tQg4oa/aZa6qaooKIW+Dz686/H/Q
         bcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594082; x=1781198882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYJiLzugjQMK/35RUx1gXPZXJK9kZ1zLL4JhlYRYAi8=;
        b=ogN5T3onA1U+AvM1/PNBisRY6TME3D1d5k3EoSgtCQKD+Lcm/phM+9bht9wM0b7sGZ
         7H05uQ9l/Qd/cwQckowBKywdCMzrSHKSSuuAyHawo0qDXMZiNLQ5sqZrvxOakJdtb9/s
         a5VczLq4v9voIykuTavR12I6IT+iQ1pW/lcgHq1PSXth8CzTL+fakBO3zvAC6GL1qjbf
         6OZGy47eMKeG1Y2cOQ87Wp+JNDy67YBeItlX2jcve47DDDQYyuqE8TwSZgiZKHCjdB8K
         UMMucIxR8P+h2JuBZp1OSW971w3PBETWWlYIPTeMmCROfG6aMOP1kclt4Z3FB5feX6Ha
         qiwg==
X-Forwarded-Encrypted: i=1; AFNElJ+FklRaKBtqPaRF2CIhkaj9zxeNqrJFYt5VuKcFqpguJNU7ETA59lvmm7X6dRj9KYluP8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YySy0Y7SdhpjSy2MhZZC27tilw8M0yJUpP5CW+Bw8BmxPvfYksl
	PkpWrQgKEzTtFwbGURHC99VwqaL1d2gavWIn3ueOiRiyu9WfT6CJL3TjG7HgqVslMfHmrJis/sl
	aHhqnMw==
X-Received: from pgww25.prod.google.com ([2002:a05:6a02:2c99:b0:c85:6d7c:2c15])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6113:b0:3b4:9168:d9e6
 with SMTP id adf61e73a8af0-3b4cd04029emr53452637.37.1780594081546; Thu, 04
 Jun 2026 10:28:01 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:28:00 -0700
In-Reply-To: <20260604022125.A29011F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-20-jrhilke@google.com> <20260604022125.A29011F00893@smtp.kernel.org>
Message-ID: <aiG1oPLl6kD5ygJT@google.com>
Subject: Re: [PATCH v5 19/21] KVM: selftests: Print vCPU affinity on timeout
 during IRQ test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, sashiko-bot@kernel.org wrote:
> > +void kvm_print_vcpu_affinity(struct kvm_vcpu *vcpu, pid_t tid)
> > +{
> > +	int nprocs = get_nprocs();
> > +	bool first_range = true;
> > +	int i, start = -1;
> > +	cpu_set_t cpus;
> > +
> > +	kvm_sched_getaffinity(tid, sizeof(cpus), &cpus);
> > +
> > +	/*
> > +	 * Output format examples:
> > +	 * - Single CPU:  "vCPU 0 (TID 1234) affined to pCPU(s): 2"
> > +	 * - List:        "vCPU 0 (TID 1234) affined to pCPU(s): 0,2,4"
> > +	 * - Range:       "vCPU 0 (TID 1234) affined to pCPU(s): 0-7"
> > +	 * - Mixed:       "vCPU 0 (TID 1234) affined to pCPU(s): 0-3,8,10-12"
> > +	 */
> > +	printf("vCPU %u (TID %d) affined to pCPU(s): ", vcpu->id, tid);
> > +
> > +	for (i = 0; i <= nprocs; i++) {
> > +		/*
> > +		 * Iterate to nprocs (inclusive) to ensure that if the last pCPU
> > +		 * is part of a range, the 'else' block triggers one final time
> > +		 * to flush that range to stdout.
> > +		 */
> > +		if (i < nprocs && CPU_ISSET(i, &cpus)) {
> 
> [Severity: Medium]
> Does using get_nprocs() as the loop boundary risk silently truncating CPUs 
> on sparse topologies?
> 
> get_nprocs() returns the count of currently online CPUs, not the maximum 
> CPU ID. If a system has 4 online CPUs but their IDs are 0, 1, 2, and 7, 
> get_nprocs() will return 4.
> 
> This would cause the loop to terminate prematurely, completely ignoring 
> valid but higher-numbered CPU indices (like CPU 7) in the cpu_set_t mask.
> 
> Should this iterate up to CPU_SETSIZE instead to encompass the entire mask 
> capacity, similar to other helper functions like pin_task_to_random_cpu()?

I'm going to skip this one for now, too.
