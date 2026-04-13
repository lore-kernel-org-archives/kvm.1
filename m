Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924F339A8
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776122946; cv=none; b=pTN2nL1mAj6zK7nEqOs6Wu8RnjbcZUNYg/mtkoG61PgsWKbJFkNzYS9M7YWbpDJ0DvwETlTIsoOOWCuGyNh3imSFMMo2pOxz95/tCycABZOjgjNFP+JIUAiXn7RB+9syGWx/w1T0hPGJ4eJT3URf/JjbRI48o++/Bpn84lyeaLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776122946; c=relaxed/simple;
	bh=YWZAnDYf6y9BkmLDuysBkBolYs6f9pDJ3ZTZLEHRWpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnY/mFMzrBiyhqsaUkLKDR2Eb6xZwSYlt7IO4/x8QgV0FKM8kYc2tWsaFmj+O4pSNXICUmrTPHkperzgq95KIfP6kZ/UR7iZxwJxvbdp3C6D/mJqFnJ0xgVRZ53tnb6r6fqa1krgT/71rlpgQAGFKyh7j3PiaGe4jUV820uoDrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SEGie2VU; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SEGie2VU"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1270f10a774so39779c88.1
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 16:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776122944; x=1776727744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YWZAnDYf6y9BkmLDuysBkBolYs6f9pDJ3ZTZLEHRWpA=;
        b=SEGie2VUKI1KUnlXjfJUT8nz3JXn6nD82oVOidiFLaffx4jypT/6hNAIw8k/LSOyQF
         ZOdmTLljCQFyWesvFaqi2V2IuDuG8NNdSjaK3zV1Od2hVnHjgXZB1fHiGwLd55LyBSHL
         rZ2Ce3VTOKygRB8oP1sFvitxAptdAZqtoXrrkUvjOV25XEkYdL3E0OWQc8wqKTYNQJs3
         1kOJC68UZj+xKeWL0Wrr7jZungRTbbdjvBQkDPIj6/h2Tjpg5CqnHC7D5OVVq02wefF7
         S98lkOrnvg4FRgHQwfMPlpPyo97/G/eoJHq6X/0FeDhkENwJYx6rcUB0iGw8SJCPIVA7
         V/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776122944; x=1776727744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWZAnDYf6y9BkmLDuysBkBolYs6f9pDJ3ZTZLEHRWpA=;
        b=HQEI2mzHATMeifgyFQq5uRzQvDpL8xn7qpZLway5sAOp/2z3tr5W6XN98TS6544cJH
         Wz0cTgouLog5rSDVkVvH/IPps7lWzb3rcRw6ty8URN08vWBVPujNpEvXizMCzX0vKWRt
         5nwcCzSdjm0Qf8J3lzJ5SlqQIszLzSOxeN655GLg+lq9MJEw8GxV5EUP/TQBuiANgHIX
         oYxxMLSZc7gbpAUTAfsb6cFDYB2P6y9jh0D0cp52TW5qjOSnoL9YXDS884EhfJvaBtOd
         7Fg4JkJvkA+9FqPIrFN7FI6iZn+7ldiguyC0loG3Yjsk2xv4WPj3sNhojg25+C+Zngfl
         udrA==
X-Forwarded-Encrypted: i=1; AFNElJ+iupfP0lJVz4zhk/ysA1wsZ04w3Cz1kk4QOe0BfvwYIbhUth8QUq2mzYLz4qBzZr8IHNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAQUHSZNa48yM7hHbR+WHAX9jGEmYNuoU6wlYYL/GiVuhZDot
	X8WBzmIowsq8xBlDhLGDRv0kfJ6YbpLzTp63FcF9Jkdcp5LAw8oqTxMAPI3DQjPksQ==
X-Gm-Gg: AeBDievfWGtzeFlDURI/91+zAXKJk/RRo7v75L45YN9KSmVNFNi/SDh2ubSlEsx9fkw
	YB752mZjitWNWd/wpCI7nc1WHriEBnCZMGN5jrS8a0dgJXMEn9/jUVl6UmeaglDpo4qo8dC/o+J
	q8fZ/At6Ey7nVHMG5yoBwD86Q9JV5QLpIntW3Qd9cTD1j5vU35HTWe6FDY+R4zKJbDvF5Yx/hYn
	ogE2/0ME0VBiODsy/pG+O3sBIcIT730KZyAZm/MRH9Wpp44VM5r2XGt5DECp+wgDUA5lM7sjFog
	pvwgeXanKAuUHFDWPp/jZzrGBx6xDO+MRYFkLSSTPJnbsBpwyGR+n3wnBJaJWSIqE1wz3twr9f7
	o8nNd5BClOXdGJbgQJEH7eeXzOfWFe9s9OWKRZhaDqYkoCZKPkX13e1j5gT6/kHrTjdeLTYky5N
	/eYV+keMZ34DUdDtjtmvmu1vTChYZZMxOpINd4IVfHvOaY6fIpUl4EnpkIa04Wu18fTIsIl4nkC
	i/pjPbzItA=
X-Received: by 2002:a05:7022:11f:b0:12b:ebc9:3da6 with SMTP id a92af1059eb24-12c29c1d268mr869915c88.7.1776122943207;
        Mon, 13 Apr 2026 16:29:03 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d851e5bb3csm10730610eec.1.2026.04.13.16.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:29:02 -0700 (PDT)
Date: Mon, 13 Apr 2026 23:28:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pranjal Shrivastava <praan@google.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <ad1z6YYIiO_jBX3P@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
 <ab3CtC0vN6J975V5@google.com>
 <20260410141652.GV2551565@ziepe.ca>
 <adl2QX6gra99bkOV@google.com>
 <20260410231650.GD3694781@ziepe.ca>
 <ad0b-5aRU172-Od8@google.com>
 <20260413223318.GR3694781@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260413223318.GR3694781@ziepe.ca>

On Mon, Apr 13, 2026 at 07:33:18PM -0300, Jason Gunthorpe wrote:
>On Mon, Apr 13, 2026 at 07:31:22PM +0000, Samiullah Khawaja wrote:
>> Yes, we use the collect walker during KHO restore of the preserved pages
>> and also during free. But if I understand correctly, the collect walker
>> behaviour changes based on some FEAT_ flags (like SIGN_EXTEND). So we
>> have to be careful if the previous kernel was using different FEAT flags
>> that affect the collect walker. To handle this, we can just preserve the
>> u32 features from struct pt_common and deduce everything using that.
>
>It is agressively not stable, and even new kernels might not support
>the features old ones were using, so this is a bit dicy.

Agreed.
>
>You probably need some, but I think I'd be very choosey about which
>some I preserve and which come from the new driver.
>
>> Thinking about it more, we do preserve the top_level, so that could
>> potentially be used to walk over the page tables of these free-only
>> domains if we just set up the pts->index and pts->end_index properly by
>> initializing the range based on the top_level. Are you thinking of a
>> similar approach to walk these free-only domains?
>
>Hmm, even the free walker requires computing the end_index, and that
>requires at least vasz. eg ARM will compute the number of items in the
>top level based on vasz to support concatenated pages.

Yes end_index setup using "derived vasz" is exactly what I was referring
to earlier. Basically KHO stores the order of the folio, so we can look
at the order of the top_table and that should give us an idea of vasz?
Even if actual vasz is less than the one drived from the order of the
page in next kernel, rest of the page should be filled with zeroes, so
iterating through it should be fine?

I think to keep the scope of this series limited and also to do it in
the proper way, I can save the vasz. That should give us everything to
free and restore in the next kernel without introducing too much
complexity and ABI right now. We can put in more functionality with
subsequent patch series to handle other usecases. WDYT?
>
>I don't think sign_extend is used in the free path though.

I think it is used in the pt_all_range() during free to calculate the
range to iterate over. Based on the sign_extend it decides the vasz and
that affect last_va and that affects end_index.
>
>So if that is the only purpose then yes you can probably get away with
>nothing, but you have to be very careful to contain the restored
>domain to only execute free and nothing else by removing the
>map/unmap/etc ops.
>
>And add some dedicated self tests (zero pt features and test free) to
>simulate it.
>
>Jason
