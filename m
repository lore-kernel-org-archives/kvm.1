Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B8C2D12F3
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776123636; cv=none; b=Qa6h8wOkncbTNmhNRO+mOJONByXQCKWp289hYiXbivMougrMZS6FWwZHScOhFjx4LeYX4JG2x+tRumP1Zawsz2sd3isUTi6UmpbxSVXNqoVjvVxz/n9v31lp7DoThIW/ZbCleRPYTsjLY5qXuvlO291LpitBWsbl+Bti5qjaq4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776123636; c=relaxed/simple;
	bh=q9GsDWqx4vIAmP/y72aLjZfj1Cz9Fw5+/QUmCubtrss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ75jeG1iO769cpJU+jAfvQ5g2SRUNZzxYvqSIRsjku6e61izgr0donQTn+vDKbjoAPT+VfQUdiwxGGSfGVY5CrtvkFMyZqpFmK6FqRO00/HdbTh7wYnyVU37Vh05bso4gId30Tao/RjKc484LNNQDe4/aCyMcWo6nxyU/2ypiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iIZjKhkf; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iIZjKhkf"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-505a1789a27so25686381cf.3
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 16:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776123634; x=1776728434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ToWxrQd5JMxwaz3rbuBFhGsBagVFYiOF9oK6XIorEnc=;
        b=iIZjKhkfDpe0Tey8NcyX7EOc/kdtLuNbxV1LeIFs9bBrOJ8fH683rA4z0I0bBpcL9V
         pVvMVAtCGtrspTEQb0JrFNXFXOA/QbxbsmK8n1oqGsdvJY/7OQ4BE0MJPgikW+JcrZbc
         Mx9HPL/Yg2q7SSYIPPUTga/9SyljZCe/xAV6Czfgq945P0/t63jVbUHT4QqDpMM2fg+3
         8yZmDz0XzIcserSpnx3HWLLU1KBJgl7lb5a3lEMfR8A89zQvUIFaxFE3W3HMfQ2n37qL
         EEGoUnuC0hfuhVzTDA/2FKFTVvbTSfyOgEw4Xphktfg5yvrckiYzBlM4Ol+SC7T2Psdn
         lk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776123634; x=1776728434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToWxrQd5JMxwaz3rbuBFhGsBagVFYiOF9oK6XIorEnc=;
        b=boH9VC6p54VJw9RE3qSRsCFPBIrzEO/padgyop3YGGskiuymjPn3l0xHWs5aqP+DNw
         h1c3KwY2B615PEZBTeBwyhVcNAj1DHn79hy90hjukZJ89/y3k1hqaTTdKz3vpsBOjNwo
         HaSQTY+8t9OrLeF1TLFKuB5ziBLXiPsvlYyF5mL6m0MpWtVe9GS3I2nmKRbweKxmibSG
         rHXGPpDnw0ynGILdahADFg4edzEE7b8bKlhMy2Hwj8DXUsvbRehGJCQbz9h7/HCqv1YQ
         B5qVmVDAN7UvAm1BCCkrFdkUjTqU39e5RpavdVnb4cv6W9fFYsW4P/0nHpdBNJm1KYoV
         y6qg==
X-Forwarded-Encrypted: i=1; AFNElJ+M61++ulr7jN4cZyMy5O6xzHh66FIaB/gBWnbRcO+ZaFLU416/hYrAyoNhQTcSYJkLhLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLyTRY2aj1CZ8idko0bkarffUj0i9ek1j6jUj9Brm5btL12zk9
	D9qmnasHEqiIdYhAe0qFYJwFvawBKvBZVs+fPYqdUBHQZxHrmZe/vJ9GE0IiRHVfYMk=
X-Gm-Gg: AeBDiesWSP0f+tnyyKj/piVcIozK4Cv1U84cOT4DQkAqDKbLa8YZD8QD50jQ7SdyLa3
	dUgHOxb9CzFGqarmd5fmQ3wIuAS5D+5V2yzv6DRcm5CvjiPyHkxEAQyyZqNx5RJXn9fq1pLppNu
	zCfwb0aXry9k7J1vecBVOZhsVrLHPuafjGgV4LkECWk5P7+HP2sEAqBORkqanUtDCscdgvHkN9r
	p20N3se0gaLDnkc7jC7mBjj0mIl5wtN7DvIYzzM5UfrqlF242kCaPIzoXws+MGXaJa9ge/u3L4G
	kSePdzeKkVQaoZD2MdCcW07s33Wh/xgkcA0igcCvrOpdTLYuKte+VEMPHNK+9cPGi8i8MgclK2p
	xUEZycAUTMsK2RSCDHQOUDZ/FRCSjh/vXewPSfMQtidpn8t1x2f3wHDJtidJnUkZ7AXLI3NUrjc
	qpoaZxiqyQw3Y2LCRkU2827O1Lflt+1PiZiDcWmEmXknglMRMjSM4GuTzf34SURwQ47Xi8W9Ycf
	P7ekQ==
X-Received: by 2002:a05:622a:209:b0:50d:65ec:a071 with SMTP id d75a77b69052e-50dd5a91ae1mr245871871cf.5.1776123634207;
        Mon, 13 Apr 2026 16:40:34 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd5607b83sm98638941cf.24.2026.04.13.16.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:40:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCQtM-00000007OXQ-2rtN;
	Mon, 13 Apr 2026 20:40:32 -0300
Date: Mon, 13 Apr 2026 20:40:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <20260413234032.GT3694781@ziepe.ca>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
 <ab3CtC0vN6J975V5@google.com>
 <20260410141652.GV2551565@ziepe.ca>
 <adl2QX6gra99bkOV@google.com>
 <20260410231650.GD3694781@ziepe.ca>
 <ad0b-5aRU172-Od8@google.com>
 <20260413223318.GR3694781@ziepe.ca>
 <ad1z6YYIiO_jBX3P@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad1z6YYIiO_jBX3P@google.com>

On Mon, Apr 13, 2026 at 11:28:57PM +0000, Samiullah Khawaja wrote:
> > Hmm, even the free walker requires computing the end_index, and that
> > requires at least vasz. eg ARM will compute the number of items in the
> > top level based on vasz to support concatenated pages.
> 
> Yes end_index setup using "derived vasz" is exactly what I was referring
> to earlier. Basically KHO stores the order of the folio, so we can look
> at the order of the top_table and that should give us an idea of
> vasz?

The top range can be smaller than a full page too.

> Even if actual vasz is less than the one drived from the order of the
> page in next kernel, rest of the page should be filled with zeroes, so
> iterating through it should be fine?

I wouldn't do that, it technically breaks the design.

> complexity and ABI right now. We can put in more functionality with
> subsequent patch series to handle other usecases. WDYT?

Yeah
 
> > I don't think sign_extend is used in the free path though.
> 
> I think it is used in the pt_all_range() during free to calculate the
> range to iterate over. Based on the sign_extend it decides the vasz and
> that affect last_va and that affects end_index.

Hmm, Okay it used to not do that, now it does :)

So that will need to be preserved too

Jason
