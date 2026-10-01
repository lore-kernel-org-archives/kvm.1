Received: from mail-oo2-f35.google.com (mail-oo2-f35.google.com [74.125.231.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F10B3B7B7A
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874911; cv=none; b=P+2uIyltSJzIZ4JC5BlWcz6QBKsMfpo/UvW1HY4I3sOP3TMShZeI2JtmKuE8eug720FHoYUVCBDyfc+jBS1FGC4WEgQCrDgY5CX2USZV2IcnjmXlL3yoU5wAOL/ee51+JHGP7DNEnMOiEoICx7rniQBkkXOC/QhD9udx8RFI2Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874911; c=relaxed/simple;
	bh=a7oq1MIgLZQaYmPsWc/dtcP0sMS+eH9o/8iLzIQIc/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lw2rwhAh62lklFx78jCARNjih0fyUOywM+93elPh1grxOOjuan2LjCMezYA1v9PmDfTW1Bl7ELNMeUp0IKdwFBZoXcE7YOxqGORTf8KdbJRrhHu7vx+Priotyy3oHt9W+jxPgZ+EScMDy4Htbbenm63tbc7+mLLRa4XZ8y0abM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LiMyoth8; arc=none smtp.client-ip=74.125.231.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LiMyoth8"
Received: by mail-oo2-f35.google.com with SMTP id 006d021491bc7-6dd4abbdd97so385939eaf.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790874903; x=1791479703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t/6p+zYx/lSA8o0kTLIaLNlPefSKg05wX6rF51KJFNw=;
        b=LiMyoth8etbND3MNQwHkSEaJ+HRDwN2uwRaewq7vz7DMUR87ukAlz/idYFO+9P6q+F
         praczIlNXVUo7jpkHmQrcQSqHqJd30JN6mwusqmR5YmITRuzCwAY1SH2MAA3lHTAxxHo
         faGoT3BQxCP6RyuF8r8RHTRZIN1Ph/QB1SVB05+al/6VVF3S276Y/hxw1gLp+1oFhFCs
         lmZ+9tOAyzFeR6sKKWseaDtFdWeWBhVmsqFNOHFVT+ePvsahskBDp+eAee0YutmzEMYi
         lXWUnFYXBSu+OFBL88bdW+EF4UaSB6nQY5vV3JPLiXRtYb8F4eCw0g5h62Cc3OhIQKcW
         5wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790874903; x=1791479703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/6p+zYx/lSA8o0kTLIaLNlPefSKg05wX6rF51KJFNw=;
        b=sum8hLJa6vz/wuKGdkUnWRhWTiUmtBUnNBSef5slpRCax49mlc6kH2QJ1s7UdXjX/P
         JCfyAuRVpzpt9rxMwBo+ExFTWcRZi9wjVMLFJtVL0aYt4x4xEERnKQtZqSr1+dKaVYhA
         swRNamOVb3ANjkvk3F/8UnyNgED/9lcVnrx1IQbgprJijQeKaIo1xfXQMnj73cmHzJzQ
         7DrEq4jZn/JbTf89tcnH3HXFFhbGD5XkilB21F7Rkdh1FmkuSpAJ2R25ta0xdsB+xtdv
         NQQgSwsnCu6VyD0lB5EQkO91Xo/P1cwvX7d8OZl1LBhnrA2ie0SFZcceL3dmF6I61NPp
         6Vfw==
X-Forwarded-Encrypted: i=1; AKwUvBzKSdukjerLG95XcpGYFXuqV5L+DU0S392igaQnZmjWjiOpKrckGFjDwv7miLxoN4YIQX4=@vger.kernel.org
X-Gm-Message-State: AFuF++mLqT+Jye1yEJ0CUpVs8Rtp/MmAufvXT1zKFrjtkN9jckGd13+n
	+H5s6pZq7qaaustSFmZvQ8se6FbQeAPzcEjo6P9UUhRj2cb3kyFb2AcQ4+5cfhHZPLw=
X-Gm-Gg: AYBFou2tOwsL4Toa5HAyE51+Ug0Ldca6L9d/3TBZBrDmM4v91kQjUIWTLiadnu1XS4g
	qYeOT0m0fOuw6visiSpo6s8OxsMXrki3yKL7YMShxfxads57Xhe6i6X+2/lgcsBjpoUUw7wr8Du
	XstVkDQUxGiB6dhsRdXFRHljM6e4aetMuu41FssteBzB/eFaNwI2tge27xvYJMtDIpG40bjr9I2
	O3jG1Y1Oi5ICWEzT89+oRP232ErY46jY+MUxTdhlzNCn8odnNtMmcoDA5XQY07ess5WbcJHLYMb
	zrJhAS3OE/6pVFqXiOrkCtXQyee/hKbjofUeR0TFIcn0KbifA+vLVQWkrsIymADTxdMkjE/6hLC
	2xQ2wZVQkoAyULsBNv5cYDJYK083pFc2qkKwFYfmdwlXVcU/CrryzFzE2mpwKj9uncXgd8aMaam
	7F7br75T2cMd0jINSJmuBIb5/P4eym4/dZv5dQOOTA1A+z
X-Received: by 2002:a05:6820:f025:b0:6c3:32f0:6307 with SMTP id 006d021491bc7-6df32aa7ec9mr9152eaf.12.1790874902929;
        Thu, 01 Oct 2026 10:15:02 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6dd97aff835sm3239083eaf.6.2026.10.01.10.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 10:15:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xCKN3-0000000EaHJ-0IkU;
	Thu, 01 Oct 2026 14:15:01 -0300
Date: Thu, 1 Oct 2026 14:15:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Fred Griffoul <fgriffo@amazon.co.uk>,
	Connor Williamson <connordw@amazon.com>, ackerleytng@google.com,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>,
	vannapurve@google.com, erdemaktas@google.com, jxgao@google.com,
	rientjes@google.com, fvdl@google.com, jthoughton@google.com,
	tarunsahu@google.com, pratyush@kernel.org, fuad.tabba@linux.dev,
	Gregory Price <gourry@gourry.net>, yan.y.zhao@intel.com,
	michael.roth@amd.com, suzuki.poulose@arm.com,
	Christian Brauner <brauner@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, aik@amd.com,
	aneesh.kumar@kernel.org, Vlastimil Babka <vbabka@kernel.org>,
	kernel-team@android.com, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 01/17] mm: shmem: Implement guest_memfd provider
 operations for tmpfs
Message-ID: <20261001171501.GD3019323@ziepe.ca>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
 <20260925-gmem-tmpfs-backend-v1-1-d36159822d18@google.com>
 <9292b27b8f48c515bee3246cf3b3a60762302186.camel@infradead.org>
 <20261001141743.GB3019323@ziepe.ca>
 <ba82487d2fe70e762a06e42a9474299d1a501ed7.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba82487d2fe70e762a06e42a9474299d1a501ed7.camel@infradead.org>

On Thu, Oct 01, 2026 at 04:47:54PM +0100, David Woodhouse wrote:
> On Thu, 2026-10-01 at 11:17 -0300, Jason Gunthorpe wrote:

> > It would be nice if it could handle MMIO and "cachable MMIO" as well.
> 
> As opposed to just MMIO vs. RAM as implemented in the prototype in
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=commitdiff;h=a7ca2d8859036 ?

Sort of, RAM is a little more permanent than "cachable mmio", I prefer
the latter because it conveys it is located on a device, is subject to
things like reset. Eg "CXL ram" would be cachable mmio.

I haven't heard of anything needing a unique PTE for this yet, but who
knows down the road.

> I think Fred has a cleaner version of that about ready to post as the
> next version of my series.

Yeah, cleaned up is needed, I want us to resolve this in the dmabuf
code cleanly not add more of the hack mess I made for vfio/iommufd..

Jason
