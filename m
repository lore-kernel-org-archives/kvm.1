Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4C44457A2
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433590; cv=pass; b=aXeKnPCnL3ZLk31ROTNcO0Jje5YNrMY6M7WAQHvP6VJRRDucKaw7W18ECiH7HVz+SBgEOY9Dd/p1su3vM6v1ngcuHHSQ8LMk9ZhSEf93lfHN+OxAYNJT2TUAtsGQKMtz8GH1K4KorsrLq9VDlLxJe/kkpJUr/yJ4isXQptcqy0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433590; c=relaxed/simple;
	bh=UOih8CBVKjn02CmrfoiIHS5zm6Wg61jRZNK4KLcmhAA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6cn5lCQVSzzLdsOvhvoV/zmQGJU0OpvlHvZof1rPh9I5LxSPwS+an96lfTRJR5j7rlNx7staYJNryvbQ50myN9CeNx+rSQ0CNv2+vxpRDl1TVECvKD5hil7bthepBoSQdJfBP726FtWmEgVAwkdkqVC/g4FSMe8Ofzlb0xu+vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fko86Nnh; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fko86Nnh"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so39324a12.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 10:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433588; cv=none;
        d=google.com; s=arc-20260327;
        b=UUmOtVv3JAmcMBCxcStK9fRMolg3ljvzD2SHihhVsrM+CLPn9qYArXUQPdaQF1MEes
         BrDDDECTTPsYezNnWexTJj9F+ChWjlozjZCLqGy0DEf1nW1EjcIDnMABYR6+aIfzRuER
         agU5x+HiB2QNAUTEplNkPXxQj0qLpjDSmLrzmYBoYtHqvsO1l5mnr8etPYdDuVNDXhCV
         fwHwt0SJFpNq8/HY9Q4QPZB3cIym/wzrPDgGSl18S7UO0i1uvAmuAEds52X1vg70uIgg
         xshcO8pg15WjM6MfPwidyDOGG39aExPkZ6lrPP9CfSdVAvt1qXkynTr9ZHqggKaQtUe9
         bdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=UOih8CBVKjn02CmrfoiIHS5zm6Wg61jRZNK4KLcmhAA=;
        fh=b2Cy4iRDESPaL5Ye9LzH3NBfw3x+wuWqiH0RbH4JT3A=;
        b=nO7Fne0KLXQ0fyJyysZUPmBYFNKmw5X2zV2DRAW00BnnHe9pVY9GTgcR9kUAJZ3mAs
         IcFuwfH+32msGEuNEjMEXGo8JkT9rOw6UhakxA3ZefMfSWlMr9cWrV5Uyl6oIAjIcnlV
         CGxm9K3IQxj3mBhOHWBOFaZrtv7DpU9ZErTgwxxd5zGRGR8iwfvYSnakLWZUVENk2iSV
         Q/86jASWyHsHaegmfEjbo7Dde60T7/LxKAKOkouYooY6fvRAAHdaujEEj5/0gXKMhdmo
         FnEcM9lmpBL1wAth9BNov0YXMYVupP6L7x7Txm89W7EKkw/5dPcqNN6he8OmHCSkQcYA
         XiFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785433588; x=1786038388; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UOih8CBVKjn02CmrfoiIHS5zm6Wg61jRZNK4KLcmhAA=;
        b=Fko86NnhE3c1LenxV/HS0vR+1WIbZIDCBakFgoAjar1fijC26C3mx1AqRur5q+x91B
         b4TINsQjfbyYBvZ7QPKOYL5GCR0wctAxUNeGrt9Ba4VBWEcRP/yI0PcfTYhdIdQsN2gP
         eGFqbnQRLNGIbI+pxH0X9oLAexKZw4EuqTFFDajZ+AV3Tg3Vu3UHs9bDWZDefLcWxaG/
         DxJbbLUCC1ZW7HSvpq8QXHfL8WDdpGbNW2OajNw1yOi/hzPgBS6atzS7aaEuqgk4F/B8
         Od+y/HvkvIS1hSXCHRQrP7Ar2vP+H0w1TaxQkmI18BuezpCrYbU2KC5qCtEmFMVl8rqh
         p5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433588; x=1786038388;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UOih8CBVKjn02CmrfoiIHS5zm6Wg61jRZNK4KLcmhAA=;
        b=fV6ScCcD7jVkD9E4khJK+I+KcAbdbR/Fpg3bVxWtLLXYH28ly8YSbR4xYPCfjt3gN3
         ojPsnnOIJnI7eQuoGDQApszlzVv7q9udd6yOxGinDDAR+HhFvU5WjeAGH0GfbAv04kmK
         pyvX6OPYw9XcLgNs1mbRELaQFuh/8Q+O5KQfc31j8RAg6cM04kR+eR1pYRNSVhBfT6Gl
         1r1Lk4utSWs9MltsbrBJMv8G5j9+hG/WsPfxk2NpfFnKIFkmuSDrlLAUEuIHs4GjS+zB
         eRKA31Tw7Mpog/lz7lpb1ldNjJkIF385jQmFL7TcH0fd677urTpjs7vztXj8IoPHBtNo
         RdWw==
X-Forwarded-Encrypted: i=1; AHgh+RrUzVz0tdUFiygeeaXCV3vG1ND+W1YCr2UeQ2IO5u6HFAXiHvnX5IMSnt8GWkwg+s/5yWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGY2s4UbYfY0j5y1MAzkmrs3dMEcThovjWFlNy1bE96Qoyqpc
	LL2EMcl687mBAE7dfhABxy4xQCYTAKonqsPdS0iCrBrgZwTjHFc1eFixXtROIIBD9FNDJnnLM56
	o1u1ueUxMq2KBSYcx0Kbh6E9d0kO9ug4I2bvdSVOr
X-Gm-Gg: AR+sD11CNEYv4tMoYDKvS9PbfTTWN83N6zHA8I5ot2Bpt6JuwkpkFn/8fJaI2kp7rLI
	J60bokql15eHT4RXabidELfABOCuQiYloe7gL978tt6zv84iJh2tjnCuJKg8MmStlFmkT58KPPS
	9Qnu6e8N+yE0XNwYzGh6iE+OTiSen7z8p2osTYjWv6aY9lqYsnyDegIbC8NxtBUIbaN0FQEHObM
	XOFHGBXBfP1PI5eBGE+gyBE7VRJJQwDhlYdy4tlNJppy4Kz0IbPI6yMWgJWmSSD61Wr9TrDhE8m
	6NXxE7nB0L6ipccXM/jKF52C5edZ9oICFvVEhVzW67DDjDZFQm/LMjraEGY6ckbgwlxiL6+4aPa
	n7PR/7cpQbajwyXnQ18blIdIm6bs6hPeAwg==
X-Received: by 2002:a05:6a21:e8b:b0:3bf:6ac8:8d29 with SMTP id
 adf61e73a8af0-3c9006bb981mr3748982637.21.1785433585760; Thu, 30 Jul 2026
 10:46:25 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 10:46:24 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 10:46:24 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728121138.1103610-8-tarunsahu@google.com>
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-8-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 10:46:24 -0700
X-Gm-Features: AUfX_mxSA02wZmCDGZHkTAv1sqG45AQrWdNvcUlNspdo9IevcZmmfeKZDjs0tR8
Message-ID: <CAEvNRgHvBTKaG4G5J=sMFGYepEnOFaeCBtjkzN6xmGtZ+o6XxA@mail.gmail.com>
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

> Introduce kvm_gmem_freeze() to freeze a guest_memfd inode's mapping,
> which prevents fallocate() operations and new page fault allocations
> during preservation.
>
> Use a global SRCU (`kvm_gmem_freeze_srcu`) to synchronize freeze state
> checkers without incurring per-fault locking overhead or risking per-CPU
> memory exhaustion (as per-CPU structure not counted in cgroup) from
> per-inode SRCU structures by faulty/compromised VMM.
>

I wonder if everything to do with freezing should be gated behind
CONFIG_LIVEUPDATE_GUEST_MEMFD. What do people think?

> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>
> [...snip...]
>
