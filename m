Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D04F30F5
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561835; cv=none; b=JmcPdtF8hr147g/hHwqMUT4PAZB6Vd2W2dnk840dRvBs73cgwZDFjKznE3Wd+DxvFsl66xgOwYNJRsAR9PAt6qn2rjX/viLSQJUxLLoT972qXOA3Zj6wppieSrAxpdo8ZDd1E5nM7vAxKsCk2Iyu0BXitRzu4q0rwpyJVBkvAWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561835; c=relaxed/simple;
	bh=cvP/RsiOaR0zMNbZjYjx4ZEbNDCN8zOgu1toEbYhi+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si8Wi5958/t0firH97oe5QbfeuRPZRMmd3A+9VseviAfCLwckJcPqMw1DTEg6Om2j1UujUOEAK4U4nyFF0khbOfWP7CQpFZ4c8cXzN19tXWfZ4k1tjFQpaaLD5jcVJbnpPou3lCjZT7b0BlQq0Zyb2gC1Z2gtzB8nzwmHau9MCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOCnYdIk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOCnYdIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462C61F00899;
	Wed, 16 Sep 2026 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561833;
	bh=J5smoL6jvTdR654OVuf3f2KumFBR4groIFahylWHxZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jOCnYdIkND9jVZqBCeY6hLpTTbb8hgCiV/hUAOQXrBW6OJQAqwUiY+IkAXbjxj3UY
	 kY5oocdALc5s2dTuS3xZiO/sxPHLWCXFUmueGGK3zNOTX9tv2bqVkJx4xGB9IK8ceM
	 8bB2EDuZFmYK2ZnJOEj8p3CBtfOIHEpb50vrgYr1p2bb6P9FIOVUA7rkHOedEW/KDg
	 jRj+4CIJMT6hGdPEI/ns0ieMxPyieiD2zSqE5JfvoicpS9qqoHvpDWC+xIN4jCEzfQ
	 XQ5Y3leDutfJtH8oN13/WncK8OtXDLLrZwAlTDQcWQJeDuAiigp0RN0Adph1E51jfv
	 6hvxM/3/eT7ow==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 221341980047;
	Wed, 16 Sep 2026 08:30:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 16 Sep 2026 08:30:30 -0400
X-ME-Sender: <xms:44uqavrjIJBu4FWSFaLnKvWYggpA1dB8ov5uREfuMDyi4-DMzRNKTg>
    <xme:44uqao5OSEA61y8b8rlRnmXTjnvmLZm1N7hUc9y2wvrNKMrqlL4kPpwPZcAaK5nhR
    33LJSrdWD_ceZHRFnsgzjhV1GpdobYD5z6JeuSy3N8OW96d_tdKtTX0>
X-ME-Received: <xmr:44uqaoabpSIMY6-2d4EiQAQnLCsr3SCKOmHzXg2U7hELLN5yUDKppHmvLBc>
X-ME-Proxy-Cause: dmFkZTFq6odZDDV1MbWatV/ogB8xNp9I0LZXqD9XYhLxfYbKOKS8UmtQu9jik/YJw5+uDe
    IQ6yOJ08HjDRPvYi9QFt1jq0pHGSfYW6nwxE+Sm7yr9nKcBmi5RUalxcvapJTiUZkcarzc
    Altx5IaL1NPrtSorlwPUW9SMwDvZR/9hNrEX1CWPEvmZJDDv27xZOM6Inb5XPJLhAbLlhk
    CcFHRQ1NHECVdbI0qiw3RFSyKV9nCbqC0DillmW/DW7U11KmKmJu9FpAeasYtIEcLsZ/VX
    fguKYmbKr3ea2GVW7GZmUiPj4seG2XhlkZtj5DvqTtNjjQkLAf9OUw31q4uYXd9/ZONdI1
    qilSP1JLzIB5juM4aAmsOYOuFreOUeRLaOA05n2XyojmpZUw4z8Qoj7FYkU4ivv4KPmKqg
    IppZcuQ4qXZTdlo3f/Zxj/WjD+NqW7FY9zyKdwSZjwg1qJCe20oNJ10CYs8fN9skNQiwcl
    zuFwrR9i+jrFpxCCI45E/uL4g0KMwhWo9lRzXN1hfFHZcXeE0XC5yIbJD6WTu17DVOavhr
    PfuNI6Ou6DoB46PHAgjjQxCqLWNFgk1f46q7jSddisFDKEIHE8gKwdxEl1pFcgBzc/koqt
    4Ggl+H/gfVqXesUjghBY5ZnV1eHm3aFGFXEZ2N2fPK0YSx4cnZU/BRjGaZ1w
X-ME-Proxy: <xmx:44uqatrUtrnCoVecgnfJXi-sDQTaS5U105AfiZEAP8Phb9q_ipZ7MQ>
    <xmx:44uqah4pUZjzsCiGW5p2eREmaWZbLbjbRUgmpFK4j3BrdeQcuJUwTA>
    <xmx:44uqaqSUZs_ZCPdO4VMlNdEHeNk-C5E-toxGWcnq62lAgT83Hn4FZw>
    <xmx:44uqah2oGeSSKcPoK3fWFlfNKvEJhKqfvQxtXpjC1SZC4dfNc7V8Mg>
    <xmx:44uqah7qHcBlWHOcnkGkmfqzCu55F0gpz_dDddg1o8rR75Q8sV4DGkf6>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 08:30:27 -0400 (EDT)
Date: Wed, 16 Sep 2026 13:30:26 +0100
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
Subject: Re: [PATCH v4 3/4] virt: tdx-guest: Use a variable to store the
 Quote buffer size
Message-ID: <aqqLv6Nw9jaj_duX@thinkstation>
References: <20260915092632.2822169-1-peter.fang@intel.com>
 <20260915092632.2822169-4-peter.fang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915092632.2822169-4-peter.fang@intel.com>

On Tue, Sep 15, 2026 at 02:26:02AM -0700, Peter Fang wrote:
> In preparation for dynamic Quote buffer size, replace the fixed size
> constant with a variable.
> 
> The constant is sprinkled across several places. Read the size from the
> variable instead.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
