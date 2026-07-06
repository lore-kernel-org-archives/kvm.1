Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D0347ECDD
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374205; cv=none; b=q+mAA91aIAz89xqQcgRKnD2SZksuZhwpM+f3s9/v+L8eUHluGBT/YxVjZLz5XzE/yybi2Y849ZjHu40TLOaBT5uq+WY4c8uOXI/FUaIMOqdI5XkdUikJGSo/sKSEvrv8iLMVM+xPa0ngXr40mR68KkH21P5PToAiZbydTX1QdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374205; c=relaxed/simple;
	bh=OAQhr3waP5J5O1KHcN/lUO1tFTqTArndt3VJbZ8eN/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EYgsR9dQxARC1hwL9yr7y2Hv9EcYCtYLXNA/N2xHK5bkTr3b9U1PIS7BCoxcSYpp2Xe6wIoFo4wADxCr+SVuDgGq03qfHgFWSIwPFrWVgJa0pqA6mUM++ytOomTee7noMKQ5UmUSPrF4mJVCv2kcC844Q6djHcdnZKkZv+8Ts7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PbHEx+2a; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbHEx+2a"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847ac21582cso3712495b3a.2
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 14:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783374204; x=1783979004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oafaChChcAwJSOuf1i0h67RyVsfw8NcuMZenVaI95Rk=;
        b=PbHEx+2a9tWSvnyjo4BgSKe2rep6KRLdcrTRbcRLNOS7AKM1k3POmunjYXb3OOCkbO
         89jYbPOJU1D34V1r2aqz4nqnhO7vXndpzkgJemPi/LmewZ5Qk7oJvJd9xy6bthoeF34X
         bfpLA5ZrNotqafioZmieyU02js+pGwyDl6suy85pmtQsnRdf4mf/JrLbDlWj3hJvJAp/
         Qw+1NwidQqqhXnz1ScjR5gsMUrFKIYN0H5UNubDFbuirSZuCFV5agf3Pl9MUKm/whVM7
         4u4lvJmKMLnzlfQBGVpoelmonyurRQxRdlm1nJFVeGFMKzh4kXJwDCt4VzJqRzBCSXCW
         VmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374204; x=1783979004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oafaChChcAwJSOuf1i0h67RyVsfw8NcuMZenVaI95Rk=;
        b=NRLM/yeuaMysr10iy7vxkqGZgiBMPXetBIXfn2hxw/N9JI9Sx1lT8MCErP1uCWyjfm
         YhSD8PCcOKxFcPvPslvuOAP/hQaIH/yuo81+8qQJ8/3kvhvgzChxAS0Rl/O1zxiOI0jH
         UURVjs+H+VkZuejbbCVg5kCgteI+nsrIRZnyNAc2+66nBt4VsSoaSIoulXeEJ0vepKxl
         yeK3e6z/1HGYop+cIWs6wo2kGbQVNQBeu4iN5WkHAsfpn6oA+7VHvNhIOOdOL0XRlMTy
         RHoGs+SDb+elHutC3HNrQF08zhV6/uu1k3wEtzXTO9XkiDciI4dU5MJwDPHOok3q1XQu
         KDbA==
X-Forwarded-Encrypted: i=1; AHgh+RoHUGBFiWDicLq+Nl2HM6ThjIuFbIzd6SzH5lYkmTILQwg5p7DjfHFxeQUbTlHXvL+y3ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFVRlkTQzmFqL7qgmsk8b+hMHDDuKSoGdk68SS0+qwM6uPxWO
	sxqf+hC2mMGcY8LxHNfooiOrdkFSze9fYsASiHp5mXWbcgrZjbXbSQ19HcSrfrof/TvYgJceRTL
	u9JqiGQ==
X-Received: from pgwa11.prod.google.com ([2002:a65:654b:0:b0:c99:d21a:f6cc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a383:b0:3bf:d1f9:b1d5
 with SMTP id adf61e73a8af0-3c08efad6fcmr2613875637.60.1783374203865; Mon, 06
 Jul 2026 14:43:23 -0700 (PDT)
Date: Mon, 6 Jul 2026 14:43:23 -0700
In-Reply-To: <20260702142912.6395-2-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702142912.6395-1-alexandru.elisei@arm.com> <20260702142912.6395-2-alexandru.elisei@arm.com>
Message-ID: <akwhexqW66RK5Gru@google.com>
Subject: Re: [RFC PATCH 1/3] KVM: guest_memfd: Use memslot id to keep track of
 associated memslots
From: Sean Christopherson <seanjc@google.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, david.hildenbrand@arm.com, 
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, seiden@linux.ibm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	fuad.tabba@linux.dev, mark.rutland@arm.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 02, 2026, Alexandru Elisei wrote:
> To enable memslot operations, KVM maintains two arrays of memslots, and an
> RCU pointer to the active (in use) array. Changes are made first to the
> inactive array, and the RCU pointer is updated to point to the inactive
> array, which becomes active.
> 
> The guest_memfd file maintains an xarray of pointers to memslots that use
> it as the memory provider. After the RCU pointer to the active memslots is
> updated and until SRCU is synchronized, readers can observe the old or the
> new value for the active array, and therefore the old or the new pointer
> for a given memslot.  For memslot creation or deletion that is not an issue
> for guest_memfd, as readers will either read the same memslot pointer saved
> by the guest_memfd file, or a non-existing memslot.
> 
> But when changing the flags for a memslot, readers can read two different
> and non-NULL memslot pointers. 

And?  Why does that matter?  KVM memslot updates aren't atomic.  Practically
speaking, they _can't_ be made atomic.  Userspace is required to quiesce all
activity that must not observe inconsistent state, i.e. userspace must pause
(stop running) vCPUs when performing a memslot update.

> Since there is no easy way to ensure that the memslot pointer that the
> guest_memfd stores is consistent with both views at the same time, modify how
> the guest_memfd file keeps track of the associated memslots: instead of
> storing the pointer directly, store the memslot id and address space id
> (as_id), and use that to reach the memslot in the active list of memslots.

I don't see how this changes anything.  Readers can still see the old or new
memslot depending on when kvm->memslots[] is derefenced.
