Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA92377543
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684807; cv=pass; b=sLljFTGECxovT3XreJEEQNY0uRiunyDplCcGZCSF7dHQtXA9G0ppagJDloogaWskwBD5V6NIrhlZJoQiMTVp71g4zzTE96E9RnUt/x8a/1p4CnbOeYG13JleduOXRD7n5erjDDJAX0XEVT/b3sf2ldh2+6o6qrcXwEnNuKBNIUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684807; c=relaxed/simple;
	bh=ylp/WG2OsDo7VxpUtN0UDtDOBb9IQxlolEx2IztCpG8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0f6l94/Z6Wo5QGawgtxJqUAX/g2VY8H1hlfYZONQnRt+8+WyAqWjn5Tw/Omo7J96d9vmXVkU5pqhOWFiXA551SaqgtC+HbDYPKZbvoiFiSV+czR7N0sK4bL0iFmKuk/UP65m4+17O5/lrDJ+OO8da0iyoKYo0qWeXegQqsp70s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DlYreZfd; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DlYreZfd"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13808436ccdso1690624c88.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 11:40:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780684805; cv=none;
        d=google.com; s=arc-20240605;
        b=IYUs/NPMSK6PKf8aYIOULzyN4+rS3Qp74E/SIs6yA3HOYyI0wANV3Oip/xHeyQkAnM
         Gctqa4O7By1iZMOWjKX/vk4YMGavU2MX6pTya2y058r2xOSxWwNjEnJ/UcXAeSHFDarO
         TzX29DFt0Lys/dwbl1FrWs0O3AfXsyk70Hd26W8dlXVCrTYnMmL6zpX4FvOLKlTtBd2q
         e+vaMFE3ePb5H8Iy+hssPQLidAdmfZ4pIrokE+f/xNSMDWQstXQB/3R1YpN+l3jwInql
         BglvojKY2WU+sEG/mm2+UxjQC1//DbpAfNUdsmtCMg+F5ReTJdaWjm5NSYqpX0ni/k4s
         /rTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ylp/WG2OsDo7VxpUtN0UDtDOBb9IQxlolEx2IztCpG8=;
        fh=wNuIwZ0u8UrhOKkY508oUn8Si4UiZSfyZeByDB6xZkE=;
        b=Z4ImaeaFohjEJKwnCqLakO/yarKy9D6XFLkp15xXxU1lg4/7pyu6ZlCB/K7wNOvVIn
         +Ytzsa4yaWLfZssxG9L170ojPa8vvndRJgbdi3KqJVMq8xfi8C2ZN76iZoDdBOqmGJVO
         g1jKbmdHwiW7+QrDDuHaBTJlypaOZKub47jUzUEaQRRxsuCSMZJp2iwfaHFs0jc06um/
         vUbW1RgwbmYhZShvh3OB3Ps2hiI4xbBgY1KqaVmIzUOElxER7h+NDP9+6rb+z7/7jNpZ
         VkxsbKDdkcBDIfQrZNsYEA6we1QcTbNi7b8qFItmZeisNH0h5HnoTviEH39Iye4v2gUI
         M0yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780684805; x=1781289605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylp/WG2OsDo7VxpUtN0UDtDOBb9IQxlolEx2IztCpG8=;
        b=DlYreZfd7kDh8kRfWp1EUUqlPh2QIh5ug/Mrwx0YGjluAffqrgR+ZnqLS6FU+IuM62
         hIrq4GcudHGhWW8pPm1V3h8Cmn+0SHbnIJjeX1KbpcwVTzYfUrBBwQFYSeOgmH5eOcJF
         Yz8YS8o8hIUkt1PNHHV+xqp0dg/KmmS52iOiYxoxWE2bib34lF6lDRWLRahAnqukXPa2
         9ewNuiI+ZInScLV0vOFwFa2JFtquWwQ3r/mSG1qLtlmwz9qNDG4tJ+bAdLGVCIufLpfT
         dU062RN8qW5G95nVPWm7+ZJOiVdXmiWjta4utTZd3YxfMWtpgRLInzRCk2TZ1DKDDd7L
         DM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684805; x=1781289605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylp/WG2OsDo7VxpUtN0UDtDOBb9IQxlolEx2IztCpG8=;
        b=NF4xpTsUfmAmpTBabsoiCJu7z5kkcTgZIiLkeNg1F7V4jMb4zrfqw5CF7Y/lGHcr0N
         EvQ3Qi0dT+W4n8Ph8I3Qt38WjXQ4/uJlwCD/ltgw//hlRqn9jFxjz6ysdcfMIHPjbXhJ
         XJZ6GrPGrbmuo735w/9tMtuQUzAXilUjktpcfVxjra46f9u8ZzgUvM/LQ3abmvf2K22u
         UT9KJwMe3VKyGLVU6/2UGmkQSONVCnscWjaFVG5KYr9pHMXjVJlG1IKGbapudZfAK2yo
         wyFCidrGKvLJNVAPZkLT8ZxSSXoEAdBHBrp2y8BxCthIglZhR8bh3BYQlV+UOoKXe/6f
         5Xjw==
X-Forwarded-Encrypted: i=1; AFNElJ9nHvEjoGy8kr3SQtS8HYl+aM5vP0bGRXWJ54b4nGg8nSwEX20W0Ui6chk+kJQDtaKFc8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfoWUIZ/8rphLgOgpJz+ll5g88bC2VmZnyoTiWW/qsN+TeqlHg
	J6eYYVqUbdiP1JgKbtZsf3ebPvpm8M7W1eN8vYiUDa1rK2M0xjGE2mx2RE2VNN7GZCrWbut5FhL
	qa5OhK6O6P8tVqrDvM42lslCsz8haEOZg0XVQ32lvfKjeCQ1+dtXPa1+u8/0=
X-Gm-Gg: Acq92OFpppsOfTdt8nwwFv/3oD5GvUZcoZGzq+oRqBR5rBItj5fJxvmHMsCE+jgP2wK
	OtSMBV2o7jtmpBPqDFrp6d5dUGlVJnl3rhdcUzW0yfAO06FsVs6EVC+4qmfjP/KA64mR6ud5nbf
	mtjdo+Si2IbYrqoWp9+afr0C6NJZQNAvUbXGno7rvE3kIembJp440Feh4EyIyjYIRA8AT3oXMiC
	vhqp0ElEFLKdDUtkbk9XX3m3uVg3fIK+5XNp4kDEg2+D/ypkkkUs2DDZw+BDrYHl1Oe49rUKi2p
	IQT0XPzr8lF1OO6kcyJSHMg8+uiWpUukL372w8xWpEBDjHHA2FlK61UL6ktoeTTmvavP0UDw1n8
	kuTRr
X-Received: by 2002:a05:701b:2704:b0:135:e312:47a4 with SMTP id
 a92af1059eb24-138066874afmr1383213c88.9.1780684804398; Fri, 05 Jun 2026
 11:40:04 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 11:40:03 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 11:40:03 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <44o2z5j553adpapnyequmk2t6cukor2wjm5urujhrnqhufogh7@jbsolz5b4i2b>
References: <20260522-gmem-inplace-conversion-v7-21-2f0fae496530@google.com>
 <20260523010752.CA7AF1F000E9@smtp.kernel.org> <CAEvNRgEVC=fFuKVgZYvWyZD7t_zvUZihFG8hrACjvtkD5cwugw@mail.gmail.com>
 <vawib73p6wsjdihwz636soxorvp74v6zyqona2a2nnpuc673lt@jvlhihgqrs6t> <44o2z5j553adpapnyequmk2t6cukor2wjm5urujhrnqhufogh7@jbsolz5b4i2b>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 5 Jun 2026 11:40:03 -0700
X-Gm-Features: AVHnY4J1_4p8mu5YSy0mKWuQG8dcjs_GQ0Bde6jh1xabblqeid9ouo3IPdVn-Ck
Message-ID: <CAEvNRgFkfqirL6hZDk5eugeaf4u7J_=a0xj6RdE=QnG5T6N29A@mail.gmail.com>
Subject: Re: [PATCH v7 21/42] KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
To: Michael Roth <michael.roth@amd.com>
Cc: sashiko-reviews@lists.linux.dev, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Michael Roth <michael.roth@amd.com> writes:

>
> [...snip...]
>
>> > > When KVM_TDX_INIT_MEM_REGION is called with a NULL source_addr,
>> > > __kvm_gmem_populate() attempts an in-place conversion. If the target
>> > > guest_memfd folio is unpopulated, __kvm_gmem_get_pfn() allocates a new folio
>> > > using GFP_HIGHUSER, which lacks __GFP_ZERO.
>>
>> For in-place conversion, if src is NULL, it's generally because src *is*
>> the target and it makes no sense to copy the page to itself because
>> userspace already initialized it, which means userspace should have already
>> trigged the uptodate flag to be set via kvm_gmem_fault_user_mapping().
>>
>> So maybe to address the malicious case that Sashiko seems to be worried
>> about (where VMM purposely doesn't touch/init the memory to try to leak data
>> into the guest), we just need to error out if: !src && !folio_uptodate(folio)?
>
> Of course immediately after posting this I think of exceptional cases, like
> SEV-SNP can set up pre-zero'd private guest pages via this path, where
> userspace wouldn't necessarily have done any touching/init of the page
> in advance.
>

Are you referring to KVM_SEV_SNP_PAGE_TYPE_ZERO?

> BUT.... in that case it would be okay, because the kernel knows
> everything would get zero'd.
>
> So maybe the post-populate callbacks need to be the ones that would need
> to implement these checks, or some API to that gmem can do it on their
> behalf...
>
> So maybe your proposed patch is the more straightforward fix for now.
>

Is KVM_SEV_SNP_PAGE_TYPE_ZERO expected to be used for a large number
pages? If not, I think we can defer this to a future optimization, like
in snp_launch_update(), if KVM_SEV_SNP_PAGE_TYPE_ZERO, pass a flag
through to __kvm_gmem_get_pfn() to skip zeroing?

For all other page types, __kvm_gmem_get_pfn() MUST zero to avoid the
issue Sashiko pointed out, right?

Currently, kvm_gmem_fault_user_mapping() will zero, and then userspace
presumably writes the entire page. Can't avoid zeroing to avoid leaking
uninitialized memory.

To avoid that zeroing, I guess there's the future guest_memfd write()
syscall too, userspace can write() the entire page - write in the kernel
can avoid zeroing since it knows which parts of the page was written and
set uptodate. Then, kvm_gmem_fault_user_mapping() won't zero since the
page is uptodate, and populate will not zero since it was also uptodate.

> -Mike
>
>>
>> [...snip...]
>>
