Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25638D
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 00:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966439; cv=none; b=fYutzgKwLTRzu7SXjxDAJHL4x/w06bIbv/oA5bNaN6+CPRjUtdjYuW27MKYVsfvQDtbyxHbeXGOGSBs1vQyOUR5YEwaWGZNkk1EdFkxYizijxtBP73GQ1MQs8c+Nn1s9K6BSCpemr5IEbjeoD1dqgfdvXVWdOyb1dQfALT26wZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966439; c=relaxed/simple;
	bh=7JwlSzAVR32H6EGmI7D2l2G8oqBDvYp4ymX0ONAMWZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DqIfxk5s9GdnFuPiB0MHzubQeUdlhwhpsTldwNY5W4HSDrL5aVx8Oi7gbY1quJ5YlLbF0XJRw2/2zVI+sYwfavNph7zXvW7bHOXQAJgQ+o/VEZQODieB8ku7m2NlIEJ0QWlhvWcprVZASnNXuNbAOKaKPc1QMAD/1+b41Kftu/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q794iOeq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q794iOeq"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d6389bbf4so4592369a91.3
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 17:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780966437; x=1781571237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2ofoLVe/pRkC2ffnmIMpARfn+9F9I5mIrOiklVpQ4A=;
        b=q794iOeq8aBzNFappnNIXcOfgKE4E8GtL9/JGZQSbjTVMtLWD5YbEWYap/f3v0ZYwk
         Cumvr6GlurSK6IqzY8CrOrACCkmGmtEsmRqaWvmgPfomN3zjouVZ6pncvZERkwDSSuUE
         9Z30pwu4RyYCLFTIDQ9VVYvguE40rMvQb4KUWa1hsoBaE2PwIrtMr9dpfGJTeDvxglEp
         gTKeUtQzvKljh80NexHEL7tdgpEXBbDy3BkDmF532DATemXwNuJ7Yis0KmSu/qCfCXEh
         SN8R5VnmW6V5qoMAUatpCifQsY6KIXIJGp2NfclnBchfX6sPlfeawOMqE0scSGU8wV3E
         zHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780966437; x=1781571237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2ofoLVe/pRkC2ffnmIMpARfn+9F9I5mIrOiklVpQ4A=;
        b=NXKgRWZlyz6V2aW+kb3smYHRsgRxEqs7N+f36x9dUsGBuSBehbbb8OouEQXzbDayX6
         ZF7fN/3LEWomqadg/gXVC9UQuMXqaygg9tJapCYHn9ijeGm39WihglruBePm+6I5zF8V
         Dw4/vJv+I4kJirkz3Q5jaLCcIv/CRyLzEEYi/DKq0y6VTwLBQoanE6j3F4+G4q1DcUJr
         qY1yN1qOUb5Xtj8Ca2zHsbqi92+JJTyYW6EOM9n4t73bjvXGBOx6FGl8mrIr+e9Da/6a
         /PgPeugszVZI/kHa9OoaFru5TXsoVVnJYVl11jX/ktOar75IeQK+m1b/da1P1/7QEkPy
         dCxg==
X-Forwarded-Encrypted: i=1; AFNElJ+rUQcZzfk3cIPG5iSCnf8oG+atFd+HGY8YyCfsOhsHSsl0WOKCENy9gMbW6zum1Lyw9rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1Rs9L8bGFKwkNkgcV9OZWas+G/lY9irgXneKmI/cqR94Zx3T
	GncUuex8fC56myC/1Dv4RCrL0sPaEIMahyIxHkJe2wWKCZKiS0eQ+EuPK+vtM6YugaGEm3f4CNG
	l/Jg4tA==
X-Received: from pjbbg24.prod.google.com ([2002:a17:90b:d98:b0:36b:d701:c030])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:540c:b0:36d:b680:3036
 with SMTP id 98e67ed59e1d1-370ee447882mr18737160a91.4.1780966437250; Mon, 08
 Jun 2026 17:53:57 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:53:56 -0700
In-Reply-To: <c1f0dee379e282ffb35296da4b666d93025f1c95.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ahnk6cBLuuPIAwmA@google.com> <c1f0dee379e282ffb35296da4b666d93025f1c95.camel@infradead.org>
Message-ID: <aidkJJesvO9vE77j@google.com>
Subject: Re: [PATCH v2 15/20] KVM: x86/xen: Convert kvm_xen_set_evtchn_fast()
 to gpc's CLASS() APIs
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sashiko-reviews@lists.linux.dev, dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 02, 2026, David Woodhouse wrote:
> On Fri, 29 May 2026 12:11:37 -0700, Sean Christopherson wrote:
> > On Fri, May 29, 2026, sashiko-bot@kernel.org wrote:
> > > [Severity: High]
> > > Does this unintentionally hold the gpc lock across the IPI kick?
> > 
> > No, it intentionally holds the gpc lock across _sending_ the IPI kick.
> > 
> > > [Severity: High]
> > > Does this now hold the VM-wide shinfo_cache lock while calling
> > > __kvm_xen_set_evtchn_fast() and kicking the vCPU?
> > > 
> > > Since shinfo_map is a function-scoped CLASS() variable, its destructor
> > > won't release the lock until after __kvm_xen_set_evtchn_fast() returns.
> > > This creates a nested locking dependency and holds locks over expensive
> > > cross-vCPU operations, potentially serializing event channel deliveries
> > > across the entire VM on the fast path.
> > 
> > __kvm_vcpu_kick() is neither expensive nor cross-vCPU.  In the wait=false case,
> > which is the behavior of kvm_vcpu_kick(), it sends IPIs via smp_send_reschedule(),
> > i.e. it's more or less just __apic_send_IPI(cpu, RESCHEDULE_VECTOR), which is a
> > single WRMSR on modern harware.
> 
> Hm, if we really are going to use a raw rwlock then I suppose we should
> take care not to spend any extra cycles with the lock held unless we
> actually *need* to?
> 
> In which case I wonder if we really need the scoped CLASS() thing (that
> encourages people to run to the end of the function under the lock), or
> if the helpers you add for that are sufficient on their own?

Eh, I would argue that "the code is easier to read" is sufficient justification
so long as holding the lock for a few tens of extra cycles doesn't cause problems
in practice.
