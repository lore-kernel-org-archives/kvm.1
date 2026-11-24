Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542044;
	b=FiPhJTmOYkr7In6S5PB+Ty8YNySTa5i8rtvbY9mA3/JXvx1Ku5fv9XsiHVQ3SGU5JXT9
	 D6vS5V2Xi5Y+WdBsCnsqBQJ5t+DqzhgxcwygMql1qWGzUH0zJSlxcO1jW+FwivDbofaNo
	 1i+jbWdI1UV3usY6EBIQaficroYpogFJ1KPapyzFPbF9OifpDVdnIrm+9MXPUW3DbXU+I
	 qVn6uSher7gDex3jS4FPsvEi6CIA/fDQEX8veeGdKt9W9bFLkyW2iH79CWNE+BkJdqseJ
	 W6XXCT62rwd4vnCLvAD5sMdmW36aN0m9ydH3kNVrKKRkOFRURRyd5GaNSXnPnP/SdfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=A0tfxpWQZksA+4DUx2Ik9FwTneKF6Ex273j07+ppekk=;
	b=TwvYXDza6eLfmebXEAmFNtv7E5dwog/KsWszNrCNguNnUfuApjxNFUThG5litkTIAmEO
	 3FkWrRmtyB+qknBiR+7U19BjaBecH5q02llhVtDKIJD+fXMWNQyukdRtoYV+Vv9ZAX2MB
	 PBrmVlBtKGb1c+PHrmFET8ytd9Jbf6k+sGN2FGwomNHNUIWIF0J67mIf6ggut56z/Q4Dc
	 cF7BNYC9bySjbw9yCHB52WaL5mKGhbMeEVNn0DsA9TCvrZTjDjDJeZkIOrsYVwcf8LK0F
	 JX57fIvdiKnWBnwkKHdSIqI2o4wE/E31F08bMkOJhqIxPLOAZhF7TaRUnT8zj1GTZJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ibfncsFs;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5B606A321
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 17:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCC5B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ibfncsFs
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f048bc09d7so212685ad.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795542043; x=1796146843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A0tfxpWQZksA+4DUx2Ik9FwTneKF6Ex273j07+ppekk=;
        b=ibfncsFsjl1Kz3hR43C3tu9vI7/bGZJ4y47qDoBAzmeCjj7Q2eB5yQnqXcdYAB/A6S
         9MQUQESFogPtukQykuwQ4MWoiZnW/gGvxdV31AOPHeJF6Li2p1i1BYmoWJ3/tbJxTr7k
         asclk4tB6yMBGKTDK5l0s2rVK6eSEQxitDpFq0jeRJHB9Uyu6IvDUZBxdImblVfcomeO
         aSFzlG4OOn6fo+7hwyzWT9Mjcs6/dZzUla3Rl1zIrrZF5BF5YHwlMne5VcxPAZdYbdG1
         GNphGUw/Le1AN2DBtd8pbLFWdT3P2aANprxyEUwHDdk6inM7u4WtaVh/bNmRKFKcgBK6
         nLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542043; x=1796146843;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A0tfxpWQZksA+4DUx2Ik9FwTneKF6Ex273j07+ppekk=;
        b=KYCZ2OEsVYvQs36bMeD2sUoSlnv1GM1ZBlVFbUjw4dLf9Zxqkl71ol3jOxlCczPHT0
         fKCF/kvDRIN2CAt7HvD7mMfVM6gkjVIPF6UDV1l3wITxnpHxowd2Avlw3DD5UcVBKkrV
         UTEbHs5BEOqdzde0PPUMeTAv88cmm5qaI1gEUpAkZ2CGxqU4KOqjE0uhjJTZAdJtgZXq
         tjIioDRFwOiqo5nX0MeMUHl8k07DP+TVrdUtwSppD7zWrelifpLFOrCXIjrjyuBh1Qoz
         piloJVnUxnpFgHMsS6izQCjTTaCl01Z80zgv81TvsPJKTMqvMwYFg/MceGqJ1OZldC/o
         qeBA==
X-Forwarded-Encrypted: i=1; AL+hErGgvduIrY4fTz8kKpecbnETvd5HP9NukPksdCLIAsiFbvTkcVAVYTJd2NdPhf5dErXnAKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hD3zsGaMIXrlcz2IAF6AZ6gJK7jWr4gmuwTesWO9W/bxI1gLB
	A+OZ5R0tJkVJSxgEOAiSHO7uTB/WLNYioseOn0y8HsHRoEWPjsljZmgEeCD8TPznEg==
X-Gm-Gg: AZFdTZda8kXw8PKbvlnjtd1PnbyMVGhsMAVvCRU1vmQtgI6vS2SbCYnt5sR+hxtd5xp
	JZilVMY5gvY6XvjMwE9njoFGuFDQolU1Jrn+nlRaJxLnofLT97fEB5h9pq4ziSZLTvtR8n8XJCM
	rAObZzWuWXn18xogHGeYPpryGyurISW80jT05gOTeWCWdNMFo309fZwEYgh7rtB6QSyIqJ9QIyw
	OAw5G5ZzjcMEVTj754B4HmAUu+sJQ21HXeJ8NFd3grO/+A78agw1REP7lH7myW3QIWH7/H62leN
	+YFS3QgQNepmKTZGbOGK7XygR8x30cz8kuhwss0XY9QhBA2xxUDPle6AzkgUL9gqh1Vuaiin8JY
	7HZU2EPXTfPlEN0Zb2heAA564xZ30t/wp+T/hxzf+1D75m9MjgJSfRZhqlf8ZJ8pwz+BNXrpFhG
	33uhbpUsDjPH8k7Fn5zqFeYCQ6rmf6pNAJzPaiw3gDOG8VJLbIjunHkqkFuQVFMhteLPTaSYGTK
	1W7yPeT48Tpa2vlgiHVmqoc1uZwWbysKA+9BJ5TswqDe9ZIVpnf6RTTdZc0Dg7ud1ief1pkIQ5i
	jwkyoBilq6d2GYPVpfKSpaEUytDkW4NAWtaJoqdniFfONiAGVFYu7Ad5UbS6cRoUubkKHWqvcYb
	dR6EaeMUSaifMuMNO1JrVe4Jb+p3udgg2bFKCefh9rd0=
X-Received: by 2002:a17:902:da4f:b0:2e5:9bdf:6b65 with SMTP id d9443c01a7336-2f0bce40277mr4837775ad.0.1795542042658;
        Tue, 24 Nov 2026 09:40:42 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc6130sm7514061a12.7.2026.11.24.09.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:40:41 -0800 (PST)
Date: Tue, 24 Nov 2026 17:40:38 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	John Starks <dev@jstarks.net>
Subject: Re: [PATCH v8 06/18] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <awXMB5GaBlcv845A@google.com>
References: <20261123044949.3610702-1-skhawaja@google.com>
 <20261123044949.3610702-7-skhawaja@google.com>
 <i7i7msbox2idxet5xfzkf5zg2hoznnjpaivbpsjrpeoko445ys@trkpzp6zceqz>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <i7i7msbox2idxet5xfzkf5zg2hoznnjpaivbpsjrpeoko445ys@trkpzp6zceqz>

On Tue, Nov 24, 2026 at 04:29:25AM +0000, Ankit Soni wrote:
>On Mon, Nov 23, 2026 at 04:49:37AM +0000, Samiullah Khawaja wrote:
>> Add IOMMU ops to preserve/unpreserve the device state handled by the
>> IOMMU driver. This is IOMMU specific state of the device that needs to
>> be preserved for liveupdate. These ops can be implemented by the IOMMU
>> drivers that support preservation of devices that have their IOMMU
>> domains preserved. During device preservation the state of the
>> associated IOMMU is also preserved as dependency.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
>Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

Thanks,
Sami
