Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1627D3F926D
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374064; cv=none; b=nzOIgAeLi9vLigqMdl/NRXizT97gBqAZ4ZlvfdpjSGNbt7ZeUN99lZwJdnlgL1QUR5WKE3n0B+WBpBfwp7LVrWozJM1HkTZ5gd8dZmo4x5FIlPk3SWAgt9jO7Ztty3G7l85TG06Y8EqSX3NOBHRuJ+kAeMLDWbldTOE1aA4wjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374064; c=relaxed/simple;
	bh=5qqRAv89nnapnboqyF9PWAGC9EirWJivtNWwArhN4cQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OOIRKKO10HvgZR4YeVKw4NE7OpwMmEf70ka6cGbI5Hu98qLO6A/g0312yxWtdXLTc3euU4pfzMctZIYRpS6qw1/7LXgacwBkYs5lLwbn54ZaXV2zAAtqCsDiHFVvDl7LXhDmoPZ5JYdIdTfYQO/G4G80r/0aqFzSQJO5IdOkR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GY1qmaSg; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GY1qmaSg"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso3439143a91.0
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786374062; x=1786978862; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSKxDjTci2S5HKL2Y8g6gVb9b+tAUX3tfJowR2dLyss=;
        b=GY1qmaSgYhJ/va/G3NzUGSUY4GjFkNC5gVWgR52RyXRFIla9wsw85stzdjcd+hmMcy
         zLCqHbtmx3TJqIGl8yr54N5EMuBwbnqLVaV14QKiR8nwktJv5i118q0UTHDpnHF6XR/K
         iYHbJGDMMzaFyHzRuB9FJq9ZxEgcH+O5xUGd72oJyZN+H+Z1XDxUnTfG5N4Kt36gZ7na
         hrgyE1k0sHC/ft9jP4e3SZFa1KU7fFrV1S4Z4krC6WvT3O6y0T0aUns1ith7sKpoGzuO
         mN6dU4XpMCjGBKje760lNsVfIAwjYLVAYc8zCc7m++g8uIq4H5awukmFXthbCFoJdux1
         F7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786374062; x=1786978862;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qSKxDjTci2S5HKL2Y8g6gVb9b+tAUX3tfJowR2dLyss=;
        b=hUW6f/Ze/ITHWtLZkPGJOTy5bP77Z0svrW/NxD0qs3FdKKscCIolOpVvx5GSSp+BHt
         1fuBpySgY9x5TUJPE381tKOcx0OsudW+T5VC9Gc5suvOHVy4UU55InB0hPDYgRiQP8tZ
         qmUupElmA4E5KmrN+zdGXF7Eqp1DRgv22YqwwY2D3fa0R91jXt5R6BGD9aQWSxS3YxOC
         RBxn4uANsloukcCFEzKItYYdCmMcxlQ1fGc2sIrwACy8boRhfgrvmQ3r10dv+4stEAge
         SInF3P81PWqN9hUCSD57UJG0vnemgbrVU3jPkF7O6y9FCXSbRgGaswLTi3Dp+H0NI3j9
         GvLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rod5Jn8oii/dIpn6pmUxau6gkPwolqjuTBZrahvmxt4HjXtV4lIwaB9ZW/xEsncJ1VlEZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPxPNJNzQinhjWWO6U4OwUpyAUHNtqcuudhJQxRHFfEDorBoZm
	+cqpKm0L3VKhPzHmG47ipgjNftCj2J3HokwisFnSGxDC40l+6n1j1OWhVM50JrIbqma/BzV5AP8
	i2QGh8g==
X-Received: from pjuo6.prod.google.com ([2002:a17:90a:d206:b0:381:2921:e696])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1347:b0:38e:9045:babe
 with SMTP id 98e67ed59e1d1-392823376d5mr23283260a91.7.1786374060881; Mon, 10
 Aug 2026 08:01:00 -0700 (PDT)
Date: Mon, 10 Aug 2026 08:01:00 -0700
In-Reply-To: <ed483d25-d908-4248-b8c7-862dd35dc6d4@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-7-2fc18ee6d3ba@google.com> <ed483d25-d908-4248-b8c7-862dd35dc6d4@kernel.org>
Message-ID: <annnrGR1noVuBkCc@google.com>
Subject: Re: [PATCH v10 07/41] KVM: guest_memfd: Stub in ability to enable
 in-place shared<=>private conversion
From: Sean Christopherson <seanjc@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 10, 2026, David Hildenbrand (Arm) wrote:
> On 8/7/26 23:52, Ackerley Tng via B4 Relay wrote:
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 65fbce46b63f4..9477ecebbbced 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -2580,6 +2580,8 @@ static inline bool kvm_vm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> >  #endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
> >  
> >  #ifdef kvm_arch_has_private_mem
> > +extern bool gmem_in_place_conversion;
> 
> Is there a "supports/has/enable" in there? And should we call it "kvm_gmem" for
> completeness?

It's kinda stupid and definitely more than a bit inconsistent, but overall I think
I actually like "gmem_in_place_conversion" the best.

gmem_has_in_place_conversion and gmem_supports_in_place_conversion are misleading
because it's not just that guest_memfd has/supports in-place conversion, it's that
that KVM is tracking PRIVATE in guest_memfd and so in-place conversion is the only
option.

On the other hand, while gmem_in_place_conversion_enabled is better, it's not
quite accurate either because userspace isn't strictly required to do in-place
conversion.

As for a kvm_ prefix, IMO gmem_ is sufficient for a namespace, and not having kvm_
is consistent with most module params in KVM.

So I 100% agree this is an odd name and has all kinds of inconsistenties, but all
in all I actually like the vagueness and the brevity.

> >  typedef bool (kvm_mem_is_private_t)(struct kvm *kvm, gfn_t gfn);
> >  DECLARE_STATIC_CALL(__kvm_mem_is_private, kvm_mem_is_private_t);
> >  
> > @@ -2588,6 +2590,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> >  	return static_call(__kvm_mem_is_private)(kvm, gfn);
> >  }
> >  #else
> > +#define gmem_in_place_conversion false
> > +
> >  static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> >  {
> >  	return false;
> > @@ -2595,6 +2599,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> >  #endif /* kvm_arch_has_private_mem */
> >  
> >  #ifdef CONFIG_KVM_GUEST_MEMFD
> > +bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn);
> 
> As mentioned in v9, the name is confusing.
> 
> 	kvm_gmem_mem_is_private
> 
> ?

Ya, +1 to kvm_gmem_mem_is_private.
