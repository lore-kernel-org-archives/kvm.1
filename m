Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4FC2EBBA1
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966396; cv=pass; b=p6kirJmtpIO4zHrPopcqp02wSxXoI3YPEnx0cnZLY8p2XUTVbbYlLjwZUNx68VWHNYluCYkHAwmQq+94p/hUVIj19zbhA56+R7pBSbrrNrSxhJe2OaAFlV3JYboF+SAdOs2Z+GeAC0BpI7ffl0+fYhR4iqabXaBD5gBsuPTUU1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966396; c=relaxed/simple;
	bh=4F9oyUj8BckTc2ElH/y4DhuW77gpVC4jgKYE3XcJY1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sz8J9Yral/xB/LyqU5HaedpJ+h2g9WEVGhzzzHiKSR9vZds4+nMZ2ucNIKYPHs2UqAIFyNqNv7y/jv+bKqpdlWOaMGTK3exvAnGF+R8RcBxch85WVOGC1jMV5p5xlmsL6LkiDclsGrS5npKjiK0vHlUTTulypXbYCBidjwM3RvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=NgmW4nU9; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=p5rczCnY; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="NgmW4nU9";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="p5rczCnY"
ARC-Seal: i=1; a=rsa-sha256; t=1776966372; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aUa3w9LXObSiDXJr2Jhk89XH7g/n4JdTySogpGIYuFcnuxlhi6zcscl3T+2zI7P+g8
    Gjlzy/54Csbdx2U1YgO3Wd9JagWqnLYViuHri3tGEjtqiq0KxjapB8P1OuqGctHHMyEg
    jnXWSTy3bd2ms+16i3ighApbuIKYC+UEWYYZyvGEpjjDU+P3oUQf+IFSRE6/aoVbg0Ro
    +86OntlsebXCE2YD/LbE6Gl7+XVTSpYJXjfQ5vEGm6wysQeER4m8kMTQF3RlIvUoSd5O
    HDV+OZYiGcJ0/0C5gYHz/EihzByI1EAdQLGDl8DSfdX9T/9EuzisgCcjR9ipmA8Z/6h6
    aZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1776966372;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4F9oyUj8BckTc2ElH/y4DhuW77gpVC4jgKYE3XcJY1E=;
    b=L0ctOigX7CzXjlM6Vy2P6jm6z3Hwor1fsPWIT3966k1lqgWj+ylKfcqk6XWob03/yC
    DKu0851zw5S3/zODFrl/M1bDwXSVLOc40kZzgWGTyQgnmKyk5WqlwbIHjtb97M2vJTlv
    O7RIbHr3XZensv2h0ge388/+0whGI5Q5ZEiExmEieFDBoBSTzPEJZ1DmLtc6dq7tv4KQ
    CwVnobi96QZnVAYqTIbARc3ElK5LR6xZwNECYLiyv9b/42njdxs4pCHHABnqr9aTw2QS
    eLhYPoFfDqxzR6jYj276MgZVO8IOk5UbGyYl73usnVuzhA1rzLJBBh+Sh9pp6o4sjvmc
    s2tA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1776966372;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4F9oyUj8BckTc2ElH/y4DhuW77gpVC4jgKYE3XcJY1E=;
    b=NgmW4nU9VRS/xMu37ekuhwTF6RhwiJDEfUERgz4QvHTV3gjC38ZWv+PutW/u+h9eKK
    H3rMXb5E2P41yO13ojT8TVmHi7wphDT9BNKccL/MZlAOnX8eBvyQ9PjU6S161NEDo/Q/
    nSfqH+sckf4tbHTVdBlxnkMf0OKBISvzIdGHfY98dISMIPygYGLPB4rYzGzi0YPUHhO5
    mPCM18M1WDPFQ8Hpd4WJbnfr4I6MixpftguEAjO0wopd5eaVHuD+ZHoviEEXVOI7QKX5
    xxHljg5Ufs03WvP4v5btvdP0iplOgzFgFlIMZqltUSqmMZVuNFZ3gzadRGdWrXdSPQAv
    yH+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1776966372;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4F9oyUj8BckTc2ElH/y4DhuW77gpVC4jgKYE3XcJY1E=;
    b=p5rczCnY9raPhC7ydBZGEe4Hoe0JZ5UWcDN8awJrXaER1Z+5FqmY1p5K6c0kgd2XPd
    cNGh6Z6KUs7WVmCKiYDA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIC+l5B/g"
Received: from [192.168.178.48]
    by smtp.strato.de (RZmta 55.0.1 DYNA|AUTH)
    with ESMTPSA id e7876023NHkBugR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 23 Apr 2026 19:46:11 +0200 (CEST)
Message-ID: <5da12382-5424-4bd9-981f-359e4dc1fa67@xenosoft.de>
Date: Thu, 23 Apr 2026 19:46:11 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM-PR no longer works when compiled with new GCC compilers
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm@vger.kernel.org,
 "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Cc: "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
 mad skateman <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
References: <cfd779d6-9440-46b2-9ed5-752f1ae6b5d1@xenosoft.de>
 <588ada6c-bcc4-e93b-1beb-4f7f859e3d5c@xenosoft.de>
 <eee732904c2a7ccce9b496b05f988a36d8a9883e.camel@physik.fu-berlin.de>
Content-Language: de-DE
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <eee732904c2a7ccce9b496b05f988a36d8a9883e.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23 April 2026 at 07:35 pm, John Paul Adrian Glaubitz wrote:
> Hi Christian,
>
> On Thu, 2026-04-23 at 18:50 +0200, Christian Zigotzky wrote:
>> On 02/10/25 08:37, Christian Zigotzky wrote:
>>> Hello,
>>>
>>> KVM-PR (-enable-kvm) doesn't work anymore on our PA Semi Nemo boards
>>> [1] if we compiled it with new GCC compilers.
>>> The VM can't boot. There aren't any messages on the serial console of
>>> QEMU.
>>>
>>> It boots without KVM-PR.
>>>
>>> Kernel config with new GCC compiler [2]:
>>>
>>> - CONFIG_CC_VERSION_TEXT="powerpc64-suse-linux-gcc (SUSE Linux) 11.5.0"
>>> - CONFIG_TARGET_CPU="power4"
>>> - CONFIG_TUNE_CPU="-mtune=power10"
>>>
>>> It works if I compile it with an old GCC compiler [3]:
>>>
>>> - CONFIG_CC_VERSION_TEXT="powerpc-linux-gnu-gcc (Ubuntu
>>> 9.4.0-1ubuntu1~20.04.1) 9.4.0"
>>> - CONFIG_TARGET_CPU="power4"
>>> - CONFIG_TUNE_CPU="-mtune=power9"
>>>
>>> Mtune changes to power9 automatically if I compiled it with an old GCC
>>> compiler. If I compile it with a new GCC compiler again it changes
>>> automatically to mtune=power10.
>>>
>>> Is mtune the reason of the KVM-PR issue? I think the issue is the new
>>> GCC. [4]
>>>
>>> Could you please check whether KVM-PR is compatible with new versions
>>> of GCC compilers?
>>>
>>> Thanks in advance,
>>>
>>> Christian
>>>
>>>
>>>
>>> [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
>>>
>>> [2]
>>> https://github.com/chzigotzky/kernels/blob/45186997e6f347fd092f9ab629d62d6041426227/configs/x1000_defconfig
>>>
>>> [3]
>>> https://github.com/chzigotzky/kernels/blob/bc7a3e27b3fcdee52a8135435f02cf807a43872a/configs/x1000_defconfig
>>>
>>> [4] KVM-PR no longer works on an X1000 if the kernel has been compiled
>>> with a new GCC:
>>> https://forum.hyperion-entertainment.com/viewtopic.php?p=57146#p57146
>>>
>> Error messages (kvm-pr compiled with powerpc64-linux-gnu-gcc 14.1.1
>> 20240507 Red Hat Cross 14.1.1-1, GNU ld version 2.41-2.el10_0):
>>
>> [  800.274759] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
>> [  800.274767] kvmppc_exit_pr_progint: emulation at 100 failed (00000000)
> I don't think "mtune=power9" or "mtune=power10" will work. Did you try "mtune=power4"?
>
> Adrian
>
I haven't tried it yet, but I'm going to give it a try.

Christian
