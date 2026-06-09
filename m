Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8A48A2B0
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025924; cv=none; b=Try17qQmVeBS5O1pu5vWs/cM46MzVxdidsKEfLizGof99MpV0N7aQSoDMUYVLhwfd09BvQh9xeAAPsdDSdU4t1e/9BNrYlqBsauh9Rw/yIovt5pijeDw3MHQNY5HMORqWo1xBQztmVmYdyyl3XLN/88XrR0fN/lyQ2KbipiyInc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025924; c=relaxed/simple;
	bh=cjcUvzdRGdxlss2/NkgrO5BRaYoQUp200DFsYha5Hho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ivH1cmkrJKkDVdDBhQX4+aK1j9GhcBYD7Xbt1Wjqg9/nu1siEAZ/eC655ReuIlcS3VHZYvp1EaAnZl2vrBCDRFMFFPJnuNSIJtHvpcbx695Ww7h07Ehb+nOvuTpBf3cpXYgdgHYA/jJAHmbfxo3UOLOoTNWGq80FMXUZaNk/hlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tORur+FF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tORur+FF"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf3636d6c0so61103595ad.2
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781025923; x=1781630723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FJIfFml9xJHnFlAX2RfQU7Hfb6zKqk7REAop/9naib4=;
        b=tORur+FFJBBvyu+rXl5LGtHbL+oYmbPEKJVCOq96uBOCdXwrWfPA1xbcheUH0T9nSp
         HbyHcvALbab4NgDAMWuHjnmMwkKQEXIujwLyUVWMyfZQKm/4yz94lxAVZJSRVzmZlaft
         f3L3LJL+jo6ll9766ZkfgmtVavRC/3MCYCZ3XmYpYZisNPbBShZi7fybs8ccl5pYvc4q
         ppItgm1rx5Dzp9pf1Eis046d7IZTuzhC7hKjrxQ1S4RkSm63Om98H0B1ZaQcntQ09wWz
         P3Mf0+KgbiyDoceJRm3ehvV3AgxG0NfikbxtR0IlFoij4JNa6PG7fTxgmAP0ONBWqwbV
         qgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025923; x=1781630723;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJIfFml9xJHnFlAX2RfQU7Hfb6zKqk7REAop/9naib4=;
        b=U+v32M7wUv++dsFF6Nqp+I5h+wb1mOyJqaqROQUTVqYCeGS6N4FFO3SBu+GK2uv5dE
         AOhRLrgJ1ze5vW/50xecapMQJBltnr1sWjmva0u8pMdpmnnjJFTwctDIk/ht/f3JcM5/
         oOnYi5uG8j+vcH+oV6qKjvGrjJsUSCIVASTIsUmBXvY4/QBfgDRq2orS5UKDLDQNVj4A
         tamsMB/bE5Q5foolw5bLDsLZ1yJfli1IOc3Ixj2ey3lYz5ihDcXb4K81Lrn3Ie4K3NAG
         h5FYl6pPpLTelvCIqQO1S74GgplYoWLxy0CfGaasV2WzS60nYgPcSyXOqyEp3PRO4kQP
         tvCg==
X-Forwarded-Encrypted: i=1; AFNElJ9CeUzyJeBQkg+tLzmxalvIT0cO4jI8deIvPMnYKfC4HONxTqmi8VY4uRboCHsX7yKdn20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2uVpApUuuXZOfuK00sAFhNgBWSiURGA7ZaM1c7N4uJx+oO5o+
	0se9cZ7fRPp2t0RJAXUPi/F/lFOy5QTGpF7mPLXsAM8veMe4VR+2W9PT4jeKNkXaj4w+Q0S7kG0
	7WHGPtA==
X-Received: from plbay2.prod.google.com ([2002:a17:902:8b82:b0:2be:b2c1:9921])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5d2:b0:2c0:c625:4019
 with SMTP id d9443c01a7336-2c1e810bd13mr257594215ad.25.1781025922685; Tue, 09
 Jun 2026 10:25:22 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:25:22 -0700
In-Reply-To: <aifPUFncRYYpURL1@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113232229.1698886-1-seanjc@google.com> <aRsIstNXu0Bl0oID@yzhao56-desk.sh.intel.com>
 <aiDCkz9V2aS5Qcuf@google.com> <aiKJt5j6vIqfh7S9@yzhao56-desk.sh.intel.com>
 <aidvQyD6BqbE2_A5@google.com> <aifPUFncRYYpURL1@yzhao56-desk.sh.intel.com>
Message-ID: <aihMgs0Zj4kS7YWv@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Elaborate on how release() vs.
 get_pfn() is safe against UAF
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 09, 2026, Yan Zhao wrote:
> On Mon, Jun 08, 2026 at 06:41:23PM -0700, Sean Christopherson wrote:
> > On Fri, Jun 05, 2026, Yan Zhao wrote:
> > In kvm_gmem_get_pfn(), because slots_lock isn't held, this could happen if
> > kvm_set_memory_region() didn't synchronize_srcu().
> >  
> >   CPU0                                    CPU1
> >   kvm_gmem_get_pfn()                     
> >     f = X (from slot->gmem.file)
> > 
> >                                           kvm_gmem_release())
> >                                             slot->gmem.file = NULL
> > 
> >
> >                                           kvm_set_memory_region()
> >                                             slot deleted
> >
> >                                           kvm_set_memory_region()
> >                                             slot created
> >                                             slot->gmem.file = f (alloc the same object)
> > 
> >   get_file_active()
> >     file = f
> >     file_reloaded = f
> >   <KVM does weird things with an old memslot+file> 
> > 
> > Obviously KVM would be wildly broken for other reasons, but just saying
> > get_file_active() takes care of everything is misleading because it only handles
> > reallocation of the object, it doesn't guarantee a reference to the correct file
> > was obtained.
> Ok. Thanks for the explanation. I get your point now.
> 
> My previous confusion came from the fact that if kvm_set_memory_region() does
> not wait for all users of the slot being deleted to exit the SRCU read critical
> section before committing the slot deletion, KVM would be wildly broken
> regardless of whether gmem is released.
> 
> > E.g. AFAICT, users of get_mm_exe_file() don't care if they race with
> > replace_mm_exe_file(), they only care that they have a reference to a live file.
> > 
> > KVM on the other hand cares that kvm_gmem_get_pfn() gets the exact file that is
> > associated with its memslot point.
> If slot->gmem.file can be set back to a non-null value without the memslot first
> being deleted, synchronize_srcu() in release() isn't required, right?
> 
>   CPU0                                    CPU1
>   kvm_gmem_get_pfn()                     
>     f = X (from slot->gmem.file)
> 
>                                           kvm_gmem_release())
>                                             slot->gmem.file = NULL
> 
>                                            kvm_set_memory_region()
>                                              slot->gmem.file = f (alloc the same object)
>  
>    get_file_active()
>      file = f
>      file_reloaded = f
> 
>    <KVM proceeds here should be fine with slot + new file> 

Not really?  There are no guarantees that the old slot and new slot have the same
GPA range and the same gfn=>gmem bindings.  E.g. __kvm_gmem_get_pfn() could get
invoked with an out-of-range index, or worse could provide the wrong pfn due to
computing .

It's kind of an impossible question to answer though, because it's sooo far down
a hypothetical path where a KVM bug basically means all bets are off.
