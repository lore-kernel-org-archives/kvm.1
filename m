Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD463E5A0F
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335440; cv=pass; b=W3tZJk/N90vH5YBfIF0xU4ruH21si/JOGPbxVwGn35VMaP4XrUQkuSHZ1cd3u7J2cR3fi2vMd8ITEh9jAYWWSOL9elZaRvkMTDMCg7cYOdx0GvVbQG93GfeZUbST+jKGxI6rW7Eu8quofTgDBqo8HwFUktuGuqnfu/8EKWASp1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335440; c=relaxed/simple;
	bh=/fqLeUK+2mBqGvKbYmtjhS3yw4ZIMajZ90sW7dKC8MY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bj6n9jPLKGYRc70E9yqHZIsNJnsvTxggjEjoQaApPEOihUOxznNO1Kqp6KABB8UrQIYWmTqAUeH9aMmp1sWcNZGRdbr8s+osQrnxaFLkkCXft2ocyi+XXBXsX4Xs8s6G2brAmm4ar9sozDuuZF5GVs/1HYKBP7FIMPZWg8lVjw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gZrCJnRz; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZrCJnRz"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13809223fd4so1814844c88.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 14:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782335438; cv=none;
        d=google.com; s=arc-20240605;
        b=h7VSQQMqV5FeilfP7fC7H5pJyWBjEVWpC5TfMYSKGqA8MMrn3ay9njOQqtegjAr+k2
         6Ti+kEvTeLYAU4vcgyCwpW2fFc2NQF+vPjPRWoryfWUdt10sWcAOgl0+KqvQm/RppdIb
         EGaouh/SgwQV/di5uv5VelqgxmEHiLVHHyxO4uXglSEre6GmbbUVW0pKfx8uBK+e0L12
         scLYQufgDI0jjBgU3dP7hdtw0D8ppaDQtO0x9Ficklb1aIhHYZAB0PCK1WUEAfcQBYVy
         B546q8KydL3ftyPvS6FX1TR1yljq4eY4y1Ugk5wIVXJycFTyDZd4ntg2dwxQ84K/j4h6
         HrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=1qhY5YTt9otpZBdjhswjpjNDeK/pN32eIQWKDjhQOPw=;
        fh=rTWroj2rXdGB+XWmEMslmauo+AepA5Rh4Bmg2nPh7yU=;
        b=lYvyqnwEgWLAhvs8RoO6L8l42zeNEJqoS3bFT4nKPWXKynQHEFsP8yGN8c/UHypghz
         oQtRDd9t5pAld9rVXrXTvNVE1HhdjbmJ70j7EAY3EZl+zB2cK/jy98D7nK/UO4SmIGqQ
         wBFR2o/CjDxIq3OgK3bwZrbuLxXMgY29qpy0W6dR8oflWa4A0rv+Kv3aE9vS+beYppD2
         59hHadyEAg1gPaEjpo/CG2dcFN9vR+SCKERzaAyyEi4PzcxuGAG8A5/+ltWF2Z2/WSKB
         xtoc1TTAtDkBGbeE/zsSfmNOdMHa4YvOInChoFbqOdQZhM3sim6uCaB/VcBiBOxJc16X
         UM5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782335438; x=1782940238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1qhY5YTt9otpZBdjhswjpjNDeK/pN32eIQWKDjhQOPw=;
        b=gZrCJnRziYALESi+EyO4zrNEGpp7soNo5xePz6vITzszfo4F6y/KtcKGvcLpyKvZrd
         qtd0Q6THio+xAZ13GySQ7XR9xNuTXLNjTYxZHjxUD+jFV5qLjPimK8JsV5XtWPp+IAAE
         nueZGNVCzR76HQiXS9fWPEkZW+FEfophypqL9S0rY23Umgws0WYROaJTvJcYM9FMRvD0
         6v/Ue4mud2QRGPZtmqhpg5QOTD+bcStGRE/IYgeZ0R/CwpVQGH9tnaAkT8bojKXGfjeH
         y9dVcengerUfzgIllLUNo7WRQx57pHQqltKIqtj6TIwC4MFBTmGuK/vib7CEbCBHOYOf
         ZITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782335438; x=1782940238;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qhY5YTt9otpZBdjhswjpjNDeK/pN32eIQWKDjhQOPw=;
        b=tF2kBxt/xz9z+bIpLdLSW+ldnhBab6bIzMmy6uFORxu//j07y4cF1osPeFsgu9HSYV
         aMB+F4yMUyshZptVfowEYwXPt9eXFh7F6S4iJfZgt9y2Z/2UiYLgKGEhIWHtGu0DCTs/
         Bal9cwosjPYZJ910qafMzM2kvmXz2Y6KOQ+BFvxZBttd6H3IFMIvvlvGRLvi7pUYwmn0
         fMfzQtnD/mnZ7Fe3B6NH9nigkIYNl29uNuVTXz69d/KscCyPWNjy+7LGeRV2ppbPvuS+
         wUcXY83iMWF5Su5KQ/oGHuMO170sqk5ZKQxOsQAFHeqGdx1WZ49izrWVgGE8WAzGhpkm
         PRDg==
X-Forwarded-Encrypted: i=1; AFNElJ8H7BR3g/zynXB4Sfe5hMs+fpgN26xy9bZe1CW5Vu+MVLxbAkFi+x6OCizjp9mc2EFt74g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Zf/kKhAK5FFgHyvlz9Fgh/S6yzSGJbTy6IfGehFHObeJW+1I
	w5NC0EBwWa0CaLVeXq4fiZ0plRqzFvEYsCA7apUHYYQdHMilVvkmJYU/SDfBOcvT6KexeMb7PEf
	nI+7srQIlSERAl65GS0zl39z1faj/54xBc9feZOTJ
X-Gm-Gg: AfdE7ckPT/pRVI59DIPMaAEsAtpubGyK+MDXzQQ+ocNDnIstEuHQ7o0jZkP19XQHa+Z
	5BtZjFF52j+vUO7ro2DEWQ72z0gRTxCPFHULbuXfTIQIbYpLDuxxJG8sxzFajy1/3XTX+VaoOav
	lWJKxGmNUwl1r2XK/JGNWm+z90r2zwQ7G6r3Ia4KlJ5k8/fFQyMy/zAzxmxzP7j9Hg4Mt8ub5/d
	NiDqddb0Bq73KNZzOupDkbFHeazROyPsIleLPYXJBoytX8/hWKf+NAzNVgRHGkD4MaT2f4tcfgC
	2MDZZIiz6GzekG0N4HIbmgjYT7+wV53PROWPVcstLE1UzCgdi1zQZsgB8+k=
X-Received: by 2002:a05:7022:ec4:b0:138:4e1:4701 with SMTP id
 a92af1059eb24-139d0bfe4c6mr3377918c88.7.1782335437124; Wed, 24 Jun 2026
 14:10:37 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 14:10:36 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 14:10:36 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ede86ac4-d560-49a6-82d6-b33ac5fc9355@linux.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-13-9d2959357853@google.com> <ede86ac4-d560-49a6-82d6-b33ac5fc9355@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 14:10:36 -0700
X-Gm-Features: AVVi8CebnA3rqvCzlkQD0wA3EY7nvdb5mQUucCUu-AjWUK6m396TQ3uUDm-u_rc
Message-ID: <CAEvNRgGWwfWZbvXxBAKHxc3DYVGzDo8TYtii+8fVnJNtBwvCqg@mail.gmail.com>
Subject: Re: [PATCH v8 13/46] KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Binbin Wu <binbin.wu@linux.intel.com> writes:

> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> Introduce base support for KVM_SET_MEMORY_ATTRIBUTES2 in guest_memfd, which
>> just updates attributes tracked by guest_memfd.
>>
>> Validate input fields in general. Guard usage of KVM_SET_MEMORY_ATTRIBUTES2
>> by making sure requested attributes are supported for this instance of kvm.
>>
>> A new KVM_SET_MEMORY_ATTRIBUTES2 is defined to support writes (unlike
>> KVM_SET_MEMORY_ATTRIBUTES) in addition to reads so it can provide error
>> details to userspace. This will be used in a later patch.
>>
>> The two ioctls use their corresponding structs with no overlap, but
>> backward compatibility is baked in for future support of
>> KVM_SET_MEMORY_ATTRIBUTES2 and struct kvm_memory_attributes2 in the VM
>> ioctl.
>>
>> The process of setting memory attributes is set up such that the later half
>> will not fail due to allocation. Any necessary checks are performed before
>> the point of no return.
>>
>> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
>> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
>> Co-developed-by: Sean Christoperson <seanjc@google.com>
>> Signed-off-by: Sean Christoperson <seanjc@google.com>
>
> s/Christoperson /Christopherson
>

Thanks!

>> Reviewed-by: Fuad Tabba <tabba@google.com>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  include/uapi/linux/kvm.h |  13 ++++++
>>  virt/kvm/Kconfig         |   1 +
>>  virt/kvm/guest_memfd.c   | 116 +++++++++++++++++++++++++++++++++++++++++++++++
>>  virt/kvm/kvm_main.c      |  12 +++++
>>  4 files changed, 142 insertions(+)
>>
>>
>
> [...]
>
>> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
>> index 297e4399fbd49..cfa2c78ba5fb9 100644
>> --- a/virt/kvm/Kconfig
>> +++ b/virt/kvm/Kconfig
>> @@ -102,6 +102,7 @@ config KVM_MMU_LOCKLESS_AGING
>>
>>  config KVM_GUEST_MEMFD
>>         select XARRAY_MULTI
>> +       select KVM_MEMORY_ATTRIBUTES
>
> What's this?
> This config is gone.
>

I'm surprised this compiles... I'll fix it, thanks!

>>         bool
>>
