Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7C23D283
	for <kvm@vger.kernel.org>; Fri, 27 Feb 2026 00:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772152136; cv=none; b=GprN8l5FvsGvbSQ/2WHaHyj0O0OBpTHtYVkSy0BkLUr68oJjxFQsZ7ekCN121DCD+3GjFFjlbPCcJZ4ntb/30vuab68PvtDEZAVxjrpW70W60pZTAlQgvYtRreWFfkEa+dxBGwMbswM9dHtcyB1uDp/QfMALli/YJ480c6BTwGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772152136; c=relaxed/simple;
	bh=lEB97ADOecWVEVe02PkREEzKIO4xAqb815Ec9Z1vUj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bnBCD9VLjaxpIxIwMZqcTc2KseLHIkGTtlX4LM42LpZeKoc8k8ou5keGdUWYFme4P7hGHJsowdn6Ntxz5DwgG7K6QEYxjN+DLVfO1oxznacJEBy8so31hOoeDhs80vDzZVmYobUi+s49/B1wty6tvVy3d/wv2D9WT/YiK9QH8gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cFt612R7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cFt612R7"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2adb1bdf778so14023575ad.3
        for <kvm@vger.kernel.org>; Thu, 26 Feb 2026 16:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772152135; x=1772756935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6kmoc5vi0J5hNeqO/ZaE6q23lfiWCinIzXvzDb0g9U=;
        b=cFt612R7C/SZiD5tQXAgw9gu2vWba6CiFLQXAUjRWAVoz9hvwZNcxqRDNZcjwyQjtl
         uzsFkWY0ZqNnSsdyU/4QsFaH7J8idPV/m99ZcxRgZNW9yXQcEILZ3RejQY+uNcd6hfB1
         ybU2w/qO212e5zAepgo1yp9y5WBtWY9KC+cYJRvnRz7GwbJxfpvoxw0iNCOqmm/ZY3id
         3Flllr5e6uh+aTlPvZxmUx9CzLeLpUXuigQheR2K6NBHzgkuL0/YGc9/f1IkC7iCaVix
         JB7wIg68IrJGrrhdCvphuc6cRLh386NTafgIAaN0XgSwv3FKBuzMH6wWNLa3xat0/PAY
         h1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772152135; x=1772756935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6kmoc5vi0J5hNeqO/ZaE6q23lfiWCinIzXvzDb0g9U=;
        b=kIewkmwDgIWwTZ5ILUBUrVkNGtR6hzT9ENeNu+UlJq6RWYNa2O3rWXOKPSQMIO/S1p
         glob8r5Gq1MipaLfN+bC6gSeDelTA+XE994OJ1Ot2R1y2378gKUgMWJfEvvIYJ9y1B/c
         e8DWqGSfRd0dbyyBty/SHLgANydpQ5Wrtn4PJLyOm89HOlJc0v1chzwjiGhY3Daf2n9f
         pNe72AH2EKZUbX9LQrbJaq6Beivwxu7E9V8jr52yAqIgkkPlIAHipHtjTVnRYWNg1ss3
         dhkICCLQBnMWsuTO+mMTeSG5XIC/9iyT9mnz+k4+5OOjGVXecT+MhOdfqN0agi9s09/H
         vGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOJPljislKY1A1cf1tgnkLhkNrO39uo4xbWPFNNqC5B9FzrzZnWavDA5rop4cpRnGaE0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvnTD+IJ4KqCZILtRgZJixUhCSNiULTJw86LKohyl+iIc1J/Z
	PeFIlPWU2xY/Ea78W0RGAgzN/eV1wtnKtW3IOdMRea4X+dUofCN2MJDavMsiniz8Ea39D8OqiG8
	guFW6cw==
X-Received: from plbmp13.prod.google.com ([2002:a17:902:fd0d:b0:2ad:c29c:618a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c2:b0:2a9:5c0b:e5d3
 with SMTP id d9443c01a7336-2ae2e40a0d8mr7490925ad.20.1772152134981; Thu, 26
 Feb 2026 16:28:54 -0800 (PST)
Date: Thu, 26 Feb 2026 16:28:53 -0800
In-Reply-To: <20260227002105.GC44359@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225075211.3353194-1-aik@amd.com> <aZ7-tTpobKiCFT5L@google.com>
 <CAEvNRgEiod74cRoVQVC5LUbWDZf6Wwz1ssjQN0fveN=RBAjsTw@mail.gmail.com>
 <20260226190757.GA44359@ziepe.ca> <aaDL8tYrVCWlQg79@google.com> <20260227002105.GC44359@ziepe.ca>
Message-ID: <aaDlRdnhIqRXEbPZ@google.com>
Subject: Re: [RFC PATCH kernel] iommufd: Allow mapping from KVM's guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ackerley Tng <ackerleytng@google.com>, Alexey Kardashevskiy <aik@amd.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Steve Sistare <steven.sistare@oracle.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, linux-coco@lists.linux.dev, 
	Dan Williams <dan.j.williams@intel.com>, Santosh Shukla <santosh.shukla@amd.com>, 
	"Pratik R . Sampat" <prsampat@amd.com>, Fuad Tabba <tabba@google.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, michael.roth@amd.com, vannapurve@google.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 26, 2026, Jason Gunthorpe wrote:
> On Thu, Feb 26, 2026 at 02:40:50PM -0800, Sean Christopherson wrote:
> 
> > > If guestmemfd is fully pinned and cannot free memory outside of
> > > truncate that may be good enough (though somehow I think that is not
> > > the case)
> > 
> > With in-place conversion, PUNCH_HOLE and private=>shared conversions are the only
> > two ways to partial "remove" memory from guest_memfd, so it may really be that
> > simple.
> 
> PUNCH_HOLE can be treated like truncate right?

Yep.  Tomato, tomato.  I called out PUNCH_HOLE because guest_memfd doesn't support
a pure truncate, the size is immutable (ignoring that destroying the inode is kinda
sorta a truncate).

> I'm confused though - I thought in-place conversion ment that
> private<->shared re-used the existing memory allocation? Why does it
> "remove" memory?
> 
> Or perhaps more broadly, where is the shared memory kept/accessed in
> these guest memfd systems?

Oh, the physical memory doesn't change, but the IOMMU might care that memory is
being converted from private<=>shared.  AMD IOMMU probably doesn't?  But unless
Intel IOMMU reuses S-EPT from the VM itself, the IOMMU page tables will need to
be updated.

FWIW, conceptually, we're basically treating private=>shared in particular as
"free() + alloc()" that just so happens to guarantee the allocated page is the same.
