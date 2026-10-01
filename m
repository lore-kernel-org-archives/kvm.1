Received: from mail-dl2-f33.google.com (mail-dl2-f33.google.com [74.125.229.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258451AFE8
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864269; cv=none; b=agdozqosy/QwWqhLpndUMpxHIMnA09knl6v3rmYU6BokXX3puoXbh5TTF7JNU8oj810GND1wxQXlSnyKJYsQgACU3u6eOAkaYYd6LamMr7MFLwed8WkLJWgnsFL0dTq07C2weME2OMEdLti/EpMDBkyxbZU0xCcYUSJtDWmO774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864269; c=relaxed/simple;
	bh=xDMyZjpmBuMrFbLISKqTNyCUa2kXcFY6ppx5n8yKikE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVYV3tbzjb+rkNs6F+dH9FLzg2kINdnMtgGP/8rZWTnlIbLaES5ysmlcVllLy1OdxNgXqstojAqgSfid8/CUpH2w3gRccTdwcIYUK0KOMLeWdEed5w15qah2WwQ7p2PHWAvPDzmvbMG+b6zwGHDRlVDTx2MiOh9aBow8hAGkZss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BXigv9eW; arc=none smtp.client-ip=74.125.229.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BXigv9eW"
Received: by mail-dl2-f33.google.com with SMTP id a92af1059eb24-1438e88300cso6808089c88.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790864266; x=1791469066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xDMyZjpmBuMrFbLISKqTNyCUa2kXcFY6ppx5n8yKikE=;
        b=BXigv9eW+sYJ2/al5rZthSGvatRRCrx21esZ8DRDlyQzVTzJ1n3lmdW1BXCm34jrdR
         1sYBYhv1ljlYYb3CUglLDIH5H4KxOBTYBzZHM2ML9L9v1iFjRBkRgF50qfe9ZyE+WSXv
         VFV0SnGbOT1PyzvYxVnKBLcxIFL+uD4sVYTdKtRFjpDe2YBkJTyo9PzRLTvZyizm8ffW
         vxsModyQrWZ3UTUnsWemUyyMDw9PnGUSVWN/ToeddRIvjpQxwhU9FIRqaR9eBODMCHt1
         F5QRRTDbnvJfUI7vhDggC5mOLm1MJFa1OnDlMjpRPZvp2Wcvso3bwCkW/R+ecr+g1Mh8
         3mrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790864266; x=1791469066;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDMyZjpmBuMrFbLISKqTNyCUa2kXcFY6ppx5n8yKikE=;
        b=PiP/6a7ZVTVQJHj7gWQ+cQda8nSp4PYeFTyCgBMUnv/qkuWR/peyvKJSCpqes14uy9
         KC3CNcHGDg+INyGA6r+nymtWKHRoOHHT6EpfrRGzrdDoAqfS5Cj4F5f981NorHUp5JkE
         k5k3fwGicXMhGSjsq09D39oBUk4yxzxpBrUeEbNuhGlLRN+ZJKHw6DjHdzEMyEcy1vhL
         J9Cuv17JOdvFqzXBg203GanANiHTzUvYKaHvstFEDedWORJKML2/dNdJTj5BWYOOO72V
         Dd1NA0uaKxY8sKqLx/Pn9Y1QVvkjgr2B6Vjk1p2dH0gxxzCn5SJw1yNC0K7xDdg7IQSr
         cTBA==
X-Forwarded-Encrypted: i=1; AKwUvBys5tTzIiUydicOfPZHdMyW5zyCQERZ2uGb+/aw1+krwiRE81X1GDJRwJeO45aPW/Otcl4=@vger.kernel.org
X-Gm-Message-State: AFuF++kUmC4CAyalTNRpxe4WEgEzGmT6j4P11GM8BADQweZNTWhaCAQr
	aFHVqR9iUNyXS8r2dSSvx412ThSDXzy9dJq2p+MjpJ2aWCuIJv6TYkDlvMrS4UEjCR4=
X-Gm-Gg: AYBFou0alYOR3QGcaREnE/Mqz3YQOXumZJ9tdV/8dW26RKL3gwby5zxoHnv36dbnFzC
	RGrnbYNBI9PM6mkzMVUa28uTHgw2nTFJwTi9xwCNS5s6bS0XdF7+BuNIuFgnbdCaz1SvZPIJQMn
	JqeSb9fbYkk11oBMLiFD+ICazDwShfPzOnDOlwvRU8QQoo3JxyeGewioXft3pnbsEQ5QxfWK2Kz
	q7xg4pCu6QMaiZB2lR4TRdG8GAvKLDtIkxjT8kkwvyNLBVD/ISYnE3vxZb3iLRwtnALiSHBoPte
	fuq7vLA1kZF/SFPdr+ymqIfnqhnLtPc/jPgDinAG7TS5RFQvj5psT0VdH+tHhmIrSNMVe6QjcBn
	d4HEHj7Swj1Fb+OD+9Q+ha7obfB/C/lvdMM62VMASR72sP0rIEuA854tQablW3eGyMagESec2nl
	urdPiJTP2JWNmfdbbuJQLE8iv0u+nVEK9GqDnTWqiCpjpKPRiSRoScOcw=
X-Received: by 2002:a05:7022:ed02:b0:147:5149:d12d with SMTP id a92af1059eb24-14d33f39e14mr4209784c88.18.1790864264892;
        Thu, 01 Oct 2026 07:17:44 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14df3ed1adcsm6451579c88.10.2026.10.01.07.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:17:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xCHbT-0000000EHOj-0Nin;
	Thu, 01 Oct 2026 11:17:43 -0300
Date: Thu, 1 Oct 2026 11:17:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: ackerleytng@google.com, Hugh Dickins <hughd@google.com>,
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
	Fred Griffoul <fgriffo@amazon.co.uk>,
	Connor Williamson <connordw@amazon.com>, kernel-team@android.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 01/17] mm: shmem: Implement guest_memfd provider
 operations for tmpfs
Message-ID: <20261001141743.GB3019323@ziepe.ca>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
 <20260925-gmem-tmpfs-backend-v1-1-d36159822d18@google.com>
 <9292b27b8f48c515bee3246cf3b3a60762302186.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9292b27b8f48c515bee3246cf3b3a60762302186.camel@infradead.org>

On Thu, Oct 01, 2026 at 02:07:40PM +0100, David Woodhouse wrote:
> The *consumers* of this memory provider API will include KVM/guestmemfd
> and IOMMUFD. The latter *might* be through masquerading as dmabuf, or
> IOMMUFD might treat memory providers as a first class citizen and be
> taught to consume them directly.

If we are reinventing a dmabuf improved for these use cases then lets
just use it directly.

It would be nice if it could handle MMIO and "cachable MMIO" as well.

Jason
