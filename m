Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533494;
	b=kLLFtcaQwLgF6hTKCxKkI0Aj1ZG7frqIwHGMl4D+j60VIZ70w2dC2mHCZ7CcctVzIlpV
	 Kk5p/66yqFmiOE6dnx2w3lna9MgOjmw3dkUgUk8ATD3uiKZccunzNb+OH6M2MafJiqCR7
	 +O/JkXYajZ0C/tOj85DPZM6Q9jo1ejb7OR+NW8iVQKHEYFivGWxBuiYM7F7k378RPIo1w
	 JHcqtrzWGdVhkrixGd5+JYyNJKIY9qCISgQOug3+Vrdw6BuljjmRNXF2SAzoML12hNHXo
	 o5pLHt0ky9JgfvKSIIGq4LWmjYT3OmWr7Rq7ZEsC1W5ytGOhCcTPf6yWY+nrQSyThqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rycHbTOJK2it38YspaXZxnOqkvIv8pjnp4MzdUIJoBg=;
	b=wuanZjjOe3Iyka7nxqhWlTk9JtNty1gurWzrKGeAvmSFhat/Dv1wCDQeaUOxQbUSty+J
	 FGv8athf4fI131qm3IjNVG1REb+EoWilx4MeY3yzawfFkPjICezNj6PTim51oUgFwR3F9
	 lv8uxBAGgYRro5Ho9mMF7TA5cFL5irNMINKPj/oY5NCAidYA4rsc5ocVrUNE88lDqMySC
	 EZJ6sXplWtZD4asJ88ciywXAwZCAm/LoH/10SaJFvgIL6/gwOrpH0otbptW7BbGsGtign
	 h6L+V/Dfnw7NeeeM3/ltzSD5v1fT2E51FQbFv9lMZqYrhChd2L8YlV5/FwaNhqaAjtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IcY3TtCu;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EB2606A331
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 01:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67EB2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IcY3TtCu
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9f6a16afcso22475ad.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 17:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794533493; x=1795138293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rycHbTOJK2it38YspaXZxnOqkvIv8pjnp4MzdUIJoBg=;
        b=IcY3TtCu5761QwGkzP5go5rX/wc//VSmZY9B9cJPZbfI9qEKb3nueho3bx5em7ukkU
         eg5rek7shDDtGkOEgibVHzkEyb7K64GyNCEVSv0VVRGesdu/+jguq2ocvMjUvWzfLSZe
         aVSzEcbmhs2Gr1C1mI5NzTFA1TQIWVNt0YrLeKpQ7t33DRLaIWeSkl8N5eMNIAAjKnCH
         SkyUj3DJYWOHF1dKiFm6WNUbiYyUyVk8/4MDrHEBorwtCUmypMzBEcxW0pnAwl/Hz3Ul
         LaY6i1sWRM/vGKd4iKlJDtUE5RvVpV+Q/39flJXF0iTgK8oDk3ygKu5lQqjJHvd/bTdX
         DYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794533493; x=1795138293;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rycHbTOJK2it38YspaXZxnOqkvIv8pjnp4MzdUIJoBg=;
        b=R32sg3LZag14GJ81NR8IteNT7iRBzRfLaYsJWdpROrc9UTG7JRXjcn6/VfPsIGziXU
         RZdUlbBK3S4UUrc6ai9/YXldrOlvbYsX4nTYain7YHgZM1jEZpMbYTgEZRkc9efIutws
         /Ylylg/AY39xvJeBv/LfuIKqPiYqovDNGvwlCY7RQXjMs5SKIJ1CsQgihqRkVi+u33Xb
         Cnl6Ztgrz5jXlx5GJmVUgVO/H4SMjPEfZzodBghI1mU/LYj83Zi388bG3Gx+qvgz7wLH
         1eUJi+bFC2qpXLJwIbN9QUEv/xxlkdNMaUhNL34Hbz3TQHXq+AXseKWy+aMAqjFg9ZC+
         u9EA==
X-Forwarded-Encrypted: i=1; AL+hErEG9FGoRq/jcbT3lOMVmjjdodt+J68AYTmiBtpCpnLr5SXeUqaH49DSBxg2Lq89MMuYCJw=@vger.kernel.org
X-Gm-Message-State: APuU4Z939O5tJPqNyaI/L/045no+P8y/4W2am1dKl5ghbOdjaHF0dv2x
	nNx/kAiU6YEhF8+rr8duoOVc5csXZ+3ocNNd68sZ1NUsn7zygji53C+qZzBvaVa2XA==
X-Gm-Gg: AYBFou3auwODU7EPFYbDkIn6af9mcnPMhocvZ4Jko2gMtlkpL1lf4sudWRdB6jSt0sY
	1DCPrBctxleYZ0ZTwqkpQIaHjX2cRbDu0gffpzXjkBlQ9h6/WiohNEGfTT0laf8AkFgLPfIeAKK
	6DYAaWUE4Omn7lWAjmEAoBduKPxbk/2sZwLncKRrG15RgVLwBzDDKn+ID5D+HaLl4ta7RXGQmAX
	tPrmcCDIOnrG3lCihbv1eRkkuxq1g0MpFQPkZl72N6KmYXmaLLCEy62+v9Z/Bvaw8dl7sG1RZzH
	NCjSA+0IkSf2H6plZqIrul65rft2v9+tqiSjpVQtH4CWsb06No7dCoKZoBcZGoEh45MS60Gr1/N
	tosWQAOCtFTm29luzH8htWxDcrXLEg/e+GLWcSSpGe1Un0vbJ8aRpZIRBAzzV+5A53zIWFQXE99
	EDwzSCge3TxqBqRfehnQd895KbXZIZLGw/aSIJg2Zqk8a3HBbIoBx/FQ6vb1mERcwWdFuXauXoZ
	c+h/YSW+i8Xgff1o3skZhwgeteP712mSYte8dLotT7o9WDLOoJ8DsgX9iVPZFEXD/6DNP7Xxfra
	RTyUyjJYYAl/446cb0V6irvOi/dIqMCuE57Qzwgd5h8VkUTNnBvVBZyr73jzOMnABdZpoivzL/c
	gVwRQKQ+1z5MYGnEkjS6e8w==
X-Received: by 2002:a17:902:f607:b0:2e9:7ba2:a8bb with SMTP id d9443c01a7336-2ee0f274d9fmr3031435ad.3.1794533492904;
        Thu, 12 Nov 2026 17:31:32 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2b190cfsm291532b3a.51.2026.11.12.17.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:31:31 -0800 (PST)
Date: Fri, 13 Nov 2026 01:31:29 +0000
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
Subject: Re: [PATCH v7 02/18] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <avZoWubpbulF3UUa@google.com>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-3-skhawaja@google.com>
 <wirs4vcszlt6wkw2wfauhjnxve4n5ivnnpkg35fqid34htepet@fn4opgt3lt2x>
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
In-Reply-To: <wirs4vcszlt6wkw2wfauhjnxve4n5ivnnpkg35fqid34htepet@fn4opgt3lt2x>

On Thu, Nov 12, 2026 at 04:31:27PM +0000, Ankit Soni wrote:
>On Tue, Nov 10, 2026 at 04:08:08AM +0000, Samiullah Khawaja wrote:
>> IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
>> the proper preservation and restoration of ioptdesc add helper
>> functions.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
>Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
>

Thanks,
Sami
