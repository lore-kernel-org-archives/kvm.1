Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E425785C
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727760; cv=none; b=uTidkHLqpgbvu/qm0eO4lY/Df0fEeRvh/niLANQTixp/fpJdUI1L9x3/uY34fxoQd5FuuZy1fTgQEGEq0dTdfhi5KHNr+TqUs5rwMlJNPgKjGxgAcKEmnjsNWVjNr7nY3tveIKkpww36ViZrVEcGDhJi4/NTA1Uvv9eQcN2DqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727760; c=relaxed/simple;
	bh=bZLkecVcY30bftvvVi5bd6MjV0m3Ziim8s8JGxTsVSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YdJiCn8fDQBWm2NbSJDqgbW8I+VtKuVz+6lHfBdbyZXeD+EUZ48FkNFUA9GRcnQ7kMikOXJ/Win4VUJtADwwow0KAGlGL55JqekMFW83+TnQslexcGNRVSvMI83gdtqzR0NotFA9MnrsVvXRCtEONCqqGp4zMj/Y/FGRstQlqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+OjPWkR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+OjPWkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649421F000FF;
	Wed, 30 Sep 2026 00:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790727758;
	bh=T6KzEUy1INtEJJYArZnSbUByEExKOQOabKMaKKIj8aE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B+OjPWkReicKp8n9su5aZQrNupSACQLU6SbsEcRho1PEFOfsv6yzrVfYV3BbzNlqK
	 FnVhLjEQYWom6XA0fALSJqMcIsdokKlSZjDQM0oMF3EDmA3Uf7wig3RhKBXkU2ffet
	 HZ5zGOFViYXKMrK5h4bptZqSsOZ2WuXXaDMy1pM0zuXu33mpbQpdgHua3xWqUNq8W2
	 Q+WwRmk3ZM3J5Cqu017N+DdHdf1VAZ+RfHcOwRcJ/XGzIQrdE1USW5jmXrYB6yjsTD
	 rO1qAh87Qid5LXJdbRdzsHe6B+K4D8neITzvR1GlFKWAxnlvHcd7OyPXYWAgeqjhX+
	 Xw5lBw7yc+j9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: selftests: Make guest_snprintf() a macro and use
 it as appropriate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930001341.3171558-1-seanjc@google.com>
References: <20260930001341.3171558-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 00:22:37 +0000
Message-Id: <20260930002238.649421F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/kvm: guest_snprintf() macro variables shadow caller ar=
guments
- [Medium] selftests/kvm: guest_snprintf() implicitly captures caller varia=
dic args
--

commit fab1360854d5b8141536eb1f70a7ed77983d6dcd
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Make guest_snprintf() a macro and use it as appropriate

This commit turns guest_snprintf() into a macro to allow its use by variadic
functions. It updates the ucall APIs to use this macro instead of open codi=
ng
the variable argument handling.

Closes: https://lore.kernel.org/all/20260918113631.634233-4-gokul02k@gmail.=
com

> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/test=
ing/selftests/kvm/include/test_util.h
> index a6a3e16578959..817d4d5ca7cc7 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -238,7 +238,17 @@ static inline u32 atoi_non_negative(const char *name=
, const char *num_str)
>  }
> =20
>  int guest_vsnprintf(char *buf, int n, const char *fmt, va_list args);
> -__printf(3, 4) int guest_snprintf(char *buf, int n, const char *fmt, ...=
);
> +
> +#define guest_snprintf(__buf, __n, __fmt)		\
> +({							\
> +	va_list va;					\
> +	int len;					\

[Severity: Medium]
Does this macro shadow caller arguments? If a caller passes an argument
named len to guest_snprintf(), it will be shadowed by the uninitialized
local len due to C scoping rules for statement expressions. The inner len
is then passed to guest_vsnprintf(), which could result in a random or
uninitialized buffer size.

> +							\
> +	va_start(va, __fmt);				\

[Severity: Medium]
Does this implicitly capture the caller's variadic arguments?=20

The macro internally invokes va_start(va, __fmt), which couples it to the
caller's stack frame. If this macro is used in a non-variadic function,
or if __fmt is not the rightmost named argument of the calling function,
could va_start cause undefined behavior?=20

Additionally, this restricts the macro to exactly 3 arguments, preventing
standard snprintf usage like guest_snprintf(buf, size, "%d", 5).

> +	len =3D guest_vsnprintf(__buf, __n, __fmt, va);	\
> +	va_end(va);					\
> +	len;						\
> +})
> =20
>  char *strdup_printf(const char *fmt, ...) __attribute__((format(printf, =
1, 2), nonnull(1)));

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930001341.3171=
558-1-seanjc@google.com?part=3D1
