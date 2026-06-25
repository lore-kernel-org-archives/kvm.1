Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF63E5A30
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398192; cv=none; b=IuJFZz/twA434o4XBxCG/xUfrlXPEZ1u1SOCe4cDlpTCaxIzTujFhKqAxXStDSQPWAJuux1SknKN+M5ZNbxp/YYJzdV6dzLmaczZqH2nUizsp9ayF3dZh4GMG/FrVOswfbxdPH3qycluT2+Omx4Wuy5Wqm+kjlJRaZFR4X0uZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398192; c=relaxed/simple;
	bh=3+XZ1J9Fg+1riF/ZK2t4KROucxsp3psGgRCdBaJ8GJ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I9sO6Kx2S0hbPgAcGG+rcj0R150oCddTS/ZRndix/Rsgu7EPSSAPejx0bEFzf9A1/nUWVgU3L/Wh6fgnXchSQn6cfL6FR9XRauiRunGSs+f6EVp/FCI3XhaiAWyDFCQkRyDmrkMNLdWXbIZsniA04ibDcAyGGW6AUX7twntYLVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUdtCqpF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUdtCqpF"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c7cfa17fe6so33436215ad.3
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782398190; x=1783002990; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIUA7CCwzOR/KQalR5wXJaS4YlQ6wVTBXf5qStDGhQA=;
        b=BUdtCqpFrVuO54RRwTYEcrsvhIUuxrvxDrpmxcm2EMCvUmA0JSDY3HC0IkiCaEQQ3D
         s1toFDMmabfeYBtudJdfXb3yr/OGVZpoRIwYQtA6/UUCFEEFWDit8fggsoukYQkBGXDl
         lQcL2MVgUpkN/nFi5wHesxoDBDc17qTVtWfPPJoEGTNuDCeU6oq9LZZPBiopULGwYy54
         ++C2+vHio8El68jCD0QZQHVaLsHt8mdEyVXnnrrW3JKfOVmm0fSOQbSOUB/F6PLyC9h0
         /YxcgHiqIEbOabu9PkzcC0y2JFjz39PJy2Pa4f+lxsWEjIik3M4aYH/bvFQjxN0mU+oS
         89UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782398190; x=1783002990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIUA7CCwzOR/KQalR5wXJaS4YlQ6wVTBXf5qStDGhQA=;
        b=G/098gM1s8sL5mJzjKxuGhNnOpjwr3jU0XxQ6IbM9sULMs8rNulEGqnI/V2hlKyD9v
         5s2JJZtnC7Qlz0STZsMo1FvVA2boTe7aTjghP0TO/WNzR3EjNcdGU6jjzrDT+DzMpZal
         libGMqaiDmjnnU8XyPF6NzGsz1vDoqq0qhLkof58k/SYG8QDEqhXJ+PTAqIy3nChGcoH
         BjA6c/0ktIhCkdTVSvg5vdNKYFr3b9vemPvKrH5jGLWcM78ZYwiFbR25tFCXPPXXGv/s
         GCsbtsl3rbbk/H8+bxBEsduWDsgbByzU//kQ/YnGVDg81Fvqx2DxV1qORyhtXf4kzWeN
         vT7A==
X-Forwarded-Encrypted: i=1; AHgh+RpCaLBdfbqnEzqyF1nyyzo7h5ef6OtValAze4gIyNSzTmJHYNvw7AIQsckCS4Kr46VorRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT6N1tAPbPag+3shT6/C90LQyJrFrPijG3Zifocc0oBFyV/42a
	ddqu5J4KmVI07yAo03OJUjKxOIaArRCLgEzTdbBfgwML9mdyWmpsEq9gpNwfyEnu8RADuVD6dPq
	YFU2G5A==
X-Received: from plpb15.prod.google.com ([2002:a17:902:d60f:b0:2bd:a0e6:1a81])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2304:b0:2c0:d91d:c3e8
 with SMTP id d9443c01a7336-2c7fc65423emr29366505ad.4.1782398189481; Thu, 25
 Jun 2026 07:36:29 -0700 (PDT)
Date: Thu, 25 Jun 2026 07:36:28 -0700
In-Reply-To: <aj0Jf30PS2f7x1nt@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-24-9d2959357853@google.com>
 <aji/2svhcc84rn5w@yzhao56-desk.sh.intel.com> <CAEvNRgHYTFnHbsLLgMTCSitmnp1_j9Pomikm9qmpGTh1w8YE5Q@mail.gmail.com>
 <ajx5Vrz9ma--hrGH@google.com> <ajyJhZcgfYFtGfS2@yzhao56-desk.sh.intel.com> <aj0Jf30PS2f7x1nt@yzhao56-desk.sh.intel.com>
Message-ID: <aj087H1UWSFxbShR@google.com>
Subject: Re: [PATCH v8 24/46] KVM: guest_memfd: Make in-place conversion the default\
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 25, 2026, Yan Zhao wrote:
> On Thu, Jun 25, 2026 at 09:51:01AM +0800, Yan Zhao wrote:
> > On Wed, Jun 24, 2026 at 05:41:58PM -0700, Sean Christopherson wrote:
> > > On Wed, Jun 24, 2026, Ackerley Tng wrote:
> > > > Yan Zhao <yan.y.zhao@intel.com> writes:
> > > > > With gmem_in_place_conversion=true, userspace can create guest_memfd without the
> > > > > MMAP flag. In such cases, shared memory is allocated from different backends.
> > > > > This means this module parameter only enables per-gmem memory attribute and does
> > > > > not guarantee that gmem in-place conversion will actually occur.
> > > 
> > > KVM module params are pretty much always about what KVM supports, not what is
> > > guaranteed to happen.
> > > 
> > >   - enable_mmio_caching doesn't guarantee there will actually be MMIO SPTEs,
> > >     because maybe the guest never accesses emulated MMIO.
> > >   - enable_pmu doesn't guarantee VMs will get a PMU, because userspace may elect
> > >     not to advertise one.
> > >   - and so on and so forth...
> > > 
> > > Yes, there's a small mental jump to get from "KVM supports in-place conversion"
> > > to "I need to set memory attributes on the guest_memfd instance, not the VM",
> > > but I don't see that as a big hurdle, certainly not in the long term.  And once
> > > the VMM code is written, I really do think most people are going to care about
> > > whether or not KVM supports in-place conversion, not where PRIVATE is tracked.
> > Sorry, I just saw this mail after posting my reply in [1].
> > 
> > I'm ok with gmem_in_place_conversion=true just means KVM supports in-place
> > conversion, while we can still create VMs with shared memory not from gmem.
> Or what about "allow_gmem_in_place_conversion" ?

No, because turning on the param also disallows setting PRIVATE in the VM-scoped
KVM_SET_MEMORY_ATTRIBUTES ioctl.

> > Though it still feels a bit odd to require TDX huge pages to depend on
> > gmem_in_place_conversion=true when shared memory is not currently allocated
> > from gmem, 

I fully expect that to be a transient state, and in all likelihood not something
that is *ever* shipped in production.  Landing TDX hugepages without guest_memfd
hugepage support is all about avoiding unnecessary serialization of series and
features that aren't strictly dependent on each other.

> > it should become more natural over time once gmem supports in-place
> > conversions for huge page.

Yes, and I want to prioritize the steady state for end users, not the in-progress
state for developers.  Once all of this settles out, I fully expect the majority
of deployments to only support in-place conversion, at which point the end user
is only going to care whether or not in-place conversion is enabled in KVM, not
the subtle detail that it's still possible to do out-of-place conversions (and
that will always hold true, it's not like VMA-based memslots are being deprecated).

> > Besides my current usage, there may be other scenarios where gmem memory
> > attributes is preferred without allocating shared memory from gmem.
> > (e.g., PAGE.ADD from a temp extra shared source memory).
> > 
> > For such use cases, I'm concerns that the admins may find it confusing if they
> > enable gmem_in_place_conversion but still observe extra memory consumptions for
> > shared memory.

KVM can help with documentation, but beyond that, it's not KVM's problem to solve.
If a VMM *and* platform owner chooses to deploy a setup that utilizes out-of-place
conversions, then it's on the VMM and/or plaform owner to understand and communicate
the implications to the end user.

And I'm not remotely convinced that prepending allow_ to the param will help
end users diagnose "unexpected" memory consumption, in quotes because anyone that
is deploying a stack that utilizes out-of-place conversion absolutely needs to
understand and plan for the additional memory consumption.  I.e. if the memory
consumption is "unexpected" to the end user, they likely have far bigger problems.
