Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E87262B
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842698; cv=none; b=sKvaqL+u7ycLtHEPzAncXbcAa8PjYBgVN+XO97spWS4boeyPsczG/J+dtEx+OBfI9PCxExmS0ZLwsvehRNPeyynevUDeNFsZmJIf5Jg26P9Ql3ZTl3pUc9UTfKqtwQz7zfl+oXZSR0AfkusCCUiml01bg6dDT+D9CevtmuoZMlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842698; c=relaxed/simple;
	bh=ikJINX9vfacFC9f5WAvIrMP8Zy5Q3upW+J1fhaQdno4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VGghw7ku+VCG/NiPcOT8TTyswH0MIssCi/3Ie8N41exB3LiYqenKBFYtqWmijU1vmeKasR7p/xUgy8r9AYPW5AJ+Y5DMS7UGSgD4fxQUi9wyK9DIVy1MHXdmG9rYN9XpvUEg4GCpgsgyKSYXJDIlR408o/Rx6VrHF8nOe6/lK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PriWcaQu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PriWcaQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0B81F000E9;
	Wed, 27 May 2026 00:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779842697;
	bh=YEp24+eIWzuTW4iiuyX1hNB9n56LoZLY2+4R5K2Ecns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PriWcaQulJ3NbFAiP23L0tL7ecSQhFCVnBsoQIW9DBrR6/L/uW+LHlpns3qv0dZ+f
	 XRN76gHtJ7EItqRhXG0KQR5YKQuf+n/4lhDYjPhpNs+7fjLMPNaBKWW1yCNM5qR/eJ
	 aNpsVboyBPf2cHQRD60Rnq51NJCwLtihU1JSE46hqrEx04l+10WMfCo5kd4BaRX6pz
	 Y6V3ONbGPD030CwFIyHNtrROJA+0mbedvYWOXHLOUFqSnYVsFqdsC39K3iYoZVt6gB
	 4gOLK+VHDoZF+/2erU1quHL5CStslY1d7/E3lAHdYopJYKRbyNZsHeb6gW03kP6VAb
	 HZGKXR84zXpyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: Delete guest-triggerable (in theory) BUG_ON() in
 ioeventfd datamatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260527002910.3931382-1-seanjc@google.com>
References: <20260527002910.3931382-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 00:44:56 +0000
Message-Id: <20260527004457.3F0B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the `BUG_ON()` alignment guard exposes direct pointer der=
eferences of potentially unaligned memory, leading to C undefined behavior =
and potential alignment faults on architectures with strict alignment requi=
rements.
--

commit 811fc6dc622ae4cbc57a596cae2d0500853c54b9
Author: Sean Christopherson <seanjc@google.com>

KVM: Delete guest-triggerable (in theory) BUG_ON() in ioeventfd datamatch

This commit removes a BUG_ON() in the ioeventfd datamatch path that can be
triggered by a guest performing a page-split store. The patch removes the
alignment check to prevent the guest from causing a host kernel panic.

> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -779,9 +779,6 @@ ioeventfd_in_range(struct _ioeventfd *p, gpa_t addr, =
int len, const void *val)
>  		return true;
> =20
>  	/* otherwise, we have to actually compare the data */
> -
> -	BUG_ON(!IS_ALIGNED((unsigned long)val, len));
> -
>  	switch (len) {
>  	case 1:
>  		_val =3D *(u8 *)val;
>  	case 2:
>  		_val =3D *(u16 *)val;
>  	case 4:
>  		_val =3D *(u32 *)val;
>  	case 8:
>  		_val =3D *(u64 *)val;

[Severity: High]
With the alignment check removed, can val now be an unaligned pointer when
it reaches these casts?

Because dereferencing an unaligned pointer directly is undefined behavior
in C, could this lead to alignment faults on architectures with strict
alignment requirements, given that this is in architecture-independent code?

If a system is configured with CONFIG_UBSAN_ALIGNMENT=3Dy and panic_on_warn,
wouldn't an unaligned access still allow a guest to trigger a host panic,
leaving the original issue partially unresolved?

Does it make sense to use the get_unaligned() helpers here instead of direct
casts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527002910.3931=
382-1-seanjc@google.com?part=3D1
