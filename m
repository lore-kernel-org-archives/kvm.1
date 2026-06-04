Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D42FA0C6;
	Thu,  4 Jun 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592351; cv=none; b=kbMgrD7Q4X6+5U6L7qYXM5QhYgjK0DoJ/NAL3D3vd7QGckCJFlsS/IDe0e0H/blGrXvWYgRrU1wzvNePGXWL5ko2as2GKnZj7QA8Zj+AV7Sy3nEY4V4ijxNOnw1w74bSJQcACRp98N6r4kLmN34i1XjLkHW8u/2BWzCygZ2eGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592351; c=relaxed/simple;
	bh=fv+HWUge/YP8LYuL46ALrxGkihxGGgZyzKU2vno5rho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3FY9LoulQmnvYd0YerROqw2etIip5ckOMXftOar0F9m/6bP9RjiyaIs1N+3yQcpR3GFp8PnV23e5Ws+oJaDUjl/TkzMhs3Cl2+El4lEb6WCIHPudbb4qjIPFxqOSiY6Rmt9DROydlsi0XEK8FhiY9/4Pk8FURAg8qTwcywcF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJrGtIOm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJrGtIOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0FE1F00893;
	Thu,  4 Jun 2026 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780592349;
	bh=WVPTTMo8bIsk9JlGvzesKjGz/XtA0MV3XLnFt/zj6d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TJrGtIOm0lsNeIQ9NVH3n+3zIJYUyBQu5gMOCKqG17JFYSsGSTJ1wARYLNdOZLqAX
	 jSDLw2xFjMH7aN0GeSbCBjAz3fR1tA58NutrNh3A46dM9QXpDqXAGieeRQ1hlqy+96
	 ETGEcwIW5sVB5G6IZbvpF1Bl5aelyHdIM5bIncxmUSokOGgL1duge4JTQ3J1Ylye2S
	 hotVP0BQq7+rxP2Mr6SBWAZqmkN/dXfedFhLdjO3hLiYq8zkpJpR3sY8sBRHRVWGIA
	 XQdxjbjY/LJkE6g3GdDtcYSUnYRhrn/79+M1rCcDKbe2l59niTRHvyrkp23cAHltWB
	 Zr6LIOZCuiQQw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9BB27F40069;
	Thu,  4 Jun 2026 12:59:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 04 Jun 2026 12:59:08 -0400
X-ME-Sender: <xms:3K4hanxi0LzocSq5vJ_h92PVMo3LKj2M3plMBSjtgoV7weU97s5w_w>
    <xme:3K4hahWaWT-35FSg5ed_xZ63njPogq_nsuZ3t_UzCiTY-xApQxiuBgs5ehnjEjLhn
    _ISozuJaoHz8njv0YwuAy9dj0nXRXI6Q9iGSA3_GZdRys75KGSk9Q>
X-ME-Received: <xmr:3K4havd-xjOR57bfKHlT9eEKtcjJs6pFEI_ZSA7AZoGCI8KSmtGOXTEkazaSOw>
X-ME-Proxy-Cause: dmFkZTGeoB4SgjdWj4Dl9/PtRKRJtdUvzP3KQVWBMoAhNypI18EqanJi+PGfEFRdTkzCHV
    ht2/0RJ2iMKxcgYpniz1aqwXmhEID8Qa1IB4iB5HQM/SMt7GGsdVaIKr8BOFfrPz+x/189
    /G9YrPAqu47fV0yBhFcev9fqPnqCui/MqX0ssmQMFlB0AT8QTqEuR1h3Fe0YehsIj3ABo2
    tD3rq1FmgQX3BDP2/k1c2rwWdTkQrN9JJ2/VEp86DJPw7O1hL/vdP0B1W6/96HCeO6c1ze
    DXl5yWGC9y8dfj9v13a8VJIMUE9ZZs2qqFz7YCKRQasuvirmqiNkuNOblidwb7vRdfNfjg
    2mFUIL7Pbl3QW84R5BqvwCzTNtFNQFUZhtnp4LMOHsgBLxk3FIwJKwssunLA5BVJ81v/n2
    YvgS3lvxk+/Z+ZZ6VMSLefcGXuLlr3w/9bxQMqe9ZzJOh/PeVJUgsSFaLu+wKcBlASlkmF
    9JmE0XH9vXYesJ2QDsBrQvomGt/qOrJVijYJB1jK281TocrfbT7eOckpICpwg6G1e5BEAP
    ztqSGHM4xjzK8fMo9h8QHHETpdaivkuQrePNAEjHwppjMEhGF0cpQAIXVK/hLKAE48GKdk
    HxoTfifyR2wX+ujfPhRDj/oDVM1sNJWxRSd4mbHH0sThZeXMEP8Aj9WVVOkA
X-ME-Proxy: <xmx:3K4hamdtH0smiskAZ4bdJqHOVj4eO2jnFcu3iebZlh0ILR1ZoXuVVQ>
    <xmx:3K4hall8sgDlhXAR1T6ZyYMPDo9sNZo7NKAlU3YtQnPjjgeYDZth0g>
    <xmx:3K4haj_q5krYNmQxBoTDbjW6-ZChMRwbtqFmEIi1IuCPdQc3wSS8gw>
    <xmx:3K4hapHoGhO9ufFGMz28QJSMcPjilLsOSYajz5SIGljjsPKzhV4cFA>
    <xmx:3K4haqLKNYJPiEHF0-UL3WzLdBuywVSYH-Cq8QzdHkXIz1fuxtrHaKB9>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 12:59:06 -0400 (EDT)
Date: Thu, 4 Jun 2026 17:59:02 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"Huang, Kai" <kai.huang@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "seanjc@google.com" <seanjc@google.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal" <vannapurve@google.com>, 
	"bp@alien8.de" <bp@alien8.de>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Message-ID: <aiGq7XjmMrsqdBY5@thinkstation>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-7-rick.p.edgecombe@intel.com>
 <ahVghgNAe4JrmlQH@intel.com>
 <fe08f03a22acfe758cd97f7c2880deeafbc5fe58.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe08f03a22acfe758cd97f7c2880deeafbc5fe58.camel@intel.com>

On Tue, May 26, 2026 at 04:42:24PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2026-05-26 at 16:57 +0800, Chao Gao wrote:
> > > -	scoped_guard(spinlock, &pamt_lock) {
> > 
> > This converts the scoped_guard() added by the previous patch to
> > explicit lock/unlock and goto. It would reduce code churn if the
> > previous patch used that form directly.
> 
> Yea, it's a good point. I actually debated doing it, but decided not to because
> the scoped version is cleaner for the non-optimized version. But for
> reviewability, never doing the scoped version is probably better.

I don't see a reason why we can't keep the scoped_guard() on get side.

On put side, we cannot get atomic_get_and_lock() semantics without
dropping the scoped_guard().

Maybe we should keep it for get?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
