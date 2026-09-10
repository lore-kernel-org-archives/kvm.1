Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DD49E12C
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082017; cv=none; b=jZrdFk9SsW3BMD8LW0653GSEN7K4EJaB92KedUDpOt7fuV7mhqylze7gOfCVUx5bOiIv/9d4mhyUpVpz+NLwOtsbsXUDmf89/0y19MsogjIfDj+GEK5OLg62k1pEqxUikbTiCnYnGRvqLVGKkjJ3IZUc7CZuWXFL6c/i/rcCKp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082017; c=relaxed/simple;
	bh=AoayI9dD6Wj+PC8f5wsooD1eY0RbIbiy1sD6o3r6FiI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=riba3fbxLncxMYw1diQjGMeKF54vb7pTEz39mw9S4e95/SeffI46kZ7Cd+XLLT9b+8ypUjj1XruCh0NdSgycisblqUupAXBGOoqpvKpiz5quoK/RuNjnmuLzYrkIgGm1lNgyZr9RGf992rNXa1R4QqQ9AyndHmh1HrR81SFGJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heJ76Y25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heJ76Y25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5E71F000FF;
	Thu, 10 Sep 2026 23:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789082015;
	bh=uj+1v6N71QJMRWxew0E4OPnxRQtLtQfVGP0VbDmv/5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=heJ76Y25/5J6vUI4mRmv25uDxMQ44BI4TDRYj2BAWvSYStYQ6w2vCW59gpgoHFSZD
	 faCiUvaS0I2cYC3cDaKFB92Gwyv6NnNeLY9zxgrPbRmLX/tpYwZSf8sOKyperha54O
	 oHSrDKBDzVHyd4iiJMzDuzr58YiNi80KVSlHz3hz5IHK3MLRSjC7Yb7Q3IhxOzF9ew
	 B9MAYqB0PbMT4kS09drp1fCmkWuEJ5y+tO1PfG4QrYRnmPpxXL+q4iHpY8MUign44e
	 6qd591eNbUypyrB1XP7LvawQzWhzVrtiXqCCBJA87JC1mfkoINJM+mxXHujgmVgBhS
	 uYpRPFQaXEd3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/harness: Drain the test process group after a
 timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Williamson" <alex.williamson@nvidia.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260910230254.1198094-1-alex.williamson@nvidia.com>
References: <20260910230254.1198094-1-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:13:34 +0000
Message-Id: <20260910231335.7B5E71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing process group initialization race leaves child proces=
s running concurrently on timeout.
- [High] Test child process and its process group are leaked if pidfd_open(=
) or poll() fail.
--

commit 2f6bf81e41b5489d0a1cc6b990abec031b22d521
Author: Alex Williamson <alex.williamson@nvidia.com>

selftests/harness: Drain the test process group after a timeout

This commit updates the kselftest harness to actively wait for the entire
process group to exit when a test times out, bounded by a 5 second limit.
This addresses cascading failures caused by grandchild processes outliving
the timeout and holding onto exclusive resources.

> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/=
selftests/kselftest_harness.h
> index 29a19bc870846..4e479c8cb49e8 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -981,8 +982,7 @@ static void __wait_for_test(struct __test_metadata *t)
>  	 */
>  	int status =3D KSFT_FAIL << 8;
>  	struct pollfd poll_child;
> -	int ret, child, childfd;
> -	bool timed_out =3D false;
> +	int ret, child =3D 0, childfd;
> =20
>  	childfd =3D syscall(__NR_pidfd_open, t->pid, 0);
>  	if (childfd =3D=3D -1) {

[Severity: High]
This is a pre-existing issue, but if syscall(__NR_pidfd_open) fails, the
function returns immediately. Can this leak the running child process and
its process group? If the leaked child holds exclusive resources like vfio
devices, could it cause subsequent tests to fail?

[ ... ]

> @@ -1004,9 +1004,46 @@ static void __wait_for_test(struct __test_metadata=
 *t)
>  			t->name);
>  		return;

[Severity: High]
This is a pre-existing issue, but similarly, if poll() fails (e.g. returning
-1 with errno =3D=3D EINTR), the function logs an error and returns. Doesn't
this also leak the child process and its process group by completely bypass=
ing
the SIGKILL and waitpid() cleanup logic?

>  	} else if (ret =3D=3D 0) {
> -		timed_out =3D true;
> +		int elapsed_ms =3D 0;
> +
>  		/* signal process group */
>  		kill(-(t->pid), SIGKILL);

[Severity: High]
This is a pre-existing issue, but is there a race condition here between the
parent calling kill() and the child calling setpgrp()?

If the child process created in __run_test() is delayed and hasn't executed
setpgrp() yet when this timeout occurs:

__run_test()
    child =3D fork();
    ...
    } else if (child =3D=3D 0) {
        setpgrp();

Would this kill(-(t->pid), SIGKILL) fail with ESRCH because the process
group doesn't exist yet? This could result in the signal being lost, leaving
the child alive to run concurrently with subsequent tests once it is
scheduled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910230254.1198=
094-1-alex.williamson@nvidia.com?part=3D1
