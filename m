Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B09399364
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948905; cv=none; b=q3Y+AOFh9VSL7HwcWO8KQz0A+RPbQGI0AZgUpDSYXxeDJ4AJgAN0F90ymVo4ZtbCXQyCiI8mpJuN1J73ZN773X10kWueZP5JhQV7ZZYAE8Zj1cTwJu15uLf5cJkrWm8zCAFNmvwgZmOvBbD7bbWqM/VfYIFJhVd9riR7IFK+cGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948905; c=relaxed/simple;
	bh=B44bV+HvNgz6vB9ZQr9ZCQ6zTs/lKADvcyiz2NMnIVw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mmtJK91tt33LsXYgABmrVhbNAMGme0SfD0gKsVS7JaCJvSQUVQm8ofKc/tanOt4Q+IRNn/N8jpUa+5MFxFZC+5ETX0J+N4uRX/XoeQjxyjVU83PQk70Q4v0qF8gR7SG5J8CcUV/yuBpN7rwYGg2oY4H9Z4FHtk1+qU1Jek+tbwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6ab4aec4a14so821843eaf.2
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 09:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785948903; x=1786553703;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y61IaF9Dfcz9/Q7k3HexQBdIGHRYMPT3uPOSCJoKxm4=;
        b=hKdnM8JthhHD5UF3DOl5hsth4Yr5nD1j7A9W9+6qDXqGqWzhu9Iy6zpKb9kXTDXfgx
         SzW9YPz1H7gGyGCpdWrIISg1rZJX74zInyDPepOjp8bC8pVQ0EBAGR1pDCbCqWM3M775
         iHYhFDCcU3LbHqvXoikEzDXOf0obQ2T6gAYhxrRIFsfmWTazyVwRq0hRb/R4lYQfZj44
         B8ISCZyYhCVLK1kFthBlq7GE16K2ppR+YxgnxNjvChBnmg29GKXX2W29q6Rc57N2mU+9
         i9j+8nQtTu7tvUYmgnzjuYrw6Lk3sJdOawtaQdkJ/V6jyWBroaS8TgRphWrFj2OKtgqg
         G6Iw==
X-Forwarded-Encrypted: i=1; AHgh+Rpntf4XKfWBP1ldFtznrZj4C7Sqku6p2WgagcJlST19Uwkw9qqHIDZ2oxYFxPFK9dY53ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxjyvQQ4qtCIbtdnYojI4mzK0wqYdR7zcu+8rkn1wtdkwwvHD
	LpsQhG2R71Ws7HoHr1+8c3CrRdIVe57LyO3Pof65XsxDVW6ilPUdWFhf+s6p6Ok3BD8BIubFSp/
	0Cmhx3vD/L7L+eDnKU9kdWmTTyPwNWGKVsefDlQ0NhbysoqOdLlMpqE8QoYY=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b8b:b0:6ac:b07c:b34b with SMTP id
 006d021491bc7-6ae96c126femr4277608eaf.4.1785948902930; Wed, 05 Aug 2026
 09:55:02 -0700 (PDT)
Date: Wed, 05 Aug 2026 09:55:02 -0700
In-Reply-To: <faea706ef539a1a2d8620d97c59fd403155987e9.camel@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a736ae6.5aa550b3.77424.00c7.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [kvm-x86?] KASAN: use-after-free Read in kvm_xen_shared_info_init
From: syzbot <syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com>
To: aha310510@gmail.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	dwmw2@infradead.org, halves@igalia.com, hpa@zytor.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, paul@xen.org, 
	pbonzini@redhat.com, pdurrant@amazon.com, seanjc@google.com, 
	souradiptodas6@gmail.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com
Tested-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com

Tested on:

commit:         b020b491 KVM: x86: Use gfn_to_pfn_cache for steal time..
git tree:       git://git.infradead.org/users/dwmw2/linux.git pfncache-rcu
console output: https://syzkaller.appspot.com/x/log.txt?x=14be3bb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=0948c82180d475ad24e2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
