Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E287625B0BD
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791317406; cv=none; b=g8YkaD6wn0vmQuiROZFMCuHEJycEzPS0qs5FsGkpFThwQuti5iK1IQgg2evr7V3aIiIqTmOfedl+7lVXDdlLa81cv90Yt5KoiZA7RzWPy+oslt0UtySgjGPNTSKbQ/DJ4ogHlWRkIfyrM6BBizfBwzvPWzjwg/4FY0aEaOM3SpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791317406; c=relaxed/simple;
	bh=24N0HjdQRbnRFb6gWB57MrVNz0s6bunkbsaTBGnBmIw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZtcGayjhsE42boppRPyDWTUTMpYuOpQdhGdVo0r3WgQuwL0h5KoTs0yWsTqr0WU21/gXnbwxJaGNEYzpuAcfHFE8Fg8boa4qh89ksZiUkQCaSCzA96Qs8N96DOwMdybPhH0e0WxMUxP9LhUbFB1uXIxLeaGY54+gx2S0juOHNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4fb73e868aaso1266752b6e.0
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 13:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791317404; x=1791922204;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2rNUwwQpmDtmJz1qAdQLSEQ4GBC91Yoxo3ntgug7ap8=;
        b=1/GRDFN0RxPbyaApJXHJ08Heb/tDkaMTipgsY29Ypcsh15/s2gPPk6EZ+hs0I8NeyY
         b4jLjZl2dfn42pmkq9nikkG98eREFExm0Dl/6JTAvnO1PDydIN59ALuEarJpiG6a0Ioa
         AnXD/01/ClDIS4HDljtmuRyl1VtfgOpTIBBBatKgLqoHUNUs4/4ISqTpNbaQPHik9du0
         2J9pGHT0TDgyIPAet0yZy69wbcRvgJQ19yrbhcX04i1ncUXcbvP68QlL2ONwmEd4aJR1
         k0IFhkg4BgtPC6Dpq1WWbcj4C0ZklHdYu4S9Dsqtid2SL3BgaU3Y9j03KF1xvq0iCAL8
         oQKA==
X-Gm-Message-State: AFuF++nAaGktg7yWbDo92RVW0MbA5x24PK/N1y2DakLBHNCSp35wsfbd
	Al5flBz6rEWWa/fixBlVMgehS9nw11pJ8Zowgstue5F/VYQCqku/4TLvD6kMSJVZ6OLcjlaqdQj
	ApA3W7IFdxq3iX1AuEza2HpbZNjnCSRBbGyPqjRgARj9zTWTNF+G4FlLGM8k=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2e43:b0:4e6:6079:c33d with SMTP id
 5614622812f47-4fc45d5e78dmr292803b6e.10.1791317403890; Tue, 06 Oct 2026
 13:10:03 -0700 (PDT)
Date: Tue, 06 Oct 2026 13:10:03 -0700
In-Reply-To: <asT5m8OClUbYT8ZX@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac5559b.9ad129c8.3ce5b3.000a.GAE@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in kvm_vcpu_pre_fault_memory
From: syzbot <syzbot+db7bd0f41c2a7e82d4ba@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+db7bd0f41c2a7e82d4ba@syzkaller.appspotmail.com
Tested-by: syzbot+db7bd0f41c2a7e82d4ba@syzkaller.appspotmail.com

Tested on:

commit:         69f80fef Merge tag 'ata-7.3-rc7' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13eca715580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e5acac5c98285f
dashboard link: https://syzkaller.appspot.com/bug?extid=db7bd0f41c2a7e82d4ba
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12169ff5580000

Note: testing is done by a robot and is best-effort only.
