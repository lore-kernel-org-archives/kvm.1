Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E6D2E2F1F
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284076; cv=pass; b=JoVxuXi1VEBHW7cBL6ta1bu+YmqFOtDpw+cFZZWRhvbqGhyOHZQQplpE4P39mZJU/QdDUyKKrMRQ68WDH0pUUY/XmLzwxN2C82TWTIucJoFAUvn/G08SWLwU1Tbi5OE7PKH9jPhcsbpovi8e5f9dUp3lsaPOOERujI6g0XVOAsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284076; c=relaxed/simple;
	bh=qQiJNamxvq/HKg+2DcbBfJZDz4xq8G4yBXbE6YWO298=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOw6d2g+QVsjoLDb8VPiLJKaluTMmvSk4Ky3fs4+woOmoKLFwJ6jBgN+iInAsB9wiCay56+5PuN9C2GOWun6BxBFs6ITKowbVvAQJ+Iu9jLvDo2xth2H+pfwBz7oCkYl3g7RHh6OtvkXNOAlUAMgw85iIx6J1FUdodY8MgbcjCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBRT6gnh; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBRT6gnh"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e61648f10so10421cf.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 06:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779284072; cv=none;
        d=google.com; s=arc-20240605;
        b=d2dtcrZEKXVd7LMEOCLZ/2/Y7BTMip/JU8poEcknOsNijcC8haz5/3Pyyk18OwXCdG
         1ItU1O1SE7qpTGMDt5KFQC30Gi/0EYZbu1tfMf+8E/lqv0DtcC7SCJ/TuUR3tC5+F4oP
         bfem10169h1AAyAg/h7k/hl2Bj8TvwsYkX8EUeGwrI/LN8HkDZBPD2rXs/CKZwcIXl8D
         3HHX8CLbfTZTJQDAqp8RsupZujmvOhGIX4NKgT86/5P5pC/0n+VMw4YtIfVyu5mq2RfZ
         iDCVhsFejaGTUhyEYuNNGVykN7AzxWGwXe2qOGOaRNY2OsHvz7AEPFqX6AwIXCbcWdbD
         OVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gg6EIejukVN1UskEcFFGr4CnqhwTYz/FF3EfBDzQQN0=;
        fh=J84YL1c5C8R9gbvCX7WeDzs//An3nY0Lh384ZKFYUmE=;
        b=UnbLZGBqNcp0b+GQhJRRX3XBMGK4zrZsOK9fGtukYSKdI3t733xy0gF5931qsQbSad
         zT/tuN/KAYLMBQP8zFdJhOSIfk5nXx83fsSbX1uD7nL8D6uc/8OU2SDOfCvdnLLBb2X4
         uz8aB+P4q+qSU8HwebmAuHJh8JxwNB7zd6OkK/HqC3w9Ab7F6zfkmu/cjeOhiu9/jS/R
         cKZqsRvSADLzng6CNh2Sxb+XRqv+8xd38bK5zBft2Rf/mLQMT2YKcCNuDff9SspLyAnW
         ckmGkbg6fjBFu0SwhA5qVneaHOYHvEPQefTKlY7/w3sktuf3FVTibsVe3LwgIMlFyK4e
         Inhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779284072; x=1779888872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gg6EIejukVN1UskEcFFGr4CnqhwTYz/FF3EfBDzQQN0=;
        b=ZBRT6gnhCXkmGh5E5RtdmLG01m9cbItQ+fVl69SplNV7tKGs61gKG5ulpXLXI3m0CV
         VqWRol0J7UEu6kw0wTYeDnN+bhK5PkKcjH4IZBDJu2QnESW3xcrRHKQ2NmeBb+e1z20y
         40TGM7LDeKzAVQk0C2z1InDN9opgFG0aYQ5pizLD3zEjBmXu75tCjgpzS9Dy8ZtoRAnd
         mseFVCUD2+xzRKgDKks5GSd74VjJhvBSzB+FU0Ij3tsu9TVKxjNcRfZ9s+XTod4gwuja
         f443+uL+BI0rx4m5EKNYjDSE3d/gPxIpxLnXDYygGkZmTghLORiiVzj/Vuc5sYqrnefo
         LX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284072; x=1779888872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg6EIejukVN1UskEcFFGr4CnqhwTYz/FF3EfBDzQQN0=;
        b=TlfzRBga5cyKCKTVnkqQfZd/NQOWYsXb3k7HaiUPOQlMuREx9FieNu9/+PR/A8Oh5m
         S2shgSXE35gtlp07aeL9/qZE+QhWuIewweKfOY7+s9aOhO/MFYv5iYI48fJE6RIBZHli
         TQeBow8jxp/RvNooYzd1NfoZNBzmznIFVHVntn2jT1BYLWEyaE36XONgBl3bncWlCaWw
         nWXDG4FWSZWocWs2cIYZ7JRW0Mzk8GJ4g2wgKLTWaWJjqUrduEk26megnFWMNpVwWWra
         tEwcc7CY0m5/dXW2K0JwlhyPLMekCURAjVxqkk1lq2Ep+Fdj/xXSDVfiLXfwiLPD6YN5
         sqPg==
X-Forwarded-Encrypted: i=1; AFNElJ8/1MS5DhuhaY7tXJ77hPl7DIEtEkYYd6BBLxqUNI7St4MEMLgtKCVaPWGE6XPAQPENtWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWgj4J4XY21py9YBIWct1ZKN5USKfDEpomJWHCVQlzgon3aNk
	01tCxv327d8sVBcuSFksn4sk8HAZd/yBExxGr97dNwojFkhCYSRckSi1NuPIzWdCMJ9k78BLp5L
	ywHb56MV2ZzA8sTdVR88dCJ6rN+9K+kW35HdY5lIu
X-Gm-Gg: Acq92OGLTo9SIVS0Z4tmm+41BkDBy2CO0dUhZtynCkNNvqA7MDbrh/o5tHePVeZT0X8
	kw4oYrIcBzlQnKq/OiFzk+SaARF3KzMu2ckUDIKmjLKwczSddOennKcFX3uFLJyUJFbJL/8TuoD
	R1QXOn6krdvaA2sNEUr98LqWZVnXAW+OVL3gsxO0CwPGyK9b8Eer14QiZXFLkwdJq7OyL7gWj7z
	jyhO9zkAsPPPccL51pquhvDagx8NeKZ65kyK6BVNLFfye8cTP/IzilxVqTwPe1UPE0C1pb3OBVG
	HUhC9gDrNDNsf5oi8qE=
X-Received: by 2002:a05:622a:1f18:b0:516:5709:45e5 with SMTP id
 d75a77b69052e-516794404famr42713051cf.14.1779284071144; Wed, 20 May 2026
 06:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-6-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-6-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 14:33:54 +0100
X-Gm-Features: AVHnY4LNSFj0RfEZst7XJ-H9igWv5oxnJFnr1A0Uux_hrTg7SmxNRLrzDdjcxpU
Message-ID: <CA+EHjTxvLU4XDPXDXYXXWJES1OFQgN8VTRLMgCCNMwBE6Hk8tQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/43] KVM: x86/mmu: Bug the VM if gmem attributes are
 queried to determine max mapping level
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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

On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> When the maximum mapping level is queried, KVM's MMU lock is held, and
> while the MMU lock is held, guest_memfd cannot take the
> filemap_invalidate_lock() to look up the current shared/private state of
> the gfn, for these reasons:
>
> + The MMU lock is a spinlock or rwlock and cannot be held while taking a
>   lock that can sleep.
> + In guest_memfd's code paths (such as truncate), the
>   filemap_invalidate_lock() is held while taking the MMU lock, and taking
>   the locks in reverse order would introduce a AB-BA deadlock.
>
> Currently, the maximum mapping level is only queried from guest_memfd in
> the process of recovering huge pages, if dirty logging is disabled on a
> memslot. Dirty logging is not currently supported for guest_memfd, and
> guest_memfd memslots also cannot be updated.
>
> For now, bug the VM if guest_memfd needs to be queried to determine the
> maximum mapping level. This guard can be removed if/when support is added.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a80a876ab4ad6..153bcc5369985 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3357,6 +3357,15 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
>                 max_level = fault->max_level;
>                 is_private = fault->is_private;
>         } else {
> +               /*
> +                * Memory attributes cannot be obtained from guest_memfd while
> +                * the MMU lock is held.
> +                */
> +               if (KVM_BUG_ON(static_call_query(__kvm_get_memory_attributes) ==
> +                              kvm_gmem_get_memory_attributes, kvm)) {
> +                       return 0;
> +               }
> +

This directly takes the address of kvm_gmem_get_memory_attributes,
which is only compiled if CONFIG_KVM_GUEST_MEMFD=y. This breaks
ARCH=i386.

Cheers,
/fuad

>                 max_level = PG_LEVEL_NUM;
>                 is_private = kvm_mem_is_private(kvm, gfn);
>         }
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
