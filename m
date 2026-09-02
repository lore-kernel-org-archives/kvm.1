Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C04AC168
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375641; cv=none; b=PNIZVsD4g5/i9qgGvlh66QSx1KXaIkJc5BoylAnlPg4FIjciptHvCGogIIENodUUJTj+Cczx8d/DbsbzOs9eiBI8qDIjrpvUHhsDtkF8YN/zwau1WFvdCsbSk1PM3M1ZSTD+HnyWQ5Azl7ln7PypT4ZAJmJSZ0s7WQeZRqFYEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375641; c=relaxed/simple;
	bh=9+PtoNWtYvyeFwm3scPlfJtr20of9eAKhZzlkDiBk6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mslk3Zy+SGhaW0IeJ7hDzrbAFSXbXy+vPoKFXKyjhz3HoTVRTKpXxpo9nkmc1rwhvsEchdFiDtq3t29lTFOA98m6bqVN7FNgA3wF1z+kEuQy7pJn2eZf5NLX/4QngDurKZ5V3OA0IG/Xsz/MDn9Sud1mwAjOVq/HvB2wNGzZWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqGLA4Wp; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqGLA4Wp"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1c62f0d60so2004040a12.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788375628; x=1788980428; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bnqlH6sbBHV8BzHgW7BD+Nz3+m4Dg1ukrAP/BXotBg=;
        b=DqGLA4WpcF0bGKAjBtcZAUADmB+UNZrMEiZk6XVDzJohEFz2t1WjZzjTdlX4zReMJg
         7GAZqMnHqjLZEbokHgydePHPw1KLZabAcYiUzBMtUnjwfzczJRDGP4M+gN+ILNKV1M4X
         QtC5SaKoovDVHc+NFPLad5D3rNpN29OUYarA0/iJ/GnFYkZyW8hMDyLXvLDN6t63C61r
         /jcDGQeMoJH8EF75LBfiIsnY6TNJN6bVBpVlJ+FESmeVbHDuRdSaEmrcFgvqwz7qZIWR
         9/e8LzsszxAOA2CheJKii9VyQTDNv/51vDDx3YSrkOjFFthudEGrkpBPk+XcOqn0f7UI
         wrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788375628; x=1788980428;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bnqlH6sbBHV8BzHgW7BD+Nz3+m4Dg1ukrAP/BXotBg=;
        b=Zc8m/oqpf/UM++eH0sINemaQGfhSyCX9zZ3E8a6u2xhjoqTGViizSmVjeZXKWHwDaT
         WIn+1s1pOTg7fNIGoXMrWOP09CYLXiFJGOT9YCop1ZNJrWUFyBwYkQFUXMbVyKE0uvuE
         AoRxQQVtqjRzEcfrfUEm3hgMYXI7GPNrhsrlEbULz35zu3WRpE9izZYlO+la6uYUmztx
         BR84AoH4YJRbSL63DKQCFQ1/nXCERGwoBDombqlnqUqZ/hXinMrDFbdcrrBLmRmVk3Gk
         cY04qbERWwYRe+DtTPs9wPhqCP0YIvlUUO+OGRbDFpNXw/XPWmKz8HXY4AC4pJiEs5FY
         oU9w==
X-Gm-Message-State: AFuF++k2VtzZMHFiRWOwFgx0LovhOfk9U4OzF26ISBkmjQ620mrknfPd
	QZT3/cd/Qkd+8OdqHhgol7/+qxsnaME0/vFYabAYP8KE8aQ7SxJ1DJubYLEmWbv29RoDbotLdpc
	4stmC4Q==
X-Received: from pfcp10.prod.google.com ([2002:a05:6a00:a24a:b0:84c:2e68:a493])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:409a:b0:84f:dfa8:57c5
 with SMTP id d2e1a72fcca58-85ed398aec5mr10724755b3a.13.1788375627681; Wed, 02
 Sep 2026 12:00:27 -0700 (PDT)
Date: Wed, 2 Sep 2026 12:00:27 -0700
In-Reply-To: <20260902183634.9E9711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902182020.2615443-1-seanjc@google.com> <20260902182020.2615443-5-seanjc@google.com>
 <20260902183634.9E9711F000E9@smtp.kernel.org>
Message-ID: <aphySzgAce0I1Cox@google.com>
Subject: Re: [PATCH v2 4/4] KVM: guest_memfd: Drop superfluous WRITE_ONCE()
 when binding a memslot
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 02, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Modifying the guest_memfd xarray outside of filemap_invalidate_lock on the error path causes a Use-After-Free and permanent MMU invalidation lockup.
> --
> 
> commit c377e9963148427885842d70319259945c649a8a
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: guest_memfd: Drop superfluous WRITE_ONCE() when binding a memslot
> 
> Drop the superfluous WRITE_ONCE() when setting a memslot's guest_memfd file
> during initial binding, as the memslot *must* be inactive and unreachable.
> The superfluous WRITE_ONCE() was added by commit 67b43038ce14 to
> maintain rough "parity" with the existing rcu_assign_pointer().
> 
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 2c8d8735de5fe..323159c9b5f34 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -653,7 +653,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> >  	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
> >  	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
> >  	 */
> > -	WRITE_ONCE(slot->gmem.file, file);
> > +	slot->gmem.file = file;
> >  	slot->gmem.pgoff = start;
> >  	if (kvm_gmem_supports_mmap(inode))
> >  		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but modifying the xarray outside
> the filemap_invalidate_lock on the error path further down in this function
> appears to cause a use-after-free and a permanent MMU invalidation lockup.
> 
> If xa_store_range() encounters -ENOMEM during the store, it can abort and
> leave the slot partially inserted in the tree. kvm_gmem_bind() then explicitly
> drops filemap_invalidate_lock before executing its error path. 

LOL, I think I get the point...
