Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542011;
	b=dV1sjPVxCRYHDnEEZqgLq0UOWHBrmxVYHzzTJA1vRooCpcNpY5d/sf697TBC/jHZbL5b
	 as0AkkByduzak7pwein1YVnCwtG1eGHSWyna5rp4WMEolsJLC0ZovvSQ5Sqco0cUGalmf
	 zf4ngHeO85uQwW1ZxJSilwbnBMrIH+o6SXWFE6omr0SJ4T5MWlgsdqR7fnTRPhGIeAzd4
	 +5S4Jh6gqwg5aXiNbbHciPPvj9CU0BvFYXr3WjLLvym8cK8RrDX3tpwmptjCHmNMreUI7
	 4aqZe2zPUc6kWkSUKdfm18YRZAc1TpiL35MSJdajitvciKVORBfGuibWf3lNndBNeYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=miqMkDmR7uPJ+RMX/Y388NkwoGQvWXSbN62ZuELGneA=;
	b=fa/jy/XF1CStSjlXagds1Fy75YALPCynggUHg3QmaEkx7Erbl+EKjlwdgA5V2NGdlwgV
	 uUIynHGdBW4RNmLUeRJ6g+6TULSWvm8ATphKcIAiop66I3oHJTI+ZLHyzinQW9B0nH9QK
	 z3I6xU6ZIpCzxINtX8dCBnhLZohDgT2r490lRYjDVZ1FzQ5BYceqRw7tfPQucnjQAhMcc
	 fWWDH/W7YB6j7yj4NnpDSDkcER/jCVPhvKwBQjTUYQXzWVTfjozv3fn1tdNylbmTnT+aF
	 EGbjujtuQcY46tUZ8FBLJ3Dx6cYBovgqlfPBNmBVMdOI5I7j+4bArUidZ1LRzSj1jmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i9agZFNs;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A45F606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 17:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A45F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i9agZFNs
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f0afdb97abso133485ad.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 09:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795542011; x=1796146811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=miqMkDmR7uPJ+RMX/Y388NkwoGQvWXSbN62ZuELGneA=;
        b=i9agZFNsK1q8o3kRmLMu51cr8aBzVAFBOQvV+Eb3VlhLkya/7n0b2TZhXe5L6cadXv
         fLVOh39CNTh2x5Z9gVxbScMubTagGqaHu6VhnhFc2tcbmfkqMD5ZOVeq8J5xHiFxnydQ
         AbE6fnBOJ2dUq7uybYleJnTuzAYM51XiVcTMDMiYrbWlQbX/h/J9kvIjxGT6Tss67ynT
         /H53Ti3mBA8QG0R7p0iefzcKxPLOuPQY/OtxddqjCUTyEDN1NZa9Ci9aHtgAapDgj8iH
         RMdcVVzBJw5vHVWZXl8pfRnnXCkDUGe8YHHpR7R7ZKHK7u4N+khZwzub+DZD8ZKeh/WY
         vHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542011; x=1796146811;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=miqMkDmR7uPJ+RMX/Y388NkwoGQvWXSbN62ZuELGneA=;
        b=yg5A58PfZxnN9cyto4e33hZxT8HEsQJWvyL/kZD4ew5R6m6txMCN/RvRUgthglLFBn
         MyrLffu7R8nCuv5XvjtcgjY8meSeRuACwd0R2pCkHCSI1HOanZldJaoDj/Bi1m6nyBCY
         SqZ+Tp8gVIKB0QuXtePHp+zOWPzt3yrpINEnUF1xb1NXTQRYcVhEK8jTPRc1GW1dwXEA
         3FgNynDfSpk8uCszXgMQHWVy2wBPyOFegFAqgD5be24aWFyYQFEwAt3JXz+gbbd8HYNj
         hTxOvomr8MjD7DcSXBzqrp/5iuHj9+4a4W7Nl4Py9KDksdVSopMPdaFeupYbMMUu9smY
         LyhQ==
X-Forwarded-Encrypted: i=1; AL+hErF9oMChdCLvti0lCTvTyLxXu47FFqWd+DBZaW/gTV+202Sdl2H8A9nw3uypvLfbwcbJZiU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NU25aKCKMwT6s0uMud0u9KhJ7LNaLyRqZiIAbmgCr0e9v7ewZ
	qS3gWxyMkMvydHd7vBv27ixO6e2KYJBnLeSVHXQHYce4iETHaZG3fv8ZyopqTq/b9A==
X-Gm-Gg: AZFdTZeI476glkqD5hz3RXvTxC3r2HKxCZ6snHH/NrcZZeCR4V97Qm59yRBqz8qO5ua
	nyXzRpceEPvv6mnZKIIMxuNeHrGk0RmrNCS1ct0xq0HuUG6QwJkVSPMm7WZV/NUVWrOaQl7uY9t
	xSiuOAUrUvVasUn4rXGxfNIDh+GLtecIljAyvr/lFDYh+EFmWPjsYwQehiPoXHCBS0kf2mLJdLA
	7To/8fB/WMAC+4QjuNVrCG7F3uXcpJ7VDzvuQrXKYQC5aAtRdkppYx5oYLpL0gvxjSF+8/mhcr9
	7VBlPYlzp4cJqc2vQRxhc1iHN0x1GzTfmFX6GMA9bcFTbqq6MgWFtHt6G90zq2Za4covE4EOv2h
	2FD4hCqOqAlV46S/pcYktVVIRnJsiD8sBzZYZBB0sKkW8y4A73DB3YGTUcvF9VxLZJPwmg3u1wY
	I/0i42rBcw4TwFP2Z443ObHBryJqYFGwqjz7SBieqe7pcidlfpcDAlmWEv2XieSw0vK1iog/A0S
	UAfnVcnIdDulVuuCUwFZSdC8mf1hXgsl4qZb5vq+XwO14y2UXXdciMnz82dkP/B8+7Lowzn9srj
	HupOAH7ukArdVw4G6AXTkGPX1YkNzvzmhdyEQ/Klp/iXMYBPmcaVPoJw9BbCWj0gqzBXP/1kqfX
	4WKXJf4a0MKEpTP1CUO2Gcw==
X-Received: by 2002:a17:903:19e3:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2f066708a17mr12958045ad.15.1795542010063;
        Tue, 24 Nov 2026 09:40:10 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f122548sm72700355ad.66.2026.11.24.09.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:40:09 -0800 (PST)
Date: Tue, 24 Nov 2026 17:40:05 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v8 05/18] iommu: Implement IOMMU domain preservation
Message-ID: <awXL2cLfpbowuO0m@google.com>
References: <20261123044949.3610702-1-skhawaja@google.com>
 <20261123044949.3610702-6-skhawaja@google.com>
 <ngjof224lsvn3aamehaaowcsk6lyrypjw7uidwwbxxpzot53t6@462wqwsp65bw>
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
In-Reply-To: <ngjof224lsvn3aamehaaowcsk6lyrypjw7uidwwbxxpzot53t6@462wqwsp65bw>

On Tue, Nov 24, 2026 at 05:23:18AM +0000, Ankit Soni wrote:
>On Mon, Nov 23, 2026 at 04:49:36AM +0000, Samiullah Khawaja wrote:
>> Add IOMMU domain preserve and unpreserve APIs that can be used to
>> preserve an IOMMU domain across liveupdate. These APIs use the iommupt
>> preserve and unpreserve ops of the domain to perform the respective live
>> update operations.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> Reviewed-by: Pranjal Shrivastava <praan@google.com>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>
>Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

Thanks,
Sami
