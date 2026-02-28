Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312201E8320
	for <kvm@vger.kernel.org>; Sat, 28 Feb 2026 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772294225; cv=none; b=jfHdsA7evJeAE6k4SE2rGWyAoMZAurYsggDRSzi7HPljfGQmh9t/iT/t9QeqWpgDAB+R9H+ER7IB9K+9uE5nD9bYjiholrCJ97Bjx+gqGiTeGMioCr0f6I7zMHmkibJ4mhwFTEnQhlk9ckDdyA0JRcpdEe5uJsy4afaxs9akx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772294225; c=relaxed/simple;
	bh=VU9ClshQ4AjoYILXK+ofmUahe+cXnPSNQCKVmqUzIw4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TSnJyaFbmgvSbRMke7UxetRKMXoB7ol/aFz4F3BoG2xfZWxrh9Cwum1qYuYX1/Z0TjJURj59Ao9t1EZyNVDG6qHNGT2sZhySv214wBNTiy+aTe1q12c6CG6J2EsDTTNamfsWn55IMn/yw3h66pySZyXHIeVco4BprbOXkMO9Oww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679c6ef1538so69250977eaf.3
        for <kvm@vger.kernel.org>; Sat, 28 Feb 2026 07:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772294222; x=1772899022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=smD2HaiHLIOJ/xJDEhd0WTnFcnRAIKeje4UXvrICVpU=;
        b=ny74kSQgwptxjDdG7XstrFmN9Vea8j8qTagXW9Qu9iRLOZBdccb5RZ0yP9BUedSHby
         Azusmb1nbFRAiRdl6DSnF5E3/aDG12s88ybk4v+Q7XEf0epaRnqmQBN7Bktk+5q6gkUL
         Ze5bVAJz4EUf5QyqBTj2TWG39BOXH2C56BA/mADgAA0gOsrM3owsDTvFk3wsQiItCYBf
         sFMYxcIqm8JTiJNmR0CQ+Q73wJA9Wa/VFq+yYo1rTthUsvHZZM2kDTXUv/Vqi9N+vq+b
         52s//B5Ws0VIFZXJdq6lKvy5+X2mMLHL3TIFvaQ2Z8njoChzbpmCgV0YornLtvIhfpbz
         Eqxw==
X-Forwarded-Encrypted: i=1; AJvYcCXv9TWHRbWWlUNbzc9rrc0Mm1+Fk8XeFpk90Hd8rS0zAhVZHvZZy9L2wsuBhdte4ODB1JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUA5wVGLJjFBqsgWqXWP7mPtxecT4trwxJFO4TTh88xBOvTzt
	K6zVyBCKwGlg4BzI6P2wacgZx8L+L4naf5lfbYiWNp4upwpoGtVg05EdUJ0fTgM5O/isjN9Et/+
	lIWCI0aSRor83uLwIw1a1MD4gPVqytx9XEgE7G0U7iSfU+i2Iz/QDQbeoNvc=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:228a:b0:66e:7aaa:be76 with SMTP id
 006d021491bc7-679faf0f951mr3959548eaf.43.1772294222196; Sat, 28 Feb 2026
 07:57:02 -0800 (PST)
Date: Sat, 28 Feb 2026 07:57:02 -0800
In-Reply-To: <874in0ex49.wl-maz@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a3104e.050a0220.3a55be.0041.GAE@google.com>
Subject: Re: [syzbot] [kvmarm?] [kvm?] BUG: unable to handle kernel paging
 request in kvm_vgic_destroy
From: syzbot <syzbot+f6a46b038fc243ac0175@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, maz@kernel.org, oupton@kernel.org, 
	suzuki.poulose@arm.com, syzkaller-bugs@googlegroups.com, 
	syzkaller@googlegroups.com, will@kernel.org, yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f6a46b038fc243ac0175@syzkaller.appspotmail.com
Tested-by: syzbot+f6a46b038fc243ac0175@syzkaller.appspotmail.com

Tested on:

commit:         949862c2 KVM: arm64: Eagerly init vgic dist/redist on ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/vgic-fixes-7.0
console output: https://syzkaller.appspot.com/x/log.txt?x=15f88952580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31d0db0315ae5d07
dashboard link: https://syzkaller.appspot.com/bug?extid=f6a46b038fc243ac0175
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
