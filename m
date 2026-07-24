Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089B3AE707
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924804; cv=pass; b=b7Ne6JqV4FjFx4OIAgfh6qniETwIu88B/u3irCtvwu99GHFgy273y31/JJsx4jJW/r2X9bUohbXZcqT7ByOE/g2ZX4LlrhL9SRh3kVahQzt8SwIUgGJVyqPMlXJXw7eH6qWFnVkU0GQRvRkvrauOapkFP2/lrLcdHhWACYz5Fv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924804; c=relaxed/simple;
	bh=3bPaFfkcLVVehjWoKc7uXp9Krk+zpZKVatRaC5BCI3o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNDFPEr2C4f3Jm7yQjCNDhMPXKOymyl2F1FHtqWTgc+vSEr6YY6b686kjg5GuZ1gnl0LOCzROx4YedqkgUTIO3G9KG28XPgtErEgZ9DBk6YFh8CDkLvkC9ebw+ULjP2yGpWGJpOeQflAvglkgxtTOnHcp486WL7jgWuwRz9dy/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+22ytPV; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+22ytPV"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38deea72eebso979669a91.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 13:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784924802; cv=none;
        d=google.com; s=arc-20260327;
        b=AvZ+rkKLXVhyDwPLic8hmMReQrZavbK6H+wpPf5OcMGYKupgRMa000kYo5ClReG9s7
         trpLyYTK88qfIsnsddpV/IPvXhGof4nDFW3P8FnDewEdgHNDaga/b1Sb1KY/HLT7+5f+
         JVBd3spMqwzSNKm5IYUtrhJykcXZhFGWfX+R51bzEfaL5nzKjOoFTg81WtdqUdpqryq/
         BABOnaJlSac4gqjcc8CYPJWAGJl82DENikQhSbTmrRmHXf21CKt8+xoa6hgWS96sp4Mo
         8IZpIvU17oCPHbsOUIKZqFROzO5l/87QyQIkuHc/utQVoa+iS22r1EBUGwUZjs+km0yK
         OEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=j6WRuRiOGlrBru4rjgXozk6E1Vpz9Ly8EIjgzHznenQ=;
        fh=uTUrpMEdaiEpNzolG23IoxnK8FDdjmwBPCAIqIirRR8=;
        b=CMBMscivEkCmsEIXHoK3zkPKeMXD046XRgOv9s1lZ+t/q8YObKEf2EXYZnEZB8YLRX
         DRJSBjMU9E4WQuxUUctTfIe5S3MCznpxaR9ygMOULN3SAYYjpiXdFSjUjhG8/odANRxe
         0IDFrs5Xbw6e2WWYNCX1gZBTn/5BtB8CgiP3TSHgEfH0pxPX1DJGTJxVHjYws4PQvROQ
         nSypGjYBAYbbPeaxQKa8Vz0zU+7WPKw7vPFxJj0v1nA8tIzS98NZvIYfExWlcs5sGDZQ
         CpJIPH4KUXfogSEweb/LneKJXZ8naCiui1jBRqkk3S9HPQmc+GQC3Njw96/t39Dg9nm1
         PqXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784924802; x=1785529602; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j6WRuRiOGlrBru4rjgXozk6E1Vpz9Ly8EIjgzHznenQ=;
        b=X+22ytPVowtvdD7H6oAjAZ6dFwEHXHU3JHtOooAKf/4Rt/T6msrmpVN9yapaJuPCXF
         BQgztoqjDqxKNUHrk3zrFXjUxFbKWrfrz8lbDrMAWHinAAAB8ufFNA+lK8gYKjqlrNym
         nCMleNTnPIVIUC0Cxzqk6t7U+1ZMYES61Afdnwqh6y11P2qbfCubhE1TG1yz9YN9JAnT
         IJU9Op2jnp5XnD18dnSNzVhOIISoNbvoTWl5o29uKwaLWAbqeaOaIylQW4ptJX5WQSZD
         FxQgxEYU2QZcoUGSWWBdvaVpiQzGU7AxpH00Zw54jehpPXR+QugrnjlzcktqsCmk/6fa
         NAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784924802; x=1785529602;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j6WRuRiOGlrBru4rjgXozk6E1Vpz9Ly8EIjgzHznenQ=;
        b=CAd0kUSDgMMpxG58gHHwpr7TAS1Q4xHX1bTqCu34suffwjNS2bkKB2ISKOhC6CfjDI
         3Z5AhjbmduJ+95e2aToRL1vZrmtjFQNkBQDHmS+CWug7Pi6lnuVfTprcWVROQQXvN/FC
         pY+QAgCOiosHCJtUDayaZFbZoROf1DCCyj1etqFgXOXYzmHYYKRRLhh5dEt2PwZBV0K7
         r+KWM3fNeEUnTUekBDtA2OkyhWr4d4z1EPqX062CncoKgjaC8eLjdrw5CVrcq+8qugRS
         dRsh8ceoKCBLN+HBskR3Gao/YfLqWxUWjYWH+NDQhUPam5em0VdVCzFmb+nadq/OKGb6
         FW1g==
X-Forwarded-Encrypted: i=1; AHgh+RohBADmoL1dHV0b39zCFlk17lw96zTnkdQlu4bu8UG6YrGOhY5JmiwZztFVnvMz9liW+Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU+5K32HQiCRyR4DUOfiNYup+Y6V9k4EDBXRHUoTarvG8LAAxD
	j0Ukk2dO59ckVydkpnZKpgYbj7ZPQ0dQ4qu+ui4UnZ+1X3DKmB0DioCidpW733zWB/iI2v5ey/y
	aHWAEeiWuN+c6LWcNIbJy1DCR1QIjujH+IdT1uuf7
X-Gm-Gg: AR+sD13SKITRkazXn7KNvrrLdgOD5onIfAXySkeNe0wz57Im2XrwY+a3Zq+s+ThKsMb
	jRqDxicfH4RCXiiY3rlEdNusbFJ0ij4NkEu18BP9VIgOylBrSwb7KtwrOscRE9spPFZTrD5Eghz
	86PFSTrLS15xXMu5LfA2vxxOaKTZ2CRTI0NovGBE5vpYFQhFJahfkgEkYxInrLFTUpY+ZFS93kh
	vGo/rry6VeA2aRj7YsWGdBe36s8N6cXqcckIMiK/3n7B8mrgdv87PJmMKbQBsuWcwYvkn1a31gs
	2i1XiQHY+5AfsZkSSEKaCseNuchUR6xqPZhw0wG2aFBBc1HD
X-Received: by 2002:a17:90b:38c8:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-38ec642bd98mr9249020a91.13.1784924801177; Fri, 24 Jul 2026
 13:26:41 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 13:26:39 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 13:26:38 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <c0e2df0a-19b2-4234-b0f7-41e010452b06@intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-17-9d2959357853@google.com>
 <584a8f9a-1538-4f8b-b576-75ef0fa961c7@intel.com> <akU7uAKb5E_Tklx-@google.com>
 <c0e2df0a-19b2-4234-b0f7-41e010452b06@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 13:26:38 -0700
X-Gm-Features: AUfX_mza0pn9bFWoM_88BD1HVQ8VVpLGhsBYWrYX7-3MlRMmF5M63UsjEJ6b88s
Message-ID: <CAEvNRgHmhpP=Re-RzojAp7E3E-TsdoUPhtZ6eSW4bf+5RVbzew@mail.gmail.com>
Subject: Re: [PATCH v8 17/46] KVM: guest_memfd: Advertise KVM_SET_MEMORY_ATTRIBUTES2
 ioctl
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson <seanjc@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 7/2/2026 12:09 AM, Sean Christopherson wrote:
>> On Wed, Jul 01, 2026, Xiaoyao Li wrote:
>>> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>>>> @@ -4969,6 +4973,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>>>>    		return 1;
>>>>    	case KVM_CAP_GUEST_MEMFD_FLAGS:
>>>>    		return kvm_gmem_get_supported_flags(kvm);
>>>> +	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
>>>> +		if (!gmem_in_place_conversion || !kvm_supports_private_mem(kvm))
>>>> +			return 0;
>>>> +
>>>> +		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
>>>>    #endif
>>>>    	default:
>>>>    		break;
>>>
>>> this looks inconsistent with the
>>>
>>> 	case KVM_SET_MEMORY_ATTRIBUTES2:
>>> 		if (!gmem_in_place_conversion)
>>> 			return -ENOTTY;
>>>
>>> Well, the check of
>>>
>>> 	if (!kvm_arch_has_private_mem(f->kvm))
>>> 		return -EINVAL;
>>>
>>> is buried in the following kvm_gmem_set_attributes(). How about moving of
>>> kvm_arch_has_private_mem() check to put it along with
>>> gmem_in_place_conversion check in kvm_gmem_ioctl() in Patch 13?
>>
>> Me confused, patch 13 already adds the kvm_arch_has_private_mem() in
>> kvm_gmem_set_attributes().
>
> I wanted to make the check in KVM_SET_MEMORY_ATTRIBUTES2 in Patch 13
> like something below:
>
> 	case KVM_SET_MEMORY_ATTRIBUTES2:
> 		if (!gmem_in_place_conversion || !kvm_arch_has_private_mem(f->kvm))
> 		return -EXXX;
>
> and finally, with the introduction of kvm_supports_private_mem() in this
> patch, it becomes:
>
> 	case KVM_SET_MEMORY_ATTRIBUTES2:
> 		if (!gmem_in_place_conversion || !kvm_supports_private_mem(f->kvm))
> 		return -EXXX;
>

Is the request here to make KVM_SET_MEMORY_ATTRIBUTES2 return -ENOTTY
instead of -EINVAL? kvm_gmem_set_attributes() also checks for
!kvm_arch_has_private_mem() and returns -EINVAL.

I'm about to post v9, which squashes the patches as Sean
suggested. Please review v9 instead to see if this concern is already
addressed :)

> So that the guard for KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES and
> KVM_SET_MEMORY_ATTRIBUTES2 is consistent.
>
>> That said, the ordering here is wonky and misleading.  A cursory read of the series
>> would make one think that waiting to advertise KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES
>> makes it safe/ok for KVM to plumb in support for KVM_SET_MEMORY_ATTRIBUTES2 over
>> multiple patches.  But that's not actually true, because the ioctl becomes live
>> the instant the code exists, userspace doesn't need to wait for KVM to formally
>> advertise support.
>>
>> To further confuse matters, it is actually safe/ok to iteratively add support,
>> because it's all effectively dead code until "Let userspace disable per-VM mem
>> attributes, enable per-gmem attributes".
>
> yeah, before patch 24, gmem_in_place_conversion is always false. So
> KVM_SET_MEMORY_ATTRIBUTES2 on gmem fd always return -ENOTTY.
>
>> So, I think we should go a step further than what I think Xiaoyao is suggesting,
>> and fully squash patch 17 into patch 13.  That way the reader doesn't have to jump
>> through as many mental hoops to piece together what is happening.  It'll obviously
>> be a bigger patch, but should be easier to review/understand overall.
>>
>> Oh, and that combined patch should carve out error_offset straightaway, so that
>> the full uAPI can be reviewed in a single patch.
>
> It sounds good.
