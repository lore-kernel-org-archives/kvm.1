Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077601AC44D
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109693; cv=none; b=Ba2HsT4geqW3Hr5QIQbLByRaQCzXXZm6H3U57wL6c3ov63APZ2/EhBY02BpvEuT/7/qXjrD1urvaZ9v1hlLwEDJvQuZvEeVm3iQuNXp+VTMc1JwNGC05FA1PvTjQoGPi6dCBRDlUP2plhnoUn5jTR2wL7bGDrSPVz2lLmh1K/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109693; c=relaxed/simple;
	bh=N3hAyy7nTu0uD6uxxEosrsvSAc05WwQLSTSIID6INNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQL4ihDAGmXWvS783iA18OArqFb6kN/OAbu65qwzlQJiTYgUVpb7l8ls0Il5N197RVMZ7Xuhr2xKyfHqH6bIqwbBfSiQyvNjfGkSVS6A4CcTgBsHE7Pj9YFR+XPoym8V80TD3jOjo6N/9xQ0hrZIBGS8zCpo/fz75ioJjAa/AAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=T/StiSJg; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T/StiSJg"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-535d60d850cso5463571cf.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792109691; x=1792714491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V2saNd2pf5xXpmgizEGMG+P83blHZRupazL/vtIJhv4=;
        b=T/StiSJg9NKkj9ibcSWBMEe5hjKjl5QSwtnEiP3tJzvpn/R0nSFhQSE2BteEpHDzDF
         4uRGBFJHEJaC8NsxylpA+ABes7IxI2+87ROJ6dQn0dhETh3oLKejUQcI3XVrCeooZ0jN
         LBuzzRkKgdH7XqHEVZM1mVh+4VYM5srvaGbH7cRqoiS+NpWHcQ3PPJ8hSNCRl3zf0jSx
         OC8glC/BwOAeoVt/aqPc6qBd/KOujSyKOKYhxMVH9idVTMQYEAS0+Dk3trwFqSQzgoDP
         Ukq63JkewdwSwFPWIY5gvBVoi5Iy7viGPaetFhiagl3amNV78U7Bh5Yi+uua5qHdSPpB
         aUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792109691; x=1792714491;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2saNd2pf5xXpmgizEGMG+P83blHZRupazL/vtIJhv4=;
        b=GX+UosGJMO8+NsiJGvUmSsnXqXqX8fEXP6G/O3yiCu1zCxtbXALiORzeR+lXtTNzKT
         ujdDJwV0euFGe/1EKLTcXBCdXx/ErGzkvVzirC1LjUYjUerDwy4g8/YdPNKr32ut/Ba0
         1TsH62DPk1od0P6f2+Zzt/Xe+tgGOCr5ko7KdwdJRM6JEIkI7kK1mShEM/oEUbXrxhhl
         iVti0NYirY1BiMN/mxM4wbvBlXycBTBZjNloN+Mxr56VzgGkVQMNLnyjkKO3RD9YaVdw
         fbM6cpcRRfvDNmLS6E6PGTwjZFNZRqSli5nU1DBlrSQaFPjw0a6rqh+Db1yxGZihIkpX
         ztIA==
X-Forwarded-Encrypted: i=1; AKwUvBzQhcM9TdX4nsw+HSuP7G2r/ChDuCkd17U4iYzHzTqOOgcU64Dz3yrP/TLSF9L/CFG6wDo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3TiCaT6viqEAXwdL64YXb8z4/y1MrdiSZYHDMglTj8bZMGZIT
	/e01gJanN5XW+b/JXDwXtHh3gjoZCRyJcYY9JOxmDBozdPtMvtFmGRVIAWgbIDjAlho=
X-Gm-Gg: AYBFou3nDvBrQNvSsuHpKiKbIZcevQRHwlWryQikvrEfiYnK/Y4NjZkaWhGOW55XyfA
	dRh19hkR6bP9RRs7VD0nxXFnn96RxXdK4c/oTr1ugq9f/fc03Gc4iPinSsCAtsqlyuG+qOovm6T
	o6CcfKIp0z++knDtxFBdsV/4QHIcmkuq2dMJyZ/72bpcUfoTreCte9m80/mY6v3IQmdTzgLGJuF
	7DIBHOjTLcWk4tA7xjhPQ7YYOojuNBTIC4M91H+F/+Cl//bQUmeTejM/Y8hdRWzhwaowFAmvlI0
	OH5fXaqTOfDPsU0+mL8uU84KwEw32a9d38R5Sr4MJP2JAUOfCHjvJxEG50sZXEmVs8XlSg7dPBh
	2JGzpXnuEMjdHsys7xbD1dPbaLoPEaF1MGySCrGnm/30SWAjTQZNIoHmkqgA0PoAjyigR9O6PfX
	V0pKXZRzDbVP/MvqlcyKOP/lCtA/6MrRI7m+VABrJzCnSUdRnuUdvIx0tjDikX2gIAPoOAnAkZD
	S2Pkbg5lIpwU6cm8EsUGcX99ERY57YohSnq5IchUPsEpHePTVCZqA3f
X-Received: by 2002:a05:622a:990:b0:535:ba01:d95 with SMTP id d75a77b69052e-536272c2d55mr30900421cf.19.1792109690637;
        Thu, 15 Oct 2026 17:14:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa57106sm7257071cf.28.2026.10.15.17.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 17:14:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHVay-00000000IxD-2c33;
	Thu, 15 Oct 2026 21:14:48 -0300
Date: Thu, 15 Oct 2026 21:14:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Fred Griffoul <griffoul@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 07/11] iommufd: Use large IOMMU pages for provider
 mappings
Message-ID: <20261016001448.GC14213@ziepe.ca>
References: <20261014093733.90312-1-griffoul@gmail.com>
 <20261014093733.90312-8-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014093733.90312-8-griffoul@gmail.com>

On Wed, Oct 14, 2026 at 09:37:29AM +0000, Fred Griffoul wrote:
> From: Fred Griffoul <fgriffo@amazon.co.uk>
> 
> Provider pages are mapped with one PAGE_SIZE entry each. A device that
> uses a large provider block then misses in the IOTLB on every page, and
> the IOMMU needs more page table memory than the block requires. A
> revoke also flushes the IOTLB once per run of pages it unmaps.
> 
> Map each block that the provider reports with large IOMMU pages where
> the IOVA and the frames are aligned alike, and with smaller ones where
> they are not. Only the pages of the block are mapped, as before.
> 
> A large IOMMU page can only be unmapped whole, so a revoke that cuts
> one widens its range to the whole page. It maps back what the provider
> backs now, and a device may also fault on the rest of that page while
> it is remapped. The widening finds the page with iova_to_phys():
> pages that only look like one large page make the revoke remap more
> than it must, which is harmless.

You are going to need to go into generic_pt and implement cut and a
more suitable unmap to make this stuff work properly. We can't over
unmap on conversions.

> iommu_unmap() may not split the range of one map call either, and
> virtio-iommu refuses to. Map each IOMMU page with its own call: the
> widened range ends on IOMMU page boundaries, so it also ends on map
> call boundaries.

Also please don't write commit messages with AI. WTF is this even
trying to say? The subject is "use large pages" and this text says
"map each page with its own call"

Jason
