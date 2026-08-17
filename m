Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC133B388E
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974396; cv=none; b=Ru+yXnW5pdXtezb14u47r7wFulDpPHEOP6qDav5ujEoUE9Sn5a20HAH7TbNeT86Hr8EDQemAtNLouWWOzeVv18XpaL4JNTCUkV+BuLcYsF/MNVXZhuVs6O8GEsIl1xcRLqfZBwPdb9kTQ2g0z9OcewZP+GeDWqTa3PCZfHgLYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974396; c=relaxed/simple;
	bh=BNA2bJ8izQU+zHo+wKDbWbBqe6iF/JZhi8seSQQ2KMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G8hXn+ehZAgnlVz5UCi4GtkLn+eJD2sZyphTt8cl02u+/dbQZ1SA+UsMAeItlfrVLL6v6NhzO9MMfrQnxcCij1Bc1BEpMH09Q6Hey9hLRFv/pZvq+/UtMQKIfUgnm/nEnuCsA6HhjlnyQBUOO1WiqfFiFIKvzjiSwv/+tt/V8Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=caEsnLEm; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="caEsnLEm"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so5015985a91.3
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974390; x=1787579190; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G5psuCp/phg+ycu2xLFTJu6xbtt7uSiAktxc7KtLUx8=;
        b=caEsnLEmw+lxL6YA2vB0DCEu3yKCU0z8J9zF1vbe08x8RmDvkR4okgDuUOQIJyaLMc
         VQa18HXBnKppog+pmTZwOpPMGd12RhUTWkc7GdfnHRV5I6Ti9HzVuvjcDNZjapfvZIOs
         bVNUgwf0P5sQcikWTE4WxPtT3hRh+KjftnfmvQQgkSRCniVTe0hMpH50JqTtvn8InRDJ
         Q7YONnFWAD/Qy6obbmtoeqrtOenyQAWnscDj2LiMyYEyndgZ9F05xMZYim/IGOOjFgXC
         83k4uMzzDjZOoAr+K3glEjrmRv6gFqputgBySzYzChEjyPBB1Sip/mP6LwSkkalq07lz
         J0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974390; x=1787579190;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5psuCp/phg+ycu2xLFTJu6xbtt7uSiAktxc7KtLUx8=;
        b=lvlIY5T/5EquKwihJgkT1TaXrTLoKv26jy55+bBmEwiSSDAiqM2t0Nc7r3rV43Eeqa
         18ryT93SrMzmYhE8R8A1scmsMxkcPKy4lBFof54RuYjiG+DBqh0ZW4PYAdLsyiADqp3h
         /Lny1AEIf0niWXANex0G1qxsO7eMkKr7hXRBB8MbztC+5JKPUNv0HJvRAVQ8kYuclCFh
         NcD8VCAdxuhZuu0U9dqALjQpUqbKw6u5G6cpEnxL4Z0Fb7g5h49dDCA04PCsgqdnf+yd
         /X2aFTdO0FPKxbhKRwkAtsNxhGlTz1ZmtTADedBMO1W7SwBbaLS8QnOwcgB5Uq8PIw2l
         rfsA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3UHKhdeSnG4gUY7pktw2VhrG0J/M7nT22qav2HY3X8CzBlhdlD5dSe8plIWkWr8jW66c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1jyG8+34ZQlSTjiihWY7yPJye9ga1KFozpuxy4Ch63PeQKyqu
	6QudbcHRL5Lw0nV+EzeeMiPO7qj9i4VoJU60IplFNEd3sAEAGWds00/BUbWXtbfeditLdAUkCZK
	YjGnGAg==
X-Received: from pjje11.prod.google.com ([2002:a17:90a:630b:b0:38d:f003:cd24])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f:b0:38e:ad9d:1161
 with SMTP id 98e67ed59e1d1-3933b833613mr29799421a91.0.1786974389518; Mon, 17
 Aug 2026 06:46:29 -0700 (PDT)
Date: Mon, 17 Aug 2026 06:46:28 -0700
In-Reply-To: <32c405c0-a05d-49e7-9cc5-3e5918c27df1@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713105033.15405-1-sarunkod@amd.com> <20260713105033.15405-6-sarunkod@amd.com>
 <20260713111119.EC35E1F000E9@smtp.kernel.org> <b50b3535-eaa1-4944-914d-0eea8dac0e06@amd.com>
 <anpwS3C2UIHFz_Uf@google.com> <5149127b-32ce-4409-a443-02b5a9600e14@amd.com>
 <anzsptZlkU4VOKGi@google.com> <32c405c0-a05d-49e7-9cc5-3e5918c27df1@amd.com>
Message-ID: <aoMQtL8qx_P69NTk@google.com>
Subject: Re: [RFC PATCH v3 5/6] KVM: SVM: Add support for AMD IOMMU Guest APIC
 Physical Processor Interrupt (GAPPI)
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 17, 2026, Sairaj Kodilkar wrote:
> On 8/13/2026 3:29 AM, Sean Christopherson wrote:
> > diff --git arch/x86/kvm/svm/avic.c arch/x86/kvm/svm/avic.c
> > index c5b1d294b15a..c9a6da646c8e 100644
> > --- arch/x86/kvm/svm/avic.c
> > +++ arch/x86/kvm/svm/avic.c
> > @@ -1020,6 +1020,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
> >  
> >         lockdep_assert_held(&svm->ir_list_lock);
> >  
> > +       if (ga_log_intr && gappi && kvm_can_use_device_posted_irqs(vcpu->kvm))
> > +               kvm_pi_enable_wakeup_handler(vcpu);
> > +
> 
> I am not sure what you mean here, because pi_enable_wakeup_handler does
> more than just manipulating the wakeup list, it also updates pi
> descriptor which is Intel specific, 

Sorry, got ahead of myself.  I was envisioning a helper that for just the common
part, e.g.

void kvm_pi_enable_wakeup_handler(struct kvm_vcpu *vcpu)
{
	lockdep_assert_irqs_disabled();

	/*
	 * Acquire the wakeup lock using the "sched out" context to workaround
	 * a lockdep false positive.  When this is called, schedule() holds
	 * various per-CPU scheduler locks.  When the wakeup handler runs, it
	 * holds this CPU's wakeup lock while calling try_to_wake_up(), which
	 * can eventually take the aforementioned scheduler locks, which causes
	 * lockdep to assume there is deadlock.
	 *
	 * Deadlock can't actually occur because IRQs are disabled for the
	 * entirety of the sched_out critical section, i.e. the wakeup handler
	 * can't run while the scheduler locks are held.
	 */
	raw_spin_lock_nested(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu),
			     PI_LOCK_SCHED_OUT);
	list_add_tail(&vcpu->pi_wakeup_list,
		      &per_cpu(wakeup_vcpus_on_cpu, vcpu->cpu));
	raw_spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
}

> We have following two options:
> 
> Option A:
> Adding a new x86_ops
> 
> avic_update_iommu_vcpu_affinity
> 	kvm_pi_enable_wakeup_handler
> 		list handling
> 		kvm_x86_callback(configure_pi)
> 			IOMMU callbacks
> 
> 
> The new x86_ops makes sure that irte and pi descriptor are configured
> correctly.
> 
> Option B:
> Common list handling
> 
> The svm and vmx will share function for list handling but IRTE/PI setup
> code will remain same.
> 
> avic_update_iommu_vcpu_affinity/pi_enable_wakeup_handler
> 	kvm_add_to_wakeup_list
> 		list handling
> 	IOMMU callbacks

Definitely option B.
