Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780038;
	b=nZYOeQFCAXKDVoPtqlfCRpE9mxAfCtFeE1FUjck5+vt6jTr9uZA3950+VKdc2xLCa7Ie
	 C6tTP61B0ZvH2JipTD/unw6C9Pdv+828ulkl7LoN+5nr6y9Bk9m6FB5nGy+XX47qSq1KK
	 KJuT1xxO7zbjA7Em+FfbQPVWNbrX9GMfBnYKsGasDSxPoHb9A/LLjrDxtUceH+px0wSi7
	 20Z874OCeI2LvyQzF0XqctpOOscDpmgGrS8DEOgro2GlUZ9fUr3a9+ynjE2NmQL8dZp79
	 oYVUOxTyH/oNX79pwdblOoT5aK3ht6kULwiY1e3ed2CHiJDxyvhP5P+DAey9C/eoX+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780038;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eKFZVy2n3LpD6eaitlCGSWY/ds3vlQFngMN9WoLAsHQ=;
	b=D3TTG2XNeTEa7yt0h7zq/+LnlUbM1VZzfkbhDVwJJJ0pOGw8M/vbIN0DnuEc7JHm71CX
	 BIJYy1xmvoe58DYAS6aOtjgW0ewjyM195cWJdE2DuVcGH2ZFBBkftNW0iKGpUuixtEPEh
	 UCktNAp8AgXli03KKwb1HuZ8qsxj7bghVrn/DhxHR2cVVa4VPw5L2K3pggrGC+AeUL+m0
	 Mge3oxC+UtY97pebBmJJfqzASGX9WZcGhpjcVd+yGiR0YiDRVarA6LZswEfXE4DghaTNz
	 7fQF3WX/ZTO4Wy4O5JOmBXbyZoUTvBdkFB354PHR4U0Bj2tzRYS22xsw04lb5OFcI1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSFYw5jG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C020606A329
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSFYw5jG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CDC1F000C1;
	Wed,  4 Nov 2026 08:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793780038;
	bh=eKFZVy2n3LpD6eaitlCGSWY/ds3vlQFngMN9WoLAsHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TSFYw5jGjrPWX85LK6zV2YRzzlZUOiZUw84q55IXiY2w7EJh/D+sG8XboMnl8Dlpx
	 s4Obx1Iqokg8kwlCZtRApPau0cq690T7Af2iBJRKMKq+aicN2eW777DG8YsfayEtWZ
	 9jhpBIY2edYrpi6YoYNII1auaYEknYlhEAw6YrmxISL5QpaPJTqPNYbjA3o+0DqIah
	 2dw04usSwcy09AUqRvzw9XscTaDgBYVZtXGdB1aggMjIBiyt8Ycq+oQz06JIqcY2rM
	 0aFTQ8BhwwpYtVdV6aJtnYL41wE/t3A1XkCZBWsh3fv0H7oA6mmoVVPAe+wjR7+ixG
	 LOK09jG+zROew==
Message-ID: <sashiko-outbox-196866@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/kvm: check fopen() return in get_run_delay()
Reply-To: sashiko-reviews@lists.linux.dev
To: zhangchujun <zhangchujun@cmss.chinamobile.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261104080721.2169-1-zhangchujun@cmss.chinamobile.com>
References: <20261104080721.2169-1-zhangchujun@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 08:13:57 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/kvm: infinite loop when fopen() fails in get_run_delay=
()
--

commit fed2657e5d999eb78e5e508f23ea617f2787e14a
Author: zhangchujun <zhangchujun@cmss.chinamobile.com>

selftests/kvm: check fopen() return in get_run_delay()

This commit adds a NULL check on the FILE pointer returned by fopen() in
get_run_delay() so that it returns MIN_RUN_DELAY_NS instead of passing NULL=
 to
fscanf() and fclose() when /proc/<tid>/schedstat cannot be opened.

> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/=
selftests/kvm/lib/test_util.c
> index f5f7189f96a84..2827f7d7d905e 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -421,6 +421,8 @@ long get_run_delay(void)
>  	sprintf(path, "/proc/%ld/schedstat", (long)kvm_gettid());
>  	fp =3D fopen(path, "r");
>  	/* Return MIN_RUN_DELAY_NS upon failure just to be safe */
> +	if (!fp)
> +		return MIN_RUN_DELAY_NS;

[Severity: Medium]
If fopen() fails to open /proc/<tid>/schedstat (for instance, when
CONFIG_SCHED_INFO is disabled in the host kernel), will returning the const=
ant
MIN_RUN_DELAY_NS here cause the callers of get_run_delay() to hang in an
infinite loop?

get_run_delay() reads the calling thread's cumulative scheduler run_delay
counter, and both callers in the tree wait for subsequent readings to advan=
ce
past an initial baseline.

In tools/testing/selftests/kvm/steal_time.c:main():

		run_delay =3D get_run_delay();
		kvm_pthread_create(&thread, NULL, do_steal_time, NULL);
		kvm_pthread_getaffinity(thread, &cpuset);
		TEST_ASSERT(CPU_COUNT(&cpuset) =3D=3D 1 && CPU_ISSET(cpu, &cpuset),
			    "Worker failed to inherit parent's CPU affinity");

		do
			sched_yield();
		while (get_run_delay() - run_delay < MIN_RUN_DELAY_NS);

When get_run_delay() returns MIN_RUN_DELAY_NS on every call,
get_run_delay() - run_delay evaluates to 0, which is always less than
MIN_RUN_DELAY_NS, causing this loop to spin forever.

Similarly, in tools/testing/selftests/kvm/x86/xen_shinfo_test.c:main():

				rundelay =3D get_run_delay() + MIN_STEAL_TIME;
				do {
					sched_yield();
				} while (get_run_delay() < rundelay);

Here, rundelay becomes MIN_RUN_DELAY_NS + MIN_STEAL_TIME while get_run_dela=
y()
continues returning MIN_RUN_DELAY_NS, which also spins forever.

Should get_run_delay() instead fail or skip via TEST_ASSERT() or
TEST_REQUIRE() when fopen() fails, similar to other file-opening helpers in
tools/testing/selftests/kvm/lib/test_util.c such as get_sysfs_val() and
get_def_hugetlb_pagesz()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104080721.2169=
-1-zhangchujun@cmss.chinamobile.com?part=3D1
