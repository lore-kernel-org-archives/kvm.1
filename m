Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702FF492532
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922171; cv=none; b=rJ6qupL4xUxudn83gMNcGoJHLEbBnF3yL9anFcgreHQTd10Sgs9Q85qGplHGep+4lhl2br00EU3zPXH1E9Ww76fw5PuosU4hgttlT9kf5HKjwynCiYFoNUvxoX+7S/8FDg94qyeS5aZAG3c1rBJ4Xe7oKjDZF089VUp51HM20D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922171; c=relaxed/simple;
	bh=PZdjWM7sO+nieQyt0RiywxeCxZBtDRu0HUNeH72ZpVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oPXTbYr0knxOkmnubmQ5IpUXOTaAbYJgia/eiLRxyUqv0u6wq9wJLHJXiSn5VI8EV8nH3vVoOoS/uvUTeCFAqSJEUjcubYO0PtMWIWw/d8CNOw5N5HogO+wpe2JYuqCzyuabwfT4ekUbbMgA6p67EbsQeUsShPXm/8jORMit5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRheYWg2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRheYWg2"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-38096457d3aso983739a91.2
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782922170; x=1783526970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fb46jkRTl6zwGFz7DUfAUgbXgotI+sXKJjyrZvcz3JQ=;
        b=FRheYWg2+u/d6OdGw/gZUSY4H+/LH75+ctJGPzMkU/tbBN4cCcXKUE1OcjKZtsfb1M
         iVfLOhqxBH5zcx5m5J0LTdF9aVN4C1Gyn0LqUUKGoF9vc/Mi1t1kjQYispMayc2KY7Gf
         0ulidEQv0PQAAQv6BXZ1wM53CtD+DeamxWtom/lwTspHqvO1CgqJjzbH4NT9DTMkSKzM
         5s9VQXqtK4IPMhFNVtep3D0WK/+0S3DhNJnWXnZe9XsH2ogomSSf7/0KgNk3lO+RDih9
         5zH2AzlbWhClTZPEOZ3yZ+JlOJeYo4a2veXdHLgrELGHHEHFRO8PYqY6f9MHFvylj7wo
         FM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782922170; x=1783526970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fb46jkRTl6zwGFz7DUfAUgbXgotI+sXKJjyrZvcz3JQ=;
        b=Au7RXIezDaQDMvWumkpjX99vf7Cmh4ffQQc5595cV91QAcFQ1P3zsOLxsgIlIRZuzk
         A57UAa5FAjDfzvSOpBFLZijZVgeBTPQxSrUJMm7dpRdir3DYCv7WG43K9j4vak9pO8Ks
         mhTeCNuS3jqDl0fjoGsnA0gl6flXEZtMtojmbw5W/G9UyuSZVgdHtmqDbQhTvGuv6o9e
         c36tvE2MmGHXMb2gWxkzuOohMT9Jm2WOJoO8DWkOsofOpeQ7OBlNq43ovnhTS8anvmlu
         VwN+G0zV5+0w9K+yJLDpEZsaDS1mnqEU4bm01C9bAGjISjma79/zXcHWQS6nJwY5WO8f
         TCIQ==
X-Forwarded-Encrypted: i=1; AHgh+RozeKiQCNYRnCipve+Prajao6NsIHRNOXAoHCTYkv7kF3rF2UJvLtuV+cuQh1OBORS02FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxcD3VF3Q7NBjI3h5cm4CbVLsF23+7n9wE+9nq2KGYLEFUNrzl
	xTQMX3+K5xqMJXU4wlcoIHgptST4m1haWocmvGKEyFlJwN2qWxC2XX8doDu9ZdyTcqHR56qPpH5
	Z9NGloA==
X-Received: from pjbnl12.prod.google.com ([2002:a17:90b:384c:b0:380:8669:e33b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c03:b0:37f:9ce3:ca96
 with SMTP id 98e67ed59e1d1-380aa20dab8mr1881109a91.31.1782922169200; Wed, 01
 Jul 2026 09:09:29 -0700 (PDT)
Date: Wed, 1 Jul 2026 09:09:28 -0700
In-Reply-To: <584a8f9a-1538-4f8b-b576-75ef0fa961c7@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-17-9d2959357853@google.com> <584a8f9a-1538-4f8b-b576-75ef0fa961c7@intel.com>
Message-ID: <akU7uAKb5E_Tklx-@google.com>
Subject: Re: [PATCH v8 17/46] KVM: guest_memfd: Advertise KVM_SET_MEMORY_ATTRIBUTES2
 ioctl
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
> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> > @@ -4969,6 +4973,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
> >   		return 1;
> >   	case KVM_CAP_GUEST_MEMFD_FLAGS:
> >   		return kvm_gmem_get_supported_flags(kvm);
> > +	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
> > +		if (!gmem_in_place_conversion || !kvm_supports_private_mem(kvm))
> > +			return 0;
> > +
> > +		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
> >   #endif
> >   	default:
> >   		break;
> 
> this looks inconsistent with the
> 
> 	case KVM_SET_MEMORY_ATTRIBUTES2:
> 		if (!gmem_in_place_conversion)
> 			return -ENOTTY;
> 
> Well, the check of
> 
> 	if (!kvm_arch_has_private_mem(f->kvm))
> 		return -EINVAL;
> 
> is buried in the following kvm_gmem_set_attributes(). How about moving of
> kvm_arch_has_private_mem() check to put it along with
> gmem_in_place_conversion check in kvm_gmem_ioctl() in Patch 13?

Me confused, patch 13 already adds the kvm_arch_has_private_mem() in
kvm_gmem_set_attributes().

That said, the ordering here is wonky and misleading.  A cursory read of the series
would make one think that waiting to advertise KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES
makes it safe/ok for KVM to plumb in support for KVM_SET_MEMORY_ATTRIBUTES2 over
multiple patches.  But that's not actually true, because the ioctl becomes live
the instant the code exists, userspace doesn't need to wait for KVM to formally
advertise support.

To further confuse matters, it is actually safe/ok to iteratively add support,
because it's all effectively dead code until "Let userspace disable per-VM mem
attributes, enable per-gmem attributes".

So, I think we should go a step further than what I think Xiaoyao is suggesting,
and fully squash patch 17 into patch 13.  That way the reader doesn't have to jump
through as many mental hoops to piece together what is happening.  It'll obviously
be a bigger patch, but should be easier to review/understand overall.

Oh, and that combined patch should carve out error_offset straightaway, so that
the full uAPI can be reviewed in a single patch.
