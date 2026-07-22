Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D9426EBB
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753814; cv=none; b=ocBtvaoBAQWRlyMjWymSJHJevg/SwZ0IRixTOcQuyxwgx7n0P+q8hgoqk+oZ9WB9rDV84YyrxU8KCFnAoi6QwEAWhxZ+PVIQg2HVzHX2hkWY5kPr8HwLKkm5bv3bfIZjk1g0nUjvP725jQEQwiPr9fQTX81TVXNmKCHqqUPWRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753814; c=relaxed/simple;
	bh=s8/wCDafUQ7pmN88abnD2Ydl0D4cpNmsjgZZBVN4G00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3G5a3i5D5MjoadszVbJdbS3p/xM/vf6rAeNGaUrYpvqiJK66SLPOSsceDEDHiV/FZrnpDOi659yvxr1+ngsxBMguz6YweI9UjTddvtTVLOoAPGtZ8HpSqeUIgQUSqUrHGuwvC/o1JW8CIBF402w+h81x6b064QQuOj34Fz8Xjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BmbxhrHw; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BmbxhrHw"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52192509869so42557151cf.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 13:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784753811; x=1785358611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DrWtospFmR1X6Ml2Vs8JTWDG5C2VdzRczI8oq8UdJr8=;
        b=BmbxhrHwS6SGD+DstaxN9aum0F+qVmFaCCLRCAesmHXK1x1tbM8o4VXAY3bTRgTam9
         XN/lXuukJ8njiId9TQhkCaRPDHdLvVG/UbqfgTdVJ7GSf/bhXuLy1McqVIhavwwBnm+u
         eH9ysztsnbb3Y0hPkS5OJzKx0qvgsrYFdGfqtYdAbumPyibsoupEOFlrVRXIIl2k70T3
         EAOge8mNby2tH4tbCTbQnpGhXvpzaKnk8AB4lrEjLDfvD+NmiYvFPPRjv4XfQeD4YzrJ
         ldCwOWXJsoNHETHoVs0VPJZNiN+TJ5HMUYIlSh7Q19XCK5ykMuHxhknCy8215sucxrl2
         8/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753811; x=1785358611;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DrWtospFmR1X6Ml2Vs8JTWDG5C2VdzRczI8oq8UdJr8=;
        b=pZKpvSTLRLbc3nirE9CAKXpybAo+DRuTnhn3KlIeObYwwUGJsRD1AczTBXzaBzYi1B
         6hQVY6khaFe/E9RoN5tiNOMB3a+Uhlkf1MR0dsw2FvcSWbPo/n9mDcC4o7+WjeEz77ub
         hd76t1egVt8hv6jb1kt/Q2dAunFCE4KbX044WkbESxISX6fT6FDGR1B8IRQ0QUURRpsM
         iOKDrQ6VwCcyMV8VRNGIjzpHqO3Tli8ftIfV1RkEWsnpsYtAt6LeVJDc+7/T3iOXCJdA
         7Q8ezgSE4IFB9qMloX3sCYz8WXKzLIKX7Xx9FVmLIKxb+kp/S9B3Nssr6l+m+ppAL3RN
         ms+Q==
X-Forwarded-Encrypted: i=1; AHgh+RoE7HAKzlXkzaV8TUT+209q84c8UKkgL1R0ZpUYMJ0rTAgC7MkyOgLfDJmT/ZC1QRwUHtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzloNKMUrOyqVrDULj3q2UuNa+mc23mva/4ic8Izf3i7SACv49Q
	faPJ5BkmI2jPsBvYKLzoaj7VPXyqzCutNefuACI/uPuIxBIhHZPyGJyNBYZlImke29M=
X-Gm-Gg: AR+sD12gOXd7Tv2pQOCeQoam98nH+FYQH6V1/al6u4kVii3GCHs3SmVB5vfp9nZ73un
	90h73V+uSD6qm+caTKniPnidnKRKlvdxmbJigv4/aD98EYRdLo6WzIRsExWi7izPSA/E69G3D7C
	VPytkoDVXyHdT2UEe/acDzqm5wa9CVFej8Wx9jwNOiTYUtq/xxBtzg6m5az73eWA4ElBO7PT4Gb
	mGX9lJul8lhHL/J118QvjZChuP0nnOy2/36Wu6ccdA0W9IbzzJKo0QJKESBwcyBPPfPBRYUCl/j
	q4jLSLKT9hulRVqzcTkL3geSX8A4dmbg/ZtA7DUaz5ugILSGp+MW1GKAUj49nh0ttcMTpShl9b9
	0GaOIs5o9FZ4srjhe3g1i0T+mXm0DB3YXq1i0IHr4W7ANz7yMVeQPEX29Rok58CgJflLvXAigQm
	r1StGDkD+qCWf62jGkOsHtsY493sFRU4VCHl6wZgV94xJpwO7j7dcSpTnJNaAaBhq6m4j8
X-Received: by 2002:a05:622a:997:b0:519:5680:1b5 with SMTP id d75a77b69052e-5283de4650emr1484841cf.21.1784753811471;
        Wed, 22 Jul 2026 13:56:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba672806sm29772246d6.0.2026.07.22.13.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:56:51 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:56:45 -0400
From: Gregory Price <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com, 
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, osandov@osandov.com, 
	jannh@google.com, pfalcato@suse.de, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com, 
	peterx@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, usama.arif@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v5 00/36] Private Memory NUMA Nodes
Message-ID: <amEpR83RtiqstjNs@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <amDL80BSEP6u9XfE@MWDK4CY14F>
 <amDVQopyvolxfX8K@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amDVQopyvolxfX8K@gourry-fedora-PF4VCD3F>

On Wed, Jul 22, 2026 at 11:40:06AM -0400, Gregory Price wrote:
> On Wed, Jul 22, 2026 at 10:20:00PM +0800, Richard Cheng wrote:
> > 
> > I saw the reply in patch 5, so in fact there's not only one
> > dedicate zonelist, but numerous ?
> > I raise the question because zonelist was supposed to be a
> > global, unbypasssable thing in MM design, but now what you
> > are trying to do is to seperate the whole global list into several
> > parts ?
> > 
> > Can you explain why in current design you don't consider to support
> > something like ZONELIST_PRIVATE[n]={0, .. ,n-1} ? that's my imagination
> > of what a global zonelist should look like, no matter private or non.
> > 
> 
> First let me say that there's nothing that prevents us from doing this,
> and we *could* make this the default case - but this decision was
> intentional by me.
> 

You caught me on something here - I am wrong about my own code.

I described to you how I originally implemented zonelist isolation,
which I walked back when I was testing mempolicy and demotion.

The current code and the comments in the code are correct, we get
the following zonelists.

N_MEMORY : 0,1
N_MEMORY_PRIVATE: 2,3

ZONELIST_PRIVATE[0]     = {0,1,2,3}
ZONELIST_PRIVATE[1]     = {1,0,2,3}
ZONELIST_PRIVATE[2]     = {2,0,1,3}
ZONELIST_PRIVATE[3]     = {3,0,1,2}

Meaning everything except for MPOL_F_RELATIVE_NODES works (because
of cpuset isolation, but more on this in a moment).


So what I shipped here is what you are describing.

Looking back at my notes - I realized a few things that lead me to
walk back that isolation:

1) mempolicy makes more sense this way.
2) reclaim/demotion is easier to implement without isolation.
3) The individual service checks and nodelists handle the rest.
4) It overally just makes more sense.  If something breaks isolation
   it's because there's a bug, not because of a structural issue.

For example in demotion we do this:

demote_folio_list():
    /* Get demotion targets, find the best one, and demote */
    node_get_allowed_targets(pgdat, &allowed_mask);
    target_nid = next_demotion_node(pgdat->node_id, &allowed_mask);
    migrate_pages(demote_folios, alloc_demote_folio, ...);

Where the first step already filters on CAP_DEMOTION.
The result is still clean - no special iterators needed.

What I realized from your questions here is that since i walked back the
zonelist isolation, I think i can actually include any CAP_USER_NUMA
node in cpuset.mems and allow parititioning fairly trivially.

I think this might be the last majority complexity falling out.

Thank you for the questions - this has helped.

~Gregory
