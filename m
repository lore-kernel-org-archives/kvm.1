Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68943C0A08
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370720; cv=pass; b=ncnUhoF8KkpVLOan8rBdlhvSRlFRip7XDnafXbjMqw+JscKFkikvR8FX8Ut3cCQYE7dVSTI1PNz2hN/bflFSg5OdUmftWE32yphdozl+Io8CKMkDux86/7d0A0ZrY2wV9TmzPBqrysCqRMzq4rfS6xdrA1iVCzQfJhPe8jgc5fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370720; c=relaxed/simple;
	bh=SyGSbXNz8q/qDroqw0sxRk5+NR5xp21V4hgaN/9L/0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMmRQiaWkwHdZIttnReHBLqGu69OxUx75B5jgmg5j5sgdadtE0ylMNctSsI6xwJvx8f21tZ4DqAMQJcVUtpJkM0blSiZZycQye4UCEWRHXXdAIf+LIIk1st9haQ+EHXvPjpX7W/kCx1gQLOVbe4LfLCHNjwPUAVJ3p2tQviWQQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tGupKp70; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tGupKp70"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-519ed52bcc6so180501cf.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 23:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782370718; cv=none;
        d=google.com; s=arc-20260327;
        b=hWKTR9wcuVddV0ywsLpLkgeP71GiALCPTqn9FmHZDfPe/PVTbi2EaLUahXnLKEIs+O
         JegG3JGD2fsv5oahsaOqbQvvTI5by11p4lg8V+bDEtjtV5ERWXyzKeMn0Uq50Jeb7xU/
         HSsnIO1FHGDEO0bMdSlHjiZf0MJ5kwz+x30mSBm1purF87BNqEwQ6iJ3o7uxO+vLBqLz
         qZkaHzs/31ShvFIxVHVjF9/Xwdo+LW3s59TVoLOCniNQYQ6O53lvPkh8CoUinZ4nPuAl
         poNSdL+K9V+17PA+5/NnlmyxIqeEdZcR1W6Eha7zKIGMmL8P0dkh2TtmOMjgO97IUoDt
         jngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KdGqwRZEoBZlGth5crGGDiriD2nf5vVEe54PRH1YZ7s=;
        fh=C2XWLcQIjfhb22jgTOjAp/8HnKfLc50GXinPI3SW7II=;
        b=QqJzaPNn72GYRi7iXF2yT3CD1qLO5G5CvJ7tfHG7Sum5NYxJ09o2W/Qre4a3QyUmYk
         LBpUilm6ZDE0bzcFEPrCU+aLOa7rosOKpG28FfdxuNpr+J11Ysm0XN5eKc5dKy+zGm+K
         jwVJO6Ik7xCFGy37x/QyBnadyAm+8G7OjyKW7zxAvkmHqq2AijPdOMzwa8UgW2U+/K3v
         nSsbfOAQ/y9t6wKN6TybNgiREhMa2xcJYHAzHmFtI9eL6ZzvBdJ7NBKrXiG6ALL9DUTV
         PRLNWBF1w5q73jurOAkLgONzO1eEsdaHxkbCZAcUSsLz1uweOJDEHmJnUz7uDSbnp2LP
         BQ/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782370718; x=1782975518; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KdGqwRZEoBZlGth5crGGDiriD2nf5vVEe54PRH1YZ7s=;
        b=tGupKp70o6smKJB8ePSOk+DwlwWcKNkV93oqRQ/I7T8w4llXQ8DAjcl+v1KxTs6GEc
         HleWAcUwm7Zz3qU7x/6LvN62bo2nfqUMm32TbZJPVxdg1Ylsy9e/f7YJX0/SQ0N0frEb
         ZMSajdlg3t7RHxislDw22vxIk9zH1iZqdT6HBWFZX3+yTArPMREusZu8MukaMwPlgdiN
         nDmw7b7Nzm8AsOjrJ0SDU2ZSKy0Mz/TiRPvbEOG1m4VLeVnxmM/n35xvmil5lUXHjRZ8
         q7Su8DZjXg7vPYSucskLr3bfG2lV1HrS3tBRS1xGr6P6jseZXvaB+9n1WUJzyAVywNOe
         BQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782370718; x=1782975518;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KdGqwRZEoBZlGth5crGGDiriD2nf5vVEe54PRH1YZ7s=;
        b=LRo9zhmjQEwjXwu3cWyVs+HtjXfKwvhD5LQvU2CxYKEXQYYVjyYJkXXHiKOzwVuyT6
         rCq0oAcdG/7m+NotFo1Q/5Ypyp1a/4YK64O+EZq33iTipLvFlaaG5kpukBSMBBb3e4WX
         BjpRgL2F/WjYihwnuoKjodJgIo7+h7T42QV54GLdKx5jJu+RDoMrTeDxyZbiI+8fs3ZH
         7x2t/wUs6gzAVglq84iv0nJFepyOTsWkF35GEWa9VFygYAXaELpqfI54zwpX4bqu2DF1
         OemHJ5S5q6E7pok3HqOv1zHBdTUtaUjcFY2mgm80snacjYq82LnYVsjOBPWZhzo7Gc1A
         df0Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Eq/21rorJJoyDwls6dVq+j10C1nSqZ/JrSEjnOXncYUF5jZ/ypTCYFnqnXwPQuzBZamA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvIoe3Ow92EH0P62sYrkH+KQsEbiBfvSCaZS5g1aLMivOhMB0L
	Cz4P580QnUd8gRwNCuZrJ78Ve2/gfef4qUtl9c6DBy/1ZGwrBXmxPeamwL0c9KnnK6G7bCUT/TJ
	FndcxYouqlJ2UlNRP+eMVCZl5ftn5JWBKjF0Xe+yJ
X-Gm-Gg: AfdE7cnqoMFX0Vcbvpkkam8SkltuM1DMuCJ6toWX6lRaleNOhJBPpzOuF8KSn9pV6Gn
	z9aekfbkLSWcJIP+4m7JTB1524Bt7vfL78xW1qizWn/aQQH5MMTgNq4+T7IK2cGhqjQHqlEy7VS
	UtPxslP5cUexXg2dSkSCPlpegLLVjL6uCqK+/A0GbVReBpB1pMxQm942N0vm0OYzEEI4suHN7jg
	lO7yRvVrwC9a3vnJC7xkEqoVxk9seNQvgyRbiS0chpftVrcST8J1qo98ey8JnVYU5laFilS5Q==
X-Received: by 2002:a05:622a:586:b0:519:f8a0:16b4 with SMTP id
 d75a77b69052e-51a6eafc644mr6248791cf.14.1782370716783; Wed, 24 Jun 2026
 23:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-33-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-33-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 07:57:59 +0100
X-Gm-Features: AVVi8CdlUqqm7utRrODu0hzmedC063K0MES5T7_EuttwZUvfcmHiCBLx6crELI8
Message-ID: <CA+EHjTw=-yzY+SLvLFwJx+73OeYcBmT3YHYQmuf9=fx_KoebmQ@mail.gmail.com>
Subject: Re: [PATCH v8 33/46] KVM: selftests: Test conversion precision in guest_memfd
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
> The existing guest_memfd conversion tests only use single-page memory
> regions. This provides no coverage for multi-page guest_memfd objects,
> specifically whether KVM correctly handles the page index for conversion
> operations. An incorrect implementation could, for example, always operate
> on the first page regardless of the index provided.
>
> Add a new test case to verify that conversions between private and shared
> memory correctly target the specified page within a multi-page guest_memfd.
>
> This test also verifies the precision of memory conversions by converting a
> single page an then iterating through all other pages ensure they remain in
> their original state.
>
> To support this test, add a new GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED
> macro that handles setting up and tearing down the VM for each page
> iteration. The teardown logic is adjusted to prevent a double-free in this
> new scenario.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> ---
>  .../kvm/x86/guest_memfd_conversions_test.c         | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> index 5b070d3374eae..8e17d5c08aeb8 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> @@ -61,8 +61,13 @@ static void gmem_conversions_do_setup(test_data_t *t, int nr_pages,
>
>  static void gmem_conversions_do_teardown(test_data_t *t)
>  {
> +       /* Use NULL to avoid second free in FIXTURE_TEARDOWN (multipage tests). */
> +       if (!t->vcpu)
> +               return;
> +
>         /* No need to close gmem_fd, it's owned by the VM structure. */
>         kvm_vm_free(t->vcpu->vm);
> +       t->vcpu = NULL;
>  }
>
>  FIXTURE_TEARDOWN(gmem_conversions)
> @@ -101,6 +106,29 @@ static void __gmem_conversions_##test(test_data_t *t, int nr_pages)                \
>  #define GMEM_CONVERSION_TEST_INIT_SHARED(test)                                 \
>         __GMEM_CONVERSION_TEST_INIT_SHARED(test, 1)
>
> +/*
> + * Repeats test over nr_pages in a guest_memfd of size nr_pages, providing each
> + * test iteration with test_page, the index of the page under test in
> + * guest_memfd. test_page takes values 0..(nr_pages - 1) inclusive.
> + */
> +#define GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(test, __nr_pages)           \
> +static void __gmem_conversions_multipage_##test(test_data_t *t, int nr_pages,  \
> +                                               const int test_page);           \
> +                                                                               \
> +TEST_F(gmem_conversions, test)                                                 \
> +{                                                                              \
> +       const u64 flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED; \
> +       int i;                                                                  \
> +                                                                               \
> +       for (i = 0; i < __nr_pages; ++i) {                                      \
> +               gmem_conversions_do_setup(self, __nr_pages, flags);             \
> +               __gmem_conversions_multipage_##test(self, __nr_pages, i);       \
> +               gmem_conversions_do_teardown(self);                             \
> +       }                                                                       \
> +}                                                                              \
> +static void __gmem_conversions_multipage_##test(test_data_t *t, int nr_pages,  \
> +                                               const int test_page)
> +
>  struct guest_check_data {
>         void *mem;
>         char expected_val;
> @@ -199,6 +227,44 @@ GMEM_CONVERSION_TEST_INIT_SHARED(init_shared)
>         test_convert_to_shared(t, 0, 'C', 'D', 'E');
>  }
>
> +GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
> +{
> +       int i;
> +
> +       /* Get a char that varies with both i and n. */
> +#define combine(x, n) ((x << 4) + (n))
> +#define i_(n) (combine(i, n))
> +#define t_(n) (combine(test_page, n))
> +
> +       /*
> +        * Start with the highest index, to catch any errors when, perhaps, the
> +        * first page is returned even for the last index.
> +        */
> +       for (i = nr_pages - 1; i >= 0; --i)
> +               test_shared(t, i, 0, i_(0), i_(2));
> +
> +       test_convert_to_private(t, test_page, t_(2), t_(3));
> +
> +       for (i = 0; i < nr_pages; ++i) {
> +               if (i == test_page)
> +                       test_private(t, test_page, t_(3), t_(4));
> +               else
> +                       test_shared(t, i, i_(2), i_(3), i_(4));
> +       }
> +
> +       test_convert_to_shared(t, test_page, t_(4), t_(5), t_(6));
> +
> +       for (i = 0; i < nr_pages; ++i) {
> +               char expected = i == test_page ? t_(6) : i_(4);
> +
> +               test_shared(t, i, expected, i_(7), i_(8));
> +       }
> +
> +#undef t_
> +#undef i_
> +#undef combine
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
