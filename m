Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29366366DA5
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158701; cv=none; b=c+1uD1bjWnAE1ccGpRXe8JIIOPKUUBeWPujNps6GD2h5CaElzicWpZLt8VMgvCQUUBKXBsjmUpc6jdo6Ojvdji+Gv+phNDGswaC8eY4+kWRVsod/8HGUtATjJsO3/PCC0fuP8EcmtbeKLpmMWpnY8ddSAigrbASdr84fWob258g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158701; c=relaxed/simple;
	bh=sxuqQOtpTIhnsnruCurB+KsFnny3NxywxLqvf8D1RWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XakT2mvoXvVwRrZYTgRdmyifsFvBsed9LBpc/5PGghTKwKb58f+rnsDvQnc/CVEwZaT6YYBgVARliIFLAhPY6fkjLuhumtKOcYJZ9L6u3BFL9VTezJuaCjsSGOiw3rL1p3ReoPBaynZJkB+Qr4V44uiH8ClBVsEmK+IHxLI2cxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=pBQ67VJ4; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="pBQ67VJ4"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632JUMee1387830
	for <kvm@vger.kernel.org>; Thu, 2 Apr 2026 15:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=1Wma
	Gc9Te9yz0Zibs0J92PxP2axqg3Ucqwb44WM0s3g=; b=pBQ67VJ46+SO5CMoxNw4
	10vf2BWyi8pCFVjd3/INcGVNa2Rx4KtH2rep92OIs2n1Z89uB2lTfNviu+kbwbPd
	DjAPZzTjPlQJxf6aaLj8+55swS1/gYcctqfhFYgYzhKlR/0crQjLSGCN03sDQss9
	4tZHP4P+wILE7QdbAjcgpe5P/Ff4my0GTEA5qtpp8D85WKZQFROup1Kp2l2MpjiS
	9Yj3nNMZauc2U5s34Um9d9jiL/3yeihYWBvWrqrsZRhGbHQbSjGDG8Q5TIp8ZYZM
	cU3Bx2XRUUejxzakioCYxP6G9EC5W5f3QZfaBWft5Fh55KmbHTKoFuO3cCmIUNz2
	vA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4d9tyua6sf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 15:33:02 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8d3e4c19307so84809485a.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 12:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775158381; x=1775763181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WmaGc9Te9yz0Zibs0J92PxP2axqg3Ucqwb44WM0s3g=;
        b=XH90qs222y7qPKNxHPCCb1YvjroKhqNXfEdv95CBaypdBMzutHA0p6I6Dy87wyLM+T
         32Dm/zHvsCLB3IuyC+rVc381fIc/VgL6awI3GbA1Vj1qkvXM0kBXCadZRhKeYJwhxQGL
         t7JafaeNHgES0DGAHKkw3OzPWxT+1U1uSX5rs1l97hCUAbNgANy+UrUqzRYNAwCU0nO5
         f4GtBDwD9ZPVh8Bas0MhZtSrAVB12oVCMVEuU95bBZogCdGdnriyBkpj7+eXiieRu+C2
         nWkg2LNe3+3aETKrENQusq5B+t1TqAC/lSg4mbreGNBEGnlgHEJfE8DoC/4kEt1isOjl
         7iFw==
X-Forwarded-Encrypted: i=1; AJvYcCXJHSL7U+Z+FwZM8y4Dh5/7bfUdhh+06zIaQBgM/q4KPgffCwsUkmlVrFZzed8qOywu8u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEG1i3sHavF8/T0EuMx2S6PPipRXHKC/mMV4rrJ/vadL8M58Z
	56zKIR4UctHtYK54gJolngWplVoA+qk140CSZPR5hEe57ceDZZUZveAZgjhpmhE+KwbxV/PgUCR
	bPd59fyaniSA9cyUEWWqb/DfQ8J4lXmIetMDAbTTIQrKvH3PiNg==
X-Gm-Gg: ATEYQzzwqWx5U0tPBqmLuK/i4nEFzPk5hLzgCntBpJLvNkII6udvXj66kMWHPdeD/eU
	h44YZ7dkVuz8FhG5kuWzd03yLexIpUE+LOPppcuvyCgXDzBO1tlorSYOqRLbRplt8gNjfuzGrCY
	5i78MjYJpLO6Qh1ANL4EiV2ulJY4laqVhWsSk6nrDmW1yyfFa9HULdHhGbJlWzrT8eo0igAu5FH
	531bcCh+uHBCtziEMkw/XdF8GIzr5tiDyHH0n30SEAdr92mLXqpPh2l5L5iYLpqGWKCpxMSzH7U
	nPghLj0kjZtnoaHYiwhHqEBK18At6+2htQz8Hrn/bQjn5Hpm1NKJbbOqYkBuUCMFZR6tYaM+5T2
	YqvbZ8rUuWPViqmuBfS6wGDzJRGD0wPJIrbiLTJo=
X-Received: by 2002:a05:620a:298b:b0:8cd:9599:b7cb with SMTP id af79cd13be357-8d41c6ac558mr84739985a.25.1775158380992;
        Thu, 02 Apr 2026 12:33:00 -0700 (PDT)
X-Received: by 2002:a05:620a:298b:b0:8cd:9599:b7cb with SMTP id af79cd13be357-8d41c6ac558mr84732685a.25.1775158380358;
        Thu, 02 Apr 2026 12:33:00 -0700 (PDT)
Received: from [10.206.121.101] ([129.236.224.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a80680dcsm283333085a.26.2026.04.02.12.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 12:32:59 -0700 (PDT)
Message-ID: <6a171abc-ebd2-4ddf-8c36-34c66ca42043@columbia.edu>
Date: Thu, 2 Apr 2026 15:32:58 -0400
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] userfaultfd: introduce vm_uffd_ops
To: Mike Rapoport <rppt@kernel.org>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Andrei Vagin <avagin@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Harry Yoo
 <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
        Nikita Kalyazin <kalyazin@amazon.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
References: <20260402041156.1377214-1-rppt@kernel.org>
 <20260402041156.1377214-8-rppt@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260402041156.1377214-8-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F/hat6hN c=1 sm=1 tr=0 ts=69cec46e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=k+Kg2sH3hDje3YXt6xVjPQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=-OANyN2A5GHSoQQpHzcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE3NCBTYWx0ZWRfX62XLD99rQXtU
 n4HTThPW29L8IvRC2AM6bzDBnjK2dYBd0RrHCEfKctB6qIX6Lm3ZNzpJ+Ag7zx6gZqFfNsvx6Nn
 j++KH0TBSv+N/oSOkX+Cy4iNiCIp7HSaU7N/RSSSTSGm7AGnDGci2xGhsIv/AnoRGUM3qBmpNmT
 MH0oSYmTI0BviLXb058vbpwViLEXMlt2MSc9mIVv6FhnA0yADZ25RFZj4UqBe6Md2PGvHhvx6oj
 LL9xVxnFoEIyCSHTZ0Fo1fB8VhvSP45phR48fERpv2sDKX5MmTdojARgIlIwP/qySb6xlKRRx6d
 oKwwhov5ONoj8C7GkIGFIxtq6WbVxF8G9oC4sD3zmKv1W8EGWvGNqRhZzlSDVouBie43nFgUcDk
 VeB5fOTjvLgG7IGh4Ba2xPI/yt3DUPUEweL9svOtODqGY+VYqxXGJ6O5/W8MZndmxXTeR56u+4P
 YWhBL+u/3FBCZgkcb4g==
X-Proofpoint-GUID: Wniyc7wI5DkctPerZc68ygzRtqJ-q2pa
X-Proofpoint-ORIG-GUID: Wniyc7wI5DkctPerZc68ygzRtqJ-q2pa
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11747
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=10 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1011 impostorscore=10 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020174

Hi Mike,

On 4/2/26 12:11 AM, Mike Rapoport wrote:
> @@ -2021,34 +2040,33 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>  bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
>  		       bool wp_async)
>  {
> -	vm_flags &= __VM_UFFD_FLAGS;
> +	const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
>  
> -	if (vma->vm_flags & VM_DROPPABLE)
> -		return false;
> -
> -	if ((vm_flags & VM_UFFD_MINOR) &&
> -	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
> -		return false;
> +	vm_flags &= __VM_UFFD_FLAGS;
>  
>  	/*
> -	 * If wp async enabled, and WP is the only mode enabled, allow any
> +	 * If WP is the only mode enabled and context is wp async, allow any
>  	 * memory type.
>  	 */
>  	if (wp_async && (vm_flags == VM_UFFD_WP))
>  		return true;
>  
> +	/* For any other mode reject VMAs that don't implement vm_uffd_ops */
> +	if (!ops)
> +		return false;
> +
> +	if (vma->vm_flags & VM_DROPPABLE)
> +		return false;
> +

Doesn't moving the VM_DROPPABLE check after the wp_async early return make
the issue David raised in [1] possible again (i.e. moving swapbacked pages
into a droppable region using UFFDIO_MOVE)? With this change, VM_DROPPABLE
pages can now be registered with uffd under wp_async, which allows
UFFDIO_MOVE.

I think the VM_DROPPABLE check should go right before the wp_async check.
And it would probably benefit from a comment...

[1] https://lore.kernel.org/linux-mm/5a875a3a-2243-4eab-856f-bc53ccfec3ea@redhat.com/

Thanks,
Tal

  

