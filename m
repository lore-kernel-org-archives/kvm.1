Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1995D299959
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408816; cv=none; b=uCKtemnkUObeIHau8L1t3/PyTBCWZObvRo/1uFfcXAyXiPQaatyGrf/WIOgNTkPPax+yuqDmkS2DHzKH0YvzvXL9TYijrhkimEk1+tFh+d7XRFQZ44HF2nBQX83qR5Rdg3Gp2t/FXEUoQjDpjfHoZCfOSdRhycO5GJ61k2ZOZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408816; c=relaxed/simple;
	bh=gPQX7eKDjF4fZq/GhWCuXhtZgyhr/sWawWqdyrYXkio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qE7IQ9Q7CpDuujlwiIQfNMvx9VAwxwns/Iu7sGVNSqbSzfXH1/e8OjBnuwqm2GS/olVjRJ8VjOSTKw3KhOvs0QBNghnSHe5+2mDEsA2Z+InM9kfFxQ3U39w5JLBuWGt20NMdu6E2kSvrdw3gPMPky//RaajI+LfzaZXtxRXNtWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d85tdKCH; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d85tdKCH"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848d21bbb55so4234261b3a.0
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 17:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786408814; x=1787013614; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JyMT57kWt1PHWoThOFjq7MhJaHyWUBNbFvppiukGfjo=;
        b=d85tdKCHVOZieTtJQ+IDiQ2pjNIuEOCyJWY9uoEoZlS76SjWliJ2I0QOUqfAAUtpIO
         lixKxun7pMVz85nLDzvIAq8nSeyUXZe1WdCtuJZGaqVg7+0mMS+5mbIhu8JVSkqChBx0
         2tbXnQYpl7LdP2N8W1fRPbG5cwm650FBjVPsH5iJhZURRKN1qnmV0tKyHeWXx724nO6B
         iy54ocfGrFrJGvNRTM7hYEoQ0e+AWKg4QUy1fzlUjHgshHNYHLo/Z4cjgu2r6sDpOM5n
         ZSi6w82ADFvfE959WkJMsbRtZIviNoI13fvU5lZD67OjF6xxdfVAE0SO5h3wJLTqkQhb
         eYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786408814; x=1787013614;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JyMT57kWt1PHWoThOFjq7MhJaHyWUBNbFvppiukGfjo=;
        b=n2ytVKiW7WYfzSeRcDBHy44g1FATyR0cHGwYyT2XgF0n0zDcIBBYdVBmBuxRdBwXd5
         CW/tjDtJEqV2oja9UaBLsgw4OcXn4gEjNQGtyP1tDE9yYcuzzAqV5CgnrHKiR3WraEW0
         QOWu6Dusv1HEoL0HxMwBlYW4+E9HZLRZIdsEiOUSgfzwqCN6NUggnMPv6hglObYy7fnr
         RHgI7xlPsU1uvnkOcNxiSZk/Rydkrx4XT0kO/pSz887FlEO3mPaRmcLWQKI9OdndS3GR
         moVlomhWcZEzWAriUMR92Ja/JBYDLN5zlHnjdrfL37CTvRpIVQfQTQXwFS9Iaaf0Nvec
         3l1w==
X-Forwarded-Encrypted: i=1; AHgh+RqTiT1J3ZBHkeWWkqc9BIG22Tv/w8IP15W28kErHP898+Lpz5b1Rzditc20rZFyM4S/5Os=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3uCRsQhKH//7Ds3x4P5ixzEehRF2j5gusds7eU4Zgi0NicXl+
	Es2o+GW5RWJ/yRKC54C+G1KxRcGZbNT9cilnKPiX7zLQ8jDPwNvx3eGdv1kF82RcOGUHbaVCkdd
	08X/bUQ==
X-Received: from pgbg16.prod.google.com ([2002:a63:5210:0:b0:c9a:2800:5ce6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d10e:b0:3b4:8f18:33a
 with SMTP id adf61e73a8af0-3cc1a0bcd09mr6439126637.1.1786408814121; Mon, 10
 Aug 2026 17:40:14 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:40:13 -0700
In-Reply-To: <6adaf312-84ff-4fea-b072-61588fd73b40@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713105033.15405-1-sarunkod@amd.com> <20260713105033.15405-6-sarunkod@amd.com>
 <20260713111119.EC35E1F000E9@smtp.kernel.org> <6adaf312-84ff-4fea-b072-61588fd73b40@amd.com>
Message-ID: <anpvbdzUIE_JtVoL@google.com>
Subject: Re: [RFC PATCH v3 5/6] KVM: SVM: Add support for AMD IOMMU Guest APIC
 Physical Processor Interrupt (GAPPI)
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 13, 2026, Sairaj Kodilkar wrote:
> On 7/13/2026 4:41 PM, sashiko-bot@kernel.org wrote:
> > [Severity: High]
> > Does this lock ordering create an ABBA deadlock?
> > 
> > When a vCPU is preempted, the scheduler executes kvm_sched_out() while holding
> > the runqueue lock (rq_lock). KVM then calls __avic_vcpu_put(), which in turn
> > calls avic_add_vcpu_to_gappi_wakeup_list(). This acquires the
> > gappi_vcpu_wakeup_list_lock, establishing an ordering of rq_lock ->
> > gappi_vcpu_wakeup_list_lock.
> > 
> > Conversely, when a GAPPI interrupt arrives, avic_gappi_wakeup_handler()
> > acquires gappi_vcpu_wakeup_list_lock and calls kvm_vcpu_wake_up(). The wakeup
> > path then attempts to acquire the target task's runqueue lock, establishing
> > the reverse order: gappi_vcpu_wakeup_list_lock -> rq_lock.
> > 
> > This inversion will likely trigger a lockdep ABBA deadlock splat and violates
> > the scheduler locking hierarchy.
> 
> For this condition to exist, Following two conditions must be true.
> 1. avic_vcpu_put() and gappi interrupt handler() must be on same
> physical CPU.
> 2. GAPPI must preempt the __avic_vcpu_put() once it has acquired
> gappi_vcpu_wakeup_list_lock().
> 
> The second condition is not possible since __avic_vcpu_put() disables
> the interrupt while aquiring the ir_list lock.
> 
> Hence ABBA deadlock is not possible

I wouldn't be surprised if you need to tell lockdep that, e.g. see commit
c0b8dcabb2cd ("KVM: VMX: Use separate subclasses for PI wakeup lock to squash
false positive").
