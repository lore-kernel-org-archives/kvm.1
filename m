Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F15439F7D
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786656245; cv=pass; b=dOoeNvhiePp/1BvISgaZ6KXC8FSf5QmcBOVUggry2dsuk4l7Hy+4G7Y+eBtGCXjcLs/dfFsArWxAVmuWuOqsNpVaYzMbg6lucMYoxhPgI4NLwF6zrehu5jemyLy+Ngk9+cbRHhrMpuf/Q7jLeOiaYzLUUbZD9xxaemEuMgGwMmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786656245; c=relaxed/simple;
	bh=qX1IR39uVwaDaiwu+D13suWfX2py7eKUr7A0OiCh9ro=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abUTOZZww6QiVqmgP9Fjbak7IlRNiAT0F3ThNgEu6CcL5lNEssKL2wXTWRVi8deRsa7IFbo5bQ2gD+B6GTydfY4YjbddsRDcZkrE7G4CGPksJXcBJYtQkBbxgpyuMotvAe1iD3+LQIAROq3aPv9PYDUroeAbe5RJXvgzMq52GnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmlSZbTm; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmlSZbTm"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84830c774a0so235708b3a.1
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 14:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786656243; cv=none;
        d=google.com; s=arc-20260327;
        b=Y3UFJ0d/YKZ8izcyE0PeFtlCkEGRNNyJ5PNJPZZ45GhY/qn5uncg0AW2KlNvNdF01u
         Wmg5vIMIGxoo39N0/JsebjlvQe8UpqU0SWfZhtbgMOk+EsxmKWa3slTh5TFACa4kezW1
         Z/Evvo/FnPF8y1YqDY3chNDt/D0fT4RZ9g14i4187Wtj5gUcAGxpi7YOmATo+/NJ2/uG
         Lyh42nHet1ljuXAuUlnYb9DMov6ohhs4z8k2vlCWFyxMO9feaucLm2iyDpqAnJCYRccy
         39b/cfQentLhTc/idS+N/SN8YqQ2x7evlR4tHvs2Kxf3cX/6c2mY6z9D1tYLcHH90U5R
         IQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FJck1umI1gERxZKqi/mE4jPaeCUw7jHUSxZxlUOvdoM=;
        fh=aRzWpwemBlQUqF15DHoE48cb9dFbOa4tHykLeApwevQ=;
        b=Znr1tQ0spB5hL9nbaUUQdE+mn3qDhLyoqsctaDFVy/7wA2ecks3zNwXI56er5aqOMC
         GNH+NxG2CEO9H4XhVCq+o86BPaHjjnYjvrGguVZxX7BTX66fXpqBw9DVaTANzpMECqt5
         4D7Lut+dpV9SO3na/M98bxxQsipbs+leJwo3WpwN6FAtwF86n+Nv10dDTcivY748ZX86
         3Kp3ZP5VPGOULT6DvY3qqpFU+T93EkVVMJBKSa8CyJnFfoEJkxsnTAIBQVY33astCz6b
         OBVIuKgOqY2Y9YOTIphwjQcVfbZ/AJLw9AG8oWKQ3xzWIycsVXy21Kh3wZZFyEjMa3Gg
         62VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786656243; x=1787261043; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJck1umI1gERxZKqi/mE4jPaeCUw7jHUSxZxlUOvdoM=;
        b=hmlSZbTmcwlzQzA4RAjRnm1zAMk0yOyDyMiwa5V5oYk5WEKaIOXTCuTjW/Jlww969n
         RaLdn6beYoaRoNFonZ+vIsG7xCCg850Rll5+UitkFZtfYQNfslPNDdeBtmwBg2rli2nU
         MXkUnasQN7YFrsk8p/jha01pyz9cF+pDF2TJhhkTEpyyefnyQE3q1OOsiPiRx7shpwi7
         kjJwqQkjUbmXB9amDQTCo1siV5u0ey8SE6OzW+nyNIZsLGZ6LXYqWXWz3tM1rOwqUHZo
         66SZmjsv/sgA4jd5zAufZ8uZGxGdzR9I3b4fyErxjshJDf+8pU2H+m/XeDZ4NTnRVx4V
         Ef3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786656243; x=1787261043;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FJck1umI1gERxZKqi/mE4jPaeCUw7jHUSxZxlUOvdoM=;
        b=E2EUz0lkwOxYPiluLe007ZR8UIpXErjys9aWDKYANskevwl1ringEGkzYLD1mzSl6m
         yuUT3KmHQXyovd8zBbNNBprQtU0ckWZ4JCsHuU5UJxn7svwGvfNVfoRiwN6gx7LZQ3Fr
         w9SGfQ2ugqquvSBzNSImMPNQyLPTGMNrdcHS1FN/jFUMgeeL4Eh3Sg3HkZHKuIfWgKXD
         WE/BGJSncB1c6yJlW38Pg7xkEk3uAFBuedWfhcAqh421e0/ov3YojNx9ropudWteao09
         i5CuZ4qCpziJg1Z9ZJwAkImobc3YWsd2GxI/2yq4BBxZOoxK8baqQWJjnJ6sTSj9tliE
         JXfw==
X-Gm-Message-State: AOJu0YxzO1BI/QPxmPYOjldChatDb3J4e5LLpIn+w5SIgjwaDgSgAMHq
	YQWshjjDCvPAt9YdXEoS/gFO+v/dYUJ3vtXplyMmTqKwxN9kZWaa654eSbiKcHQYxzKnpHkknTZ
	W8pKTNumAa3ibaFg/L03hhhztZQl47u9Q+/j+EEHp
X-Gm-Gg: AR+sD10RvhjzdL96P9ieZS9oqYSW0Xg+2Vu7fOQfNsBCvZhQ/f3iYRQ0HECxWX3V4dX
	/YpZlGZkSgY/MyaPdz9PCKg4074CD1Ad0EV/5PHXbHPPkZdgqOq8DJSmi6ptrJklWaPqWEe7fsy
	0MWrctWpf2SSAElcQoqx/GUhkG+ScSeSocdvM6YtOBC+93+BjR3W40IEV8rmXSsXPpGqY3K+fAy
	hxQYzdIT16mBQ0IeOe+h1jq5D72ZzIxbBNwlx4TAT4GVjxZ1tzS1qXiEM8h+aXV6Gj2+AK5nV0I
	gqo4wKE6jAJf2t30xPQAv+2FAieQJhhZKteJhMrlVDPIm844XUPXF7zx50D4qiCYB4bYLiBUDwj
	cE5UKyNNHuFvZpYqxoJA9xCPpfKauZg==
X-Received: by 2002:a05:6a21:a4a:b0:3cb:d156:d362 with SMTP id
 adf61e73a8af0-3cc7196e785mr831997637.3.1786656241969; Thu, 13 Aug 2026
 14:24:01 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 14:23:59 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 14:23:59 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <82ded1ea-e0f6-48d9-8bcb-38a6bc5e9176@kernel.org>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-20-2fc18ee6d3ba@google.com> <82ded1ea-e0f6-48d9-8bcb-38a6bc5e9176@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 14:23:59 -0700
X-Gm-Features: AUfX_mzbri1ixV_zlf2Jna8d8Me5Qvc_rxP8xrcIgsSaQjjAlnxnniHAuo3sYt0
Message-ID: <CAEvNRgHpy52iynKfXeEkyCixhhu0_Hnu5jSNT8i+BNxvEoG7Cg@mail.gmail.com>
Subject: Re: [PATCH v10 20/41] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
To: "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 8/7/26 23:52, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>>
>> [...snip...]
>>
>> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
>> index abb108886733a..2c3c22aeafa54 100644
>> --- a/arch/x86/kvm/Kconfig
>> +++ b/arch/x86/kvm/Kconfig
>> @@ -81,13 +81,21 @@ config KVM_WERROR
>>  	  If in doubt, say "N".
>>
>>  config KVM_VM_MEMORY_ATTRIBUTES
>> -	bool
>> +	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
>> +	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
>> +	help
>> +	  Enable support for tracking PRIVATE vs. SHARED memory using per-VM
>> +	  memory attributes.  Using per-VM attributes is deprecated in favor of
>> +	  tracking PRIVATE state in guest_memfd.  Select this if you need to run
>> +	  CoCo VMs using a VMM that doesn't support guest_memfd memory
>> +	  attributes.
>> +
>> +	  If unsure, say N.
>
> Hm, does that imply that a distribution that must support both, cannot ship a
> single kernel?
>

Did you mean this as a documentation comment? Should the above read:

	help
	  Enable support for tracking PRIVATE vs. SHARED memory using per-VM
	  memory attributes.  Using per-VM attributes is deprecated in favor of
	  tracking PRIVATE state in guest_memfd.  Select this if you need to run
	  CoCo VMs using a VMM that doesn't support guest_memfd memory
-	  attributes.
+	  attributes. Select this to defer selection of where PRIVATE vs. SHARED
+	  attributes are tracked to KVM module load time, where
+	  gmem_in_place_conversion can be specified as a module parameter.

	  If unsure, say N.

I think we should do _without_ the above clarification since using VM
memory attributes for shared/private status is intended to be
deprecated.

Is it fair to say distributions should not support both, and if they
_must_ support both, they need to read code to figure this out?

> --
> Cheers,
>
> David
