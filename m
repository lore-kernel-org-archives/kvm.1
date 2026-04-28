Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65144B671
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383406; cv=none; b=YhWmyHEQDCsrslUpXyRITfmK40Czy0m6fOGKQEnWyrbr5cfxbi4kH1iBNZ9tHInXrHk0jN2FYaubPodqk0hyrHOmiiLRZXfpvVMkrKimXu+uB0uoOqxu7edtOQhZDiEYeof3THUfEjGDBqf9MItgXwMsoKwljA1cFPH7fxU1l1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383406; c=relaxed/simple;
	bh=esToKOeJowsAkTTeyqSbmSIgmhGnHRhb2YdBS1u1Im0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIeEjbKMxuEshGauUb7dAViX7X1FmWn7jAuRRkFVhPHelzGZ8qlfUZINBm3oJyY/zFs+3DzjuC4ofOaunMLqmxYSqoy4C5nicELLJSW7JlOgBnHxBeQkv/jAAEOKX8Eu22KlRblaMk6UkZy8cF8NOdwOgRqFjFLUYuQArfxdvxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CCCpCEka; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CCCpCEka"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ec37d52c0dso1181058485a.0
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 06:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777383404; x=1777988204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZ19NsW5fr6ajdZR5D4lYg3z8k9sQDPcT96d4+jJChg=;
        b=CCCpCEkaKpe5tEjOu+k7WSh0VNfkjg802bvXXdHMbKlYZZjGdecKDW7UTXH+OU5rU8
         Jkc/Z6ZX0bpi5JvTDUKWMntyc4Izso7NrzcCakzoZReb1nTwFpD6TtoRFhnwuJMBzcgM
         JFNg/SMdDPMRFjVuOSuGIYqqpE2WpwVR+4DZDpUnAls7mja2kBvXtZZ/bVthpnb14ch8
         eiMXBFQyfUuFMo+8K1hdac4AqHfeX5kxLPfbDcIxqejVv55q6nzfYl2kM+qLTniXf5cn
         /YBURlAde3Nxe+TkrXaq4uRfKUh7LlEMqL8WgHe8wfRGyRGCToZuYfs8kmW8Cz6qcnXC
         ddMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383404; x=1777988204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZ19NsW5fr6ajdZR5D4lYg3z8k9sQDPcT96d4+jJChg=;
        b=pb4oVXdcb4expN75tg5vip3AwlinvkiFqvBMIYQOZtfw1Xmhu8OJW46dkDo9M+FUOx
         bEUgSpRQkG+jhCZXLmqxKVUxNB3vb501nWUc2cyutbk6F3E6yERxfE9CsPay6v2ftI1S
         ymzrUF1/d7EistueZnH4hu/4vwEUMn/987s6VPIV7zgC7Zkz0MSJW/88/ul0KD0XknAQ
         YsCzN0dbviQM/bHe556ZHuwTzOv2Dj/JILp6BkfcdWvvwMeKQYe0MNQUv5QoASutTvJq
         CItYX/JDtPemj2sxmm4sSj+DVYePXy8Br90m1jl/kAEa5flTjL4QSyGTXIDMy6r0GMoL
         dYDw==
X-Forwarded-Encrypted: i=1; AFNElJ/yHok00f6LKN2cPDD2WhIxgVAKA1fL9RAU2kNTGKsBfZMu7FnAwaZ0NZEn3mq0Vx90q58=@vger.kernel.org
X-Gm-Message-State: AOJu0YydSrAMvygKdJ9GXc6Yhbues7i5vJ0uujXABrcka1nCrHo+V3+/
	vqoBHRYWdxBJrpuBOnvNUANNhQ9C1Qh9OL5N0xw/cOkQEOrCPAxWkyyNh5SSVs9o6UE=
X-Gm-Gg: AeBDieu16+0DJj7WwtA/rsKLyN3u055U85/gzF9Xb12Cp0P82wjHFhXqfRxdb5hrH5z
	oxokIjgK0nj1rqfc0OQ03ukT3mDGHH+pTaeaL8/7ERKnFV8GorSmxQBzQJFPLKZwT19SNIg+YML
	fN1NGTW6ok0b2x0HGw/hUnmbEzqbONaaJ2KG2rO4eXBbVkOaqwbOMNuoPHGkp/S0rl0HEGiPfl9
	BweieC7+A4oUX5yoVHXMNp+Kuo8iBY+c5m3c7WGgsxOEr59AE6VjI6cPWpfmNCyQfSH9wUH7QSd
	dDIEmzgnT3Z79SVZSPrwANar9I7aeqhW13cIdCltN1J8CAKo7QocIv/bVIv7G/wd4PtKwMDQBMd
	0vCCjiZNRs+FlR4HfWDSPP6GZNaZDAHrqSAMgKLFuTnnrz/VZybyjsiHbYJlGwCq2uq/ZMdlkdv
	nmSMIMlE8KjGGAGuQeQh+4WKbM5C6evhi0QYGfZXtNg3UVNzmsQT2RbjOgwcTkF7L3Okqddg90e
	8JAHl28/z/HA20i
X-Received: by 2002:a05:620a:4002:b0:8ec:a621:a3af with SMTP id af79cd13be357-8f7d7d17f49mr430093585a.27.1777383404115;
        Tue, 28 Apr 2026 06:36:44 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c7cd2becsm194526285a.29.2026.04.28.06.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:36:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHicD-0000000Aii6-3yTF;
	Tue, 28 Apr 2026 10:36:41 -0300
Date: Tue, 28 Apr 2026 10:36:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tjeznach@rivosinc.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
	atish.patra@linux.dev, skhawaja@google.com, guoren@kernel.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/11] iommupt: Don't preset D when RISC-V IOMMU
 dirty tracking on
Message-ID: <20260428133641.GF849557@ziepe.ca>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
 <20260428131359.34872-8-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428131359.34872-8-fangyu.yu@linux.alibaba.com>

On Tue, Apr 28, 2026 at 09:13:55PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> When mapping writable pages, the RISC-V format code currently
> pre-sets the PTE D bit unconditionally.
> 
> If hardware dirty tracking is active (DC.tc.GADE set), the IOMMU
> sets D autonomously on the first write. Pre-setting D makes every
> new mapping appear dirty immediately and breaks dirty tracking.
> 
> Introduce PT_FEAT_RISCV_DIRTY_TRACKING_ACTIVE and, when set, leave
> D cleared for new writable mappings so hardware can capture the
> first write. Keep pre-setting D when dirty tracking is inactive.
> 
> Only meaningful for second-stage (iohgatp) page tables.

You shouldn't need anything like this, the D bit is managed by the
iommufd core appropriately. It *should* start out pre-set as that is
faster when not tacking. Only once dirty tracking is started does D
get cleared. User space is supposed to assume that everything is dirty
prior to its first D clear.

Jason
