Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35590428824
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383553; cv=none; b=mHlo7ZJBou3sYXX0l1uJW1yqh17bH4o2WS+EkG7gdBm9nf3i4/AZ7fZ3m2/fXAFWDQcWjGp2aMHT+DoiKKU/lijL5t+g7WuByyWyLJbhY10Ps01vatzBb4poNUk1HuGpbKbP1HZmwKLxpgJmidBfzzXZjcWNhh17g1XWbkUNCIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383553; c=relaxed/simple;
	bh=grR6Ob3GMY4FN0+fwbhETogkpYBbcp8ScejUeYe5sg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCA1+pwmvtjGpNkXQXEVd5f5qAEdDaqYZNaFKaW5Wx87rLFmQ7FcdjF2fC4pUAQ9SzpseREWV9+I14IcUV9xwBs1GRheOCCUv0gNBpdwXQmkseL9o5Whj5/kgsgcLMw11pT6RGXGe9mzzWCq1U2c/0K3aFltJY/hipVz74WCETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P6nSuSvA; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P6nSuSvA"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8ee62a19730so703280485a.3
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777383551; x=1777988351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SXKtcLwqLjfsawGA5AC8W37mySu8/8Ho5thgPASoghk=;
        b=P6nSuSvAWK8+pjCEb/tgM0+J2EDVC7naAsAZdCSvPifuhQJQTjGVE0KsyEvug5uI8a
         8xvj6zP8SHkH+hTsBc40rcg6CdOokJSThxXGdkq+QYJz42rZWaE4/W9/y66d6kfVXvLl
         jLEetDL8XodwgdDFQoR6nOY4220IYJajr7vO/NLKwZKGiIh6fr3/8P0IVdOcEpaKfFOp
         XKLOUKmDitUXYP3mAnz9d8mfz/IGJd2h+AKT1pco18NWk0bO8jCLVq/81TThBjCcjC6W
         RZTZZWt5qe8ykbTAmU8Gu7jisOdei8FiQpbYYPx7xaXFxykNguvg4E5CQrtgBlCeSwTg
         0aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383551; x=1777988351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXKtcLwqLjfsawGA5AC8W37mySu8/8Ho5thgPASoghk=;
        b=WQqRocXuQs+Z/489hAdNXnZ+0w4UfejVeXvV981JgigdB41NpEelqassY+cQhfmSCW
         BhijhbpmFNhK6Epq/fWwetgs/82XPhXRRU8Eso0naMvr6TJs8nfLLY55NSLqCoXngYWv
         9UnSPS86tvt0U2XMmvnUZUY8Igfd8pC53GMzWLu0Oq1h2+UfcCLNS+WcBUco5gz/NmPY
         TsZowAjj+ra2Kc/5iOpZczNawvoq/RCiZFhxxoaOks86dUY/mpYKAM9Y94sp2ijenDtN
         hV6mpcSLLpK9bQBPRjYBvIV+rEysZ8zjdH1VrEB4g7VAzlorruAnGbVOWI2agU9tCkW9
         Jrhg==
X-Forwarded-Encrypted: i=1; AFNElJ9VvfOk2SvAX4No8klR3gA7jJ4rX1apqwl+GWvzFTcAwp8C7xwG3FItOf4W6nMaB27bToU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8uZ2EfeBzY0ZrvrQnl2mS175kmJ5sTlsyvwdwXHRMsXYQv4go
	6xtQ8cVY8reckasLQyStnoCM0J37OLVimXYX+vJk9jN2J95o4n+mc0RHrYWzKdz6pSk=
X-Gm-Gg: AeBDievqGvQjXIilgSf7F1U/aRcDzoTyALeHbqlQc7pMnHJpLlw5OV0AaAzTXLoFwsV
	TjxeTfpov3PRYrIKVeX5BlesdDoNrzwV2czt9ka7oLNF0SbMwP2n9TjbZXQ2UkmcrB0wS/rcoFS
	spSz5igj4IqDBa497LVzKlBslhfGvCFUV1/toJGz4AXd8Xc/w2rpHlWHpq2sW5j8tF7hBo8918u
	7DOxNigNfz8v62wo0QnUZwvK6kAj1QbAV+xT8uU7cEwTQHIB6lVNrpnUv6YF6VvqAmN/PQg7M1w
	a1P3JEdoYgZjCgsVsgdSDxOzey7ikq3Wb+FCN3xPJPbyW0vUVZ4Z3H9/UgY89e28elaM+5nW1bj
	LAYAfsTv6r5XjXhuyySub8Xe+edesIt4yAY5h5ch/6AqkZXJ0U3B/Au0sg+Fp90PC3DBvBgDLdI
	fcrxxtKPmN9YsPWLLF6a5q1VL4WjqOiFMVltED7srLRbWVpcs5RyjkzmL+KQfhzpMlbxNTK7ar/
	VCgWBLC/r+EkQjG
X-Received: by 2002:a05:620a:28c9:b0:8ef:12de:1337 with SMTP id af79cd13be357-8f7d9200e1bmr385079485a.38.1777383550897;
        Tue, 28 Apr 2026 06:39:10 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c48c71fesm230888585a.5.2026.04.28.06.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:39:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHieb-0000000AjKg-3JBz;
	Tue, 28 Apr 2026 10:39:09 -0300
Date: Tue, 28 Apr 2026 10:39:09 -0300
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
Subject: Re: [RFC PATCH 10/11] iommupt: Add RISC-V dirty tracking PTE ops
Message-ID: <20260428133909.GH849557@ziepe.ca>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
 <20260428131359.34872-11-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428131359.34872-11-fangyu.yu@linux.alibaba.com>

On Tue, Apr 28, 2026 at 09:13:58PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> Implement the three dirty-tracking hooks required by the generic page
> table framework for the RISC-V format:
> 
>   pt_entry_is_write_dirty():
>     Check the D bit (bit 7) in the PTE.
> 
>   pt_entry_make_write_clean():
>     Clear the D bit across the full contiguous range.
> 
>   pt_entry_make_write_dirty():
>     Atomically set D via try_cmpxchg64() on a single PTE.
> 
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/generic_pt/fmt/riscv.h | 43 ++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)

This patch should probably go earlier in your series, before adding
the alloc_paging flags at least.

Jason
