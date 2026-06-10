Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4393EF0A6
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781091035; cv=none; b=SWUCOffttgEO9i0Vo0sJsXvRFP2JZ2CmPwlextl7i0GjPVbyGIV1ZQSBA5earJYsKOeTRsUWXBAC4RQJBgDKjjR9G9/xPLeE6NgLFomTdwA5uVTEHB85MQMKe2fHAIc3i9daAVAPRg/8uduJVF3+R3F7j0CPhP/oFsnC0CWBxI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781091035; c=relaxed/simple;
	bh=9Eb72UC3Ys6Unixoy/LVuiNpdPNzkXhuwGwUXjGK7+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzfNBNg6OQZxts4sZGcMDqvGXGA/T0oy8hWi+Cv/5tPYteQ8+zkHa8VYF3rg0QKvA0YJzzrncf2at7FnDYVSGOaBpzfdj7KrEcLJxo+Osuh6cInOaaiFZDTziG5vPX6BU5UzT5w5w9wOwvEB11YbzTNEl4lg4oMhx8hFETWsP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8dRl1rr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTD3VDiT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8dRl1rr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTD3VDiT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781091033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MPVV2GOg27Dpjw19ICOKPzJ1CeAqBEvzWs4C0sdUP/A=;
	b=S8dRl1rr4aa7gjlW0/hm6KdVDnv103FCJl1jY78mB64++Il42JGSQjTfPVDF98rLEjKkUw
	agU/1s93jW86Jh1QTIYkISSnWvmkAT3Jd+dHM3yHCSM0ZNZSBeEPPKIr2MeOD6NSO7Tbqz
	tPXgXh5HsoEREvqFR0r5roEJWe2aeNQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-jCqbtfW3NVCyD13969NeEg-1; Wed, 10 Jun 2026 07:30:31 -0400
X-MC-Unique: jCqbtfW3NVCyD13969NeEg-1
X-Mimecast-MFC-AGG-ID: jCqbtfW3NVCyD13969NeEg_1781091030
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef3aeeb41so4371705f8f.1
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 04:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781091030; x=1781695830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MPVV2GOg27Dpjw19ICOKPzJ1CeAqBEvzWs4C0sdUP/A=;
        b=CTD3VDiTtIb4gx/0HBpUWGdKeHgaOc2GFASRSLKBnLStofc4/PXGbJmkctRbQ2asVT
         iaIxrhgWa25gaeQIvIhoXoOcqi2JGPJtG0YTxquq4XZz4VZRE/fDaZuGE/JyztyN3FYl
         XCpoi/rX3DC1sfxT7GpeyFHDgKu3120yRDMJhv3pPdcUbd7FF9ZiUf/BkrtO7kXRHWC8
         vzaJwLmldpjmGGjrA5+tD3f8lOLM+QNh4I+3Vk8XiQh6sN96caCAVTGiE/KRHmZ/yg9c
         +o+Nob4PA5EUZyAuZczEj57vCSoQGnV0FQo7lLEx7K+7OIw2sikHjkP2IPWpo2YNKcYw
         4Wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781091030; x=1781695830;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPVV2GOg27Dpjw19ICOKPzJ1CeAqBEvzWs4C0sdUP/A=;
        b=P+0bF2V82qq6aOkVzav2L1yP4Ky3KpxbJjxHPyeJ8+wvHW0+GD0scI7jzoiWQhmha9
         dkw2AV5VuBzruMzWtB6LZCYddasNB90QTrAKLGONZ6dNLLkC0Xbxqoz+6loAv7lNAM4K
         HXJgNYsoNWXzccY+UD+jhcKXkvYFO/j0wNlEuWTHjo3XuZW47u/urBEf9VWNPTXEB0x/
         7eDkC8P76oeEpSgEMZpWD+aW1xo+GOMlwoTyYHr+pZRnMCFyPCXkOrGU9rqTlUXNcp7B
         fqScLnLlV4xu3NSE51cRMf0RFUIAM8F1eD7ldN/jEHl6tXtD2dk0uwQ7zhnNt6UQJwze
         2FTw==
X-Forwarded-Encrypted: i=1; AFNElJ/xC37SjrCWzHT+WYD254ffKiorVZ6oejrcJQSCyeznlETclxX5GNUZtVemIuHm4htPLeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUH+w6SWZVGYNALixvwm8ghaq7YFoCJ3DJo8r6aTJ1GqkZBtqE
	OEgrd+WCvlWba/N89CD/74FqfY4+eSyl53O8Oed1fkQVRu1rKMOueNUKYMDE4FSFxBO213OGskL
	5GHBvk5/qZRswbN+HuCLIuXdmUNAh/IkA0KWnKIYuYk/rFpDb+CzAhA==
X-Gm-Gg: Acq92OHAlHIi9JvtD/gJxJTn2pnIiodJrV+9jQ7Bl2FpsjxkYzWkNcDDoG/05BORSBh
	5LUXACjxXGUDoyPkQOrh72WqzUI+EjLQt3uLSsbjnuhMQ5iOFKv5hSVkF8y5l6rLC9omhfg51VP
	W/T5O1W4UYFDQ9M2eynfnEAOJzdpbMvJrQiUI0tSCjX6vfDgNBHjXwtZPTr9EoJDLeNxFj7Gh72
	A4JKNHZh9VSl2LzBCdxQkTrv4aQxFinLuBoQhhkSHRpSZmM3Ii/TiliMCxgIyDGBHI2lleDXqz+
	U6apd1aKNiU8h+WYfPc635fnhBlFBKJOQJ9OCXjZD71ce5phRaaPDAitPPJqfQhTKXbvKLkN+1Y
	RdaITDq5mCWRzytrYUcvUV6fSYqIBVg==
X-Received: by 2002:adf:e00c:0:10b0:45e:ea46:3346 with SMTP id ffacd0b85a97d-460304f0a0bmr25751361f8f.6.1781091030328;
        Wed, 10 Jun 2026 04:30:30 -0700 (PDT)
X-Received: by 2002:adf:e00c:0:10b0:45e:ea46:3346 with SMTP id ffacd0b85a97d-460304f0a0bmr25751317f8f.6.1781091029954;
        Wed, 10 Jun 2026 04:30:29 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.132])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm77961462f8f.5.2026.06.10.04.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 04:30:28 -0700 (PDT)
Message-ID: <7d9e6365-1b2d-4b18-8fb5-d8048fddb7f0@redhat.com>
Date: Wed, 10 Jun 2026 13:30:26 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests RFC PATCH 2/6] configure: Make arch_libdir a
 first-class entity
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-3-rathc@linux.ibm.com>
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
In-Reply-To: <20260602064806.3101025-3-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2026 08.48, Chinmay Rath wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> arch_libdir was brought in to improve the heuristic determination of
> the lib/ directory based on arch and testdir names, but it did not
> entirely clean that mess up.
> 
> Remove the arch_libdir->arch->testdir heuristic and just require
> everybody sets arch_libdir correctly. Fail if the lib/arch or
> lib/arch/asm directories can not be found.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   Makefile  |  2 +-
>   configure | 20 ++++++++++++--------
>   2 files changed, 13 insertions(+), 9 deletions(-)

FYI, this patch seems to trigger yet another issue with Clang (I used v21):

clang -no-integrated-as -std=gnu99 -ffreestanding -O2 -msoft-float 
-mno-altivec  -I /root/kvm-unit-tests/lib -I /root/kvm-unit-tests/lib/libfdt 
-I lib -Wa,-mregnames -fverbose-asm -S -o lib/powerpc/asm-offsets.s 
lib/powerpc/asm-offsets.c
lib/powerpc/asm-offsets.c:10:10: error: 'asm/smp.h' file not found with 
<angled> include; use
       "quotes" instead
    10 | #include <asm/smp.h>
       |          ^~~~~~~~~~~
       |          "asm/smp.h"
In file included from lib/powerpc/asm-offsets.c:10:
lib/powerpc/asm/smp.h:5:10: fatal error: 'asm/processor.h' file not found
     5 | #include <asm/processor.h>
       |          ^~~~~~~~~~~~~~~~~
2 errors generated.

Could you please have a look?

  Thanks,
   Thomas

