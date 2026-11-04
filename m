Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833768;
	b=AA07b3C93mXgV7TGgJMe0rIybTSNPs8ieGRN9hlAddJlH0c6+bdqT66L+cVMxcr9cMtw
	 cZQDKsO4lyCP8Qks9/zQXsM8L0ELfPYxJeaA+74cBxZr+3aj3O+CMeYJAzrYiG6b6WKKJ
	 4W0Se90m5za7Mig6wjPGomrGoja/Jhm/8xWYzWfVZrKq7coY5rjrD6JqESoXLdFhoPuCa
	 NZhOZ/EFE/hPAgrTeF/EO9Rl2uw5sUO3gTdy1Igc9/S9o+NP9ULvGOs+q4SUOIpc5CAE/
	 uJqkuVbMW6Oo/D7WpTWN0XHVjDMdmZhnN/dX3kBHWpuo4dmIeC/rvJjktJb9PwonvmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QJ44xLdhQI1uBh7xxp/N2gaMNtMNeyLEDRfUNR/7E78=;
	b=V7wG9pL6t8jCgBrELynFdM2eMKVp20D5o6Jk5rIx9/2F0FrhkMtRTeeJzqQkCnlkCHct
	 itExv735LNp40330EhV5mskaLiQuHxLw2c1xuD9WfNtZUm6vunw1+YLlR0NzFu8FlgNY5
	 nhgsD6gDTDxVlpBh64FH94Im4IQzutvxPZXNVw5ClbJEIAwpvlk9qRKkeOWW9HjapI83L
	 3+AZdDV6p5iuwa79UFVlH5UsdRzTsmo772F1OL143rZnVPAic0x+N3RZoNz/ApOC5etHo
	 NervdhgqbgtHp2PQWmHmO9UIdTM+2vnd1JoUL/45WrJstIcARAGBIT6uBJfEa6mLF8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wjPH+Yne;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E5606A328
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 23:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E23E5606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wjPH+Yne
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49d05d51553so7906355e9.2
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 15:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833766; x=1794438566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJ44xLdhQI1uBh7xxp/N2gaMNtMNeyLEDRfUNR/7E78=;
        b=wjPH+YnexCxHCatAS+O3CqB/uti+0YeZ1zpXdmwJfGvl18ME2cwPE17tj9l8RL6zKG
         4YD+rNP0FbGe1DApbRxNUKKDQxKiWWyJsEsiIeD5m3R1WFqh5uyBi5/u3mZOh93btlba
         3eNdOhcnOs7Rz8iwRjpkdDIuKPNF5iof1aLQiDacU5C4shWTx6C57mU+9gbm2GGZcfBA
         p5pZk14nucF2DgMpHAyDsRhrYK1h49CfvSIS462o++nOlfmXwYGmg6Vlq1VcyCgAzpCN
         hIQfwykB+Z6qGuAShuE0FkkN5trrXYAempNz1eSEyLl34fNFWujFVUwcAFwoGY/0fLOu
         XYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833766; x=1794438566;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJ44xLdhQI1uBh7xxp/N2gaMNtMNeyLEDRfUNR/7E78=;
        b=QRZ3cabneR4dUZ0NMf6tHpSrcdo2bcpp1pcPhxMeag1gHsPfkRsNfhAELyT67RivdW
         DIB5LXglRa6MQH8WTJF9DUTadt2Rx2yFtmbu7LqtHH9+SOFWGcUXSy7DZl4ZjvyNfIeQ
         wDUvSbp9yTLnvSDZVZAfYMfdYhYD4AYXmcduIaq6PPXTxdqnHbtr7/eIJzt0VmTncb5t
         Ps8trXjJR9LZHvILUXuQdcxfY0H0tspztj9Ki2wqqUU7UOKaXOL1ZY/q5Cl1HQ7Y2mAd
         UuWGTajbSG9ieNeTQn1/SksKl3LL782PcaSG62qQxh7OA/1r+WH82k2C8A4rcSN1TItd
         0Piw==
X-Forwarded-Encrypted: i=1; AKwUvBwe9OzNYXqnU5DnCz3Y+ocP/Oj8wytliaB8SVaEuBJUo6Vh1JiXxJWynM1JxOdW65N4Jjw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+burrGEgaWOVqgS4QEuaNCLIk65193AbEnUZf9qDaKvT+1hR2J
	lwcw0UGv0mdOC+eprmUYGf9lNJiTZH/sQIMf2qK8lS9QqrdKUGdVrrLv
X-Gm-Gg: AYBFou0d2peQ2tEWji4AACNmTBhOCPGauS5kipSuBFyROLVYNVtxC7tTA/M+v2y8CpQ
	nRZYXL3ySgNYGF2V2QC/frDGbCCK5ZpXRBl08XeVoRZK6Ke14soJDn1qp2mifzTi7bZY/rlmLrK
	JDJZRH1wwQJm1bO43II6glFkpwRVTgAT+0K5e42oyKR80jvaDYfPcoppMVeiShnh5zo8e5uCyrz
	r36YliNDXj0KoS8xGtnF+ebhTLRCRrjEMDiIZBSOI2nSVbIkpKuJF/hoLb8BkG9y7E4QYixWwqD
	6m3dweONSBGi/NOuEdIVdp3HNOJaC+Aa11OPWqMZYX45KAlwBfqmFn6zyY+xgxJYgxCyq381BLH
	1yYXzKmRwHpYcC00i9rmoIFT2AHAdBhikMfaB0QM3WqS/WLk6u/IoIKAIzrM0WGh20kE5sbmeKT
	zHaQgzN/olZB+lzcWCg8CJRooum5YG0MNL/kGlGq1W3CmJ2cE55elMc1hQwa19uNVrz3gazpEe+
	c9x6GIUBf6aJ3X5cwZqg4ifYnZ5sQ5zpmk0nXM5+/EPNlkyeJ0+9XT/q5U8y7HcYt3Wg7exxfYv
	gXyP517+UtMZTmQ8Aa5ejUQ=
X-Received: by 2002:a05:600c:3b88:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4ac187a6ffcmr414345865e9.29.1793833766131;
        Wed, 04 Nov 2026 15:09:26 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae73csm18115315e9.1.2026.11.04.15.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:09:25 -0800 (PST)
Message-ID: <a9ed4146-691d-4a35-9b82-e60329688277@gmail.com>
Date: Thu, 5 Nov 2026 00:09:22 +0100
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
Subject: Re: [PATCH v5 3/4] mm/huge_memory: read a special PMD under the lock
 in copy_huge_pmd()
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
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-3-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-3-c56d0d26f970@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 9:40 PM, Konstantin Khorenko wrote:
> copy_huge_pmd() reads a special PMD without the page table lock and
> copies that value to the child. The mmap write lock held by fork does
> not stop unmap_mapping_range(): it zaps under i_mmap_rwsem and the PMD
> lock.
> 
> The zap visits the parent VMA before the child's, as dup_mmap() links
> the child right after the parent in i_mmap. If it clears the parent PMD
> after fork has read it, and passes the child before fork copies it, the
> child keeps a mapping the driver has revoked, for example:
> 
> - vfio-pci: the child reaches the BAR after the device memory was
>   disabled or the device was reset, instead of getting SIGBUS;
> - panthor: the child maps the pages of an evicted buffer object after
>   the driver has released them.
> 
> The same branch deposits no page table under the copy. ppc64 in hash
> mode keeps the hash slot array of every huge PMD in that table, so the
> child dereferences a NULL table on the first hash fault, in
> __hash_page_thp(), and on the zap, in hash__pmdp_huge_get_and_clear().
> 
> Take the locks first and let vm_normal_page_pmd() tell a PFN mapping
> from a folio under them, as copy_present_ptes() does with
> vm_normal_page(). The zap clears the parent PMD under the same lock, so
> either fork finds it none and skips it, or the copy is in place before
> the zap reaches the child.
> 
> The copy of a PFN mapping then goes through the same tail as a folio:
> 
> - it gets a page table where the architecture needs one;
> - in a shared mapping it is marked clean in the child, as a PTE is;
> - in a CoW mapping, which only VM_MIXEDMAP allows, both sides are write
>   protected instead of a warning being printed.
> 
> Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
> Fixes: d1503aa9ab80 ("powerpc/64s: Add support for huge pfnmaps")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=1
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
