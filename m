Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337184EC66B;
	Wed, 16 Sep 2026 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561879; cv=none; b=oAngiZj7VflNerJ02U+7ukwNotBfhmHLTXEeuVVELxDvzRvhGlnlIHD89q3gupv078czE/rueFWSXnELONNfeGKM+JbAaDxg93ObDl2KXkhFoPs0jd5OZm3lS+fBXSi5h3Racj1d9Llb2+PYK7rBfPik97fByd3wZw6clSYfaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561879; c=relaxed/simple;
	bh=NQyn7xnCW2kOyOTszqYsFf4/IwEShE2xbk0rOecXvZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3A5A3U7mvwpKeUz8/7XOY1Mpd6q99NCzRIXXVurEOwmPtWbCDVd2It7WqqORnOvvh3V/+l2Gap4ju6z3t2i8q9zKNK/EXtlc07jt6o+ZdoJ0v0XfBEBlrbaO1jnn9aEqGzUNM1UyM5Nu+sQDkyY8MspTqHnStI9jZV+cEpmi8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h14U3BC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h14U3BC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AD71F000FF;
	Wed, 16 Sep 2026 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561874;
	bh=zUK8acdC54iLgP1wZLTv3kmWmHfOWNMJRPSZykmGE0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h14U3BC+BhW5anDkEGTScLBkddRPDlDT4jJcpagnKIKbKZlCIIGY48ZH6HWk2LRDr
	 kY7AZR24QBMiaxzmDkYFA/XfXeFLu+hdQtI+5RMCcFJMBQGNXSd3+zMgA0M9Q69m76
	 s00FTSAPLVf3frOLe3kvvpWm12jctNkMR2ia5emKnoEBRdDEyD9lM4Ti0wKFMXVbDf
	 bFLFai8sTMWSP52cvNOSAifiCd5DJ8WY65HrIconZSvIsrCSHr0wU03kZXcKpouOp2
	 z+iaaoz39EF9r1jgo1UuqRENkkuh92Bewzfck1RJp1/clIRxVti6tv5DnNDbcdAHdu
	 Pxabf1hHnnOvQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 3AF8D198003A;
	Wed, 16 Sep 2026 08:31:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 16 Sep 2026 08:31:11 -0400
X-ME-Sender: <xms:DIyqaio0TRUQSabjoM5AMoDIOWpgHtjGFB4SEwN8RaS3RpjNVjmqwQ>
    <xme:DIyqav6ScVC8f4BamGmSQH0_n6C-_WGQDXmJ-ag4Jj3Sb0gG_K-sffDNoKiQ8HBlM
    Py_WOYYNwnhEgokxws6UKU9gAhK847fvk1svlEq7dbaIrZKiZf9U31OXw>
X-ME-Received: <xmr:DIyqajZf9E5j1_codcnvChlOtksQxgZksKhQp0i7JIVcqQTJQecMVmBsYew>
X-ME-Proxy-Cause: dmFkZTGq+HgZ5fIHRs1lwXL79bYGzqK9qEPPO5xkwezZpnZ+b7WRlipjHVnZLJAb4KlQUS
    hIMlKvGH0XEIA9ZeF+C/Z/Qmq4OtCnR8dDtlLK14MCY0jDi1fxFBc+6UTaUCjbmAugoWLS
    n0/O1WLIiMxY1F2qQj+HhA4JJBUqekx9DO6evdBJVtzpWaKZ2y6HbchvhEgnWlOX2V+61V
    6bADL+syu3oE5pulEJaoZg0lXiP10Sn+/aadjKSgnLscEJHUXdgkZJJKg0zDPF388FcCID
    EbEkIzf5peZvXp7LeUGhnzwIcRxM1dnBV8nhi+fAE5fdOWbmg84F7Hq6jpStUBK3x2qBt6
    QAf0cNT0BJcy+3Ymw2eGzbXVR7qPitp5MLibg+WuKQva1RAscP5DyuzyWtLcm6XG7IC9Tp
    /MuuTlDZZnhLR3dkegV2QpSGIuqd5DkFNOeCyAf4ENFGgACupkVtlFTkcz48Ayr2vV8i5W
    5Awa+dnrS7RKsTd3Epn93Yl7KA9qua6nDlkFIch3nckuEn9KzMUYc5VsEKBKzuvSiTCLOK
    d/KwlVsG6yfA4ro0c0ycttg74zoGqddQctyXTidc+yNz9Ccf+3J+iJbwajYKqIj4no/YaC
    n2XiI46e2o52pUIY9EB33Ru7aivsLY3KUqyjdgozlzMCBm5X7ZC3/RDwbV8A
X-ME-Proxy: <xmx:DIyqaspGUGHbKOenR4cAj7obkInI8wjqeCFYYJV1uSnOF_iNayB6LA>
    <xmx:DIyqak5MRPokJOzkzt3UIsXc1UoCNDN6PuANaMIUHDoZKQx0pAnAbA>
    <xmx:DIyqahSwyQXHw96EJT3qevfTC7uNi6hFLRD7ZXF0y3MA4xU7oca_1w>
    <xmx:DIyqas32MoK6EtWAnLPm7mxphkMQJVajjswLpf0OprTD-pQMd5ssmg>
    <xmx:DIyqag6L1vfd10Jye5u0Jr39RDyHxw-NVVUw3XCP4daZAeL7llZWj8EW>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 08:31:08 -0400 (EDT)
Date: Wed, 16 Sep 2026 13:31:07 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Tony Lindgren <tony.lindgren@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>, Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: Re: [PATCH v4 4/4] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <aqqL8uUxfIYhN8b8@thinkstation>
References: <20260915092632.2822169-1-peter.fang@intel.com>
 <20260915092632.2822169-5-peter.fang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915092632.2822169-5-peter.fang@intel.com>

On Tue, Sep 15, 2026 at 02:26:03AM -0700, Peter Fang wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> A new TDX module ABI reports the Quote size limit in a metadata field.
> Prior to this, the guest driver uses a fixed 128KB buffer. Intel derived
> this number from current Quote types, but that is not sustainable as
> Quotes evolve. 128KB may be too small for Quotes using schemes such as
> post-quantum cryptography (PQC), where larger certificate chains can
> increase the Quote size significantly. With this ABI, the guest no
> longer has to rely on some empirical number.
> 
> Allocate the Quote buffer based on the reported limit. This avoids
> wasting memory on platforms that do not need larger Quotes. Older
> platforms fall back to the default 128KB buffer.
> 
> As a result, the maximum size of the "outblob" file in configfs-tsm now
> depends on the TDX module.
> 
> Because the Quote buffer must be physically contiguous, its size is
> bound by the buddy allocator's maximum page order (4MB), which should be
> sufficient for current attestation needs.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
