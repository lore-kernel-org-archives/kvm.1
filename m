Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D06406804
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096052; cv=none; b=QOHyjZbxqeq0iONAG+ShI+Y2i3dgnqHbNiW8JOpBzx17aAPqycYVAUu3RlINskdrZ4RoUXgMjIpRODzs+vsfNMrTY3EFYwfhUSQx9h8zR2WqE8VeT7zSc6iKrjsk5VS8KqRxfl+w2WQzrJtNapeO7LDx2G/Iwc2lLm49rFzbD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096052; c=relaxed/simple;
	bh=1fDn8e0kzyJZXjNTkgS2W925lJ9q1jwyjr0ErIJlU4g=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oERAM2Fflkcxz6TP2Fz1Hh0PezmecxceQ9MqmHtGtd27iB2CyNJHKNeiZtRaZrKwHX8KyLlDGKy5MTi/EEKibMVGg0rJct5G6MX0q6uhxplpeH5PSsFOTwrg9jOtunmRm5z77m3/cq33da4l0SRNTKaXRTnd4FNvgHgZUrRxCnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOGSaOIq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOGSaOIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988A41F00898
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781096051;
	bh=1fDn8e0kzyJZXjNTkgS2W925lJ9q1jwyjr0ErIJlU4g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BOGSaOIqOpjX4WpFokHXjBO4HPbW0/jTqTHHrk2GY5dJeo6nSd9yP0LkeZ/Gt4E4Y
	 dFLuWaqPIfDGblCqk2jclrHXW/NAPQvNSzVnsSEKBw9vJ9iaxMkrbPNMiusWKmpeyC
	 umZ/lg+RH3QUNyHoBTgIMXaEWcGsg9Y202WV/irQFjPQ3E+63VZZJIIa/AhZ7ORnHp
	 jDWzAYIy/22YHXLszrPDdNtNO2Zj66LOKOq6sDE4uBPr8QcqIEeiGizsdOE0INyUW8
	 ffgRxqKFGcx+RpaLuQBFk1sAMndzQWO6FtGCYhxnkLyMYjkRK4ZPIX9apyzAQ/5Liq
	 pGLSpkmfYU9BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 RESEND 09/10] KVM: PPC: selftests: Use u8 instead of
 uint8_t
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <9bbb88d55320ca04608787e05222a865c141d713.1781093720.git.ritesh.list@gmail.com>
References: <9bbb88d55320ca04608787e05222a865c141d713.1781093720.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 12:54:11 +0000
Message-Id: <20260610125411.988A41F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Commit message contains a copy-paste typo, incorrectly stating the =
conversion was from uint32_t to u32.
--

commit be805dd1657bb3d5b73a2937cc30e09c502a04eb
Author: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

KVM: PPC: selftests: Use u8 instead of uint8_t

This commit updates the powerpc KVM selftests to use u8 instead of uint8_t,=
 bringing it in line with the rest of the KVM selftests.

> commit 6ec982b5a2c7c ("KVM: selftests: Use u8 instead of uint8_t")
> made this change from uint32_t -> u32 for all other kvm selftests.

[Severity: Low]
This isn't a bug, but there appears to be a copy-paste typo in the commit m=
essage. It mentions converting from uint32_t to u32, whereas the patch titl=
e, the sed command below it, and the actual code changes are converting uin=
t8_t to u8.

Could this part of the commit message be updated to say uint8_t to u8 so th=
at it accurately reflects the diff?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781093720.gi=
t.ritesh.list@gmail.com?part=3D9
