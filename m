Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E0223DE7
	for <kvm@vger.kernel.org>; Sun,  9 Aug 2026 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786275244; cv=none; b=Ug/rCD/se93QzMbwaEALHRgsz6sHbMzur1si7+uGMvP5rCBRyrThcFWNz6skQe0/u9CH87D2mvaeG9CroYW4BG3nMbomeup3iQjNkVtA5d0JXv/7zIVrk2kXqgzWxXKOxwHCGAmjUmW983ucO/HaAIGxyVZw2FnD8teotTTX4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786275244; c=relaxed/simple;
	bh=4yBC4TOR3j/q0XUdeW9ve1iksgGtLh8N7a5/oa1M6Bw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lw/GQEGujaYcnVmeg8iOofKHnE95Zw9OONC8P29Ef/1BMkcI79C1u8SAZQ9tNlE3RF5I8CJujLmGqoQNkoS4DvWbyOsMHKkGJIolqyX4bIUd8ZIIKePgBWGDUIzl4zSKsEFJS2T9y9cg8oCEU0JRBM2bBr6tTsBUHPv7GdgaRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4a41f46d629so1522577b6e.3
        for <kvm@vger.kernel.org>; Sun, 09 Aug 2026 04:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786275242; x=1786880042;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OfEaqI1/cm3iEN52zSQnWGci0fCyKRb42i0NGIj1RKw=;
        b=fmjZbmKTb1OqGjFonjdJGTw3OhVSL3xDTH2huiaeLeQcNPLr0yFDO3BOpfk7GQvAcz
         whJ86GTAqujFEqDQEOeEtUS4Yy+rOTNahvXs5gZPHYIjhO/gLXeO1Umxi8I9GtBrauuL
         7/GPg05DvdGpsNyD8jGgHm1XUIbRRBNvWpb1gAS/DjB+xEmMHNeKo2jhN2UUHOgmf61s
         V0T2vFi5InCcQiaGpxQcU+6JN+JZUEpA/HcbnElzqDnPaKXjoZSfaDSOwdDHAx4Mmapi
         ERbAQkma8O1A5JlEEwjqqe0wqjxR5b2jOL7/7lDeaH63Z0JohuIFpV3+ajrqHWIjvK33
         LC1Q==
X-Forwarded-Encrypted: i=1; AHgh+RoeEvE1NLXvS42ZFT1y7WOYeg5+sg3p2G+MqzKvC8QcsTQOBYpO1Z8WfQccb86ntKpkKbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxponrD6lXhwU/T2ofQi5deemkCo4DceDtjiGSXIDmL8BsXWYDP
	zaaJLF6wDNf4+yeVFBTvRrAD5f2egJ3L/kuTnfsokWnKUkLeMxom4FK67c9HiUWhFqpcdKt+3Rs
	bbY0oG3cMCa2fgUfm7TsrVvE5Yx8dbMZ/uwUReQxZWK3NKP7wGBadlNn9r7Q=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6904:b0:4af:57e9:4ec6 with SMTP id
 5614622812f47-4b1a0fc9a20mr8642099b6e.15.1786275242293; Sun, 09 Aug 2026
 04:34:02 -0700 (PDT)
Date: Sun, 09 Aug 2026 04:34:02 -0700
In-Reply-To: <e8e1fbbe24ddad3850d77aed52a22a6e3f620cb3.camel@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7865aa.9c11d2ce.289b96.00ce.GAE@google.com>
Subject: Re: [syzbot] [kvm-x86?] [kvm?] WARNING: locking bug in kvm_xen_set_evtchn_fast
From: syzbot <syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com>
To: dwmw2@infradead.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paulmck@kernel.org, pbonzini@redhat.com, seanjc@kernel.org, 
	suryasaimadhu369@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Tested-by: syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com

Tested on:

commit:         230abd62 KVM: pfncache: Use a dedicated SRCU domain in..
git tree:       git://git.infradead.org/users/dwmw2/linux.git xen-rcu-fixed
console output: https://syzkaller.appspot.com/x/log.txt?x=110522c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9cef045500682f6b
dashboard link: https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
