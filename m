Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEDA3C2B95
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371072; cv=pass; b=jsppZ2FP3N/Rcbjg1bfUmUiD/aJ0Ts9sfSHmHYhnzfSIaHKKDLJMFyl0WZ+D/vVk6hL93MumeKr21gRaFtienyaYT0j248bY96Q6ja8Zb6QpxLFJiusFCcN1v1CWUc9UBtAiafSeFj4Xge3dyUofvGi7zejKm/v4tKzFVeMpqMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371072; c=relaxed/simple;
	bh=zdplWEMU4ZutyOkbI+3SiQhFO5MjqtwHboLbHuF46t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYXbrYzok4WeQxanCDOvqO/lukVwd2pVKtpZfZoyJXmzEj7RZU9oO77JHQwkvAzq/o//VTnTwqh3tLDlueccxALRjOU3TLCFiSKnRJOA5/U103Fj9ONV94Tx3Oue2r1vne68iW0iQ0F1+XE39te/hynv4UqjrFsjGZYXZUvAB1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9sZA9BW; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9sZA9BW"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51765331535so124541cf.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 00:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782371068; cv=none;
        d=google.com; s=arc-20260327;
        b=WZlHSVUQPyEkpByg8c6ZsyASvZgMXj5u4gHw51GohQZHUZ9/CzvH5JfP5w259tlF0J
         P4ePWT6eUAVm09deO1A9mcKtNqR/yVgdYn2MiATxRXPKAjQG8Uy+KqUVWfhBj/iYcH57
         9tvnIZARPT/zVmhi5NMg5UsW3VnMo67iDTyeuGz6Du6VM83KUcH3JDbNgJltVO6LQoFI
         6HvLIamM9fapo3daqGgtWkXANuBsyYkwo56ou3acsQbM9gkhnSzDq0qLf7Rk4Ozqix89
         IHXnvFI+2OnBcPtgyWzAS8ocrWnRU03Wxz4UM53psfWI22PNviHHCilE1H3TIdGZ8OL+
         VpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EviLczuyy1yyIrBaIYV/LFmo2BGtZCvU6IS38nnd4b4=;
        fh=E7CrKe9w8gT+eXNjA172GumEPJ6BhDNa44+6siBNXjk=;
        b=FVLBPOfAuBryh69ugU4xHmLLFa0kOMTnB7UZM5qpEo/QfvOTR8N4ol9sBymD0I7hKJ
         YnWdkqYO9kY3ISGkQMjofC2MB/iZs4cvf/hau9JC0LaxhsQ01rd7z5bdEy3dVxvlYfIK
         i0zu8I05aQckV7+34NPPHuJtTXIeNkZ/S6nHU4QpoHsPbjGKg7T5kAUIT/MBFKj7hh5F
         5vP1PwM2nPhCUeS6e0rlVrnHdaO1I+Su1oYUmpENIO9LFOnCPPp7WeCvDWBtVjq2xXRh
         KP7v0ILDchrl+5x5JaUzons199sJkZ2tD6xIwpkzZXEXPVe5c3o24/xmD97yqJBtlR6n
         a/bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782371068; x=1782975868; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EviLczuyy1yyIrBaIYV/LFmo2BGtZCvU6IS38nnd4b4=;
        b=q9sZA9BWKj8e5gAjlUeJer2U2/ygGOKPecKmhNST+2LJBoxivs8AJXXFykgll7PRWs
         yihfiGuo62y6GSheBuKyR/+LUCGaz6m1TKOXQCbY7gr032+Sv8cyOeCwJ3fHtNNnrlvk
         ghglZnhiy5IOkjZmJz7E8N7AcVq2ZwXQ4BY+siJlDAICY3Lmasm7aJrzNAaCXL0jzQr+
         e0Ql3yaWSYiqPAEA2wJiHk4u8un7IrseLEVKwdisFxMHQDYRTFZ6MgW9yhltmVdKimE4
         Ja4a9271KjF0etmXnh1g2SlwlCVDG4CWteGt2IpuwKNiJL6z+ALUcRaAbLlQrVlCAYVq
         Z4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782371068; x=1782975868;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EviLczuyy1yyIrBaIYV/LFmo2BGtZCvU6IS38nnd4b4=;
        b=Q+7SbWLooD8c+XydVYMvQhZv7zepPxhNVrm7QpUz0FaGcCW7piwgu2Ve+I3zMgCVjg
         Y7wcL7I15ntqh6M3DY2nOmYsQPqxn+RW3reg5voE2+Df4vh3LBw7jIXLlwPV6EmzbLgn
         tLbeYjZCGt9V44qUJ+8bf8f37hOU6dYPgVDjCxPlP9LSCGOFnOhP1U/cl/pYE16QDdTu
         xjSY5GdRBu99STyTowBVTHMAoKNOggW7JmlO1Aj8Hn+ChCktqKLVGGPTDwV2hLe9FNS9
         dUGBv+4B4gbR3YKs42Fu31NLJDzD3NlHPueOhqP+/FBP4rgEem8ogv9vW8B/R/LpfXiq
         gDFA==
X-Forwarded-Encrypted: i=1; AFNElJ/p+bwLVtFUy/Krs/3ER2nP+zuO6tHI1wvjTeCLKskMa9BcP2oCOWd6xZAEWF93aUtFEo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvz1W8mu3qTvieqrCzKIJl1d/TA2x9ZY9Qu86q81MuufFrtC7l
	BUqcvcbfKWqgVzpU3DYxGycvIoYubPJW3E/MCJg7kqvPmI9wia+bOPC+QLcLSwX2ugXZWCLtBOW
	FGt7U4taWnym+Rj4iY8eRIf78mmcr/7eab7b0fhRY
X-Gm-Gg: AfdE7cnLj8mAlBNZiquIbnbji42tFdmwkpWk22c7P3fWEz0kAAHUpS9u6k9EyimpqJY
	KbHVZhQgrbsXrSrZHCKAZhDG5T1ai3KQjr2L1ndbXbxr1vuVePDhWJJE0FzWcONBuApvziUTOg3
	57H1t5EzdLElW1+9XSjbyQC8lDex+SyP0nQPIZqQULdqYnvlHCJ0JdmQ6na0XNxMEaGcWCUM0Fe
	IzBE6ZipfKt9HRW+T0ACaUAbhS58pJiBwPmZSwqpam1KBnj02meYeblYC78qriLTA+twEhamw==
X-Received: by 2002:ac8:5a88:0:b0:519:b655:235 with SMTP id
 d75a77b69052e-51a703faaaamr4395391cf.3.1782371067208; Thu, 25 Jun 2026
 00:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-36-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-36-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 08:03:50 +0100
X-Gm-Features: AVVi8CfPiivQ2jTF4C4b2T4SW03MiAlvIrJh5OdhMlg3bv2FAUX7zsWQXsWcZEs
Message-ID: <CA+EHjTzFUayXCh2SBe7Nwu7YEO3aUmL1Fo1hE_v8OvUw7MWO6w@mail.gmail.com>
Subject: Re: [PATCH v8 36/46] KVM: selftests: Test that truncation does not
 change shared/private status
To: ackerleytng@google.com
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

On Fri, 19 Jun 2026 at 01:32, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> Add a test to verify that deallocating a page in a guest memfd region via
> fallocate() with FALLOC_FL_PUNCH_HOLE does not alter the shared or private
> status of the corresponding memory range.
>
> When a page backing a guest memfd mapping is deallocated, e.g., by punching
> a hole or truncating the file, and then subsequently faulted back in, the
> new page must inherit the correct shared/private status tracked by
> guest_memfd.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  .../selftests/kvm/x86/guest_memfd_conversions_test.c       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> index 0b024fb7227f0..f03af2c46426f 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> @@ -10,6 +10,7 @@
>  #include <linux/sizes.h>
>
>  #include "kvm_util.h"
> +#include "kvm_syscalls.h"
>  #include "kselftest_harness.h"
>  #include "test_util.h"
>  #include "ucall_common.h"
> @@ -309,6 +310,19 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(unallocated_folios, 8)
>                 test_convert_to_shared(t, i, 'B', 'C', 'D');
>  }
>
> +/* Truncation should not affect shared/private status. */
> +GMEM_CONVERSION_TEST_INIT_SHARED(truncate)
> +{
> +       host_do_rmw(t->mem, 0, 0, 'A');
> +       kvm_fallocate(t->gmem_fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page_size);
> +       host_do_rmw(t->mem, 0, 0, 'A');
> +
> +       test_convert_to_private(t, 0, 'A', 'B');
> +
> +       kvm_fallocate(t->gmem_fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page_size);
> +       test_private(t, 0, 0, 'A');
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
