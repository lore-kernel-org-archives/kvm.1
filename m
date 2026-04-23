Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76F1D6DB5
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965721; cv=none; b=fSte1b0cYwfBvVEvawVFbxKa9+/bvT/HxyMVutoJ/MGggMshHbXaCCmUndsqZBvXxjbRqpMe6CmGHp85XXdCPazZXhxPwGMYcPMZ1McRinwmEGtNw+1sckmbe3hLRGvIHpY1iz/qya0DuFY8YaQ9Xu4dFacRz96sXSIlBjGZGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965721; c=relaxed/simple;
	bh=MkG6mMhR10MpZ0HW68ePKqgcY9pDJqwsnfnSliRYfFc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RqxVAaWpXLdceSrlbh9W0xY0PMESvTiR3whWIcuKTSwsh+OlLCHrTNQYWMN4Nc2/z09YJGr65/dJYguwvpHLRx2dEmLAMkcqKOkNC+/61B7lBpcF/fePxQURb6guxqMhglptLHmn5hEwFZFqSnctyu0pk+0plcwEgULVeOa3qx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=lFCnNWKG; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="lFCnNWKG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=GJw7yFXCFTC80hgAw7N2IV7qI8Oysh8o3mjC4onHLRg=; t=1776965719;
	x=1777570519; b=lFCnNWKGRH0og1E4PUtq+pN/BD109ygB+PlQcDL50qP5oRJu2hMpRfR3m9UcU
	QPflVqdKf861CCAZ7XUwDhP+C0vnd+pUMxYxSmH6svUjPtxJGsW/VHikyF2n53QpWY4pCwF885QsH
	ixVhVIecwbpTNVoggjWpaXYU0+IhJ632iaWQrMP8a1+9aHuwLTTbJ4jWUCmGdwwRCXK++oOQWBJf+
	C54BEI26S0JQ/yQGD+24k/8VissfFAIcg06tFD71kIyza8CXiG9Ariqy1smighruXNTBgpUhwFRg0
	DuypPI6xkNQxK5MWUpvw9kZju+k8f7fx1tXKi7qk5UNvZrMNqQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wFxxM-00000003Q7V-25In; Thu, 23 Apr 2026 19:35:16 +0200
Received: from p5dc559e1.dip0.t-ipconnect.de ([93.197.89.225] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wFxxM-00000001oKD-17um; Thu, 23 Apr 2026 19:35:16 +0200
Message-ID: <eee732904c2a7ccce9b496b05f988a36d8a9883e.camel@physik.fu-berlin.de>
Subject: Re: KVM-PR no longer works when compiled with new GCC compilers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev
	 <linuxppc-dev@lists.ozlabs.org>, kvm@vger.kernel.org, 
 "debian-powerpc@lists.debian.org"
	 <debian-powerpc@lists.debian.org>
Cc: "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au, mad skateman
	 <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
Date: Thu, 23 Apr 2026 19:35:15 +0200
In-Reply-To: <588ada6c-bcc4-e93b-1beb-4f7f859e3d5c@xenosoft.de>
References: <cfd779d6-9440-46b2-9ed5-752f1ae6b5d1@xenosoft.de>
	 <588ada6c-bcc4-e93b-1beb-4f7f859e3d5c@xenosoft.de>
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

Hi Christian,

On Thu, 2026-04-23 at 18:50 +0200, Christian Zigotzky wrote:
> On 02/10/25 08:37, Christian Zigotzky wrote:
> > Hello,
> >=20
> > KVM-PR (-enable-kvm) doesn't work anymore on our PA Semi Nemo boards=
=20
> > [1] if we compiled it with new GCC compilers.
> > The VM can't boot. There aren't any messages on the serial console of=
=20
> > QEMU.
> >=20
> > It boots without KVM-PR.
> >=20
> > Kernel config with new GCC compiler [2]:
> >=20
> > - CONFIG_CC_VERSION_TEXT=3D"powerpc64-suse-linux-gcc (SUSE Linux) 11.5.=
0"
> > - CONFIG_TARGET_CPU=3D"power4"
> > - CONFIG_TUNE_CPU=3D"-mtune=3Dpower10"
> >=20
> > It works if I compile it with an old GCC compiler [3]:
> >=20
> > - CONFIG_CC_VERSION_TEXT=3D"powerpc-linux-gnu-gcc (Ubuntu=20
> > 9.4.0-1ubuntu1~20.04.1) 9.4.0"
> > - CONFIG_TARGET_CPU=3D"power4"
> > - CONFIG_TUNE_CPU=3D"-mtune=3Dpower9"
> >=20
> > Mtune changes to power9 automatically if I compiled it with an old GCC=
=20
> > compiler. If I compile it with a new GCC compiler again it changes=20
> > automatically to mtune=3Dpower10.
> >=20
> > Is mtune the reason of the KVM-PR issue? I think the issue is the new=
=20
> > GCC. [4]
> >=20
> > Could you please check whether KVM-PR is compatible with new versions=
=20
> > of GCC compilers?
> >=20
> > Thanks in advance,
> >=20
> > Christian
> >=20
> >=20
> >=20
> > [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
> >=20
> > [2]=20
> > https://github.com/chzigotzky/kernels/blob/45186997e6f347fd092f9ab629d6=
2d6041426227/configs/x1000_defconfig
> >=20
> > [3]=20
> > https://github.com/chzigotzky/kernels/blob/bc7a3e27b3fcdee52a8135435f02=
cf807a43872a/configs/x1000_defconfig
> >=20
> > [4] KVM-PR no longer works on an X1000 if the kernel has been compiled=
=20
> > with a new GCC:=20
> > https://forum.hyperion-entertainment.com/viewtopic.php?p=3D57146#p57146
> >=20
> Error messages (kvm-pr compiled with powerpc64-linux-gnu-gcc 14.1.1=20
> 20240507 Red Hat Cross 14.1.1-1, GNU ld version 2.41-2.el10_0):
>=20
> [=C2=A0 800.274759] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
> [=C2=A0 800.274767] kvmppc_exit_pr_progint: emulation at 100 failed (0000=
0000)

I don't think "mtune=3Dpower9" or "mtune=3Dpower10" will work. Did you try =
"mtune=3Dpower4"?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
