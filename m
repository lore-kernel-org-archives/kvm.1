Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234014;
	b=1pNRTgV/rpZfdmI0vi0WUW9c75pgZ31cTB/JkCj9jXkEHGcjuVL7YkzrKe0W+LYCMJPM
	 jgB4ZOnyKNml5VNzyKSc6xNtxMxeKf7ctXDW6gNygQfUIga1iQjNSB3jXHchCuYmFxxjM
	 AXSn/L+scj6CqzrdDR28dIfj/65enXnoP03kqcHZKhqEJBC0iqL/sAzjPGApeNIWX8OAq
	 TV1pM5KzYHk+euScN9JmTjNXMfNEMHCRQnRvRv4b+ix0qtgitHyc2tJwz91ukK7cS+8i+
	 kmuxXZSICyEE/NopUyzf9xM8FAlK0KpRRdXbEwJcRk0vW4vbyDOC52sK2RltzqoqS9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=O9QpSR8lg+vF2or6LsznjkiIHbPGjItpop+9ep+sVOA=;
	b=h7p1cYAGoxNlUwZ+248foewTkUtmJ3j5bK1cwthdMVpeNOKBD+leHXLrCJZI+j7j+4PJ
	 sUFobqD5YctMQJZZ2VwX4sokXfEHBXaofOeViZ4cyyRc28NQ2QGbdB0wo5GiCZMiFpPdC
	 N60z2KKWZd0/mqGWuWA4+2bjfE2Q1pNFuSezh1YMb5vDZw0lzY0bVVXos+nluyLfV53Ze
	 95gBYWzkV8cXGRomxUIuBPrRUeuQteECSN2beTP0NPMYtoBdBhfcOK1mAuhJKYvhDgHXh
	 CuBo4F3uaOe36nJm6J+JTAqoisqJh+M2ihlpKpf8WM9NLiAwHy4Q2bjVb0OqWzjMqjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="W7AkaGC/";
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE0606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 00:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27BE0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W7AkaGC/
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2eb0a52d605so30845ad.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 17:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793234013; x=1793838813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O9QpSR8lg+vF2or6LsznjkiIHbPGjItpop+9ep+sVOA=;
        b=W7AkaGC/h68qamBtwPNyN612w4zInsqvafQv60Te9lnAPgWhczM4kgJeTkRrmIzSZd
         kNuRcFOcEaVrAW0FAw2ALVtQxxoz5t7AN06P8BDEEAlJx+XFNkLFCOeEYTxeSUqMW+Ol
         DdtbiIJbB0T9ud9QwNXOS86w3jT3MemxvSGqdtBSbx8LX/twJ5QT7N+ExTR8eAaEMChd
         XBquv62uSr/zUNIeTfNcUmgKz+Z47ccBYjz7TtbvqpjFOjYTADUpzGYTVqhEpxOzTYWU
         qiaI3WG10Zvztork/UWAImpyFHhGEtnKF4M3byVkRTdHjfYK3XxBftKLIM3yZ53jtfXd
         ozgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793234013; x=1793838813;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O9QpSR8lg+vF2or6LsznjkiIHbPGjItpop+9ep+sVOA=;
        b=PjAcRSyGXxd8L5QfrMGpCBq9nNT8muEXZCp6upl60w3iqipMbYqUhG4+ouEORAybzq
         l4f6PSkwsEoXvn36sjXzzutBBjyTnLkhIGITdyH5iPpvWkM2+iKfpW0Jo7aRY/g3cpYn
         oENmJuhnTpPc8tmrkMy/6nfn5IGkm6Qzi90wS0PABPVjz6+hQgQIH7KiStC6ru4QGVxV
         AS9SwtX2gvmEmh7cWFMKNUzhHrbe6MSuQERVYuzqoZ67KyA8eDxgq7LRdNiSbYZciu6U
         hQ7stCkkY21dBlZLkeyz4O4IRRtBTFzcZzTpoks6HZgdc/MHMNKlfCCAe7l4cpmdMy9K
         b7Qg==
X-Forwarded-Encrypted: i=1; AKwUvByBp0o/3Qw9KW9rrsXk+GdlScSIur36Z1fl29L2Hal9reoPt2GyM0VSMKqeVXy43UOzIIc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7yZm3xF42JuWFmVztePQYyX3pPA+jh5nGg/GUGM6p6/2b9hRQ
	se4tJ5qP70+INks61osNBgNQQ7jw6BK3vhE0U7o+9EAxhSJOX8TIFUYWhKQFOsX6xg==
X-Gm-Gg: AYBFou3YP/8/53NYqMe8PrfENNyOB7GgpXRcVFi/TyIUs3UzpNIVKlIL0RR6cN1xqlT
	RkahSMYvep9XUroJnfGGybXMOE2wmMG18moWEl+4YcYcb2hVPcR5nnIYe1b7nGgohEx8beOYxtW
	2tJnG2RGh3dvcP6i6il9wpn1lTv23aDdzf5yc9gtQi+X50vjfy2QK7s0ppICXyGyS7+o3KCkP9J
	t/yA2TLAU5I77Hb1tMOoDxnhnseosRfdx+3ZzNME1NdnjAcvtJyafT1TpAN5qwvSrqfP+XJxP2Q
	UmLcMdU9MuSRd/+Co1o3+dI1Hh968AXs1GGFDppD3JLsgSldKsaJ7ibPW1vF1KeV0SyC79Ko895
	ivrTld5NBKhvKV/S5CJPgVm2+ydjoeMKYzQCgeoVXu/qPppFEX92yKjbRwV+YNdv6i7hHMRd8A5
	GJ8XtoFl4AtEg3isFxySvgsjIGhIUAmh1hMQ1mUcXpF3mK3C36tAuqDNf8rnzdO7KpJryEAkZuh
	AfrTsH91e/ZDLt37sszpk4GKWaZmTX4bd2aRJ/urNO6m+FknC8FeUp8vs1xDjANP869u1qAkuBy
	dM+Y/YTF/DJN/UvwH0dvZ3xc40fZOprX7aU+3i069EDFTYELjFBnL3QSNHe4X9UaVLxpkLvJQYg
	OoMA6mVIu2jvHht7YDBmAow==
X-Received: by 2002:a17:903:2301:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2eb1ec33fe0mr1312655ad.2.1793234012878;
        Wed, 28 Oct 2026 17:33:32 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5795d04asm2769044a91.2.2026.10.28.17.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:33:32 -0700 (PDT)
Date: Thu, 29 Oct 2026 00:33:28 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 09/18] iommu/vt-d: Combine disable_dmar_iommu() and
 free_dmar_iommu()
Message-ID: <auKULvZVjkrAmzIB@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-10-skhawaja@google.com>
 <9e0c1aee-5a4c-4e93-ab26-f7e59b268f2d@linux.intel.com>
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
In-Reply-To: <9e0c1aee-5a4c-4e93-ab26-f7e59b268f2d@linux.intel.com>

On Wed, Oct 28, 2026 at 02:01:08PM +0800, Baolu Lu wrote:
>On 10/25/26 10:19, Samiullah Khawaja wrote:
>>Every caller of disable_dmar_iommu() immediately follows it with a call
>>to free_dmar_iommu(). Combine the two helpers into release_dmar_iommu()
>>and simplify the teardown and error paths in init_dmars(),
>>intel_iommu_add(), and dmar_iommu_hotplug().
>>
>>Also drop the early return when
>>WARN_ON(!ida_is_empty(&iommu->domain_ida)) triggers so translation is
>>still disabled before freeing the IOMMU resources.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c | 30 ++++++++++--------------------
>>  1 file changed, 10 insertions(+), 20 deletions(-)
>>

[snip]

>>@@ -2310,12 +2302,10 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
>>  	if (iommu == NULL)
>>  		return -EINVAL;
>>-	if (insert) {
>>+	if (insert)
>>  		ret = intel_iommu_add(dmaru);
>>-	} else {
>>-		disable_dmar_iommu(iommu);
>>-		free_dmar_iommu(iommu);
>>-	}
>>+	else
>>+		release_dmar_iommu(iommu);
>>  	return ret;
>>  }
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
Sami
