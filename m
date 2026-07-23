Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF124968FA
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814692; cv=none; b=neqmRF9dLf8CIYfsfi4qi0+/7IMZai2X9pYSKUuSw2QQ5Oh7NCAsl3lctLsRX1HKAfNU12w5BIaQ1kVmtK0FCn6//WPav7tUcJNYzy6rXwpJdzaBNqlgjGI77SVtvMTy71EgrTRW5/hOTgMuIzArRAriw8AiCabMRJEVUsUBVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814692; c=relaxed/simple;
	bh=gN31rOLFFLWTk/SpUrbC69WWWfuCLoPuE+4rmxeHq4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XKV3MLitj5hzyR2FvKOAt1yNBE+miyQMscQ3tVViafqPYziqKbaHmk66hEbDUG+8BUMKnsP7Hhzd4f7Kak+NeDnUA3m0YQdzdjDALI6xLWEj1Icbg7hvNx5BbwEQS3poVSpUM8WHHC4BdwLOvIGSwCwG+eN7Pz+0t2Na3tOZGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRK/gt43; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRK/gt43"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc8bde6318so12072285ad.3
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784814687; x=1785419487; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oGPMnBPG8DN0GWvTrl4frHL5NuZB07lUxK+6EcBmBHI=;
        b=SRK/gt43pUyNu1gelwqFBuCcOHgKx4tpnubycjq4FXDr9Q0IeJwPGvawz/9mqLj8Ff
         YF+cV1I+B8bWyNdusr6JoGa19YL9okPI43aCIn3yNVydahejzjAqAXlbQDYfhFTmkAyK
         xS58CKU+JLHVjyZN8AMs0QyoKhOFBh3QTP7+Xq4xcg6DSAj23d1q+n/xvBgeyCYPqDIS
         Sfk7Vs2ZDyImZA+9EcErexZhZLUj8GoS3keK9q8xr5V7uyLh+lYW3efr7gRlu1c04hqV
         n7NcQM/t9pKXLc2Lsc9btcmfMPXFBAk2LZzSYjMXZyS0Rw1w7h+tWN+gU/U/I5+2sjN/
         oyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784814687; x=1785419487;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oGPMnBPG8DN0GWvTrl4frHL5NuZB07lUxK+6EcBmBHI=;
        b=URiSlreFpoOP8FeBjMUy8dnU53MQ9RtrGBUFvKVmCtup5a+siI1ObsEoYpND0ibn9s
         Rvv56GQLoUbzdeHnWprbjXCuaMQiWxUWUrZH5WaP43uPzRWeENrwCm4AtJlDhEQwScoz
         fkUl/L7772K0XlYX2kHUok1BCCqNUSczFPqMJmX89XRARQFnrEVaxfOWqY/6ucVaAPG5
         e6lxHY/gwWA24e19dgPssGn2Dsn493QmRUn4BaNbkC76LdBy3fhcPLN9i8I/p9TTe8WP
         sQgEyIFljD9HIHy/sLrGiS3YOZqfH1EizUkmLWg0jHeeBLxvt0Lohp2ybgFUtGAlCN6J
         s/lw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5LaWES/2qy4cQjMsbvewjkG0i/WM9KD1R10rSgvz8tFse1dbrNuPhzH9skpBiz3wWkFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29SksU32cDx8FmDCycwhUHdlAM0Zqp42g819pLC5GNByLLnQj
	J7ilybJO4DCcecn7Zxhjuy2E3965hMSGsVLczmqzBSE/6t62SeqJ6F7UtV3OtzKxoLkf84nn3Q8
	/3GRodw==
X-Received: from plbjz12.prod.google.com ([2002:a17:903:430c:b0:2cc:6ddb:debc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:244a:b0:2c6:9f66:d573
 with SMTP id d9443c01a7336-2cfa6b7d4c0mr39323625ad.2.1784814686615; Thu, 23
 Jul 2026 06:51:26 -0700 (PDT)
Date: Thu, 23 Jul 2026 06:51:26 -0700
In-Reply-To: <amGpEEqxoLq/Y7ZO@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629163337.1264881-1-hannes@cmpxchg.org> <amGpEEqxoLq/Y7ZO@yzhao56-desk.sh.intel.com>
Message-ID: <amIcXrS7nGX-adpG@google.com>
Subject: Re: [PATCH] mm: mempolicy: fix automatic numa balancing for shmem
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Neha Gholkar <nehagholkar@gmail.com>, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, vishal.l.verma@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 23, 2026, Yan Zhao wrote:
> On Mon, Jun 29, 2026 at 12:33:37PM -0400, Johannes Weiner wrote:
> > Neha reports that mapped shmem aren't considered for NUMA balancing,
> > noting convergence problems and bandwidth bottlenecking for cachelib
> > based workloads on tiered memory systems.
> > 
> > Looking at the code and going through the git history, this doesn't
> > actually seem intentional:
> > 
> > Commit fc3147245d19 ("mm: numa: Limit NUMA scanning to migrate-on-fault
> > VMAs") added a vma_policy_mof() gate to task_numa_work() so VMAs whose
> > policy lacks MPOL_F_MOF are skipped from NUMA balancing scans. The
> > motivation was a real usecase: Oracle was pinning shared segments with
> > mbind(MPOL_BIND) so trapping faults was both expensive and pointless.
> > 
> > The handling of NULL from vm_ops->get_policy, however, treated "user
> > explicitly opted out" the same as "user never specified anything." For
> > VMAs whose shared policy is absent - the common case for shmem - the
> > scan was disabled too.
> > 
> > This issue is old. It probably hurts less in conventional NUMA. But it's
> > very noticable on tiered systems, where entire tmpfs workingsets can get
> > stuck on lower-bandwidth memory.
> > 
> > Fix this by having vma_policy_mof() use __get_vma_policy() directly, and
> > thereby handle the fallback to task policy (-> preferred_node_policy()
> > has MPOL_F_MOF per default). Every other consumer of vm_ops->get_policy
> > already handles it this way, the scan-eligibility check was the outlier.
> > 
> > This preserves Mel's intended fix: don't scan stuff the user explicitly
> > pinned. But allow default policy vmas to participate in balancing.
> Hi,
> 
> This patch introduces a performance regression of a KVM stress test, which I
> addressed in the KVM selftest itself (see the analysis in the patch log).
> Could you share your thoughts on whether the userspace fix is the appropriate
> approach?

Yikes.  This could have meaningful "real world" impact on VMs backed with shmem,
not just on KVM's convoluted stress test.  NUMA balancing generally performs
poorly for VMs due to the higher costs of VM-Exits versus page faults, and due
to inefficiencies in the mmu_notifier interface (KVM does a full TLB shootdown
of the affected VM on every MMU_NOTIFY_PROTECTION_VMA event).

My stance is that using NUMA balancing with KVM guests is a terrible idea, and
that anyone that insists on using such a setup gets to suffer the consequences.
But in this case, IIUC, this change will "silently" enable NUMA balancing for
shmem-based KVM setups where it was previously disabled (albeit unintentionally).

I'm not fundamentally opposed to the change, but I do worry that downstream KVM
users could be in for a nasty surprise.
