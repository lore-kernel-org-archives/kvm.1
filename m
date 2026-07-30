Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9745B3FFFA1
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410812; cv=none; b=TT5Org6SWUGLqGIn4v1iZWRti9lhlmlYfShrPmBHXZivT3svx7bXLMcr2HtufpqOgWEV/9CgKvT7zhOY1roqwnS4HLzee+4qg97K9yxuAgLPtRh0hjB1KUZlXvRNqSx3lOtjhzuYsOsM0+bZoMuXf8UhTl7iVqzJvAwcFx9uTkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410812; c=relaxed/simple;
	bh=rjtsBSvx95rOJmBq3mZTryV8XjdPzR2jRI/yu+d9TEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PcZQrP+H9XkJgs21/aDB0s4Bhy6BGzrgGLYl1GC1OOUgNjM/zzNVvlcCCKLhJVnPblY50RW+hiVuwPyEGzqQPhttEwcBseO4VVh2fWQ/b/DgV3y8NGZGQNglTaHLjLh3U516ECRFFnD2KpjsQFIcnV1wFIhHT1sTPkrjRXJBA1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgmvPbMK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgmvPbMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319641F00A3A;
	Thu, 30 Jul 2026 11:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785410811;
	bh=Y54KiZ+D0oUv0n81x3eVbOpyVYDrVN3bDNK4HAIjAWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mgmvPbMKUUlk5kKuk3VP5PlkyoXUIQAPQmYSgiXPyeNv7ry8hrHSSt/xAYp5alcWM
	 rDqmocz3QbfWCMik/XCSdXgzgfn4i9RdrYv/UuNgvDK6Zg6Ng9Q0+PkNOYbgvB8vHg
	 TePDaJYsEj95OmUtqheVN9wjH9lZfhEV57J6gxoyTqClnSJHW5pou6DYi+vg7g+MKr
	 PDkk/mae1rZ/dsjXV9mG8FKX/1lEkXD/WqoBytBfahpICJmcrFHUO55Q8MoI9OpOYk
	 nfIbSyOvAzoWKfI08vOD8Yoye16vTkJCoFoT5YMq4S3MCSjdjrdAzWqeyFqrUB2Ykh
	 wDGjSr0H7gHMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] KVM: selftests: Add Zhaoxin (ZX) CPU detection
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ewan Hai-oc" <ewanhai-oc@zhaoxin.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260730110524.2539316-2-ewanhai-oc@zhaoxin.com>
References: <20260730110524.2539316-1-ewanhai-oc@zhaoxin.com>
 <20260730110524.2539316-2-ewanhai-oc@zhaoxin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 11:26:50 +0000
Message-Id: <20260730112651.319641F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Type punning from `const char *` to `const u32 *` violates strict a=
liasing rules.
--

--- Patch [1]: [PATCH 1/8] KVM: selftests: Add Zhaoxin (ZX) CPU detection s=
upport ---
commit a6b3b2a2cfda9cc7037a7ac4f7079fa35f410950
Author: Frank Zhu <frankzhu@zhaoxin.com>

KVM: selftests: Add Zhaoxin (ZX) CPU detection support
   =20
Add infrastructure to detect Zhaoxin CPUs in KVM selftests. Zhaoxin
CPUs use vendor strings "CentaurHauls" or "  Shanghai  " and implement
VMX-compatible virtualization technology.

> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/=
testing/selftests/kvm/include/x86/processor.h
> index b161174ece453..9840b583877c3 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h

[ ... ]

> @@ -744,6 +745,12 @@ static inline bool this_cpu_is_hygon(void)
>  	return this_cpu_vendor_string_is("HygonGenuine");
>  }
> =20
> +static inline bool this_cpu_is_zx(void)
> +{
> +	return this_cpu_vendor_string_is("CentaurHauls") ||
> +	       this_cpu_vendor_string_is("  Shanghai  ");
> +}

[Severity: Low]
Does passing string literals to this_cpu_vendor_string_is() introduce a
strict aliasing violation?

Since this code is built as a selftest under tools/, standard
-fstrict-aliasing semantics apply rather than the core kernel's
-fno-strict-aliasing rules. Passing a const char * string literal to
this_cpu_vendor_string_is() results in an incompatible pointer cast to
const u32 * during evaluation.

Could this type punning lead to undefined behavior or compiler
misoptimizations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730110524.2539=
316-1-ewanhai-oc@zhaoxin.com?part=3D1
