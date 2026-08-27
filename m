Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8843909B7
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864046; cv=none; b=gwuoHN4OjSK/985Pg50HVVcrCnw5Uz1O9/4GvPopmOqrOYhFMaA9RnT7t+NAnS8fp/XXaBJIe5+03NzNoiviJim++iAeqsjWLbtxUCzmc7uZwaC9FTCO9X6/1B5GxWZxJUT5ZhRJy6VnODYncrcrPPjfGisgGt0Umfq5aBWHhxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864046; c=relaxed/simple;
	bh=584T2Fi+jYdHnPMPryAzdeyBmBsauq81+2zQRXO51LQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cm1SxGAzJwq5P8A0M04VU5He8MsZpXIISY3QEAYhbJU+Qk2CQgF8KhBvLSAerBj33uGUg6Ho8Cxpdu3cFYPtLe0zmLercKRxIN41UGkfmh3WabsUtxGMdiTcy1CwyNZxDsoG5ZUGkYY4L3TKNNqHPE+eZ7MssLpiFNkaNZQ0xic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDhHjzQU; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDhHjzQU"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-855f662439aso672674b3a.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 13:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787864044; x=1788468844; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZEfQxTOKQyDG0uZqNyCVnRw0wmiuuoqTc9XyRDn+pn0=;
        b=NDhHjzQUvh3ExnAjwNkVIJFwsPZcmuA2IniGkFO/nza1s9PQ7UM+5SBSybByx8jfzC
         9H76VzzIzoNit3xu/+s7pMEmDNzD/0TaoOmS3lzHmaCl3jnT0cx350Cy2zY2AKZARIdx
         UuaaQUkt10uQ2St3MJ7eZcVmDbXDw+4NTJFh8pjHVBgXnTfepFdpYbWWoX0PWX9/asJN
         Fq+Bvtpe7qZpck9RIc+q76+2w3yqqe5rKZsboxBBolUEN2/nSmQjxLRV6Iv0be9wYMUH
         FAx9lcKQxR5EtlqPw+mnJ4X/uuVyLHwt7LvL7KWV7uzVe5Cu4MOsoGK6wumcbonDoEFQ
         Sq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787864044; x=1788468844;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZEfQxTOKQyDG0uZqNyCVnRw0wmiuuoqTc9XyRDn+pn0=;
        b=QMSr/Ig5vpUSgoz7eHHkLEtWDDrpC82gMwrcrBBfYYj5IRmD8qCpVHAIg3NDABJh7N
         g53uiMCuRF4mTcXBST/KaPYS5GGGPw+WDFIJHnvJxfJoO3UEUnOifCkNbmuz5uh5QXA5
         xIZdSjR38jJW371SGsIMgKA9B9R9EKGehGfbES4kDj6U3V6/aA6e7r1elCF2tGBT+eWQ
         hkZ+3tw++3VCKdnaiyc4B2/5gTJc193oHqPcynX92BkToWBmZ34TDXcY8Ilv5DuiPIvl
         1dDWXHr6f8HWYuNt4S1T1Y30xLSjznT1ChoCd3wdJEmuS6tODX6Cfho9mUeNM+pCNzkc
         +HrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rozan9OauVPp7jpnROLPdbK0pwEaQLzkpzXPpdAija2XGN6rKVPSAEDmQuLUwN7ee3kZ9s=@vger.kernel.org
X-Gm-Message-State: AFuF++nnJMqCzIPFJCegzILR6ZhQFqCDF56kgfFlsSu68kmiRuoaE02Y
	amNo72DzvVFgth9T+ktRajE4+4pCGxZL3UcOEMbPF9YHSoo+T+hDu9k99oCc/N+ZsAOZUx2HPIT
	bGfy+dQ==
X-Received: from pfbkr16.prod.google.com ([2002:a05:6a00:4b50:b0:848:5480:9ac7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:e09:b0:851:fb36:a702
 with SMTP id d2e1a72fcca58-85629f09cc5mr4062708b3a.9.1787864043380; Thu, 27
 Aug 2026 13:54:03 -0700 (PDT)
Date: Thu, 27 Aug 2026 13:54:02 -0700
In-Reply-To: <ztufznh6v5md5cn56t7pvokubvbpc3yki6dhiilgebb5uq3ju3@aa4xc6wwte5r>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
 <20260826-gmem-inplace-conversion-v11-15-0a15d8a799aa@google.com>
 <ao9CKMXAX-hScRSa@google.com> <mtbqvvvpwbzybgy6z47lwui6ag53kyubub3hkczui7u72zxesl@lnwsglrgwl5p>
 <ao9px1j7CLYXMiGP@google.com> <ztufznh6v5md5cn56t7pvokubvbpc3yki6dhiilgebb5uq3ju3@aa4xc6wwte5r>
Message-ID: <apCj6gz8x24Dkle8@google.com>
Subject: Re: [PATCH v11 15/46] KVM: guest_memfd: Call arch make_shared
 callback for to-shared conversion
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 26, 2026, Michael Roth wrote:
> On Wed, Aug 26, 2026 at 03:33:43PM -0700, Sean Christopherson wrote:
> > > So there's real performance differences here but it's sort of been
> > > addressed through a solution that offers additional performance
> > > benefits on top so there's no longer as much to be gained here I think.
> > 
> > Or another way to look at it, eager conversion would allow QEMU to drop its
> > workaround.
> 
> True, for SNP at least, but pre-map is nice too, and not really gmem's
> place, so most likely KVM_PRE_FAULT_MEMORY would remain regardless.

Hmm, good point.  And as below, we can't sanely avoid the check in kvm_gmem_get_pfn()
without reintroducing the preparation tracking, so the lazy approach is probably
the best option at this point.

> > To be clear, I'm a-ok with the code as-is, I just want to make sure we document
> > exactly why we're choosing this implementation.
> 
> Agreed. My understanding of the current design choice is basically that
> it doesn't *need* to happen here, since kvm_gmem_get_pfn() will already
> trigger it on-demand when it is actually needed (or not), and that tends
> to happen at fault time when other platforms like TDX handle it. 

Oh, this jogged my memory.  For out-of-place conversion, waiting until
kvm_gmem_get_pfn() to update the RMP makes sense because KVM doesn't know whether
or not the SHARED backing as been allocated, and can't easily get at it in the
first place.

> To handle it differently would be to go out of our way to make SNP special in
> this flow in exchange for performance, 

Not really?  We'd still need kvm_gmem_get_pfn() to update the RMP to handle PFNs
that were never explicitly converted.  Either that or KVM would have to preallocate
everything (ewww).
