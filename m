Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B204026CE2C
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134709; cv=pass; b=fQs0fQV9OStS/PTVgcNSAZRs+6LreRG8Qh3KQazQ+uPEwuAMsNYnIXm4sE1DAudTm0gw+xqCI02x9Hr96ifE5YXjjGwjANc4pKdm5bd4OcLgSlT9xbSnd18DuPQ5+B6QP43bq+TTLp3AkxMArqPjxD55AXiGL2reoIbFOPser5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134709; c=relaxed/simple;
	bh=fGDWFtOBKfjZJNEB/V2j3tDwuKJfxKGoa79UynO/y6s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmbzkqXvDdjnHLhr1RNhYndSscmrEE+sVFpLXo9wzhxVgpHPRN+I2Dme8lHjoW+8LAlmu/clm59BDtssUrkQ0O9smbpfPztAwQBFmJiJ5Eup7r4phCRAE8JTyUNn9/CADTZkVP3UfDP7qLQa+Zr76MfEwNQgStwLsxkE2z0jwz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pbk7VrKL; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pbk7VrKL"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5751e12c524so826273e0c.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 13:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779134707; cv=none;
        d=google.com; s=arc-20240605;
        b=jA7P6mVqFqynIsV9k4BRlvKqPta4VdFu8h1M9ELjoGzUeIyT713MY5IBP/wi/9Cgpd
         u+sazFpqLyRGnKPMoGdb0rGguRN0IXrWV5En8M0nuvam8rvjiUZ2baThIEJX5n09ouyH
         PZsCpjghZo+c25iyKQN54I62gZT2qNhnSfQREg5EWOB7lb3bJX92IlP/NKbu5CsYuVxX
         CMySaz1Nt1Wb9H+qDBi/VIwuMlR98JA7qMifRqSuodJQEk6Q97GMdG8wcLG6WtPdjz5K
         g4K3HPdvuTEEKzyIqbnuHOvoyOf6Zr+atoD/TuelHhhdt+SYhTuX2oDOFOs4kEsiJrOH
         r3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=glQxNdgLK/pIJ2vL4my5atUrPxfPqi+r7bSAfMQrWYw=;
        fh=oHfFk2q05rRlUhj3CLMFgDT/HinNQzTZYNWp7ZPtapc=;
        b=JzvJJAWxN8TK6BVlrxRy1DMFG0X30WotJYXgwpsi0cavP5AxFYzCqOSrs+VqwA7P7y
         bHIVSrGNsxWwiur3+oru1B/UuckwYrU/5vXsNHeifw9TBAcKL6reFBxl5CozeNBIL2+4
         tb4fnVYt2PeZPcfYFuzCZHcugWWxCOqp1hhDD2VOa82ugq3+ra/EzKWKS4E+v3HEJHVL
         ah8AKqmwxS8jpBs+3DEKXXMYnVHsKETN3AkvPVewSzWfKfs016w1cVjVqUL7+osZRn/P
         SdAsTP8KhjG0ztNkCEM0efniHU51whP6LbQnhrTDUjg/h8WYoHRJIODF7eHt+mOSDWIq
         28Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779134707; x=1779739507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=glQxNdgLK/pIJ2vL4my5atUrPxfPqi+r7bSAfMQrWYw=;
        b=Pbk7VrKL9bMcuXxS7XixuRfLBiFjhqvrER+YKwx3OIiqXlHokWfZoE2kztiEIuqK3G
         LPyPZm56Al5cWpQ1yRrLFWMaq0q0mklpBcJUjOArfLM6/oTs4p2eGoDtIjIPDM2MF4aZ
         1/TtCrBPqI7fvyk3OeJLukHWJUopMB2+w7D8hJfK9Vp1aCZxtLia28m8N2JAqD75vpoY
         CYPxfUuYUNq/FLIjD7xOGfKleVLWYBUI8s8LWriF7th6Aqejj4zj5rGXxXoKUt6pHq83
         W+uHU1u81HkK7YT6cXnYGovxB2Xk8W1EHwxKhoPtgoN2LU5F/ZRosdMwZJUfu3BPqpGU
         z1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134707; x=1779739507;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glQxNdgLK/pIJ2vL4my5atUrPxfPqi+r7bSAfMQrWYw=;
        b=kxAJIu8oo6Qihqn1vaIjsEaouGX+vogI6TSRRYp/9OgbxAeYc8bYYJEkzyI2RoX3Bj
         sXdStWBL8876jg0hZF5hFvJYlCocLGlmxBcX++40AWiU+DiM7ij1Sb6NGKqgM18hsh8Q
         jQikBB+Zh64cAjdR7FD9uuDS8q5QMhohH58CjrXbhYxHFGn07028gBFxdEqZoew+ObER
         FZGNtobWUyOMe4adhsHhsB65EaoHqGWJPpLrY0qOWXqWosjB9GbZp9Ai5je1L/vPNhqN
         32eEOBxT0Ac/Uu2paRKij4YnZ+ZattIV+rK23CjQQhE21IfRArY+cYSHKueGRx7gjW4d
         CzHw==
X-Forwarded-Encrypted: i=1; AFNElJ+xBh2MAvpIWViq6HsZFQmOfFM3aKCr53KrL6jsvEJqPHWjgHewvBbl6vP1DiJk5ezv9GM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy13AI0zIwLtV45l2NXufj48kpRvoRK7GQfKjBE2CzTpgACNGg9
	6h795ZwejzbjLJKfPSBEecQe9GH3uXUz8xabelhEoNTpl7s0VivmxE9JM1OWteEUBFzPBTJ3NcK
	apf7ea6SiOaSPsjmRSE/1WzUFv85t9UCMSfQ52qOa
X-Gm-Gg: Acq92OH3RVba+vzIc1+I1sVcHRDCKhhlxq3uvVJWBUwm+i8/1VQt8YxSsXy5VBv/RZ6
	WFqyPNZEGWMM/VGAkxxTFqSqQ8sOK5uuCgzjWz9D28B//34RQtTd/2l5UapauBiCfDefRs9rYg0
	eNP+68qeLaMam4BA/ZUYjM2qUxxUcftyyyZT1fVEigx7vkWQVSt52EkvvssG6YFieaJCMt0rqHB
	PXEYKFNEh1CLZ+mqWAS93HuWhMmzMb06SmQ5SmgiAVlMx9L1dEns87id+249lXMqiNRH16DGK1v
	YIfODInYUJL1d/zMXpFCs2DNxy/DVJcelhD9KZpxskKzIpFfakQTBM67838Hz2nNHviu6yyMUI6
	5bedz
X-Received: by 2002:a05:6102:10d2:b0:65a:fcea:5a8 with SMTP id
 ada2fe7eead31-65afcea103emr1750266137.3.1779134706025; Mon, 18 May 2026
 13:05:06 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 May 2026 13:05:04 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 May 2026 13:05:04 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260518070943.2091287-3-ZongYao.Chen@linux.alibaba.com>
References: <20260518070943.2091287-1-ZongYao.Chen@linux.alibaba.com> <20260518070943.2091287-3-ZongYao.Chen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 May 2026 13:05:04 -0700
X-Gm-Features: AVHnY4J_F_OblcICyWTeoEnuPCNoexxjBKD7qo6aV_V4XEGTmZ1hiCbzwRoXxrk
Message-ID: <CAEvNRgFgobnW+O=t32gu-0YDy0n7ZqvmdCtg+DzLT3uf0+BDeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Test guest_memfd binding overlap
 without GPA overlap
To: ZongYao.Chen@linux.alibaba.com, Paolo Bonzini <pbonzini@redhat.com>, 
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ZongYao.Chen@linux.alibaba.com writes:

> From: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
>
> The guest_memfd binding overlap test recreates the deleted slot with GPA
> ranges that overlap the still-live slot.  KVM rejects those attempts from
> the generic memslot overlap check before reaching kvm_gmem_bind(), so the
> test can pass even if guest_memfd binding overlap detection is broken.
>
> Recreate the slot at its original, non-overlapping GPA and use guest_memfd
> offsets that overlap the front and back halves of the other slot's binding.
> Expand the guest_memfd so the back-half case remains within the file size.
>
> Fixes: 2feabb855df8 ("KVM: selftests: Expand set_memory_region_test to validate guest_memfd()")

Thanks for fixing this!

> Signed-off-by: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
> ---
>  .../testing/selftests/kvm/set_memory_region_test.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index 9b919a231c93..15607e0bec90 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -510,7 +510,7 @@ static void test_add_overlapping_private_memory_regions(void)

Shall we rename this to test_bind_overlapping_guest_memfd_offsets to
make it clearer?

Perhaps also update the pr_info() to "Testing binding to overlapping
guest_memfd offsets\n".

>
>  	vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
>
> -	memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE * 4, 0);
> +	memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE * 6, 0);

I think this technically only needs to be MEM_REGION_SIZE * 5 for this
test to work.

>
>  	vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
>  				   MEM_REGION_GPA, MEM_REGION_SIZE * 2, 0, memfd, 0);
> @@ -526,19 +526,19 @@ static void test_add_overlapping_private_memory_regions(void)
>  	vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
>  				   MEM_REGION_GPA, 0, NULL, -1, 0);

When I re-read this I was wondering why we created and removed the first
memslot. Was it meant as a confidence check that set_memory_region works
with the given MEM_REGION_GPA? Perhaps we could add a comment/pr_info()
to check that.

>
> -	/* Overlap the front half of the other slot. */
> +	/* Overlap the front half of the other slot's guest_memfd binding. */
>  	r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
> -					 MEM_REGION_GPA * 2 - MEM_REGION_SIZE,
> +					 MEM_REGION_GPA,
>  					 MEM_REGION_SIZE * 2,
> -					 0, memfd, 0);
> +					 0, memfd, MEM_REGION_SIZE);
>  	TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
>  		    "Overlapping guest_memfd() bindings should fail with EEXIST");
>
> -	/* And now the back half of the other slot. */
> +	/* And now the back half of the other slot's guest_memfd binding. */
>  	r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
> -					 MEM_REGION_GPA * 2 + MEM_REGION_SIZE,
> +					 MEM_REGION_GPA,
>  					 MEM_REGION_SIZE * 2,
> -					 0, memfd, 0);
> +					 0, memfd, MEM_REGION_SIZE * 3);
>  	TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
>  		    "Overlapping guest_memfd() bindings should fail with EEXIST");
>

Since this test program is meant to test set_memory_region, should we be
retaining the original test? The original test is wrong in that it
doesn't test guest_memfd's binding, but it does test that
set_memory_region returns -EEXIST on overlapping GPAs.

Perhaps to just test overlapping GPAs we can use anonymous memory
instead of guest_memfd.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>

> --
> 2.47.3
