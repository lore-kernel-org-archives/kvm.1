Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9AC4BB26C
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056239; cv=none; b=Qf115LUeFzjGLsgqoowznHMxM1a9LgE/iFjO1LB+VtLDe5yb+RFKig+Jif+rxN1UNDeGVMQGJp6gTbQTIx5ZyTV4aOfYPYh4d7COlhnE1vBWjsJTMd+RMV6iqLoow/a8wrcCcElkpmzeHMpqZreSeZNLrN3BmIrx2bEeY9fs9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056239; c=relaxed/simple;
	bh=AHkASD+KT9hovr17X9EfCxN+oDA7ZS7vi9iIUeCFVhs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tQV5uaTZgJNPaihupdmbow8IQMdxvIYeudks7anyGnOq4TFcVmDR8zRWBd4hJADcGZBHY3tgnlLeFgoxD7qW4nHklOdYMMp6tQRfELF1mEQU34zo+1iNjacJ9vXEwlHJWpgT38ocW1vmBvjKbbf3e5qb4rj+PptsN/4sWmtTmMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iuhY13a8; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuhY13a8"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c89704da8c7so2576a12.0
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789056237; x=1789661037; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PjpQmguvZKqFc40yaCCUF9DxHpcHtd3drRjNMUjWpE8=;
        b=iuhY13a80KGseO7HZmuA3y94fmHZB0TSKy1X56JoxJyaiXkGKyG10ot87xmhbpxJP6
         W8fA5QrJKRypQSa+l9BxY//kK8JoC6TiQnGWZr9E3EoWzmtEplTg30Ke8A/yT2pXivDv
         6b8B4rJf2oLbGheKWXq54phZ3mmC8j8fjWTLtjPFl0QezZRlrU0G6x6gr7eqOM4SwiOK
         kij6G5FSKnBbmQcXWtfwFby5h8YCVznkRdrXf9Ce6oGz75L1eb25lEoOSirVkGdN2PKO
         DOIoP2NXZX1D80e9v01orGBOtvq5EfCzmZpnzN2kVluOH8O29+1M24CNDR5Dn8H2mXdL
         Pnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056237; x=1789661037;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PjpQmguvZKqFc40yaCCUF9DxHpcHtd3drRjNMUjWpE8=;
        b=AvTjju38DIs0EBSA4MYdMZ55X8xS59FwL7b29Ih1Ccnq4HpdpRwwNYou4ed9J7xtzF
         yynvZWFVcatxJX72q3rHej66oemzbxiPjXAIvk/FjsblAcM/Vycz+x6Zaw3Ed+gayeXI
         NASJzCLm5aNaqbbGHotfXlMXBLH3rC5GeGhjk6k5np3ZMcAj1+XMcYAj2UlyV6J+x+UU
         yQEYFh/6mjYL5ZXof9L0kThZ24I1XqU7EXVJZqhRTVgj3AUvDOaKNTJ7eTCn3JZvUORg
         axrYjafGUxpyFKdynCCspRxFzW7njg/1qNK1T4AdN2/K6BVzkBnMxxsGU85Y5Xvsrd/R
         ZE4g==
X-Forwarded-Encrypted: i=1; AKwUvBy6u5Q99o6BfCjhtjYU7TrWZvwuDZZzXhpabBCYlE05U9oowb8d3bF0N0z2DQN2Fxjg1Cs=@vger.kernel.org
X-Gm-Message-State: AFuF++l0G0Vk1v06k4zYYWNYIfXRqKGHJKWhebQ/jJzWJGdBEVLpTLwy
	GJc2dtDvVC3GI8UUqdi2PRC5L4lTz0EhOlmaIrG6/iy4L26gRzUC9eN4XPHcN9YZIgf5I1mUtNx
	I4VVlnQ==
X-Received: from pgmh20.prod.google.com ([2002:a63:5754:0:b0:cc4:3b01:7730])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4303:b0:3c3:7179:a640
 with SMTP id adf61e73a8af0-3dacbd6e061mr12520616637.3.1789056236336; Thu, 10
 Sep 2026 09:03:56 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:03:55 -0700
In-Reply-To: <20260905011956.GA856309@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <anphyjFv3FhF61iB@google.com> <2vxzpkzo51wg.fsf@kernel.org>
 <anssOQFNZ2LfihbU@google.com> <2vxzik5f311e.fsf@kernel.org>
 <anyObKiZIhfok5mk@google.com> <2vxzqzjz1x5f.fsf@kernel.org>
 <aoMcqp0gr06YXAPU@google.com> <2vxzy0e3zgqz.fsf@kernel.org>
 <aoSCCTTBn9D5hqzk@google.com> <20260905011956.GA856309@nvidia.com>
Message-ID: <aqLU653FXjJjhbop@google.com>
Subject: Re: [PATCH v4 05/11] KVM: LUO: Support VM preservation across live updates
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>, ackerleytng@google.com, 
	fuad.tabba@linux.dev, Andrew Morton <akpm@linux-foundation.org>, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	linux-kselftest@vger.kernel.org, andre.przywara@arm.com, michael.roth@amd.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, will@kernel.org, 
	vannapurve@google.com, maz@kernel.org, fvdl@google.com, kvm@vger.kernel.org, 
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, alexandru.elisei@arm.com, 
	skhawaja@google.com, aneesh.kumar@kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, kexec@lists.infradead.org, 
	suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 04, 2026, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2026 at 09:02:17AM -0700, Sean Christopherson wrote:
> > The rule is thou shalt not break userspace.  Whether or not the
> > breakage is the result of an explicit ABI change is irrelevant.
> 
> I argued strongly for this simpler approach, I will write here the
> reasoning I gave.
> 
> Firstly, "live update" is not uABI per-say. It is not "userspace
> breaking", and it is not a "regression". It is an internal kernel
> mechanism to allow the kernel to self-upgrade. In the industry it is
> typical any of these hitless update/patch/etc schemes to only work
> between a few tightly controlled version pairs.
> 
> Asking upstream to carry a full matrix of every single version pair
> ever released is massive over-engineering and cost on upstream
> maintainers. Refusing to do this is not a uABI breakage, it is not a
> regression, it is simply a lack of a feature.
> 
> I think upstream should start by agreeing to only support forward
> going upgrades within a single stable branch. If live update becomes a
> success then maybe we could do from a stable branch to the immediate
> next stable branch too. I don't know.

From that perspective, what I am proposing actually goes a step further.  I'm
saying don't commit to supporting *any* specific versions in upstream.  Express
the feature requirements in the serialization payloads, and let userspace sort
out what kernels are compatible based on their actual usage.  The kernel may need
to provide additional discovery mechanisms, e.g. so that userspace can probe to
see what is supported, but discovery is usually fairly simple to implement and
maintain.

> This alone is already much more powerful than live patching.
> 
> The balancing issue here is the impact on the kernel subsystems
> adopting luo. Every time you change anything about the internal
> function of the subystem you now have to go test a massive version
> pair matrix to make sure everything works? No thanks.

No, the subsystem just needs to make sure that it serializes its data using the
defined ABI (where ABI here means the format of the payload and the meaning of
any flags in the header).  That should be *easier* for maintainers to handle than
trying to support arbitrary versions, because it eliminates subjectivity and
having to make judgment calls or remember magic version numbers.

> Luo is very invasive and a huge PITA at the best of times. It doesn't
> need to be even worse.
> 
> > It's probably fine for Google and other large companies that tightly
> > control their kernels and use cases, and have the resources to
> > juggle the resulting complexity, e.g. have kernel engineers on staff
> > to track feature and dependencies, coordinate and plan kernel
> > upgrades, etc.
> 
> Every downstream that wants to support luo is going to necessarily
> severely restrict the version pairs that can work. Like a RH type
> distro may only support it for 9.1.x -> 9.1.x+1 - they can carry the
> cost of figuring out how to manage their patching and compatability
> matrix on their own with the tools upstream provides.
> 
> > engineers on staff to help them thread the needle you describe
> > above.  And if supporting live update as a general feature for all
> > users of the kernel isn't being factored into design considerations,
> > then that needs to change, otherwise this is all dead in the water.
> 
> General uses can use upstream and do CVE upgrades within a single
> stable branch. That's good enough, lets start there. We don't need to
> boil the ocean.

We're in violent agreement on this point, I think we just disagree on how to
express compatibility.

> > I also don't see the point.  Maintaining a rigid save/restore ABI is
> > annoying, but it's not _hard_ (or at least, not _that_ hard),
> > especially if there's a set
> 
> I was told KVM had the smallest luo footprint of everything, so
> perhaps your perspective is different.

Only because KVM already has a massive ABI surface for save/restore.  If you
want to convince me that magic version numbers are the right approach, then show
me how KVM's existing save/restore support would be made "better" and easier to
maintain by throwing away all of KVM's save/restore uAPI and replacing it with a
versioning scheme.

> In other places luo becomes coupled to the internal datastructures of
> the kernel, we literally have to preserve lots of kernel memory
> utterly unchanged without any kind of serialization at all. 

Have to, or choose to?  I have a very, very hard time believing that it's infeasible
to define a serialization format that is decoupled from kernel internals.

> This inevitably creates restrictions on the evolution of the kernel in
> general if we can no longer change in-kernel architecture because it would
> make some data structure incompatible with a kernel 10 years old.

Only if the relevant subsystem defined a poor save/restore ABI in the first place.

> There is also a need for *downgrade*. Meaning the N+1 kernel has to
> strictly emulate the limitations and capabilities of the N kernel so
> it can be rolled back. Can you imagine the nightmare of trying to
> codify the feature progression for every single kernel release forever
> in some impossible scheme to enable this? Again, no thanks.
> 
> So, what upstream can reasonably do, that still provides real value
> without severely burdening every subsystem, is upgrades within a
> stable kernel branch only.
> 
> If some distro or CSP wants to do more, they can deal with it. They
> have a far, far simpler problem because they can exactly lock down
> their version pairs to a very small universe. They don't need a single
> kernel that can emulate 10 different releases of behaviors
> concurrently.
> 
> Jason
