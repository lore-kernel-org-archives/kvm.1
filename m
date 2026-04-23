Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C8340273
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963057; cv=pass; b=gbhWN3J8Z9I+fVKb0g2REy7rXyMDDDdadggZPuh4wQzum0q+nGTBFgKjqF1DvDDwDEBj6YXHz90jGCPbzcGHQTKkvBqPkEA4Pgo9Nv40cfcLtttJ5YBM23x7eVi+UqtYSp0zedWx82dv4yFEdXmJ7zw7FdbWTcrgXjzjMdzs8UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963057; c=relaxed/simple;
	bh=9eF/SCquOEv+RL6v0WBSx0lmw0ntw+k++IIMQmfGXsU=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=awB0epUc2LkgYO+8j5dkOn8gKrEzD80YEtTepPZa+ueHBlKapGzdeVRrvAim1ChtdU3Jl0MhWP5UEpedMxxHvGkeoK9/hlFc+17/mIQs8/chXyjjQ1sDyXqa8jGpyQRr307y/sHb8fD9mDOu8uACvDo/fq9rdBsWk6cD7XWcjTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=a9HAa0+W; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=RSbtY0TT; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="a9HAa0+W";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="RSbtY0TT"
ARC-Seal: i=1; a=rsa-sha256; t=1776963038; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JOb3Y4qgRrupDvb8beHEpK0m8hfhZiWF4x3PMMEEf0Qh2utt4dCOKrOFtgvV0bY1Uv
    pImMeOX0Ew+Fp2fzIzvZlFkGo6WfFSIO57A8/Wgi83X0LpMTvVLBJYjb+Xg9NnJadLyR
    eRaPYHtVGenKtbdx9YarDJmsFKqKu/Ai4qy8rKo2My6bh4kuoh8legm8yStemBm2RTv8
    pz4/OkvYZIE6wAZEzCaBbrGcr3/0PXSHFqJXEnC78G0hLDtOsbc+gnjBTWPUg/+c0rtc
    NSQ9qBcQADQ/p/O/WuVDMBf6pi5CqCGk30d0aOaeP0oTgsIo5iLtqx4y1d5O+nRIp02J
    Y1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1776963038;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=doIqzlK9MrAmABBQOTomurGoCdyNJXPyXJiAdYANQjo=;
    b=Urrqm/PaR14GAUmfgSjf8G48s+sxBNbSU1tUKp94QLHN369EVI2zl7J3LH8CgK5JjP
    TB8imSZTr7gJQ+cIAYSRSJqmE9gcGOnaREwSFXClbab/HCD1UJ1wn+1fej1lpVpRrJwv
    0e61v111smD9HlI7HPcwlseSQEIhZwbmgEeC64L/cx+2K2uAOP0Xu7SzBAxImBy37zJp
    uitft8PieRE5gHLqpUZc/bGfQzk9JwOAt88xrkNMllGRnknUyoOhT67mkMQ9i4wS+Ujn
    Hd+/siGuxqGwLrhZ7rAX+iCzU1Cz1MEPi345irNIeGB/Z3FxNK8AaAOY/2tPbw69GOjz
    HZEw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1776963038;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=doIqzlK9MrAmABBQOTomurGoCdyNJXPyXJiAdYANQjo=;
    b=a9HAa0+Wcj7tqtYx/0bCyojw/Lc4HGmELzrwOXxWNtsMwSnNKQadqLPfzRytm4D4Pn
    R8VYj4QcypygIG/2s2KXkpILbMhProUV7jdtfpu1spVhdaNf0t7b0+gpmEYtb9k1P8yq
    8NiF3mO97svl+YgPPY9ci80cb4nU3i+YpSVqlurg88/LUGz6p4g7F+LTexAi7nwwXCrq
    N45S4T9Ujlt5mbVJj7XD/v+7kTHqu9zNZZCb8swHyWJBgcnzBtKmPRuRwlzPLqvlDZTo
    v3k6W9RTWoPukITquKPkEac1vloYktGcAnQbfqjk8i761JQzRH7nbS/buneOgKp41abN
    RidQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1776963038;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=doIqzlK9MrAmABBQOTomurGoCdyNJXPyXJiAdYANQjo=;
    b=RSbtY0TTooAYupA587BNWSzYV33lzVqJPLOnfs3xPDbNjEYyrTkqaKjPoE2W55568b
    Rn/uRvQDgMiuI0LvF+AA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIC+l5B/g"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.0.1 DYNA|AUTH)
    with ESMTPSA id e7876023NGocuXi
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 23 Apr 2026 18:50:38 +0200 (CEST)
Subject: KVM-PR no longer works when compiled with new GCC compilers
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm@vger.kernel.org,
 "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Cc: "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
 mad skateman <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
References: <cfd779d6-9440-46b2-9ed5-752f1ae6b5d1@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <588ada6c-bcc4-e93b-1beb-4f7f859e3d5c@xenosoft.de>
Date: Thu, 23 Apr 2026 18:50:37 +0200
X-Mailer: BrassMonkey/34.1.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cfd779d6-9440-46b2-9ed5-752f1ae6b5d1@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/10/25 08:37, Christian Zigotzky wrote:
> Hello,
>
> KVM-PR (-enable-kvm) doesn't work anymore on our PA Semi Nemo boards 
> [1] if we compiled it with new GCC compilers.
> The VM can't boot. There aren't any messages on the serial console of 
> QEMU.
>
> It boots without KVM-PR.
>
> Kernel config with new GCC compiler [2]:
>
> - CONFIG_CC_VERSION_TEXT="powerpc64-suse-linux-gcc (SUSE Linux) 11.5.0"
> - CONFIG_TARGET_CPU="power4"
> - CONFIG_TUNE_CPU="-mtune=power10"
>
> It works if I compile it with an old GCC compiler [3]:
>
> - CONFIG_CC_VERSION_TEXT="powerpc-linux-gnu-gcc (Ubuntu 
> 9.4.0-1ubuntu1~20.04.1) 9.4.0"
> - CONFIG_TARGET_CPU="power4"
> - CONFIG_TUNE_CPU="-mtune=power9"
>
> Mtune changes to power9 automatically if I compiled it with an old GCC 
> compiler. If I compile it with a new GCC compiler again it changes 
> automatically to mtune=power10.
>
> Is mtune the reason of the KVM-PR issue? I think the issue is the new 
> GCC. [4]
>
> Could you please check whether KVM-PR is compatible with new versions 
> of GCC compilers?
>
> Thanks in advance,
>
> Christian
>
>
>
> [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
>
> [2] 
> https://github.com/chzigotzky/kernels/blob/45186997e6f347fd092f9ab629d62d6041426227/configs/x1000_defconfig
>
> [3] 
> https://github.com/chzigotzky/kernels/blob/bc7a3e27b3fcdee52a8135435f02cf807a43872a/configs/x1000_defconfig
>
> [4] KVM-PR no longer works on an X1000 if the kernel has been compiled 
> with a new GCC: 
> https://forum.hyperion-entertainment.com/viewtopic.php?p=57146#p57146
>
Error messages (kvm-pr compiled with powerpc64-linux-gnu-gcc 14.1.1 
20240507 Red Hat Cross 14.1.1-1, GNU ld version 2.41-2.el10_0):

[  800.274759] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
[  800.274767] kvmppc_exit_pr_progint: emulation at 100 failed (00000000)

-- 
Sent with BrassMonkey 34.1.0 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.1.0)

