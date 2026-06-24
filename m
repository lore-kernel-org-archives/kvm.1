Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4583B3C01
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340311; cv=pass; b=A1MRDwH6THt9IZVGqeISTw9w4tCYThUGb4WN8Tw2ek/PWMwsmjjWSFcYcIqkoivqVV5RZ46Ea8SII9BRVGLaA1sZlXoVcyRt3QHnykF4UE/MRgD7xeCjyE2/RGEKpb8lRVDjbEq2tlzWdBLoZsk1YcU9USve7iHamagKcYl82Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340311; c=relaxed/simple;
	bh=Ac4SnsNXN8rEQTk23iatkBhfXxnOeNd/KNnr5r577/A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHGIU/eNfPqDLnoRvIzjjrjWg84BLAedr03wdjPBDE39oeCkgYl3JBBsV4gWqULiyUh/bpFby7iizYTMIUL0hXozy+UZZTKFiIhwnc2CnrhqHEiryajBbv8qMZUqebBcARFmw6csD55MBSlQIPMpDFMp/sxlV3jIgyEEZek5QMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kXObEAmO; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXObEAmO"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-139aff562e1so2225309c88.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 15:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782340309; cv=none;
        d=google.com; s=arc-20240605;
        b=lle9RbThOcFVmrTDHXV8DZNRNQGEgPyWOnQta8zmTVRrrhhYwHxU1o1zJ27pmrzmBm
         VtyjGVJ40Zz3zlKTGDLA4ufJIkET3ZJ8QEHVSFRrFVCnfOdM5dJsnWar9Zrc+L9UtmO3
         nflSLQPYCoRlnTse8uTw3za7u54PJ+YDYe+7PN6/4buH8MUD/Ij9D+GxS+4CxbYZu3eF
         a4gQxw3/ZfEJfL79u6HRjTan/OIRnsxzJDD+raqIQ427M5YNIP9aWwgfAZvxn3383gKZ
         08vXX0Rk+WcjGvbG/Rpo6zom982abwsY9dfwb9Tgb0VRdiqM6wb8MMoD7g9c8oC/F/Rx
         k1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=N6i/SOXitQvG69KsKOuqXfKe3MaqkPv8vgabs7K/yu4=;
        fh=Us3j35v4JJBZTJhQXzR+qlOMmNi7YXmsRQcqbaUfmuc=;
        b=bIKJlWlwercDZ7TSGY4VwhyehpqxEa2Jly/Mv3Z5ur/shMsHk2841Jj+2DTeN8QQDN
         P9rvqJM6+L0jJWRTy2iRLv5MZzgEFOq7bzyJRhpbJkt0yCaGwo0W4+XFkemg486Flx5+
         oKVBVqQ8k4wYvTP0srv6ISuvk26BCuG/kVoZNqvTXDxo4Z1X+yITq7bh8eDvh28d/6Da
         HO+6YbQg313FojhIrxUlcwPcZq6z/NgUEDrJKz+BQpAsUIT22W5Ljq6m1AsaV1RZYi8s
         eLC8Ro7xvO76iSbfFJVy8nDCn43VCp+owuKb6JzCQ6R8RamEgdSFLPgr7Uj+bx0SlkFk
         /EZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782340309; x=1782945109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6i/SOXitQvG69KsKOuqXfKe3MaqkPv8vgabs7K/yu4=;
        b=kXObEAmOeWU3iGzGqynePW9vunurhr4tXDrm3kJ2Cz9dCW8c0pi4ePkiJhdBbB0r2h
         w2/+t/hVRBLgpq0dTtIQvLqCJTmnZ16KNtEGT3BG8nimWzD7EBPiMzIYkIrQ0jsf3cbH
         LqCrTgOTl+1z4VqvDpsuuODCr33rr3qU+phQFm5bVgbQMlqnrTmNVDjU7+JqzSw+vOMc
         ggWC08/3T+MlomMQSP2Eeb7JXdSZK2ox02iFGX6yqQanH03l9+ftp8gaFMwFSmIDKEaK
         ybqAQ3aBIj4bBlXeIN1nGnVP+fb4On6GNfk4+S9EYul2hXXeZBoE12ny+sl//VsX8LrI
         PiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782340309; x=1782945109;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6i/SOXitQvG69KsKOuqXfKe3MaqkPv8vgabs7K/yu4=;
        b=bVI4sGbjS+YrBIb6gPeTDFKbrMJWPjZu61wh3iizsOvxF0EoaTkgs9+GReaHRGeCsd
         RkbIUs3mBI8WmQb5CD5InxrVrB80CG1r9zBcQoFFB9ttujE2iYfFtrTuzcITv1vFWwZf
         4kNQDXUGABZ4yn5VlJL+ZjR6ex4Vr2o17+A6fJg9iyqiZ3Ng6bTXkry5zvHapt+eIHnj
         jYE8YFzGuzTWFrcmNp88mXFktmqKEh/Ftap86cJmG3iK9PiqvEDvhbf3GuqD42Gyax+8
         dYskEg5DiXVhy1Q4daWJ+l2MT084HwokWXFN7y32PhX279BZMWhkMTKKnYunhxTKeDOg
         em/A==
X-Forwarded-Encrypted: i=1; AFNElJ9XfLyAjwDwJvLWzxExxaGzTewuV3oyWXPiIi+Os1cNiDUJc9cONDgJ/NPIkwBB62AYMnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKuDwomDvZxYE5McqEd7fu0L9woSU878E6+3Pbq3Ed3XoKElqj
	Lpws3VjlD0PXxG24zZoV1Nc0fU1rQWlCN12GDtbIQGj2j+4IwDmbI8r1iDglQevxNkgYrWyazBN
	TBqA1gtdr37iiAksl9rmobPIwL+ZcqACc0jLWVtfk
X-Gm-Gg: AfdE7ckUo1tuR0yTTLbUkEvOPdjbPyYo4vf3YhcXb/JNd0q9vr4vgxx9XlLkMFzajEA
	iahXwEJsUn0iTTc1VlxpIGLGLhXdfaPJpk1YBhJz8Q/0fImBg6HpDulvhQCsVCNcmnOXaZhp2Ip
	pUaRfr1GY/sgBTNhI2962nwUS3zRzdnwHX+bfh31RfWHrSYeCbTC0ZICR/9/eO2f/dFftqJZoFr
	A65V1VWykFwXHotTUCBjWlMM6FmHi4rgZL/1Z3/xQJ9H4qEddYKoj5xk1eIp+xc091b7E8D7Krd
	9zzc32DDtP4szNpXx9qs5ayqLTbD+M50jsbNaToekQa8MOncHUq/z4gYOQcGjTYGmBfFuA==
X-Received: by 2002:a05:7022:f687:b0:136:e639:9c05 with SMTP id
 a92af1059eb24-139d0c976b8mr3775881c88.31.1782340307804; Wed, 24 Jun 2026
 15:31:47 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 15:31:46 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 15:31:46 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CA+EHjTz3SW50EzxgXm8VysoaM21RReUVG2px_WUYU7zUwjXnpQ@mail.gmail.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-22-9d2959357853@google.com> <CA+EHjTz3SW50EzxgXm8VysoaM21RReUVG2px_WUYU7zUwjXnpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 15:31:46 -0700
X-Gm-Features: AVVi8CdGjNdamkK1obuu8yqfMxgZ_h-GaO78YorUefDXnXrkakD9WS-D2oU1DQk
Message-ID: <CAEvNRgGnSgYBwsgTh34uTTBvah12SE55LW=7Dm7RQX2U4sA7Jw@mail.gmail.com>
Subject: Re: [PATCH v8 22/46] KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE
To: Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
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

Fuad Tabba <tabba@google.com> writes:

>
> [...snip...]
>
>> diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
>> index bd04a908a8dbd..29409297f1ef0 100644
>> --- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
>> +++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
>> @@ -503,7 +503,8 @@ secrets.
>>
>>  It is required that the GPA ranges initialized by this command have had the
>>  KVM_MEMORY_ATTRIBUTE_PRIVATE attribute set in advance. See the documentation
>> -for KVM_SET_MEMORY_ATTRIBUTES for more details on this aspect.
>> +for KVM_SET_MEMORY_ATTRIBUTES/KVM_SET_MEMORY_ATTRIBUTES2 for more details on
>> +this aspect.
>>
>>  Upon success, this command is not guaranteed to have processed the entire
>>  range requested. Instead, the ``gfn_start``, ``uaddr``, and ``len`` fields of
>> @@ -511,9 +512,13 @@ range requested. Instead, the ``gfn_start``, ``uaddr``, and ``len`` fields of
>>  remaining range that has yet to be processed. The caller should continue
>>  calling this command until those fields indicate the entire range has been
>>  processed, e.g. ``len`` is 0, ``gfn_start`` is equal to the last GFN in the
>> -range plus 1, and ``uaddr`` is the last byte of the userspace-provided source
>> -buffer address plus 1. In the case where ``type`` is KVM_SEV_SNP_PAGE_TYPE_ZERO,
>> -``uaddr`` will be ignored completely.
>> +range plus 1, and ``uaddr`` (if specified) is the last byte of the
>> +userspace-provided source buffer address plus 1.
>> +
>> +In the case where ``type`` is KVM_SEV_SNP_PAGE_TYPE_ZERO, ``uaddr`` will be
>> +ignored completely. For all other page types, ``uaddr`` is optional if in-place
>> +conversion is enable, i.e. when the destination can also be the source, and is
>
> Typo: "is enable" -> "is enabled".
>
> "when the destination can also be the source" is hard to parse without
> context. Maybe: "i.e. when the data has been written directly to
> guest_memfd while the range was in the shared state".
>
> Also, how does userspace discover whether in-place conversion is
> enabled? A cross-reference to KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES
> would help here.
>

Will fix in the next revision. Thanks!

> Cheers,
> /fuad
>
>>
>> [...snip...]
>>
