Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6226436EA8D
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882045; cv=pass; b=kUIAC1aZqQ4T2yA1bzrKl/btvvXWokOE6EDKYetvhO0LRazOzJXtSNcm2pgQzqlNMh3pxkJTxKRo/gTIUJYXgTSH1EFE0ZspOELXamBvx1x99z/0ib3zgGh2rOEWyGxxX5E8f0WNVMU2A1koTjHTFIK7+9558B0GTpnEyTW1O6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882045; c=relaxed/simple;
	bh=p7KpLXDbYWu/mxWpOCbWD2NL3j0JpP9nFMeNwakGxKM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnMalbasbkR+WJCwmtAZ+g34wEs0lB6hrWG2lvVnJCvW5GvWf1Fk9TLm0dCFu6pMPX0ifWMtZGm5Vr8+kySygzHnL2LefyLxdxUbW1B7OsaNmPf/ECjOdJFHI38uj1aCFCpdczFGqLTnKeXwri/lhj1LtSIDHseuf30qKPlybro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0w7KDnZ; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0w7KDnZ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e041ea211so379655a91.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 15:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785882044; cv=none;
        d=google.com; s=arc-20260327;
        b=kRwtQOksex0Vx4MY8VVICu9c7ZbI1icsbN5NbXQnpZjj2fV1AHV+ma4jYn+RxMA3NP
         VPe71J4DE3JZSpdvJZjHfLezi2JksQqWCIp7qsIn4SzLg0z0bTuXpQm01nNLJyVIgOoT
         TzwX0sJ6ePSad9otr2xv1YvJ+iGXfkrZfGLFPnk5T53bQAADmYqeETVKPfKXxv1+ViQr
         +hzLlH6z8SdKIo4wyjoIzJVT4Ft+TD7vQFZebbeGwIqrFGtoitL7pNQOYnDrUuCzImnh
         nAjnEAS/60t3YmiWjWEbK9q2f/KVFRUbA8ZHNlv2gJB4xsBP9qkySKl2le5UCtWxTw6F
         nMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=voJFtdOcDQ3cvv3g0Px6B4YkGP5JAhQ6QCPfp6/emQc=;
        fh=YxflZLIDyesZ0GA8g+OLJTghmiCwJlkznfOwkS51pOI=;
        b=MY3uo1XfsIqjzlhaljkVFLKN5GU/o+MlTHpfx6r8rqd592YfftrxjpNlWuYRtfrQiq
         RwTiL2u8Zvhn9LmUbbQSz1VWVuuE43BVV99QbkVrBxnQ1fqB/ei7cUsWfOptpODnoQ+2
         7pmBl7fYmOfuAbubv6eDFAHetqxzWitajMxHaNPXV42rVfMZSQF8UBW8cbV1/bzGHmpT
         QWpya8K02vQVW/eejaejinwO4a9FYb3Ev6sTp1gx3z0DF8Ueo76GZIm51xWX0GsQRyFE
         fUQdZyUiYmAC7Rkqw40x6qtUUDlhHtWbWww2Y76BdSqz5Fy+7wQCOlIL893StFMLTTxP
         dteg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785882044; x=1786486844; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=voJFtdOcDQ3cvv3g0Px6B4YkGP5JAhQ6QCPfp6/emQc=;
        b=T0w7KDnZr3jDS7HeDOIQ5foupHOVXSXTAbw+qAcmdFnD7uhWOR01G5pZ2TwfG02OR3
         GoCokpW/JmEvbbp+dh5ZQCJH4MXtA0H2Vv3j9sltRAxZQFk5qayZKtUVUqO+eBv1P5Pb
         Ya3sTRX+5ZrDXdtx3Z9jyWNq0DNk/bjVz1LaghtuPH+1dQanY6ZCDSVLl4wsviU2oeEe
         KN3Td1pPk/Zw9ArFGFbgbYPFB1Mikp1LQN/U3qoVsnz8x3/rXJOp62ZcMOLbAb7Hn6//
         q6lNvxPchY4EdvWRcTtON+8IRphlZHj43TZ7bADEKrF4RqlddHJxwclXT4FNGrogCWud
         n4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785882044; x=1786486844;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=voJFtdOcDQ3cvv3g0Px6B4YkGP5JAhQ6QCPfp6/emQc=;
        b=k/0EnVB2QdLbHipsmDD06k1XHFYy7skxA4ZAvmLpjr7dC3wGd/4xSxLQz1nurvk1Qc
         z5hz6EEPFIAHExX2WafwCdhbQy+WjEap3esmIz5pUm0o/Ky+DKuH+Twfcu1gb4swqjSz
         5keN7FQ7VzdGL3E5vVX5rl0AbCogAmv/m/tTwlx1eBDV0YsGiaXqoPdmsUkj+2hLr+s8
         V8BA9+l9qqU5ahZECuPopMnr4hy7AG1QXiCaCLihpK5AT9hdwOyIrXeUvRG34FftYuTh
         j18sQUx7s5tDeNlTO0BWVIQfZ9S3WFtGVw65hBrQhE4t9Cw99wfDgHut7ucuDjgaFDDM
         hYsQ==
X-Forwarded-Encrypted: i=1; AHgh+RofjbDoeYDD7XauKhexEoJ5YEtkRXlxKovpmz3fnv2RSyZGG6R4HZlLHwCgVk1WpQ+cmJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+8C5jZg+RPF6KsyD2SrvkNkw4dhfoxYBnUHk2c5olFtsnpqc
	2TaJDwbqrQT3TWbYfcNhNGrSHnpIsqDZk+sc2dvNOfn0u/gxr2Ygc1Eg1WQTugDxc5ihU/ou/d4
	LYk/xuRu37OrmWaQaZii40nfI8JfrLPuyPs28uLPR
X-Gm-Gg: AR+sD12EPUL7oGKSEHQ0JBol5hBG38OWADnaxGHcoIvKp+L68PYmjquh4jpP2/1qyyP
	TGccGgPASixWVe7ehKT1ExLKqnbseYRZC5n3dQqrQeRRgUL1I5LwBmO6tS0GhPY1xeiP+bzKXnP
	rmn+ta5tCpgbGv30jjWAIQgIygFu5wHysTxk77jF8kHgEBUb1jcfhLj1oeunHWtpR71ySMiBlRR
	jWZHU+1vWShMWGpU/usdyGDEymmm2+BNpAVuBL4dWNSlzRI4HN3tSCRN1xACtx2Ex89n7jr0D0k
	HFwFqD4/DNiANS3ezvO7b7Kmjf04ciBtUPQGIH8nlnlBtNcQXDGTum3a6ovYPjs1EVzxf1A+ol0
	zWVb7rN4vUS4xbVxHa+/C95ozS7MdzfsHNaBEnBxu0m4P
X-Received: by 2002:a17:90b:270e:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-3903bb0cf61mr2065807a91.0.1785882042841; Tue, 04 Aug 2026
 15:20:42 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Aug 2026 15:20:41 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Aug 2026 15:20:41 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <de780cc3-8c43-46f8-b8e6-3ddfe93d753d@arm.com>
References: <4460e252-b6de-4df3-bea8-0368a9d0f4ff@kernel.org>
 <CAEvNRgEUQSju2tW_1zMk2=QmveZNtmkjjCZdqVBgBD2JPh0k4Q@mail.gmail.com>
 <a823e3d2-8acf-49d9-a812-ac1bb2136d7f@kernel.org> <edc3566b-370c-41a0-a71d-2e4a0e1a94f7@kernel.org>
 <CAEvNRgEas_9BEV-cNxXu4_wQx8sR2M4_OaW6DEd4=fszALMV0w@mail.gmail.com>
 <60552bee-3326-4917-b00f-5fb7ba3b8adb@kernel.org> <be77c2cb-6e41-4382-9d2f-cd299f634196@kernel.org>
 <anCtzQrUkFSSq8De@google.com> <99037993-ee13-4160-8c87-b6642faea554@kernel.org>
 <CAEvNRgHYhKACDfx9ZZy4a-TTS4yWzEJt=Jc92=eXxS15LPnTYg@mail.gmail.com>
 <anJbMf5GBe0Pxh_x@google.com> <de780cc3-8c43-46f8-b8e6-3ddfe93d753d@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Aug 2026 15:20:41 -0700
X-Gm-Features: AUfX_mzkFKRHTDQOiQvLQ1e0yQheZQmYXCL22A9YUJawwpQUjT54D9_OoZJNsuw
Message-ID: <CAEvNRgEOE5oeFVRYYucsCGJaFAQYS1oNRXAwGKzRAyqmoHT9OQ@mail.gmail.com>
Subject: Re: [PATCH v9 14/41] mm: swap: Introduce lru_add_drain_progressive()
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Sean Christopherson <seanjc@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "hughd@google.com" <hughd@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

> On 04/08/2026 22:35, Sean Christopherson wrote:
>> On Tue, Aug 04, 2026, Ackerley Tng wrote:
>>> "David Hildenbrand (Arm)" <david@kernel.org> writes:
>>>> Andrew wants to give it some more time in -next, so I'm expecting it to
>>>> land for 7.3.
>>>>
>>>>> 7.2 or 7.3, then I would strongly prefer to base v10 on linux-next (where
>>>>> the fix will presumably land soonish), and target 7.4 for in-place
>>>>> conversion. Then v10 can be applied against an early 7.3-rcN and we don't
>>>>> need to juggle branches (assuming Andrew is ok taking the proposed patch
>>>>> through the KVM tree).
>>>>
>>>> Agreed. We'd also have to get the actual preparation patch into 7.3. I can
>>>> send it out and coordinate with Andrew.
>>>>
>>>
>>> Thank you!
>>>
>>> When we were discussing this earlier at guest_memfd biweekly, before
>>> deciding to refactor out a function like lru_cache_drain_for_folio(), we
>>> did say that the likelihood of actually draining in practice is low,
>>> especially on a machine with heavy load making allocations all the time.
>>>
>>> I think the threads with Xiaoyao have resolved, I can put v10 out
>>> tomorrow. Would it be okay to go with the following from v8, and then
>>> clean up later when lru_cache_drain_for_folio() is available?
>>
>> No.
>>
>>> I'm hoping not to push this back by a full cycle to 7.4,
>>
>> Sorry, but we've missed 7.3, irrespective of the lru_cache_drain_for_folio() fix.
>> Even if v10 is perfect, applying tomorrow means it will get ~3 business days in
>> linux-next before I send pull requests to Paolo.  That's just not enough soak
>> time for land a 40+ patch series, even if half of those patches are selftests.
>>
>>> and also hold back other series dependent on this one.
>>
>> Eh, I don't think there will be meaningful impact in practice.  If v10 is good
>> to go, I'll get it applied on 7.3-r1, and will also get an early pull request
>> over to Paolo (probably around 7.3-rc4).  I.e. folks can start posting against
>> the landed series shortly after rc1, and I'll have a set-in-stone base on which
>> to apply more stuff around rc4/rc5.
>
> For the record, Arm CCA KVM support depends on this series and that
> being a big series (around 40+ patches), it is an inconvenience for the
> Maintainers to make an effort to review the series.  That said,  we are
> happy with the way this is progressing and next cycle merge for this
> series would be perfect for us.
>

I saw the exchange on v16 of the ARM CCA series.

I'm going to make every effort for the conversions series to get into
7.3-rc1!!

Sean, for the two attachments you left, did you intend 0001 to be the
first patch in the conversions series, or separately handled? and 0002
will replace these 2 patches (in-place, in terms of order), right?

+ "KVM: guest_memfd: Introduce function to check GFN private/shared
  status"
+ "KVM: guest_memfd: Wire up core private/shared attribute interfaces"

>
>>
>> And if v10 has issues, then *not* rushing it into 7.3 will likely be the fastest
>> path forward.
>
> Absolutely !Like any work, if it is not ready to merge, it is not.
>
> Cheers
> Suzuki
