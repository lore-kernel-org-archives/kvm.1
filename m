Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2C3BCD1C
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022618; cv=none; b=r9BMKb6zq7kSn6Mji8/CztnSW0LLFEK97orRVlLhWeoJOUW+cmWSa9WLJwf70P+lH7iWUj4m2dTubUJYu6rbOib+LZo7hqLH+E5zwH4CJpT1jDkoKNbbioNie5uz17cZWbyHaGVJUlzQ6Ypg7O0rSWK93R9PKw6p9EQBUWWDTeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022618; c=relaxed/simple;
	bh=wglGkK+Wqcig3U9UO39P6xvQ4ndk/UF9CIKej9ANDl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L5ktCaltSeOSBES75AUQpPMUlRZ5HvvPRg03a16oE5we1cLbcGg30yXU6UwiPs/qhJZnIKCUXYYnVK0DBfaFUnLB89z98TMzZTFCg6kpR64e+Z1H1T3AOqTm2mwlMOs6fvq3XYJaOD6ZVhgkH1jQtBlSawiFJdoiyMGgR43KKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbzFdio8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbzFdio8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB381F00893;
	Tue,  9 Jun 2026 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781022617;
	bh=UjPwjttdtMGMRO2elhEwgzhu2EwOxtuaivlKsD/6pDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KbzFdio8YMYw2mYpAvV+aUqHM5sVsFQ4fwAnZE5f0JRnxjJoM88isjjr+dzmne6RX
	 LqcVKDnXXeKDWqX2G9TfsRcBeMj+O83089scWP/U/4Zaw5VES7LYkZR+5rDfvvcnoj
	 L8aUJWHHI9THsP/z8gxlXNFcbWUIX7XCvEl72v1qNT2x8C9xiJmVjtEQtrUv3x13h9
	 LuUBM0rVGT19Cuz9lnD7nMEWYVkGJ3Y1s68yukZ9IbCL/4YNapmYPWHJZPWrTvI+/4
	 96eBwP7Fjim5gYbGrwMQ3zJV8EXVs+rd2nzcZlktGU+63qwi0hMG7/2Y8flt09cGpd
	 w/0g2jeXUOv8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] KVM: s390: Silence potential warnings in
 _gmap_crstep_xchg_atomic()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260609161646.695361-2-imbrenda@linux.ibm.com>
References: <20260609161646.695361-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 16:30:17 +0000
Message-Id: <20260609163017.6EB381F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `(void)` cast does not silence `__must_check` (`warn_unused_res=
ult`) warnings in GCC.
--

commit ba4c03a707e418c0a14a0a8490bf5c5ce461e30c
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Silence potential warnings in _gmap_crstep_xchg_atomic()

This commit attempts to silence a compiler warning by casting the result of
dat_crstep_xchg_atomic() to (void). The function is annotated with
__must_check, and the caller intentionally ignores the result as it is a
best-effort clearing operation.

Fixes: d1adc098ce08 ("KVM: s390: Fix _gmap_crstep_xchg_atomic()")
CC: stable@vger.kernel.org # 7.1

> diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
> index 5374f21aaf8df..4e6979783e16b 100644
> --- a/arch/s390/kvm/gmap.h
> +++ b/arch/s390/kvm/gmap.h
> @@ -279,7 +279,11 @@ static inline bool __must_check _gmap_crstep_xchg_at=
omic(struct gmap *gmap, unio
>  			gmap_handle_vsie_unshadow_event(gmap, gfn);
>  		else
>  			_gmap_handle_vsie_unshadow_event(gmap, gfn);
> -		dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce);
> +		/*
> +		 * Ignore the result, it's just a best effort clearing of the
> +		 * vsie_notif bit. The caller will have to try again regardless.
> +		 */
> +		(void)dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->as=
ce);

[Severity: Low]
Does this actually silence the warning on GCC?

The Linux kernel defines __must_check as __attribute__((__warn_unused_resul=
t__)).
GCC ignores (void) casts when evaluating this attribute and will continue t=
o emit
the warning, unlike Clang which allows the suppression.=20

Since GCC is the primary compiler for KVM on s390x, will this patch accompl=
ish
its stated goal, or should we actively evaluate the return value instead (f=
or
example, using an empty if block)?

>  		return false;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609161646.6953=
61-1-imbrenda@linux.ibm.com?part=3D1
