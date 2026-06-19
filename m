Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159BF2E3FE
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781838141; cv=none; b=iElTh2m65RQgUzYWrRQTPff7ll9TjAtMemJdy0ClZQTNc4Ibd9ZyJ5a4TmI3wxpU7/IHBnhmuuH00Tf/H8U+w8119OA11E4VJjVhhQsyRWXZ6i9nL2ww1vfh8aFABcWDPApx3ajwyq41j1zTosew2v6GhixeropdDkkrL+gzYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781838141; c=relaxed/simple;
	bh=UKEtMs5fHLEEXUbvxUq7fU39OKalTVra/kMpkTkmMrA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eFUuAMPAFP9GaP656lbCISWZ3bMAPlBU0Ub/gwn/SuBQ/bhAloaw28OhHjMoT8xJ22FmGQs8byjyL/4wSPn9iM6Ca/I4bKiyDZMUrb2M8DMIwVgdIdrNFix8lY1LchpsXGRh9a9dWPwxxGxwf0AYUk84fx+F9SxJZd5MsrEpz9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8wr8oJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8wr8oJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4DE1F000E9;
	Fri, 19 Jun 2026 03:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781838139;
	bh=q3d7hayY4AekKJ/bqsf8sgPUXOnfkBP0HzARjtTO/8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y8wr8oJZpNF8r8Sr439xnYDFZVUnt8Qmc5ngtdlp332VyqXRDYi6wKo1b+Z/yZIFC
	 5HchR4yqcd68R9kerduuxBQRooiSP+sdIv9ybXn0qhNq93n63argy80YzyvUgqQy2+
	 sxAuUfyC/tMn20p4edQkFSHOcWGuNJEFeqQfpE4MdYcIEX/pFl5GoxB22OzTpAEov1
	 RPzALRgxDo4tULVdArEqVg7uyjbBmY98o9qRf/mnrKzU74G53XPQu/uYHQXjoGykIs
	 eXb8Pf8KdPD8NfPnJo+7u4DQDzmAWUmi+TeA9xqq14vU9k/C5gEJJycCHNTE6UHQPB
	 CifZUG8i2LSlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 38/46] KVM: selftests: Add helpers to pin pages with
 CONFIG_GUP_TEST
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618-gmem-inplace-conversion-v8-38-9d2959357853@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-38-9d2959357853@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 03:02:19 +0000
Message-Id: <20260619030219.8C4DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] System-wide exclusivity of `gup_test` prevents parallel executio=
n of KVM selftests and causes spurious failures.
- [Low] Incorrect relative include path for `gup_test.h` breaks the build o=
r relies on accidental `-I` path traversal.

Pre-existing issues:
- [High] The `gup_test_release()` function calls `pin_longterm_test_stop()`=
 without acquiring the `pin_longterm_test_mutex`, leading to a data race, d=
ouble free, and Use-After-Free.
--

commit 23065bfd3ffa48cfd9620c8d5f059f9ef6b27ced
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Add helpers to pin pages with CONFIG_GUP_TEST

This commit adds helper functions allowing KVM selftests to pin memory using
the /sys/kernel/debug/gup_test interface. It implements pin_pages() and
unpin_pages() by wrapping ioctl calls to PIN_LONGTERM_TEST_START and
PIN_LONGTERM_TEST_STOP.

> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/s=
elftests/kvm/lib/kvm_util.c
> index b73817f7bc803..524ef97d634bf 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -18,6 +18,8 @@
>  #include <unistd.h>
>  #include <linux/kernel.h>
> =20
> +#include "../../../../mm/gup_test.h"

[Severity: Low]
Is this relative include path correct?

Four levels up from tools/testing/selftests/kvm/lib/ only reaches the
tools/ directory, causing the compiler to search for tools/mm/gup_test.h.

Does the build only succeed because the compiler falls back to the
-I ../rseq include path defined in the KVM selftests Makefile?

[ ... ]

> @@ -639,6 +641,27 @@ int __pin_task_to_cpu(pthread_t task, int cpu)
>  	return pthread_setaffinity_np(task, sizeof(cpuset), &cpuset);
>  }
> =20
> +static int gup_test_fd =3D -1;
> +
> +void pin_pages(void *vaddr, uint64_t size)
> +{
> +	const struct pin_longterm_test args =3D {
> +		.addr =3D (uint64_t)vaddr,
> +		.size =3D size,
> +		.flags =3D PIN_LONGTERM_TEST_FLAG_USE_WRITE,
> +	};
> +
> +	gup_test_fd =3D __open_path_or_exit("/sys/kernel/debug/gup_test", O_RDW=
R,
> +					  "Is CONFIG_GUP_TEST enabled?");
> +
> +	TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_START, &args), 0);

[Severity: Medium]
Will this cause spurious failures when running tests in parallel?

The /sys/kernel/debug/gup_test interface relies on system-wide global
state (pin_longterm_test_pages) rather than per-file-descriptor state.

If multiple tests run concurrently, won't the kernel return -EINVAL to all
but the first caller because the global state is already occupied?

Furthermore, when one test exits, its file descriptor closure unpins the
memory of whichever test was actively using it.

[Severity: High]
This isn't a bug introduced by this patch, but interacting with the gup_test
file descriptor exposes a data race in the kernel.

In mm/gup_test.c, closing the file descriptor calls gup_test_release(),
which invokes pin_longterm_test_stop() without holding the
pin_longterm_test_mutex:

mm/gup_test.c:gup_test_release() {
    pin_longterm_test_stop();
    return 0;
}

If multiple file descriptors are closed concurrently (e.g., multithreaded
test applications or concurrent test processes exiting), multiple threads
can race inside pin_longterm_test_stop() and concurrently call
unpin_user_pages() and kvfree() on the same global pin_longterm_test_pages
pointer, leading to a double free and use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inpla=
ce-conversion-v8-0-9d2959357853@google.com?part=3D38
