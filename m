Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E73655FC
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063443; cv=pass; b=Ch7CoUfy0NGXE3yxLYTGWWL8ejZWK7Njv5PGXMHjGOdrO4vo1Z8KMfUtLZdUfM1D4ZQQvKeb1M4KkVuqHpDp9wZZh/z89SV/P6pkWUoF5Hwj4yLDIGuSUnakLbkcN1ZFgfcW+iUhn3YjImHvBLOnq+T2wNob6l1TxCl6kXIVKHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063443; c=relaxed/simple;
	bh=Ah0Y8dKK3ONQwTech3fUqo224sZ77BjP0hgfw0DpEFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSrbHWduTvr/rnBcck3LgMEd0F7+SuuGn2PxsdcZzoNT9b3uL9UFP7oree5JV2P3i+LGxr5bAA7MTwZ1hhbapkIpKb1gz9YYTAqskWpBUokalBmuI7mv1lXRN/yVtD0B5gGZs1/QJ6jj60jRWwnQsXJ/NLiG44kD78Yy2JultQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=idTv6K8X; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idTv6K8X"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5307425f44bso329221cf.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 11:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789063440; cv=none;
        d=google.com; s=arc-20260327;
        b=BcDrcYoiZhabZZ+iAfKNYoF2CBv0PkqwMRUnqvGdnGoH3+VFsrTjShIIg5M3JYKj0q
         3tTZTXCTXeVU44Nf33vt+eW5p3EWYBdHh0E8HOzwczcTQLCrEjgry9gBMvblAdmg5OlZ
         FtogHCdnPIyAbzWuw3DzhYcYayG1JRMONBds/Lz5rMRYfFLD8nWu/A67wFnXWw/oD25T
         Q8er0uGT46uvdlWPkScDacfVuoXkAxpCPy8irCWuYCJVAvvbcey1wWpRrje07jWbaHlU
         I1MTI6uQ+xg6k6JsZ5mYOPRu7yb0bBZmQpPLCTnRJJB4FoKB3fukKw+G5EPZqlqdI4vB
         e8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lU4Ni6nVNz3cbuwIORrLsfK7gF/gdk70J0L4MX46lSc=;
        fh=JM1bP/DellM+Q6HsbxNoFyPUPOAetBmeje+K7gN41E8=;
        b=hh1Ni5Nqc6ycWtLVHEF7vqzWHCSNFyWNxWeROc6dUrSB2tO1s9t67vWAK3W6B60h0q
         bclddKWA1+20qPG6Sl2W29t2ll8f73Vr4hU7tIWWaC/wqATD8IV+qH6xjX8zcaTJFgDn
         B7uQe2/D0Glnh5QKljA7WBg/ZXd9IUYnB/gJc/TQuQd7ZjUKFnkk2d6FtkDzwt2/3+4e
         xIaDUdA6ngDHc4WuVP99abo+qkaKyk8Q7tBnTmJ3uCMd/7A5m78mHnbZde6RXhf4RA3p
         b3QRu7jEsQS4A/NZ+cfC4SuZbPTog1RKEdlomcJHwfIFqwetRoe8UjxkPxl/oj706thw
         eyHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789063440; x=1789668240; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lU4Ni6nVNz3cbuwIORrLsfK7gF/gdk70J0L4MX46lSc=;
        b=idTv6K8XG4mHilS5g5JM8jvsmztymfIy8555Ifim3Gd0pA0wPxNTX6lxgxhOCu9y1J
         8ejezbOZ99kprCSVr1BuOgg91bNkebL6wfRSY1W+8xY/TIY+7y/+krL3GeVXm1M0TFni
         05RLYvfcZuS0jV7TuQ/aPVLcuDz7Y7o9oojzLwsqZiCksP/A07BMzA7JQzNkhFhex2mE
         P9+hW7HpO1Rq3/Awd2++HYPFJorCS/s96S31vzz2JDrs25FMkU1Id4fSPzOc0j7n3OXH
         Y6eLxmSk5lnwI+KcptqcidfOxy4F4320xK6SLqgt54ZVqGgYv+H4qGiAovK91aoWpALY
         L5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789063440; x=1789668240;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lU4Ni6nVNz3cbuwIORrLsfK7gF/gdk70J0L4MX46lSc=;
        b=VJLMyTYQCFuTuwNzE7uxvRChoFCmHcvzEXZpZ3n7O0dkOJ9NC6pJTpomYYBZayFcWv
         Rz3yj1sgu5aGevi9cMGuL778dEHB/ezUe1UuValx4KZwGJiMxBJCvB8rz0bKpIHESNS+
         SVr3OVB4VxMaUK9GIkWkPRJ6IWEkWY5ONSHfp2wyn73MNgGuQkw8S5s80OJ0PawwWNSt
         zwxe/33VtLNJtsiwOo4J+XIbuG9yf0U4WlwlIToThpVJNKZjWAxkoDXh4mTrC570suzB
         7zW2ND1X3YiEwWn4VaysZknR9otQzZrTmQVVK+/pMQbO3BzSjxCG5rKEEG0/0DadcRsc
         x/fw==
X-Gm-Message-State: AFuF++nLqFF8865pLRKvvXOtdE+ZHuRKqkQGPK0/6Mj/taI8mJDOAitF
	3DuB8+O1/1bE/sxoqjrl7ba3l3HjrrXSMIMKR+dLbYlX3IIA8N/rPQM8yCj290x3r2mHT2pnk2M
	DHXgBL8zbgwS+XUFh0Hju7L0J1JGktoQdEOahgExv9XQsSrY7+1vXu2Qs
X-Gm-Gg: AYBFou0ZmwJvToMwDTQFitIroK1efuG+l3q9v3jhyM+ygyU4aaa/X1hXfLVJgsP8iyA
	EMdcVBqMf7DnVgxZGp/PBZre7ARziLnpzoz/s8j8c++cZ4Uzg4jXRf77GHKAcp1TR/xa6+QeEwE
	Md0aTl2pESIyx+lkmCpBGhujQr6aVTI3Q9fkG+z01apiNVQ5jecQeYxVqvahsDIwd78Py0nc/y4
	IXSvgJ07+JAWRCUTxlfr46OkZNNcw4NdQbduy93VanmN3GRIadhGYcAETrKO7mJQhzj3qrW+gHi
	oE0iQAk0FSGUjQ4DzomkSX3qtk8gecO/3dzFuhYui4HICp4zOAgBcxc=
X-Received: by 2002:a05:622a:343:b0:52b:4ec6:52ba with SMTP id
 d75a77b69052e-530c958404amr977721cf.6.1789063439266; Thu, 10 Sep 2026
 11:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804165748.1060476-1-aaronlewis@google.com>
 <20260804165748.1060476-5-aaronlewis@google.com> <an-YyQV-CtoulEHr@google.com>
In-Reply-To: <an-YyQV-CtoulEHr@google.com>
From: Aaron Lewis <aaronlewis@google.com>
Date: Thu, 10 Sep 2026 11:03:47 -0700
X-Gm-Features: AcwNN1W4du2QOxeHX0by0NkLn6FRfzeSxfPAq7O1Ig_qsUsAWbd5EQz_G-0wS-I
Message-ID: <CAAAPnDGbnoaNDsa8-p9aM=Gj8QG36_5QVgEW0DR3+GOEB0BkAw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] vfio: selftests: Allow a size for vfio_dma_mapping_perf_test
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > For example, both the test size and the test harness options can be set
> > like this:
> >
> > ./vfio_dma_mapping_perf_test -b 16G -a "-v vfio_type1_iommu_memfd_hugetlb_1gb"
>
> I tried this out and it's a little clunky to work with. Especially -h.
> Plus it's quite a bit of code in the test to deal with the different
> argv arrays and parse everything...
>
> Here are the other options I think we should consider:
>
>  1. Abandon the kselftest_harness for this test and manually replicate
>     across the different IOMMU modes and memory types. I don't love this
>     since it will differ from other VFIO selftests, we'll need to
>     reinvent the test fixture replication, and we lose the TAP output.
>
>  2. Add first-class support to kselftest_harness for custom test
>     arguments. I ran it through Gemini and it came up with something
>     relatively clean [1].
>
>  3. Just use an environment variable for this one argument. This would
>     be extremely simple to implement and use.
>
>  4. Have the test look up how many HugeTLB pages are free on the system
>     and just use all of them. You can control how much memory the test
>     uses by controlling how many HugeTLB pages are allocated on the
>     system.
>
> What are your thoughts?

I like the idea of #2, having the test harness support command line
arguments in selftests.

I ended up going with a struct interface rather than a macro one, but
the idea is basically the same.  That allows tests to easily add
command line parameters, and still use the test harness so the test
looks the same as the other selftests.  The other thing I liked was
that this solution made the command line look sane again, and allows
me to filter out tests with the selftest harness command line options.

>
> [1]
>   In kselftest_harness.h:
>
>     #ifndef OPT_CUSTOM_STR
>     # define OPT_CUSTOM_STR ""
>     # define OPT_CUSTOM_HANDLER(opt, optarg) KSFT_FAIL
>     # define OPT_CUSTOM_HELP()
>     #endif
>
>     // Modify test_harness_argv_check()
>     static int test_harness_argv_check(int argc, char **argv)
>     {
>         int opt;
>         char optstring[128] = "dhlF:f:V:v:t:T:r:";
>         // Safely append OPT_CUSTOM_STR to optstring
>         strncat(optstring, OPT_CUSTOM_STR, sizeof(optstring) - strlen(optstring) - 1);
>
>         while ((opt = getopt(argc, argv, optstring)) != -1) {
>             switch (opt) {
>                 /* ... existing core cases ... */
>                 case 'h':
>                     fprintf(stderr, "Usage: %s [-h|-l|-d] [-t|-T|-v|-V|-f|-F|-r name]\n...", argv[0]);
>                     OPT_CUSTOM_HELP();
>                     return KSFT_SKIP;
>
>                 default:
>                     if (OPT_CUSTOM_HANDLER(opt, optarg) == KSFT_PASS)
>                         break;
>                     return KSFT_FAIL;
>             }
>         }
>         return KSFT_PASS;
>     }
>
>   In vfio_dma_mapping_perf_test.c (before #include "kselftest_harness.h"):
>
>     static void opt_custom_help(void) {
>         fprintf(stderr, "\t-b bytes Specify the size of the DMA region...\n");
>     }
>
>     static int opt_custom_handler(int opt, char *optarg) {
>         if (opt == 'b') {
>             test_params.size = parse_size(optarg);
>             return KSFT_PASS;
>         }
>         return KSFT_FAIL;
>     }
>
>     #define OPT_CUSTOM_STR "b:"
>     #define OPT_CUSTOM_HANDLER(opt, optarg) opt_custom_handler(opt, optarg)
>     #define OPT_CUSTOM_HELP() opt_custom_help()
>
>     #include "kselftest_harness.h"
>
>

Cheers,
Aaron
