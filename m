Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC432C937
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959227; cv=none; b=q8OT+4cuqC1Gt9EVKsf6GtJOBzm1ThYmWMDWq0tNEOrv25r+D3aQ7WOxAS5DNfIDSmup34moK/Lb7gGIteGXH2LiAE7j04fItPNP0hIxnUg61VvPb6G2/F+e0DEBfX3mRX4VZIWTMhUNw2kN+De2sw5tgOtPBB51ep+lqqTv/AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959227; c=relaxed/simple;
	bh=mfeGsIUssFD4BDa8yLNU+8MdWvaJJIrNglRzMtuFLbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QHOThmy5kJ7uSr+c4BiHx9o1LejJKSo0MzPsw8DDfXcVmJ8W66lHuA2dwoHKzx0DQT+kOViL036zwnUl1DgXP3m5++X/z36EF5XqiEu4FvF8uWHUCSv9bZDSUJeo/QqVZnsBboswVtaR6O5vYetR6kYdn/+L/X8pcjCf7wNGSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PRQb+o+N; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PRQb+o+N"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8484b57b98bso6559868b3a.0
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783959222; x=1784564022; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FaREvBP1gg2ufa+OsQJIcco6qjp0ITtDsYsM/CE0YBo=;
        b=PRQb+o+N52DCC7Z07dnZfKY7v1PbVDZbBmbXo9PWqN0ub3V5aJ7EB3v1EjQkszXNy2
         DmWWVOsSjgHex9pUbAhS2fsDKTmqndl2c0FWNKYAaY/fxkIsTWRYqdQezy1C3w2djMWl
         H/9LUy/boLFtjmFrS4Rx2PigaoCs/+84RDAuLoR39WwMNZEj1BzUYDe+e4zkiXr3Modd
         MHxyM6JAopmBYoIG2k2s4c+ZehUUHgeFdnbsxRBG2xxXroQUX/vGyG8Yu/NIRp30tR3u
         PvVTdvM2h01UBKHjYjnyA9ANaJU6rLhfsUITXeyeTLeBPTANKfktcoe5+Hz6shervGBC
         kO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959222; x=1784564022;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FaREvBP1gg2ufa+OsQJIcco6qjp0ITtDsYsM/CE0YBo=;
        b=WcEb4JXjxuDfke4ImVF2+96afb8d5JLZnpg7d7yfil1V+1+dHjUPtGLgtpJNuEG1jb
         4V6zZNlDk0THi445U4/xihp5El6bm7yNFxxtGnqdtqBxOxvCQ2rsIdn8eJkn/CbjE2EM
         yx3tJLLFHrs68TZL98MWSlDR9meFAnGX7GKg4Dfdis77CZU+tFszOcCUbtiLjd7cw1rT
         XRM3flVoYzqrc8T+8rxkHIytJ37HhjleMlIZeMZP/6Mnms2auoubIC2AsGx9T/38CTjQ
         zWcYApl/VKL+RO9tVJJQDhJ0PWrZz6dw18Nk1/Hbuj2GWAaKYOmtqoN7qd7+J5Dq5hIY
         qs1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpf2v9TM67cZ0KyU9tvIyDmol+X21a6uRRZKpv++41ZhrjszKLHvH7q9HlYVrBoThqmTlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaaF6SwjmGz8K2u5PVmBz83CEqyExwHwt2xxsT7PtfY0RVI7+D
	1xZeW/mpa/gRcdcdbmo5l1YL6p+FFEyFLgfTWT33vpwXkAvgNm9t3/lVJ1TxZcYPm+zS7Oja2rp
	GZpxFXw==
X-Received: from pfbkq19.prod.google.com ([2002:a05:6a00:4b13:b0:849:145f:7ff1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3021:b0:842:4b88:20ee
 with SMTP id d2e1a72fcca58-84889721d40mr9009472b3a.44.1783959221968; Mon, 13
 Jul 2026 09:13:41 -0700 (PDT)
Date: Mon, 13 Jul 2026 09:13:41 -0700
In-Reply-To: <8c0c099d-47aa-4bf0-ab7a-c682b0dccdf5@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702142912.6395-1-alexandru.elisei@arm.com>
 <20260702142912.6395-2-alexandru.elisei@arm.com> <akwhexqW66RK5Gru@google.com>
 <ak0x0QIWWw6lFUiy@raptor> <8c0c099d-47aa-4bf0-ab7a-c682b0dccdf5@arm.com>
Message-ID: <alUOtUEe3EW1NlqI@google.com>
Subject: Re: [RFC PATCH 1/3] KVM: guest_memfd: Use memslot id to keep track of
 associated memslots
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david.hildenbrand@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, seiden@linux.ibm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	fuad.tabba@linux.dev, mark.rutland@arm.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 13, 2026, David Hildenbrand wrote:
> On 7/7/26 19:05, Alexandru Elisei wrote:
> > Hi Sean,
> > 
> > On Mon, Jul 06, 2026 at 02:43:23PM -0700, Sean Christopherson wrote:
> >> On Thu, Jul 02, 2026, Alexandru Elisei wrote:
> >>> To enable memslot operations, KVM maintains two arrays of memslots, and an
> >>> RCU pointer to the active (in use) array. Changes are made first to the
> >>> inactive array, and the RCU pointer is updated to point to the inactive
> >>> array, which becomes active.
> >>>
> >>> The guest_memfd file maintains an xarray of pointers to memslots that use
> >>> it as the memory provider. After the RCU pointer to the active memslots is
> >>> updated and until SRCU is synchronized, readers can observe the old or the
> >>> new value for the active array, and therefore the old or the new pointer
> >>> for a given memslot.  For memslot creation or deletion that is not an issue
> >>> for guest_memfd, as readers will either read the same memslot pointer saved
> >>> by the guest_memfd file, or a non-existing memslot.
> >>>
> >>> But when changing the flags for a memslot, readers can read two different
> >>> and non-NULL memslot pointers. 
> >>
> >> And?  Why does that matter?  KVM memslot updates aren't atomic.  Practically
> >> speaking, they _can't_ be made atomic. Userspace is required to quiesce all
> >> activity that must not observe inconsistent state, i.e. userspace must pause
> >> (stop running) vCPUs when performing a memslot update.
> > 
> > Is that true when KVM_MEM_LOG_DIRTY_PAGES is toggled for a memslot?
> 
> Good point.

Oh, right, that's "fine" because there's never an intermediate state where there's
an INVALID_SLOT.

> > As far as I can tell, KVM today tolerates VCPUs running while the
> > KVM_MEM_LOG_DIRTY_PAGES flags is being changed for a memslot. And by
> > tolarate I mean that VCPUs that are running when the flag is changed don't
> > return an error from KVM_RUN. If changing a memslot while VCPUs are running
> > were fatal, I would think that KVM would want to take vcpu->mutex for all
> > VCPUs to keep them from running. Or is it a case of KVM allowing userspace
> > to shoot themselves in the foot if they really want it?
> > 
> > When the KVM_MEM_LOG_DIRTY_PAGES flags is being changed, VCPUs handling a
> > guest fault can observe either the old memslot, with the old flags, or the
> > new memslot, with the flag changed, but they still continue running without
> > returning an error.
> 
> Staring at QEMU, kvm_log_start()+kvm_log_stop() do not call
> accel_ioctl_inhibit_begin() etc.
> 
> So at least QEMU does not force VCPUs out of KVM when only updating flags.

Yeah, as above, that should work, and KVM needs to maintain that support.

> One option would be to require user space to do that also when starting+stopping
> dirty page logging. (I'd assume that should work, but it might be tricky
> depending on in which context it is called from QEMU migration code -- whether
> we hold the BQL)
