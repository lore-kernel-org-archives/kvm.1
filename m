Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661AF37C10C
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404223; cv=none; b=t+5yg170pw3Sqz0Ssd0FLG6nfypJ48XLx4EsT8YMV7DSt30oiPvSRT+RwRzG8ekbVD7NsW/6mWSkfyOHTa9AuEhFmZZfVAKF0Bp556GVvpQ57/OpfqYoRrZScAWhGbnxC9niTruwmXnanzH5S2fkCqrBq0xZrgfJhHpkndRxYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404223; c=relaxed/simple;
	bh=wIPTKxfyVL0jy6wv8E8+2qbGpd3o9MDx75MoSQN8IEw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KZuD7dLmzhjHW1j20LNneyyN++tlp2U2OvhWE2zWFDIZ48vHCaMjmADBxc5YKzgkY+cMAKb+5GMcXQeJJBNqQ2LEWxQZgWMAvA07E4h862sA1CmYr+XtvqNdNExlF7d/G64zch0gfswisFXMgCVlRhEUxyGU/1SkT9/hooAef3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6a131aeb9abso1654714eaf.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 09:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782404221; x=1783009021;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWfk9OFEmR+fn37O88WSkEBetpiuYDmQvXdLihQkk/U=;
        b=BAVpo9NRfN4P6GOAajCv3CS7FyHFdg0bYxAaEAooZQC6LoJrLhZdZy8yHmcCs4qZfr
         XSQptlCJUAgBTI/FB/JsPc1PWpPmFvyDeoHt8Rq4Z/8QXqac5NWMNf5rt23xFqpF7vvB
         jKt732oobggwDgKspiOQ7XwmAYIKVv374IJVNu3hzM7Q4Jc8S8koDfuU/dwpXCyGDxwi
         5LTViM/wSUjvfxd5FZZ0pcvjzGc9wTU2MUby+5/GfE212m4yOxtpJ43RSxWdEkEvT9g3
         beMRM5oVuodbiDFLnlhlsqxPs4mJLphJVEED7xbC/vdzv6fTRUy7YRGkBD5HYr8X0MVa
         w0VA==
X-Forwarded-Encrypted: i=1; AFNElJ/unn5tNpjQSpxbN3ijVwE8UikOudVMoCSqtuxo0S+Jy5yOVeiquyIlrrqSFgpv8TkJ8HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHF2lvj/Y3iAt+2l8z5Aql1yxzvtvDjLox6DtnUGH4yvTuNEo9
	lL9+Y8CCclx0BVTc/r2WH8mtxuGFPvZ5QfafUNGU5HdycqQ/K641XSE7QKOcCERKlev5zbN/YJ3
	moLtRSxpxt924Q5teADph8J06YYyLMz5nG3Oco/Vhz8s2Q09Kk3+IxlUKWEM=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:80c2:b0:6a1:189a:daf1 with SMTP id
 006d021491bc7-6a13515dbcemr2705790eaf.4.1782404221459; Thu, 25 Jun 2026
 09:17:01 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:17:01 -0700
In-Reply-To: <aj1H_JvSc5rxLSs4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3d547d.80e5668d.5d0ef.0005.GAE@google.com>
Subject: Re: [syzbot] [kvm-x86?] WARNING in vcpu_run (2)
From: syzbot <syzbot+dd769db18693736eee89@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         ab9de95c Merge tag 'rust-7.2-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148b430e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86ba763b42fa66a
dashboard link: https://syzkaller.appspot.com/bug?extid=dd769db18693736eee89
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10627ce6580000

