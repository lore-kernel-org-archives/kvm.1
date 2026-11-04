Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833072;
	b=SCtQ5V/u972Mbo7KmvM5EFFfsONjzTqHEHjaek+0MaMf+LEFrNqopYNgQHj9q1HNaDAd
	 9SSPF0IxuOxRvAJ2SLJ3IJ6s8PJ8+ppLNzVJHXeJOYhX3i1ick7f+SPWMNnwoPddcOYLc
	 FvN9BcoQEC24RUdBkLCdnB3ZWfuLqaS0JSgmskuLfSiHwp4GbWKZx63uHQeSUQNECa7z1
	 fMUalzU8M7K/bFEvNytKDTV5HfFhGjjtug15T1qd8089/a4VHfj3Su+q799Ilu6m3eSgf
	 3ILy/3RIagMMBXo5sgqGkdK0budLIgkyAgWjQEjU3DyxyVsx2gJcxmWo5jz65ULM8TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=bZmm/fjciQHFDsHygF6gqzElYGHv0HpumcgfM0NGUjo=;
	b=EGKwVKyQCZjVR6R5TWXyUKmJ5ni+WN1lrA38jbV83r6HLbK5zyhwjbD+eMD1zgvI8fS4
	 Py1vrAItqyKJJdTIYb3/57uNKvzXDY7oeD9YXaSkis6etB514SyatjsP88vAohihuGvl2
	 sU7LzZKJ5X4i45d1ZJ/HO4k19xLb4V79pcZvuYcn4levXGrZyIcYZYqxQ5IxfJJWbBSxZ
	 hB1Or9Qek/YAXIwYrrIMohU4RQTxahNHNd+7jajRAFeQDgfj+icDHxr3YP1/OiydzfsXg
	 y23HVMhzJ5WtlAc+WjUbT/W8KXTSeOAMLQPM74wnGl0PB2ovOhrYftLbEJ6pNje0EMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cDfTc7XW;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0828606A31B
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 22:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0828606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cDfTc7XW
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so11071005e9.3
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 14:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833070; x=1794437870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZmm/fjciQHFDsHygF6gqzElYGHv0HpumcgfM0NGUjo=;
        b=cDfTc7XW0ifae+8M1LuPWAwdIdNKakZkFWFnJt6KL55fGa37RQmqkq2uRmhEY7B1n3
         CaBTcgavNgfBak+NIwaNa3H5fTfJ9PIT5PgZQgH2MazyhDmo4aFllXX0SMasXGEEM9Fl
         p/51Tb9ZeDWq1NeJnxB9QMyf1cDUO3GXJQBRKRgploH8Le81bwbGb+y13nOzQrXCWpNq
         F42HKXSHEzc0A6bpTaknb/yOiq64kB0H1wCLiqtk4d1YdokCcUVaxOjocfuDaznMEOXl
         BFMxyeOdRQgLkukh4xswNJohIqsIMfXRyH1cjs8NbBnWvzJr4LA0LYjw3tAYWNzSjLvS
         MNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833070; x=1794437870;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZmm/fjciQHFDsHygF6gqzElYGHv0HpumcgfM0NGUjo=;
        b=hpMg0ry3iscIQJY1JLAQ6w7u1gn62j5/mJO783Uu9sQ3F1MeZmXPOthPHg5jeBbnON
         9Py0Q/Y+5Go+AhKzadIC8sMA6mcx4/1L526kkEyOlVGs+/VAjodbpeEsERvUlPKdY2yp
         byqtHmEPY+RobjQgttDz9HpUyF9c5K2NX9MCRM/FZDZKjt2B8cRwHcET50Hv7eWLP71W
         yRj+baeoxiGQ0DMeBnm8uPZ4PDaVs16DrvUknTpUgFnyP0IW0ayaNbr2bCGcTAEcpbW3
         zuEqV2h6xTvBx5f2mMpEANNOZGMdb6n486/YUL8FqaHH0moZ28w5Giix2nN5JpI8cCix
         PpIw==
X-Forwarded-Encrypted: i=1; AKwUvBzJaGbEDYxEbouttFra155wgDY4m2vFHo9P1ZOCEu9bbNFVkyHWko9FX5KuowuLlDoV3hQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GKc1LG3WSLE9K+NlGa4fszMr/nzOBYt5jTWYjw14t041qtLt2
	rfD6/tdaoxkm6SN7qDUEX41ZvlxmjatUVfm6I9AP/vhC3voBh6U4lDgP
X-Gm-Gg: AYBFou1Lzrccp8wj5Stm0rWjwhvxQK58d7GH/0p0rqqvnorIXFUwW04nfM4MFm2Qc1X
	T6HQyUmu5BJJrihknCvFRMe4QPUvVoBZKDPdwOFHsAehMPpCZMse4cEJ6I/pCaOjb02Rf+GZ3dE
	fe8qZgHyApD0bKtB5uUfrFQqAvDun1t/H5CyAq1n/vqUVlu6UzNxQOc9tVvt1TIIqCJBW18orjw
	mJuFrV+UY3cEeBb9i+GjzVO8hXlPu3ONxW4JHCqZuCkAqUXoM4hyVufSmJfaioH8SF/VA7QZKLI
	SOsjRRgrhmVOvTrRAX4VUzRsd8NB+CWMSbxtABESAfCGBKWcQtgmJlQt1Z52douSH4c5I2CioEV
	RFOuhgXP1XtSXY7sey0IB14J3V4udkQFkKfG9sXhA1pUbJF5syA+mWMII3Ol6Ge0Y8QPVWXkvuP
	ShefCtlfJ34mGbiPIQyozolUDNQMD2IDy3swMCoru1soRT9yidMoJYT+Ap9Rb92etYF95Su8+hH
	bWcSmhnCZpFIBLz4F/giJQ0tnpumjMQqScXvdyPoZgsa7SphLFAnPJvpg0pU2dJ0TJSvWI/iyF0
	U01QUQezwJJacgLLOInODzQ=
X-Received: by 2002:a05:600c:6212:b0:4b0:a7aa:843 with SMTP id 5b1f17b1804b1-4b0a7aa0a54mr222825565e9.25.1793833070285;
        Wed, 04 Nov 2026 14:57:50 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b5725061e1sm17756545e9.7.2026.11.04.14.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 14:57:49 -0800 (PST)
Message-ID: <93d13781-0c37-4a3c-8fca-6f8108eff35a@gmail.com>
Date: Wed, 4 Nov 2026 23:57:47 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-1-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-1-c56d0d26f970@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 9:40 PM, Konstantin Khorenko wrote:
> folio_dup_file_rmap_pmd() passes PGTABLE_LEVEL_PTE to
> __folio_dup_file_rmap() for HPAGE_PMD_NR pages, so it adds HPAGE_PMD_NR
> PTE mappings to the folio instead of one PMD mapping.
> 
> The helper has no caller yet, the next patch adds the first one. Pass
> PGTABLE_LEVEL_PMD, as folio_try_dup_anon_rmap_pmd() does.
> 
> Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
