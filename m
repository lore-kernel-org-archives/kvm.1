Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3253DEAF1
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297370; cv=pass; b=os7CBgiz/gr/+yM+PPz/KXF5vEAFBTFcFdVI8Y04HXTG/1g5oV4uWSbBqL5d8rOZlKdD8u6Cu1HAvmAgYbTO6uJhDSql6A9JFvX865JNJ86/yBVpRSZofzde3qJqLyMb0cXH5ueKhCd4e9N7cGiJmt5KhDA26AG7YeDPAZw+4pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297370; c=relaxed/simple;
	bh=+Ww3YVEwz3akOCPkGfwPOz5g/SjxY63PNjUlqwWXbGQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUbhE4iOEMMjw6vBqgH6Rs1Nq8nCP9YP9CY2GmpGMR1Ad9x0s9YaEGjtsA8hvvDw9UP4C3uRfZcYdqbaVJEv54qORJviq0KAXV5mfDKbw/vYUkDZCdUOOGRx6xkaq38DAjN9gYV2A1mGHEyfW/3YSKzUlgQodbqwg3EPakSoFbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ibwuzlau; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ibwuzlau"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ffe41e8e83so2881443137.1
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774297365; cv=none;
        d=google.com; s=arc-20240605;
        b=jCm9l/UnnK9V7+cul5vEyWql2qNF+xA/1UoflnQt1k4ueQ52MFRNT2VBHLSamFZXKZ
         QljcIpM1hjAqGPtwQFOfUH4TScTCiBDb76T8t9PBlE2aJ815JCVrlFVVVzllHeCD0BYx
         T0SWEfFd6Elvnu4/To0pRjHrupEo8Q4R4tNjOVNBoBgEZ4d9XKuN5ji2Nkuyy/7SY/YA
         cAvD375eZjW93Tte8awGIKnYaNLDbb8TFCufV2lirO3h5fJ4gCSdaqk/6wt3HzULFzk6
         OoNy88kEvdnIBT4L803KKA2c94TjofC5XDg/c1fynYU44KmuzqLGgO0UB0iy0rXBXQEe
         HiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=DfIEo8yQ3CK3TKTvqaXVb6LUrtHQE6Lxe6QzmQiMk8w=;
        fh=MYWUhSU+3xy9MuvblBW6+NZBvyO5LE65DBK0nWHelJw=;
        b=M7Z4+D5B7CHXzoO6DRYfHyuPuFs0o8Z5uF8SqzlxGawgD3j2vu/asewfivu3gY3B0X
         vWVrIaslacPuIjorRdKbYPerWUaCD/B0BUU8Kd0Tt4NrcOHd4HzzaJqY56NcVuGgkvxu
         Z2hgIIRGpJ/tS2SCKymLYuTu+3hlbwMvSj6L1SBDGCfaBrxzfZW3fNEt1EgGMd8TZDlx
         rZzm8vjqApsdwZ8mQPXk/St9JRrW0C+4n9rMs9H/rKiCnf2l2qz6fukAeniHEfRWJJ8c
         AINu2uahnR6ur5CNfT19lX4cpnuIcSsouHEl3Ns2xxhbawwBrnGiRgjGE9Gh9CSurBQz
         +fuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774297365; x=1774902165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DfIEo8yQ3CK3TKTvqaXVb6LUrtHQE6Lxe6QzmQiMk8w=;
        b=Ibwuzlauj5c8iKXxG1nK0hN4JyHV1Mv3KfKVQuiM0E+dlMSGVRwp8PfoYFyP1KyuxP
         TV8eM6VPHDio+E5Cn8SvvUl81aCB1scyZpRBpQDqfaLDZ/2fcpxRSgfNro+mQ6DrusbP
         Z/a96ziy/AhJVi5KNvSFNb0PJC3qVLwpHNJIPJ+i2XhBM9b547uqZ6kBX5VfuKRPpGll
         zvvg4ItxeGu1cu1UCqpMsS5/wsgfWhO4cfLEXuCTkRTZm/O8BRjqXxrk7D84ejUoBBku
         ZfHITQWeg4EzxLmcIyXpuaZa2R++4mxy+6mdQVDjSpf0LTRgOhE1fJU0yDfXDeikC89Y
         vkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297365; x=1774902165;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfIEo8yQ3CK3TKTvqaXVb6LUrtHQE6Lxe6QzmQiMk8w=;
        b=OO/OKjbZj1/dvT7kpYu8D/FDdWWWmhybF8O9ppqgFPyfrWN+gx627zNImQ3XpNY9D2
         Kz9EUG6f245EvQBbKxtncxiFDi57a8gxNsPbjET+IJcErk7l4ddwAT1xHeZ0/T69P+TM
         fjmc0trLUwXfe4ohYjqnaUTvdKEw2wpFv15ZrWEcDXp4zr9809r3lVhIzcUkSoXwvE/l
         c2T9xvwbJbg3vqt15kIylWPqYi7zNHhRQH+6ero31ALND8AIois8oijgL8bK1up8Os2t
         1qwhI9W5vXFUvIvHGrBAEInQHZOFx/5fg+o8M2odrjxFqkDzG9MPXQRo6IPxwFIRPlUc
         PRpw==
X-Forwarded-Encrypted: i=1; AJvYcCVeQOl+zC2P07TbY8rOQuw9/E3UfgBMDptcG/+wwoHTGBqVWqUviERg0e6Bw3tykn06qCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKvcsCjzbQ3vUfqnlT6CmlmKHH8icQMOJK/pAs416e42ymCIlR
	vkP32y3tbnpna9R39ZIUq4JUGnCCKRNWsIiG54nc1ijQbV+zEzfPix+C51/0kevAnmHwpbEfKaT
	SOr1TOk7KNIry21SiY/3nJ2AbgakxEXm73566De9p3AeNZVU+p85lkJ8lLoY=
X-Gm-Gg: ATEYQzydMt7kKYeHvkpoGJDDXXFah/jKOdZgOGe2/in4ZgCEmxVabzZmdpb1ZEsMSy2
	ZmXGIhsdBSgZgrVcrRWqfyzaF0IZoh0vHFKzYV53z5s696Bfkw0s2HvT3XxH3GLv5+4AoVMeJVn
	k9eUir+rAG4QhkwwRIfUBNg7hRVOGtCfkUKqHZhz8Fp4SiN2Kn9jpn0YdVus6i5BtdE3bt0c+ty
	GB0sYdlDFWMZF17T4GBdr24zxnKtG71UcNu6Ptqz4j0VPPr3hWZIPTeEl56SxgptMLDOBIlRcbq
	25Kw+ZxyrR/yVob5b0Ti9U6KLCKMRAeCdRp4lsDJme9mH/FmbYcot7WGMw/jtpnB4s1TIQ==
X-Received: by 2002:a05:6102:3a06:b0:602:8742:1fa with SMTP id
 ada2fe7eead31-60316013f44mr514571137.9.1774297364023; Mon, 23 Mar 2026
 13:22:44 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Mar 2026 13:22:43 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Mar 2026 13:22:43 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <0a14c10d-0dab-4b9c-85ec-e0ee25cd0db8@kernel.org>
References: <20260317141031.514-1-kalyazin@amazon.com> <20260317141031.514-6-kalyazin@amazon.com>
 <0a14c10d-0dab-4b9c-85ec-e0ee25cd0db8@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Mar 2026 13:22:43 -0700
X-Gm-Features: AQROBzAJTtmZ8_CHcmYDgt7IaYmvr2Pi4WE03drdmWTq3AGR3rA_vEwuIGtsbTw
Message-ID: <CAEvNRgHqJGwmAfS8TuGBbUoQehpqY9GdtjUS=+Hc1ViK79RL4w@mail.gmail.com>
Subject: Re: [PATCH v11 05/16] mm/gup: drop local variable in gup_fast_folio_allowed
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "vbabka@kernel.org" <vbabka@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "riel@surriel.com" <riel@surriel.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>, 
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"coxu@redhat.com" <coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"yosry@kernel.org" <yosry@kernel.org>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "tabba@google.com" <tabba@google.com>, 
	"prsampat@amd.com" <prsampat@amd.com>, "wu.fei9@sanechips.com.cn" <wu.fei9@sanechips.com.cn>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "urezki@gmail.com" <urezki@gmail.com>, 
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>, 
	"gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>, 
	"jiayuan.chen@shopee.com" <jiayuan.chen@shopee.com>, "lenb@kernel.org" <lenb@kernel.org>, 
	"osalvador@suse.de" <osalvador@suse.de>, "pavel@kernel.org" <pavel@kernel.org>, 
	"rafael@kernel.org" <rafael@kernel.org>, "vannapurve@google.com" <vannapurve@google.com>, 
	"jackmanb@google.com" <jackmanb@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, 
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack" <jackabt@amazon.co.uk>, 
	"Itazuri, Takahiro" <itazur@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 3/17/26 15:11, Kalyazin, Nikita wrote:
>> From: Nikita Kalyazin <kalyazin@amazon.com>
>>
>> Move the check for pinning closer to where the result is used.
>> No functional changes.
>>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>  mm/gup.c | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 5856d35be385..869d79c8daa4 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2737,18 +2737,9 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>>   */
>>  static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>>  {
>> -	bool reject_file_backed = false;
>>  	struct address_space *mapping;
>>  	unsigned long mapping_flags;
>>
>> -	/*
>> -	 * If we aren't pinning then no problematic write can occur. A long term
>> -	 * pin is the most egregious case so this is the one we disallow.
>> -	 */
>> -	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) ==
>> -	    (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))
>> -		reject_file_backed = true;
>> -
>>  	/* We hold a folio reference, so we can safely access folio fields. */
>>  	if (WARN_ON_ONCE(folio_test_slab(folio)))
>>  		return false;
>> @@ -2793,8 +2784,18 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>>  	 */
>>  	if (secretmem_mapping(mapping))
>>  		return false;
>> -	/* The only remaining allowed file system is shmem. */
>> -	return !reject_file_backed || shmem_mapping(mapping);
>> +
>> +	/*
>> +	 * If we aren't pinning then no problematic write can occur. A writable
>> +	 * long term pin is the most egregious case, so this is the one we
>> +	 * allow only for ...
>> +	 */
>> +	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) !=
>> +	    (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))
>> +		return true;
>> +
>> +	/* ... hugetlb (which we allowed above already) and shared memory. */
>> +	return shmem_mapping(mapping);
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>
> I'm wondering if it would be a good idea to check for a hugetlb mapping
> here instead of having the folio_test_hugetlb() check above.
>

I think it's nice that hugetlb folios are determined immediately to be
eligible for GUP-fast regardless of whether the folio is file-backed or
not.

> Something to ponder about :)
>
> --
> Cheers,
>
> David
