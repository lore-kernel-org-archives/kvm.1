Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDD335562
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045729; cv=none; b=k83hclqsrFGlsja6MZqeDO9nnqpLF2H3jp5rVd4hlaRzp/Dn8n34RkF0eq6MFAUuVa3T+mIdcur64JerZ4H8U8mysJmXBTZdr6Md7JhpoDKCykpyytloQUEtNS5FkaQYxsEM1kYqSsca/lnFikbCwDDo8u+mhyPJP321lsfmKyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045729; c=relaxed/simple;
	bh=kU6sLy/i0cJOnetP5Co+iC5u31/ISmJNhpmdzi/dPH0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HvFhrNpNqT6oESatIlzkxFKnZec88P+ePxoEEUtmFGabkcqfW2h7ChxTB+e2AobWxKq8Ntdy0sIozrf6L4G0S0CeZp1Bw3qLByky1127boNqJwbTcWuCE81oB5oMJyhIAKEgznO3cuiRl+f0Ad5jIqW4YPORZWPzjHm/gQvfq+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=UE5GDi1L; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="UE5GDi1L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=sR7PWVzDNl0Tt491SxI4OxCz/9aFZbKZgaCBkHzdKEE=; t=1777045726;
	x=1777650526; b=UE5GDi1LSQWTJ6MiYXrfvkXzAEHd0fUzRy8DI8Zx8+D9iLKSWcm5mJKHbkWxE
	+ZnG2F1rJ7C1FfG+WaAGI7QoIKQId6l8k+po1BomnItpBnG4Ebvmu++Wg0cJFAK2WlOQIMYqiT/eV
	bPywQ71J3RK9JmTJ24sk1mMGIQrIxzS+lLaYxOuBvBuewzQb3+48rggTciQ+44u26hCxsEJA613Rv
	X00fbjrH3CxOsn7h6T+NGWmf3Y1kKusWpABQcyz8qr10kmggIynAKT8J9ZfLh6pxR32/sE8fZUilM
	TZ3aPNybYFAmGk94zlnEqRoox8kvmHErH8tOhRhg8v/ZYV6pIA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wGIli-00000000k6X-3PRH; Fri, 24 Apr 2026 17:48:38 +0200
Received: from dynamic-002-242-158-062.2.242.pool.telefonica.de ([2.242.158.62] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wGIli-000000007EX-2Trq; Fri, 24 Apr 2026 17:48:38 +0200
Message-ID: <d9ad0cd6fa640f23c396778bce2aa322e40e7e88.camel@physik.fu-berlin.de>
Subject: Re: KVM-PR no longer works when compiled with new GCC compilers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev
	 <linuxppc-dev@lists.ozlabs.org>, kvm@vger.kernel.org, 
 "debian-powerpc@lists.debian.org"
	 <debian-powerpc@lists.debian.org>
Cc: "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au, mad skateman
	 <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
Date: Fri, 24 Apr 2026 17:48:37 +0200
In-Reply-To: <a584b7a1-fc25-a475-099a-634159b6ffe8@xenosoft.de>
References: <cfd779d6-9440-46b2-9ed5-752f1ae6b5d1@xenosoft.de>
	 <588ada6c-bcc4-e93b-1beb-4f7f859e3d5c@xenosoft.de>
	 <eee732904c2a7ccce9b496b05f988a36d8a9883e.camel@physik.fu-berlin.de>
	 <5da12382-5424-4bd9-981f-359e4dc1fa67@xenosoft.de>
	 <a584b7a1-fc25-a475-099a-634159b6ffe8@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Fri, 2026-04-24 at 16:47 +0200, Christian Zigotzky wrote:
> I compiled it with "mtune=3Dpower4" today but without any success.
>=20
> Error messages:
>=20
> [=C2=A0 800.274759] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
> [=C2=A0 800.274767] kvmppc_exit_pr_progint: emulation at 100 failed (0000=
0000)

What exactly are you running inside the KVM? 0x00000000 doesn't seem like
a valid instruction and a quick Google research reveals that this triggers
a SIGLL trap.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
