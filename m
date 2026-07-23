Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F593365A1A
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832362; cv=none; b=uuakxsuLD6YGZq3+1j17q55SY//vKvbMRAVTx6WzEQH1s+nXXQpWxmoUZ57BQlHraKecG3yiUw4aA5PgM7iUVIookzO7nkrUT7Dbx58Q9AznRjsydPvrfuRIhyAeVsNlfW1iwwgwBbzya9qlmc2tV8kQ0NWu23yxOff4AkdVklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832362; c=relaxed/simple;
	bh=LPFtNwvaq4iknUN8ryy9bvqn4NvsGt3LGnIJqR6PdXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuFddJxYia0Fi6J8H0HLDOBhpw3lJ5lLaxh8N7dVKPnW49rlUcsJbxKXP/yplQO22dMhbLnUSODUhyfM8meaCKJgO9JUhoK7Pd9A55IVSRmkmiMQy6GD+QxTwFHjpWdObgqir2tfkVemGn/GxrgR7JlOIQoaFo64hFyoBjP5m5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lTJTPlIo; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lTJTPlIo"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e512a9a6bso77025285a.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 11:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784832346; x=1785437146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j6ufwgXideJpYnCHTcqdI7XFL4I7bDx4wDEI8wCsug4=;
        b=lTJTPlIovsZh/NkCV2kpXgCHz7MnGJKeZ3o2OsDRztfvrH9WLLSlF4L94aAhP6mrGY
         zmnDB7G/nTuMA51SvCx84csUWApJGp7srNWUAi70Miwnx5GClPSLmPFKzuSnsZDEeS77
         /MPHpMJXbvBZtqqWdFaHvbp7K5u7zz2iI3AJgA9ixRSIyTSEM/VKz/1rV5wcqDjPV5KD
         xkro2/ExspXRUxbRYvYC9dXhg+btMuhGePlGQrEeMrcnkX6QjjDEV7tfDDE0soRQdX2e
         eyvP+v9hgN2MZjDI0n52LRofVqkzQdzxVrjGfJ+VLgfwWYlHFX9im3i/dzjoEKCmrKSI
         x23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832346; x=1785437146;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j6ufwgXideJpYnCHTcqdI7XFL4I7bDx4wDEI8wCsug4=;
        b=T0fnm4qPN9GjPH9Afeh82+mmrCZNgLVrC5OxUhTK2xpwDDvFpUMugQE3zB+sWFmEKV
         s57OZ/NEbRIGClGetysiAInsVhhRhLSwXJBg8x3oImumgJWU4gVhMmK1RqHMS2wnw4zz
         c/revBvN+jerU7rTa5SznW6QOPdawjzR1Y4K6ZgAK25DTfnRGMclaI0jso+wbOjhOU6v
         RujYe1ifRD6OntJMERUxOAA5zG/Y/okngzay1DLizhPJ7bAA3k43GRcawSCobszlyRSw
         T5VIJK57UPFgR1bg5ALw/XPsIBV/pAOGRAYTtR6Zw+zgowu3ohRwIfNKU0BcbxgYD4tH
         zycg==
X-Forwarded-Encrypted: i=1; AHgh+RrncTRKdmd7/ifBWjFzVc5GrwhmGGT47EqwCnTrn/BnIF5p1LyKL9jDcfCLgnWPxpaM+30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xHGK1+GODiIDz8hT/+52sjGi+w+w1E8XCq0JC/brTCVJ0/CC
	F41MXT29Rq7B0XDEQWxEaLARkHGXnPS7AFgwevEfOcOUxz7ux+g3WS+BjV4oKXx8rdU=
X-Gm-Gg: AR+sD10joYCihbmpSuVjWH4q5qWxywm5TAw76bO+5+rn9oZq62URkTsWcahwwnLcyLb
	pHbvH7gUQ9BaDvEaMerJb04dTHPPGf1vUwp7dQ5YBhI3MSgrxRIP0UnGJOT2sUlRHkNEGFBKbWB
	rPjXVdh0GOvPzs0vLGHUGKwY0SY2VXoJy6zrsuaNNrrTCicPyxWmdm6j1jPoCgmTpvo7ODqcNdy
	TLk7daMRbmIyrm1aVB3SeHEqhtImWFBSkEj2VBJRd825X6xUmW4DaeIoY7M5g8cMxHqe9pYiyBX
	PnUWqdEg6oKSbCPDdZyL402acAbkalB79RZCGLCoR1NJn5ZeVqMSSCAy/XEXbyxRCpR0TGV+dmQ
	y5iP8AoE1Lw0Yg7P/ZqMkkjcexx2qM/hii2Z1lYllJZyYT0WXZhNvD1NWMuOIbJ26REW5YCrZkz
	vU/qBgEJI6Vqfh6ynjsw4eeHHbURl5nNqtfSRhI9AUZfnw3KBnEyUs388IjQ==
X-Received: by 2002:a05:620a:371f:b0:92e:7d53:8e83 with SMTP id af79cd13be357-9310391f7d9mr467983085a.56.1784832345663;
        Thu, 23 Jul 2026 11:45:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a6bd88sm470112785a.39.2026.07.23.11.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:45:45 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:45:40 -0400
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
Message-ID: <amJgdSXxFk24e94p@gourry-fedora-PF4VCD3F>
References: <20260629163337.1264881-1-hannes@cmpxchg.org>
 <amGpEEqxoLq/Y7ZO@yzhao56-desk.sh.intel.com>
 <amIcXrS7nGX-adpG@google.com>
 <amIrDncrL4K-JRBO@cmpxchg.org>
 <amIxyy4Vg_TTE8Y4@gourry-fedora-PF4VCD3F>
 <amJKOPczNMb96NJv@cmpxchg.org>
 <amJQAs3Bm99ZR_sF@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amJQAs3Bm99ZR_sF@gourry-fedora-PF4VCD3F>

On Thu, Jul 23, 2026 at 01:48:27PM -0400, Gregory Price wrote:
> On Thu, Jul 23, 2026 at 01:07:04PM -0400, Johannes Weiner wrote:
> 
> So the default global mempolicy is effectively:
> 
>     (MPOL_PREFERRED | (MPOL_F_MOF | MPOL_F_MORON)
> 
> which is just MPOL_F_NUMA_BALANCING without MPOL_F_NUMA_BALANCING.
> 
> The user can't actually see that - because the MOF/MORON flags get
> stripped out when it's queried (because they're internal only).
> 
> Maybe we should just set MPOL_F_NUMA_BALANCING in the default/preferred
> policies and document that the global preferred policy default-enables
> MPOL_F_NUMA_BALANCING - and that if a user (KVM) doesn't want to be
> affected by numa balancing it needs to set a policy to disable it.
> 

Walking this all back:

  - MPOL_DEFAULT is the default policy
  - numa_balancing=on means enable NUMA_BALANCING on the defaul policy
  - shmem was broken and did not respect this

Johannes' fix is correct, and there are no additional changes required.

Users enabling numa balancing while running KVM with shared regions are
not getting what they're asking for presently - that is a bug.

They should get the performance hit they're asking for (and then either
turn off numa balancing or set an explicit mempolicy for those tasks /
memfd's).

~Gregory
