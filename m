Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF612EEE8C
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384273; cv=none; b=dIExuxO/Mgx/MDgW0N9EzHJVL9KYE2+OJVRb+BfPDasMNHbBjdv+qXalr7hcQOcD93skCC4xiEiBStm4a6Z7f6Eh808mfd/y5YIO6xK+Z9QnU8J5o74y0/vkAlVm9XLcIUo+tqRp72gSjORnW9VxGIis6BD/rauJ0nO+WtMW4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384273; c=relaxed/simple;
	bh=fbZWXN0OcEvYS+7fM+4NuOY+y/riiLiXQ0tEInRvIuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=REpwv1SbG6H1sPWri1MXdTSpXJW15iyM9XK5OOsx+uINOEimhjs7jWG4L4CdQZ20S6+jnRBftseX9C4PyLgr7XgVTK3Qn7df89Xdlro+6RMnPLfRocouB5BLIPFujR6Yld9CwMRFhFPFDqXZ0Yz6IiI769j7CMmyJqHjrBatdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnLYM1+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnLYM1+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBA61F000FF;
	Sat, 26 Sep 2026 00:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790384271;
	bh=fE3/tX3+Jkyxcons2+AJw7vXMaY8AsXzBix9AxyjLQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dnLYM1+quvY38F4Csc+wlySGmnGgaWPFtoMqgY3y4p6O23HPQAEtmQyKU/u8thqsf
	 ayXrYZkWKhM6PnXD72MFml1Zjmz4DllKzWtw/bQQdrMIXK5qGPMcC9J+Mr1ihrum6B
	 pm3XJ0PQl3rTq6M19swzaL7svn4OPN9NmksuUWEKlB4DZ9cU50dQ9TNpsk94f8dkC7
	 c++A2b9YotJsHiCQYR4tCr6Kt7qFeXG0hIRBy4NjuPeHN9MeEhdN9D63hc7REU6H5A
	 bsHHullQjW+LgycBs6vePACattP6OGXOHehImRgFxoJ96SrA+cfnm40bMqGPqKdedv
	 qPIeV2MnzguVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/17] KVM: selftests: Test rejection of swap tmpfs
 mounts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-9-d36159822d18@google.com>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
 <20260925-gmem-tmpfs-backend-v1-9-d36159822d18@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 00:57:51 +0000
Message-Id: <20260926005751.8DBA61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kselftests/kvm: incorrect fd validation in create_tmpfs_pool_fd()
--

commit 757011eabe5ad7927d1894ae72e08f8c628d45bc
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test rejection of swap tmpfs mounts

This commit adds a test to ensure that guest_memfd creation fails with
-EINVAL when passed a tmpfs resource pool mount descriptor that has swap
enabled.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index a7a1b5470cb2c..5d017164d7b45 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
[ ... ]
> @@ -477,6 +478,54 @@ static void test_resource_fd_tmpfs_file(struct kvm_v=
m *vm)
[ ... ]
> +static int create_tmpfs_pool_fd(const char *huge, bool noswap, size_t si=
ze)
> +{
> +	char size_str[32];
> +	int fs_fd, mnt_fd;
[ ... ]
> +	TEST_ASSERT(!syscall(__NR_fsconfig, fs_fd, FSCONFIG_CMD_CREATE,
> +			     NULL, NULL, 0), "fsconfig create failed");
> +
> +	mnt_fd =3D syscall(__NR_fsmount, fs_fd, FSMOUNT_CLOEXEC, 0);
> +	TEST_ASSERT(mnt_fd > 0, "fsmount failed");

[Severity: Low]
Does this code incorrectly reject valid file descriptors?

The fsmount syscall allocates and returns a new file descriptor. In POSIX
systems, 0 is a valid file descriptor and will be returned if it was
previously closed. The assertion incorrectly treats fd 0 as a failure.

While selftests typically run with standard file descriptors (0, 1, 2)
already open, making it very unlikely to trigger in practice, would it be
technically more correct to check for mnt_fd >=3D 0?

> +
> +	close(fs_fd);
> +	return mnt_fd;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-gmem-tmpfs=
-backend-v1-0-d36159822d18@google.com?part=3D9
