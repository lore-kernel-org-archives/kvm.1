Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1B3264E2
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786584075; cv=none; b=J/+leFF6fisD/WG+Oy1wtlgNGzDCiWm/gm1Jt+qqdtOmd7aZy8qLlbg7FvZteAPZAumGQnNasfy8ZzccsIRsWp3JrLq/+NvlJZOKr1AJ8IF7uZn2NgU+87NjN1zZPy3n0iYJjoio0IqHFYAAjsJg+DMtF0KNoctenPAPVwUwLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786584075; c=relaxed/simple;
	bh=jQAWRVENXd5JGHsxo/hf6vUttuV6ujE/QtYCehIVHRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkZ/Til3b2tLuqTIuWF55sHJfsBZXOil1JIR6Ym3ev1+54+x7R6o6CbbaTp+awjn5CWXYHPzMWa7FwXweZMWXGdtjHAoCIr8u78GGDowQZY+zZXsN0ElVS7kMU3nCdnMb0qKEdg7j5uT66xbFQdOlmGoy4D/i9YcYux4cVtvVF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gV8Mq8xE; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gV8Mq8xE"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so1893346d6.1
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 18:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786584071; x=1787188871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZGIPGO62vUWJJtnlWOV7HnIzQD6+wbjwlpycp53S1ew=;
        b=gV8Mq8xEA4vtp2rDR+jnsK6TSSY301yKIdCVoD89t2x3h9Hgh1rrBdXjPL+CXFnKeT
         SgVmxK9YhwfBk26NKuanp3J6BqnN7/USTpDab1KXu05gblpMHZZhHLaHX6OYZjrkSTT+
         ndMAlJK/eFZotlpBWs/cl17UYJG9pm8sN7oSr2GxLXNHrirOvdufd5pCS61GGlFgjQET
         UblzbhY28gXamsNJPH9B9mCtMjh0uO2f2nXQy8B2vIpvJJnTFTdLMwOELMREAc5ZnPHV
         bljYuNumM7lTPeweZ05hCOaUTdzG6R7ZVXB7nWY2NU3i4BPv37QoHQw7aN/CUrDZSC0J
         p/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786584071; x=1787188871;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGIPGO62vUWJJtnlWOV7HnIzQD6+wbjwlpycp53S1ew=;
        b=CKmbz6eZUHWDFhC8ryHYc5mDf1GrFaw9wJ7Wl3fYbYqd5YYTJ9fRs3N/Ao7d5NZn0g
         MO7BGihkk1bn00R2zSx9UgByWFC2M0bF+N7MGe0YG+5ggJMMYkYgpqVk2GjPz+CmZ3hd
         QfGFNpQyJHSVCNcLBEajqcy8xP09il63BFkpf4gR6vKBgrohV7xqsIc9p1ucAjcZuVbP
         N42rQmvygUb41wZRJIlgbk8Kz8CCCfV0QEusQRP6Uyfhk+vnRi2nx/md/MIoj4SKfNSv
         F/TPTzMQK///+GdJKUdXmJIyS5o88g4TNDuadaQruTIIexg9H5cwi8Jxq4pUJ7jSsDWm
         Vevg==
X-Forwarded-Encrypted: i=1; AHgh+RoBJAi+V9Sje71Aat9YxtMSMfeTXKDR8QCkjW9poQKNLw9R0pbYJ3VhdwKg4iOrJnT2q9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6XDFtFOCC0YiKapSrjF0QJxLy9b6BZ3kYqOl9JygkVABhDyzu
	//D9Nn3yhZR/4AnFqMlQvxCALABtzaHPlr76lgM1lbTWsmhfSYmYoBjjbSYIhlqjaK4=
X-Gm-Gg: AR+sD135r3G/EIxMjZDddQ4lDIx0eGJDvli//BV4ymC5HFyduz6LDycQr29IgP6s13S
	1kPLhrApnHPNA2qexQFqzPO83OiOLvl8O6RnTU8F538aus1qEHm+3UEKh0KaoJP/UJmGrPKWPwB
	2QGe4dZCdp/BQZGYhgHdpJBFHVZa7sxWqmEuydugRUXJc1u6Jw5er4oJCZSnG242vdyTj3HnlDK
	ea2ruHXDDc4Sf205zwuzIxT09gBD1oUHlWBgQTDAY2MH4GAMNaR2hvqaUpjJnr8PCTJm0zPG6Vl
	ZAcLUBbq3ND2N8oZXQ6tac6AMNfbVRWHAI+UBnS95K5BA2gx6F5FIz9oRiibma/vCMbBSFojwEA
	fi5W8ufwp/dNUtous8fJHXWDzkOecBq6TDUm6Ic4T2vhzXq9zEKFGL4NWdhyZv/f0XXeTuiP2tY
	JKn8yXbFVLBKLzjXp7aBG0uZWk+emX0JeRZ7RwYdZKYev4k/M=
X-Received: by 2002:a05:6214:500b:b0:8f0:d710:26ba with SMTP id 6a1803df08f44-90a80bb0b74mr17793966d6.31.1786584071577;
        Wed, 12 Aug 2026 18:21:11 -0700 (PDT)
Received: from fedora ([2601:19e:8500:d3c0::28fe])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a8179e350sm4119856d6.6.2026.08.12.18.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 18:21:10 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:21:04 -0400
From: Gregory Price <gourry@gourry.net>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com,
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com,
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com,
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, corbet@lwn.net,
	skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	alison.schofield@intel.com, osandov@osandov.com, jannh@google.com,
	pfalcato@suse.de, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, kasong@tencent.com,
	qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, mkoutny@suse.com,
	sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev,
	usama.arif@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com,
	"Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v5 00/36] Private Memory NUMA Nodes
Message-ID: <an0cAMh_m8ZhGIm2@fedora>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <CAM9Jb+jpJ-Ui4qDHxsp2WiERiv8gmrQfKQ8Z0BmabefeQ6pg4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9Jb+jpJ-Ui4qDHxsp2WiERiv8gmrQfKQ8Z0BmabefeQ6pg4A@mail.gmail.com>

On Wed, Aug 12, 2026 at 02:01:12PM +0200, Pankaj Gupta wrote:
> >
> > Bonus Configuration: HBM device memory tiering
> > ==============================================
> > echo 1 > dax0.0/private       # make the node private
> > echo 0 > dax0.0/adistance     # highest tier
> > echo 1 > dax0.0/reclaim       # reclaim active
> > echo 1 > dax0.0/demotion      # may demote from the node
> > echo 1 > dax0.0/user_numa     # mbind()
> > echo online_movable > dax0.0/state
> > echo 1 > numa/demotion_enabled
> 
> I am bit confused by the HBM device example being discovered as a DAX
> device. Is it to
> only to showcase the use-case? Or we see HBM device is actually
> expected to be discovered as
> DAX device with N_MEMORY_PRIVATE?
> 

"actually expected to be" -> no.  there's no requirement HBM be
discovered and boudn to DAX, DAX is simply a convenient intermediary
to memory-hotplug.  This is at best a demonstration.

A device driver could very well just call memory-hotplug directly,
or its memory could be brought up as a private node via a boot
paremeter (which I have sculpted for v7).  The former is preferred,
but there's a bit of a chicken/egg scenario for bootstrapping.

Most of these UAPI extensions are going to be consolidated into a
debugfs interface for testing purposes only in v7.  I've been working
on aggressive Linux Test Project test expansion to ensure there is no
UAPI regressions.

~Gregory
