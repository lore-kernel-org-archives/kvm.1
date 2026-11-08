Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098638;
	b=o/Eq5yA8VxAIErmc52p4uTHDdNnOH5CW72raCwl3WdIUTIFmzEajwZH3ZTxsTfw6gCaM
	 gJ4XvsGerzWFptCxrf30QVjuyc3O9zuEB8L/C8vOnbr0vq/8PI2tG5Z864+/bxb+ICD0S
	 hacNH2IQcfKR64HTF6Z5t36JbeCTiRjmOae8N/eORjVFPduIk7E2ZjVi0QjcbDJ98zPsZ
	 LfGjTQnUIQ7SWlUA28Qx3/eny6edSSE3jOP356jBByyqyrsCMXsp+NUXp5KwpSBBZGZZq
	 plSZH2+ieCvh4oJN2Y0BGdBtysmNlP9hGwB+TkoI7UNwNiTA+8eb0NS93+biK1G/yFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098638;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yxHF+HxMAXdqXZTq/8M2Y+JwmoWt4VoRh1g2RwdITdw=;
	b=NIOb9l2dkgZsq1EowHelWqF8Qaaewg55ws/9T5JfEI5ienQXrIVUvDmcaoxcIAWFSrsR
	 rSRRNz88PAo2PClOY3xJsfsTI4eZcJcwGfr6QlBGlGxUlf3CzHTN9U2dddBd98zbnUSMx
	 kQwJ4lLRqgfdm03qq77waSOzMR6nvLHYZSs7q3GrZs5ufoniIVV+r5UEOi+PUgINCo/n9
	 7VcYZTtIgwbgn129eOHoHxifj1NKgA4DFYk9MFmWKn8hqmfdYZ0fNWeqlXIDpSjk9WPiC
	 z//jF7WASgLyZwThr642+WB9l4MsHuLPIraEu6/xC92YJEFFuwIfEaacvmnueQ/3hew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UWleJ/sF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECB6606A33A
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWleJ/sF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2791F008A1;
	Sun,  8 Nov 2026 00:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098637;
	bh=yxHF+HxMAXdqXZTq/8M2Y+JwmoWt4VoRh1g2RwdITdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UWleJ/sFhbPjTYUwvtieIOwhWr1zLN2XNKhrggy+vZ9k5fhbP4hS/AMBHeVyaO0G3
	 yBXgvrR2cMindlHKNbqVd+2m3P8Ww1/4O7h29Zd3AqVJ/5QG4RpvELKLvulD/Mkngy
	 FkptAiib4HO2USV4zhjqcSCzB3JWrGnQoakHSTYQwEqM5EEp/yYnoYZP4A05O3CpVx
	 iLnPaRFHo2/ynFVsXgzL3u/wbuoho2Bc2ytyK5KO0OJzNoeYnXNXu4e8k9JRMU9hkU
	 wNXj4bPUfDrhb/opyT9GMcgJrIYW5djJfqVevtLvCMBR1ohK0oWHPfq1fbI0rYGQrq
	 KeBlC4Bzcp7EA==
Message-ID: <sashiko-outbox-203421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 10/88] KVM: selftests: Test rejection of swap
 tmpfs mounts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alexey Kardashevskiy" <aik@amd.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jianxiong
 Gao" <jxgao@google.com>, "John Starks" <John.Starks@microsoft.com>, "Michael
 Roth" <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Sean Christopherson" <seanjc@google.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Fuad
 Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261106-gmem-alternative-providers-v3-10-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-10-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:43:56 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: selftests: missing CAP_SYS_ADMIN check in
  create_tmpfs_pool_fd()
--

commit 3ffb77e319f3b82f8e3aaa6439dea9dda37671d4
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test rejection of swap tmpfs mounts

This commit adds a helper to create a tmpfs mount fd and tests that
guest_memfd creation fails with -EINVAL when given a swap-enabled tmpfs
resource pool fd.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index d62ae23256083..205f822e10c6c 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c

[ ... ]

> @@ -478,6 +480,73 @@ static void test_resource_fd_memfd(struct kvm_vm *vm)
>  	close(file_fd);
>  }
> =20
> +static int create_tmpfs_pool_fd(const char *huge, bool noswap, size_t si=
ze)
> +{
> +	char size_str[32];
> +	char template[] =3D "/tmp/gmem_test_dir_XXXXXX";
> +	char *mount_dir;
> +	int fs_fd, mnt_fd, dir_fd;
> +
> +	TEST_ASSERT(size && IS_ALIGNED(size, page_size),
> +		    "Pool size '0x%zx' must be positive and page-aligned", size);
> +
> +	fs_fd =3D syscall(__NR_fsopen, "tmpfs", FSOPEN_CLOEXEC);
> +	TEST_ASSERT(fs_fd >=3D 0, "fsopen failed");
> +
> +	if (noswap)
> +		TEST_ASSERT(!syscall(__NR_fsconfig, fs_fd, FSCONFIG_SET_FLAG,
> +				     "noswap", NULL, 0), "fsconfig noswap failed");

[ ... ]

> @@ -539,6 +608,7 @@ static void test_guest_memfd(unsigned long vm_type)
>  	test_resource_fd_invalid(vm);
>  	test_resource_fd_unsupported_fs(vm);
>  	test_resource_fd_memfd(vm);
> +	test_resource_fd_tmpfs_swap(vm);
> =20
>  	__test_guest_memfd(vm, 0);

[Severity: Medium]
Does running guest_memfd_test without CAP_SYS_ADMIN abort the entire test
binary here?

fsopen() fails with EPERM when the process lacks CAP_SYS_ADMIN (and setting
"noswap" via fsconfig() fails with EINVAL unless capable(CAP_SYS_ADMIN) in
init_user_ns), causing TEST_ASSERT() to exit with code 254 instead of
skipping.  Because test_resource_fd_tmpfs_swap() runs unconditionally
before __test_guest_memfd(vm, 0), unprivileged users with access to
/dev/kvm can no longer run the standard guest_memfd tests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D10
