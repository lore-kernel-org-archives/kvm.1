Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F638F951
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828915; cv=none; b=QZqpc/LFzeDNw/8WCKa/HCflBm4f4XCUUvWhB2cpk7p4t2M6/sQg/aAJKfKuoYWZImnQFkGnZgOuDp/jaK6dsNCXvkkJnZplBcXVOivbpPk3p7CdLsh1gfrm95lg1/9Fv6An2mjtv0BiUwk5xxcwXUJ4mk8e992+Y5OadbZqro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828915; c=relaxed/simple;
	bh=vOfWiDHu8KJHXpLZNL4rujIBCQsIEp/ffLVBXHg7tac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPSbgymoBDdWiBEPDSGdVmiqhh4n+6uAn4iai8EX/s+w2Jxsxvgh8Oqb68sVk4nFIBC3eGFCclH1qIfClHnyAyFHp0pegoGRGQJBNEz6T+7rq3kH7t9Qrwu0XuXw+RfOwzNPC3c7Q2dVphmuOqRHaT9wmgnKtWrIqfo9TTg8gH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=b2OV5hok; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="b2OV5hok"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8efbafa1bacso8089906d6.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 10:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784828913; x=1785433713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G2+4/YWWiPL/NjZ7kD3wcGqD98ci6jBKaqWoskADH3c=;
        b=b2OV5hoke2MYSUVGR7eJfxpU04wj6HOd+SItWjZfaAG2dAzzbFS85HNdqgmhQXR3F9
         Qn+HRwBJORjSFYm6qHCX99MaLHKwcADPb13ecOV+tMUNnB/bAPGTbngm5//z+YC2pL7A
         B2GDaCZilCefNv9Mr981OcQD1psk3owdpsF3Rjnz69KmBj5EfuZJI70fSD5CPbHImz9a
         8GARXEw9CR0PiFjKoWIUQQOLOqtS6VyOYGWBFlD/j2Me2zv/LlIVWhFf02v/ARk86ZBe
         xZ0PBU2zEEaV+RQeT/fsqXYbz6y1uSye8KIfOPUDypfBT6SLPh8M7gx2rXtA7IkSAZwC
         Dp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828913; x=1785433713;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G2+4/YWWiPL/NjZ7kD3wcGqD98ci6jBKaqWoskADH3c=;
        b=V61um7FacG5oEjXi7rSma4OVQMrMbPaJZRiHz4DERVIFj86fTUOrQuWj4/2glsU61T
         umPRD/pY0GaVmKhhzaps7LecDtFtpdbqrCDDHcnsRWQBHGOoXhdMWOb/cB1FaMNidztR
         pRgW8xKBrfuRcdXink0NRZWsmKMj9465sOacqg9KgqgBBuh9Fqye8FUeiH83537DwIFK
         Sgt3w/RQOzJrvtFvjawvX5vCemsMF4Qrd9ksiA4oFYK4bEWVoI2vXK06Y7qlCaoxqfEQ
         jNw+JQ6ZS/dzx6biqvEJFWl2tKBBJQacqRZgrEEjDQJw7XvTtxcBzIRzH/G5unmQd0s0
         awWA==
X-Forwarded-Encrypted: i=1; AHgh+Rol/n3JVXxyRw9BbLrYVVuO0HTqo3Cz1RRE1SpvSGDFwsdhxVuq50LNz57K6tgclsqwo0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaR3ZPCsIZNuoZE9aiydTdYmlJeHfYz4g/0kbIgVLMUywPmjeO
	3NMu/26UnJn3PoWGt7jOmoC2ymvUG+RK/zMHf3DDsbaadsHagPVZdKL7lGrPsrxan4s=
X-Gm-Gg: AR+sD12+TrbUND4PmFuXn81pzP/hS65M2sFRy6rxEqTiMs1pbRbTa9uEb+7lST7ytuy
	AEjXS35cuGIeVFZFXQlEEksO/RRHU6LSioJQ8+nxv+xKWbBMAc0LWMrqQcpN4Ljf5B7I3bYUr/V
	Po1G5zTXn/2O2jdb6pLS4VXH2u8i9b/Y7pSrqCNkBLKBxlQ5QkymuBJrQaAhLAY5y7DV5KEB1ok
	Pm2UzBLnSrMFVFceNsWzHWVyEtcxK1deGXXNNOxaIjm0B110oQ58B4PBFY08yKrlEp8m2H9O/4/
	eB8mgzSOYcbiGWq9VszCb6Xtbn2rGKhjSSD/QUR/rXXlziEY+2Ub1RpxCmp3/DvVBZbvC2uwRGs
	iByZONJJlWta5HdHXI/goibMvqpDY+DHd1Qxnz9tUHzo6BfiiwwQ96PWS1ZFeNo5wMcg8CxGZzd
	YnI8YbIWgNMFUsGSjktc6+VHmY8JDKhAF/SOBE78dvns3p/A5uHDIpn8roNw==
X-Received: by 2002:a05:6214:3b87:b0:907:75b9:b101 with SMTP id 6a1803df08f44-907ca3506dbmr49693546d6.32.1784828912139;
        Thu, 23 Jul 2026 10:48:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa09dbcsm50354966d6.34.2026.07.23.10.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:48:31 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:48:27 -0400
From: Gregory Price <gourry@gourry.net>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sean Christopherson <seanjc@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Neha Gholkar <nehagholkar@gmail.com>, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, vishal.l.verma@intel.com
Subject: Re: [PATCH] mm: mempolicy: fix automatic numa balancing for shmem
Message-ID: <amJQAs3Bm99ZR_sF@gourry-fedora-PF4VCD3F>
References: <20260629163337.1264881-1-hannes@cmpxchg.org>
 <amGpEEqxoLq/Y7ZO@yzhao56-desk.sh.intel.com>
 <amIcXrS7nGX-adpG@google.com>
 <amIrDncrL4K-JRBO@cmpxchg.org>
 <amIxyy4Vg_TTE8Y4@gourry-fedora-PF4VCD3F>
 <amJKOPczNMb96NJv@cmpxchg.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amJKOPczNMb96NJv@cmpxchg.org>

On Thu, Jul 23, 2026 at 01:07:04PM -0400, Johannes Weiner wrote:
> On Thu, Jul 23, 2026 at 11:58:27AM -0400, Gregory Price wrote:
> > 
> > I lean towards Johannes' stance here that consistency is better, and if
> > KVM has a known-poor interaction with numa balancing, maybe KVM should
> > simply set a default policy (when none are present) to avoid this.
> > 
> > That said, this is painful because MPOL_F_MOF / MPOL_F_MORON are already
> > a silently inherited policy on boot (added during init).  This will be
> > confusing for users.
> > 
> > This is not documented anywhere.  Maybe this change should come with a
> > docs addition that says the default global policy is ACTUALLY:
> > 
> >    MPOL_LOCAL + (MPOL_F_MOF | MPOL_F_MORON)
> > 
> > Instead of just MPOL_LOCAL and letting that silent implementation
> > detail bite people.
> 
> Hm, where do you see "Instead of just MPOL_LOCAL"?
> 

MPOL_LOCAL is effectively the default, that's what most people expect.

> Documentation/filesystems/tmpfs.rst says it defaults to "default" and
> points me to set_mempolicy(2). That in turn in general makes little
> mention of numa balancing and doesn't mention MPOL_F_MOF/MPOL_F_MORON.
> In fact these are documented as internal flags.
> 

They're "internal" and generated by passing MPOL_F_NUMA_BALANCING...
which is basically shorthand for "use (F_MOF | F_MORON)".  There is
no other user of MPOL_F_NUMA_BALANCING.

The internal/external state of uapi/linux/mempolicy.h is frustrating
to say the last.


> The numa_balancing entry in
> Documentation/admin-guide/sysctl/kernel.rst however DOES say plainly
> that enabling this feature will sample and migrate mapped process
> memory to where it's used, and that this has a performance penalty.
> 
> It seems there is a general lack of documented interactions between
> user-requested policies and the system-wide numa-balancing behavior.

Agreed, that's basically what i'm pointing out.

This is what most think they're getting:

    static struct mempolicy default_policy = {
        .refcnt = ATOMIC_INIT(1), /* never free it */
        .mode = MPOL_LOCAL,
    };

This is what they're actually getting:

    struct mempolicy *get_task_policy(struct task_struct *p)
    {
        ...
                pol = &preferred_node_policy[node];
                /* preferred_node_policy is not initialised early in boot */
                if (pol->mode)
                        return pol;
    }

    void __init numa_policy_init(void)
    {
    ...
            for_each_node(nid) {
                preferred_node_policy[nid] = (struct mempolicy) {
                    .refcnt = ATOMIC_INIT(1),
                    .mode = MPOL_PREFERRED,
                    .flags = MPOL_F_MOF | MPOL_F_MORON,
                    .nodes = nodemask_of_node(nid),
            };
        }
    }

So the default global mempolicy is effectively:

    (MPOL_PREFERRED | (MPOL_F_MOF | MPOL_F_MORON)

which is just MPOL_F_NUMA_BALANCING without MPOL_F_NUMA_BALANCING.

The user can't actually see that - because the MOF/MORON flags get
stripped out when it's queried (because they're internal only).

Maybe we should just set MPOL_F_NUMA_BALANCING in the default/preferred
policies and document that the global preferred policy default-enables
MPOL_F_NUMA_BALANCING - and that if a user (KVM) doesn't want to be
affected by numa balancing it needs to set a policy to disable it.

~Gregory
