Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7D345CAF
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215705; cv=pass; b=KdX6uztQ2aQjvmVFJXCK/w22yYQrX9jyam7DKHLKcKC9ipty5zlTwD2WlAbcf+zMTVFoAo27x/fev0arOVQAFOAWPo6KtYFXBRc4+rR/9T2n229X4Qof2gkZLgcENXLkQ8Ner8JSgPq7SEKYPwHc8XWN06cO0dfV+jQQAyTgUHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215705; c=relaxed/simple;
	bh=KGwOof5+ZrWk7fQk8HZziiUwEIlVuaXd+B/75nP5r7o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6No4Exy+6e8fiAN+F+k7UMfOKK+oyjdQ7gP5TabnaOs0fG3FWbgAlWPwRU4rNHLJHgBZrIjAAtffwtDBpM/+m4896Cxyj03fxff/jMnSteCcavMkgpliNtJcW2H3+2/R1IBPVOTs0l6lTQc1p8KSiu7ArmLp+i2u2TecakKa68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gGAELiIj; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gGAELiIj"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-57512b86273so2875164e0c.3
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 11:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779215703; cv=none;
        d=google.com; s=arc-20240605;
        b=FZR7OPCotJZbSqncJRj/s+NcLRHTFI0QmZ1shsQpQB0RfJz4FGVd05yPl8c1uKdZqF
         7TKp3hwewje+lavSnmZIL/5FFgqbKmFNlAdArsPOqE4IFXidDWins5wqRWueQHKD0BUZ
         Nau9Lb6mIOHM+krShGd6rEIWUFBXu4zfW6KY1rH6tkhwjB0ZmvbD6BCwA/niaYTNyD1K
         U7fqwIX3pbbyeW2ocPCfMYaNkLwh4PjpD9cXwaWmMUqQ5NRN6OslyypCGrCBAO5VjyBT
         2JWCkTjHGvvD/xrVlBieIu84KRVyK04D2Ah8xmJsasLHWYXKblGLIF9qtydPdn5Axqdk
         e04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=g5YZm4UgAbGxYabjQSgq96Npr2NETq5PmOxXIUp4roA=;
        fh=VwuF5xOIkWh2ESfUkJWORAokCXKSgO7H2WfBMI2iBtw=;
        b=VKmDhZ+ez5jWVLCIs9+3ni3RV15tqW4LYuR1gUsRb0G5GMHOZQ1R5RcGE9CBhohvtp
         El7GSt960dqC2awHWUQ3TGvDXMz3aFJtTQH+BsQYO7vIrgY7r8TVdNztTX862Pc7fJbu
         /fZv+9XGvun+RYnLiY0fF3S5oPJl41z3EP5tRO+trV9pI+cKSeecodn04s99FPPBqXlj
         p56WYYSoWz6A2HZ7LU2nC4gzUEOAq577+WOgW5g/QyP9SOtyurKDhkDfAkwthmID8qLm
         GUpQSDkdpdsLmLZ31xc4BnRx1Ca9idj21kN6LbGhdmTwdBKf7x/R0m82yyJ1vOIT+1gt
         x2AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779215703; x=1779820503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5YZm4UgAbGxYabjQSgq96Npr2NETq5PmOxXIUp4roA=;
        b=gGAELiIjllEN2fO5gAg1oWXeDYJshtsvffzgK1Px5SGpE9SJIt5ufCwK3CHTtdnF8D
         wCyP2UeuOnlJu5f5bNS6wCYxJDbuAg6Dl0Z+3chkVT9KJvQJ1bCF+ikRTxM7lUwobhd/
         pMjtf8aGrSTwmfUOzZXrDxvIlA4ZMZQfgqtsarl7w9uciW6OmIBP6nM0Ovsng6okSutE
         3iuKJSZnSerFt9wqKESxm2LjUbNW5maq/Q5JgXw6Z67HWocs6pNxCdkhfzzmPUu3HLKj
         xDnEbIQTOG4uNqmn2+giEzxWysm0hE53qjRGxSH3Y6u6OIB0wNCwiT70YqUOAL37BMwK
         qyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779215703; x=1779820503;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5YZm4UgAbGxYabjQSgq96Npr2NETq5PmOxXIUp4roA=;
        b=nTDW3dzVWLDdj7npraG66QDkz80HMIFitmlLpcdUmZmCtY2snQwBVO0BZcdiLXDxrL
         0QaHhNfDHW7dZNZwhC0uqRWTTiokshBLZteVbDA3Weq3Qe+oBn1KfGLlR5ZbSMJG5cNi
         K8UOdZiDMkRekRp+dTonu09h9hZMFGtKh6s+qtzrOVvSgQIuVKLCVn/gioasaxYAFLxJ
         7KsifgjPWO95d0DE1bzYi90kcOfE++SoYHe0RstuEFFA9hhr8ryjOx0OAKpACmEwb14G
         SwC2VXWdXd7Gc6Pz4LfCaUtPMYGL0N9yJ/3LLcEMDCb2FcB7HmlNxjUH1zfhRqKNA4ra
         c2BQ==
X-Forwarded-Encrypted: i=1; AFNElJ9GP2Erfxza5EPDPpWov7oEnjtUTc7cC7Vba/saUgumTGjs36/DOb6c+SKgvKqt+hboJqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPT1a5bWm9Zo71ug+tgl08KVpJUBqm6M3eGowEpByVOqOLkhw
	Gu/Oh3LUVt1Ro/1PZqp72x/d+2MIfsc+R/yRCnHxx7mAURC6QVyhl+Uj06X8qsmAZwSA5nVIYN6
	2tBtF8PGU22j0yrz0Ogg0zv+y1WuChz8sYm7WGQyi6KBnIN0l89FYlnSt
X-Gm-Gg: Acq92OGtcmBiZC3fx+gzIpunisvZWPWmesCfNqU3r8z9s8aPP9YSVEjAeY7bOW5phfk
	a2abtg+zTRD5HbMMifdSs5fPE0JIYD2l5CpsDXkusOv4vjGbITXM52d/VWFajzr9DmNNV8zIlRf
	n4MYZzQW6+SQE0vZrr6hH53Mypq6Gz8GRBNQFEddQPiNohO4BHYsvC2BYxCtfuCi+bPFVxr6fZO
	5LiIBR8PRlXGgjswMujgtv5+2VJKBvMdZybv8PBv77N1oY8SPEyjycUbWwXLZqFdMv9jY/lqWZO
	Pa8ygTioOEgvOoRMJ0t58KHE/4BXXxCPlKxs4HK7ygdGw6kqbPjRiziHlKCmuqDcfN8mUxrDOSR
	OKOBA
X-Received: by 2002:a67:e70b:0:b0:62f:46be:8318 with SMTP id
 ada2fe7eead31-63a3cc0e937mr11563105137.6.1779215702359; Tue, 19 May 2026
 11:35:02 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 11:35:01 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 11:35:01 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <agt5A90k9lS9JPWp@google.com>
References: <20260518070943.2091287-1-ZongYao.Chen@linux.alibaba.com>
 <20260518070943.2091287-3-ZongYao.Chen@linux.alibaba.com> <CAEvNRgFgobnW+O=t32gu-0YDy0n7ZqvmdCtg+DzLT3uf0+BDeg@mail.gmail.com>
 <agt5A90k9lS9JPWp@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 May 2026 11:35:01 -0700
X-Gm-Features: AVHnY4JMb8xTVN3PiZl5iQlu_-bUy05sR1IlC9x-XipUxw6zHkFMz5hIRfmkZZo
Message-ID: <CAEvNRgE4o6C8P2jW_MGn=1BHxgmp183UTk_h5YkM+U_MCTMdzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Test guest_memfd binding overlap
 without GPA overlap
To: Sean Christopherson <seanjc@google.com>
Cc: ZongYao.Chen@linux.alibaba.com, Paolo Bonzini <pbonzini@redhat.com>, 
	kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
>>
>> Since this test program is meant to test set_memory_region, should we be
>> retaining the original test? The original test is wrong in that it
>> doesn't test guest_memfd's binding, but it does test that
>> set_memory_region returns -EEXIST on overlapping GPAs.
>>
>> Perhaps to just test overlapping GPAs we can use anonymous memory
>> instead of guest_memfd.
>
> Eh, I see no harm in having both.  E.g. if we do this, then we don't have to
> explain why we're not testing the other case :-)
>

Makes sense to have both :)

> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index 9b919a231c93..283392bcc3a0 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -510,7 +510,7 @@ static void test_add_overlapping_private_memory_regions(void)
>
>         vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
>
> -       memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE * 4, 0);
> +       memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE * 5, 0);
>
>         vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
>                                    MEM_REGION_GPA, MEM_REGION_SIZE * 2, 0, memfd, 0);
> @@ -542,6 +542,26 @@ static void test_add_overlapping_private_memory_regions(void)
>         TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
>                     "Overlapping guest_memfd() bindings should fail with EEXIST");
>
> +       /*
> +        * Repeat the overlap tests, but so that there is overlap in the
> +        * guest_memfd bindings (i.e. in guest_memfd file offsets), but _not_
> +        * in the GPA space.  Regardless of where there's overlap, KVM should
> +        * return -EEXIST.
> +        */
> +       r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
> +                                        MEM_REGION_GPA,
> +                                        MEM_REGION_SIZE * 2,
> +                                        0, memfd, MEM_REGION_SIZE);
> +       TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
> +                   "Overlapping guest_memfd() bindings should fail with EEXIST");
> +
> +       /* And now the back half of the other slot's guest_memfd binding. */
> +       r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
> +                                        MEM_REGION_GPA,
> +                                        MEM_REGION_SIZE * 2,
> +                                        0, memfd, MEM_REGION_SIZE * 3);
> +       TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
> +                   "Overlapping guest_memfd() bindings should fail with EEXIST");

I just noticed this is kind of odd, what is the purpose of "%s" and then
filling the string in with a hardcoded string?

>         close(memfd);
>         kvm_vm_free(vm);
>  }
