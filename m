Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6A23C4F3
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922719; cv=none; b=IWtRYv58hgQ4LZve0ibxiyeOjQwtKQ8aYo0p7qa2rjdQ7ELmFtEGqWs2MQaNBf6k1+UHaGBJp9B4HBLDsB2JSrSy76+QsXI4Hcci3wrXhbl66Vb8yzzX+pBKb8Zxn2mUhMjBUOFGxDyqNtwdiwdiBb6psm9ngt5HZa/6l+ZYhus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922719; c=relaxed/simple;
	bh=42qVtwWKcjvteBcYswE8CJYNa8605hjoVwQzGeK/4TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvvF3cI3PJB3bNmOkGEC7+LZFVunOgg3/DfwUhvygB7STznRBoCG1I7q99AyiXVaJ8/QGQ8ZE9JDHJOPij0e6ibXZtlDNWt/vofidw7EN5XeDsSWA/AWoTLZLjlO89t+xC/NtOck9t+kXpnJj8gdUQUdd5qvT9WnLpaoCTFTvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWO3+cBX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mjqam+D3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWO3+cBX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mjqam+D3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780922716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OBX5ZjVJ9Vt5icolNqsYRF5h5TyAgyLBE7tpU2Ey3us=;
	b=jWO3+cBX7U4xGjrR3+YRdcKxkxtPtIhsFj9NtC77KW4Q9xFq8R0dQx65jYaet0OrnXQ/sE
	7VZdDPuJKMQ5HMxm/g7Im4ZsiHvmzCANIRY4Io0HQWVP6HUvAgweeXimZeazwTLt4SFtcM
	0kyew7RW7lb/gPibtZu0i4JBDMnx5eE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-rB9iN32HOsS0HjOW34t8SQ-1; Mon, 08 Jun 2026 08:45:14 -0400
X-MC-Unique: rB9iN32HOsS0HjOW34t8SQ-1
X-Mimecast-MFC-AGG-ID: rB9iN32HOsS0HjOW34t8SQ_1780922713
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-460153ce644so3108613f8f.0
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 05:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780922713; x=1781527513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OBX5ZjVJ9Vt5icolNqsYRF5h5TyAgyLBE7tpU2Ey3us=;
        b=Mjqam+D343wJgy+utEDaCynxFIp/Dq3b2xHgygne517PaEQ0E16G82gcxnVwIpVjKo
         DYfxaUq93g94zT1b4ec0oxsfJNDs7mWyIF6ZQ5Zu+CJFo2qPlE2euDgj7tZ5iGUif+hA
         Y4s5dGQcuXORNUpAqBV6Vh4j/YfbdcjASPoM8m1W7l9KlwI6xH0pBgbYjfU09vDd/pFh
         OacPdYfYUIq4KFvWXTO76TFBPed31c5FblJiuQl4BDMb9CbAjzRyAZUX3pwEC55yjO08
         A/jW2rqAOueGYnwrBgRBjY1k+WLOpvuKNq6723UJ24K002BKKsoqrLyZbzJDcNPhFOE3
         jzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780922713; x=1781527513;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBX5ZjVJ9Vt5icolNqsYRF5h5TyAgyLBE7tpU2Ey3us=;
        b=Kku1PBFCt1K3z4BYlRop/TUcSseXhPHaDKPy8ofCrRCWSr69caO3pT3IQZZ+lq/rx1
         ZFSKTHqaDnNqKj8Fb5dJmhWR+owLg7PjnykFcfnJeadpNvX6gN2hXlZM80TC+lQ7+qkS
         e589BazDXYipcY1mGn0WnSyWyagsdJXQFV+NDq+TF+klz4oUW6WGzyq5b15W/Tz29oiS
         iNGUHLVx5NTImcZO5hzy15XDw9i7MbuoHnd9n959gE4w73Zd3DxhEkwF5BopnEsRkkpu
         Aqr9C2N9UWt9WY9DWn9bfg25pA0ghgG7tSEpEFChpu4bO2rmdQxwvEAJmvQdAXAzHuDb
         fFfw==
X-Forwarded-Encrypted: i=1; AFNElJ9WVd70j5VGtVmELOCKc3HDcDF3CmDoNfJ2SDsQRMS2EuSPBoriDARbJrmdLav3LwgE9h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqzPn9rAKVnhm5OmHHHCVZss9NrVk54J8jQVzszop+bxfK+iZk
	9ksbOmvfLK2EgGkLrj4LUKpB9mwORtuWqAOsHNH0+1+FnnkdjL0SVB3Nw5ff3TlLA9mFxaBwBSh
	rmR8Kh3p4KaRmoVISMnzsNtDv2RIKpZekJpqheM++KfZkZNDVnucERg==
X-Gm-Gg: Acq92OGZyjjlyuT+qIR2At3FjhyydiP7H0VjFrL3oaHf8xyMiR/dtN4OTpqXFtYoNcm
	6hTr+it9rX76M3VVVJ/K1jT2bnZviVhkjUXy0qFSFloj7CIueVvPQwSbOo+oZmxohyjohV0sl8a
	dQAiIbEJFCt2b0xLm5lASgfbU6hmjVhenKM8HxpBvDJu4OAWJpT8KfvS4TYvfYI5ptbMcDaviVJ
	JTer6P/K323rD25KWwvtPie3GdmPyP5dxaStAIGOYX+GnCDKKsdG/AzzN96B66fSZhiDtFGQvPn
	aun3dXX0oFaG6TnOj+/TYL3kPOI84wGkMC/HJAqvBxWtF7U/mEY+kTalZONN+5k1z+bRnTQaZl6
	cDn9RLsA6LHlOOMcO5iJ/tSk/O6JxPg==
X-Received: by 2002:a5d:5049:0:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-4603063cf3fmr17162356f8f.37.1780922712940;
        Mon, 08 Jun 2026 05:45:12 -0700 (PDT)
X-Received: by 2002:a5d:5049:0:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-4603063cf3fmr17162311f8f.37.1780922712460;
        Mon, 08 Jun 2026 05:45:12 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm53768450f8f.13.2026.06.08.05.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 05:45:11 -0700 (PDT)
Message-ID: <b7aa2c73-be32-47e2-8452-e626845f4d3e@redhat.com>
Date: Mon, 8 Jun 2026 14:45:10 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests RFC PATCH 1/6] powerpc: add pmu tests
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-2-rathc@linux.ibm.com>
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
In-Reply-To: <20260602064806.3101025-2-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2026 08.48, Chinmay Rath wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Add some initial PMU testing.
> 
> - PMC5/6 tests
> - PMAE / PMI test
> - BHRB basic tests
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   lib/powerpc/asm/processor.h |   2 +
>   lib/powerpc/asm/reg.h       |   9 +
>   lib/powerpc/asm/setup.h     |   1 +
>   lib/powerpc/setup.c         |  20 ++
>   powerpc/Makefile.common     |   3 +-
>   powerpc/pmu.c               | 567 ++++++++++++++++++++++++++++++++++++
>   powerpc/unittests.cfg       |   3 +
>   7 files changed, 604 insertions(+), 1 deletion(-)
>   create mode 100644 powerpc/pmu.c

  Hi Chinmay,

the problem with Clang on Travis [*] still seems to persist:

  https://app.travis-ci.com/github/huth/kvm-unit-tests/jobs/639614142

Could you please have a look?

  Thanks,
   Thomas


[*] This already happened with Nicolas' last version:

  https://www.spinics.net/lists/kvm/msg351218.html

