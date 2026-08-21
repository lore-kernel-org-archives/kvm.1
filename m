Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C784A2E2D
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320925; cv=none; b=l2rhUbczh3hptmFf4N+o1G+CreMyKCZeWg3YoE880/Xb7TMNHB3qe5XgUhaSoT/SKGRMX5y1j7SqmJDdhhi3meEW6997WitQQuq2CGvwocjphCILheBA2DVf1Awvylvgd1psiRPPW5G8hdej6sPZuWlp3ZldVbIhJ2B1JJy90XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320925; c=relaxed/simple;
	bh=w/VwBDo9UPwUkAEyzce0Vi/QMwtEtK0I0XlnqIp4S9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUyURI7z6/wdnMy9x3GNx79cYPRE7Y4kRTjd5W11Hm6yMFJZcSTZka3RXTtthg8EjK2ErXlO4CUIctujkmFW2tbChv1739jcATtL6uIWMhS7iUDlfaPUvqYu8Lpm22whH+NqwAyu9jkgiduhLKogmz8Sn4XE0zMYPM/t5OxBhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNG9uLgr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNG9uLgr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-495437bb891so5461785e9.1
        for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 07:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320921; x=1787925721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nQd8YnirXzo/05vCBWaK5j7dOswPV7dn2KgbQ3nhodY=;
        b=mNG9uLgryHsnsf9twvifd8wbGuqV5Uy6Bsy3G6bFpmQb5TNVtD1Ld4th9iwN4VF4ye
         PIXjmEXNoRb44HxXWc3WsVxpICy0BKRHWbImGWfxC+WJVRUbZhdsPJPRarazJSBQXPfF
         fEMKu0S1O693HtUybQ4OW6PGVkLDjKXlXY00Khu7BALM3wdhE1KOm84SAM459QWrfBqB
         XCty1Dfm7TubjZU60e8Wx3DJ8/FaHXcr/MHZIOaWWl3liy/M6OhNcXIFvP2GVp3Wiyg6
         nxt7AEztZJoOqfglCutIVIV7B1NS4RmvzfjJXxryEZ85D7b6b+RtAbK/iefNYu4OmtZm
         /ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320921; x=1787925721;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nQd8YnirXzo/05vCBWaK5j7dOswPV7dn2KgbQ3nhodY=;
        b=WoRdKMVIwpLJQiSIiDUZWZjrSh7pk3Lu0sBAIx3vce8Tb1KmfVjpu4gH1nzm1Toc9c
         VBbThC+PcrU4KEsLcIR86vch0vdpNuLnLoRCdkfjFZPDFGCCzCCgngINi+rmsbgqiQDV
         /KHSZEzF3m6NdiG9+KMR8zkBxEfTSzyBsuXq4FGLtPdHFvOeDed+gyqD7fN+lVRnWri3
         HGo4Y/3FZW2bPn/gO7LhvbvZJD1oQiEdzp+5BUrWwWRDkQ1+1SYS7PwC9/fouCNykcr1
         khaUaqTtOAvELTDRVxpf46sgDpsJAUnJK5L4M4PTb8xVVaHKT5keUH1cB/Woy4Ru+AQn
         2tXA==
X-Forwarded-Encrypted: i=1; AHgh+Rrjc1MLFmxvlef8+Z7NnWsO4JHVx/3+XbJD/uy0wfnlVbGz8EkUUYkHZstyXK/3kkpYrCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB1/pUX6fB2QwBltn6MnxPXCUF+XHqq6W0rXWvD81ridUup8ud
	xEshTTZl+n566+tmVSQ0cxxrl3NoAv515tdYS9idsunFHgYQArlbx7Z/
X-Gm-Gg: AR+sD11BU5brIoj7DS+bI1zHIjrtuNuf/AJ/uipWgi83wFrpCpFx4G7Ji/nHT+2kUEu
	HeFlXG58MIIYUfwHeJjab7VUORzajJGnlUgf+eoh4JhJZ5K6Zs/CqRFknAjX9wQ3dXNqTPjXo5j
	miPCL49bEMtSPQUVSMweat1Q0D7gWN2IZRTkTQTWqV7/9td+G+xNksluOBog/ifnTHykSJzLawx
	ncHpTUzwHsBjhnZGR2EOeJzuhS1lYUaz05K2zpRwV3Jfv4d/a5hvFFi6Hsp/6fDt/SNNqgyewVG
	/wyqaUQhPHSLiNqKw6d5wVQ1L2Ervt2ZEA5kmXwR7rb2U+VmyQBt/2IOv26RQun/qz6eV9pjuQI
	biGF07m4L+1wIqJ9If8yvBjHQbZArdgCNRGx+EJMmmGUa9WrXlBC9GIyrzK52R1gBmHlUNEXx4s
	Nuzc0a5rjkE1m29mg6f+CypZtdrAqTYrZ8aPRaYyChnHoE0i/uXeZUusr0GScewt3wzYHOuodi4
	One
X-Received: by 2002:a05:600c:1912:b0:499:8d9b:832c with SMTP id 5b1f17b1804b1-499b9182141mr59968525e9.4.1787320921200;
        Fri, 21 Aug 2026 07:02:01 -0700 (PDT)
Received: from [10.45.28.226] ([15.248.3.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b90f8b4fsm34103715e9.9.2026.08.21.07.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 07:02:00 -0700 (PDT)
Message-ID: <6270fea8-aa08-48ca-ab1e-ab0ada105ded@gmail.com>
Date: Fri, 21 Aug 2026 15:01:58 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] KVM: arm64: Add pre_fault_memory implementation
To: Vincent Donnefort <vdonnefort@google.com>
Cc: maz@kernel.org, oupton@kernel.org, pbonzini@redhat.com,
 joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
 shuah@kernel.org, corbet@lwn.net, vladimir.murzin@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 isaku.yamahata@intel.com, Jack Thomson <jackabt@amazon.com>
References: <20260612162354.73378-1-jackabt.amazon@gmail.com>
 <20260612162354.73378-3-jackabt.amazon@gmail.com>
 <amc8zlGxegNKHxIY@google.com>
Content-Language: en-US
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <amc8zlGxegNKHxIY@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 27/07/2026 12:11 pm, Vincent Donnefort wrote:
>> +	unsigned long		*page_size;
> 
> It looks a bit odd in that struct.
> 
> Also, transparent_hugepage_adjust() modifies pfn and gfn. So perhaps it'd be
> better to introduce a struct kvm_s2_fault_mapping that can be used to get what
> has actually been mapped in kvm_s2_fault_map()?
> 

Yeah that's much nicer I'll do that thanks for the suggestion!

>> +	if (vcpu_is_protected(vcpu))
>> +		return -EOPNOTSUPP;
> 
> It could just call pkvm_mem_abort() when the VM is protected?
> 

I see, I don't have a setup to test this properly myself, so at the
moment I left the protected vm's out and don't advertise the capability,
if there's a usecase happy to look at it as a follow-up.

>> +	/*
>> +	 * pKVM stage-2 mappings aren't directly walkable from the host; let
>> +	 * the fault path handle both new and existing mappings.
>> +	 */
> 
> pKVM has a host interval-tree where we keep track of what has been mapped and at
> what level. This tree is also protected with the mmu_lock.
> 

Thanks, that sounds better. I'll have a look at moving to that for v6 then.

-- 
Thanks,
Jack
