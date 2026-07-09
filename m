Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33AF33121E
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610185; cv=none; b=aKg2V6goSCOtMidBB9ik6YD7hNc/oqrBnp/Ur3AyXkk878G4dSMxxgUqXInykQyUYwC35cVrXB7Emj/oTmaQH2P9Bk/FSKr6OmWgh2W2joFsK7SQIQ7/XoyAXx38c7Z5l5cdSn0TTujAwdSZmlKW74cO/zvtZ10ohd15hndC5GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610185; c=relaxed/simple;
	bh=Ij1xwwVUlAfw+3HYVsYCC9jsLBWz/8SIGy82QiPKdaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwZBmUUuU7jKQBzUehD8RsSUYGp3q9vU1ao9FsOlMiS6UuGkb5oAojyJUT5iY65olqk/c1l+Q44QkDL/He1kVDY4AmILgQUGmXKFicdH52b6Z+ALib2oFOyLBB7qMOjNavtvHI34U9wUnYQXLDeVj32NOVnDYhjrQ+uKE9LO+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0toPmIB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8g44ABF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0toPmIB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8g44ABF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783610182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ndeL40kSceba8UVL/FXky/NF5sW3lHJDX0WAUxiIYCo=;
	b=e0toPmIB1Bc/1Am/M+O1Nq5tlHasabT1z/aBtXqIt17jElbYWsjc/VnZfOIluXHf6gaGaF
	7RPk/TxDCLgrohHU8lqJFYHgaJWVNHghcRntTPeagwzFrjwc6/RQCPnGRUNY3/Ofg8012l
	N+N8f9yuOQz8MMfk8UaXj5S0LTDWP7U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-NhrbLxg4NDmlheU379I-Rw-1; Thu, 09 Jul 2026 11:16:20 -0400
X-MC-Unique: NhrbLxg4NDmlheU379I-Rw-1
X-Mimecast-MFC-AGG-ID: NhrbLxg4NDmlheU379I-Rw_1783610179
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-698c181a258so1260279a12.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 08:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783610179; x=1784214979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndeL40kSceba8UVL/FXky/NF5sW3lHJDX0WAUxiIYCo=;
        b=D8g44ABFyhieXtftrMMewUrqquUpC763XP8TLLKT37OOQl6CMT7p30eGcS5vdTFHH6
         2AMBWK7Tvcd84Hq9R8FdnQ3W+nIjC39E7tqJsyeArFO586G+0JG1wqhVsUamdVCroM+t
         e0xhFvPZkGZhPAa4w1gPi/bphjMaVaJuKaQmYpyS/YMPZuTfFLDQXeYIs53ctye2OH77
         sUkudCkiYniYC4IkNgudXfc8jsoOFE+NovIIIT9wzF7OnLfWU44jYAP9gkCwfQtqbE4R
         hnYry8KP8Qiwfsc3rxv6LOJrsfW4IOWWc8kC6GGK91+YwvwRbDAnbOpVpz9lAlR/RlB/
         gY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610179; x=1784214979;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndeL40kSceba8UVL/FXky/NF5sW3lHJDX0WAUxiIYCo=;
        b=XgJfr9rLojxE9cXT4aP5YRyGdJu2YA+BRjvd2i+IA9t5SQ2p0ZK6p/T+waRoBiL16x
         YHwYJD6umaxCcjrYQNTQXE6fbeJ5fCDUFrc+HrXE0K85woimxDHJ1iDrVZPeSh0FhbUX
         wLqjwdqWC2CTeVuH/wzq5ESFG+eCRZe8p8rPninewXChc5tmAHO4bMYlirIz26FlHoGD
         hZiuD5Eo2DYC4CvRuJG6Vrka8gxqvEejejAG9nRBVauI7HEd8vLJ9HvrvZhBQDdumzCW
         OU+1BX1YToiEpD9MOlurbmIZyAHRXrVIZIqbEvka+PRrLuHE1sSCs28xVR23FxwJTGVr
         IYiA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+cUO8pls4xXWxPuhho1/2Mp4VPIk5lWmIpOKnViZnkIydQMheDn7pz9EMOYcE/OWBJao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92JCRlC/NJZzKszlrxMn+EyQPD/KFdBPv0CVjHNdxnBu2kKeM
	kJIrYxS/Kb1ircCgryPxgX+dqyfJnUoYCqHmWV5PDR4TcyUlitOP62SP9e5o84EMvapvU1HpreD
	NysNywW/vRLge1kojBz9kHPuOm7PRCr3t0ezoa+V6qaK3tZ1IQXGdyg==
X-Gm-Gg: AfdE7cmUAEyL/HM3VXRfcIX88b3VhVmCIbeVMeOAKamkZSA0MbY6t/IGJF1k0I00/hW
	nRgpzDZK86AMlJAp254NIj35VPztsj8XJzhVo1QK4SPUcMexrwCY/2vkb/CvMvPhcCzyBNjefL9
	hbx3O78c8+paTnOzm6KLtB9kAMXAmhboLPfP6v2jAwUjU7FEBSPBMtMz8w/wcbm6pHlVNIy6yvo
	lU+Dy7hnZ81NJ9rK6mvmZZUt5Ljvw5VkErRR852EpIMGVRcL9nQpgFSdpT4Tj0UtgCCZiKTWzye
	Hf77I4LyaDbYFvUREbJ7qBdHD6Hp8s6fdznULvdiytj/RGMqe90SbmLdY4EWyxaEhWyFLHy/kPu
	sO5NRUdKy
X-Received: by 2002:a05:6402:5d3:b0:698:1973:1daa with SMTP id 4fb4d7f45d1cf-69ab4488cf6mr3022660a12.18.1783610179198;
        Thu, 09 Jul 2026 08:16:19 -0700 (PDT)
X-Received: by 2002:a05:6402:5d3:b0:698:1973:1daa with SMTP id 4fb4d7f45d1cf-69ab4488cf6mr3022632a12.18.1783610178610;
        Thu, 09 Jul 2026 08:16:18 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19ce4b4fsm9498949a12.10.2026.07.09.08.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 08:16:17 -0700 (PDT)
Message-ID: <73573868-2fb9-445d-b5c6-02166a0feb25@redhat.com>
Date: Thu, 9 Jul 2026 17:16:15 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 4/6] powerpc: gitlab CI update
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, andrew.jones@linux.dev, sbhat@linux.ibm.com,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20260708105122.1177210-1-rathc@linux.ibm.com>
 <20260708105122.1177210-5-rathc@linux.ibm.com>
 <bd10e435-de06-4b67-962c-b520a43a8280@redhat.com>
 <8c9b739c-8a9b-4e9a-8e43-7b1a6e1aa330@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <8c9b739c-8a9b-4e9a-8e43-7b1a6e1aa330@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/07/2026 16.32, Harsh Prateek Bora wrote:
> + folks who might be interested.
> 
> Hi Thomas,
> 
> On 09/07/26 12:16 pm, Thomas Huth wrote:
>>> +++ b/powerpc/unittests.cfg
>>> @@ -24,6 +24,14 @@ file = selftest-migration.elf
>>>   machine = pseries
>>>   groups = selftest migration
>>> +# make a kvm-only version for CI for now
>>> +# TCG accel support with Qemu and distro release used in gitlab CI needs 
>>> to checked.
>>> +[selftest-migration-ci]
>>> +file = selftest-migration.elf
>>> +machine = pseries
>>> +groups = nodefault selftest migration
>>> +accel = kvm
>>
>> This does not make sense (or I don't understand it) - gitlab-CI currently 
>> only runs with TCG for the ppc64 jobs, so adding a separate test for this 
>> with "accel = kvm" just adds a job there that will always be skipped. What 
>> should this be good for?
> 
> I understand it may get skipped in gitlab CI for kvm-unit-tests,
> but it might be helpful to those who can run it on their Power HW.
> If the job can safely skip on non-ppc HW, I hope it's fine?
> We would like to get it integrated in IBM's internal CI with Power HW.
You mean you also use a gitlab instance internally within IBM? ... otherwise 
it does not make sense to add this to the .gitlab-ci.yml file (which you did 
earlier in this patch).

  Thomas

