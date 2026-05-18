Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EBF29D291
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129144; cv=none; b=q9kaaHBSqpsfuNpYjNssa22u4N6fF8goWSMzAZLkDZ7KDpz8PtaJ+MlrrKAv1jNYNifYiKv0JOqe5X6nexsACYmaLQLsywu59DmRYl9HMRjHqAWJpQ06JpglZ9VtsPhwdZVOC/WoB4rBrB+aU+ZLzT+iVsJC3iTozABRSyZvggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129144; c=relaxed/simple;
	bh=16bEYXGZGd2YyQebL5pOyWJvKC3gIBGcSWo7OTItR0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bxJrm8Ce8baHVs66wFEChsRSQPGP1WJ5f1fNkOI8ongysMykrpvzr6mJva0Gt+5xcpl/MjfjjYtre4ahAZgCpihe0twHgbOKyJnkLN30AtPgji2MprcoEYNLRJAxImVPzi2OBVjIf4tL+8WBUfHTXxhz/C2zbppHk6J7EC7nipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRRmJYhI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRRmJYhI"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-836d0184333so3843339b3a.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779129142; x=1779733942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMfPrbhoLjga1AdJLxMvGsU3iqNPJdA/CeWmsArIr+g=;
        b=YRRmJYhIB4+xHrTzclJKFEDVXRKDBnV0PL+TcjJ1q823qHuS87zvB7iRI4pfOIwVSt
         /Vcg+k5s1pdTPvf9NmYfD5TzKXRdu3hGY2+63S9VOI0/uJ4yN0yZStUJDi9UJsAdvq8P
         h+Bkv7Uh6hJDA1X9GqZ49mcgPObXqgWxP+4w8R7dpvrOVipkNw59msdU7vR8o7Fmr6Lh
         BXU/RRMj+X6GUb82f1O5dtn4+H0kMxN/tZllXE9TfgwHDGYPKBuXqg5UiPMeW9ABU19a
         2Bar/a81dFIsVZHicquxAwry8vbApv6vr2UJLo0aT39CteFe21zgkeZcIfCV11hNlrNT
         mlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129142; x=1779733942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMfPrbhoLjga1AdJLxMvGsU3iqNPJdA/CeWmsArIr+g=;
        b=HgftwDavklYhNPNHblP2XaIOI6InEa7N+3stM6vlsOVVroA48jRlRbsDZcWePF8YqP
         GxEwU0dLsYDS2CKMhVYltpWD/YRhBda/Jmvapk+WlDU6T8DxpcA4R7RrDkFiAOm6nH2j
         wAtPmPZG20MJflo77S6o04NNN+AMNUkjSW4HwurgPwmihIFnd+MKWKgHZDBSh+e+L2Oy
         O82LV8naws4n4jocFSC560gy8ThJxmBFV4xhlzSljGDpUumIskuAES+9C4zVTxGGxCjM
         UZgxDRFQSe4sQPrveeDN4eYMQFbS1uCPnD/IR+Mu+ZPnXPiP6ok/TWnGpkmdE4AC2jAB
         jvfA==
X-Forwarded-Encrypted: i=1; AFNElJ/SpVldRZ5h2CqHARlo8Xu02kBYXFa4sBhVxDOR9CQMMyazF5PYj1jgIgoMTRAlQae9lbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynyf2tUpRRfpGvSYxDVJkOAJy5wKaBsVXMxAzZ6DwWyQTGMbZ5
	UwOkXmB3hzvfFiHpQV36M45TyrA1ZHkMnqL8qxcMbZumTPuK/luRhgqY3IrBGywGcfxII2za2c5
	A06XbLA==
X-Received: from pfbff26.prod.google.com ([2002:a05:6a00:2f5a:b0:83e:dfc6:971])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a221:b0:82f:7b98:e499
 with SMTP id d2e1a72fcca58-83f33d9dcb4mr16612559b3a.31.1779129141944; Mon, 18
 May 2026 11:32:21 -0700 (PDT)
Date: Mon, 18 May 2026 11:32:21 -0700
In-Reply-To: <20260518070943.2091287-2-ZongYao.Chen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518070943.2091287-1-ZongYao.Chen@linux.alibaba.com> <20260518070943.2091287-2-ZongYao.Chen@linux.alibaba.com>
Message-ID: <agtbNc2uPA7esShy@google.com>
Subject: Re: [PATCH 1/2] KVM: guest_memfd: Return -EEXIST for overlapping bindings
From: Sean Christopherson <seanjc@google.com>
To: ZongYao.Chen@linux.alibaba.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Ackerley Tng <ackerleytng@google.com>, 
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 18, 2026, ZongYao.Chen@linux.alibaba.com wrote:
> From: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
> 
> KVM_SET_USER_MEMORY_REGION2 rejects guest_memfd ranges that overlap an
> existing binding, but kvm_gmem_bind() currently reports the failure through
> its generic -EINVAL path.  That makes binding conflicts indistinguishable
> from malformed guest_memfd parameters.
> 
> Return -EEXIST when the target guest_memfd range is already bound, matching
> the errno used for overlapping GPA memslots and making the two types of
> range conflicts report the same class of error to userspace.

The other key piece of information is that we quite clearly intended to return
-EEXIST in this case, given the testcase, but simply failed on multiple fronts.

No need for a v2, I'll add a blurb when applying.

> Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> Signed-off-by: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
> ---
>  virt/kvm/guest_memfd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 69c9d6d546b2..46727539d08a 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -675,6 +675,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>  
>  	if (!xa_empty(&f->bindings) &&
>  	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
> +		r = -EEXIST;
>  		filemap_invalidate_unlock(inode->i_mapping);
>  		goto err;
>  	}
> -- 
> 2.47.3
> 
