Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A76285041
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780239673; cv=none; b=VgKt6+m8h1xuLB+uo/ihhshEAQtVIOqXSQSDeIk+kgIr29GdOA9XjRJoD77vnPFzFNh7PmhAvUni3cIh7KxY7DA47AtYAcGNhBdOs4gkeG+KLU1kdrZPUa10go0Q6zP4mHtOkWG/LFsPM29o9ZPD9+wBQGoVtFCY4ZPpeRqg7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780239673; c=relaxed/simple;
	bh=m/doq2BtzLeS5lo9H5+wwfTuHFdurPg/keWVEZ7wRG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XEthxWPJN02lHagX7m780tS6RmXRKulNIcDGdk/T/RcQ0aNj66Wom0FlGySWQgeeMnZAddqJj4csPkdDWRlpR8/ukNxaMHVVm0T1ba0QGoSM7SxeOrcGqIYTGwIXbC3if0qErZmsnFemgrTPmuUTZYmE2siTlXeGsWdSgYsONbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTzG2Ftg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTzG2Ftg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5084E1F00893;
	Sun, 31 May 2026 15:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780239672;
	bh=9Mguv/y04aB8HP70xjDgZ18UircjRQNluGEP8H3bgok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QTzG2FtgniwY1uDh9eXrmcaNOTs6D68hz9xuE6BGhxumDO6w+NtTp6qz2AsZ4XnXl
	 2qofdO4jFgN3doePu+2lkDyKWP03YKEYgunQVBq9xt74ax02WVlvKN0oHtgQEbh/Ty
	 2p4TNPhy4FdzyWWEed0f3PSxajzrV2A9y83WpUujCw89t46u40OmWM1n1NWvNrJq/R
	 Tdhb17wwe6pWjjK3YbcVzu6iy4o5wGNqEWP2f8hnOh3NjFUSG9VuiigMgfUowPtA8d
	 V/K+LjkvLcot/9nFZkQJGRCDE7QPK15vgTIm+spQ7wel5l1CaxM4J5rBq1e+5X0ptg
	 /Tu8KksCbKj8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools/include/linux/types.h: add ulong typedef for musl
 compatibility
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hisam Mehboob" <hisamshar@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260531144934.403888-3-hisamshar@gmail.com>
References: <20260531144934.403888-3-hisamshar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 15:01:11 +0000
Message-Id: <20260531150112.5084E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Adding `ulong` typedef to `tools/include/linux/types.h` causes a `-=
Werror=3Dredundant-decls` build failure in host tools like `perf`.
--

commit 88e8d7a9a4205d14733be0e5978d3a32589a15e0
Author: Hisam Mehboob <hisamshar@gmail.com>

tools/include/linux/types.h: add ulong typedef for musl compatibility

This commit adds a ulong typedef to tools/include/linux/types.h to fix build
failures in KVM selftests when using the musl libc.

> diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
> index d41f8a261bce8..ccc90dd4baeb2 100644
> --- a/tools/include/linux/types.h
> +++ b/tools/include/linux/types.h
> @@ -42,6 +42,7 @@ typedef __s16 s16;
>  typedef __u8  u8;
>  typedef __s8  s8;
> =20
> +typedef unsigned long		ulong;

[Severity: Low]
Will this unconditional typedef cause a build failure in other host tools=20
like perf?

Because glibc and musl <sys/types.h> also provide a ulong typedef, adding
this here without guards triggers a -Werror=3Dredundant-decls build failure
in tools like perf, which compile with -Wredundant-decls (via EXTRA_WARNINGS
in tools/scripts/Makefile.include) alongside -Werror.

>  typedef unsigned long long	ullong;
> =20
>  #ifdef __CHECKER__

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531144934.4038=
88-3-hisamshar@gmail.com?part=3D1
