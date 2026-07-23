Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D34734D9
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826441; cv=none; b=nsZeNJvVbuxCTM85i+hYn8O+AxmcpDDEhCnUrOkZuLaSmwKCGbYJgOK7d2EYCID7MOrlUFOgpOZRychJD6EjXOzWy3LTYWJQ3OWC/IxVek52X9wV0s5cnjUOneoJwRQBnTfdr2LWR1yyWXJDjAX86zBIVn1sW1vZriGEJ0gIwSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826441; c=relaxed/simple;
	bh=vaGPFqyOPtGK/NPyUdkbXxLgCQ/ZxcDp8ygzXnQM2sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwfnD5mIxzFdYIetpMzSp1pa+PCsfa2FnYDDRbJ7YRHUEQhoPZ15DekmlBJeU00JxMo73nlLLKMGujF8/wbuiHwpbrJa5Bq111KoJ3fqd1LwOXJtC3AO6tWZ6sn3wo39o1Ek3mPr1iRa9Ax08WX8mFOKmZYNkH4V+TZoYx8oFJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=dr6D71pd; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="dr6D71pd"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8f256eaedf8so11481906d6.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1784826429; x=1785431229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6nTISuiCBMBC/x5bhGnScXYmL0t1DEe+uFhjm9NEqZI=;
        b=dr6D71pdkJzaZoA573EzcDPgqkVMwCs3l8007MpPJFj7mfhGF6RJEvvKxfz1m+LkAE
         CKoD0fn9fNVo1SP3g4Y6r0cNLMq9QiDWI40Z0PnfE9C+r+IUrpVhHMv9p4nUnKEKTV9Z
         ur31PPNSrT4tDcWJZ1/rZdcXFfbdt3AbdSdsed43OMTuS8lWzwSaSwAhJNO3NrmoVbOY
         bYwfm0RmlI8++YaRCim0HcKSyJzcTtAT1wQsml1yNcjf8i27hIKmotoFZg2LQIzoZjZC
         6do0lsviqsAh4q8xGfLOYx03whDjuiQ7HXyeS7sT03UQwYjausl6QYeuzZFmU38BI8us
         9O6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826429; x=1785431229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6nTISuiCBMBC/x5bhGnScXYmL0t1DEe+uFhjm9NEqZI=;
        b=m94K2VeP4HH9uZ7V6H8hEHWkHSphSAVIC0irhtFo3xR25UStcVPs1fMK2XqW5D5PXS
         vxFAJwPEN79ufQ8EeFe+H0fVKxDs98ZWvDu+3aaQZqtCVzglE0VJN6LaLrS5LbRdjArY
         cqIS10s3cgG8bKDsEkbJaB0dzITTYAHN8fnAnL52oX9nnOApMBTp2fb+aUeUZJpFdQt2
         Mdb70ceAjMCCS6DAi3o0Yn1+OWy5nFvj90khQBvM7CVl9fXUm3qh46CAK4ezHow8QBxM
         SrIIpDzmxaZBw0oD4pDG33V65ffkTRHkLV6k2wjQKiGlH7p+bjk37w7AXBbSTIlRYYE0
         TncA==
X-Forwarded-Encrypted: i=1; AHgh+RqhBlaGWpBWUyxYJTtfYUmV9I1Hh+gxlN0OjbDA5C5DcP9f7DTcoUJZSuoOeLkAeUEWfVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/KGnAIjOguSXzWXOCEVwmtIDLMQx5r37NDlX3O1R0BQS8L0y
	LcHHeBwXEC9w9cpIbuzPwvG4yWhWKKcHCvPqm+kg39fIQX+cUK2XdVoAWuBGIB/gQaM=
X-Gm-Gg: AR+sD10EkjfdchT42ofd2m/RP16cCxnIZK2zf1LTj/deSpBGKe6YcN4iEt48oX1YK57
	IFh/ZYv0jU448F2uRlgbAkdyaaTy1dG5Duo+2Tzc9dy2DhFlkxYjgfBfeT0LuTBSFja/9cGE4RT
	vhtk7IdQBoNs2HbVrWTD0uSa3AhynwOds7DwAIw2iibX9JootjoloVzwqfzXDfjSAWCflQ8K4Ur
	0+ssU0HFxHEhnOqzzOiOstvLqMvSISmnstDNxKSWLw1qhy0/ea3Gi/eQ3L4iqPNTXFAB9SaVN4L
	xKYWWHPVELTjMfT/pQ8N5/29c9o6v3xgR7AcJOAYbemaf4HPsjP91G79xcZfC8bXlx5uGxV42ou
	YAqDlzN/IF+8EQCHsVyo4ryiqbs5r+SbiE9zb1+xmFYcvPamc3u0zW9+zg7YhS8088gvN8mWPWb
	XT
X-Received: by 2002:a05:6214:5d0a:b0:8f1:579e:a41b with SMTP id 6a1803df08f44-907ca295150mr42984396d6.24.1784826429087;
        Thu, 23 Jul 2026 10:07:09 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8f2a8bsm48949526d6.20.2026.07.23.10.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:07:07 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:07:04 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Gregory Price <gourry@gourry.net>
Cc: Sean Christopherson <seanjc@google.com>,
	Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Neha Gholkar <nehagholkar@gmail.com>,
	kvm@vger.kernel.org, rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com
Subject: Re: [PATCH] mm: mempolicy: fix automatic numa balancing for shmem
Message-ID: <amJKOPczNMb96NJv@cmpxchg.org>
References: <20260629163337.1264881-1-hannes@cmpxchg.org>
 <amGpEEqxoLq/Y7ZO@yzhao56-desk.sh.intel.com>
 <amIcXrS7nGX-adpG@google.com>
 <amIrDncrL4K-JRBO@cmpxchg.org>
 <amIxyy4Vg_TTE8Y4@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amIxyy4Vg_TTE8Y4@gourry-fedora-PF4VCD3F>

On Thu, Jul 23, 2026 at 11:58:27AM -0400, Gregory Price wrote:
> On Thu, Jul 23, 2026 at 10:54:06AM -0400, Johannes Weiner wrote:
> > > 
> > > My stance is that using NUMA balancing with KVM guests is a terrible idea, and
> > > that anyone that insists on using such a setup gets to suffer the consequences.
> > 
> > I agree. Surely we cannot leave shmem balancing broken due to
> > that. It's also not clear to me how many people even enable numa
> > balancing.
> > 
> 
> I lean towards Johannes' stance here that consistency is better, and if
> KVM has a known-poor interaction with numa balancing, maybe KVM should
> simply set a default policy (when none are present) to avoid this.
> 
> That said, this is painful because MPOL_F_MOF / MPOL_F_MORON are already
> a silently inherited policy on boot (added during init).  This will be
> confusing for users.
> 
> This is not documented anywhere.  Maybe this change should come with a
> docs addition that says the default global policy is ACTUALLY:
> 
>    MPOL_LOCAL + (MPOL_F_MOF | MPOL_F_MORON)
> 
> Instead of just MPOL_LOCAL and letting that silent implementation
> detail bite people.

Hm, where do you see "Instead of just MPOL_LOCAL"?

Documentation/filesystems/tmpfs.rst says it defaults to "default" and
points me to set_mempolicy(2). That in turn in general makes little
mention of numa balancing and doesn't mention MPOL_F_MOF/MPOL_F_MORON.
In fact these are documented as internal flags.

The numa_balancing entry in
Documentation/admin-guide/sysctl/kernel.rst however DOES say plainly
that enabling this feature will sample and migrate mapped process
memory to where it's used, and that this has a performance penalty.

It seems there is a general lack of documented interactions between
user-requested policies and the system-wide numa-balancing behavior.
