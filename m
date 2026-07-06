Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44012431491
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356208; cv=pass; b=aJGVi9fdLWVpTnGToAwyo7gyDF7uTAdWkiYT+2cPu6RPokHNq4l9zifIkP/LwzGOmI/1d6VkGP1muGNWYo2eh8KUTCSwIVKRRwWMnoT8Ncgsww9taTbxzTVli0IfRkrBQNMJUEHIgNIlurq3fTCVvDeEc1Y28512x6/Z78WRKGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356208; c=relaxed/simple;
	bh=vrg3e9cxUNDpns9Bl1a5bKc3re+8UaUiVeOIgrtnLTE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcSM0jgwMvSpX3+kKFpL4ZkCNkA1UImatyqVJaf7KkaFubuwYKpl67BH/bkUuVvarR+qhYv8OD31gKkr0aN0OqPAGe6VXx2q3XMPp9Zmj1WKAflIIncd8zWoZAXFsRbNMn6JeN8eKXBG7p3PMfA1u6a/O14kqmmoiPB0hsZURas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jQC+4RU1; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jQC+4RU1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so22204315ad.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 09:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783356206; cv=none;
        d=google.com; s=arc-20260327;
        b=WAbgGFSptaMQkEPla050HOnbtTLlIGrcoMrN7G+1rAZ8Aj4u6bCZgXJLWzt/ixib+L
         wYXfEJRllEdUwhnUM+aqYF1G3jsfkXlTPbG2XQErOZ5eLK07yyUDNDyumCtsgN/NSWh5
         hdqFu02/Z1Z0w5m1R5tOMWBuf/DEx38RFVfFHtNbFgIN7i6+ylINhpecDeztv/VGcYkN
         agupqXw68/Pc95ZnSQJkan71Smz8Su9+FLgnT1sczitWGM7Br4yAGWjre1CKRRBQNtQ9
         hjixEuD8s7RzYiqpu/BvcvCVEvoUueu8exHwT/bac9eawi+iCbi7Aa7ujz7x2EbEXNF/
         njHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=AUlAAYq1P3NlBc7es7tK425G79dZYYxCv/As82Uw0UE=;
        fh=DGvYYXxC+Oq+iueIpmjv4gycMNRvoOf9U8TbPTZltVs=;
        b=PIqBwdp0hGuOhm50OUThRI0nH0n4xIo9tcMEHvmZq23K8fDC5wmkgzGknH/GRckoZo
         hi+oyZnLV1nj3GR1cgrxtyZWx0TUAXezku4+Nu27Y48WZyYLj/v7axJSlprH2s7aVDBk
         Q2gmFblRuGPrE5V7RnsUtameFrghicroEWC1/wJa7xQvnjH8eETCT3PufWcLmP5fBeih
         D9sXxcPVtUqMJeGdTlnT6hQoELfrjaBJUyk/xMP6VjZB9GMhAqPPJn5tv8pjypO4ZjUa
         O66ruhDxY53rSMyz768QMHLt7tIF8i/+jj1e6OYSM4TabvyyxeCpJYDWt3mfOZZIFsnN
         NNlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783356206; x=1783961006; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUlAAYq1P3NlBc7es7tK425G79dZYYxCv/As82Uw0UE=;
        b=jQC+4RU1yN7Y0+IhSFWu5n2JDYLIu/9M8LiujCeOciI3x/Lag7kfylhKAFphQlTNKN
         3ujt57pHisXqmhdqjcpFloKy4BNGUTIxlruNRK7Fta8jJvNdHr5K9raKipfNP51J3UR7
         R8Hip/EmJJeN8pQvcnK8/nBI2nouBZHmFZjC9p8d+l4ULwFVcwE3h0cPdYMsu/Fowm38
         EaKnAInO/z7WiOJ9GWknSSMGy/Swfd397vcLvtmL9mRMK3WkeTZ7l4bcc8v6hv83r2x2
         n+PmxfbPnI+DioDHa5ueex2oTWvXI2JtdW3oydqEc2oR8B3P9xd5hbdp+7mkXFrHNUXb
         s4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783356206; x=1783961006;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AUlAAYq1P3NlBc7es7tK425G79dZYYxCv/As82Uw0UE=;
        b=m08lrF42pFySx8io524NhSzVdMwr6KcIlUN5XmlWEm4bwauPd3+8paIBVseKtrlJH2
         4ZLjVX2FQfEQNs9rL9s5cg1AADG6pyjexlRN/9K+SqFUnpy8IYR6p6BptsAy+JeQLq2P
         iW3yjL9+MN84KBqcv1gVd4iZjEE/xVER6KeoMx+03rGL1aVSGAZbRoTeBBPKIoicV6d/
         4PWukblfEy+EsxMegaGZKRzuuuzWUdZnmdH6mjSES4yDlLYlscsQwl00Z1HGnX1BlHAz
         vv02jsPDG1OogtzA9nZePhwbxfAEzc4fAZHvP2e08+HGK+bAquXZ62btPLH6nvElkIKF
         iAmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rql9tTeK0Hii+SPJOtKM/B4rMEpI5tQmnSjn+NyPMa0iB5Sz6ePG6MFwxVIcN0Uwjs9sR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJO3i7+x/JrHqJV6xzSHRkEyj3Q9DtkFpOUpc5H7l4y1YMqNsj
	vmtJ1YV1XRkAzdXmBB0VBH7bExN4EC5aLWB/ZRuewJe6cz3RiCvGbQj4zd2gPtgxOaWxtygO5q8
	UUyRtdycVS3gwpE62aEzBd1P13qEFIos38B5ieHdd
X-Gm-Gg: AfdE7cmDM8tyIx6pmNqkzpkCkjWzKLIMjoy2AWzaeEBOsQ5XwnVfzaURvAUFs+Z5BkW
	1cjQjxR0Y4/sBsQN/M7CtW0FaVbzYQFIkbdNZ3K14xYGSyaqMVgIHieJNzqMT8CcMgvyZVnWy4E
	wzfQJ8Qu2MMhRBZ+YfVhdV7fSAPwBkUp3wMhP8i5jjhsl2oOu8ukhRHlaxLv8tBrHzif59PXoj4
	HlZVd659NoxHSglruLxVG97Q6d/av8VOhF1wQ4mFRvua2Te390+GA6gwxFWuun8NuiugLmI1UpS
	biBhqd/aorQECer3/u4h0Au0eLhYzBZaiuAus/7YAGKRZwg2VIWLI7qRT0c=
X-Received: by 2002:a17:902:e5c8:b0:2c6:90ec:f601 with SMTP id
 d9443c01a7336-2ccbe50a8f8mr13298475ad.8.1783356205420; Mon, 06 Jul 2026
 09:43:25 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 09:43:24 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 09:43:24 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260513131757.116630-27-steven.price@arm.com>
References: <20260513131757.116630-1-steven.price@arm.com> <20260513131757.116630-27-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Jul 2026 09:43:24 -0700
X-Gm-Features: AVVi8Cc7UELd1-7ZAYEyOZ88G8y7OqpaGYaDp3NNsXOnmH1AvIzaHGeBstkVLUA
Message-ID: <CAEvNRgHTu5ZDAamO_sXkqP3V=_5MhFjdzTYmJn4i=a9ni=9tfw@mail.gmail.com>
Subject: Re: [PATCH v14 26/44] arm64: RMI: Allow populating initial contents
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, 
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, Lorenzo.Pieralisi2@arm.com
Content-Type: text/plain; charset="UTF-8"

Steven Price <steven.price@arm.com> writes:

>
> [...snip...]
>
> +
> +static int populate_region_cb(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +			      struct page *src_page, void *opaque)
> +{
> +	unsigned long data_flags = *(unsigned long *)opaque;
> +	phys_addr_t ipa = gfn_to_gpa(gfn);
> +
> +	if (!src_page)
> +		return -EOPNOTSUPP;

Came here from [0]!

Sean recently moved this check to before kvm_gmem_populate() was called
and returned -EINVAL [1]. I think the rationale would also apply for
CCA.

[0] https://lore.kernel.org/all/114e2488-97ed-4740-a8e8-1edd991f26c5@arm.com/
[1] https://lore.kernel.org/all/20260630213711.479692-3-seanjc@google.com/

> +
> +	return realm_data_map_init(kvm, ipa, pfn, page_to_pfn(src_page),
> +				   data_flags);
> +}
> +
>
> [...snip...]
>
