Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D079831F9B1;
	Wed, 22 Jul 2026 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784721639; cv=none; b=BQFzVs+MAmLfVO+QIjSkO27C02bcSjO0A6hjCdt5cgj7vRnuw+A98usThwR4jfFwFEabfuKT4rR/ovaJyNtRNFfv1r25ZCBID06aJdC8YNzYRRcNohXdyaAVBN/7+NRsCTFMOMcx5FeaZBasqN8RdN2Nq+lvlQ+6+2PyWusSxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784721639; c=relaxed/simple;
	bh=9zM4CsvwB3ammwOcYZBu+ACpLNDw2uvPPV0Tq7R8r9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAxreBoqKvuiASZQ168bqiSTJiYFobjP97E08P2SjZzOFoBAPFEiJOQORESGUydNdzY2AAeo444SM4k3nVK/Fb54TP3FIrlonBo8x4IDzuyQPrUp57Rj85hGE1wjA8/DMdI62Gg4f4NAZIz7SN2+A2bekI0+h9ziuFCSWHuSGsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wbiz9VJT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbiz9VJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5907C1F00A3D;
	Wed, 22 Jul 2026 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784721638;
	bh=9A4b1VU0zQdVia5DOx0R5a1QrYj5Dm7uD2Zk8LZbqJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wbiz9VJTv4uZOavwrOpXVSHy7uuxf3M4Fba+TMVnQDp/oiXMWXS+nlCENTFqqNnPb
	 Kz+zQyxNzrM62VIKH6iu7GqbqPMAuEE/1lypRLDfDmfHDcV1N9mL5ZSz1Qzrl6k/a5
	 3+sBqdHZvXqAxHC3QiaUdnBA2Q1itCWBz3EvPh3fsCgM/YhLS6AFXv2Bj0JAByrr89
	 xYVZbdfGDpKre6mEh9bOpXc5mcdiiC3JvnbPeMm305TyYVeeYQ7qTHQesRKPSYCZOk
	 Yb8ZTvHJwHjKzxIeSS9KaQfoYiGJeStb6fFqTuvj3v+cPqv0c+at26lFdODK3RbfYN
	 kvdedxdn7rJdA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 77935F40086;
	Wed, 22 Jul 2026 08:00:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 22 Jul 2026 08:00:37 -0400
X-ME-Sender: <xms:5bBgahlXR__QtAS9OQtoVhoivp34qwmWNY0ocyOLXOOfPik_VKJ8LA>
    <xme:5bBgavIvpl_5THVP7Q6EGtZUjVghICr938UrubYJ8aOxQrD1D8quu-tVm-iYByACI
    eCV8EHpARdsY2qfuTlBA2ZGfVy7Y87pqvgWkls8IqCrZdxTnkslB-A>
X-ME-Received: <xmr:5bBgamUzwTQHMSbek1yIvE1YvD7HUmW9BYOCnuEGbffu90l6BwjEhER__LAwKQ>
X-ME-Proxy-Cause: dmFkZTGrWA2P9MoWmY8SVxXUqsmXTjpz/RNS13nSx3eLvnipr3fFDktdiB6rtZC+JU9Pih
    9CqGeoiv0KaSCYHjGF6kZ8HER2IE9UAI4sUBkCtGv069K/qteEzwU/CacqSLnOTlKLn12A
    AmzF1NiD2YKeBaNBoCdXTcKST+ETfmaxu1KVgAcVB4JDGpHYYWMxYVRY8ZXkARumZfpiDe
    b1VaBgEylYjrceizsJ9O9+emXrtHcdkiykwNLiKxdDTH9/LPMjokr03N0ICGodbEKY5qoB
    Y7pfLMJviCV34XeFyLZytd8hXAhJcY81KuUOo6opff3Qzer3szqXrZbpnUIse7zE8XVEO+
    OngOf1QA7Sk2ZwZrzrAi/hsXdkdas4kTaDW1BYCxJMZH7ZKOZkFlHFlRjTU5tdurtWoq2V
    ZQUkL1vFVp8N8kUFz63sxPHmlMTXDUO3Zmn6FHhzoPbk+nXuSnyEV5RPetB7rQeRLI9Fzo
    v8QnGYXh8XclYXrKV+UyWuqqEtNcEbxCh+M5EQnNnk3y+Lc0DSja/QIwvLjXBjpW4m+TA4
    q8Ydr9GCtc6dXzeXwObWFOcpdMmdjj3qMldosaJqKhqiCmpIuGsaHy3Y61Br9idtlRkXFx
    J0xRVmWzMhTQW4yA98KDYr4KyMjnIdbZEgSCxLnVNhgGQjzgVR4SYUpFJELA
X-ME-Proxy: <xmx:5bBgaui1uHrHObvR4jUBr33QYDkbaDK2CZ1GgB1iVdOKI-NOId8EMg>
    <xmx:5bBgatcAhbOPOW5hfilQ1QYK_pcQ_ktUH5uArlKklo9glqkMiqI99w>
    <xmx:5bBgaos1Zla0eLaVHJlSDEsOK9GCN6fG6pYu3lFtOUK8efwYEaRz7w>
    <xmx:5bBgainEOI6pmmJbRgId1V-_XHHZBgfiv09DBgm_1Z0i_StJPuNQXQ>
    <xmx:5bBgakNDpZCBYCTC2_t7cNEqBnyFk_1WnK7vmxQ0GFwtna2yRlhVjiHw>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 08:00:36 -0400 (EDT)
Date: Wed, 22 Jul 2026 13:00:35 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Hansen, Dave" <dave.hansen@intel.com>, 
	"Fang, Peter" <peter.fang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "hpa@zytor.com" <hpa@zytor.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v2 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <amCv00f5Q6QlztyY@thinkstation>
References: <20260717214349.4075994-1-peter.fang@intel.com>
 <20260717214349.4075994-3-peter.fang@intel.com>
 <51059852-9a10-4735-a81d-003b4b1963a6@intel.com>
 <20260721064907.GG3178326@pedri>
 <d88fe58e-5963-49a5-86a4-6a9779d06109@intel.com>
 <741eb8b8b83dd10d39f304133a7625f4232ab793.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <741eb8b8b83dd10d39f304133a7625f4232ab793.camel@intel.com>

On Tue, Jul 21, 2026 at 04:43:57PM +0000, Edgecombe, Rick P wrote:
> BUT, is this number coming from the untrusted host or the TDX module? I cant
> find TDCS_QUOTE_MAX_SIZE in the docs.

I cannot find it too. Peter, any pointers where it is documented
publicly?

> If it is coming from the TDX module then
> we are not talking about security considerations at all. It's just a functional
> "do you want to know if things are failing". Not sure why this one would be
> special in that regard. If we think it will fail so often that we don't want a
> warning, then we probably need another solution.

Silent makes no sense to me. We are talking about attestation. If
attestation fails the TD is functionally dead: it cannot obtain secrets.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
