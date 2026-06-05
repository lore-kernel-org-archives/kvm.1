Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175872701CF
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616003; cv=none; b=NHC3+N8An9XxZVbfgJqIQ8GMD6CLlPqGQzsrdPdk5YOumA7ukBSzZUyIAOJrPnWHnJL5XT51DAx1nnEzK4TMw0cCK6t5tFDx5SSbX7h4sJKORsrV196NyDtd45JfE/a+5+en++ZpM5Oyn5MbaBT6py0s19e9omjgGrGCFp22ZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616003; c=relaxed/simple;
	bh=Lb+xLGteN8rGNFfXJPGYAlrX4zLjvvSOH8R+LOVRa9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT2WDekeHji3yONIhOIG3HQrb7nIK7PmMU6fVW1TxtEtHM1DPB7JsTD4tp6dDInkWYD7M1KJxwIXxav16eiDh7LjJP0zNkV2gXn2RQewbIUPw23tKf2RhKsV1mqenZx9twGLXYskzcSgvS8PfWlZaAKaSI08ZyOGjQcTsmA5PVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc7CO9e/; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc7CO9e/"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8583b8fd89so786058a12.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 16:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780616001; x=1781220801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGFlwyuNaR2/Raijzn5hJY/deT6FrQc+hecXmcS90Nw=;
        b=Wc7CO9e/1SVK/5UNc/UMJQQXwXKmIl1vdT8lkXps89RnnRKVLa8uUmXcU+CCljUSeZ
         iXj7nsWrdoiXLd4EbMObF4D0oEIXkv43lP1tHT8bEPlb61JdfqWW048iGhEAbwqCGGOy
         x26LUUlFQRwKUkwX8uVySXgRiC1r7nyfZpbdoFQpXtLGCyXfdG5eWxhRGgaJdkeXbKaP
         23u6OVCjSlzSTVFLtxWM0SIRN1RHcYopbDiH3rAfgk/6CQAtmBy/p/Ur21naCJxddy0G
         4nVnGBUjs/XJy1KjqmXYIYWGpQrLkB+l3vjuQ4gjIP1SvL/G6cQiBPzSha02F7yuZ5cD
         2ANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780616001; x=1781220801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGFlwyuNaR2/Raijzn5hJY/deT6FrQc+hecXmcS90Nw=;
        b=niyzfky1Tn8atsCs+sG8fUhElR6W8Y5J8Xz+ca+STNttOKp4ee7Td3tnHM4kDiAnFL
         ir1Wp/gmXBUjHZhxnOZnud+XIvVHCsy923CZ5e6AWtBC4uiSSeO/rnyDasI7bNyp4fND
         VZsSlNVEae5snTzn0fUKJCwio1L87KnhkO2dLDMi2UmTlzLqb39UHC9Zd1Xv77NfFfFu
         0OeklP3CEcpnRFC0iQtJ+sxeRoL8UYWMq/ywostA8HDDlozx1/sabFEJ8HfqNyeFFdd2
         cA5aP3YSw+/ugMZsNOZFb8Nn4VlgdbMhdSPMXQPOlZ3OOyMvx+Rpb9jO5Dg00KrxdW71
         m3jQ==
X-Forwarded-Encrypted: i=1; AFNElJ8p/O/Ut+y3GSnEnOLRoiFR6R70CxkCvpsw/bKQSbEfWAyQnkO7jt5wSX7DN+LxfFflc0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwusABKJq3MjAOjur+kzxV289Ln60qk/cbcVGLKjkhyXfmYNBtW
	4iGOFJsI2vWYvBeekNMZNIL/Ib/ZTA5HH0se8F3w+F+ho/WhIYf06jSr
X-Gm-Gg: Acq92OGaOMUnlQUg2fxcX8Amw+GZFyolhryd3LfcJUu5X71Y2A8TOOI0rFNAjvLwv9m
	NucTIMyRUyGdWEAS7Vx8+Yyr5ZitK2OOw/ov1k3UqJUZpYW192Eh8zRh/Tr5OEVxh1A0BYMx2fA
	yjpkK05DsOyzlLW2wYJi8eXs7i6sXE5kwkd/teNKOsCrpuNtaaDCnlw+4MOCO91kaXQTwwgf92S
	Yd0VU7gFAMRYITFNAtJsAS1+bg9wvYMCX6W722G81EmZBNZEH8RcB8ZDB87jBz6Ucm7pvqP3/IF
	wgzNtqFl6Yy/F6rOMOd2M4yrNt4vhN17QoD72euu7UtZJRCWbXQvzwe1ui7R09RHsq84JnjO4Tl
	UNn+zus5eCD45SNMIaiczg6IO3CQbxStnA89sRuHhl81k99TwJ4T+WnbkJf0iGN1aRbJbDB2H9y
	igHYbdUA==
X-Received: by 2002:a05:6a21:9d4c:b0:398:89b6:1b41 with SMTP id adf61e73a8af0-3b4cd066bc8mr1219019637.32.1780616001275;
        Thu, 04 Jun 2026 16:33:21 -0700 (PDT)
Received: from localhost ([2a12:a305:4::305d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a505fsm6146958a12.20.2026.06.04.16.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:33:20 -0700 (PDT)
Date: Fri, 5 Jun 2026 07:32:42 -0400
From: Guodong Xu <docular.xu@gmail.com>
To: Qingwei Hu <qingwei.hu@bytedance.com>
Cc: Conor Dooley <conor@kernel.org>, sashiko-reviews@lists.linux.dev, 
	kvm@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 08/15] riscv: Add Zic64b to cpufeature and hwprobe
Message-ID: <a2o7tkslomyf43dcs4tultdmrzcjgvkjh736l7lqemasljhs2j@tyixe5krxw6z>
References: <20260603-rva23u64-hwprobe-v2-v3-8-5529a7b28384@gmail.com>
 <20260602232800.768311F00893@smtp.kernel.org>
 <CA+Ck9FbKRM0wjJMg1fQpdwmow8cf_zTfir7V6+T=CRxU+vomdg@mail.gmail.com>
 <20260604-rice-protegee-3a0b8e4cb609@spud>
 <u52q565xhv5s7gz3wbh4heplhbm4pv732s5kqvf4deiw6ceb4t@n4bnpzu5kabs>
 <6940420B-C9C3-4D60-AB7F-7FBC4B93D855@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6940420B-C9C3-4D60-AB7F-7FBC4B93D855@bytedance.com>

Hi, Qingwei

On 2026-06-05 00:43, Qingwei Hu wrote:
>
>
>> Ok, I get your point. Agree, Zic64b/Zicbom/cbop/cboz can be implemented
>> on each hart independently (at least spec doesn't say no). With this in
>> mind, the validation of Zic64b should be like this:
>>
>>    if ((riscv_cbom_block_size && riscv_cbom_block_size != 64) ||
>>       (riscv_cbop_block_size && riscv_cbop_block_size != 64) ||
>>       (riscv_cboz_block_size && riscv_cboz_block_size != 64))
>>    return -EINVAL;
>>
>> This will allow :
>> 1. A Zic64b hart with 0, 1, 2, or 3 CBO extension and block_size 64
>>   passes the validation.
>> 2. A Zic64b hart with CBO extensions but block_size is not 64
>>   fails the validation
>>
>> Thanks for the catch.
>>
>> I will fix that in v4.
>>
>> BR,
>> Guodong
>
>Hi Guodong,
>
>Thanks for working on this.
>
>This overlaps with my earlier Zic64b cpufeature patch[1].

Thanks, and you're right that your patch predates mine. Your validation
was also correct (at least resonate with what I planned to do in v4)
from the start.

>
>and Greg confirmed that Zic64b does not imply support for any CMO
>extensions[2]. It only has meaning for whichever CMO extensions are

I'll add a link to quote this in v4. Great info. Thanks for checking
with them.

>implemented.
>
>Since the Zic64b cpufeature support in this patch overlaps with my
>earlier patch, if you keep this work in your series and base it on that

Yes, I'd like to, and I prefer, take the your patch into this series, and
credit you properly. In this series, I also added dt-binding, documentation
and howprobe, and make it consumed by rva23u64 detection.

>patch, could you please put my sign-off credit for the Zic64b cpufeature part?
>
>For example:
>
>Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>

Yes, since your work came first, I'm happy for you to be the author of the
cpufeature patch, with me as Co-developed-by:

     From: Qingwei Hu <qingwei.hu@bytedance.com>
     ...
     ...
     Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
     Co-developed-by: Guodong Xu <docular.xu@gmail.com>
     Signed-off-by: Guodong Xu <docular.xu@gmail.com>

Let me know whether this works for you.

Thank you for pointing me to your existing patch.

BR,
Guodong

>
>[1] Link: https://lore.kernel.org/all/20260528141630.2741710-1-qingwei.hu@bytedance.com/
>[2] Link: https://lists.riscv.org/g/tech-unprivileged/topic/question_about_zic64b_and/119631059
>
>Best regards,
>Qingwei Hu
