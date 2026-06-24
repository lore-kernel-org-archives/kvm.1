Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E212DE70D
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311922; cv=pass; b=Mn3YwlzdE+nTcUMEPH+0l6rxRB+1V5MrvZ+ZaQezFbNoSXwzNOn7Bsx53S69iKAnRPv0UIHwm+p1Gu6f0PLkETLZH3k0LSVNLlsCxpYPtn+LE8Wtbv9D3fW4F8iZG/kfUlX1452031V/v52RM+0yqFmzP6HhOQncqHRk8F7LwIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311922; c=relaxed/simple;
	bh=+a1qMWWmOM6Y8/o1eN1lz2qoObcQIVgbkHxFmUvd4Kc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiD/9Llv4ePg+5AHwwtaU8DLTSuogMH2qpl+9nLmGWWJEZBHa6muHHXTMvmjIJCwLilNHLm0C8nDiShfZ+SYtzbutKAoWn+WEA/eUGPMTRijpH6Wepc7CJkiTjOpLzZHQK1UpBn9Ns8CPUhAmjnIswyjYbm0CmHKLPstsfKI7oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNSNe9wb; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNSNe9wb"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137335bc3caso1833258c88.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 07:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782311920; cv=none;
        d=google.com; s=arc-20240605;
        b=cvY/OtNsw6ZEhTms7GL8w3ZaYD7VnCl8FiogZihUsAvf7MKnfYZNXXJMcdEmUVQKWI
         IAcuCetT/JK+dMiC/NqpXWxSBud9tSR/ErDOUKK2INkeBmNSRhYLXeJCAfgPkGVirX/x
         KfDzgmJCVacpd5gEvOlpmdxZhnVo0GTY/6RN3D4GVoaUukO3CLyN0yjc5VQYwob6V9SI
         K8w+keEGXWw6/C5P7gj2XXQgSpduYomfkFWRg0ziERg3vSbJfkVGpPLcckAO3m5qb3rd
         bdmEwCgGqdCgHlV1/WGWhqIJ3srj/3NPnaOtReP9fMbHLujaQfIOR2sbkZXtTE9Rf3ys
         dvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=HpVAzGtumZJ9rywOtX3ITBDfHQ1Vjgs3+apnvgsrs7k=;
        fh=ariRPF6Sj+GnFk8EjlygpZ/Ki78AcaT7BUfsy2/HgCg=;
        b=fJqnsIUcV55qmM+j4+KVqXLAA0f1Ch1Q9BxSx62Kfe3Wx2ZfIqDJtvyXCx17SY+QBm
         JOyOfy5wla8bfsbaB1ysTxh1s7b5llZpqMsVvg/5o43OzvZ9jKBp+2XsEFPaxTpWIUga
         iLt6EcKRyA3XXpoIOdBDcl4hx+j9jJmgIT6Nb2muF8leE/p1eqJAkYyg6s7Yrewj9OQT
         0ILfOkV2QN39S/8Co6V2WWKE1zTU61r5a9Oy7ccvd/MITy4fNPnb1MooGhclDA5pHjwS
         hIq0LunTS8TwMDxR37+2QwQHvFVnHluGybUdnF0DaUJu0BY+bk610rqMjf81w5/QZaPJ
         zxqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782311920; x=1782916720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpVAzGtumZJ9rywOtX3ITBDfHQ1Vjgs3+apnvgsrs7k=;
        b=mNSNe9wbTP9Ngof4VtQoFcV2uv52SUPaZgY+Tbi660cx+xZqhgJ2b3iYt44xjlEr6I
         ELCjjQ9gLffplXOTXMTE3aF0bPXSlYL7CEDv/m8Y61oFNVZwQPaSVRLm9AqiUWupNXz9
         IlLVsV72n9CO/cCbMEXwfXIzvGB7GvrX/TAQHIGJiBfQ4PUfK9rT4oDvczZ9ytL4FU0u
         OidJ8kWId23VDBoEkkY6a6NZZJ2SKgenW7G4SsyXAhUq9Zi2A+OJoDsFdVZDw2Pv5lr/
         pl3c+NsUeE8KQ0GZFGCbtsNJItUDelIt2UCx2XniStgj4PvZGXLbswTlT90kbvWoN4y4
         pdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311920; x=1782916720;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpVAzGtumZJ9rywOtX3ITBDfHQ1Vjgs3+apnvgsrs7k=;
        b=oeystMsu79abJ2HCELjOevlFJQq7/8JNKOkz3y4CLxc4WYaoP+a+/adFaPvOKmy8Rv
         DzTEC6u3b2SKeG/Hd94iZz02IH74Loq5Ju8PKdId8sRMUtpCdjQTRpG1DPMfOHbyrIH/
         vtv7Jhs/Gjr5HiGKHDvOHS7demskj4YKXnY2X6wIMYExSR3JDAxhjPl7BrIj2qGL2Zj9
         ik7pC/8pcn8wk5OTvtI2wUUv1cN8mQb84zmosYPQA1P+OXDpJ+4eoKTPwXjFiocd72Rd
         fZ2OOTJ0z4QXMq1FBDIBzDRHbFOFJL09syJvkXpR/uTear0IvIHcXK2AGp7u0RrhYUqC
         aJxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2uG71rbXzJE+8fRS93E4EHh2sF59MceruLf20ijLn0SxXZgxaTYE184IRDYl8+t7OM+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1a21iUrICoD6rIzDHSY57e7oZKu8xySOucBA6vUThLUFirocz
	B53q1w2dzIKhL7YncTi1Q/jTmFn7Mftrt8dy/jCromqRaufz/IEYQ8gWNyqnMHppffe6uPKNqqp
	5K0IW/My5oKBcQlT1jyAn4hQDDyjKI+qVgANGD3iN
X-Gm-Gg: AfdE7cmkJbrwJev6sE08GyKI9FpLlhP45+io3FHRP+hvPFIpSQnYLHGpqYQclTQbHug
	GU2amC6nAxXtOGgIhcvhCojfxyElddj/sgTr5V/X98jLrWnqYdrwETQRvL/+3dPyhnH6Yx6clNA
	07UzwC6AH/sid1EwBl/9r7mYwmZsns0btLoTs0svMIEK4lAK7Jxr3NGjFX2Ds4L3Nn+yfyiQsVa
	5COyPBOKUnIM2uJMZmC1d2u7hEE7Ja/zxTVBn7BJ7EW1bOSsMuZoRfYAEYGPRJEjnrGpx0Wov/C
	d51SOZ3bpOWaXRW3E6f4NevuimMb
X-Received: by 2002:a05:7022:6612:b0:133:3bb1:8d40 with SMTP id
 a92af1059eb24-139d0c24496mr2539007c88.15.1782311919284; Wed, 24 Jun 2026
 07:38:39 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 07:38:38 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 07:38:38 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <1b59fec2-a464-4429-8532-880394912af5@linux.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-9-9d2959357853@google.com> <1b59fec2-a464-4429-8532-880394912af5@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 07:38:38 -0700
X-Gm-Features: AVVi8CeozOwjsDHz095RESzI1L73Y_-_c-08wJAGuPOXvsS0FIpnjscm-5zrczA
Message-ID: <CAEvNRgG-WDzHp-15Mig4hiU5Dag0pFCu70-R-9b=PkD69W=ZMg@mail.gmail.com>
Subject: Re: [PATCH v8 09/46] KVM: guest_memfd: Introduce function to check
 GFN private/shared status
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

>
> [...snip...]
>
>> +bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn)
>> +{
>> +	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
>> +	struct inode *inode;
>> +
>> +	/*
>> +	 * If this gfn has no associated memslot, there's no chance of the gfn
>> +	 * being backed by private memory, since guest_memfd must be used for
>> +	 * private memory,
>
> "guest_memfd must be used for private memory" is a bit confusing to me.
>

Hmm good point. Is the source of confusion that guest_memfd can be used
for both shared and private memory?

Perhaps this can be rephrased as:

guest_memfd is the only provider of private memory and guest_memfd must
be used with a memslot, hence if there's no associated memslot, there's
no chance of this gfn being private.

>> and guest_memfd must be associated with some memslot.
>> +	 */
>> +	if (!slot)
>> +		return 0;
>> +
>>
>> [...snip...]
>>
