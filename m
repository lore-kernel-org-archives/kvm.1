Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB4D37C0F6
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373290; cv=pass; b=Sr38YTa0X5fWN/jFLsuIOahC5XLoExcIniHalESvb8sVrEcBY7swyztg8eAHjGTL7R+eCJlW53KbUnj2U2jUEnq2V0Ftw7Re0rY23H7nY/FyhsRcQVp21b8yoUl6BXHa2LLwM/LlWqic2rtwbrKeHurLAXZfw1uzPZI0DOrql3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373290; c=relaxed/simple;
	bh=Qvcbq0DaasBf8gUW2nSthq4nzSVZglaEH511+tU5N4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLTC4GHaYlsC98gs/Ux8ofXRYuOQnB+9+9lNqr381Y+NtKs1RA1yupkOIVhDC0vCYpDeK52OssNQ4TQLWGSRkJZsePq4N0L1N2M7hccp4rd8QjGCEuiIUzLy2YCkyPCrfGjrXhcheQ05EwsIBXfqT97JLUKxncHW5KzUTM9d6I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGr6iSYC; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGr6iSYC"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51765531803so170071cf.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 00:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782373288; cv=none;
        d=google.com; s=arc-20260327;
        b=EL7mzw+8vPUROLtFbUGLVA/thlMkfK7GUOtzCfT+TUxQnIR+5FqrYlXXafhEufmJtn
         QP0t4sSmMPNk6zhTq9CO0yLGquE6Fg/fotUaokdKeuxnd0T93HvYOJ33Fm91ZMxxpZYa
         e65JhMVC/TXa8arqmvWZ5IOPk/ubrWvU3g4UIP5t5s3tLKtmayUeJ8epeQcTPbQAfYw5
         La4AerJjU8GxAk/ppopA5Km9FLwrRz/0y/nmF41qpRNFK8IcxHpovodPsJR9u4XEmy5i
         NRyRlQEx/K8dUjleWIjiiUz+m/BPVaRB4xsym4yEfYZhNbj20Yods9b9u/PRAW0c8DvQ
         1JNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IKDmrHuQqoBYlM3iNILSe07cr8MVKcj1ghLIbtUqfRQ=;
        fh=JGHf56ujS5MaQAkguj47FRJdcLgf2/2t+0j/daJEGSM=;
        b=LEDIlk9LNCQYU5MBBq7V+kaqi63Vgwik4izHXpLqJTWk6Fvn718l7Dg76EaQgotRuj
         dewM1EASB1DXn21yatJ+ajwoCbAS5V1mINHHQs7Gz4chDHFfbkEYSdsgRDw18SWHBq6O
         uN7+niwiPphtRFZgL2StfED0cHvo+skV9C0qaPnKVK+QusbDD3b8c3gADhkaaytoRfcB
         f/qlENpUR9iwKI89GN7WCTAS/ccO6i2rNOGoB8mkDOCWzRoFek5cnU0u1re99+fP0VJs
         RtzPX3NFDYws0sD5BEtxeS565GyakQj1q/bmi3lMgb0doqwwAZ+QUxGb8pytfeze4Yj9
         q+lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782373288; x=1782978088; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IKDmrHuQqoBYlM3iNILSe07cr8MVKcj1ghLIbtUqfRQ=;
        b=NGr6iSYC+lcEY55yFPE7kO3jc2Pu8i1J6RoSMrYqEIbTdJ3CEbSVgVnCgzL/UKk2Do
         fKTDTSt7T5e/oRhc644gpHbhhX4RBZfcfmf3ouTXUyq08gC30xPF3DrvuBx4GgZlXkuv
         7t0fAHbGQKDulVnxOiV8qer1BHa2dLGvY6wGKnQlrRqH5r2mUyW/JDupPnDicElJzAWL
         kLnihC/jAz0YOwy0MdTqu51lrA6KzSN8xPrDR2QzFz1qAqBaSqtoPh7EvAwJVwMnKq3O
         TBg+2Jf+G2sJPEyRLK6wiFpYzCiTq4AmkpZhSTqpEw/0aTNbsA78Se5lFRCnqYrCYHJz
         c8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782373288; x=1782978088;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IKDmrHuQqoBYlM3iNILSe07cr8MVKcj1ghLIbtUqfRQ=;
        b=eYzXUFp64sTTExpMQBoWz9oNwJzHpIwIIkdHhz7TbA+NE8ZN5TBc4C88HEI/PjJ+do
         nI1pGZGsst/HjDgH/WVKOTLpWPnzPzP0lwOfPR394df+F/HKRwjqo57mBvObLSCBElB2
         yYkk5hB9qfz1/eQUrf1FU7QDfNb5k1lOutx0ntoVQGRzmlK0W08L6ONqQK1Ja3jgsbZM
         ooaIoIKMmMvKCtwxVO5MVoEGVN3jjWodHr3NrcTd64ChwQYFpLudC6GoAQAeT1kLZ3Z0
         SVE0/N9MDK4UXpRZQBD9nU8vhofeLqe8vhywW4WXWAbyYCrIyy8+O/MPcpQR96JGo3I9
         hDbg==
X-Forwarded-Encrypted: i=1; AFNElJ+QXDonqiZNmRyKc15rS3p3dx0htYGwd1mEfq2XmbLPXldZ+b6/F/ioeOBnrfIDTXwHtrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwugKxOWN05fIxWKXv6Lgo8YtDLV1NplMsp27Uuza2EI3bsH0kl
	ZzC95Q24pZWOuIkCKf98zJ7lI5tFbHYkd+EvQmfv/3e9skZXLR3ntrE+f/pwjr2PQ7AcxT5BYlC
	OiJ8jfC6tOxUMdgbPZYzrL7ji/w6PLK9PyaXzZ3eg
X-Gm-Gg: AfdE7cnjEc1rvdvmNg2tWmIIGrEFke12Zf/sz8QydznDqw/vBh+STpiTks93+MxynIF
	ONe7quohI8sqWZ5rEv+2jadFTcVObBJg/iuTCS92lgHWvxC1rUYsQDxE6PgAmr1W9jYfzuREJXy
	tJtOK6oxkvg0AWFEThmRFivZGaPRc+So7eji1M/G2dKrqnoqyZWsg7cRtHxzpYozDTBmIWcDap5
	jGXbtSJb0I956JLFMWSnhuEUoz5cxFVR9zlxsNqhMPVFGZz9aXkJG1To69hLUMPLajXkJDqyA==
X-Received: by 2002:a05:622a:120e:b0:519:56a8:2693 with SMTP id
 d75a77b69052e-51a6ebae001mr6553451cf.24.1782373286970; Thu, 25 Jun 2026
 00:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-38-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-38-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 08:40:00 +0100
X-Gm-Features: AVVi8CdNvXe7DIQJSIUqqBW3OCX6JP2NJsxm61_dCUo-WV2w6fSxq-mU03dKtt8
Message-ID: <CA+EHjTzEGxZQXPPsY5nynYf6ts+Jt3TBevgLpPVyHDqf4i7RGw@mail.gmail.com>
Subject: Re: [PATCH v8 38/46] KVM: selftests: Add helpers to pin pages with CONFIG_GUP_TEST
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
> Add helper functions to allow KVM selftests to pin memory using
> CONFIG_GUP_TEST. This is useful for testing scenarios where some page has
> an increased refcount. such as in guest_memfd in-place conversion tests.
>
> The helpers open /sys/kernel/debug/gup_test and invoke the
> PIN_LONGTERM_TEST_START and PIN_LONGTERM_TEST_STOP ioctls. Since this
> functionality depends on the kernel being built with CONFIG_GUP_TEST,
> provide stub implementations that trigger a test failure if the
> configuration is missing.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

nit below, otherwise:

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  tools/testing/selftests/kvm/include/kvm_util.h |  3 +++
>  tools/testing/selftests/kvm/lib/kvm_util.c     | 23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 323d06b5699ec..79ab64ac8b869 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -1195,6 +1195,9 @@ static inline int pin_self_to_any_cpu(void)
>         return pin_task_to_any_cpu(pthread_self());
>  }
>
> +void pin_pages(void *vaddr, uint64_t size);
> +void unpin_pages(void);
> +
>  void kvm_print_vcpu_pinning_help(void);
>  void kvm_parse_vcpu_pinning(const char *pcpus_string, u32 vcpu_to_pcpu[],
>                             int nr_vcpus);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index b73817f7bc803..524ef97d634bf 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -18,6 +18,8 @@
>  #include <unistd.h>
>  #include <linux/kernel.h>
>
> +#include "../../../../mm/gup_test.h"
> +
>  #define KVM_UTIL_MIN_PFN       2
>
>  u32 guest_random_seed;
> @@ -639,6 +641,27 @@ int __pin_task_to_cpu(pthread_t task, int cpu)
>         return pthread_setaffinity_np(task, sizeof(cpuset), &cpuset);
>  }
>
> +static int gup_test_fd = -1;
> +
> +void pin_pages(void *vaddr, uint64_t size)
> +{
> +       const struct pin_longterm_test args = {
> +               .addr = (uint64_t)vaddr,
> +               .size = size,
> +               .flags = PIN_LONGTERM_TEST_FLAG_USE_WRITE,
> +       };
> +
> +       gup_test_fd = __open_path_or_exit("/sys/kernel/debug/gup_test", O_RDWR,
> +                                         "Is CONFIG_GUP_TEST enabled?");

nit: should you close this/reset it to -1 after the tests?

> +
> +       TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_START, &args), 0);
> +}
> +
> +void unpin_pages(void)
> +{
> +       TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_STOP), 0);
> +}
> +
>  static u32 parse_pcpu(const char *cpu_str, const cpu_set_t *allowed_mask)
>  {
>         u32 pcpu = atoi_non_negative("CPU number", cpu_str);
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
