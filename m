Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B3388371
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981120; cv=none; b=jFh7IOBDu+cv3UbEITGHgsBrFI81pdj2K3W+DH4pZpIVOsFXIGhmc9U2Fql2qluFgWKbcmw7khg243uXXj6o8A0jjB6LQziU3JSwn2akdmIcN16ZINKvm31YRLibfrsnaxaNXut1MQwnd68uuivfGNCWiXRpQ41EQT8MQDGTp+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981120; c=relaxed/simple;
	bh=g1YQ8S4VPD7bLF9CRGQo7I4DxCi1ih33xBj9CSwW1Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8XvAk9p6F6OzC3qxN2nrqTUi83vT4LzTp/jJYRZ6rJsrtS7BR5he92KUsWa6VdYFAMq2EsHSOeCrWPg4Q4lf9YLIpdtoXOr0L9Ld6rLeNnAtwc0ac29uuehGMtyOLmYjTCb9uwme3TwW/VT/PWtzbN6llKpJCAE/tVm7znAfiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IhaS/OSk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTpo7ZI3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhaS/OSk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTpo7ZI3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777981117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UmcpW4CRfawEMyZUweO0e7YA2eoyQ5QeRsWWHrnqWI8=;
	b=IhaS/OSkg7C+Hl/Xs++9o5hTKyg1eB3eqDDj2j8RIjgsTu24l78mTxlxHk/xkmzu02wj9z
	yZ7ryC442QqpDaGS+V2TGhadS8+hvoyaLEL6QmOJbCEh1X3of0X0dzQMxixxkuKEiWsW6V
	U0O1CAnY8rgUgOr0FFjTBySz4yiE1nA=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-m_d-UQz6OfmHFjAacSiGqg-1; Tue, 05 May 2026 07:38:36 -0400
X-MC-Unique: m_d-UQz6OfmHFjAacSiGqg-1
X-Mimecast-MFC-AGG-ID: m_d-UQz6OfmHFjAacSiGqg_1777981116
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-649df163c11so7125678d50.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777981116; x=1778585916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UmcpW4CRfawEMyZUweO0e7YA2eoyQ5QeRsWWHrnqWI8=;
        b=GTpo7ZI37vOgwO7EgTVAwEB4ouagrq7h9U/cA5B8xwr81mR4RCe95eR7lQYI8qE0wl
         xxCuk0LtI3grFeBf2yqRoNaiDzc+et5SodhyV1VoNmZjZSVVpGKYGpSJGtQFT6yYPI8C
         omoaghup9Ulqq36z+2bqRmb3SYYOGTBaQPfPfAjlfp/n8Vam6eBMySKu/lVTI9U634hv
         /bYn1WggUrmpL+lAyCrmSNLVPJUP5uT1ss4bpkW/d+UGz4Q98S+wmgw+leP/By5SI1i0
         yGU5uolOPgos4vZtc2tI3GioiULurJP01MxCa4o/i7bhzpxXXyqN02emRU7Ees1ljtrP
         OyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777981116; x=1778585916;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmcpW4CRfawEMyZUweO0e7YA2eoyQ5QeRsWWHrnqWI8=;
        b=jViE+Q5iKxEeW3M3Cotypp7Tphbq5A83PIoHBIxLnClsR03AyJh9EkzCSj2olwkMkF
         qh6kngkVVvv6ae/939z+HOY1x/Tw47Z0AlnOtoVSauqrimffsSdFuE13wDNkK9FR+hAa
         jMwNu41jUth9qHH+b6eOm+5gf4bcLEqvbpictDG4xpr5gmwt6BCHYMnrnTsq/rT9/jzY
         hmocrI5yHqhG5xbvl+3jTW3NfuCM+9OOP8QNURfu1DCozsT/hwp+Jsg9mWey6RoahwvE
         YKUAlerM9dkdm1EXuug+pTuQ0yIGacVLCcpjnsXQBY17Lswq5kTK66C+RUUcsqG2rD+i
         gKgA==
X-Forwarded-Encrypted: i=1; AFNElJ+rlv/y2i6lMxyUYI4oOr32aBos0r2dyVEzoWrVCU2UAuK+QY2Mo9z1ZItvsJ6sAU6SWwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnhn/vtP2ouR4stiDWMbB9JifCzRBlgWlOrYMW4rLbK7UG/wc
	H6siY1Texps9WSimeNs3cGy4NbekGH2WFd3zGoQAVgpReCbVWzblN3B6c2oISdaa047gZlF3L+L
	uxUPhR2Ouy7XA09pY8GOKWhn/SVd7vX5SWTMuztUXnRFbK/dTNfyi2A==
X-Gm-Gg: AeBDievpYrJpdCE0zBnOwCPKQj+t1DVYYLrBNXJWvAJlo6z6qN2ZlKkCzqsDRxJv4M4
	MLRM33co5A3B9nL+W+rHdrDBHBnn0jPI5wc22eFZi6cmA2DXIDH2/G6xWLGysynPpFRUq4ilOtn
	TlOd+ZZEDwxE0TrbRCDvcYSeEyV9k3pqratpXktyKWGICwdSBrhdGVrF/wNrDnO1q3JsVJNNeum
	yCTUrP4Ah/l44lAf6fTqeLmsBEG4KOZkZNmLzTHcBt1DwJM0MKMI6qnPShlLYOhyYsE8MVrs8tn
	GEl1ElMxiycTBFJSk9dVOfNDRcgc7k4n03/WCaYEqwvQNO91CRSGiMSUfvs4PnsURF23rzXAQKb
	lOEmHmoZ30kURDR+sWPgZLdKKDYU1KQ==
X-Received: by 2002:a05:690e:4349:b0:658:a18:cdf0 with SMTP id 956f58d0204a3-65c3da71355mr10839879d50.29.1777981115652;
        Tue, 05 May 2026 04:38:35 -0700 (PDT)
X-Received: by 2002:a05:690e:4349:b0:658:a18:cdf0 with SMTP id 956f58d0204a3-65c3da71355mr10839664d50.29.1777981110414;
        Tue, 05 May 2026 04:38:30 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.164])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e1bb5adsm6870038d50.7.2026.05.05.04.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 04:38:29 -0700 (PDT)
Message-ID: <48384da2-7eb5-4044-bc3a-201b09d9cf81@redhat.com>
Date: Tue, 5 May 2026 13:38:26 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: intel_iommu unit test is also failing
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Yi Liu <yi.l.liu@intel.com>
References: <8aa24294-439f-4484-b6fc-9327b6fd0306@redhat.com>
 <600b025e-602e-4128-9679-f53f32b96e8e@redhat.com> <afi_HNJoObF10rwz@x1.local>
 <96f57df07e6d39e30557357142b2212e0ea26af4.camel@bull.com>
 <0abf41c113c9425ea4c73a108db22f28290fa395.camel@bull.com>
 <13002aef21dec62205c252f3d12bb42ea59cf287.camel@bull.com>
 <d4ae6782e30a05ea9d56c38f0c5d296fb6a5c7b1.camel@bull.com>
 <6b338140-873c-4303-bdd1-633d69f4a971@redhat.com>
 <20260505061927-mutt-send-email-mst@kernel.org>
 <c7b1a006-a67b-4ddc-8e2b-67fbeb23b066@redhat.com>
 <20260505065122-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20260505065122-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/05/2026 12.53, Michael S. Tsirkin wrote:
> On Tue, May 05, 2026 at 12:34:41PM +0200, Thomas Huth wrote:
>> On 05/05/2026 12.23, Michael S. Tsirkin wrote:
>>> On Tue, May 05, 2026 at 11:45:17AM +0200, Thomas Huth wrote:
>>>> On 05/05/2026 11.27, Clément MATHIEU--DRIF wrote:
>>>>> I had a bit more time to hook into qemu to check the root cause.
>>>>>
>>>>> It seems that testb issues a single byte read (out of the valid size range), as we can see on the following breakpoint:
>>>>>
>>>>> ```
>>>>> Thread 6 "CPU 0/TCG" hit Breakpoint 2, memory_region_dispatch_read (mr=0x55d72883cb30, addr=152, pval=0x7f62d25f4590, op=MO_BSWAP, attrs=...) at ../system/memory.c:1473
>>>>> 1473       unsigned size = memop_size(op);
>>>>> (gdb) n
>>>>> 1474       MemTxResult r;
>>>>> (gdb) p size
>>>>> $1 = 1
>>>>> (gdb)
>>>>> ```
>>>>
>>>> Ouch! That's an excellent finding, Clément ... so GCC 16 is "smart" enough
>>>> to see that we only want to test the lowest bit here, so it optimizes the
>>>> code to access only one byte of memory instead of 4 bytes... which would be
>>>> ok for normal memory, but not for an MMIO register :-/
>>>>
>>>> Ugly work-around, to force GCC to read 32 bits:
>>>>
>>>> diff --git a/lib/asm-generic/io.h b/lib/asm-generic/io.h
>>>> --- a/lib/asm-generic/io.h
>>>> +++ b/lib/asm-generic/io.h
>>>> @@ -38,7 +38,9 @@ static inline u16 __raw_readw(const volatile void *addr)
>>>>    #ifndef __raw_readl
>>>>    static inline u32 __raw_readl(const volatile void *addr)
>>>>    {
>>>> -       return *(const volatile u32 *)addr;
>>>> +       u32 val = *(const volatile u32 *)addr;
>>>> +       asm volatile ("\n" : : "r"(addr));
>>>> +       return val;
>>>>    }
>>>>    #endif
>>>>
>>>> ... but I wonder whether this should rather be treated as a bug in GCC
>>>> instead, since it should IMHO really not change the access size for a
>>>> volatile memory access?
>>>>
>>>>    Thomas
>>>
>>> Wouldn't this break linux generally?
>>>
>>> #ifndef __READ_ONCE
>>> #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
>>> #endif
>>
>> I asked myself the very same question, but after googling for "GCC 16 linux
>> kernel" issues, I did not find anything related... there is likely something
>> specific to kvm-unit-tests in here...
>>
>>   Thomas
> 
> 
> This seems to be pertinent:
> https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
> 
> -ffuse-ops-with-volatile-access
> Allow limited optimization of operations with volatile memory access when doing so does not change the semantics outlined in See When is a Volatile Object Accessed?.
> 
> The default is -ffuse-ops-with-volatile-access
> 
> implemented here:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=122343
> 
> Try disabling? -fno-fuse-ops-with-volatile-access

Thanks, this seems to fix the issue, indeed!

Would you like to send a patch for it?

  Thomas

