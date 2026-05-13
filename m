Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DD2423A7F;
	Wed, 13 May 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677938; cv=none; b=s9Mhtlr/Ou8+5mgr8o1wN7CEtGIJ/GhJnBdxKqJfhnVlF7Hvcwf5iY9Ab6BcCSt2ksefJvlafAWxpo19Z5sqjkHKpaIoMzOzu6qy88bVdf5CXm7sMlKnkaNH87iU7cEFosLqSe2yqO+OC5rf+rJY2h3wXAH7Dy9uJdvIUcJasoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677938; c=relaxed/simple;
	bh=iCpxvNQX2QRchxRRcav3/dDScMh7AbO9nXWT2wbP6/g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=H+twc9NQm2nm+pOE2sBdxDfc6RLQI5ab3xW4gIOME2iLHOIQtyFv3kYzXKPxgzqTL5mT0OAr+AE49C9nqtjBeBpuUieNtY4Uyvmgs32/SzSFqqaZ3AJmxCV4/pGxJqk2HmfaiAlhZaoSs8F2YLXAJnZ2d1WC8P1BRFHOJi4pNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IF9cL5xL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IF9cL5xL"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 31E9C40E01A1;
	Wed, 13 May 2026 13:12:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aXYNBOPSziOK; Wed, 13 May 2026 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1778677922; bh=iCpxvNQX2QRchxRRcav3/dDScMh7AbO9nXWT2wbP6/g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=IF9cL5xL/wOF2qWuzfJdNvAmYyGRcLLQaPnb6Hin1JmkrWhtgLmKWxhqBCljy72fb
	 LcnSc7tU+ZYWu5NeRZULEnLgTI66xW6II2g1w/oJJGDtGkQEhJSzgBm1xMfWID2ttH
	 J5rtln44lnZP2ZPotW6HKovFtJw9C+kR28k8JVzx2DyexPMnR4hbmSHBKvtRSU4u8r
	 YKUjHqXUZz+a+FK+mFcafJEgPbLjOcMfbaWG+p33jG3vZzWD7mWT9LmVwTo+8eiQOp
	 483BKt1UviBM7V4x5HjC5G9daK32S/JQpiZtCZUISi7KFmNChFXZOsLq4WRnPh9Ou3
	 w3NvZ4myTH5SMBf0ngvn/uhtRysWujldi3gkY1VeHA4pslFjZG2lnsOclhRx00UcWH
	 s4ivftcBjzK/STKs/rz9yA3vuvsZjzsnlvXfNuuv6Ne1MyNZTf7nLv4TFEnEU0QDhT
	 eOLxInqRfrVgs/EyOGc0NWTgwYAEWca0wVzx+0Df3QT54N5yYrn2i9VE60rlJvsqjO
	 rMYII9OTnkJhPqDHRoClAJJhEyUeYblu80i5WUNcsJic1A/3hrnwH+RAvK/5uqqfbI
	 ca+NZUl2EmWb236Ykhi9n1wxjm6U1Ik2zci5/h/MlmnSZo1JuYoPWbykAjUiUL6FkH
	 WUOkt993ideqldzFq26MkjJA=
Received: from ehlo.thunderbird.net (unknown [IPv6:2a02:3033:26b:33f2:2529:b5d9:a881:2128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A4CA40E00C2;
	Wed, 13 May 2026 13:11:50 +0000 (UTC)
Date: Wed, 13 May 2026 13:11:45 +0000
From: Borislav Petkov <bp@alien8.de>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, vishal.l.verma@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_x86/cpu=3A_Skip_reading_MSR=5FI?=
 =?US-ASCII?Q?A32=5FPLATFORM=5FID_in_virtualized_environment?=
User-Agent: K-9 Mail for Android
In-Reply-To: <0ade3fe5-4834-44a8-a0d4-eae088c4aade@linux.intel.com>
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com> <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local> <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com> <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local> <4365e457-3d3d-4bc0-ac11-b3d4dfe8ccab@linux.intel.com> <20260513110805.GBagRblQVSjxemzwsQ@fat_crate.local> <0ade3fe5-4834-44a8-a0d4-eae088c4aade@linux.intel.com>
Message-ID: <D568CD6F-0DC7-4388-82A4-A36AB8E82FFA@alien8.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 13, 2026 12:20:01 PM UTC, Binbin Wu <binbin=2Ewu@linux=2Eintel=2Ecom=
> wrote:
>My fix was intended to skip reading MSR_IA32_PLATFORM_ID if hypervisor is
>detected, I used cpuid_ecx() instead of cpuid_ecx_native() so that Xen PV
>guest can also read the hypervisor bit using xen_cpuid() (Xen PV guest ha=
s
>overwritten the pv ops) to make the coverage=20


Which part of "can be handled completely separated from this" wasn't clear=
?

The current code uses the native cpuid variant=2E If you want to fix Xen, =
send a patch ontop please=2E


--=20
Small device=2E Typos and formatting crap
