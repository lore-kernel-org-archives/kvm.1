Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF276396B98
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085174; cv=none; b=uCMAR4OpYYScYgRcCGq9nxAGGWWbQuGcrJF0zlVL8oKTZtLKu3YYM0cUMQhIxDS7+7J5Uo3pV5X77HzVHxHavehbx4dLy+hNcxDuKsH6vOwGoGkFQ7snjS8aPYwtP/rmyhdlVE/jnIBaR+lCFqwwYkIXkV7ZWHMPvGQQrnQXT+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085174; c=relaxed/simple;
	bh=EnX5oClrPscfOuKTv2mK98kRhbb5/8/RjmipllU9v30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPRYchjmKzRxkL5SJcDV8avU0QVnG/ckqOZguzEro+HzTCMf/N18Oqe7SQciOqaICMTvI2eLr0zXOtCOR7b8LyEVV2cegZE53qbK/eXMlOVaXLfHvVjd9U7uWOs7CDSn8f13vh+rmzOSKUFO80fZnYVA0SdlcjzPYQanlxnjR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fFd6Ku3J; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fFd6Ku3J"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49558ce01afso21613275e9.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 23:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786085171; x=1786689971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bZwcS+8CNqVvNQJbXmjcjxW1uPv4P7RYpvJQy5BKBq4=;
        b=fFd6Ku3JOmHhVW5DX515n5tIHvJkHzTm8hBQpT7QZhoMAplZsIdsCzuLbFLwoffUGL
         /4ExDX0P2eFLuiwW2+RB26pSkf7s/Tpr+FvFFegqKCDdkVOor4x0tWhpOJixm83t/03d
         3O2npYnuh6jgiQ2hy482pIeHJUDgjtw3INXKim+F1hk0lgX537lDBGVY3QsbBHr+CnaH
         unt3IwBKa2q5QEWHuPxp7cIoiMQOlnPraJLKbyNZ7SXX9XDYKmlAznnh2ayXJIRNpgBa
         +zUvZDDxyVoS2Gkbfubk8BvAnxn0YaE2lIy1wFoVUZ7fc6rdDmeNzbgATw+BAmhxcYqr
         sATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786085171; x=1786689971;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bZwcS+8CNqVvNQJbXmjcjxW1uPv4P7RYpvJQy5BKBq4=;
        b=GuNurVJaATGEsUW8rLhoOzHSmqJ+OUSFsi/Topqdv7I2FfSI8CiMDnSYfcgPk0TSrr
         8Rn059fiLd7vBWORRXyTbGC6ap8UKlTSME8e5Vbudxu7iRnUNLGWWl7eWVjiOPmzRIyU
         yNT452sH4SyJ5Dumf/cgfSKQUzC9cRFX0GMKNVy5HJtfPAS6Mgh2XOmOGzBsiBb1Yt4u
         Aezo1fMPK3Nz4ahPgoXb2jI3CL08S6ui6blXInx+YOIlhgNAJwELhkN0QDVXApVlqhYI
         2YpqQ0D6n1X3roI3vomE0sGDW/kKPuWRcKjiJMj21mLyWmWCCB3mI83MxViXEQsAWvnW
         aWeQ==
X-Forwarded-Encrypted: i=1; AHgh+Roxj7vq55d1oMqIAfr83rLfH2vfO5gjTjipgOjJWUnHiZK3L8B17C7k5e+Leod4lyLzsNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1X7B0c52UyYu26ZCkX6WayPYQKTs4+LpcgJcHhLXQIAZHLccP
	iE+HS+ErlNFYfCAHkxO5YfpauC4osl80Rv7+c30PtFbmqFaVULyGKWOVyAVAUFGpX/k=
X-Gm-Gg: AR+sD12Vn1yWmkux84LbVdsr35nnzoGW4q7uC33rGRdGZh8Nn1EAbiCEdltd2Jp09VV
	d+XI0nt9B+5EjTp47eThTCtPbbHjHLvgE+tRQ/Xiwq9OTK/ScqjM+7xDLtiKhDZBKWnGTNkqE0/
	xy8MvKDbo7eARDAd3iQEOlbEbuea9pjcN+2q1qsGo9Vzkg1L/bxXpTSmlwH1VBIEXxQQ2h6OtAm
	Cfk769zJmfdZLQtBWB7yOZ2TvwgENikR5l9tA7pucxpO0ucbe38N305DCAtEbs/0KHpsp8UMQdN
	guRBJPVNZSRnTictYjvPDGdZIyN79JfohVA8F4DrP1XhsJBX+z9TbofErO0YGz5VsNtmMhpk8oG
	NLB8yd3wfXUiuzCjTAYkal1jeEgiCCGR0DW3XmOnqokwKKlxxfaw3mhSacOdm5M7JA3RHMmdgNE
	UE7HJIP+gVGMQc4eL4MVXJomT+tNgy4Jgihdf3gOj2k66TuW2Km1TJkbnfd7vYvw==
X-Received: by 2002:a05:600c:3b9b:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-4994e7ba85fmr260641755e9.9.1786085170923;
        Thu, 06 Aug 2026 23:46:10 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.206.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995422016fsm98416035e9.8.2026.08.06.23.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 23:46:10 -0700 (PDT)
Message-ID: <f2bc9f23-391d-47d1-b52e-c71d05f927af@suse.com>
Date: Fri, 7 Aug 2026 09:46:07 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: TDX: Enable Notify VM exit
To: Sean Christopherson <seanjc@google.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
 "kas@kernel.org" <kas@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "tglx@kernel.org" <tglx@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Chang Seok Bae <chang.seok.bae@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
 <20260805031257.1844914-2-xiaoyao.li@intel.com>
 <82482276-0140-4d90-a983-fdfc5bc2e4a5@suse.com> <anSRCBhWi2BK9kYB@google.com>
 <5ab71720460d268e3336e521209c796ca04b0012.camel@intel.com>
 <anUngktlwsNI6oUM@google.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <anUngktlwsNI6oUM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/7/26 03:32, Sean Christopherson wrote:
> On Fri, Aug 07, 2026, Rick P Edgecombe wrote:
>> On Thu, 2026-08-06 at 06:50 -0700, Sean Christopherson wrote:
>>>> It should be instruction timeout (as is in the SDM). Please reword the
>>>> changelog to refer to the name of the features as they are in the SDM. I.e
>>>> if you search for NOTIFY_VMEXIT or NOTIFY_WINDOW absolutely nothing can be
>>>> found in the SDM.  The changelog should ideally mention both - SDM's
>>>> nomenclature and linux's nomenclature.
>>>
>>> No, let's change Linux's nomenclature before merging this, "Notify" was always
>>> vague and confusing.  It's unfortunate that we let that bleed into uAPI
>>> headers, but we can simply #define aliases (or just force userspace to update
>>> as well, if they use kernel headers directly).
>>
>> Hmm, ok. We were trying to go with a minimal backport friendly fix.
>>
>> Xiaoyao, if we are going to carve it up, I guess we might as well do the
>> consolidation of the exit handlers too on this version. (a cleanup patch that
>> got left off of this).
> 
> Oh, I missed that this was tagged for stable@.  Do the mass rename on top.  To
> address Nikolay's concerns, I think a brief blurb at the end calling out that
> KVM currently uses old terminology would suffice.  E.g.
> 
>    Note, KVM uses "pre-production" terminology for the feature formally called
>    Notify VM-Exit.  All public versions of the SDM refer to the feature as
>    Instruction Timeout.  This will be remedied in the near future, for now,
>    use KVM's terminology for consistency.

That's better, at least it gives pointers what to look for in the SDM.
