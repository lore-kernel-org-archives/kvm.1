Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E529B200
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818454; cv=none; b=cLwX7jlaCfLl6iTPXCviAcGlhtvSKpkXLdc+sgJDLFoopIfWCneb5x6ezHz5RHS4iaDTUesE7YnOETyw/PVt5dQX3gNrFHYhv89tH/qOFDnQiBXXcMkngFHpccqcKv1sHY/WivvTauX8BViGUbbNFFS16xZv7p+/1BtuccxQeyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818454; c=relaxed/simple;
	bh=Rl4UTRheJ78F/7WqbhrhfxyBBQ3AxzdN+uzC71aQ5eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQPXUUEPCcMrp5XF59M+KpkA/493DXK5Qo2b2DUv5QPnXRbkiwi2PbdfQbebiWEJ+nyL3a9twEChVwfswK67nztyZE6W//RgIHGflxDi4mVh9K+ZrThfF+LzHpUDlhtlz8Ekbd+15wB1XxK6rJCe6XI5rAgV48hCYo1BipNM6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=cK0S8fAG; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="cK0S8fAG"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8efbafa1bacso6173126d6.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1784818451; x=1785423251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dLLxSZLuQjnUsz6lY8chbZ4xGpk55UfyIcJeXwJcjf4=;
        b=cK0S8fAG6Q3Bl8Snc+CVMK9HpTB7C2y0IO0IhOjqK9cx58LxrWfpv3Of54WFryHZN9
         MSsd608cIHzb0BH193wv1IeP+TfrsR3nKOOuhV95PkSF0j9vAcC+eoTESP5bMlHEW1bJ
         aq8ufWgXs7qx47bMJnzRUKMBz4Lg3z/YcOGEpIqQ4Osr2uKJu+lXmvzKpLZi9jbdZ9oE
         dKILo0A8q4y8d25l509IMqeTGwkiVcxuZt2El1gI+XHsBOMfqCPeb/LFPxX6pXUDK8Nd
         hBH4j30jwc03dR73Tj88lW2KRHnXigCho9gDMt4ZIqXLP8yJsi7QIP7KTuj9wtwQmcFc
         L0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784818451; x=1785423251;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dLLxSZLuQjnUsz6lY8chbZ4xGpk55UfyIcJeXwJcjf4=;
        b=MtlzxwYmVgpxEMDXS++smygbi8kIiXq3c06c/nvdOnvAThXSb8JrkTbOpBQeL8mKOf
         /wdgNpZiiONNM2zs/fYSJ8+7Ws6QQ43VJjw7vCWAjrf+aDQGFE7COnbWGYPfRq2tjsXn
         CZUFAqd+b4sesxxlQo0QICKkU/TWZDlduTWW2DCYcOnuVKFpyzV7POU0eTME0/4x23Q9
         pyf6C+cb4qDlNzQWNvihWyF2Pd5sP8JKiQPU2Is7jVd2CgLUj5H54SarvqIVrKDUtz3d
         7DLPOb89RDQZJB4g2oC2dNRWSw9T0T2c1VA2Z0EMXK8gjT5oOlwq589s8et6iB8JlTjG
         KA2A==
X-Forwarded-Encrypted: i=1; AHgh+RqaKiNdPuzkDBJTvbTwUaI7DYD+UjX1mJlhILxjgp3W22gbEryxoobIkD6s3a6efKHiJUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NyW/pREIVF3c3iZdJlb58a1YTK9f8AYvEnTbXGviSQHWFN7R
	dEjHrPy+6w1sCw9R6Cm80YhV1dWLD1CAXjvXg3lxbi6ABzawkTvMcY21/F5NgCoVDhc=
X-Gm-Gg: AR+sD10W1W7+s6MK8XIGb81DrV0gDRdfgm04S0yA1DpcMLC0QZ/iuKCRYqcIcaXBUti
	ysMmBGOqn/DrsBUq++5RPI5i3e7iX8wk1KyBEjB8B47NuLq/udMJ3y5JpeQxc5qX2MFJuh9KeuO
	enJ7lQDr2u0SvlYUxt8mfhPJhFNGTpYTNKjiA8LrBRQAYhbLNTQvD/OVXnr1vZiKMBxbb4C02Pd
	vNXj8ZzKa9wRDgWDH994iGJ4EcFJzz7T+6mNanmScKRtD05mbcFWJl6i9vhCRzAGXuRDl5dCGVm
	lkXsAebNEgN+xqiBDxNRFspAKGNZd+lTdG4pDjvlfHwGpJdTVdToR0LLk9Z2ij65/USYiCA6tPb
	Z3ATYEa6vI+A6B9mHD4YoHTdYvkoNc9ZSbtAeYbXjzh/5QrCpfwP72oXw3XSHaxSCqfp2H0RQ7D
	kZ
X-Received: by 2002:a05:6214:19ed:b0:8f0:779a:d2e9 with SMTP id 6a1803df08f44-907ca5524f4mr46157826d6.46.1784818450912;
        Thu, 23 Jul 2026 07:54:10 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8d5434sm46798176d6.13.2026.07.23.07.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:54:09 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:54:06 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Neha Gholkar <nehagholkar@gmail.com>,
	kvm@vger.kernel.org, rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com
Subject: Re: [PATCH] mm: mempolicy: fix automatic numa balancing for shmem
Message-ID: <amIrDncrL4K-JRBO@cmpxchg.org>
References: <20260629163337.1264881-1-hannes@cmpxchg.org>
 <amGpEEqxoLq/Y7ZO@yzhao56-desk.sh.intel.com>
 <amIcXrS7nGX-adpG@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amIcXrS7nGX-adpG@google.com>

On Thu, Jul 23, 2026 at 06:51:26AM -0700, Sean Christopherson wrote:
> On Thu, Jul 23, 2026, Yan Zhao wrote:
> > On Mon, Jun 29, 2026 at 12:33:37PM -0400, Johannes Weiner wrote:
> > > Neha reports that mapped shmem aren't considered for NUMA balancing,
> > > noting convergence problems and bandwidth bottlenecking for cachelib
> > > based workloads on tiered memory systems.
> > > 
> > > Looking at the code and going through the git history, this doesn't
> > > actually seem intentional:
> > > 
> > > Commit fc3147245d19 ("mm: numa: Limit NUMA scanning to migrate-on-fault
> > > VMAs") added a vma_policy_mof() gate to task_numa_work() so VMAs whose
> > > policy lacks MPOL_F_MOF are skipped from NUMA balancing scans. The
> > > motivation was a real usecase: Oracle was pinning shared segments with
> > > mbind(MPOL_BIND) so trapping faults was both expensive and pointless.
> > > 
> > > The handling of NULL from vm_ops->get_policy, however, treated "user
> > > explicitly opted out" the same as "user never specified anything." For
> > > VMAs whose shared policy is absent - the common case for shmem - the
> > > scan was disabled too.
> > > 
> > > This issue is old. It probably hurts less in conventional NUMA. But it's
> > > very noticable on tiered systems, where entire tmpfs workingsets can get
> > > stuck on lower-bandwidth memory.
> > > 
> > > Fix this by having vma_policy_mof() use __get_vma_policy() directly, and
> > > thereby handle the fallback to task policy (-> preferred_node_policy()
> > > has MPOL_F_MOF per default). Every other consumer of vm_ops->get_policy
> > > already handles it this way, the scan-eligibility check was the outlier.
> > > 
> > > This preserves Mel's intended fix: don't scan stuff the user explicitly
> > > pinned. But allow default policy vmas to participate in balancing.
> > Hi,
> > 
> > This patch introduces a performance regression of a KVM stress test, which I
> > addressed in the KVM selftest itself (see the analysis in the patch log).
> > Could you share your thoughts on whether the userspace fix is the appropriate
> > approach?
> 
> Yikes.  This could have meaningful "real world" impact on VMs backed with shmem,
> not just on KVM's convoluted stress test.  NUMA balancing generally performs
> poorly for VMs due to the higher costs of VM-Exits versus page faults, and due
> to inefficiencies in the mmu_notifier interface (KVM does a full TLB shootdown
> of the affected VM on every MMU_NOTIFY_PROTECTION_VMA event).
> 
> My stance is that using NUMA balancing with KVM guests is a terrible idea, and
> that anyone that insists on using such a setup gets to suffer the consequences.

I agree. Surely we cannot leave shmem balancing broken due to
that. It's also not clear to me how many people even enable numa
balancing.

> But in this case, IIUC, this change will "silently" enable NUMA balancing for
> shmem-based KVM setups where it was previously disabled (albeit unintentionally).
> 
> I'm not fundamentally opposed to the change, but I do worry that downstream KVM
> users could be in for a nasty surprise.

This should be very visible in early kernel validation after an
upgrade. VM hosts tend to not do much else, with VM memory dominating
the host. You'd expect a significant uptick in numa_pte_updates,
numa_hint_faults, and a change in per-node nr_shmem stats. And the
patch subject makes it trivial to find in a commit delta scan.
