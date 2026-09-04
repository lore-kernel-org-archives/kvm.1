Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C291F418F
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558057; cv=none; b=RVFtbUT2Tg2rVwVfgOjdkm7qyhQiYHouJpmlCDED+HKSBnFWns1XZDrpBar13yFIdByihEFVXQ3LPyLBoGaRA71NQBrDzAuo2NFJXyHx/Hm1XiY/LtquJJfm6XCvaX7uNZEq7vOwtvccpQhJ7EPPa416AFRKxu2vd03AZXTBZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558057; c=relaxed/simple;
	bh=MMW5Zhv//CViWj0fAEp8P1ImU1S2jCTSQzMvwFrDS88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3fDKLJildpRQ6zaP0S6g1CBynpuoffqrM7TOXhZ558p5gFn4pn/N/cxN5K9fgNSGHzKS+ZwN+oqaT0ONJxGxWcVa9i0thMjIPtoAv3E7iO0ndLJyj5T60ZSNq8vjeJh/pqUBXvpbr+UfcylgmmpxW2qk5RBA6/wxiciMvcJT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i1dvxn5N; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i1dvxn5N"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff390a6aso13485ad.0
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788558055; x=1789162855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MMW5Zhv//CViWj0fAEp8P1ImU1S2jCTSQzMvwFrDS88=;
        b=i1dvxn5NoJqVpGJxGph9eTLaxy8piePwDfOWWfoMGFPJ9/Lgqhw9hA+r8ivpcojnxN
         CLEu+vllKUFH47xyj/gXe/FpGMYmX5/JoIMgpVx93c03yhIseLWvXX2qQ8uBvG0JVjar
         0LKH/4hcVu77bOcaEiXJq+CLsDgL3YNr404KdUIhoNFVLa3JeYbOfzOOSEOgiUmZVKlD
         S3tRbj+BynNQ27mmI6XMMcIrYWFxCJOgV2mh/JfIN3D0ftsqS1zyAcVE0SjtBKVVQsW9
         OtiHkCvDKkWRQDOoxpxXohU2IIukPRXdZ+/OgQ+xUndRp0cWBsGqaNfNcnN1bTSQabgz
         u7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788558055; x=1789162855;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MMW5Zhv//CViWj0fAEp8P1ImU1S2jCTSQzMvwFrDS88=;
        b=ZdtMkyILipwvnSHSpaTgSTgg/Xi/vIP4/QbPfUVywvZNo/hQ7OmXTK/UbiAH0xUNHQ
         ft7LQDfTDO49mY5XR9fuwncL+X6pWEV6NSIGmjmBa318XWO+gSHfYjwjR0BpFR23Kuf0
         6v+f0zALgPTEK4aRMcUIAXD+GAaF8dMDQHJ8JPn1G8irUqjCkbWwR4ssKlbkuPC/7cQe
         BVtcTmU4cpBtNcwZDljxUfMWd/XywFrS/IXihVTE77G+FiU0bh5ed2Fb/DJA5WLKZHnL
         vvu0t2gesQorghCQrfcWXvqhXMIngWshBakSFH4I0Hp6xiQwDPagPB4imDnnV1VX03QU
         FBMw==
X-Forwarded-Encrypted: i=1; AKwUvBwn19f7WeKL4HqRC8XGrR5l9FCYA3l5q7T0kzy9UmctpPOKXqiw+24MU4uoFKROsDxDzNc=@vger.kernel.org
X-Gm-Message-State: AFuF++lRnnPTbJKzCpRXAN5MtwtY468LKqXUqGtH5sjdg8KSRe+wKPO1
	gWstLvHl6Zr0CePbXqETfuqGYclHhPoYh5YiA0barTLMZ3CIzrIiw1z8PkL1w+yrbQ==
X-Gm-Gg: AYBFou1eEHd/4wgwLsT7+xwOUeoSSo/tWpjaaXdLTAnlb4DzVUvoj8ml3HB5g+NJ4bM
	kdyWrkd8/MvGNxBTM32JpLnIracoBFB/1pd6cdaqVdRLgB8nUS+DD8K5+2H+srGzdh49iM6bozP
	Cw55kTeFRYkgghZBWPkkrW9hIWT+UzziibCtE1TACGb92VLoMjTMnSUJ1dOD5eyf7t4mRiXHdK6
	vqceqJMaJ3Brgs1B0fwWttoQiQkFX3dSRpHurzMloDxkjEw/mkvzS6zZZ9LFtWI/7NOL7Y/1J7I
	4MRTymM+UteUvTg3pfvKgNQpQWSvbi602VQ1WbpOuFDoi2dVtZOE4GO8nk7oBcXcPVRM/16Hprf
	8yd+hTIbOe3l/CQXyN00ujDDnj0ywQYVAxg7eTncOlyl+IJ8flXo6X4H1HnqP4tIeMBLKGzTf/a
	xmv74XXSyTgR8xqFtECQfQU2RA7GupbOQgLlTRM9tVKBJvaEUWEeiDaV39bEz3FS/XYXwY/v9C4
	tPW6kBu12uFwjPKu5aBbe+hOFuDUmLQg4CMeJmPiKXmPhgHcIfkVjNRuiU=
X-Received: by 2002:a17:902:f681:b0:2d5:cad1:a2e8 with SMTP id d9443c01a7336-2db28365563mr1928785ad.6.1788558023178;
        Fri, 04 Sep 2026 14:40:23 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ca63b3sm12393723a91.11.2026.09.04.14.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 14:40:21 -0700 (PDT)
Date: Fri, 4 Sep 2026 21:40:18 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 00/18] iommu: Add live update state preservation
Message-ID: <apCIr3Ops8MxdY2y@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <67a636351d656e032bbe64b1ae113821ea4694b7.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <67a636351d656e032bbe64b1ae113821ea4694b7.camel@infradead.org>

On Wed, Aug 26, 2026 at 09:12:53AM +0100, David Woodhouse wrote:
>On Sat, 2026-08-08 at 02:27 +0000, Samiullah Khawaja wrote:
>> This patch series introduces a mechanism for IOMMU state preservation
>> across live update, including the Intel VT-d driver support
>> implementation.
>
>Nice work; thanks. Do you have any timing information? Every
>millisecond spent on work here is perceived as steal time by the guests
>which are paused while it happens.
>
>So very quickly after the "yay! it works!" stage, we get to the "how do
>we do it in <100ms overall steal time" stage...

I don't have timing information for this series yet, but I completely
agree that every millisecond spent here is perceived as steal time by
the guests which are paused while it happens. And this is why we do
preservation of the IOMMU state early during LUO preserve() when the
guest is not paused. And later LUO freeze(), during shutdown, does the
minimum.

But we (Google) did some analysis internally on the time for which the
guest is paused, and the major time spent in such a kexec liveupdate is
in bringing back the rest of the system including important unpreserved
devices, other kernel drivers, userspace (VMM) and other major
components. Note the Orphaned VMs to reduce the VM pause time:

https://lore.kernel.org/all/afEwWZksU0Fw61oT@plex/

Thanks,
Sami
