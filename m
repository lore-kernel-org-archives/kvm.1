Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9728D37CD5C
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918439; cv=none; b=JHrElKdH90GG6iFdzOD7bZuHxwWl1eIilMWccK2gXAO51tg6qSijgq9emG7/hdWB+WSS+QHBHSSn1db9vEsIj7hjIh2/wzYPzicuUcX6torYdjUnfmme0SVVmqr77cZql+F1W/h2p2gsFEZCDids36UWPqp6/eTTc3X54jELoKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918439; c=relaxed/simple;
	bh=mtle515uIyp+O7vElJnFWYGr1uuE1TQcAdjdXN5Vo4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EWCoBlGm7rx4l5EoSZp6FGZCk6DEpIBYn7H1N5kc0STpP3k2PecJyRqYPCGK9JTZiMoAKQgxbbUq9op7Zl9A6PuDuSCquCRUWRrJ+k0nMbYnpMm3QjQtH3NodaErtedcEXcS0yoSsZ18DxUxlAel0keUx5a3yf6EHCKZm7EgnYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=du7ybx56; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="du7ybx56"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca0d4fb061so9105945ad.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782918434; x=1783523234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=35ip1FXhxTsr49Tf+Elt4WaaVNO58PfZuNT2YrZrg5w=;
        b=du7ybx56GtUFlXWVU3O9LfpHYDV7/+pOAfpsOn3bikOwU9q6VYbpvER6Ii5TEfbid4
         cVGaR09SdjsrGJzsKmN/yk+v0FhRORty75rVyokNjzxK8TyhzUilW2xLkb2MgKmKPMCc
         AXL6zeLlvcL/k3UL1pnt14R02XyU25z7yY2LH3R0yT8o4mSPH07QIRNQ63+5HlF+6eNe
         Mee8dMbugJRGxgfV3FBChkSW8XFiQktTpoNkk2YpP4HWAnrfvv0FNB5p9iNhvlXcNi0s
         p2XwqZKe8gw2bF282V7CByNKa9hR9GbqUKZyqCWl8VM5fLHE9dY4omhI4shhIuROgFUV
         uEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918434; x=1783523234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35ip1FXhxTsr49Tf+Elt4WaaVNO58PfZuNT2YrZrg5w=;
        b=pn2ypYXeRXL9H/HWNnuKdvQaMWaRDPzOqw6dJsZWN+iBYr38Imu9Nt0OmhpYYQQ3Ea
         xiyCHt5tuwvIK6h+JdKNA0CPavRjOJj9MAsr66S7iaLwfGQmnKC/sXaMUIrxkIfXj1hT
         dnlAprjW+51A0aXYiZIUaAMvWPtUxhmQYouoVZLcgLyv+a+I4lwUwAB7VSQL+SZ4EUBV
         TH2y2uiKMRPwOimwqh0CpxHXlLcNBlp30oE29a6SdvKrB9+d1IvP8NqHdC2DeK7OXqGQ
         g9qKU5eZDe0uvhkjknVYXW6DdIrX2Yz8HuxG3sZi4tbk6ubw84KVJGdBWPG5LrVYqOJQ
         XSZA==
X-Forwarded-Encrypted: i=1; AHgh+RrlAZlG7PhP0gCYvK6UaOzEqlP9Im4GgnBOFRSEGOmnDRw2hox28Q9/Z8Qahiuu/1ALM5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPe4x70i+r+joOSt7S3J94OjcqfS9JWTzVbVWG+1Hne948szp1
	AzmT7ELOFSp2Datc2ty7dLj7dPrk4fpB5JR0yLpwhvhrfDri5TzEJuACyHhN4NfdIp7F2DaKFrv
	qNRpp9g==
X-Received: from plbl14.prod.google.com ([2002:a17:902:eb0e:b0:2b0:aef9:a5a2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c50:b0:2ca:e5c:7fcf
 with SMTP id d9443c01a7336-2ca7e654686mr23268045ad.3.1782918433131; Wed, 01
 Jul 2026 08:07:13 -0700 (PDT)
Date: Wed, 1 Jul 2026 08:07:12 -0700
In-Reply-To: <e5876e41-a11a-4d5e-958f-9e247c19d387@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-7-9d2959357853@google.com>
 <a1b06afb-af6e-4666-8c7d-990e7fa150fa@intel.com> <akP9Qv_IPVEh7GAB@google.com>
 <e5876e41-a11a-4d5e-958f-9e247c19d387@intel.com>
Message-ID: <akUtIDdRiU9YOr8-@google.com>
Subject: Re: [PATCH v8 07/46] KVM: Rename memory attribute APIs to prepare for
 in-place gmem conversion
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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

On Wed, Jul 01, 2026, Xiaoyao Li wrote:
> On 7/1/2026 1:30 AM, Sean Christopherson wrote:
> > On Tue, Jun 30, 2026, Xiaoyao Li wrote:
> > > On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> > > > -bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> > > > -				     unsigned long mask, unsigned long attrs);
> > > > +bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> > > > +					unsigned long mask, unsigned long attrs);
> > > >    bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
> > > >    					struct kvm_gfn_range *range);
> > > >    bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> > > 
> > > We have
> > > 
> > >   - kvm_pre_set_memory_attributes()
> > >   - kvm_arch_pre_set_memory_attributes()
> > >   - kvm_arch_post_set_memory_attributes()
> > 
> > Yeah, that's probably for the best.
> > 
> > > left, do they need to be renamed as well?
> > > 
> > > then the interesting one is kvm_vm_set_mem_attributes(), which contains "vm"
> > > already while it means "vm ioctl". Do we need to rename it to
> > > kvm_vm_set_vm_mem_attributes()?
> > 
> > I say "no" on this last one, the fact that the function is scoped to a VM ioctl
> > is enough to communicate that it applies to per-VM attributes.
> > 
> > Actually, since it's a local helper, we could go with kvm_set_vm_mem_attributes()
> > to be consistent with the other functions.  That just leaves
> > kvm_vm_ioctl_set_mem_attributes(), which I think it appropriately scoped.
> 
> If we finally choose to rename kvm_vm_set_mem_attributes() to
> kvm_set_vm_mem_attributes(), I think the trace
> trace_kvm_vm_set_mem_attributes() needs to be renamed to keep it consistent?

Ya, good catch!
