Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1FA3F88A2
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870079; cv=pass; b=RM8+mNIrrvDnLPIcj1LyQd7eVG9YqPIwLTMyoLgYE7A1sIDf3Mfj45aqFknzeuDCgwfptWaEkWsMfXuubVQxerfAMslLlbpLWf9TIkSdvr+jkhw4Y9xZQU5yEIjEcykDEK59Ux5bKIqnXNx7IN2KFQV8hiS+7Zzt/zWyX7TLtr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870079; c=relaxed/simple;
	bh=DA2Wy9smkUrOgGLD5EcQ7iMKHSUE3cp9ttCFreanAWA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBnNYRbUP+xuVmUO/ZLO0btFYtDEy3jTpu+Urd1sxWXpwPDilAx42FWjg4XFdPUcldnZGR5Hp62ZrpB0yw4KRxZRFV0hvCvPkXPMI9J2q5UNShlcboPHQriSCrLtZLSnL5od+VOZKz5kNZgMQ6SVMugpcixFvphxNaUfc/QJdVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYS73nz/; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYS73nz/"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-6313b7e3d03so62409137.3
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 11:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778870075; cv=none;
        d=google.com; s=arc-20240605;
        b=JP9JJnFCTXyJllNZqcnghC/Wm19/9m+Syv8/AOrY1Yyru2fQ9WUSgw1Mn0QDNAP4Rd
         LlEf3xyA++9RrSAeFjmAVdWuG6Z2OxSi7jmvscosj+lFXnGNZvxVfJPC6QwVVHNvAsks
         27YtQyWTgSUQiE/+0IasAG/BGjZ/sxp0h0zdgis3E97irxm29yWP/CUPqI4Ow6oyy9DT
         z/hOVo+QQG84Hr1zFEi0xDmiDmIyAlOOQiOWA/W7hz9l8lNmOgRDnXSqN1fZpZIP0rg1
         E7tmrWqBNazbVvZ5Xvr3oZN31rZ42LzXlEV2R5FQ0vmwJ4cKhm1XwZeUEdt4PGUwPdFm
         Kv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=hXzcL4Si7AoDz7U9pqlgIyMQAxFIyNef25XFajpPNe4=;
        fh=lrIWIvq0UgFg7QdOZpUJVbyjcCjdA0HklBeWbP9PnyU=;
        b=Rm6WP16inV4knGkpggvXwQFwbQJOXdprwY1atQw94avVCadbT2+5z3syETyDQTw1Qq
         YmROtcNx5g3KTFTw4v7Mn827qtm6W/KzYxmQzV2j2Hfc6x1g5ohdqQyY4v6+3jReiKlm
         FbzhcLChxFfCNqHUin5jhkegXlljx4vTn4xDyO9ogPBXGKp8h0PwO2imveewIOGTrOMu
         F7r54DHr0Sq5cyvkryJCJXJwO1ppDulSysLCkLof9fgHzwhIVIutOqfFnMT5B6GuS652
         axQW4PGXhzbITT4IYXT6cOTvJVXqfMzDSuwwLPQLH67rik2+EXriH5j0JjGrrWaAqkg6
         YsVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778870075; x=1779474875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXzcL4Si7AoDz7U9pqlgIyMQAxFIyNef25XFajpPNe4=;
        b=YYS73nz/xIcDnIoNXHbg5GJ4s1o3X29GnkFEut9rfuxgQk3TQRUsu6RVLw+uqTtc/v
         d2z1AxB2eSs4RV3oGINb/D2mPrEtUN+TCkSDpWobhMFO0HR0hbo5L8yeD9O8iU/IcRJH
         sa7VwaOXROWEEexJ+1HCXnKsA1naMryFUYh/MiAvcrarKYPHzupdMRSlAWyR8eOetR3b
         Sxe8w+/PVbeVsIw96r/jOUejGQ71sBO0mVt543KBlOXhuQ8VzTtMl4oO9u8I8KxBxyia
         EK+Q8RFlfe1ZHyYZaqOa1j0zPOMaJsKMfLjG/nF5Rn7Z23Kd8k2b0hBAblYntqprLt5m
         Klbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778870075; x=1779474875;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXzcL4Si7AoDz7U9pqlgIyMQAxFIyNef25XFajpPNe4=;
        b=B2DGWQwxwSKFVYIhCCuTRyR+1TkvUoNdPgeySX2ACS4k5+oKwqW5GzMD5zteJArJlN
         r+OlzStNEiRO7nKsd1giY1YxxbnAJB7wuhpIQyIqrV6aP3B6NuJ2gOpgWgSGRKDlRiL1
         EAeZvPDhKtrac0UBlli6z52pBcLaFPZATvGTEHqOcTxKjGwdyEsA4NsUs1o4CMURHocR
         5TSCWRX9F4gOBURmZkurJPZ0y0aw7hZlM5RpSZVKr3bFuyW6HhGwbB4x+GRIgAUku2Kd
         NNtUXpdVFUie7K2B3hn4YpDhPjfqGYJ7rF8joOhRD2/ceKDpr9wpAsVj09V9BfR3fcvu
         G8XQ==
X-Forwarded-Encrypted: i=1; AFNElJ+T46ue+0BX2QO5CJm0muq/8LXthHvl5RiLPA8Q4L86TihrNJRi+VAQ6CbuygYgIgvzrX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN15rZNkYnrtbiUdZpCYfu3Lb1/pD1GABviP8pbD11tnZjyt11
	JxDMEIhWRmqnKzLr+v6X0t7CYOjmAWzkR6tJD20uLBcSgrA5E2laKKsu5Rsx/sv7X0lKtuF57vb
	yYV4JBavcYY/PPDXPQQd6vGFHcV0BEqp3ZEPdoWDC
X-Gm-Gg: Acq92OH9sXeRc5G6bfoh19wJik/CuCd5hzO2UBKSajr2s76njI5l7N/vs6uL4Z7EWD1
	8Vr57lCKidOb6bEk0GJnYkcBI0J/OMGAYk3daPuXLXwvwQaw0u4TRzDiYpVjNsviAlSYqAu7tEP
	LpdLVriKmKp+jVmseOGmDfdGSiA31aO9jNK+n5H9vCWZEc7UqPvp2/OvNmF1bhOr2Tae/qHgK0Y
	aR9tOne8CLLD4zS2Rb6EngxI06jZLDW7fbTpt7eH7+hUYwi+s53EettHFFNHd+gZoxMrg0c/YtM
	6Xvw82wRhEJVxtibURxrvp6Kcr6856AHMuGfmSVQoz/gNNBzNJ/zgzHHyNhqh6MXN8RFK2Ee4qK
	bgaMJAyo6YlFxqg==
X-Received: by 2002:a05:6102:f13:b0:5ff:f4ae:a154 with SMTP id
 ada2fe7eead31-63a3ca1ab64mr3398396137.1.1778870074886; Fri, 15 May 2026
 11:34:34 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 May 2026 11:34:34 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 May 2026 11:34:33 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ac7oE_1j6gxf8OKT@google.com>
References: <20260402041156.1377214-1-rppt@kernel.org> <20260402041156.1377214-14-rppt@kernel.org>
 <ac7oE_1j6gxf8OKT@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 May 2026 11:34:33 -0700
X-Gm-Features: AVHnY4IEbHvurLDEpAdcz2fUdNtakQtGECOPGI7q3-EkzXTSsmoe5CSHOnLeDQk
Message-ID: <CAEvNRgHd4azPaMddvqnSG+Z5fmg+LWd+pz=LSB3PrJTW618dww@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] KVM: guest_memfd: implement userfaultfd operations
To: Sean Christopherson <seanjc@google.com>, Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, 
	Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, 
	James Houghton <jthoughton@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Oscar Salvador <osalvador@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, tarunsahu@google.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
>> +#ifdef CONFIG_USERFAULTFD
>> +static bool kvm_gmem_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags)
>> +{
>> +	struct inode *inode = file_inode(vma->vm_file);
>> +
>> +	/*
>> +	 * Only support userfaultfd for guest_memfd with INIT_SHARED flag.
>> +	 * This ensures the memory can be mapped to userspace.
>> +	 */

Is the principle here that any memory that is allowed to be mapped to
userspace can be userfault-ed?

>> +	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
>> +		return false;
>
> I'm not comfortable with this change.  It works for now, but it's going to be
> wildly wrong when in-place conversion comes along.  While I agree with the "Let's
> solve each problem in it's time :)"[*], the time for in-place conversion is now.
> In-place conversion isn't landing this cycle or next, but it's been in development
> for longer than UFFD support, and I'm not willing to punt solvable problems to
> that series, because it's plenty fat as is.
>

Thanks :)

> Happily, IIUC, this is an easy problem to solve, and will have a nice side effect
> for the common UFFD code.
>
> My objection to an early, global "can_userfault()" check is that it's guaranteed
> to cause TOCTOU issues.  E.g. for VM_UFFD_MISSING and VM_UFFD_MINOR, the check on
> whether or not a given address can be faulted in needs to happen in __do_userfault(),
> not broadly when VM_UFFD_MINOR is added to a VMA.  Conceptually, that also better
> aligns the code with the "normal" user fault path in kvm_gmem_fault_user_mapping().
>
> I'm definitely not asking to fully prep for in-place conversion, I just want to
> set us up for success and also to not have to churn a pile of code.  Concretely,
> again IIUC, I think we just need to move the INIT_SHARED check to ->alloc_folio()
> and ->get_folio_noalloc().  And if we extract kvm_gmem_is_shared_mem() now instead
> of waiting for in-place conversion, then we'll avoid a small amount of churn when
> in-place conversion comes along.
>

I think it would help if we do some refactoring of existing allocation
functions to provide guest_memfd's uffd ->alloc_folio and
->get_folio_noalloc callbacks instead of having new functions.

Perhaps uffd ->alloc_folio and ->get_folio_noalloc can call an alloc
function refactored out of kvm_gmem_get_folio(), and also do the
kvm_gmem_is_shared_mem() check.

+tarunsahu@google.com, who is starting work on guest_memfd preservation
(as in LUO/KHO).

>
> [...snip...]
>
