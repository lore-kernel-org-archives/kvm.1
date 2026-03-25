Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599213A3821
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432519; cv=none; b=TL1QfUx3eciiHYxGgFcmcxVaymGVBMifuZhbMy5CZilKNmyIQFgg9r12/q//sVtPKoXVxETnS4GpaS5WDAMPZDSedI2FgiEH6eWq7Tz4wYCwiLCesqvI4ydG0MoxXPzBsRRLuIdgm4zQAdSkPerUtCLQDbYZpaNo3KOU7MvRmZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432519; c=relaxed/simple;
	bh=tJpE3nHtIwutAS8FrznYdTlEQD6Hh4nzxQjgsh3Wg54=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=r3I/+N6RiefcTJyyOJtzfy48diTK+dLFElw8HR0P8LfFNPWDR7G/OHDKvFZ+gjVccdahoOmwMeldddCTqytGqOsd2Ho2cryWJBa4BDBLmBo4Bg79OzuRVlPg4eauhs5rPUjB6xA5wZwrQ0nbDzzwowflBqxt4s9/Vp34xLV0rUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C7LgyjZB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C7LgyjZB"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 496AF40E015B;
	Wed, 25 Mar 2026 09:55:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 78CoyLx0m9XD; Wed, 25 Mar 2026 09:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774432499; bh=tJpE3nHtIwutAS8FrznYdTlEQD6Hh4nzxQjgsh3Wg54=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=C7LgyjZBZLBw78ii/e9eKHM4aUbFOGJfwO47leRwCJP9T06qVDVy9tzy4MA3zeY8q
	 Hns57nJjUt0ZKvycilfguECuiYjlH/X4svHMd5YPomTJsCLiquVNzzpLLX+QSD0UL6
	 ncQYsasy6BBJOKwuxfP99pk2Gd/ddYsKT6yfvaeUjSByaE0RzkknTY6YETuPue7cgi
	 afBFwXhzfGNL8/UEq4J/StNNFL3vFbzBCDbliytVOHEd8dQOK2r2337ccUKoc/HslB
	 C7E9sIf11cBLi/KGLrq9FzKeFcPswMJ6fsYd4nN87N5ThXwlNmoRhXsJyKFCJjZSDW
	 2yxCIHGW4Ut40YxDronyM9QsPE0eUQ8vjieQUhrKMFBtiwYWaJ/P3Y7U8SyElpZ5WZ
	 pAfmk26kGpRuT1X7e421PDzDC7uEtqjanvVGfi9ed54qvTcdWipOAjdDj5Ur9gsTZI
	 nGOJpJ3PDgLGG97zonrwFKhOOp3zYoUb18Ao3P9WMePrwENnfx2FnH4NHNTReP0p+E
	 7Js200ZIB63pRjWdv7I0c4GAOht4LU39FF6L4eKAX6Bd4JKf8H8bllF/H9BFJVn/ZI
	 E2t/Ngh4lailtI8+cw2ExLF5LbNPs2yVRvfeldLixZx9dwPs4PDaA0p/NUvUS932vi
	 W3a7l+tK2temVsVGiN85PWUk=
Received: from ehlo.thunderbird.net (unknown [IPv6:2a02:3033:266:68d6:b127:ed1d:b692:3857])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D74340E01B5;
	Wed, 25 Mar 2026 09:54:47 +0000 (UTC)
Date: Wed, 25 Mar 2026 09:54:43 +0000
From: Borislav Petkov <bp@alien8.de>
To: Manali Shukla <manali.shukla@amd.com>
CC: seanjc@google.com, pbonzini@redhat.com, mingo@redhat.com, kvm@vger.kernel.org,
 x86@kernel.org, nikunj.dadhania@amd.com, Naveen.Rao@amd.com,
 ravi.bangoria@amd.com, peterz@infradead.org, dave.hansen@linux.intel.com,
 tglx@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_v1=5D_x86/split=5Flock=3A_Provi?=
 =?US-ASCII?Q?de_KVM_helper_to_log_guest_bus_lock_exits?=
User-Agent: K-9 Mail for Android
In-Reply-To: <b3f3058d-c0eb-46e0-a443-5ff0f756df6b@amd.com>
References: <20260324124002.7670-1-manali.shukla@amd.com> <20260324180449.GMacLSQUJepcHGCjTX@fat_crate.local> <b3f3058d-c0eb-46e0-a443-5ff0f756df6b@amd.com>
Message-ID: <1F01D0F9-83C5-418E-B864-C8D80345DE9E@alien8.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 25, 2026 9:32:30 AM UTC, Manali Shukla <manali=2Eshukla@amd=2Ecom>=
 wrote:
> However, the other reason for keeping the
>function in bus_lock=2Ec is the current->reported_split_lock usage - it i=
s
>already used in split_lock_warn() and handle_guest_split_lock() in the
>same file, so keeping all reported_split_lock accesses in bus_lock=2Ec
>seemed more maintainable=2E

Meh, it's not like C has member access rules=2E Besides we can all grep=2E=
=2E=2E I hope=2E

:)

--=20
Small device=2E Typos and formatting crap
