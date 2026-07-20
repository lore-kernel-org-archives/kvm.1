Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A83101A9
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539862; cv=none; b=hVDDQfbYuhp55UDleAd+dvTfa3N5SI1jwqiSgWmSEDqY9//P1rVOAKNq8WplYN1gTms3RIjBltwFunaAroJ4xF9UA9N2FCMXm9+wWHzIv/KBEuFbUjsMP0kQEz5qBY5axmtwJUIdEfeAaaVE7fyUqqKy726/bdgszTOH8MHmd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539862; c=relaxed/simple;
	bh=S4+K8XQOjCL190y00PiLar9Tm0otIO7Tq+X8wrwKPEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gg+BLfY+aYMzJVx9xyLshVhue4mHkzNPerBKzH6XtoNOfHTM5p0/P8GZmpoPuCDFEq9uxx5XIG54MROI+Zx+IL5SzaRTmi9t1heWxeITJj7J0DfgHq6TUMbTX4ELA+iLqXcSJOkCodZzXx9dabrxLK/cpni0S+3md+qcUpDklX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bheyz/fE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5uQbQZX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bheyz/fE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5uQbQZX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784539859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N8CxclYG5NULruRRAvMxBAfpyq68GFNT8X9UeD7miNQ=;
	b=bheyz/fE2JR1GoSsd5OHqyEnyhQBmbbMKxni961NeX5onpqig4dk8duh+TI/6y+nNITEtR
	6Lqv1HsTloU2C1WmFYb3IJFSPlACy/k7nzQv3vAd+ODARdJEQ9xvC2iUu1A7TdMHpuNMXl
	/OWZyf2PAABy3dX29lPMFxUI6CvT6uM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-EhSo_RspO26qSf-ED7eAJw-1; Mon, 20 Jul 2026 05:30:55 -0400
X-MC-Unique: EhSo_RspO26qSf-ED7eAJw-1
X-Mimecast-MFC-AGG-ID: EhSo_RspO26qSf-ED7eAJw_1784539855
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-474170b59dfso5796807f8f.3
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 02:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784539854; x=1785144654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N8CxclYG5NULruRRAvMxBAfpyq68GFNT8X9UeD7miNQ=;
        b=G5uQbQZXgBnlXXQk+LIxnKXvtJbm7hg7J+Elht2qN6VgrjRA8Pv5DAw3VorWQa50io
         7VUt9F/y1MQ3lIdAVdvwie0jbaP0GNHIktn/TUC/Yez0L+7z5Owi7R0bBNJ0DsftPJQm
         n3KUmRO8aezOes63aHKR4TpFh2PN9MAlqFYHaagTO0f4bI1XaZpZr1SLHTs/CqlPGXi0
         kbqBn/ev59Gbzs8npoud9Z+v+WYAxppnMqXBEcNHqyfFchwjNsxYCJjhXd42mM5srhFu
         AM3nuoLJuBjxH3Dp4HnbwJKaeXBkw+yZefrh3wRINQ62p6AI+8k5YKxA/iKoSXn6kF9Q
         gSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539854; x=1785144654;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N8CxclYG5NULruRRAvMxBAfpyq68GFNT8X9UeD7miNQ=;
        b=SSGgudG3ZYrU1S3LLEZ1myhWOSh6L551dDoP+ejL3fLd0LA31rDv8l3Ai6D9thzIQ+
         GK5+kgbspM/C7isZfqgztAEHv8rznEXePhVKrLChFAMG0meP0a61eROSyuCqRnqA4AiB
         gKqj1qkX8nZfEUvs01yQSeR8vnpLkwPKN1kbXIg/FkAsmSZl2yI6g5zc/Qe6BWWD35mp
         ZIZiup32VobfuVMI0kEWxqifN8MtXCjMwFUX+xThVEfpaqSIdMcNGAUbvBrOnPrAkoHl
         x5vU2BDxIkrKdA5P3z87M98hr2/lG1Z9fXaSH+c/MfAcJdMePTSrNJ3we+4Icw8LzO2e
         VhNg==
X-Forwarded-Encrypted: i=1; AHgh+RouNMnl34wpGwFdXThFbNpnaLORb1soSbTcrLkFCpJYhJANTgVTyMLUooS/0SawkBOskI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhUsMGxwTko8Eb4rWNVQHUYVUhDbMulx+mFpz5FDDJTSzT0jk
	EAF/qDipNNEKOWBzpcFqZulXmQQqowHfj3b11AE7xJ0UKgTuVL4F5hfwdXbki2XdE08o/QuMtEf
	AUxw+70bVf5+kWDKZ8jxZwo8BGn/JyNVdi6S4y1ytOxn/fwAsX+aapA==
X-Gm-Gg: AfdE7cn8C9lLwkHbvZqfuEkeXFl4WD1k3+fUx5WNybGBntfi52NNxl4GbPGvvx/WlBd
	eGVLNDnW0VTX3gemKJABoKYjgQhm76kWYqAmhzQzS3NXyEwh0sw5Fqw/ZPaTFGEPf+qc3DTJvmU
	wqKXB1vlwxIxSumtsp5RYqVW9VyOsO04pu5IGoG5NKeFGYyPdpdU4pKScnR+G3YSMWiuQ9gBAhN
	cEVkadxq2l6FrpJdP0vIFEFAZk97kobm1bcRX896bWVdBXTXfFJZDwE5BLcBIvNYDHEGXq6iAuF
	dFkYuCgO4K6B/dNBhHKkZe3oDqGKzkfv++nABu4mw+QEwGM7UMBATKten3YhuvqkUyxkIiR0XA=
	=
X-Received: by 2002:a5d:59c2:0:b0:47f:2baf:5e2b with SMTP id ffacd0b85a97d-47f623074e0mr18760938f8f.1.1784539854525;
        Mon, 20 Jul 2026 02:30:54 -0700 (PDT)
X-Received: by 2002:a5d:59c2:0:b0:47f:2baf:5e2b with SMTP id ffacd0b85a97d-47f623074e0mr18760883f8f.1.1784539854103;
        Mon, 20 Jul 2026 02:30:54 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ab8sm29860816f8f.5.2026.07.20.02.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 02:30:53 -0700 (PDT)
Message-ID: <c53b1c7e-ee9b-4c45-95c6-6648f696cf11@redhat.com>
Date: Mon, 20 Jul 2026 11:30:52 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 0/6] powerpc improvements
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260719130027.2347519-1-rathc@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
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
In-Reply-To: <20260719130027.2347519-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 15.00, Chinmay Rath wrote:
> This series aims to add a couple of new powerpc tests and improve the
> powerpc build structure.
> 
> This is originally Nick's work. The last version (v10) of which can be seen here :
> https://lore.kernel.org/linuxppc-dev/20240612052322.218726-1-npiggin@gmail.com/
> Couple of patches from the series are already merged.
> 
> Since it has been 2 years since this series was posted, I originally
> posted this as a RFC. This v1 series has changes accomodating the review comments
> received in the RFC :
> https://lore.kernel.org/kvm/20260602064806.3101025-1-rathc@linux.ibm.com/
> v1:
> https://lore.kernel.org/kvm/20260708105122.1177210-1-rathc@linux.ibm.com/
> 
> I have rebased the patches to the upstream state.
> For the patches which did not require any changes in the existing upstream code,
> I have retained the "Reviewed-by"s and "Acked-by" (patch 3,5 & 6) from
> Nick's series. I have also added Andrew's "Reviewed-by" received on
> patch 2 in the RFC. Nick had originally introduced powernv tests as well.
> Removed it for now since it was causing CI failure in the current upstream.
> 
> Link to Gitlab tree with patches :
> https://gitlab.com/rathc/kvm-unit-tests/-/tree/ppc64
> Link to Gitlab pipeline :
> https://gitlab.com/rathc/kvm-unit-tests/-/pipelines/2688519679
> 
> Change log from RFC to v1:
> 1. Patch 2: Added Andrew's "Reviewed-by".
> 2. Patch 4: Removed usage of gitlab-ci group to run test - Thomas
>     It would be nice to make use of the gitlab-ci group, but doing the
>     change of all archs would make sense in a separate series. I look
>     forward to doing that.
> 3. Patch 6: Removed addition of panic test in gitlab-ci group - Thomas
> 
> There was a discussion on the build failing in Travis CI with Clang, in the
> RFC, which I have addressed there.
> 
> Change log from v1 to v2:
> Patch 4: Addressed all comments by Thomas :
> 1. Removed extra blank line.
> 2. Removed accel=kvm test from gitlab-ci.
> 3. smp = 2 preserved in atmoics test.
Thanks, looks fine now, so I pushed it to the repository.

  Thomas

