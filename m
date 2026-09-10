Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8641345CBE
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047634; cv=none; b=ASlXlwEEam8ythgGLdiGcwtV+c8tGs7FbRSAwbsV59kvPYSlrOjwj/eCPJMfCcb8ARCoxLownaogSjufM38akbIdnK2xZJ3GqT9T43yz3kKDjuu2ikLFsE6cF5N+84F+4k1Put0SEtABoi1fYUxRJDMVXvusrPvxQDQXiM2J3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047634; c=relaxed/simple;
	bh=E0HFg0SzLDxP5QD6hp/YjRxGgume2isM05oS3oy4/Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8U1WoePifMQuGodX/kahOzpfUP6g7INqKvw2p8qemQqx9Q6W8t/pSgLPIM9PfleOyfIgPxvjNRvuDZhhYQbkkkY1IkYsoPSm8VilJ9GUq7oecs3Byz2AkJANCzeY2Xk2wnFEM5n4umXHnY//tiCQ/YaBGBSzYk1QKRs1i4Jf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CKQOPX94; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CKQOPX94"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e85499ffbso566016285a.0
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789047631; x=1789652431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aY0bZ/yqrjuFAG3J6+JEFIWAYMbJQEXce7G9l1M4Rcc=;
        b=CKQOPX94M69/LzUskxyfGliTFAlVsyLopvpt0sLwbo/Pn10hRe1e01BSeZ492LTU4g
         MR/X0W87+Q4KWTSh4DYQ9d4GfhBkEaF5XhmlN2odStk0UBNQHRiJ2ps7TXJRGK5LObBf
         USVNKpzq3unJritdP4Vv3T0g+5U8zi/eB+o8QW+XgPfYZ5RP1Xs23ip3q8ie/xJSv1qc
         RSjlHzvOYynSipCbvraD2YTlpjPe+OgjO7BIcD+yZaDwGiLhrRrT6wXxE5q5oV4e3ZZZ
         d8Uu1zaOHb07ey7RdWw4dvFR7R2jZYDa4+mMt6xoYnsscm4nugSESvns1/BvyKKSITcK
         5zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789047631; x=1789652431;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aY0bZ/yqrjuFAG3J6+JEFIWAYMbJQEXce7G9l1M4Rcc=;
        b=BuDsiwuZzleSiW6VDXTm5lmAqQtr0ChuqVVnMiFb/WC2L0Iryqz8DRF5GXj2QXCT45
         wUuQeoPKWX/dlbGCeLnHnCb6EJbIlDac+KNySA4Br2gJ3Xf/oVE/cRg6ycBiJjKcfHRe
         LOcpYYii6joPXTVBtgTRFd+EZDMq32vxHXhN/mRup062hYOiYdFiFW1vKQVOXAIlZq6I
         2E2p9+diBNk9OzVymrHMFl8QpTXpi6JXSGS+D0dbOPVn74xT7ajXCtkzjtIsfLF8dLVn
         s+kTSlce5dEET2wBNhy+9mQLOspruUe9wCBW4WNBPxcTZmz9wPVDhX6i/UT1pvoYaSkc
         Q3qQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1/d86Y23Qlla51CmbS5GxsPMI8JUMf8iSktdePCdKWkRevoYMC3pS4Svg+l39Zi0vxRQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lmN24xn2lRal7SmuRSq6U9fedZefh2BdPdq9glPSzoBSsjwOvP
	zRGGOntUWZN7FoHSNF571tuUP5A8C1vUtcGo5njM73baC0tdOI84KcgcrprN5Yj/jdU=
X-Gm-Gg: AYBFou2Av6OGw7ajlMDl6/WCHuPKWV9co+Ra0FxLJBnDJzK7lwyPByvGAf7IiZDtCi5
	GOD7v+nq0MqKVYDMdKzTvPk+MGDG+CoON7FxKWuWGixnvlriU13fXiEMVJtGK2Y+gBIwK6efB8Q
	YQTwZQ9zScRdOW+5NRiKqqBZ37fowrmrGqhgTVzihD9/Ua9ZSjQlTsYp0yTNDcw6U0nGaeDgjoD
	4fNcbbAGVIJlyHCTkOSJJhuqVQqhqWokANbAnT5AtzsUnl3eN7flNblXEUA1kkWWfII/UGrAlff
	yT13mNhn0HbdrWM9G6Jkpp1JqELvTiUveDFRoQpPVjtyqmlPG7rLinx3EoopVrYnqCNaeEQOXcm
	H7JEKRczYi6AYj8uIH5+hjZ73F17WcsDQo3eeMHk6IHNFSxP7epb63+/dg7XsXL3NSsWfmmGiXS
	VVD7MFbXi5fBzkoxfiBWi6nJ8PgF+4iL9V2bMt1qlXd675zWmU+6VBzUEDM0c13sUEgHsMPh5/x
	UYp8aKc29/Q1QieoHfoJ/8COcZixMr+8MygWNg/Ge9QjnMsfGqq+fHxFt5IOYV/og==
X-Received: by 2002:a05:620a:2a11:b0:939:a2fe:926e with SMTP id af79cd13be357-939a2fe971fmr3077102985a.17.1789047630473;
        Thu, 10 Sep 2026 06:40:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e190f8c3sm78468885a.17.2026.09.10.06.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:40:30 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:40:28 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	pbonzini@redhat.com, seanjc@google.com, akpm@linux-foundation.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH 0/5] KVM: guest_memfd: bind backing memory to a NUMA node
Message-ID: <aqKzIO3DD66Dhkdw@gourry-fedora-PF4VCD3F>
References: <20260902194657.79075-1-gourry@gourry.net>
 <9b67424d-70e5-442b-9ec7-22b1d3db12f4@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b67424d-70e5-442b-9ec7-22b1d3db12f4@kernel.org>

On Thu, Sep 10, 2026 at 01:30:04PM +0200, David Hildenbrand (Arm) wrote:
> On 9/2/26 21:46, Gregory Price wrote:
> > guest_memfd allocates its folios through a per-inode shared mempolicy.
> > 
> > Today that policy can only be set after the fact, with mbind() on a host
> > mmap of the fd. That requires the fd to be mappable, and it cannot reach
> > folios that are only ever guest-faulted. Neither holds for a
> > non-mappable (confidential) guest_memfd.
> 
> That looks like an investment into a mechanism we will soon consider legacy, so
> I am not convinced this is the right approach?
> 

Hm, I think i've missed recent work in this space / this context.
Any suggested reading here? Don't want to eat too much of your time.

~Gregory
