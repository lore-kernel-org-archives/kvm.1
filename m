Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC583B27E9
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491893; cv=none; b=p7qyeanzOg1WDhJDDisu+hKpDBwUYNzxSf3SliNIczdf+dvGHAPmgnu3Q2fwST0XKDU574NAQRCnXfpJSnyKkalf9DvKkiPgvvVj7GBJcnyITOCtjrgrcbbCbD1hRZYMDQiMChviNXVUcPkpvIjvPMINPfh5xseKFGXV1B0l2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491893; c=relaxed/simple;
	bh=AIU6NGTW/RpZfTt6y2cuypcAmkoFDaCDqNNZTCJi0Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omgKD8Wd0uFOGEiL8L6w95FqzKodLn+fiQKDyiAX9UWNxMIWKw3QCY781SavfJuad9DFQ3aTXuz0v+Cxzt3hqiN4xS/lKWuKDgCkUoPXVvlepJ4b93B4N70QNpfKiB8IKZQifeDsIK8DHhHBiuUdHeyZbrGH7Jfc55MQUKv0efk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=vNaR5W66; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="vNaR5W66"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-9103f5b813aso3135936d6.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 20:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788491891; x=1789096691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I82bST350eZ9tF0sXAbqbqSO4hf+URoRFBA/uGedV7I=;
        b=vNaR5W66ftewexcRp/AydcFM2kOVhyyKwbiWjJkfWFcKb8ZIkkN6b8E+rjP6HVUcwC
         U5cSYyZVbUAGqAdRQZQ3zOVOPu7u70Ndcacjqs3bg4zToJqHloIaDqQg5NTx5+GNWpQE
         f5r3TSMDQoDUaAcqYmrLROMq1gqVO2rzqCfaxtlitpJhtM9dZTy4yC018ZQzyQjpyHpm
         1PH6t9cVDi5DHgrhFSzJ0l8dPkZZ8DHMWUc+LRRFXLxhnOOWva2zxFeYbVJT3yhzkWAw
         w13nz9WCmpGNUVzFn1LBBjcZMIDowMqeYH+G9XRpM+J1A4f8u0ImnZZ7ASV2apVR6Er7
         TlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788491891; x=1789096691;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I82bST350eZ9tF0sXAbqbqSO4hf+URoRFBA/uGedV7I=;
        b=h8gkRB7EGYPwLNL9s2u8i7N6iUlS1YvA9391L6jSj0bmQYQ8RFoq6z4tmAYrZrxDsh
         4oEtnNVW00VsAXP5xNwvyGEUJv8KPcaABYUh/MHgoDg2BQ4x/P8s8qFQCOnJ6uIFeMF0
         dF7Ks/0VzyZ3Brn9233XovAl5hHZ4ps0jL+deEURnZ20tt3lvo3XurC7kNyV1LD35xPh
         R458hviRT+aVQDlwQ1WlwKFminmLLy9HQ00N+LhCijB5ig9zPo7epcnhKOoTB7iAIDiz
         luvlQILfzSe+ifYwtf5qy+zI7TEqNd7PlxYcH80OdKyAC8wH9jxv4ZqOLiZ5LP43GFS9
         N3zQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJmm68F/ajWriux1E/yXxk2HHYtIPvevHrpXtb+IwuKML+TApj0hbe7m3Vdzeiaq+onFI=@vger.kernel.org
X-Gm-Message-State: AFuF++m3rrn0k/BD4kq5AqvCBG0ZBvvptivZxsehKjWxkWlceLnaMW27
	8hCx5vgFFrHvLmwWNDGr6+w4QXKn7ApeQMxZT6XT4XtPQmUzEw7HjJHKifp0FV7dL9U=
X-Gm-Gg: AYBFou33Bt0/uLczYR0KRi6M7U3wrvee1H7Ky0SUqoBUO6/vXyC+fV71WRYETpZHpTT
	lMWSnM38uWfm4YwhzK8D0OL5gSwOtUpgpY4gHC9jjMsChddo2EN9nGwjHFjba3mao43VCWx9bG+
	xRZiPARiYYNrz/xvhn9zW+K6pz4MIrTFjOhf2GSY6ABlZWo+iAxHX8oT1vdyMobQyKZNqnPGLSb
	csI5KRDa+OWf4nebzjw6ZpUYrgn6547NKbDRL4fUzBdnMlqbSQs4AkqvHJbsJy7xitwKbHUh2Ku
	NsqOdf8gURfLk0YA9Ab4wfHLJ4p0+rkeLfipL5dyAyR3qr54CaPotS8sC2/OxX4140WbU6rtXLJ
	xoLrBWb3DhEmOVxzOQFZBWwYjerU6Al5mSIXdHn+WnHBCY72aTpBV36WUARON65m6VYCBRNq0Gd
	idlCgBqZj9gckMy9998dhoBuLZAbA/j4bQIzDAbykJg288b3/lagFyusK7JigBBkiAFtWYon3Iw
	0TfDBZbM4KTy0/+Wg25BwBIY80YpNb66JnJ3ZpjrYIXYvpz/c53Vgw=
X-Received: by 2002:a05:622a:1c18:b0:52d:4f43:d5b0 with SMTP id d75a77b69052e-530548bc5e0mr43078621cf.22.1788491887027;
        Thu, 03 Sep 2026 20:18:07 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5305402a7b7sm11260161cf.3.2026.09.03.20.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 20:18:06 -0700 (PDT)
Date: Thu, 3 Sep 2026 23:18:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Qiqi Li <liqiqi23@huawei.com>
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
Subject: Re: [PATCH v5 25/36] mm/memory_hotplug: support N_MEMORY_PRIVATE
 node hotplug
Message-ID: <apo3bZab6qtCosQM@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <20260720193431.3841992-26-gourry@gourry.net>
 <6840c720-8cb7-46bb-a652-040c130a4427@huawei.com>
 <aoJaaYp30LnKLj1w@gourry-fedora-PF4VCD3F>
 <0334fe7d-d949-45f7-8914-3012cb11b740@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0334fe7d-d949-45f7-8914-3012cb11b740@huawei.com>

On Fri, Sep 04, 2026 at 09:05:39AM +0800, Qiqi Li wrote:
> On 8/17/2026 8:49 AM, Gregory Price wrote:
> > It would need to be reserved, and you could use numa emulation but
> > that's clunky.  I have an RFC for exactly this issue - though i haven't
> > pushed it further yet.
> > 
> > https://lore.kernel.org/all/20260610014517.253609-1-gourry@gourry.net/
> 
> Hi Gregory,
> 
> Sorry for the late reply.
> 
> I took a look at the exclusive-node RFC. The approach looks useful for
> device-backed private memory without a firmware-described NUMA node.
> Thanks for the pointer.
> 
> We are currently looking into the private-node and CRAM design as a
> whole. I noticed that CRAM was not included with the v5 series, and saw
> that others were also interested in a v5 version.
> 
> If you already have a CRAM branch or patches based on v5, even if they
> are still work in progress, would you mind sharing them? It would be
> very helpful for us to continue testing the overall design.
>

I dropped it off because it was starting to become unwieldly, but i am
continuing to maintain a branch on my github:

https://github.com/gourryinverse/linux/commits/scratch/gourry/cramtest/cram_72/

I have not posted a new version in some time and it has been reworked
significantly in the past few months - but I plan to talk about this
particular branch and the tests I've run with it at the device memory
LPC micro-conference.

I validated this branch against most in-tree (relevant) filesystems for
the page-cache extension, but I imagine the anon-only version subset is
the more immediately interesting for upstream development.

I may include the anon-only version in v6, but I've been a bit busy
shoring up the base private memory node core and implementing kernel
selftests and LTP tests to ensure there's no userland api regressions.

I hope to get something out later this month.

~Gregory
