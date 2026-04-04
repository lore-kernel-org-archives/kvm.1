Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556E93A6B62
	for <kvm@vger.kernel.org>; Sat,  4 Apr 2026 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775295622; cv=none; b=J+YkBVt+tvXF5v2buax6TAgvo4i2w1f62EXhuJqvjeLptbQQpRh4NjWDWgXIizwMfIoU5dHAnm8ojD7rg0vFZP6Vy37zZuSRg7LLgNwY4oDUXCGUdxHgcpfVm8DHzyC2z5hkK+261UB0NCwUnwK9C1coW7Cjtcw5gsOFkB+dc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775295622; c=relaxed/simple;
	bh=XDXXCvBuP+BedXOB/xJSS7nMwuoIr0SIXDhnUXQY4kw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=r0n9c4W5r/DD23jihsKcyNablEOo3uGPTMSyyb7q/5JRPJMviZYKkqrpEznSqX2clPmcN5nGpwG40S2AhbHL9FEB/oRHaobind5ClDtDqlP/JlvnY6AT1qshXFwXDBjlbdB2WuR+NkrgU50cC8nmN5yEkVGw60C+TkppceZEVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdjZEwjh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdjZEwjh"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824c9da9928so1662014b3a.3
        for <kvm@vger.kernel.org>; Sat, 04 Apr 2026 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775295619; x=1775900419; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rOaxQXfX6SiiuBlcP8X1nQXWObPEsgiGGDciqZtKDLA=;
        b=MdjZEwjhhjDeVQBpJUdGFjryWTfkjawv2IsHZtPE3ccALMo/uiHRFPDbWtUKVIYSLY
         Kb7cH5sTS14s7F9rr4IlTd4BEVnSUtv5JGApCn4c71Wqkq48f1x+sC3F4CfceiIAndWh
         pLpxZ1AoDcYVhKSTBsM9tTnpHXdAwIMBaa3BMR1Kpn+XMhTtCXYg+7rCqUcWgvPR/4Ms
         zYI+w4ZZFCO8mlJrVeNUAr42ZMnfSxH+fzLuJY37tBLFw+ufHyheYQsJ4pbnfUe6auHl
         QIIRurGLmPpkmf0C8Mvx8fBq2N2tQJ+o71ImlVK2TYemsc+Y4U5gDLSiER2iJaSkWz/B
         5G2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775295619; x=1775900419;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOaxQXfX6SiiuBlcP8X1nQXWObPEsgiGGDciqZtKDLA=;
        b=kKQhLi36CeC4mMFB786JyJSP/x1/OwmxuS9ud/ARjPBDn+RuG1TnSuEXPzo1zWl6HU
         59VHMdHoTBDIuRd3EQQCvV6CSoVAHLpB94kv+4CSGRVigPXUiD0Cy19aFgzTby8uX2Zb
         b91X3OXEbwfwuN35/z2r+rEygBT2Gac/vlG/JlYVBu8Z3RtSJNxFPT0q7FwGsrBh7WmN
         G3Acy+ilflCW31TzbN3YJnz6CUeYkMZxgnTRdt8P8AW5IyqzEPMdLMMmktVV/A1ckTTu
         65h6KT+go4GKAeitdK6lzVVpu7YIxJAASvVA4d8QYscIo74CK6UmuhXb2uf6OiQEi7YO
         kasQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqZQ5gGHnVWhx22+xoyiAs2gER1VGmqNXTUgEQi68fPMu75MyWyZJf6A2VQ90MJ8+jnK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW15wRIp5Cti5kfGlEES8oAeHY0BTwIh4GqEMBUhi/k/nVkg+v
	OhcDXIKXwKGMe84Zczm6zW9zsscbcQpeKBjNJY/rlwRnqqJiRo0V1x3P
X-Gm-Gg: AeBDieu3t4XLufnCWA5HWlrKYWtQ5dxMNDy0HBN5lQKWjrWbou/k6w7i/Z6pDNffQ9l
	m1pWIpviK35RBJb/iX6z5i2/6IdMLz7bfP7q4+XV+rTLd9eniDyrDI6fUnjHsRjcQfvaRA9kPbI
	XSSXmzM+I308M/uszXChDIIj25ZnrB8gManSWgnNNUUDvHpBBronm6RqfTOvxobaFLBOUzKwZ24
	z/bQw+RV8Yhb6dwbvuaaih3xWdy36fd/sw8T0Es/EjA7bk3wRMvF5pVYgyLLFj64y+6OaoNAkon
	HGUhLwfRWbRhQohhQ0xkJCQGtmaYaRGsV3Elv05fwqBDq7SNHoqY+xyRW+Ix4ZFGVaF2kzvV5lh
	QzVeoH5RTBAdSdgVc0qifoGAsaWWVxFn/iH6BdOQI0l5Cw8cStMo/WzTYI6A9pBCBYBuvcRYGpj
	BZsIzXgBtcKxZ+pLBkXXJGBQ==
X-Received: by 2002:a05:6a20:430b:b0:398:6ea8:21d2 with SMTP id adf61e73a8af0-39f2ed8d9e7mr6111236637.19.1775295619301;
        Sat, 04 Apr 2026 02:40:19 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c647792bsm7698445a12.6.2026.04.04.02.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 02:40:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Yosry Ahmed <yosry@kernel.org>, Peter Fang <peter.fang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, KarimAllah Ahmed <karahmed@amazon.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
In-Reply-To: <acsvbxIdtlQzUw4q@google.com>
Date: Sat, 04 Apr 2026 15:07:01 +0530
Message-ID: <7bqnm5he.ritesh.list@gmail.com>
References: <20260325092001.613025-1-peter.fang@intel.com> <acsvbxIdtlQzUw4q@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Yosry Ahmed <yosry@kernel.org> writes:

> On Wed, Mar 25, 2026 at 02:15:11AM -0700, Peter Fang wrote:
>> kvm_vcpu_map() and kvm_vcpu_map_readonly() should take a gfn instead of
>> a gpa. This appears to be a result of the original kvm_vcpu_map() being
>> declared with the wrong function prototype in kvm_host.h, even though
>> it was correct in the actual implementation in kvm_main.c.
>> 
>> No actual harm has been done yet as all of the call sites are correctly
>> passing in a gfn. Plus, both gfn_t and gpa_t are typedef'd to u64 so
>> this change shouldn't have any functional impact.
>> 
>> Compile-tested on x86 and ppc, which are the current users of these
>> interfaces.

Mostly a mechanical change. I had looked at ppc call site and looks ok
to me.

>> 
>> Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
>> Cc: KarimAllah Ahmed <karahmed@amazon.de>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Signed-off-by: Peter Fang <peter.fang@intel.com>
>
> Most callers are converting a GPA to a GFN, I wonder if we should make
> the function take in a GPA instead? But then we'll need to the GPA not
> being aligned to a page boundary (either do gpa_to_gfn() in
> __kvm_vcpu_map() or fail if it's not aligned).
>
> Not sure if that's a net improvement, mostly thinking out loud here.

The suggestion from Yosry and Sean sounds good too. Instead of every
caller of kvm_vcpu_map() doing gpa_to_gfn(), we may as well make
kvm_vcpu_map() accept gpa_t instead and do the gpa_to_gfn() inside
kvm_vcpu_map() in the call to __kvm_vcpu_map(vcpu, gpa_to_gfn(gpa),...),
or within __kvm_vcpu_map() which is fine too, however, the former is a
better approach, IMO.

-ritesh
