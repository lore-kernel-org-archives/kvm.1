Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE9292B2E
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779921802; cv=none; b=H2UAQ3M5RY7Ir/Q11o7mdfgvNvAvz0PI1NLD/jdCx/Tz4tlZhnDPXJg2Xxww26MbjaXfZignhmaVnrYRUSbuteREYfLTCYLNRzlobQWIHCblVhwN3C/eNWNa+QpFsIgQLJkO7wkbY/CakxUnJMOXm+FtaS2GriWmTgl9JeTzSgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779921802; c=relaxed/simple;
	bh=M2uIm2jED4+3dlkYBLLjgxfKzRcbFG9jIjgsHVHOBqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EmJFUGBf0EeakHWOaUC54+IaoFww9biL/i86Z5Q/m1y7hLsxlnT7uyhCozm4i+CUlYI/O9Lhk4/YmkZYkBY6lLwNGaNuuv2rYahg01C4bhi9XawKuZvU7BB8PJV+lyMQNzn01tIef20uiSGb6XeTQY7dqaKwpWvDhdzYBEpAhnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNxUYnFe; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNxUYnFe"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828659ecd4so5378418a12.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779921800; x=1780526600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FsmNkE2VI4iLm41l9qqqzl3T9LuJhEB/kk53DiCik+w=;
        b=fNxUYnFeOtBSKYR9ovFT6qeXVHaFffPFLmf6V7fw94+/pCf7MoxF/cZ2UqKBG6GWkc
         nKWla1bAfxcx7Y9gDBN6xf+gYNHAzC7f5zLDzgOHOjXO37hWhK5fOtRnSdaHcUdmFG4b
         Kc2KXunA88IK0jmSmIP4ng/Faa57IKLFA84pwab8UatsBVrjcv3YzRwxhrqLYqeOOoiH
         Jn314Qyo23Ir0MxsoROLRVb7PSm483HbiYssu4Po+ViTpsgS4veV+xcAh518U2BePhln
         5SQNbsT207hhu/PP5A60ypE4WQEsO+WGQADJaCtLOZ6So1F2hwvvEuizuWLm/5Wnf41D
         D7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779921800; x=1780526600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsmNkE2VI4iLm41l9qqqzl3T9LuJhEB/kk53DiCik+w=;
        b=EZu2U3d/GMQLtZE3gSz6wxWomQp104murotQmzv/ll6pD+D+L85rrzYaRHGphP4/um
         ukqnorUlMAfEo8jc62pjPXCyIOJtm1YK1Aj/EBSNXG9dpREhKp+Een64tL6ympkwJ/rm
         9O/5DXAcZz2mFHF2GgDYdI6N3T7UmS5n9Ltm+AztqgvuhLtewu3EVbnTw+vDviO63Tel
         Brhf5SdKTGc7Qc1NgkuXmib1vF84iYGa2Vq1ug0KTjcaSoE2ZYdrWVi6LRfDhVe3WBY5
         DRy5pScgvpnLOtRucCMnJzmYT87y+RtgUrdpYxxSiHo86ugON51HsSJlJQfza3WVLdwq
         dUqw==
X-Forwarded-Encrypted: i=1; AFNElJ/gxszYn8KBC/1RCd0/8wx3dU2Pd/N3pwzuR/PnZ30iLFXy9kheps0LIQwsudoFFlmx3Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP839zvTPDs6bZJcBbUz6j+vCnABhdu8aXwsz5sgUrKCQV1LzZ
	hP7HyoAWCQPW5vXNt9NaaxODEP/4kqtctujj2Z5ogb+SFlh/Ku7DUDvDF0tUj3m7YTwFwFj8k8I
	SbWUY5w==
X-Received: from pgtk13.prod.google.com ([2002:a65:68cd:0:b0:c76:1d9:8c20])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7486:b0:3aa:f2c7:fd87
 with SMTP id adf61e73a8af0-3b328e53f98mr25116032637.31.1779921799970; Wed, 27
 May 2026 15:43:19 -0700 (PDT)
Date: Wed, 27 May 2026 15:43:19 -0700
In-Reply-To: <CAEvNRgHnxEO+jXqEKuewiDgFBDQDSr68A8MnJJSyf9K5AgbwWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com>
 <20260522-fix-sev-gmem-post-populate-v2-3-3f196bfad5a1@google.com>
 <ahXMzPz1cQl6kZge@google.com> <CAEvNRgHnxEO+jXqEKuewiDgFBDQDSr68A8MnJJSyf9K5AgbwWg@mail.gmail.com>
Message-ID: <ahdzh8yzbpX7OKwn@google.com>
Subject: Re: [PATCH v2 3/5] KVM: guest_memfd: Handle errors from
 xa_store_range() when binding
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > On Fri, May 22, 2026, Ackerley Tng wrote:
> > If @entry is non-NULL, xa_store_range() pre-creates the entire range, before
> > storing anything into the range:
> >
> > 		if (entry) {
> > 			unsigned int order = BITS_PER_LONG;
> > 			if (last + 1)
> > 				order = __ffs(last + 1);
> > 			xas_set_order(&xas, last, order);
> > 			xas_create(&xas, true);
> > 			if (xas_error(&xas))
> > 				goto unlock;
> > 		}
> >
> 
> xa_store_range() doesn't actually always iterate: if last + 1 is some
> clean power of 2, it'll create a higher order xarray node.
> 
> Otherwise, it falls back to creating and storing 1 index/node at a time:

Ugh, _that's_ what the code is doing?  Argh, I missed that "first" is incremented
by whatever the batch size happened to be.

			first += xas_size(&xas);  <====
		} while (first <= last);

> if the above did manage to create an xarray node, xas_error() returns
> false, it goes on to the store below.
> 
> > Yes, the API handles failure on the subsequent xas_store(), but I can't imagine
> > that failure is actually, barring garbage input from KVM:
> >
> > 		do {
> > 			xas_set_range(&xas, first, last);
> > 			xas_store(&xas, entry);
> > 			if (xas_error(&xas))
> > 				goto unlock;
> > 			first += xas_size(&xas);
> > 		} while (first <= last);
> >
> 
> So if a later xas_create() fails because it runs out of memory, the
> earlier stores would have already been committed.
> 
> This ignores -EEXIST being returned since earlier in kvm_gmem_bind()
> conflicts were already checked.
> 
> > Purely from a design perspective, providing an API that can fail partway through
> > under normal operation, with no indication of where failure occured (AFAICT),
> > would be awful.
> >
> 
> Do you mean the API of xas_store_range()? 

No, I mean xa_store_range().  AFAICT, on failure, it doesn't actually communicate
"where" failure occurred.  That's quite nasty.

> xas is updated by xas_set_range() so that should track the last store. Since
> the cleanup is storing NULLs and won't allocate, I thought it would be fine
> to just store NULL on the entire range on error.

Yeah, it's totally fine, and AFAICT the only remotely sane approach.
