Received: from smtpout7.mo536.mail-out.ovh.net (smtpout7.mo536.mail-out.ovh.net [51.210.91.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA37435EF3
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.210.91.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825338; cv=none; b=GMOpNk/pQ3i+hzhMxejvWvawWFiq11+mf2G92DrN2ELHrDcyWnfO5xJffNXlAuLw/EMS4X4wS41xsIRpSIuyFyY9LhZFWeOuozur3F6wFqpKDbT6XwMKnlXEhohSBprUuW4xc08i/H0xAJVDs75r1971JHlhqlc2ms0BJwJQndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825338; c=relaxed/simple;
	bh=VZ4Le3M/m4NnhYTp4z0zlCtxfQrzliK0uA3UXecN1tI=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=I/wi7IZeSKXJuE83EMa3x5jt4nMTX+jcTcHvSRxZ7tymvEcQgVFyiDb9UCb2yMgFjwS+of8dmO4j06ocV8/kNA06P5TUNiCYSIEV+KmvyQ1ULFEM6uGIBeeW0rLtih0/kRUZO1bHsZkN2lGANEen70kWuxw8jeRsVk7fDbnvhUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guillain.net; spf=pass smtp.mailfrom=guillain.net; dkim=pass (2048-bit key) header.d=guillain.net header.i=@guillain.net header.b=Zawu/kZ6; arc=none smtp.client-ip=51.210.91.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guillain.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guillain.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guillain.net header.i=@guillain.net header.b="Zawu/kZ6"
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hVwJd1lKvz890Y;
	Thu, 27 Aug 2026 08:52:49 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <jc.guillain@gmail.com>; Thu, 27 Aug 2026 08:52:49 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.164.80])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hVwJd11PWz1xt3;
	Thu, 27 Aug 2026 08:52:49 +0000 (UTC)
Received: from guillain.net (unknown [10.1.6.10])
	(Authenticated sender: jean-christophe@guillain.net)
	by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id C16143E1B52;
	Thu, 27 Aug 2026 08:52:48 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-99G003255765e4-3865-48d0-b893-2cc9b18a132c,
                    F56AF3F020D60C8C2792995819B8FD805BBD3DB7) smtp.auth=jean-christophe@guillain.net
X-OVh-ClientIp:78.240.189.86
Message-ID: <56a4bc35ee605588b7cc36c8e45c12b5f3b506cb.camel@guillain.net>
Subject: BUILD_BUG_ON failed for kvm_vmx struct size sanity check in vmx.c
From: Jean-Christophe Guillain <jean-christophe@guillain.net>
To: kvm@vger.kernel.org
Date: Thu, 27 Aug 2026 10:52:47 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-ovh-tracer-id: 18077730381273778979
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGGCOtzQ1Bl36I+HA9IXxFrtsWIdFaWn4UT7CF7q0M1df+g0MXX+IVATBmVMaT1CnOtCavjGBrNV0favPmB2xV7GYoOnCFwqRcyOXgvzX5I4P95Z8mzrFLJ70hq2tLz668RUghNieECfwtQ3Hw7OHlaXvT4q0hRdjZvvBYPdaDJS9Dcx4XDsAxbU3Tv+qIhpd2C06PN8XrkWTZx+WrWH5b4r9rVYMP76f4SJenGqqCpd+TxNLGP1ITBxsfdaNNKa9aQX9mEfh0PWbbfUgPCPHk6qPjRgvH+z2d/JCff6c2LYlJPKpAS66xYXzX4RjXp1bm/xWsGBwSwo5wUbzW1leyITA7YKmjuATJOzqf/3ANQoZA0EE7z3h6y4cWqjMzz8BKmhLrO9KGjuVZ8VqDFFM4B9FVfNTRZ3GMp6FQCotNHW7geCOjs7c7BuGN+74pn8tD52xhI2368zT/VZVWq4GM0Y2O2fja8DLOSsC47+FtDKksN9XpuOe2hGw0oBRzLqp/hPn7iXCcOGZt0ME5UDUo+vPAWhyMSGarwbMEWGgaU4bTfRKYHKNUymhmmEffn64QQDCa0lGhXjrKEsxuC5qvHwOHQGWrKDnWN2giyRqE1OtDPsEvBzz+CIlpRJOxzjDi1gOvUTy9+7gfsiT712p2kjB4IFNbvCh5naB/FrkxE7g
DKIM-Signature: a=rsa-sha256; bh=eb0HSvY/DbaSOJhZUvXAMSiabMoO2LIvsr7MYYN30pY=;
 c=relaxed/relaxed; d=guillain.net; h=From; s=ovhmo31693-selector1;
 t=1787820769; v=1;
 b=Zawu/kZ6zaOSvj25gmJ2jbvzntyqORHVrZr/XjRZXy75KcCN7zMMdz3QBXRwgJUJGNqLqoj4
 hciY+GZ1AsSXGAoCEevyFbid6wmoNGl+T9SmEh59lEElzLSmYlIZZqd5ajKLILC/OifsjjPwZ14
 iqq9djVrT4UR3Hjzvaek4unRdXu5mR+jPw3ZTXgV1GZNsGjfRRclkZ526jBSmEMWQfxfj+vuo0F
 VvmFs+sH/ljU8fwJr6cAVmlsq23DRpG8H5r+4iEEk4/TbLnVHzTfuIBMDCZOvLpp75N0Tgll1xW
 z4s8AiXEMSBr/c/iAS8TMLNJNvjGNsjLCk79hIn4yzTww==

Hello,

Since yesterday, my daily compilation of Linus tree fails with this
error:

  CC [M]  arch/x86/kvm/vmx/vmx.o
In file included from <command-line>:
arch/x86/kvm/vmx/vmx.c: In function =E2=80=98vmx_init=E2=80=99:
././include/linux/compiler_types.h:702:45: error: call to
=E2=80=98__compiletime_assert_1411=E2=80=99 declared with attribute error: =
BUILD_BUG_ON
failed: get_order(sizeof(struct kvm_vmx) - SIZE_OF_MEMSLOTS_HASHTABLE)
&& !IS_ENABLED(CONFIG_DEBUG_KERNEL) && !IS_ENABLED(CONFIG_KASAN)
  702 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:683:25: note: in definition of macro
=E2=80=98__compiletime_assert=E2=80=99
  683 |                         prefix ## suffix();                  =20
\
      |                         ^~~~~~
././include/linux/compiler_types.h:702:9: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  702 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:40:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
   40 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond),
msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:51:9: note: in expansion of macro
=E2=80=98BUILD_BUG_ON_MSG=E2=80=99
   51 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: "
#condition)
      |         ^~~~~~~~~~~~~~~~
arch/x86/kvm/vmx/../x86.h:38:9: note: in expansion of macro
=E2=80=98BUILD_BUG_ON=E2=80=99
   38 |         BUILD_BUG_ON(get_order(sizeof(struct x) -
SIZE_OF_MEMSLOTS_HASHTABLE) &&        \
      |         ^~~~~~~~~~~~
arch/x86/kvm/vmx/vmx.c:8874:9: note: in expansion of macro
=E2=80=98KVM_SANITY_CHECK_VM_STRUCT_SIZE=E2=80=99
 8874 |         KVM_SANITY_CHECK_VM_STRUCT_SIZE(kvm_vmx);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[7]: *** [scripts/Makefile.build:290: arch/x86/kvm/vmx/vmx.o] Error
1

gcc version 12.2.0 (Debian 12.2.0-14+deb12u1)

My build machine is not very powerfull, so I didn't try a bisect for
the moment in case the issue is obvious...
Tell me if I could help.

Cheers !
Jean-Christophe Guillain
