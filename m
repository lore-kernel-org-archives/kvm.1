Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AD53BCD39
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440084; cv=pass; b=nu5XimWaT802b1Qyr3JmUHJTZ0bA0hOgvB8jwgEXTB9qvvJ6dxs5oDpLm2AACkZXFsCU2jMPejVeRBnJGQKDb/lbZfJ8TtfiNTXgxBr4cLlu7Q3S/phm1q6SyGhPEvDV6ecRZ52K929ImCEakClAERx/4QiWii/82/oNs29d+nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440084; c=relaxed/simple;
	bh=JN5w0VLC4CArOs/YqYBchGdpeM2L7REgIk+BeZ3c7Nc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFPAGPk+1ZeKQ5ukR3IDvp2wSynPw1YmpMO5+2ZbZwbtQYin5iKltPC32nc+AuVe+6TmS6tQ2BUJsPWf8sAmLLl/Bg2YrZseFrTtQLsx+3moU9QqYiILNkAKWezlEodGz2a4OfncIIKgcvLUaNyG6xq+MQiUtiSOXlrIqoZ8Ubc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLdpuuzZ; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLdpuuzZ"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-137dd523634so4883215c88.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 15:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780440082; cv=none;
        d=google.com; s=arc-20240605;
        b=LDvF5xdTXRdBWQCVawvnO3SnetB3bcWJz/5yxNkMlaQR9ea6Lv6nyAiw3Ou4JPmEOp
         95vOtwBxtZxitCpFrFjAvCLFwIeMY4f6FXgRxXSJcTeDsSr7IJw0qau80q67+UaOPJ7S
         +q4RSOWwhohC3U8NdhUdpqOuAoDJpRf2+xkFIg5Yv1ajqQKA+nOYuq5kKuqDCQ8/vi7s
         vG+jvxk5zdCNA1N2R6V8gmo4PtZWzMJsr5rbPp7/tML+9PZmnq2YXJUebDQ2O6lhlU4Q
         GioPuYLVjLUyzt6xNgbMmtT5aeIoGbqrQMBE39QURZoMFqA21xQ+LsF2TOozzJr5ZxZP
         Q/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=9Zpj3jj8aTNr4p/iPSCl+ydGEAQL1021/sdQMyQbGis=;
        fh=Vo+HhlX0TT3S1Fzs0dkCPvyPppBNtiGJEWeJhRKv3qk=;
        b=kvSiR2QIFX6nuEyGmga25NssDl35SghDxXihGunafNF9jc7b9wIdYie2BB1kkjWDob
         i/EFLSLCXRp1x0skHYLXE6+5PxqpLR/MrG5B2u12dNg2y2Ja1SMIjHPmdQMKy18H1rsW
         eCGMhRP9dHNqtpgdGFkLyejP2VH7wP99WJiSJNV97ulOdEwCPKyNu5SO8ZNSIbIJzJDE
         0dgE0CZxcKrSbRGmAXH2ESNcTgy6ZE8+dSAwpK4+7Ej+zibKnBvFuucnHoIM9al/veL8
         YubOj2upzC5ZM7gUlbI9V8pWhcRfvc//q1cXlr+6l/+QTktw9uehXJ/5SVHpERnsDPfn
         qJlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780440082; x=1781044882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Zpj3jj8aTNr4p/iPSCl+ydGEAQL1021/sdQMyQbGis=;
        b=OLdpuuzZDB47YplpmtAP4MJX6E8SIykbgJ59+5rm698PCRhUth1naGUs65Lu/IeH4N
         ktaZJLkhg0AECim8CAiss+raZ1tL3+xj5x8J4vTFCWyH52UwhtKMpUP3YFLnzflInGxe
         gBlAw0xf3m0ndFGggP8kAVwB7KfALltPNU6hF3FzGQf7wJmpllivrfKTMNoruZDSXoZS
         339scviSYJyk3gU8ZYDJICqQKcYeYM7F5gqrNqVreAcke/GozMlRPW+ugYZJd3OMUm6l
         QQC9Z8QHO2nEEXfI6mQFaJR6s1lg852u4+rNjjci7JsAhk0fCfrr46LzOkPwmjaJ9JgS
         VlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440082; x=1781044882;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Zpj3jj8aTNr4p/iPSCl+ydGEAQL1021/sdQMyQbGis=;
        b=qmmK9VmbW3PidKj3IxCVSwqN8X7HHgERvilS/9twjF1uhy8TUBdLUObRLtJqrA6nD1
         /BRTJMMz1CbhSqeiEp4aGh9vfIhQK/SH0kaVkeOax1teMweth746zvn3vXqoY91PARhm
         Kvj/odh8rzK5IExw7OxVN3GcvI3V8/u6bKk948mxvcQWZ5P2oqYAvmCNDVoQBf0XZX+z
         K6Jjdsmmix77JplWXpbFuo6QKYp+XYu0h7+YWf8UbhH7/2pa3ZM/sEh7NaMTInwS1uT/
         zAYazXoUUDETzrQe8OotgytEoR9/Swygl1ZMUVx6QqMzOkSuNcfrgus5mwIE8IH2tbAS
         ZvlA==
X-Gm-Message-State: AOJu0YxbSZB2af19dyPOzEhB4RkjsdpJ+JhgqIH6edHPh1yCMQJBStBx
	NFHaKoZc1l6aKDh68hnwQhSFoJD48A6x6i0xIoKwNPihLib23ya8vWgCyZoqfszrpJJGXAzGuDK
	zw/z+zzGrFlKltt8dMTqBZq0HCPXGmcqmh/DoGEk3
X-Gm-Gg: Acq92OFxfcr05lVoHsC2IRYe/oFxwfrfk9FDVLWdvpPysZuhszKAe5JV8KKXw7f0UYH
	QzHaEqp97YGIU0dQlC1nLDAfAKTSX4WJY9vKPT+xVXZ334HRwo8xbmzzVJPCu5DE8Bz/NfqZvXR
	XpHdseCWs2eU0ISjnM27GL5c7WB4fAQWRE4JHFK9Bc1WrZfp++0Ix90OsODX5Nknf0Ug5rElyci
	3Rg7GMxteTD1ItaRJbC3MUt3sdOuuLoC4eMDuQ096YAtktCGHjHrDvyTf86MEoR+/S9Ya5qz1e8
	UxfTUYgpjMvl90TCItiYrah4sW25A+YtuwIHDzY3J6uQKrDcNh1y8YlfFd38088b6FqxpcBqPDd
	QjU29EYtGQyz/6HA=
X-Received: by 2002:a05:7022:6ba8:b0:135:5d4b:2096 with SMTP id
 a92af1059eb24-137f6bd71e0mr275458c88.36.1780440081068; Tue, 02 Jun 2026
 15:41:21 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 15:41:20 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 15:41:20 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <144bbb9f-39a2-4c90-8903-51521e022da0@arm.com>
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <20260522-gmem-inplace-conversion-v7-7-2f0fae496530@google.com>
 <d01cf1ec-b85d-4af6-9810-8107c0e2a4ec@arm.com> <144bbb9f-39a2-4c90-8903-51521e022da0@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Jun 2026 15:41:20 -0700
X-Gm-Features: AVHnY4Il1A6xpCFYh9Ccj4ryfsVj2nvlEe4xvqbfHFojqcjHjss1rOCXb44vh2I
Message-ID: <CAEvNRgE1dCVAxJWd_hyFa8N=m9JLfn97ip9tAmvHxspWJ50oGg@mail.gmail.com>
Subject: Re: [PATCH v7 07/42] KVM: guest_memfd: Only prepare folios for
 private pages
To: Suzuki K Poulose <suzuki.poulose@arm.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

>
> [...snip...]
>
>>> @@ -914,7 +916,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct
>>> kvm_memory_slot *slot,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_mark_uptod=
ate(folio);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 r =3D kvm_gmem_prepare_folio(kvm, slot, gfn, folio)=
;
>>> +=C2=A0=C2=A0=C2=A0 if (kvm_gmem_is_private_mem(inode, index))
>>
>> Don't we need to make sure the entire folio is private ? Not just the
>> page at the index ?
>>  =C2=A0=C2=A0=C2=A0=C2=A0if (kvm_gmem_range_is_private(, index, folio_nr=
_pages(folio)) ?

I was thinking to fix this when I do huge pages, for now guest_memfd is
always just PAGE_SIZE, so just looking up index is fine.

Is that okay?

>
> Or rather, we should go through the individual pages and apply the
> prepare for ones that are private ?
>
> Suzuki
>

IIRC the plan was to make kvm_gmem_prepare_folio() idempotent, as in, if
a page is already private, just skip. Currently sev_gmem_prepare() does
a pr_debug(), which I guess is technically still idempotent.

I'm thinking that the information tha needs tracking to make
.gmem_prepare() idempotent should be tracked by arch code.

Does this work for ARM CCA?

>>
>> [...snip...]
>>
