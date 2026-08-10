Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6DC3AAF54
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405501; cv=none; b=FGoICJ17Xe/bPmSJ7VCMSIlXf2a9c6GSdIW1QmhxC4Gjmy28kfs4KRAuMvB6iB+Tiv2dl9+upnoPbbWFmeSoDkcPz/0554ZVD/dtFscU6bAurnhfTFh4jWLwiDPs9KXkwPi+v+CWj3NKeON/bXD+gZ//fGmj1MrnfswCKJ8shNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405501; c=relaxed/simple;
	bh=33plBrcKy5Ba/ieAnvSmeZoRK1u7IAJOuZUoYzX0htw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qBapsjbrf5tou6NYp+tJmzK5mdCJmqeeM9tp6+IRtM8bNKmtOyjobHgt2Wjvsk0Jd5862hk/N2KMoX1JraLb9yxWfV6AGmfXKec4/vWMvpzukHqBeMK+3FLQg5iNgvjWqRlc9vopXwSOmRRWNYi7sfQnu2VtY/6/ZkqonZ/MfUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+6ZUIw1; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+6ZUIw1"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a3514f912so319760b3a.3
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 16:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786405499; x=1787010299; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lgf1v7ZyMRecW6GzYu5RKpdf3OAqJ1cTW2eoW0KSWKY=;
        b=o+6ZUIw1MbH/G+nWOFBorS6s4CZFDXy70d12/0joRZpcg7dgK+QMkownJHssYuzaUs
         3kl9VADZAjGPeG+QspxwLyj5efMYKnOq4kJ5rsN2fuGTC4JPbWSrb/OQngVbADt1dCgV
         KxYm5MBHegA5nkhaXXYJPHeeJRGYCkwGi51mUb+gAY34inEHHrVAdXXl+ZA/cytpGlnt
         kh9E/xW7vXqy1oroDzglD0SjZ/XbY2pTmOzTKxgUrpZCv98LV9YDMqxhfqkz7bw/IhpG
         8Ue43UPTNS3fTAb8IKD2F+ZBYq/ZdS7jEI9zh0v9QpWN/1a27xkToUKAzX/vkbr0HKBF
         SgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786405499; x=1787010299;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lgf1v7ZyMRecW6GzYu5RKpdf3OAqJ1cTW2eoW0KSWKY=;
        b=NxuxhJ8Rd+jnqc1FHehXok3XE8K6W+ynw4RRGF2PdBN1dHrc1SKM/DCUOi5j9PH/By
         Q3PZ8bg+CiXYMZPgxHFQcvcTnB6UtblC/3LUMUlWMvGh8lkv1nmPYO55dLO4JWi0p1x7
         BOGpjPca1+F67RKsU7Jt6fxuR+nT8VQOuhkYbIdrOUMreuw7ceG7cvFGPTMd7NYdGP32
         BI2gG7WMfAMcqOy6GGUv8KE3iVpes3V47zfWIwKJ35HGe/z3RHE4bgObGzvRF+FqJkK2
         zOTrAQvIIlf1zuw7++ZvrHeMlUCIRP8qrT7tFN4cTydiRnpvzPNXbDCoiys2/5boquOm
         daOQ==
X-Forwarded-Encrypted: i=1; AHgh+RopTvUyUIVTMpgv/CmZQgSM4B9GTsZSSu+iqBz9eIv1auWNGPRRfMf7499oyKgreBONe64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywfbs7RmA2XVaoHXNC+yKjq+539Q0TvayvUNjWHZui9dfKMgma
	nNdu/Gxb9lA7rSKuZrl97P6ooyU1ghrknwk7Ort6A5DzZpR3Z3HA4XjSJbtL/w0kt//C8SJFhZI
	0pj96vA==
X-Received: from pggg21.prod.google.com ([2002:a63:2015:0:b0:c9b:bdf2:2507])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:178a:b0:845:e97d:447e
 with SMTP id d2e1a72fcca58-84f2e040170mr49815116b3a.26.1786405499340; Mon, 10
 Aug 2026 16:44:59 -0700 (PDT)
Date: Mon, 10 Aug 2026 16:44:58 -0700
In-Reply-To: <20260728121138.1103610-8-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-8-tarunsahu@google.com>
Message-ID: <anpieno-RyRl54fp@google.com>
Subject: Re: [PATCH v4 07/11] KVM: guest_memfd: Add support for freezing mappings
From: Sean Christopherson <seanjc@google.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	linux-kselftest@vger.kernel.org, andre.przywara@arm.com, michael.roth@amd.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, will@kernel.org, 
	vannapurve@google.com, maz@kernel.org, fvdl@google.com, kvm@vger.kernel.org, 
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, alexandru.elisei@arm.com, 
	skhawaja@google.com, aneesh.kumar@kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, kexec@lists.infradead.org, 
	suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 28, 2026, Tarun Sahu wrote:
> +/**
> + * kvm_gmem_freeze - Freeze or unfreeze a guest_memfd inode mapping.
> + * @inode: The guest_memfd inode.
> + * @freeze: True to freeze, false to unfreeze.
> + *
> + * This API is used strictly during the live update / preservation transition
> + * window to prevent host userspace and guest-side faults from making any
> + * mapping modifications (such as fallocate or page fault allocation)
> + * to the guest_memfd page cache.
> + *
> + * Synchronization Strategy (Sleepable RCU):
> + * To avoid high-contention VFS locks (like inode_lock or
> + * filemap_invalidate_lock) on the vCPU page fault hot paths, this subsystem
> + * implements a lightweight, system-wide Sleepable RCU (SRCU) mechanism
> + * (`kvm_gmem_freeze_srcu`):
> + *
> + * Global vs. Per-Inode SRCU
> + * ======================
> + * A single system-wide global static `srcu_struct` is used instead of a
> + * per-inode SRCU structure to completely prevent unprivileged users from
> + * exhausting the host's per-CPU memory allocator. 

This argument doesn't hold up given that each kvm structure has two SRCU structs.
