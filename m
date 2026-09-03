Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E43769EC
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476508; cv=none; b=ni3uCnNCKvhztlAIIl54Z0O6NKT8dHvzxAU+LTM2w4MFeCgRXvVPZqwBuXSJzpiEo1cjYPvwDHhKLsUWxa2nC4bN3n9/azjSua5ciZOvJrsxOuIe5ORGhjYzO8Q1+5/uIgH9x+0hRLjv1dOcPX607CtK1DH5CnsURxWozu+ER20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476508; c=relaxed/simple;
	bh=xGXFyePA8dYFsIjn1RCVqnIHOQzJB15X4kbkjOM86Aw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bIAdcJiHXH0jZ6ac+jCxTEbEP1KaApPIoDAQ+oa2Tb3yvi00Wjb1/wis0KLtMYH9lnsv8qiiDuyXN557zvy8QwzQwi7QnnZ104+RpvlLW0VypLyggHdAFPMLNKag1x08aox6upc+1DOqTFny6wDSjmXd3JppjoeBHoX/7DYIeG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFT0SvYv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFT0SvYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ACA1F00A3D;
	Thu,  3 Sep 2026 23:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788476507;
	bh=hfYKfzLEmj/DHgpKz7Ba/hnqxTlJhQY9kkopPMrmdm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AFT0SvYv9jwcA9iuh3N4Ucx2AJKxsL1+4ir0l+ZtQuklTDmIu6bLdfWF/iH0TnZJY
	 qPZAtQMQ/rAUQOdCB1Q+DnJOJ4cikRbA9nmW0+IrAp/WDp99ZjhRRktH7e2fyHaSZq
	 +/0r+PXND/8hbzvhUh1koypKL9FjnHDjyjmCJF4Tv2rWHa9oWURjbJeKUj044wLSI6
	 QA+CLw7KLknMeUbFicA9iEZNn+LqV68/IO1aJK/QokNlIuP9AIWOsKHsA7lrjRC0d0
	 j4z+rvqc6kEJPPu6ugM+lGdwbElU+uC2qC2D7dla9SLSurG3LpfVSm74jLRh2GZVbO
	 uzns+mKfMrDgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 6/6] selftests/vsock: test the assign ioctl
 privilege checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902-vsock-guest-ns-v1-6-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-6-9995383e9a8b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 23:01:47 +0000
Message-Id: <20260903230147.63ACA1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The unprivileged user namespace test spuriously fails because th=
e unprivileged user lacks DAC permissions to open `/dev/vsock`.
--

commit 4c5b8557bb5663f827061639a80256407bfe6c8c
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests/vsock: test the assign ioctl privilege checks

This commit adds two tests to verify that CAP_NET_ADMIN is required to use
the IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS ioctl, and that an unprivileged user
namespace alone is insufficient.

> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/self=
tests/vsock/vmtest.sh
> index 53591fa07f1a8..efb94d17d9976 100755
> --- a/tools/testing/selftests/vsock/vmtest.sh
> +++ b/tools/testing/selftests/vsock/vmtest.sh
[ ... ]
> @@ -1805,6 +1817,51 @@ test_ns_guest_assign_g2h_netns_reset_on_ns_delete_=
ok() {
[ ... ]
> +test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() {
> +	local helper=3D/tmp/vsock_assign_g2h_netns
> +	local unpriv_uid=3D65534
> +	local unpriv
> +	local rc
> +
> +	unpriv=3D"setpriv --reuid=3D${unpriv_uid} --regid=3D${unpriv_uid}"
> +	unpriv=3D"${unpriv} --clear-groups"
> +
> +	if ! vm_ssh "init_ns" -- "${unpriv} unshare -U true"; then
> +		log_host "unprivileged user namespaces unavailable, skipping"
> +		return "${KSFT_SKIP}"
> +	fi
> +
> +	# The home shared with the guest is root-only, so place the helper where
> +	# an unprivileged user can execute it.
> +	vm_ssh "init_ns" -- \
> +		"cp ./vsock_assign_g2h_netns ${helper} && chmod 755 ${helper}"
> +
> +	vm_ssh "init_ns" -- "${unpriv} unshare -Urn ${helper}" &>/dev/null
> +	rc=3D$?
> +
> +	if [[ "${rc}" -ne "${EPERM}" ]]; then

[Severity: Medium]
Will this test spuriously fail in minimal environments like virtme-ng?

The test helper vsock_assign_g2h_netns is executed as an unprivileged user
(UID 65534). In minimal environments without systemd-udevd to modify default
device node permissions, devtmpfs creates /dev/vsock with default 0600
(root:root) permissions since vsock_device in the kernel does not explicitly
specify a mode.

When the unprivileged user tries to open /dev/vsock:

tools/testing/selftests/vsock/vsock_assign_g2h_netns.c:main() {
    ...
	fd =3D open("/dev/vsock", O_RDONLY);
	if (fd < 0) {
		fprintf(stderr, "open /dev/vsock: %s\n", strerror(errno));
		return -1;
	}
    ...
}

It gets EACCES, causing the C helper to return -1 (exit code 255).

Since the script expects EPERM (exit code 1) from the ioctl failure, does it
misinterpret the 255 exit code as a test failure?

> +		log_host "expected EPERM (${EPERM}) for an unprivileged user, got ${rc=
}"
> +		return "${KSFT_FAIL}"
> +	fi
> +
> +	return "${KSFT_PASS}"
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-vsock-gues=
t-ns-v1-0-9995383e9a8b@meta.com?part=3D6
