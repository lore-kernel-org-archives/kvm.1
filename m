Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E653E022D
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042107; cv=pass; b=ptX2iOnxLYeILS//HCeiIEGBg6irJnR9zllnuXfdFXSgYzr+cBFDO0NptCWr8Y+DXwwRQjhkotMhGzTduDAvVqA+THfuAmC8FB9gI7Tnp/3R5lin+18rbEY28DH8jAolLdqkKFYkRp+jCKIyscEkXByedWhUTDBUkZA9Cdk0+B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042107; c=relaxed/simple;
	bh=MFLezGQkjpyNvidVcNWJBCkv+ZJGnFlRSwwDl3G0bLU=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Qo1WBnVe5JC2quAkB7WWrTriGmAevOR48ItuTL0mOO4z5+/uynsowUkMNBs+s2tWiUSbbnkw9iEOc8OyuGM/kEFfgqtARNSu1nXAkSEiig4Dtceju9Yts+nn7EgBDpOAWKnGQwNB7juIG68cc/tld8bwQYliQHnFeemT7eHlFXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=ZQCimJAo; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=tpy4+zWG; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="ZQCimJAo";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="tpy4+zWG"
ARC-Seal: i=1; a=rsa-sha256; t=1777042079; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sY3+JyxOHH35fbBxp2GDkpTGsBGnsW1n3ENA5u3iiSmya0N7jp4SAJl40c46nImZ5O
    u/rUC5/ID75tsbPl1y1SgVN8HZB1U/Yc1FYfsGACcz7Z2J1WIE+KOk8sq5pJ3YDw8S9n
    xuufLMf2VKueGKsIj+4g+1+Y2+CSVcASj+lJgz2tTDVgcBNEM5sHiLmWO2T7tmNRo6SY
    mMZDk+lxcZk3wEcjWh85D78cYrMuVSIm18PscKQ+7L+F7y+5/PWiXIZtooOYH5CS33Fp
    ruBjySSGhJJS1wNzde/sojAShth1EAL+3DEkwJbLqQHBuOLPl+Qg2UJCDvz4aktCPtdE
    PxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777042079;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=AxqLW8EPOEFlnjj49t6Ck8WlSYjtqj1YnihzRrcoLe4=;
    b=h94z/3dJGm0VuDZc+rJZtJQlA2IYBz0wVuIjw7gBPIhdY4aXEbwtREg3YBzKnx7W4I
    QoYSgXGyMFrn19toXHGgiSFshBiXavFDF8ZXwkCxXGb/ESaTWi1VR8qDJ4l8KhS9ExAd
    RatXXOyqQMTA+dJ5VkxXjU3sTj91Ebl1I91XJSueD1IresF5KW7vEuQHd6P5wxBW7iXL
    dvGKEqV6T3TRGqkcOzd2SK+C02XE0qkz8jmpqrV+TrAP7r3ZqBQSz4ZMy35F5P177A1H
    Kx+kfNEzF9+x4N0CShYuVGmIOuO7k2NBqBm4WmSlWv5umo0bv0pJ+ZNBBrKXKSc/7Chl
    VGYA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777042079;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=AxqLW8EPOEFlnjj49t6Ck8WlSYjtqj1YnihzRrcoLe4=;
    b=ZQCimJAoxEebAKTmorkVldtEq8aby6XBh8g3Z/6oYcn4QnUT0wafCcIKfEMO3MRBdi
    p/PjWCVwElv2vN1n/T00gmQZuuUMrjwLmA/LKghl9MhzJL3qvclCMgNfX2HkpCwuVvWT
    0yhnDayggijzkMthn0m0zcN5Z1xJeppw1V96e/CFAfTVkgSph0aYh9idbw2pcACS/vnA
    K8Yd1xJ610S4j8WWEzIPG8vh3QMFFeE8xBi5yLRbvxkmGvq8g1j3hJNV6MLUwRLWYBku
    vTZYWdEn9HBnyfUeK02l9GyMTruKF38j8wAbGpLL5bS3SvacUw3xc7dScPqa836xD5eN
    prVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777042079;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=AxqLW8EPOEFlnjj49t6Ck8WlSYjtqj1YnihzRrcoLe4=;
    b=tpy4+zWGZNmPwLvXtsCIVEH4OP0LcOcIecU3E65WmvxHZxHCPtfXprceHIGElMgCfd
    DqzOK1r1eKRYxDynLeDQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+l7x/g"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.0.1 DYNA|AUTH)
    with ESMTPSA id e7876023OElwxiU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Apr 2026 16:47:58 +0200 (CEST)
Subject: Re: KVM-PR no longer works when compiled with new GCC compilers
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm@vger.kernel.org,
 "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Cc: "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
 mad skateman <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
References: <cfd779d6-9440-46b2-9ed5-752f1ae6b5d1@xenosoft.de>
 <588ada6c-bcc4-e93b-1beb-4f7f859e3d5c@xenosoft.de>
 <eee732904c2a7ccce9b496b05f988a36d8a9883e.camel@physik.fu-berlin.de>
 <5da12382-5424-4bd9-981f-359e4dc1fa67@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <a584b7a1-fc25-a475-099a-634159b6ffe8@xenosoft.de>
Date: Fri, 24 Apr 2026 16:47:58 +0200
X-Mailer: BrassMonkey/34.1.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5da12382-5424-4bd9-981f-359e4dc1fa67@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/04/26 19:46, Christian Zigotzky wrote:
> On 23 April 2026 at 07:35 pm, John Paul Adrian Glaubitz wrote:
>> Hi Christian,
>>
>> On Thu, 2026-04-23 at 18:50 +0200, Christian Zigotzky wrote:
>>> On 02/10/25 08:37, Christian Zigotzky wrote:
>>>> Hello,
>>>>
>>>> KVM-PR (-enable-kvm) doesn't work anymore on our PA Semi Nemo boards
>>>> [1] if we compiled it with new GCC compilers.
>>>> The VM can't boot. There aren't any messages on the serial console of
>>>> QEMU.
>>>>
>>>> It boots without KVM-PR.
>>>>
>>>> Kernel config with new GCC compiler [2]:
>>>>
>>>> - CONFIG_CC_VERSION_TEXT="powerpc64-suse-linux-gcc (SUSE Linux) 
>>>> 11.5.0"
>>>> - CONFIG_TARGET_CPU="power4"
>>>> - CONFIG_TUNE_CPU="-mtune=power10"
>>>>
>>>> It works if I compile it with an old GCC compiler [3]:
>>>>
>>>> - CONFIG_CC_VERSION_TEXT="powerpc-linux-gnu-gcc (Ubuntu
>>>> 9.4.0-1ubuntu1~20.04.1) 9.4.0"
>>>> - CONFIG_TARGET_CPU="power4"
>>>> - CONFIG_TUNE_CPU="-mtune=power9"
>>>>
>>>> Mtune changes to power9 automatically if I compiled it with an old GCC
>>>> compiler. If I compile it with a new GCC compiler again it changes
>>>> automatically to mtune=power10.
>>>>
>>>> Is mtune the reason of the KVM-PR issue? I think the issue is the new
>>>> GCC. [4]
>>>>
>>>> Could you please check whether KVM-PR is compatible with new versions
>>>> of GCC compilers?
>>>>
>>>> Thanks in advance,
>>>>
>>>> Christian
>>>>
>>>>
>>>>
>>>> [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
>>>>
>>>> [2]
>>>> https://github.com/chzigotzky/kernels/blob/45186997e6f347fd092f9ab629d62d6041426227/configs/x1000_defconfig 
>>>>
>>>>
>>>> [3]
>>>> https://github.com/chzigotzky/kernels/blob/bc7a3e27b3fcdee52a8135435f02cf807a43872a/configs/x1000_defconfig 
>>>>
>>>>
>>>> [4] KVM-PR no longer works on an X1000 if the kernel has been compiled
>>>> with a new GCC:
>>>> https://forum.hyperion-entertainment.com/viewtopic.php?p=57146#p57146
>>>>
>>> Error messages (kvm-pr compiled with powerpc64-linux-gnu-gcc 14.1.1
>>> 20240507 Red Hat Cross 14.1.1-1, GNU ld version 2.41-2.el10_0):
>>>
>>> [  800.274759] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
>>> [  800.274767] kvmppc_exit_pr_progint: emulation at 100 failed 
>>> (00000000)
>> I don't think "mtune=power9" or "mtune=power10" will work. Did you 
>> try "mtune=power4"?
>>
>> Adrian
>>
> I haven't tried it yet, but I'm going to give it a try.
>
> Christian
I compiled it with "mtune=power4" today but without any success.

Error messages:

[  800.274759] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
[  800.274767] kvmppc_exit_pr_progint: emulation at 100 failed (00000000)

Christian

-- 
Sent with BrassMonkey 34.1.0 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.1.0)

