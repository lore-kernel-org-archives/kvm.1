Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593C3BB139
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281730; cv=none; b=lET800Kr7XprS3lvOevRgdzttFNXZBTRreLcD3J3X3dHor5TssTEkw3M4EPwlDgU4SFpQBbtE9BHx9b9MZepPN+Yg1or0FdkKugy/w521NAKEOLlE78Rfz5a+kvB9+Qk7BwWwbTt6/0FzSLV12KuL1LKPezIyXUwGRe1L89E6uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281730; c=relaxed/simple;
	bh=zyDPxDpwrJ6mXcvcfoZMBiWiKpkImZ5DV0yRuJYpDG8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n44YGsUAkVGZcT/mFSfl+oUo62t+QqRzJEOFpJjGb3hAadI3Y1mEn76bX+phpZWbrHomsFbunNX3Usy9tlWWm+DXDIIE0N8Yazuzp95xemmADGu2J13CIjSlcNelIYe5bsD1QlTDP+rGyqvrCq1XCArsR+h/JPUQzOdKvPZFkd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTsVJBxJ; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTsVJBxJ"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc73f47bdcso6844545ad.3
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785281728; x=1785886528; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=khuCcB6aPgDehmywSb3PygGc+LK+56JfFL0yArTKlXo=;
        b=XTsVJBxJwuU0qf4HtJghhXARLAmmQyI+tOAEdFHgDrYoLXu1wrYMq78RtPkINA8gAo
         UMAoGv0+yrhsEdpGCEzMS8og4IFhR+MHWFYzXTqxE7ny8NEZeG9BBVBjEU3itg1S+X1x
         45gYXbKi3zWrL5FpsWXQWe2XCgOAzHY1+ezjEH/Th423M/XLBU5G5DHTdUCXB24mTghS
         mcOBF9F7FW3ZBJC25ayBz0RVtV7GU6YoHXGAem5NV6G2MA2CrN2joY88iu5zLazNTjll
         aPPNjnohAURSIWynA500ZQIqr/XH44V13bvbs2VHGgl/nis/8EaHeiyVpJhuovkohuts
         hz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281728; x=1785886528;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=khuCcB6aPgDehmywSb3PygGc+LK+56JfFL0yArTKlXo=;
        b=Eaf+ffBbwtxOtuboEbsGDgYRfCPQTenxQ0NuuHh1br2WEZnDqGujJi/v4KHD7yyKWr
         3K2akuM1E9LHHJmFmrLBURk/fDi0UdncXBdMJMtcSQAms1r4pZMvljqQoEC5d2Vs6irN
         T+ptqp9GKB+gCrU8UrBgvhicC21cmwse1eyYxqxIzrjTjEkXa7WM5F5+4kftr3ch00aG
         4KZ3joA+lM+Q84+fUG1X1CZS6Hl/2BrXD7IZMWg6XnAH812MKmfZlEFxe8h4JzcA1U/f
         cFzDSRFuEmh8NoC0f3maDK17OQfMvyyNAw9UjmcqacDimAxNjzdFe98dbUZ7z8w7zmlS
         Ao4Q==
X-Forwarded-Encrypted: i=1; AHgh+RqRZQHAWqqKSGYOcY3MlYzQNsedV+d4toFl/OOHuckbCn7PahZmyzKM3/6sEcchcR3/4oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMIfe8VP7CC70cFzwpXm9zYI7i+kRrRUTycnZcoKWokWzzvyoH
	2etoC/s/uWOmWJbnecn/LZH4I416e30htB47vAWdGFuxAENhgU8zjDFdPryfFRCqh8CX4GP/0y/
	77VglrA==
X-Received: from plblk16.prod.google.com ([2002:a17:903:8d0:b0:2ca:d820:b697])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1745:b0:2ca:1479:d9dc
 with SMTP id d9443c01a7336-2d015a5f10dmr49972745ad.12.1785281727982; Tue, 28
 Jul 2026 16:35:27 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:35:27 -0700
In-Reply-To: <5a03c9c8-09b1-42fa-a086-63734aa17f6d@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707183405.15571-1-zide.chen@intel.com> <20260707183405.15571-5-zide.chen@intel.com>
 <amkC3aR32DMkjdzH@google.com> <5a03c9c8-09b1-42fa-a086-63734aa17f6d@intel.com>
Message-ID: <amk8v8Vx3KyM5c7D@google.com>
Subject: Re: [PATCH 04/15] KVM: x86/pmu: Add PMC bitmap accessor helpers
From: Sean Christopherson <seanjc@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 28, 2026, Zide Chen wrote:
> On 7/28/2026 2:28 PM, Sean Christopherson wrote:
> > On Tue, Jul 07, 2026, Zide Chen wrote:
> >> @@ -120,6 +146,17 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
> >>  			continue;				\
> >>  		else						\
> >>  
> >> +/*
> >> + * @mask must be an lvalue of type unsigned long because for_each_set_bit()
> >> + * takes its address.
> >> + *
> >> + * @type is token-pasted into KVM_MAX_NR_##type##_COUNTERS to match one of the
> >> + * counter defines, e.g. GP, FIXED, AMD_GP, INTEL_GP, or INTEL_FIXED. This
> >> + * reflects what KVM supports, not the underlying host's PMU capabilities.
> >> + */
> >> +#define kvm_for_each_set_pmc_idx(i, mask, type)		\
> >> +	for_each_set_bit((i), &(mask), KVM_MAX_NR_##type##_COUNTERS)
> > 
> > 
> > Provide dedciated macros instead of requiring the caller to pass in a type and
> > then doing token pasting, e.g.
> > 
> >   #define kvm_for_each_gp_counter()
> > 
> >   #define kvm_for_each_fixed_counter()
> 
> Do you mean having only two macros, and using
> KVM_MAX_NR_{GP,FIXED}_COUNTERS for Intel, AMD, and the common PMU code?
> 
> That should work, since all_valid_pmc_mask64 is already constrained by
> KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_COUNTERS, so iterating up to
> KVM_MAX_NR_{GP,FIXED}_COUNTERS would be safe.

Yep, exactly.
