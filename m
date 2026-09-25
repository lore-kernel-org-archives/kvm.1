Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960C3148C9
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790335185; cv=none; b=Eg8pU6XUx5U74emVB4l5wQb9PGEhzzrqbMiN0Z1iV6/hjSxX+cD69yT/J8g9BBJOASiWk1yiQtBFZBk3BoQxD9FaV5O3+cD+39fj7dC5ftittuObr5mPl7FeP9/EfeehThwaI9h1zU13s7M4LP+SWlV1JbFucp2T9fboT2GJKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790335185; c=relaxed/simple;
	bh=wSluQmSSorSp9ZHinGh5VyHG4yg7o2jMaeGz1BYn03g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2OYvGvHHJrnqntWqYc6EBdSco8NFqkk9IE3pTSRd7PlPXKlZHtjv6riz2F4BpHjhbvXcDzwM37rooKyNoiKEDPkRsFtBqwKbhtq7TyDNyYj8QtgKZuBqEuzw4CFgEJ262TcUAAJvWDr4P1btzZszxu0nizrvudTKn4l62gl3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Anpt9Fav; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FkS1+yI2; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Anpt9Fav";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FkS1+yI2"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3317A7A00D1;
	Fri, 25 Sep 2026 07:19:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 25 Sep 2026 07:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1790335181; x=1790421581; bh=br5qg3sOBqD4VUHI35euHRC7GezouLRE
	XInGGSs+VI4=; b=Anpt9FavthLZoIA6nKOXZg8FSdV9x8sIdQBheF2t7EFBkRwC
	HVCHiYcZgJaeOjDf/XBFZN36wAMFz3vE3pcIQ7h2Zfv1eEphv3jqtIAjbwNpkVfj
	mkN6RPp8L6H8iHAWUCJnjp4RX/qNztgBbB4rZ60jjMVQWZLfXILuhEcGscvBMHxm
	7LLvEN/OJdjlmQqdwpOLC35TN7xf7fS+0zu41HbWKqcg6wr8gAPCAtJx7S1yNE0i
	2pZxi1hsY+f1GimrXLabG4n8dQTS/45tBZSPbb/j3WT2mxeA1LWq7jiiwJyjNyBi
	+EBMmWnxfVY6yE+a7XhaQyHOB64rhDKG3X6Drg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790335181; x=
	1790421581; bh=br5qg3sOBqD4VUHI35euHRC7GezouLREXInGGSs+VI4=; b=F
	kS1+yI2KBkgqpc5d5zUEgzh7pN+32IvGiFRJTDqfrh4pDVsE8hHCvTZWqr7mK30S
	EQNZM8uO5Xq/34dv2GW37pg1IXmX6JumpgA/+pwk0VafFpCY2BwitMQVQ2bSFLUJ
	nHPUAbyszVf4TkgN6vgXNL3fKZGRJY3yPeYyPRa/Re9WHG8591pUJTMm916qcZ8y
	DmsW0EkmsadNk0Up6WatSwLBXQgbIecQ0GnYqbJ7XO8o/V+zJg1dKpM3VMwuVSxD
	lWUCYbGzFhyUiUfRdAULYcOPkeH3Hkq+hufUv4npaWqfzV2bJfJkDQnc3tzm4isL
	b08Edu2K4yZSU1F2nHklw==
X-ME-Sender: <xms:zFi2at4OgSjC0YdCP2QvAy-plim6kk0BzqGiAuIIErC-vZGesyFFyQ>
    <xme:zFi2ar1GL6e_7i4a2O6yTIoi0cOGiLzd0zjJ_6mw6u0CkNKzBYuhc3xJ2Z7pFRFyJ
    Ti4NStgrzI_57VlE11HB-77pqxvyfj9NTS2WSO__C6VOKxLGNeDAss>
X-ME-Received: <xmr:zFi2akzyl6Mus_b3E6tAX4ggZlE734hr4ztR5XkntIK1uvVCZW4mafjqsR8>
X-ME-Proxy-Cause: dmFkZTGvQ80WebMSBUckFVV0jr3YL9tpWR/04NOusVjI66dlelAkWycWX+k3hFhwbjINRn
    bZCU4oDfTAEw3Tr9PsxAgQU0BFsqV7rLEFIqYCEgitYabbUUZTzGUEzDguUD59aHyYRusn
    NVTgQRb4m+ovjCmPKWNN+muzuCv22amZmKkA3ShSZ5UNm1La00sh4z/0kOydDe8pW+N/vD
    VBMSVi7Z+jhr5Z9cs1dei38nThW8mIC32EWA31MUeiwmb3ev8FvFmKIaSdLxVnRhTQCjNB
    i3uS+lApeBuJPKq+dsjjxu4rKSeIAgIi5d1cXq2mRJWPrw6cRPf0Ql2fRT91N+otYCtotq
    MRaVYiJ9d7n1XGc6TfELpiZL3aupgV0GHMjzD+eHeWpYCdj/Nwx7qsJga6pQCRqFOIJ0Ic
    sor5WVP3wZlMa3f7wSgoJo/EFvVhuCaalDOHgk1NYmh42rXIs9Yd8kK7vXcsjtAzSTy4vZ
    IbCMh6jMD9Jmlz5nEkUBWhWIEmN3iDqABzV7wdbRk8zmUIUfNUU+HLVU+er2H40UKKZg/2
    cAoaasKmSa2Tg5F/4ChJ3cONlQqFFBpKveCYgAxaAlRuZHV4TZmG85RuWI4AxZviOPCTTP
    PIUCQFl/EfMGywKIvE/CRM6UpwzU6pq/tKNYQKdlcFQfKHSpdmWE5A1P8uuQ
X-ME-Proxy: <xmx:zFi2akk89B4U8leOA6eGwXjASlbv2Lq0WjP0DxHj-nn9nTrEyiZWGw>
    <xmx:zFi2an_jaDfpxxKQYA_IGGSdvahXoV8M5O0QuXcdRJeioqwCEuOw5g>
    <xmx:zFi2avq1ZfhdAMevUkNBG5PKcDR0pa3OCpeH2qRfi7EiojGIpcGe5Q>
    <xmx:zFi2arKzJnaUoJPss5dRTH36efTEzWBUkZjQVfwTbFJiszENj30cZg>
    <xmx:zVi2ahkCoCduSoy34kze4xjFE3a8j9OcJtYI3f5X_X3-ObHubhZN4uV4>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 07:19:40 -0400 (EDT)
Date: Fri, 25 Sep 2026 12:19:39 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: dave.hansen@linux.intel.com, rick.p.edgecombe@intel.com, 
	xiaoyao.li@intel.com, linux-coco@lists.linux.dev, kvm@vger.kernel.org, x86@kernel.org, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: [PATCH v2] x86/tdx: Harden exports
Message-ID: <arZYKKo7fHFzosNY@thinkstation>
References: <20260917110714.1587301-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917110714.1587301-1-nik.borisov@suse.com>

On Thu, Sep 17, 2026 at 02:07:14PM +0300, Nikolay Borisov wrote:
> tdx_* function aren't supposed to be used by the kernel at large, rather
> they are mostly used by KVM and a very small number of them are exposed
> via the tdx-guest/tdx-host drivers. Reflect this fact in their
> EXPORT_SYMBOL* declarations.

Subject could be better. Something like "x86/tdx: Restrict attestation
exports to the tdx-guest driver"?

The changelog still talks about KVM and tdx-host. Rewrite it.

> Reported-by: Michal Koutný <mkoutny@suse.com>

Maybe Suggested-by rather than Reported-by? There is no bug here.

> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>

With that fixed you can use my:

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
