Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F62C44CAF7
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435142; cv=pass; b=ROY/ptUsdtCA1uIIHTpKfQpvVEavnIpsEGx3jC1OmrROVrf5dqHJMpXWPQBWmtQxFxdNuviBvEsDLq3B13c3J/lNyLni6Dx2eMyW1gKmunBWwiBlDgp93m0UZDenLCwWpt4S5v7Lpgd7vdA+5Q5EunASmEeclhivpPrU31MLZYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435142; c=relaxed/simple;
	bh=TfIMwScvckB1Fib5Y+wsX3mqgKnQULjNLMCYcEOof2g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSRdMyX3KF6OaEQ1trUwWc+vtWAtqQKJf0yB2b2IpTgixtKiXDgwiQHcqCqtT92Lb3d0/FzzZe542SCUkGZSu/F5/JN2oa3CpT5B4I/IO2qLxM3PR8x11GGnBgmwTjm7T0H4Vm/P44lXQnZi9Xvk7XJTvaY0PH5EbI501t583uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uF91zuAN; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uF91zuAN"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccf2360620so674675ad.3
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 11:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785435134; cv=none;
        d=google.com; s=arc-20260327;
        b=q6wAiJudQ9N4FLFIHVBxDSLxMj/PxEyD0IINDk9uksTQXSKvzuWdhomSYqEWLFu+eS
         2Ym6gHBtUPwlv14tZCS/sedCCq0ekmCu74s4gHAPFqg/obpPZjHIbajW+iQy3Quu/s0P
         2//McAKwHzH5PRHno3YKPB3QVIulvod5bzmdqT28lokDWAYpLDEXlHZGojPJA2934Ep5
         ClykReVjoa48sbx2HqcUESCoSfcIjLQerUXThdsfEvI/gdlaCBbEBpLTSObwm4+njGDU
         xSTR+Vuz2xeaNO0Qf0f1fWuUgf15XUZmFM8fsX0f9ybyZB9i4SuNRbPqD33Ngv+VdqcB
         gPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gPvFSTghJ28Kixi5Kvwbbt6p3THpZRrypXj1JQIqIto=;
        fh=QgROu/kfFLDao8feHuq7cio9EUFN7U4cFnOp2ZNeIAc=;
        b=K7Z28NZEiHtAwu0zDvsFpwsWnlLoSnznI41cwbvs8R8cRaKsKpO07zdGl/yyccZMWf
         e58xLJ/980skIPzKT/QSH2gLuK2xfJCDECBV9Y+D6F279VEQ5jUyJra3IC4f5/jMQT5k
         ZRG06AgXNNyLtjD4eFGMj2NvM8n25H7wNb+dgsHFKTZG50a7hUdI3ceuNwdP2JGuS90y
         Vju7fjyzENVB7YJsWq1wGlPrjZyYDPOcBEq3d0sLoEaxDghrsNigaeDXGv0VpU6apE89
         SvzB0EGw1Xsi/W6gBTjW2l/VcA/DhbrTHNsig2IfECUjGFV3/11y2/HYm50d/u5PPAW/
         tQMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785435134; x=1786039934; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gPvFSTghJ28Kixi5Kvwbbt6p3THpZRrypXj1JQIqIto=;
        b=uF91zuAN4E52hdv7rh5ePXW5IbE21BmQyOaLbedFouQNsSbV9KuoJ0tX4AkVWtRDjb
         JbMNO6qgTtJXtJwUXcYMpGigwjyCKv/8ASC9KiKkp4WywqK+muw7YUGcf+zcD3nAB1Kw
         Sh33C1d4YCur1zwK5LwbeboW5N+kIptKOXnJdzasF6sL44NEwIg5WF8wjcc6Lblzs/XC
         6BibsrvKm6LZ6+p/cUor07EBzr8p8eNO2VGQaHi3e96wuG/tw5hC+CEYRP7OwqxiVweh
         1BwVmnHf9ZlKmp/mymp6a8k2fXq5xA7Sjg2QtEn6pLrPUU0R7DCFrEZdD1tuxMyeDkkp
         ZOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435134; x=1786039934;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gPvFSTghJ28Kixi5Kvwbbt6p3THpZRrypXj1JQIqIto=;
        b=dq3TXRqi9Cbfb39tZXscM0eGDgBZtYLKKqLM3wnqR9rmdRehVob176ko58b95vbpde
         iGyl++imz5oddYqaMNauOR5ejF483GIw/tsYqD1e5IqIf5w7ZSafnHRYwTi9lYijVw/q
         JqtrTtbvnbuRL8Ge9CCwoYChWTLL1Ykj+TkkWH82ewTHv7OtqtkvZCC2xqQwLEvqkzZu
         SVcyNQl7Vu6o31ME6mkEdbhzmLtlekyuCX4/eRWi+1s4tP8T46f3fzkSQIJbKHElPZLh
         XFIDJZjq/gcZJ6m1n7rACJoKdAyIco2rf90MjKoEu19DHLZ/h9vPqPoGNCCdsKIENbgD
         XVgg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8XisuSvhFNGtqNBEW3ozZOB58eFiKL8WBL2iRv/n+ve1bRRkDdzGdKsDFQTVC4CwYyoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQzAbtCm8WLvOuT+rMwhDktTU76T7GJwVJfRjyMge1f0TyaCGO
	dxqKgB0PZ0ux0u3VXE18uvoO65CrJxO5nCst6qgB2/mMutLdMtfBjhLbK+UCs6WklTulg38Hr3A
	3Pwvy6KSLHmJRGtnrBrti97/nqGv3KDeojMZCKJXA
X-Gm-Gg: AR+sD12WUrUWO8Xo/6X6AZUaWC8RaV+/5K6xFAE0JDSuu8a/cHFRGeVkQ/a/w6fl7sM
	i+N4jUFc97EglCfZ8A/CNY1cweuzhK9Hssco9eglRNLEfeIYg1mBQNU1eYK1LnLGMbVdgtYsWOz
	w1qUp+ZW5rJSoxs7Sp7Jt4vxBZIbVss6s/9NwVktsMyMlmTRPlLH7B14yrRD4ynb7WvQhaFIGUb
	SPrFKZArA0FQSexyBEYuaWmeWyfUMRoxjgedemMFGxnT6NQT+Xy5bmpdOtdvkCPcg9q99m2RgUa
	8XVcQynF3QlWSn1n+VjZAEDjyfREmHNNQV2V+fR+vrjc3ToElUZ5YZjjNvjiELdY+xmTSkZiqfW
	x3Za9H0hfI+cGw8IySkGjOb3okb2Lrm/Isw==
X-Received: by 2002:a05:6a20:7f95:b0:3bf:9b61:f7ae with SMTP id
 adf61e73a8af0-3c90046cff3mr3701207637.14.1785435133085; Thu, 30 Jul 2026
 11:12:13 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:12:12 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:12:11 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728121138.1103610-8-tarunsahu@google.com>
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-8-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 11:12:11 -0700
X-Gm-Features: AUfX_mx2gL8KIE-6PLoUtXVMOZbkrQaxrGgfvvgdayE505KQfySpbra5kxUa-V4
Message-ID: <CAEvNRgHW0P78eL0ip799XF+2geKwz7MQrjSFTgvCdUAuh9oykg@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] KVM: guest_memfd: Add support for freezing mappings
To: Tarun Sahu <tarunsahu@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Tarun Sahu <tarunsahu@google.com> writes:

>
> [...snip...]
>
> @@ -273,16 +284,30 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>  static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>  			       loff_t len)
>  {
> +	struct inode *inode = file_inode(file);
>  	int ret;
> +	int idx;
>
> -	if (!(mode & FALLOC_FL_KEEP_SIZE))
> -		return -EOPNOTSUPP;
> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
> +	if (kvm_gmem_is_frozen(inode)) {
> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
> +		return -EPERM;
> +	}
>
> -	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
> -		return -EOPNOTSUPP;
> +	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
>
> -	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> -		return -EINVAL;
> +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE)) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>

Continuing from [1], this guard is actually meant for PUNCH_HOLE... I
wonder if there could be a deeper refactoring to check when actually
punching a hole, basically the equivalent place as kvm_gmem_get_folio()
in the flow of fallocating.

Will srcu_read_lock() be taken in a nested way for the fallocate case?
It can be taken in a nested way with some intricacies, but maybe if the
freeze check can be done just as the folio is about to be removed (as
described in the above paragraph), it would avoid this nested locking
here.

[1] https://lore.kernel.org/all/2vxzzf0kl3dt.fsf@kernel.org/

>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
> @@ -291,6 +316,9 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>
>  	if (!ret)
>  		file_modified(file);
> +
> +out:
> +	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>  	return ret;
>  }
>
>
> [...snip...]
>
