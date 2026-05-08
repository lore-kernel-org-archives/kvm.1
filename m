Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065E8371D0A
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221022; cv=none; b=Nrd2v6gIPxF3rEXkvbmBKOJ2DC9NqlatAAVq/TytQlvctvodczSGF/EtK8G8qUpYjmGHCqJjukJv+2lwMCQ7TxXj57yq5u8PEYJwpib3HAu+0l+UeAWDh+ASYvaTSvolRSJeV8r5vFwBNGmQlk2HfOxj3G+wlI9J/c/q6+OwxY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221022; c=relaxed/simple;
	bh=maMKpG5JtsahwCoCistRB9wzcOXtXjO7nbLwk2IXAhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHG9jF/YokqqFl6F3Eyu2tQfYBCMs3QzFvhDJbHNicrbk0kkcvm7iZenNJIgDjopcGL9HGiMvPxQ0yxQM/N99EqDv4ntoV3xCKbfA0GpS9Mt+R1Jz57cKBxYVRkvv+qORHdV19EZ0KfmZRk9GZZ6CnNrQRIBPl/MjPsCmgRYtvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KM4KFiy3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WC73NZfr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KM4KFiy3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WC73NZfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778221011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2unXq22HY2FnCjKT6qtydtFufJI+AwXDzC5gFdjej0M=;
	b=KM4KFiy3W6T+yPa/+5TBYd1nyixpSjiBEJeevhfbKczLBojqwwkjOZLUt2rw0Ippl6mMJO
	yfKH2GOb9iIeVrJVZMfkS6Wc5kPOkuifcWfQXjSCfMObaClabjHAnD5TLiFT9O6ezCZ8ia
	sCxxM31/M5PT44GCBVKwju3q0slF5KA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-8NoPE4bhP2KUt5sqzaYMgA-1; Fri, 08 May 2026 02:16:50 -0400
X-MC-Unique: 8NoPE4bhP2KUt5sqzaYMgA-1
X-Mimecast-MFC-AGG-ID: 8NoPE4bhP2KUt5sqzaYMgA_1778221009
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d1b5bca0so8000825e9.2
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 23:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778221009; x=1778825809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2unXq22HY2FnCjKT6qtydtFufJI+AwXDzC5gFdjej0M=;
        b=WC73NZfrVgDjnu9fLdg0DG0PNzAYjDzBpAAqvdnQ3noZcCDgG8C6zkzHWRBebhEwoS
         wqlmKSbNHs7cYITn77UlnU4LMNrsjg3DwxMy/g9NtTnzJLg32dnDcDhv66njJ2+zH7+A
         umaBOoW+BWWymzERrSReGwmoiv95l2aL2dy9P5abjufqwrwxJ7LFnkBm8/ketCmfC+WP
         b07FmT1YyAlx21PQqBwK+zeeVuZpqllaG/jhm5Ug3Sh30CkZVkdZOzGLjgDRaR8b06Pd
         wS7Prx4Rn5EniTLLHs+N+1aKx3NvXiOSZJvrjh96GESKXM5rmbSyxe/3YkVtxFBKo5Kh
         694g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778221009; x=1778825809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2unXq22HY2FnCjKT6qtydtFufJI+AwXDzC5gFdjej0M=;
        b=rEX5+OUG8+UFcL6VD4yzAwitnT+OSnYmbvpmO3n3bScLSYPtePFDBXZIv+gtMr694n
         6mnuDJpm3j8ol8XcA7HDGp2mhHVs7a/gPXrweyie5fCG897lf3oCWJXjOirdFUffI6tM
         PTQ1g2jE7GL/jEjDd2CGEplAd93zCD+TJrAHlFdNYQy3Kx1di77y0zLxqKzSYfLH7Al7
         tw0JXI/BrQa4ce3WISfwiI3pzaXvM0Cqu5RFE5/Ou5ufaYptB0tIl273nAOotnc2NH1z
         JG3FT3QMpOyNRFlVPwZwvOmK96mcW9K5Ov/u5aQOEYgiYKHU+5xP2g7x5hB9fAA4osoE
         aVCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/mVhMuc870bbbOHiOepzF3/My4HR2SFSPV+9Gbuu+9eIcL0hCCwzpiQ1II3ELrpLSkoaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyirZHY7nvR6B/ih4AMg0NTQceKBsPYlakndDAnjgjK2tIxJlnd
	bgaGFvrC8USzcB933obS3cGe88AtNOs17R60eZ8d4fEEXhi5pU52x4tPnT9tydTzbPWIVEKaPtT
	+umGUpgs/NYi3Ooj7HXNuBoel5zx40gEnb4hwgxazL0xYJiXC9x5+CUMDV49UvQ==
X-Gm-Gg: AeBDieuHfGiyTbxkBQQ6V1o0ET1XKmSLqX0/UWZP4dU5Y1Pq+Vr7RvIKQvQT3Zg7tJS
	nBGjRktaNL3bA7aX78xeXAn9oGskglWkwJERUWJpliMkjPP3lY+D/XxLKPWCqSzSlipBOllQVWO
	3ullbscCbfiivxx7PtQXPffm9lQq3K9eUFn/UilH3/2IEx3tMyczveYWAupRaNyrhypvZLXxKHG
	2ARpwFKA8s2QvQwJBsYvQiOg5evJfprt3HTPKOj6pmvdqw3M6IGCgijVfABBYij0Ogu0vyNYOfV
	fZVyRbLs7eNdCsYFvHhwBIKrvW1ZvYNnBua01MnZzsHwtpM64ruRup0LDYNacrATZ6OEq2qu4UR
	WE0/uQ97/s4ip2Lwq65iAoZmwZWK5/VzHUZjeLYOv
X-Received: by 2002:a05:600c:a47:b0:48a:75b9:5e07 with SMTP id 5b1f17b1804b1-48e6767e04fmr19385175e9.11.1778221008537;
        Thu, 07 May 2026 23:16:48 -0700 (PDT)
X-Received: by 2002:a05:600c:a47:b0:48a:75b9:5e07 with SMTP id 5b1f17b1804b1-48e6767e04fmr19384575e9.11.1778221007973;
        Thu, 07 May 2026 23:16:47 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68eef558sm15122585e9.7.2026.05.07.23.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:16:47 -0700 (PDT)
Date: Fri, 8 May 2026 02:16:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [mst-vhost:balloon 4/30] Warning: mm/mempolicy.c:2527 expecting
 prototype for vma_alloc_folio(). Prototype was for alloc_frozen_pages()
 instead
Message-ID: <20260508021630-mutt-send-email-mst@kernel.org>
References: <202605080331.y1eIdVUC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202605080331.y1eIdVUC-lkp@intel.com>

On Fri, May 08, 2026 at 03:56:56AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
> head:   9f56ee36fbf6a6d336dc6a9eaeb4f8a67cb42a31
> commit: 95744e0e9c4df79c6bc8ec96306b29c7a8e8984e [4/30] mm: move vma_alloc_folio to page_alloc.c
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260508/202605080331.y1eIdVUC-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260508/202605080331.y1eIdVUC-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605080331.y1eIdVUC-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> Warning: mm/mempolicy.c:2527 expecting prototype for vma_alloc_folio(). Prototype was for alloc_frozen_pages() instead
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


kerneldoc messed up by a rebase. will fix up.

