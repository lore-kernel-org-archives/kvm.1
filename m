Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798446D2C1
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927756; cv=none; b=JEeeIuJA1w263bjcYXAqAdkC7S1SBuUCKUn6b9F/ihhlAS0Z/IpfBKHcErHB/7oCm5zGHm7uqXCSlKotetXOpyTD4CFEvG211zWGwht7AZGrAQ2Fuv8SAXTSz63VwKEjdRFYmZK8/VLZ9+mPDZYwZEQU4AFWVDuf2OHh4BWdUCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927756; c=relaxed/simple;
	bh=b7h8dV9oHVBHfBv6mxuKsP2hyM8HHn6hEleZHSArLSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1uzYiE9M6O+JH6QN0GKICpDdLKFaYbarChSFn74pqxWJHtv37TEnCZVvvSgHXT8F9U5gY6qVKGX9trUvBCsi897txta15dbU1ChVI+8AdxEIo2K1gFCUpye8QYCJhpUZovzUUiul8KCD5UK0ucaRAorpHmYJlSC3EOWxlN48Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZEI70Zy0; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZEI70Zy0"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92ea24a2dbfso91514085a.0
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787927753; x=1788532553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1CA/dtHk3Ua/1jrmqIIittu4ca0gllo+cVF1m+itAJ8=;
        b=ZEI70Zy0NCJ/LiP0AZ0r2+ufjAQd+lLxfKiHzKDM+xus8JocIA//e03nMeUKzjTugM
         TUskxZAJ9UEX4fHnTj5mCibciaU+c2YusSc913jcsSc/rLJsTZtKvVE3vk01kHRVmQCH
         F9F0/WaGQDFJ3KejtrIhtjfeEd020No3x+ID1DKDuy8kJKIyVk/fLLXSc/+Eohle84b1
         5Z8vy5dN5EA6bJjU2piSdwFyQlBXgeYJim2hfa18HUYQbKZLDbTMpWL2rPcRfzCro1xN
         ojhVWr0zAgHjczfat0a1O1bjZCCpxQzSPZsPHYYI/9gpYzMgPZdU8gXNRZPx9Jwa5s+G
         t4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787927753; x=1788532553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1CA/dtHk3Ua/1jrmqIIittu4ca0gllo+cVF1m+itAJ8=;
        b=hVAlNyFL6qIFSBvLZYPJ7qF587YGBxQODyV3K1Vs5olBeu3pwPUoouAZR8UM2UiFQi
         SnqsVECEa7vuJNiGG+kTl5inAib1OWCIfcuANeCEnthdBgWB7jTHRrTj4HOkD8MJGjJo
         RYYQVnNvTj9n0kBued51ZAujJbBpth4tFQU7P7n7MIJDKypcxDYrxOgzm6rUgIvwylwO
         ycWHV0k4fF7PXnTWOR51wHSYUSUHPUVHDE/UnV9pbnKBx3R/rOsv5ZJs+G+uHxkBnfnF
         B9XBzkRZZJsjXm7B2jIojYLceNQYnCXw6WfF+yq7/tRKKyf++aiWC8JNVB8MfG1TG4c6
         NgQQ==
X-Forwarded-Encrypted: i=1; AHgh+RoajWEHZg7+Tzg7V6yb9U/Oo6Y82gdHNWtzinpMYyEX5/44E8yR77YiMKfnR6Hbe32ya2k=@vger.kernel.org
X-Gm-Message-State: AFuF++mFyhhxLFxaG0cZEA1/N+5lW6CupIBGJjqPtnMMf1ZkTpx86R+A
	gD0wRMuunvAiGEaB+dqQ2pY0Xt8PcAHzRVB3cZllNgT0+zoOvbjTsmkjb7iy2B4ZOpw=
X-Gm-Gg: AR+sD11kXZHk0b9tORgOZ1+TvdyI3e1tnk0t+a4Mj6WMze/EYra+uOJB8so5wRLAwgU
	YItzBbNQFmVwweTKSzEZQHTEIyk6fEsBo4MlzwqSnxa6I8p9aIiEEE0e3Duu34suWu3WyOGbBi8
	VrbFxEGsZPjrg1k/Lu/BKIzUqDb4A5yKtZUIcY9x8psGsWxAZS+UoD6YvFisWanvgB0UcTM1fzT
	ya347jjqDd7h9I48cfxBmDdUW1bMYr3CnPjt0Npivd+HIpiV+yV7wbNfALKooUwJit4Qwcut1Db
	Mfox+grki3etOBQAS/oW10T3K7zF0pnebQzaYFepAVkzQbzIj8VKHvXXXbmMGpcB4iB+pCXofri
	hCJK7e15XmClZFGwe2FhE9HUvryQYOmsBieay8+jLXXXqNBMKvgRIOpCloa0a4Evn55gPChqvn4
	JvOiE4X4dOocmQomm64Va/nrobR3JXPbz8uAyuaaMbUpjICt7AIvoaR7qzHUPjtW/q4M2SoG0uQ
	cdZNIEoCTVdwLCFqyU8WKddLdEsC1S1FFBj3ums4oHuww==
X-Received: by 2002:a05:620a:a0a:b0:92e:6637:da8 with SMTP id af79cd13be357-939138ffc3dmr615678585a.28.1787927748313;
        Fri, 28 Aug 2026 07:35:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm157064785a.10.2026.08.28.07.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 07:35:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wzxgI-0000000HRQV-3Jl4;
	Fri, 28 Aug 2026 11:35:46 -0300
Date: Fri, 28 Aug 2026 11:35:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 12/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <20260828143546.GC3769797@ziepe.ca>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-13-skhawaja@google.com>
 <5b920299-260b-4025-ac4f-e8f83beebf95@linux.intel.com>
 <apBso6So7UqwR3AX@google.com>
 <bb7052d7-51fa-42e0-9eb5-ba4743956688@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb7052d7-51fa-42e0-9eb5-ba4743956688@linux.intel.com>

On Fri, Aug 28, 2026 at 09:55:18AM +0800, Baolu Lu wrote:
> That looks reasonable to me. I have no concerns about keeping ATS
> enabled on preserved devices across kexec reboot, as long as the
> software state is synchronized in the new kernel.

The new kernel should issue an ATC flush when it changes away from the
inherented domain.

> By the way, is disabling ATS an option? 

No, many devices require ATS.

It is not that ATS and PRI are coupled, there are good reasons to do
ATS to pinned memory too.

PRI is a PITA, I continue to think PRI through the iommu was a
mistake. Devices that have device-specific PRI handling are fine
because that all lives in the VM. Devices relying on SMMU PRI
forwarding must also somehow not loose any PRI events across the kexec
and must ultimately inject all of them into the VM.

> The current design already requires disabling PCI/PRI during kexec,
> right? 

That is also not OK, but there certainly is a useful universe of VMs
that might pretend to use PRI but actually only use device specific
fault delivery.

So ignoring PRI for the moment is possibly OK. Someone using this
should understand what VM shapes thay are making and if that
limitation is OK.

Jason
