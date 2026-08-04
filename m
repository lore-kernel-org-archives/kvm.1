Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0263446D2CF
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857997; cv=pass; b=uLCa+dgQC0IorWS5VF0czSgwHwzC9xg4Jwz6aQUCkt6fjkN2sDEwvmybzlg8T7VT/UgsRU5LCUdUlWWLN+0197AXvKcSYtZ4W8DcyKqP5jmHzA6zxhWOBojbTKwbhUfv2a4MBh8gHbyAyn1GPAtDy15fF3iU+phRynHlx4qRdyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857997; c=relaxed/simple;
	bh=3oWNFp8mlmM3sK5SQC2KqwSAdHvsMlVK7v6l4lJqdEI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=medlp+EwpC3HZMumH6S5CDvNM0ldUoODYfLuXcOdftbOZwrOKm7oxtgMDxlj2w4a1WLpPZQ+2P60RWfdFMfZBdKPs0Es2uVPJK7tn16qPm9n7z74l7+QIJNMKYEtQJPTmWVg/hyBVjW38Q7k22usQ7LJ6w1aN9UhpEorbBNTTEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8Kqbe+8; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8Kqbe+8"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e7109321dso2857973a91.3
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 08:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785857989; cv=none;
        d=google.com; s=arc-20260327;
        b=G7ezFP2hpvpP0y9wW0L6E5mmc7GCrB/BxbEnrAhM6TDaFxF0tkE2MjsM/UABtX8Dal
         QSPXF+g8z8fSzKkQW3holqQi1XoPhyCkmps74OKHl+bO+nERLvl761H11udYPx0X6nKM
         QJDi3et9XgtKouvuY6hMxYdoDyQLjJG28YLsnefrQlMY6hcvMSfQ3ibeoSu68RdYWDcp
         qJHN7J8IqWwTDX5kZiFhBBLMMKYO2yHkUUtIHqM+WPIZ9oOsztQSNTvYCY3zaXOcfybe
         099CmcVgmXwaTgC0UcHh3VOWB56ytnhJ1icS8WGrGscvrODKD0Xnqxof2DTjRk6Hr+hZ
         JwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=CroU6+PYSvOtV4uy1av7nC/Q1rK5iyolsTF+JTm0nJU=;
        fh=lfeD6oXUOXUqKKEWq9uCpbJFP4c25yo5X3bpr7EwmIQ=;
        b=Qk0jonrbBkzfHulkmg/npTGn0UhqnVLD2LyM+jhTjSEQNQXFagX6jlLUTNWvTNPccc
         g53owkN55DN5Tfu32RdTYSY1kS61vmHDgnR9VF8e2yMEypfRJ0aSB+flI2w5/sSQaCeQ
         HTUmg592xzEFRqb6JtJ/Vrl8uuaAt6RtVPrgPEZ4niT2Y7TSQLSzfK2OROpAKpNwR7J7
         YxOTFlUi+EAnDlkV0jCJoMZc0M6NBWlWkTDN2ZhQlxk/BmF4Kf60WuM+iRm0DvVaAjDx
         4NdNrZCcTIwkvcJRneznmICtU5swlA1VlvSVnaZZFE+jC6I2liF6yMTwYA/1FkFO535h
         h9LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785857989; x=1786462789; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CroU6+PYSvOtV4uy1av7nC/Q1rK5iyolsTF+JTm0nJU=;
        b=u8Kqbe+8NUGx9yefTwTAvANAItwU6yEEGFtaF1wptzb3NCfl/HzgNPdrrKzF+QZPyO
         qR2u7GnHAczFSGMxmu6RTivLrLESjLA6OcOIxReAP9at23zOfbu276qpd5NXebYcqTHA
         5N8K/OoH4gPX6399D+5ml7KSo3wNwYoSnMp/TiyNx1wFTWwJjIDfZUmJLvmOiqvMoXaq
         PV7jv6yblCt43N8A0QooLDkpvyGjlDlm4fFsN1RXKiXEpq8PzBqPKZHZ+22AjIlEmXOF
         FMh1HQ4kc6jxGPgaZJqsu/nRxDxYvTkJUY9S6qVhyXd3fjEH+qC+jhzuO6k67htlAucv
         cH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785857989; x=1786462789;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CroU6+PYSvOtV4uy1av7nC/Q1rK5iyolsTF+JTm0nJU=;
        b=X6BWUr6wl6+pLZwX9brEcymly/JucyTbF1Pt+nP2QYZZ8HbTUOns8ZGTgkD7CeuF33
         t/FPYBaEuPe96LN0IRMvA8Qam6EqKhDBUCpGPQsV3qynqsHr9dbgGkk4VPqWSy5yi5Cs
         7utmWHj7CRMaGQuIVmWqMMSrFcquwFJK8TJO0EzPHvqvNuY7WhNmv3s2jjqMdYhZFpis
         FaQOw4fQaRGNO5kL77KBIpwsEUFEYp1wJomxyMMK90ZVostToW1eXp8Z8hwksZpXCIss
         V2T040vy+NWS/aMTQwEixsEzNdX0PacdMECU3xpMNY4nwy48tctli1zsYkGoUvcm2toA
         7ubw==
X-Gm-Message-State: AOJu0YwcLIKbNDjCFN8r97Ka4FNkI2V+7asUl9IOHb0HkQyZCGby5qK7
	FSgQJ2GMOrAbZEiDq9wt0IXiTnua8AdtaW7jCdU2srPGIx5d2/axxsIGtZvnxpV1RjC60oT7+ZU
	PMXqxqSxj/9LtcYI82eLyDqdBY/GD/hklHcr42Wcm
X-Gm-Gg: AR+sD134PyZdRxrV3rXklyWxsc+SrqEFeCjex+JrZyF7h3Udp69fRyoGBjx/3xdPMmS
	/6+M5LH6yW+MgNY4r/iwcbOsHLxI9TtcfYYYggASlA3qvvOiUFViDGD4fthZT4gi+HRS+lSfZNW
	TE4M1ygYiNSaOahdla+2TDLW8rHVaPzpPCoTn2ZdBRcuXwf7+QbpzqQkRqKkwcoYF47Ow0Vd63w
	r+J/opA7H2YltK28mGF7ljg2rbxDthkmLfobkV2D+O4Ir1RRWcfSIxqBTRf+O1L5oPwQ55iDwcY
	vEKsCrg/btTc37PvKSoc5IrS7In29oRTwqvlFR3HRSL5/UagpX/quqYkuecTNnv66kVdW/cnEP3
	1LDQ/QGG8V3o=
X-Received: by 2002:a17:90b:1c8e:b0:38f:1a80:d1e7 with SMTP id
 98e67ed59e1d1-3903c596de7mr90484a91.13.1785857988201; Tue, 04 Aug 2026
 08:39:48 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Aug 2026 08:39:47 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Aug 2026 08:39:47 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <7f23d149-b7f0-465a-a9c0-5c7484e289d2@intel.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-20-35f9aec2aed2@google.com> <7f23d149-b7f0-465a-a9c0-5c7484e289d2@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Aug 2026 08:39:47 -0700
X-Gm-Features: AUfX_my5tJzuKxcHX_DSDai20MF8F8MLGyTCXlBPRZTIfOOy8MGvwUJsA-dI9HA
Message-ID: <CAEvNRgErZqaLPpBveBd2VxdrS_8mjMbArL_=AhzMdikXmUU5VA@mail.gmail.com>
Subject: Re: [PATCH v9 20/41] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
To: Xiaoyao Li <xiaoyao.li@intel.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
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
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

>
> [...snip...]
>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index ea2752989f8bd..df67a6188aa99 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -1137,10 +1137,12 @@ static bool kvm_range_is_private(struct file *file, pgoff_t index,
>>   {
>>   	struct inode *inode = file_inode(file);
>>
>> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>>   	if (!gmem_in_place_conversion)
>>   		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
>>   							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
>>   							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
>> +#endif
>>
>>   	return kvm_gmem_range_has_attributes(inode, index, nr_pages,
>>   					     KVM_MEMORY_ATTRIBUTE_PRIVATE);
>
> With my suggestion[1] on patch 7, this diff block can be dropped.
>
> [1]
> https://lore.kernel.org/all/dd4201f2-3660-46ad-958f-c70feb1ab1c3@intel.com/
>
> The code looks good to me,
>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>

I think your earlier suggestion on only defining the module_param when
CONFIG_KVM_VM_MEMORY_ATTRIBUTES is selected still applies, since it
removes an avenue for a user to turn off gmem_in_place_conversion if
the other option (VM memory attributes) isn't available.

  +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
  +module_param(gmem_in_place_conversion, bool, 0444);
  +#endif

Given that we're now dropping the diff block as you suggested, do you
agree that we should keep this #ifdef?

>>
>> [...snip...]
>>
