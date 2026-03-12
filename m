Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F1B31F9BB
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773294303; cv=pass; b=IqmHOPcEvq1S5W8QkKNGh7KEIl6m2FGtAIEUFK5hB7rudR/eVjbDpDjPtL/bQUxjxt8RWLuE5fRRJIRU8l04YZgeHM8iOnmOkF9EjZ8sIEpX5dlC5p+wtKEQl6pI9KYrDz+xGNu5P+Ma0lxy+OYE57v5amXkGT02gWQu7cY563c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773294303; c=relaxed/simple;
	bh=GmJK/N0KBkRxDo+pqiY/6G+ZRXyparhw1yW+Cxl6e28=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeLngpHAsuVBC+qHGFdNuFFo3GRvwIpQG9YIWHN/nVw1QU6UI6sH2P39Y1LrwSyE2tlauKDLXCDMbVjmFSDNdWLBz2ELflSfcHAFw7YeZOxU2T5erGDiWuTCkr9MdexLlQl61MZjec6o/XS7MgjkxG3Yh/uoHJJx1W7gXTqWYYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VdZJT0Tx; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VdZJT0Tx"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso311919241.3
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 22:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773294301; cv=none;
        d=google.com; s=arc-20240605;
        b=RQwA3DzpSOJoF8NClSTXHPeUnr1Z0R53Oy7F5E2As1vAS7sLKMo9J+D7rwAU+zKQFf
         nLTAHBJfOnwwsFpkiFxqqLMHkIfhwUW9o92EKZ5+az0cJZt9/V7nB15lURWnlHu+o2A9
         /lq98WmPxqPvJvxN5f3MuPdNhpewlDSlRe0ZrzDAElUZSpLkH2elNthgH/ZKflwKMqKL
         qdO3TcKTO133sx8SHosFeR43gmeghNxjjQuyoPipRq2jP9U3x5k/zjJDgU4eq02Fs66f
         LZAVrV6Ue+bJAMbhjuGR1pj4+NYlJhHVUWfcgEmjD/YH2Z0wvgWk/hmFZlPw/xnJxhXw
         5jxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=WHL+cdGBVdeYzUrRkXUnxuFTgvkDYPGLTyvabwlDW1U=;
        fh=QuGRZV+lwkLB3Ja08qWMJmOBQhdHSed+R2+HERPlsPk=;
        b=jjz9tcDoKsoQwrr5gVZPbUNNiAY585YHsv4pq/PuXpyaikIEjRBahVi5zCZwXyLMvi
         hTS5uBhbx5ixCLDVst0gjwiGtkHhGvBEbPoJyEFiq9utxGaId/QRehzYag0B+ijW00pC
         0dvGl06K3L3ISnEG+7XorwYRxSk5ZOAk8VW4fv6n8+i44/0HMyoCX/wffqskW4KMqMbH
         KT8Q9JU82nkhV0vB3qi5uGCVwWRaZFDsr526u3NvlklcTffzv5S6kpqK0qkvUSyIKLLR
         i2VI1rtWkePTpAGb99IpqnHyoqjvindKaV0UhDFYiZKPniqVmJ0Htm6dma6eoTH2N1iE
         0TWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773294301; x=1773899101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WHL+cdGBVdeYzUrRkXUnxuFTgvkDYPGLTyvabwlDW1U=;
        b=VdZJT0TxrE2a9giQrcsUQtWWCibe1Z2In7NV0CRlZMWbacWoFRZzPJiR7FY93c03j9
         2yAo6IHTgN6vy8NV77CVpW+HhOc8Y55Q1whsRU7GuexdhiOif0pMktOgLab0yQH24Xmb
         eY626NrC06XAbL+FuZen1nZxylloOh0Xe89KQ40vjxWjixm6s10qgZ4tccTY1C/SL9YU
         idN+6ZtprApYPnh/eGiR+dkQwu97WSop2d6awTVostO+SsiP5p9csP3pOO148vafEevW
         oby0MD9CpiBWwPQcNfulnvgZ3CI41epjzwTw2bXTqHx8ZBGK0yocieKobEXt292GR1Sr
         CfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773294301; x=1773899101;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHL+cdGBVdeYzUrRkXUnxuFTgvkDYPGLTyvabwlDW1U=;
        b=JFmXWi9wXOUS0kj9T2Wy6yjng8BoaFzcleVuqEnwckZH0JFY8ICiP1wCc08b7iof9M
         uPMR0fI8Bxz1JXJcwz5o8DSGjljuaLRnlINNtJ0snNoecFLtxfVzNFFJZAkcdSvu+2vi
         ItsMlJSjYukdyqOwhhDXYhfHrW4Ekv0oHozUl1R/pHd0QpUEdU1B6raZi9ofC074CzX7
         e604EJ+85X/KQdXuY0F6BL4FRR+LAq/1AixdVEe4Kf9VTQzqKqbpXadGakTH8VnCno4d
         WX85duONI27pjdYnD2T+QYPXVNqh9xsnuHu7D1iLo24yAPysp5h9P8qE0GPRJSrZmP16
         q7Hw==
X-Gm-Message-State: AOJu0YyhBBJqnLuvcnJPDUlxOqdI8jar4VMo2Iy3fjCB0Wgdnguhe3Zo
	mID2R7T/zDiPFk40OPdjI4QMYBvOygNjQIkmkLW/UVBe+PiDr6xSm59S7cRLFcFvdZ1gesmG/js
	u2xM/h6ywEEI3GmICNu5tMVANC2PL3RNiTlNJeiZVQ44j5GTc4PhKQi9kXQU=
X-Gm-Gg: ATEYQzxqaJ/CCbNzOc813gpR+oU1qrYP/exiYMaN7q4cLwN2v6jxFkVLLXegdTzMgo7
	awHD20F3h0bp3FbI6pvMaeoQCUryDNrewizsgDcOnaH42xSv+e043dXsxhEOepETGL3j5AtKDW/
	VUQvTdJSNF2gqxo1bsAGVOUwPzQ7g9IsKvuA5G6XLN5K0N9yFH3Zp5RcgOKhxvZPNQHwn4+kr5c
	+5KNedMpIwygNIeArzLT0MywTjoxfNAW14QnOP97I0bdIqfic06U2U2jiEFvwq342OjhjUf7EdC
	eNbee5Md9OCFjtTlOxJzxpEG6o6HYdxDM2AbKw==
X-Received: by 2002:a05:6102:418e:b0:5ff:ba2d:17c1 with SMTP id
 ada2fe7eead31-601deb8f595mr2321310137.9.1773294300559; Wed, 11 Mar 2026
 22:45:00 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Mar 2026 22:44:59 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Mar 2026 22:44:59 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
References: <cover.1770071243.git.ackerleytng@google.com> <86ad28b767524e1e654b9c960e39ca8bfb24c114.1770071243.git.ackerleytng@google.com>
 <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Mar 2026 22:44:59 -0700
X-Gm-Features: AaiRm50qY80lG_kPAevYiMiI4iaIYG-rOHvoXqEdwljZn3zJnS7kUqoIvI7enLE
Message-ID: <CAEvNRgG-L+GBcm+u_thGvXAxV-Nqzu5VtgXy0PfND6SG0FiyVg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	bp@alien8.de, brauner@kernel.org, chao.p.peng@intel.com, 
	chao.p.peng@linux.intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com, 
	ira.weiny@intel.com, jgg@nvidia.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, maobibo@loongson.cn, mathieu.desnoyers@efficios.com, 
	maz@kernel.org, mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com, shuah@kernel.org, 
	steven.price@arm.com, tabba@google.com, tglx@linutronix.de, 
	vannapurve@google.com, vbabka@suse.cz, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

Here's iteration 2 of the attributes, after getting a much clearer idea
of the use cases across platforms at the last guest_memfd biweekly.

Please comment in this context! I'm planning for this text to make it to
Documentation/virt/kvm/api.rst.

> Ackerley Tng <ackerleytng@google.com> writes:
>
>>
>> [...snip...]
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index 23ec0b0c3e22..26e80745c8b4 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -117,7 +117,7 @@ description:
>>        x86 includes both i386 and x86_64.
>>
>>    Type:
>> -      system, vm, or vcpu.
>> +      system, vm, vcpu or guest_memfd.
>>
>>    Parameters:
>>        what parameters are accepted by the ioctl.
>> @@ -6523,11 +6523,22 @@ the capability to be present.
>>  ---------------------------------
>>
>>  :Capability: KVM_CAP_MEMORY_ATTRIBUTES2
>> -:Architectures: x86
>> -:Type: vm ioctl
>> +:Architectures: all
>> +:Type: vm, guest_memfd ioctl
>>  :Parameters: struct kvm_memory_attributes2 (in/out)
>>  :Returns: 0 on success, <0 on error
>>
>> +Errors:
>> +
>> +  ========== ===============================================================
>> +  EINVAL     The specified `offset` or `size` were invalid (e.g. not
>> +             page aligned, causes an overflow, or size is zero).
>> +  EFAULT     The parameter address was invalid.
>> +  EAGAIN     Some page within requested range had unexpected refcounts. The
>> +             offset of the page will be returned in `error_offset`.
>> +  ENOMEM     Ran out of memory trying to track private/shared state
      EOPNOTSUPP The specified content policy is not supported while
                 setting the requested attribute
>> +  ========== ===============================================================
>> +
>>  KVM_SET_MEMORY_ATTRIBUTES2 is an extension to
>>  KVM_SET_MEMORY_ATTRIBUTES that supports returning (writing) values to
>>  userspace.  The original (pre-extension) fields are shared with
>> @@ -6538,15 +6549,42 @@ Attribute values are shared with KVM_SET_MEMORY_ATTRIBUTES.
>>  ::
>>
>>    struct kvm_memory_attributes2 {
>> -	__u64 address;
>> +	/* in */
>> +	union {
>> +		__u64 address;
>> +		__u64 offset;
>> +	};
>>  	__u64 size;
>>  	__u64 attributes;
>>  	__u64 flags;
>> -	__u64 reserved[12];
>> +	/* out */
>> +	__u64 error_offset;
>> +	__u64 reserved[11];
>>    };
>>
>>    #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
>>
>> +Set attributes for a range of offsets within a guest_memfd to
>> +KVM_MEMORY_ATTRIBUTE_PRIVATE to limit the specified guest_memfd backed
>> +memory range for guest_use. Even if KVM_CAP_GUEST_MEMFD_MMAP is
>> +supported, after a successful call to set
>> +KVM_MEMORY_ATTRIBUTE_PRIVATE, the requested range will not be mappable
>> +into host userspace and will only be mappable by the guest.
>> +
>> +To allow the range to be mappable into host userspace again, call
>> +KVM_SET_MEMORY_ATTRIBUTES2 on the guest_memfd again with
>> +KVM_MEMORY_ATTRIBUTE_PRIVATE unset.
>> +
>> +If this ioctl returns -EAGAIN, the offset of the page with unexpected
>> +refcounts will be returned in `error_offset`. This can occur if there
>> +are transient refcounts on the pages, taken by other parts of the
>> +kernel.
>> +
>> +Userspace is expected to figure out how to remove all known refcounts
>> +on the shared pages, such as refcounts taken by get_user_pages(), and
>> +try the ioctl again. A possible source of these long term refcounts is
>> +if the guest_memfd memory was pinned in IOMMU page tables.
>> +

Memory *content* policies can be requested while setting memory
attributes. This defines:

  - What the host reads after a private to shared conversion
  - What the guest reads after a shared to private conversion (if
    applicable)

The policy definitions below provide more details:

``KVM_SET_MEMORY_ATTRIBUTES2_CONTENT_POLICY_ZERO`` (default)

  On a private to shared conversion, the host will read zeros from the
  converted memory on the next fault after successful return of the
  KVM_SET_MEMORY_ATTRIBUTES2 ioctl.

  This is not supported (-EOPNOTSUPP) for a shared to private
  conversion. While some CoCo implementations do zero memory contents
  such that the guest reads zeros after conversion, the guest is not
  expected to trust host-provided zeroing, hence as a UAPI policy, KVM
  does not make any such guarantees.

  For testing purposes, the KVM_X86_SW_PROTECTED_VM testing vehicle
  will support this policy and ensure zeroing for conversions in both
  directions.

``KVM_SET_MEMORY_ATTRIBUTES2_CONTENT_POLICY_PRESERVE``

  On private/shared conversions in both directions, memory contents
  will be preserved and readable. As a concrete example, if the host
  writes ``0xbeef`` to memory and converts the memory to shared, the
  guest will also read ``0xbeef``, after any necessary hardware or
  software provided decryption. After a reverse shared to private
  conversion, the host will also read ``0xbeef``.

  pKVM (ARM) is the first user of this policy. Since pKVM does not
  protect memory with encryption, a content policy to preserve memory
  will not will not involve any decryption. The guest will be able to
  read what the host wrote with full content preservation.

  For testing purposes, the KVM_X86_SW_PROTECTED_VM testing vehicle
  will support this policy and the contents of converted memory will
  be preserved.

``KVM_SET_MEMORY_ATTRIBUTES2_CONTENT_POLICY_NONE``

  This is an explicit request that KVM provide no guarantees on memory
  contents after conversion. Neither host nor guest should expect any
  guarantees about the memory contents after conversion.

  For testing purposes, the KVM_X86_SW_PROTECTED_VM testing vehicle will
  support this policy and every byte of converted memory will read
  ``0xab``.

>>  See also: :ref: `KVM_SET_MEMORY_ATTRIBUTES`.
>>
>
> [...snip...]
>
