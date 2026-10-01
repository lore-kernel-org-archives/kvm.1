Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6AA484236
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860235; cv=none; b=DU56ur2l4z0g0gp5t2/TeMz2+I1nRkXfe+qMjNJsDyqa6mOq0c5XlT8xdlgZDz4/TSHyXLQ0pFVy86mHUwgRu8E7mTJlqCNDpAHjc9JIYptJfDckI9UV0I/iSz6g4jVZkATYNOITEUtWv1cNMhLZBRghNGRwOWqhUzcX39dWfHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860235; c=relaxed/simple;
	bh=LTZ6Km6/CpuoVK8bg9yT3WNGLHdPkHSXQmJ98kg34ZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0wWEbccSaX2AUTXvuF6jOpGC6zCxrpe7ORBhGPqfrcEJ2cv/RkGideWPVmYYTaEYVz2Olje3iavbrYPkNYw4gtETu9hnDwgYvtIIjSIJJ63uRLQoLxUDohoAVmi5ULaebWL67jxSDxtql7OiMCe3EE/iijKuZV563K7tMYNRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7g9fxCm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aqha37sN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7g9fxCm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aqha37sN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790860232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDJyio79knKj0re/byLa1b13NjMEeAfKBhItlxqNUIQ=;
	b=X7g9fxCmycN9dDwdR5nPCfb7lp+/QBFSFekcTr+XJv4bQDRja2hHMUdMUok6UAQP2TuhEr
	BcIOKSaHyGGgW+sj8r1E25iIOVNNo1ab3S0VWL0iwxXDEV4tWAIuFJfvfesnsxNyHifJJc
	enzs25RlCsuLQd9bWNwxj6tfWjc05PU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-jdrxbbijMVmn5NPw3gy-lQ-1; Thu, 01 Oct 2026 09:10:31 -0400
X-MC-Unique: jdrxbbijMVmn5NPw3gy-lQ-1
X-Mimecast-MFC-AGG-ID: jdrxbbijMVmn5NPw3gy-lQ_1790860230
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so6525888a91.2
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790860230; x=1791465030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DDJyio79knKj0re/byLa1b13NjMEeAfKBhItlxqNUIQ=;
        b=Aqha37sN4PbC5p7Iz9TsLifZyCQftB2D6coxW+gVKUUnKELCi9kYCQYVCPeEgz7iZg
         CD03W9lhHC8ACTKYVfPIawaA9ZxmYyb/mUORa7YtKQl8l6tdUeuLblfuNUiy/gXCUa+f
         EGPqO5kZ9+V6NTa3P+or3p1UelRqoMfYFOIgr8eB3N52Q9oq46J8hc1P/AEgsU7XxzQu
         9iGzEauBv1o6ivumxNQZ18oFUiTqHXInN8u4BpyLtCXzXcNG+pVHx45ixThFfWJUZXUy
         UojhIZxPFPR3PYPy/89d6jYOsWFMLHn3ekRdWMforw2prK4GN0kHUtbcei3dO0YVpAqa
         vOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790860230; x=1791465030;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DDJyio79knKj0re/byLa1b13NjMEeAfKBhItlxqNUIQ=;
        b=lNJ9hP6OI5raLjCyTEISLUBLYDtA5QReoNMrNhahHosgG5Tfc6QlZq1Uv7NwkWJOx6
         pCHYjr9N1iWcrtEvBPm384leK7RK6NFLbVD+HWmQxv/q8hcV7cf1xpicNUZsOQzApeWr
         9I84YrnbAfhnBinnrZu3c6P0EiMEI8balcnjkFonmrc2U6dmfOq0oYARMRF/7X7KBc6k
         DSPkUiA7np7tEVUlqiBFoKvLbTvHnsBFmIr11KgjkXvZbHtM3dzlYIZ9DVmqrpOEl2kU
         m7N9HkKuGyigJAgxit46A320gL+4fergpqcTq6yef6uv/vk+oB+JB1Bez+nlvIYj9yQl
         JpUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOw7b/6fsP2UU/10TzBIZdp8B1uYtiGmbe9D/lLm1doIEWeFshv8HAqLAbuwm84tSP8IA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTKnxc7jp70AN1kaypiu+PobV/udw+sZoZx13Yc4YTZ0PhC1FE
	RyjKRQoMU5aZtkXDYe0wbPj9XV+5FaFOsFYrkmo6vNyBGAz6udJWwsdGMjMBKCXBf+v5m68YQgk
	y34RUQ7vHvbmdS4PnORfam/5SaL1KQP98NjNWXVIfS9cpnEtyOg6T8A==
X-Gm-Gg: AYBFou2E1ToFdpsuXA11x4vh1rNr2EmrmEJG+jLgBCaIG379wOkMp7jPpCRcql3J8F5
	UfRR5mbS9GbDaSGHUqbbhxUOaJ+iN823SGos0Ly4IXvAyQe55xZWjwTePQ37lZp5k7dDXf9+cpm
	YuxErNcj/jj9pJ/q7US/MwFC+a1NuDuUSSfKjYyabufB0QT4iA8MCPKf29zYKosuq8vcnGBl/0z
	0hdTGC26Gcj5+3xSff9Wn2BUISqpVG0xdCWp/n5aDrsQsU5MrCv+3aDAMjtktsuKWr38LUEKsIK
	llQy7pvmnnoSKI/qsJpi2s2LIzy1ch0XX4vIrjXtqxmFJAE6zBtxugm+NnWkry9/V9Bb4APN5he
	bfRoelLmGVHKPkJGeRGgjXxITsxCAPJh+VGa8ZGGb0Q==
X-Received: by 2002:a17:90b:4d09:b0:39e:6c69:f472 with SMTP id 98e67ed59e1d1-3a4d18c0f59mr4364880a91.49.1790860229916;
        Thu, 01 Oct 2026 06:10:29 -0700 (PDT)
X-Received: by 2002:a17:90b:4d09:b0:39e:6c69:f472 with SMTP id 98e67ed59e1d1-3a4d18c0f59mr4364841a91.49.1790860229444;
        Thu, 01 Oct 2026 06:10:29 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f6fb6438sm1829850a91.0.2026.10.01.06.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 06:10:27 -0700 (PDT)
Message-ID: <79509ef8-6b7b-4499-b2bf-f400b1c197bf@redhat.com>
Date: Thu, 1 Oct 2026 23:10:19 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 9/9] firmware: arm_rmm: hotplug: Skip memory added to
 ZONE_MOVABLE
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
 sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com,
 David Hildenbrand <david@kernel.org>
References: <20261001084555.1456543-1-suzuki.poulose@arm.com>
 <20261001084555.1456543-10-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261001084555.1456543-10-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/26 6:45 PM, Suzuki K Poulose wrote:
> If the hotadded memory is in ZONE_MOVABLE, we could allow that to proceed
> without the RMM having fine grained tracking, as we won't allocate pages
> from there for guest-memfd or kernel allocation
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v20:
>   - Use is_zone_movable_page() and only check the start_pfn
> ---
>   drivers/firmware/arm_rmm/rmi.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

