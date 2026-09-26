Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8430F7FF
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384446; cv=none; b=n3a3Kgne5VLbOIyn5Blt8gkiBxtltdgktaSMkjafIFA7ZkQ9yzCNSQb/tKjI6OoYNTZUyz+JCnJmIELvdQxZzseoce9ujXR2hn+t/ZtEeyg3xmnPuFeftnoAyxCeM4q5ugQgbSeqcgfvAPJUDQ+jAAf2ID6Ecbx7+HAbu+tR5hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384446; c=relaxed/simple;
	bh=96zuT87c39XqLc0+zyJwCHOYDyubptkGwBOXTgmPHu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XMi7T6XVZ8YGj4hN+6LQWUhuhbZ1rrxJ8JSMzzNgAgpxYvTZ1CwKWBnm8kF2Bd9bPLeFU2btVvPn0CCYQmfL1Z+57S6I8FmI5gKkwwxUntDci8tJLDDgfhgg0+kZ8RE2p2CAsaBFFyQURxB35wIdxAZJ03//8n6b/MbJPPLuSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvwWkrwL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvwWkrwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DC31F000FF;
	Sat, 26 Sep 2026 01:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790384444;
	bh=+cvUoM2MmXJBLi7p9T1Q8/MM84BG8AzQEGeF7PRkick=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TvwWkrwLuAH7UPjXkkHZTnfNp6yT8X9mg/iLOUUhE0oYfSSc1NGT49V3Bws8YTkVa
	 uqNpeGeoLvSpsLJeMMiQSNDaY9D/qXejUTMevM1UiNrS9vbbcgUSvgL3BJxuix5LmA
	 ZbCMqP3Ry0LLKhWYbdo25UGdbKcn2NX/rLgoJQ9t+1xZj9gAUzKVJ9aghoVcVftprt
	 iYZ4J5qKJR9GoyFFKQKKDFOdhk/JUXwp8hjEfewmKiUS1GhlqHVr1o52xLl2XHBNsR
	 tb4ZKKn6q9bKit3iOePPz12yWAtuARaofkaYmKMnNycJWT6ldwtdbEzqOULYhgfGvv
	 0coN4L8o/UDFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/17] KVM: selftests: Add helper to create
 guest_memfd with a resource file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-5-d36159822d18@google.com>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
 <20260925-gmem-tmpfs-backend-v1-5-d36159822d18@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 01:00:43 +0000
Message-Id: <20260926010043.E2DC31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kvm: UAPI backward compatibility break in kvm_gmem_create() va=
lidation
--

commit c5a56bcf1ec583a76fd38be9422edf93bea63235
Author: Ackerley Tng <ackerleytng@google.com>

    KVM: selftests: Add helper to create guest_memfd with a resource file
   =20
    Add a helper to create guest_memfd instances with a resource file
    descriptor, and update the existing creation helper to pass a zero
    resource file descriptor.

> diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kv=
m.h
> index 419011097fa8e..66c1f40b50c29 100644
> --- a/tools/include/uapi/linux/kvm.h
> +++ b/tools/include/uapi/linux/kvm.h
> @@ -1654,11 +1654,14 @@ struct kvm_memory_attributes {
>  #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_gue=
st_memfd)
>  #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)
>  #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)
> +#define GUEST_MEMFD_FLAG_USE_RESOURCE	(1ULL << 2)
> =20
>  struct kvm_create_guest_memfd {
>  	__u64 size;
>  	__u64 flags;
> -	__u64 reserved[6];
> +	__s32 resource_fd;
> +	__u32 pad;
> +	__u64 reserved[5];

[Severity: Critical]
Does repurposing the reserved field introduce a UAPI regression?

Since the baseline kernel didn't enforce that the reserved array was
zero-initialized, older userspace applications might pass uninitialized mem=
ory
in args.reserved[0].

If a legacy application calls ioctl(fd, KVM_CREATE_GUEST_MEMFD, &args) with=
out
setting GUEST_MEMFD_FLAG_USE_RESOURCE, the validation check in
virt/kvm/guest_memfd.c:kvm_gmem_create() will reject the call:

	if (!(flags & GUEST_MEMFD_FLAG_USE_RESOURCE) && args->resource_fd)
		return -EINVAL;

Should unvalidated reserved fields be silently ignored when the associated
feature flag is absent?

>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-gmem-tmpfs=
-backend-v1-0-d36159822d18@google.com?part=3D5
