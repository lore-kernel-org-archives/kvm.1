Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8883C3C0E
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927055; cv=none; b=azVbAZE9uWNsKq9dKRrQNeqcRWVIRF4sw+JcsaNFRNJ2aIdk6DkNFaSrDir1AgP4KSE0Qte+z2NJVmN9vpDe496ofW8pPfy4c4Jie0npwsXb1v73dEJehg/J6U0wCpFApNhM6YIfyFaJHi8gXFlpZ2biirORF2MBSphKlFqXT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927055; c=relaxed/simple;
	bh=V/PRzVGD/Wn9Z1UfqbT/SqDvTctLoLUeiR9lmm2cxOE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pbSsh7MYq9qicWlT3I7nrKHEm/yRztEk8CVWTJ4t2fr9S7RP9E2uJVqECU/apeKs+EuO/nIHXACi9nxM1ffVnJfBImGiJ2VUJvy8up/xuoyAZuiYrVjMJjELPdElm/g97GattJcspvvGpGZJGokRrrBeKhdCBAXtxlnpwWeNBiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfhFnb3D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsggIQVM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfhFnb3D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsggIQVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780927041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3QZwl1Yn9MoZg35gakkX81ZZXe4u4EcmIxBYNzqBHiw=;
	b=FfhFnb3DLeQ5m3yVGfaIpJH9GFcnclSpJ8heyrgTdDR+rtXns4wQlxB+IVrHaa2L6Eion3
	r3/aIQahMwTn7NZ5KnpOrsKvYS5f5IlHxrw+MBOFBWn6M35RO2wFVM4YMeOknDa6GVyAjX
	ZAiq67P1oAbvPO9Z91t0ZypKu18NDSE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-MrzY9clePK6mQRXnGsVVIw-1; Mon, 08 Jun 2026 09:57:18 -0400
X-MC-Unique: MrzY9clePK6mQRXnGsVVIw-1
X-Mimecast-MFC-AGG-ID: MrzY9clePK6mQRXnGsVVIw_1780927037
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef0af9517so2176490f8f.3
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780927037; x=1781531837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3QZwl1Yn9MoZg35gakkX81ZZXe4u4EcmIxBYNzqBHiw=;
        b=PsggIQVMp5IbC2KQ767ANmnkcmclZNfSCQ63d7iOIgLEHep9Qc2cbUpjMoJ+nAA/vs
         8G60nkxklLybCA6hv5SRr4yTkgUnIQ3W4LLJhFfV3FIN/yWF7seYjlr9oCZkZu4tJWkc
         u1/HThTvV46Aq1D9c4ngAbIw7kdNeVXRSPY1Z7dW0NQt019+AZZtKs2+QaJh2KK9txVS
         SQzo4PYOS8SOoj9FsKt80AizZFQGNijk1FlW7g4nYM4HO1MmV7eF5aXAkZUWtpl3MQla
         OdJOidWpb8ZRPAl4kB+l+d6zo6nyMuDELL9XRLL7J0DucvHI+S1tEyS1ai3qdhP6xoQv
         8dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927037; x=1781531837;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QZwl1Yn9MoZg35gakkX81ZZXe4u4EcmIxBYNzqBHiw=;
        b=EQOgS967whwoVRO/6HR4WHkX1PMfpnrCf9aVUS65xnUgON19QLxSk1ee4rqune+3HU
         sig/w+gdPBWs6GldSaFxog/Rd/3DNzQRXH+KiFeprn2SN9FGLawlgswJjhkZQ9whLMfS
         RAaRuaTFBY1q/rAU6FP/ATdX8nyb1g5D9YJ/KxiOJOclEe4UVbTqjVP7p90eYIymHm3A
         Stth4b9p+AQvbNi2SCkJU9l1sW47Nezg/weLiOf2b4y0GZFTl2Lmgx+IPayEU2OJBjrO
         FwTsV709g60CT8gBh+Bvp2VoSTTHOjpvAXjca1UkDKqhPXt1NZzefP3c79KAnJaNEDmX
         Ysfw==
X-Forwarded-Encrypted: i=1; AFNElJ/AGQSazliLejvrN5pv5aTM19Bcv71w4M6IQg8FOpZHNnmmcUlzQrOXniX6VwFalB2L1Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7qzWSuYQtqId2fI/ZAQEJ5lrk6TlrusNLmD2gp2zcy15UvuWs
	EzKny8GoGdjL6xu+F4wIspCrgZV4aX9xhSLl7X5q9ZOAe1NyZLMquhnSCnTNWpa+4TXTnnXR4Mw
	YW1TdGh6MZM1SQHKhWh///9bA+nRD41bX43aqZcVU2sP+dr36+BbPIA==
X-Gm-Gg: Acq92OHWLugOYe/N0l9BjeroXvNOAyKdBkjn9QQqe+VBgW2nuKUmcZrMIXbWrbAtDHY
	Iw8m72C3QEy6gmBY2BWciUwWNFt6o75XQjMMHctf7iFLuHmJozVttwfekADVPGLi5ZmFWZAoL8N
	sIOS91tFl7f2lvuwG2MngETqfjmrPaiQWCf5Gx2SGwE8CI31ZcKBUDpdxzrwp5KWT9prFg3GxyH
	nhC8RAckY6QVpb6lStlQUOxs7/3RP0c5XlOkdi7u5RgFxn06QNmCxc9X/FkWWnVVUj6pvEp+0kQ
	FORfifTIielR8qYBqTzqYhoXU4MthmfTfhz+EmVWSqBja45oI40lpr1B9dEsOVjNJRKRrNiInel
	FnWy4J/XiRATTFDLZhYLPPrIu/xSAGg==
X-Received: by 2002:a05:600c:620c:b0:490:b28d:a6f9 with SMTP id 5b1f17b1804b1-490c256f1f1mr258398405e9.8.1780927037303;
        Mon, 08 Jun 2026 06:57:17 -0700 (PDT)
X-Received: by 2002:a05:600c:620c:b0:490:b28d:a6f9 with SMTP id 5b1f17b1804b1-490c256f1f1mr258398055e9.8.1780927036954;
        Mon, 08 Jun 2026 06:57:16 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm40542835f8f.10.2026.06.08.06.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 06:57:16 -0700 (PDT)
Message-ID: <0c95c25f-1400-4912-befc-c5b32968d9ab@redhat.com>
Date: Mon, 8 Jun 2026 15:57:15 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests RFC PATCH 1/6] powerpc: add pmu tests
From: Thomas Huth <thuth@redhat.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-2-rathc@linux.ibm.com>
 <b7aa2c73-be32-47e2-8452-e626845f4d3e@redhat.com>
Content-Language: en-US
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
In-Reply-To: <b7aa2c73-be32-47e2-8452-e626845f4d3e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/06/2026 14.45, Thomas Huth wrote:
> On 02/06/2026 08.48, Chinmay Rath wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>>
>> Add some initial PMU testing.
>>
>> - PMC5/6 tests
>> - PMAE / PMI test
>> - BHRB basic tests
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> ---
>>   lib/powerpc/asm/processor.h |   2 +
>>   lib/powerpc/asm/reg.h       |   9 +
>>   lib/powerpc/asm/setup.h     |   1 +
>>   lib/powerpc/setup.c         |  20 ++
>>   powerpc/Makefile.common     |   3 +-
>>   powerpc/pmu.c               | 567 ++++++++++++++++++++++++++++++++++++
>>   powerpc/unittests.cfg       |   3 +
>>   7 files changed, 604 insertions(+), 1 deletion(-)
>>   create mode 100644 powerpc/pmu.c
> 
>   Hi Chinmay,
> 
> the problem with Clang on Travis [*] still seems to persist:
> 
>   https://app.travis-ci.com/github/huth/kvm-unit-tests/jobs/639614142
> 
> Could you please have a look?
> 
>   Thanks,
>    Thomas
> 
> 
> [*] This already happened with Nicolas' last version:
> 
>   https://www.spinics.net/lists/kvm/msg351218.html

I managed to get access to a ppc64 machine. The error is:

/tmp/pmu-eab466.s: Assembler messages:
/tmp/pmu-eab466.s:1649: Error: unrecognized opcode: `ldat'
clang: error: assembler command failed with exit code 1 (use -v to see 
invocation)
make: *** [<builtin>: powerpc/pmu.o] Error 1

  HTH,
   Thomas

