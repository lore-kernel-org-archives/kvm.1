Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F74314BD
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442579; cv=none; b=S7hpPYBQBHrF9nViVplGKZ4WkAXza+ClF3pfEIcz9rWoHXAdoyEqhvEMEyKP0oOrZ6aggDuiX/5xjFz3OWIbaC7o5JeSKhlHPkzX8nf4UrAbqCJFtXetJ18gJbWKlI+nAuDkooDVpWBBM1gEy6g+nTH+94KbVSm3gUTcFVvXghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442579; c=relaxed/simple;
	bh=H41yMknjVG71og8CmjZZR+MeUIksNhRmvY/nJramKWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r3DINYZdJEkX5Q/RBAf+rRj+X9RhO+HslkAoonJJsp1j9AYQOjVK/lixJSzP/wPf+8JSutgAh4w3HDb7sUBKoCUUkL83N5M9Jxt0g2nH9wB9s6suTf/LkVh7azS9dbw2BZxk5s8NlA1XqjH8zNNPGklxxWpg5/XJMEJ5AQGbd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKta0X+Z; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKta0X+Z"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ccbb61893fso21840965ad.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783442577; x=1784047377; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5MJA87eelqZlich/k/pRyyKO3yBR+w1Zvvri00+Rec0=;
        b=GKta0X+ZjtxH+S4XMg5Nfw9VAOHWdh74aVul0lBz9FaHmQX6j1HsSqBVeOt5ZWR6Rh
         o1PLT34c7XktXhC8gQ5YPjz75JxFx2dtSWiAxQiE4UfnzPM+VRH/jCw1vtLzSUBTJTfL
         aCBqKFuYL4FH5fpWIp57LgR1GCH4BkaH13jZTR6DAyZoc1OZ0QoOPsr4TgYUGSGlDDFA
         fk7vtEEIaQ2Nr8EQMZRP0XNSrUhYMvXxl7MU4kZePuIFNURBPxb6L+diTTlLatm1FpK4
         9LepNZJLVqezFLcZy22ylzDuRvqPo91uO2R6wBJ4jb9zzWNQJeC8TkLscaMesskZR98o
         ZKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783442577; x=1784047377;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5MJA87eelqZlich/k/pRyyKO3yBR+w1Zvvri00+Rec0=;
        b=VWsy1ZTZfEPRcWozOGURiBHYcBvudeymldyBnXQ65+BMdRTffdFLXgY2sUNmiqa0Sc
         oRnEHpcGATeLmlsKEB30bIHlTmh47xPfoXelMh+n+ISycG5wlJuRPZvK9xSefPZvHnAX
         u1+EL8Qre/ldrs8WA6xcJd7lbUw62LMaAKW6CN9a3BFsB/pLUDjmALjS5mue9H6if/2F
         Kr2RojNsEJ7P5g9uy+EhZSjPr7n+Mz9QMAPhyb6WecTawe0Jt7ax1TzPwdtVHrbdn0pW
         L6HtgNvPVv5vZHXYIBo+opzzVb7oIkSbVUP+jJW2xVmxMj3Z0Co+XsYs0jSXzkHk/WbS
         6PGg==
X-Gm-Message-State: AOJu0YxxOTonkCq1Dud5k2i6kMEtYoiIzz3gtB3x0Xp2BArPjcgsVOeF
	6B05rHT8ZTsdxZ3SuJBbe2l3OXbki5/yxgHyOmCv7jhym8J7R9sYLLtOrDCMOgkApwG9PSpScGM
	f0JbQCg==
X-Received: from plgo11.prod.google.com ([2002:a17:902:d4cb:b0:2c7:f626:ec80])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60e:b0:2c8:25c8:85a6
 with SMTP id d9443c01a7336-2ccbe4004demr61882425ad.2.1783442576803; Tue, 07
 Jul 2026 09:42:56 -0700 (PDT)
Date: Tue, 7 Jul 2026 16:42:56 +0000
In-Reply-To: <CAG8aMMegOz4SVbzJK2P1n0iL17t3e+wQPcLPE+Cn+t3ioOa+EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAG8aMMegOz4SVbzJK2P1n0iL17t3e+wQPcLPE+Cn+t3ioOa+EQ@mail.gmail.com>
Message-ID: <ak0skG064rhKUC8d@google.com>
Subject: Re: [PATCH] KVM: TDX: Use check_shl_overflow() for nr_pages validation
From: Sean Christopherson <seanjc@google.com>
To: Sunday Jiang <jianghaotian.sunday@gmail.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 02, 2026, Sunday Jiang wrote:
> From 4be3dcf1fca4acd2bf9c22bd604c913ba1774035 Mon Sep 17 00:00:00 2001
> From: Haotian Jiang <jianghaotian.sunday@gmail.com>
> Date: Thu, 2 Jul 2026 14:13:27 +0800
> Subject: [PATCH] KVM: TDX: Use check_shl_overflow() for nr_pages validation

This is all kinds of mangled, patches need to be sent as plaintext.

> The nr_pages field in struct kvm_tdx_init_mem_region is a u64 that comes
> directly from userspace via copy_from_user().  The current validation
> uses a manual overflow check:
> 
>     region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa
> 
> When nr_pages >= 2^52, the shift (nr_pages << PAGE_SHIFT) wraps around
> to a small value, bypassing the wrap check.  While downstream protections
> (gfn_to_memslot() returning NULL for GFNs outside any memslot, and
> kvm_slot_has_gmem() checking for NULL) prevent any actual out-of-bounds
> access, the overflow itself is a real bug that should be caught at the
> validation layer.
> 
> Replace the manual overflow check with check_shl_overflow() and
> check_add_overflow() to correctly detect the wrap-around, and use the
> computed end_gpa for the subsequent vt_is_tdx_private_gpa() check to
> avoid redundant and potentially overflowing arithmetic.
> 
> Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> ---
>  arch/x86/kvm/vmx/tdx.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 989ab29b8c6f..9c6aa95ea1e1 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -3234,14 +3234,20 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu
> *vcpu, struct kvm_tdx_cmd *c
>   if (cmd->flags & ~KVM_TDX_MEASURE_MEMORY_REGION)
>   return -EINVAL;
> 
> + u64 nr_bytes, end_gpa;

Declarations go at the top.  These should also be gpa_t, not raw u64.

>   if (copy_from_user(&region, u64_to_user_ptr(cmd->data), sizeof(region)))
>   return -EFAULT;
> 
> + if (check_shl_overflow(region.nr_pages, PAGE_SHIFT, &nr_bytes) ||

I much prefer to put these after the initial sanity checks.

> +    check_add_overflow(region.gpa, nr_bytes, &end_gpa))

Heh, the existing code is technically wrong, as it's ok if the last GPA is
-1ull.  Of course, that can't work in practice because x86 supports at most
MAXPHYADDR=52.

> + return -EINVAL;
> +
>   if (!PAGE_ALIGNED(region.source_addr) || !PAGE_ALIGNED(region.gpa) ||
>      !region.nr_pages ||
> -    region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa ||
> +    end_gpa <= region.gpa ||

This is unnecessary if we switch to check_add_overflow().

>      !vt_is_tdx_private_gpa(kvm, region.gpa) ||
> -    !vt_is_tdx_private_gpa(kvm, region.gpa + (region.nr_pages <<
> PAGE_SHIFT) - 1))
> +    !vt_is_tdx_private_gpa(kvm, end_gpa - 1))

And then if we fix the off-by-one "bug", this becomes:

	!vt_is_tdx_private_gpa(kvm, end_gpa)

Putting it all together:

	if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||
	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages)
		return -EINVAL;

	if (check_shl_overflow(region.nr_pages, PAGE_SHIFT, &nr_bytes) ||
	    check_add_overflow(region.gpa, nr_bytes - 1, &end_gpa) ||
	    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
	    !vt_is_tdx_private_gpa(kvm, end_gpa))
		return -EINVAL;

I'll post a 2-patch v2 mini-series, I want to base this on the patch[*] where
Sashiko reported this.

[*] https://lore.kernel.org/all/20260630213711.479692-3-seanjc@google.com
