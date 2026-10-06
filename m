Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A8D2DB7B9
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 03:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791258599; cv=none; b=qiovLYiSWzVZPHiUrqbOIFBabFfqXndiZX+C+sulXuI+QAm9Ydxh55WEAavUSDockUg0hqwvyS3RF22rqFpJ1TKZyD6IvHQzVQd5IZ13mTwS6mdjEtjLdX+4qxAlAEsb7sw/TYorDbjc13Ke6PF22+ySTSgzuuo21Em5yha0BgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791258599; c=relaxed/simple;
	bh=9NW5It6o5eoUftkY9ls5gsc+2gvCsipwEhZuTUOLJ2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ta3ABnH/epnlCOuEWNPlyNYxfsMyavo3Gvxt6Dt8fOTfLCCbtpoEziKjyHoYg7ldl9i6kDxJS0AaCGNRsq/48xaH1WaQ043ojPn13f0yn2+SxNAXinr1ii2xpb1kIQpDD7ehSy0pKljByplwbGPaoP2zrYC4X2Wb3TQsnmHFKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhnNjAWL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7dUK5yh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhnNjAWL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7dUK5yh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791258595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ikmq0G2vWuzS8RQjLvE7O0ZgTT2QCtc6oU8WM5b+mQo=;
	b=XhnNjAWLVsgwxjJ7x2WM2t5njlqOGejaTBLuoCGNPVbnvPOxpNu86ufQXy6pRT5Wv3sUcf
	eQ4ykXxBNishJE47jijz2x/YFH5IvnxefEiiIg9ZBIkfQaneV8nL/skbfWhH9IGvVwsWyj
	xA8jtArtBJUuiT50kO+Azes1fgQObzg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-Pt6SZgT4OIylS6hrf-gXCA-1; Mon, 05 Oct 2026 23:49:54 -0400
X-MC-Unique: Pt6SZgT4OIylS6hrf-gXCA-1
X-Mimecast-MFC-AGG-ID: Pt6SZgT4OIylS6hrf-gXCA_1791258593
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a4aa263a4aso2382789a91.1
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 20:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791258593; x=1791863393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ikmq0G2vWuzS8RQjLvE7O0ZgTT2QCtc6oU8WM5b+mQo=;
        b=f7dUK5yhacwKsVqOojRTtDU9rJlde14D8YS1puw5ExeyN3/GBHqJFkTjsIqL37Fpvz
         N8xRzdLUFAAZaVGIRpu0L59bRT43E6sewFi2sDP2wJK32BAHkXn1MAMyPZaMa2umVtvl
         57IOZTxX7oBnfjwQ2ybZqHEXiQAcLugu1g4WV9X6rzPtc0KK7xhx6ODD6Hg3mE0jYy5z
         NCkF3JmfblFjcO4X106sR2waI84CO2DY+oqyH3WLE2xD27e7nbzZTbaDHomDWEmytj+P
         XcbbFGPIshlZB8YSpu+SNgRwvjnyyYpQrEdYUAKmEB8z70d876l8cUaDLY+1jcJMNDlx
         8M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791258593; x=1791863393;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ikmq0G2vWuzS8RQjLvE7O0ZgTT2QCtc6oU8WM5b+mQo=;
        b=PNXew1CqHqdnaARPtY1jyxFsgatyKFrsaHPXAj1spSwdHe3weZs4MoirxYQSLyQsIA
         WCz9Qx9ZhUt76I1weoPqyIdaSwjt73ohgEM7fUNTYeSkWfwU8LMgJE8p+iAdKQWjtETx
         vujtHApmIgsSznZSJQjw/33l4hlSHcdFxmyztl4/Fv5AQ7rYib5ut1CoT7tu4JYroCkL
         OlsoKO1TNbRymcO7oGmjaEcd/7GLW7/58B8QVZXfLMo8UeEiyFJJKw/9gi+gwt0kxx+K
         O+/7+/co0ZQMF8xPo8W8wkbi9ZqhF55HEt126pWgaU38c3dV7fumxharr/W3wb+xvP9L
         gwiw==
X-Forwarded-Encrypted: i=1; AKwUvBwBGR7QVSdHX2y3nf3F5RUz8xAANnskBaCkddlxRqd7KMzUcwe9cpkl8an50mVYX+WdaVM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzy3JTSuuwu0P8pn44L5NumlHm/o08Sf8rHtHC/bu0cKsfiqAZ
	TsBSur0KbGEK6JYE32lVNJjjOiwo/xWO7uXf+U9iNqkP8udhB1dPZ0OxCmzIQ2y71A7CS/AsYx7
	t66LbYaWqBJ1jdfqZE3NXjMZ8m2+MV69YjCs6WwMdDoc1/1dw5oe6iA==
X-Gm-Gg: AYBFou0eUPZK1QtuoyVtoxphd8YT/s9bLtfF4W3ThrLQIJExfgEw8VvLu7WI4ab7Cce
	Tsq0smesCoyYa8hwXnux4M1AVwudLCt9y1R/Dj2DUQyIcjBzlqyUarEk/ryWCrg6f2C1johB170
	nxOVyDFZXKcwFqNh0PAwwa3pPRYWWRmMaVRrQVXYCzydsPebk0QSTZYCjyrOgETVsuGPqAUhR1r
	q9CQWJCEmL8L97HCsqCcH+lzvQS0A80nm2aiW8Vttm9jfX15PXWwm6J2EpUYy+qAEG8PZDGuUwP
	QOwBEOosRHd/7FnKLwWdQsLa8/eOoRODzhBng5eMjWRQn+XEMi4sQq+fPLibT+66MdZsy7Jytr0
	JF7WzxucCZFpHlAvB/IpwMxFJGRiwrP0PiOOvavB8nQ==
X-Received: by 2002:a17:90b:2e45:b0:3a8:1745:6c01 with SMTP id 98e67ed59e1d1-3a873697b75mr93394a91.35.1791258593282;
        Mon, 05 Oct 2026 20:49:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2e45:b0:3a8:1745:6c01 with SMTP id 98e67ed59e1d1-3a873697b75mr93373a91.35.1791258592828;
        Mon, 05 Oct 2026 20:49:52 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853889667sm2507543a91.1.2026.10.05.20.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 20:49:52 -0700 (PDT)
Message-ID: <2e83d025-2edb-43bb-a9fe-cdc09ac2320a@redhat.com>
Date: Tue, 6 Oct 2026 13:49:42 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 20/23] KVM: arm64: CCA: WARN on injected undef
 exceptions
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
 sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com
References: <20261005090754.2140522-1-suzuki.poulose@arm.com>
 <20261005090754.2140522-21-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261005090754.2140522-21-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
> From: Steven Price <steven.price@arm.com>
> 
> The RMM doesn't allow injection of a undefined exception into a realm
> guest. Add a WARN to catch if this ever happens.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/kvm/inject_fault.c | 1 +
>   1 file changed, 1 insertion(+)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

