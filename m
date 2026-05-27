Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507EC3EFFD0;
	Wed, 27 May 2026 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879141; cv=none; b=deCGf5jMZMw0DqoQVu2j5QCVf3WaMWf0jqiRhJKvGcSALg0dHUsW2yfu6yR/s06XHy99E/ldNTs4xFe1K9cqSrCHT/8xa7XK1UEA/epq48yP9n/Ma5yPYtphRtKwJhjHYsOQA4Dd0DNkcSZzRdi6wwl0cEGeOzqof8FWkDGaj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879141; c=relaxed/simple;
	bh=B+g4YvqHsDOnAqiOfY8GpdmA2K/xqBIQDqFMvbowv4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNECuLqau/xafwclGWQqfVu8TJ7f/mcqxrtf+x/UrvnbOOTOBkg+mcoZELwFSPu8WY+1ZMWxat8a88J8wQ89IENkspJkTRa3e0cijmKZ1xMLvjpVM888YlgHbZk42wj+U8TBlcDJfIQPRB4WpUV/rZuNFR1qVxTfTDC+fh4W2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTfF9UyH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTfF9UyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A201F00A3E;
	Wed, 27 May 2026 10:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779879140;
	bh=bYZ1ZawJY45HMeql39fayAt+bbGilPmWtkSg8lwQRkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VTfF9UyHggRVD3b88Meuq/pdvPzMOjtYNSjr+C19JK9AIaW34GXfw99L2QlB1BUpp
	 ox9AA2hy5HYmKHoCEpw7/aeMFlTD8eD7p+r058Fqo7A2tZEupmwFLyIMlnched7LtZ
	 gGluKyrLI7l6vXJg7xjvZjYa+mVEb6a2i809OdeABQOnfSUTJ5ycqwPRSpqfooWPkp
	 Xrkubg/iZijBaDRNJPIkhYVUkJ6BpZNya7H5q/j3aYpZm6DwHW0UKu+PWHPVO2oNK5
	 nAKIdXfDlrHXT0xuuwePYCqOe8N+1HiywxMwFORXbKsIdQS4vJzDNbbsbslcES8rw2
	 Cor3p964Zz46A==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6366AF4006F;
	Wed, 27 May 2026 06:52:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 27 May 2026 06:52:18 -0400
X-ME-Sender: <xms:4swWaraOJyE7U8Bi55IhtbqbvuOo_siLAL-A_B0tXIonqGi_adFIpw>
    <xme:4swWahwIxFnmc3WY0i6Xd_RtwFh_pC7BXS73z2pB53W9GFvUqw-b13l3I2p58FobC
    BgCWFg80cWkAadOjc0GV7hBD5ukV-3fq7Pn_qUONtQqw1OLp22YZ-M>
X-ME-Received: <xmr:4swWaoTDgEASqaY9-FnKpmmutvOfUsOwLBzKg2LMTgUtFjp4uvnpsF9A2x9MJw>
X-ME-Proxy-Cause: dmFkZTGQGmNv5Mx6E4sUI3KXUIvD9y9YLx5q/3nV9yEQV99YXai9x6vujP9852Mk+mIcHA
    WNa4/f+TuNBOTkh5tfGKJBzkD5d+ALvaVg69eao/lmmkW5kHf902Qg7ykrI8jYr5umZWJC
    krGKdYKHfbkLojo8cAKNQaDIiIf5hNmKU/c9TWV99Xble4GnKeHCvyjv9ownScLkbkuG69
    YZqUjCfEHE0Um/W+ynZ+ssjoeO6B6WvVsYNNGBmrhpDAqlMlTDEAu2O6KZ+U5iptu+dCEY
    Jg/hX/GBvuwEav4jxeZhgYOjiks/zDZ7FGEKsvYWxjrWbHit++4jAXHdrzE0gpqj1bceoX
    0gtIQ4sQBqQXAbiWKyM8s82wyVOu1Il724kJlkrrWxU7jD7cZZCVMBUTOVrIpzoGRCc1+X
    +qVHD1XfIlP1P1/Ga0j4UGC8ufGx1pu4HCJQlmdPoyrZBs/kpPqTukjQbhm2eKQm+qMBsm
    qm6P4oBpxX2z/Gk6Yb8PMLRH/2lIiMoYgz8Le613tAukDK6JX8kQg1rnB8FG8bi2G6RVqH
    uSpopSYJiYaqTng+Eu6Y9NcrsuF+0+al4xLHTw/5hg0g50/tNiHH/b20yQqtKbsu0T+/VG
    2AnbfWlOAS5MGQ62T9S1aCp69YiXS4gsFaMatg9DQlz2/5pwMVf/+qDLaZDg
X-ME-Proxy: <xmx:4swWanoUmPlAKoTR3uacAZlhXF37dBcOJ6L8OI1m7asWY9d530FAQg>
    <xmx:4swWaqbqG3PNiKMb3gIYS3tkJdG-6egwVElvnRjQfF-MBQN0rEwcYQ>
    <xmx:4swWapoNB8zpCYmppB0h4nKx5jC6Cn-qmChgJEtadZxiFA9KF9xffQ>
    <xmx:4swWaumuGWc0pe50IqB8N-kChWMNkWbJYCHPeBdIE95f8Us8NoUSZQ>
    <xmx:4swWas8AALla6O7nT3rhqG1W-iLcZln23yACoJwbAw1-mA42lXeFVGfJ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 06:52:16 -0400 (EDT)
Date: Wed, 27 May 2026 11:52:10 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, 
	djbw@kernel.org, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v10 03/25] x86/virt/tdx: Consolidate TDX global
 initialization states
Message-ID: <ahbMPxrVbxnql7hu@thinkstation>
References: <20260520133909.409394-1-chao.gao@intel.com>
 <20260520133909.409394-4-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520133909.409394-4-chao.gao@intel.com>

On Wed, May 20, 2026 at 06:38:06AM -0700, Chao Gao wrote:
> The kernel uses several global flags to guard one-time TDX initialization
> flows and prevent them from being repeated.
> 
> When the TDX module is updated, all of those states must be reset so that
> the module can be initialized again. Today those states are kept as
> separate global variables, which makes the reset path awkward and easy to
> miss when a new state is added.
> 
> Group the states into a single structure so they can be reset together, for
> example with memset(), and so a newly added state won't be missed.
> 
> Drop the __ro_after_init annotation from tdx_module_initialized because
> the other two states do not have it. And with TDX module update support,
> all the states need to be writable at runtime.

You still can use __read_mostly.

> Signed-off-by: Chao Gao <chao.gao@intel.com>

Reviewed-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
