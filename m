Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7741D121
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163267; cv=none; b=qUPX1PoP0TLQQ34TNmA7zQryRPh+hbT/4M3qohYG3SnJS3OrozNThRUd2CTGQP5xCiFKHnW9cQYJ73Ou0kOYoVsVQL+QAPiMtNx2U3KSs/OW46N0d5fht+zFImxsOyuoX3YHaa3E2XIM+BcnZ/AaU0emksfGc8o8VOudEHIwASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163267; c=relaxed/simple;
	bh=FwoRJEo2GmoAnZxW9PPSlo80tUhyFRNiNZkZkdykbUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LjN1ZtDHXvxK8LRn9+UKoKAmHpVYW/KpGMbP2ETVDPNAPkp4syg46e9Wv/EOluR4StO7uBtRGQGqOmGCPAwgNWYg06pgpi8gz11kQ2fcTuBgjqvESbhz1N3mvO69AHJTcu0qIRjDpeIFHpzS3+fgO+CmVIpyaWzLnlxZuKgX+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YlK8E0jF; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YlK8E0jF"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc640dfde3so37873115ad.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 07:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785163266; x=1785768066; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7pArl8q168UcAovCWpIP50BcVQynTGjSIcRYIXI9vrA=;
        b=YlK8E0jFkAdVK7qVIMlfbDgcGO4hYGUqqcHJQIETlHN/xNrrpGo6dQkNnJhqhCmbI/
         SbqNTD+KMBEBRKQgPw0T0IgZnGru3XWIDrWxFu4B5nfYVjob8x9y1hIoPvM7sW6ZM/Uq
         TMqc27aqaG1LVpoIYisQHVwAexMpWy7yOUVRxIfatBGE0Gi5zglWkoN7TrPzsaKODpbi
         AIN6Tlh03v6zXXCcRc4DWeJjOX18UGaQeJDkWYX1+btGPgvAAOHuN3bLLvDoVb+bmkIV
         5mBPLdwNv/p8djfTo2GJzwFBzWztD0O7XCfQ0xPpKyeL2rl+oJtqXeLRQtUCJ/RHhaH0
         1LQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785163266; x=1785768066;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7pArl8q168UcAovCWpIP50BcVQynTGjSIcRYIXI9vrA=;
        b=ijUlv7MEJ2NQT6wkPofbnL/vEraBp7xgbmC8dNmRBSbS0j6fZuuj4HKyOViFycpvgB
         iba64OgKVFn0LmheYND32p6aJSgvs1tMpeczZei5wPzaUSLzagwtfKqTYM8vOYlNDzYD
         bwxt3eovqeCS+ydl4UDIN6acMCrY8xKG9gffHqMDH97sfX65EsGjjTQb4IS2JKCrjla0
         d9BvNys3I649PgqHcEOFcgCamv+Vt54XBJZ5b5C1usGWdwijL//1GJHEUH/XC+leoO1L
         tezmAxDRRqKcdpnLdwH6E0vxgEzZm5iK5M9kDuBjHWDOxbPGdJpPXQqMbM0Y/1jjCnSW
         aE6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp819iW5DOtGSVLYjlJuYqQsXFpe7dme2xplXKL2ExFBfZb0Mk5VoeeDHiVlm/PE3irwKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3gUCIsW80q4yS3tirIP18+wwvCjqGZq2XVP6+Uz4NMrWqXL6k
	O7H/oxtEKxnnzTGLqKsbBqYU6VdwKqbakgwUJVVEeBinyIvogBTMFmBHi1oAJHWonTyBqhzBm+i
	+CqfPCA==
X-Received: from plhv7.prod.google.com ([2002:a17:903:2387:b0:2ce:9c01:be21])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18b:b0:2ca:ed57:8586
 with SMTP id d9443c01a7336-2cfde83034fmr83044295ad.23.1785163265520; Mon, 27
 Jul 2026 07:41:05 -0700 (PDT)
Date: Mon, 27 Jul 2026 07:41:04 -0700
In-Reply-To: <627eda4b-c084-4cd8-ad3a-3b3793feae0d@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com> <20260723210811.72720-8-seanjc@google.com>
 <627eda4b-c084-4cd8-ad3a-3b3793feae0d@intel.com>
Message-ID: <amdqJtKey_zX4-Mf@google.com>
Subject: Re: [PATCH v6 7/9] KVM: guest_memfd: Rename prepare() hook and
 Kconfig to make_private() / CONVERT
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>, 
	Michael Roth <michael.roth@amd.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 27, 2026, Xiaoyao Li wrote:
> On 7/24/2026 5:08 AM, Sean Christopherson wrote:
> > Rework guest_memfd's prepare() hook into a more accurate make_private(),
> > and rework its Kconfig from PREPARE to a more generic CONVERT.
> 
> > This will
> > allow x86 to share (pun intended) a kvm_x86_ops.gmem_make_shared() hook
> > between the "convert to shared" and "reclaim" flows, which are one and the
> > same for SNP.
> 
> Does it mean in the future we will introduce something like below?
> 
> #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> int max_order)
> {
> 	return kvm_x86_call(gmem_make_private)(kvm, pfn, gfn, max_order);
> }
> 
> +int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
> +{
> +	return kvm_x86_call(gmem_make_private)(pfn, nr_pages);

s/gmem_make_private/gmem_make_shared, but yeah, that's the plan for the in-place
conversion series.
