Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769CB4028C1
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374415; cv=pass; b=DyFIqMBA2pqwWBh3NvnH424u5g18v7G+matqIml/u8Gk1ZOMwItqx+iOM2FyozeSpIU38zOanUaKoHYSI7zO9EcgCZJBZfcGszsGRPYdsPM2YIMnKC16zAqXQh+aOfCC0RN+dIEUTL5ajLSvme+eUJCOMoJak1iA4j+//L++Bu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374415; c=relaxed/simple;
	bh=RPARozcT6UfC6sMpVhy6r4Aiv8XaW0DBJyjeK/ufCb4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpH5eG+gCcMJ9hilPohU2DtqlkxMWL8VxL3EmhXAKXECl6UHUNzL9tXSAOB3aUzIgNCRoKhjO5hyOiFt3zjPrzgLqxmmyKk3KFrdVb8LcPqmt4G3JCpviCelyoBxLJdpMhbeIywEBs8IrZxLPCMAlWnfJR7isVrsMQVSV4zO7KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V9p0GPMM; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V9p0GPMM"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-631ca15d35aso5560590137.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 07:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779374412; cv=none;
        d=google.com; s=arc-20240605;
        b=f1+YvfM3lo7q9Uw9vYqK9rkrUniFMP8jJvKmqARJ4Rx/MxCDl4t57W7vcQMbVKCtxG
         aKlLocTIK/TEEzVKA4+loZRz3vZb0fny9gKw1jgtLhsZrlFTIyZUk2a2q6z4tEt8y4t5
         /JmxkTyvEd82I+6dfqxvN4nM6TSl5iMx+nEGdb4EY6AoxajWwCw/wu7/WHkUebmbCkES
         cyihbn2agKwvZChS8GVgGg1ldFG93YpDW54By6zAB8tOhzDwaFTNMcOpTgNHCRE9RXEu
         5p9m+LSp2c1v+8GWryXl3eBLeQwynDcZYPCUBJBtN+1/XFq/MvST+DEpgrSPwxvgmlQz
         5Ptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=pETZ8fM2HZBGp3r6phdANPEwcKJJ9mevi9pfUImaGvM=;
        fh=gqffxSJdkMpM2TcQ1sv7Mxf2apfnll2W5bsrVLxUrVU=;
        b=KGRlsiXt5Ao1dS8XLQrDId8EIPpx2QdJad/nLpvdxJ3GHY2fakbKwogsQKqNs8FuK2
         tmF0ZdFOKJ8B1j2G31Mz60r4mk+ohdeqO452Hk9nNDf8aLwfYNfp8kwlRkWkIlKGuyPh
         ssXZ0ErRkP+R5vxjBMZVvFYypPZMlV2SIXubf7jaSrXKoiV4d2CggnklsfJSPgbuqsVp
         00Iv1O6CSCetSVl6iwnMRXw9oC9pBbbjvqU9eQ6+PJZZqR1EJhMLFvN24HXduZRq8iSl
         2KPsp2qriIpe42042vVCZeG88PSPiHcdxcNOj6UZ7dl5z4WxVKyaM2EHjunCyyGj+TxR
         nY7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779374412; x=1779979212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pETZ8fM2HZBGp3r6phdANPEwcKJJ9mevi9pfUImaGvM=;
        b=V9p0GPMM4JoAoxY0vDgPfychMd8I2dNla96qYqWgPvlZ0DjapntWlKuDNmOjfW+/XW
         +IMGiGnTtURerCqRqPJQrpRxyxBf/qdaQIONZqce1kHnH+9efXUw0bi5zweZjavzLg53
         DLSTVoI/XsPLkgdTjBzww57u0BKReUP3QNqC6y9NxCJ4uigCAAqF1xD1Ckt2XEbuX4lO
         i9MRjTpHgb+xv7cdKHe9yZJ8ko17HPICKtxup56MY8yixmjhhW5iItr94mePc3x+Dpm1
         KM2Z+jwV41cHy6IulePecYceVwzzuxIUO1BCOuDRt+se4qKkmsh/i9pwQ0urySguHFzV
         GvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374412; x=1779979212;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pETZ8fM2HZBGp3r6phdANPEwcKJJ9mevi9pfUImaGvM=;
        b=i1oQx8Zfgx/0EaqOSZb6sRAWLtDA/AJByt7Y7tvaYevVF+saCElSE9KLjXNdykjxT2
         cicxNrRljj9mPOrGWR1x5cZa3vI9T+AA8PzUHEZ201hneJPiCxZjAPRjhjo6Q3CQHeAg
         vbfeZj0jS0geYZKruLDQqCFhc4Fy/JwBHZv9QkOZhBF5ZOQvh+sQWdkM5qUsd800NyjN
         GPGlNRILe3XjcxJvpnuYWcxCBvEiHpRCEIIq9hqHuRX+3IcjPlXbGfl/AZSA467YsTu5
         NwP5aAf3B4AiZGyrDJj/D4UU6F369qpkzFvU2hkjSDs/A+hN8/AwPwF2BnHib/1W7QLs
         E5Vg==
X-Forwarded-Encrypted: i=1; AFNElJ9+iei5ecm9z0r3HYkThdQft6qZ7AjWgLnr+ZlbrhMfhtL9ZtDHEw7lZhAiBRhj7OEjMHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKg40UHERfLSF8NszrrlFjHrCicL+Kvv5ZvLU+BzO0GkojcZ7r
	KNqDZjyQQ/vABV059yoB1mLc+4h4kzhj5n+fYrVxl4A337u0S4/gkGibfOgvm+jA/tQmsOk6txu
	oouXLDt1V6888QS355kY3fuqpmNm7X4e9lN1QZUKe
X-Gm-Gg: Acq92OGrYPEKiveQab8MyNh4gbt8dHY2/p/W+asPnPP2KE+D+Gd10HjnHebtUXzfGww
	nUwPzAbwsuafrzk3feDWEkaKcRiAub7yKaIbDo/zPEUP+GFHACdroYZhzeGrhpoNDhCeOykyvw4
	AfFeuHAreR7rRLbM3Ve/1CLqjLMIbqon82YRDX2p8sCJXFPGP14nKZUcp+PzWTA3FemQDJvp0At
	uDwxXxruVxyHpDlWPHYneUIRWCu6tjan7Jq0P3l9fazifWUnuxZMY8/1s+krgIQ1StO72nMZrbc
	b5uLiLOek/tmncD8SDWLenvOoMJFe+5ey5PWU1vl4zileC4n6Q==
X-Received: by 2002:a05:6102:52f:b0:634:248f:bc04 with SMTP id
 ada2fe7eead31-673cbd0ce21mr1147276137.10.1779374411627; Thu, 21 May 2026
 07:40:11 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 07:40:10 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 07:40:10 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ag8BmtzxTlcuA_zy@google.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-16-91ab5a8b19a4@google.com>
 <CA+EHjTxcadguOfOo7RpJVtAzcY5JAFZTbrAT_wcN6akMi8gCUg@mail.gmail.com> <ag8BmtzxTlcuA_zy@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 May 2026 07:40:10 -0700
X-Gm-Features: AVHnY4KEEzPCaNbBUek3sDUc3FN_Enrlvw5CRgr6BoNKh9-pt1QUYC334HSuCXU
Message-ID: <CAEvNRgGDL=_XO3z=h2RLqb_gZFe9QtxwiMFJHCzQY3HEoaUfHg@mail.gmail.com>
Subject: Re: [PATCH v6 16/43] KVM: guest_memfd: Use actual size for
 invalidation in kvm_gmem_release()
To: Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
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
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
> --- virt/kvm/guest_memfd.c
> +++ virt/kvm/guest_memfd.c
> @@ -640,9 +640,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
>  }
>
>  int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> -                 unsigned int fd, loff_t offset)
> +                 unsigned int fd, u64 offset)
>  {
> -       loff_t size = slot->npages << PAGE_SHIFT;
> +       u64 size = slot->npages << PAGE_SHIFT;
>         unsigned long start, end;
>         struct gmem_file *f;
>         struct inode *inode;
>

My mental model was:

+ offsets => loff_t
+ indices => pgoff_t
+ sizes => size_t

But looks like loff_t is more suitable for places where return values
(possibly negative) matter.

Good to go with u64!

> [...snip...]
>
