Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D381383998
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379811; cv=pass; b=cD6Zx0qXyMwm20Or5/FKIxQeEzrtCA84F3YUKsFiSg7C0u9naFUxCfHObG3Du9DJtWPkpndicavsJKDUxl1Ov6fSEII+7FYP2xODZCpIiaHUzEFzRtdUZcnGF66q9/0k6WnEeroUtc0S9oUpxOW0Jhx1sZZLUonfQ351Hzs/xFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379811; c=relaxed/simple;
	bh=WU9qgw2wyQ4Db0YV1GPH6pGz3qYi1wBkaN9pDyH60hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDHcpNiB1mkx0bqcYvBVhwK9RxlkzQpvLBcTx5T4CFm9X2ONmXI2QtFG92B2zMnXVqTZf8amgy3O4KigDFfVGFNlhQ98L3uXIpC5zXE9/BPVa50R9aAxJdCBNK9qLFmVg3ik7A0KnB69yJm/4Ocj/HQlGfBFnrjp3k+Lmp5zeas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tvxH3G/7; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvxH3G/7"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51765531803so197421cf.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 02:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782379809; cv=none;
        d=google.com; s=arc-20260327;
        b=GPkA3NLJeCLVWNTlNv5yMijXzzrk+3YVzQolAXsxQagWmbkHZPByoTSa/Z3sbJThLe
         uqwrgeExxksZuefxyPv4FD7vgnwnD5Y8fc22FAy7V3sfm1w64s7w/BEgsB8z36QBsFJw
         f5yRtrdw/nDeibfcJzE+95QQrGNn0vPNFkbzRY5vPnMBtJBnkUOdmxprHdqguyrhsBUD
         4WsM8hbx+6QM4lwuidoIZs+bRjUjME9LHYrNTfPnI4WRkBJXBI2UQoN0Hg5JLTt8NdV1
         AH8sv3IO/8FOLiaCcUhcDlna6lySKgeRaYpZzCrFPBPCVTeJ69D28OIAo2RGS2RIZOqf
         cFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HWFN45t67ilSUVNbHIGobHGAf81p04HluCZmKDev2qM=;
        fh=Ged+Mov6n0ZTK8mT0cK5inKp0kSSBNM4AXwgLcGmfsg=;
        b=JzDsAfeuCCujhFMAw0ppm5CkBRYxtRRTnrK4oUz6ikhnfnMJ2dCwPDKK3udqMr0KkM
         Fn9tAIRlNEJfbO/HSyo6BPVyxW6HSiYsL2VZg2UI/Eox0+2HaGE/lPQFUIFCP7DAHevI
         dtXEr/t2dayJjJp5AQXwGg6NoOTL4N8fJZFxKW8D+atZx/EWKhnwRzHsJLTyrTFLAQW4
         CcFWs2k6CGQ/qpfkCBlNtIMgipxKuxETRQL0zjAxC2fKu8zQhYy4YZ4JQ2+KSg54Vgb/
         ZU4ddyb34BywqihXh8JaVnDgfFUUVvbpDHooAIO5PeAWkUKO6s+c2Hrpo7w29XvcMZHE
         KZEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782379809; x=1782984609; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HWFN45t67ilSUVNbHIGobHGAf81p04HluCZmKDev2qM=;
        b=tvxH3G/7kMZP2d/9snzm3SgKHl9OAzqD+weDqyVWYS00gsgpwyJ7Hji23QdF7Brrj7
         peUU2Jl9OkvEmVl0NG9UDrJWNiGEkRxPKT6H2zLYpZJ74RZonF0jMqqOl2TyrhWpSeXr
         v93i1JfqeCuxCiGLk+xOgphCVTBAVLlFFfW4MjPlR2S2m6luwDPTbI98ygKXveD/PQad
         EWfbKN5xtVh+vN1xDeHj0CqgkWeG5O/559GKWOqGtfycaqducC7g4UKsoZ7YL2nCWTMJ
         jPqovba7zwd4E9tc1Y9mcVOQUD2o65odiYBEGs1xDotvhhA+CUbMez2a3AGmi5YVPT0u
         /qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782379809; x=1782984609;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HWFN45t67ilSUVNbHIGobHGAf81p04HluCZmKDev2qM=;
        b=hQVOZqhzNYPFeywg+ZqU4pRcApaB1p45/4gCOdTE9qouNJ4MvN/FMVGLhT+fTH22BI
         QJ8rwJnGmwjNYAtXYa3GmVpU24mS4uzs9cDsSF330y9qcPLjbyVCo6fzWpQLEbassxez
         cB64jwWpSL5eeHXSHHo7m2IpwvOEbXiwS8fL7rLQc3vcD5nC+zhvowxq2gqX06GTpjyc
         HC6qGxkbeN7hq0PeABgxa39pXLy2sq94JXrsS8tR3QYq90v6Y6r8nbxbGTfhBhPie2N+
         1E9//naJaVAas9y3DV8DIbPWAF9NLcz8jGH5WHYk3kRu7ULucTD3Xn5I+8uxFvf+4Kao
         dM4w==
X-Forwarded-Encrypted: i=1; AFNElJ/Its1yU4cOoKt0cO8h2olvzeZHtxhJZ7gyknyV9zQG/Xp1RzUJwdHi8SoK/jG6Po7cCGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFpTigTeUiZZ5CQaXR0XshlEleUUKOLzO4vKnvXcKsSD82QUJX
	eSiJkQWOSFCoKBs9YoG+Q3rJvKVox9knFzdmPTpN4hEGPAqVbs2Qqrzx6zuX0volHoLkJsGWZ7N
	CsnblkpozEcPesYN1w9/V2VHMegCQINZVkWMW6Dbd
X-Gm-Gg: AfdE7clQzr8G5fRKC+rYsiS7oquPLnalAvqPlDnA/kO08VWLY4NWl5KTLDFRQrkgaT5
	AZWGS/BVsJsIWeEDwkJZ47pnyyBy670hIXstXTlpXcTxgraQJArP4agg00mJLyGfvOODXmrhTjb
	QanDpViCZ5+nNnTgrXQJIXl8rG6MJo0CMWn25nL3uc+JNlPwfZD4cXuda0qPnomAMNaCiZcgaW1
	qqPM4RZMAkYXRZ13uusTQaBKyn19ULg/nJrzZiy1hXEdgto3VTHm2bpXVazlB3H2JipuNB8kw==
X-Received: by 2002:a05:622a:228a:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-51a6e9a113bmr7270171cf.10.1782379807934; Thu, 25 Jun 2026
 02:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-44-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-44-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 10:30:00 +0100
X-Gm-Features: AVVi8CepKPjvM3Enq6RbicrK2LVKri7rowcdAQD9hRsLWhakG_kPU-ncpztrsII
Message-ID: <CA+EHjTzL4yfp2mUqE+_FdoDLVGdpdh8Gy+gAwe3FvLWXwkOFog@mail.gmail.com>
Subject: Re: [PATCH v8 44/46] KVM: selftests: Make TEST_EXPECT_SIGBUS thread-safe
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
> The TEST_EXPECT_SIGBUS macro is not thread-safe as it uses a global
> sigjmp_buf and installs a global SIGBUS signal handler. If multiple threads
> execute the macro concurrently, they will race on installing the signal
> handler and stomp on other threads' jump buffers, leading to incorrect test
> behavior.
>
> Make TEST_EXPECT_SIGBUS thread-safe with the following changes:
>
> Share the KVM tests' global signal handler. sigaction() applies to all
> threads; without sharing a global signal handler, one thread may have
> removed the signal handler that another thread added, hence leading to
> unexpected signals.
>
> The alternative of layering signal handlers was considered, but calling
> sigaction() within TEST_EXPECT_SIGBUS() necessarily creates a race. To
> avoid adding new setup and teardown routines to do sigaction() and keep
> usage of TEST_EXPECT_SIGBUS() simple, share the KVM tests' global signal
> handler.
>
> Opportunistically rename report_unexpected_signal to
> catchall_signal_handler.
>
> To continue to only expect SIGBUS within specific regions of code, use a
> thread-specific variable, expecting_sigbus, to replace installing and
> removing signal handlers.
>
> Make the execution environment for the thread, sigjmp_buf, a
> thread-specific variable.
>
> As part of TEST_EXPECT_SIGBUS(), assert the prerequisite for this setup,
> that the current signal handler is the catchall_signal_handler.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  tools/testing/selftests/kvm/include/test_util.h | 32 +++++++++++++------------
>  tools/testing/selftests/kvm/lib/kvm_util.c      | 18 ++++++++++----
>  tools/testing/selftests/kvm/lib/test_util.c     |  7 ------
>  3 files changed, 30 insertions(+), 27 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index 51287fac8138a..bd75162ec868d 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -82,21 +82,23 @@ do {                                                                        \
>         __builtin_unreachable(); \
>  } while (0)
>
> -extern sigjmp_buf expect_sigbus_jmpbuf;
> -void expect_sigbus_handler(int signum);
> -
> -#define TEST_EXPECT_SIGBUS(action)                                             \
> -do {                                                                           \
> -       struct sigaction sa_old, sa_new = {                                     \
> -               .sa_handler = expect_sigbus_handler,                            \
> -       };                                                                      \
> -                                                                               \
> -       sigaction(SIGBUS, &sa_new, &sa_old);                                    \
> -       if (sigsetjmp(expect_sigbus_jmpbuf, 1) == 0) {                          \
> -               action;                                                         \
> -               TEST_FAIL("'%s' should have triggered SIGBUS", #action);        \
> -       }                                                                       \
> -       sigaction(SIGBUS, &sa_old, NULL);                                       \
> +extern __thread sigjmp_buf expect_sigbus_jmpbuf;
> +extern __thread volatile sig_atomic_t expecting_sigbus;
> +extern void catchall_signal_handler(int signum);
> +
> +#define TEST_EXPECT_SIGBUS(action)                                     \
> +do {                                                                   \
> +       struct sigaction __sa = {};                                     \
> +                                                                       \
> +       TEST_ASSERT_EQ(sigaction(SIGBUS, NULL, &__sa), 0);              \
> +       TEST_ASSERT_EQ(__sa.sa_handler, &catchall_signal_handler);      \
> +                                                                       \
> +       expecting_sigbus = true;                                        \
> +       if (sigsetjmp(expect_sigbus_jmpbuf, 1) == 0) {                  \
> +               action;                                                 \
> +               TEST_FAIL("'%s' should have triggered SIGBUS", #action);\
> +       }                                                               \
> +       expecting_sigbus = false;                                       \
>  } while (0)
>
>  size_t parse_size(const char *size);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 6b304e8a0e0d5..b4f104436875b 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -2292,13 +2292,20 @@ __weak void kvm_selftest_arch_init(void)
>  {
>  }
>
> -static void report_unexpected_signal(int signum)
> +__thread sigjmp_buf expect_sigbus_jmpbuf;
> +__thread volatile sig_atomic_t expecting_sigbus;
> +
> +void catchall_signal_handler(int signum)
>  {
> +       switch (signum) {
> +       case SIGBUS: {
> +               if (expecting_sigbus)
> +                       siglongjmp(expect_sigbus_jmpbuf, 1);
> +
> +               TEST_FAIL("Unexpected SIGBUS (%d)\n", signum);
> +       }
>  #define KVM_CASE_SIGNUM(sig)                                   \
>         case sig: TEST_FAIL("Unexpected " #sig " (%d)\n", signum)
> -
> -       switch (signum) {
> -       KVM_CASE_SIGNUM(SIGBUS);
>         KVM_CASE_SIGNUM(SIGSEGV);
>         KVM_CASE_SIGNUM(SIGILL);
>         KVM_CASE_SIGNUM(SIGFPE);
> @@ -2310,12 +2317,13 @@ static void report_unexpected_signal(int signum)
>  void __attribute((constructor)) kvm_selftest_init(void)
>  {
>         struct sigaction sig_sa = {
> -               .sa_handler = report_unexpected_signal,
> +               .sa_handler = catchall_signal_handler,
>         };
>
>         /* Tell stdout not to buffer its content. */
>         setbuf(stdout, NULL);
>
> +       expecting_sigbus = false;
>         sigaction(SIGBUS, &sig_sa, NULL);
>         sigaction(SIGSEGV, &sig_sa, NULL);
>         sigaction(SIGILL, &sig_sa, NULL);
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index bab1bd2b775b6..30eb701e4becd 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -18,13 +18,6 @@
>
>  #include "test_util.h"
>
> -sigjmp_buf expect_sigbus_jmpbuf;
> -
> -void __attribute__((used)) expect_sigbus_handler(int signum)
> -{
> -       siglongjmp(expect_sigbus_jmpbuf, 1);
> -}
> -
>  /*
>   * Random number generator that is usable from guest code. This is the
>   * Park-Miller LCG using standard constants.
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
