Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A035F609
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944765; cv=none; b=G7H9oDpf3ctme/ib5Nd3cRHi3mPMOI0Qee7Ly4rAi3Za7ysETVU4GeZTuifC8YXh/hcAM6HVOcCGCSrsbeB2sohcMTGxUWGFMtGr5vBDcEXNWzWQBnqRn9RfKy8lSKk82TiNwls/WQ5tv4NUnz4sF0XwAbTSoJ2SWhHRkHrNnoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944765; c=relaxed/simple;
	bh=ZL/4J8TTn3wXba9R5vqZ/yXEDwD0Q2tEaZEhsVWwzt0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WnoOZ+cChj6HYBKUFRF0EmA9eg/NUvvKOL5mBeS9j+Sdh/hfeuzRyxsDjq9unCnPx6tblNCu7BOz+Uzsp/czHwnbRoxlaKrV30QgYkYmiq5wjS8xJ8zFyApjcVDQC60VwzLYArgDe1k1vkJpYaN4reB8JF4L8NmFXEUH1GfSSv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7ead32f5c6aso750612a34.1
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 08:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785944761; x=1786549561;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BeLwYL5ydMClGOYDYV09QEDBbdMa0yN74n5ogutYg5k=;
        b=RDn5HabA5yp/I5gA8z5Xn0/AGbyK8EchboGcEfLF0o+YKGm8fTNh1KGEsxQn14zi14
         d1ukcH3QaSW+jzCIUWVFQgAntsjtATCH280DNtji37+5LTaaqPhfOJqr8rcYh4qrTlbN
         8lPnRFgE4YqF75unKY9aULUCKv3FwjSN36V4zkT1v7KHI8NY3IQfrXw32nVw1277ASmC
         tjykrxk+0rpe4AhuVjx2Jdf5XE6nW1+MCzSK5uyl/H/SnrLNWgOWed7fT+xi/JqfC7qD
         T7CMuzFk///Y86+EZUELlaeYRL2QnH4ohgwjvre0IrbSin4dYJEHRDvtsH4uq+ht2bBm
         we3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp0t29HMs9Zu9di+clxPeNiMN56xeMXXDWYCXqfKDPWGcrvjJIveOdU8swH9/Ros2esqFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyimRxC1dpxTqmf9yMbdVqpm1AVP93Me9ThAGwEpVSp9odEn6aZ
	p5b88UGt5a/LnwLPpX9HaGIkhGEUfL/aaE0shSUKA8FYw8CXtQo6d70S8aDE1aUeV+NjNaxBOUC
	uQ4KSUoLaiwHRqsknkDDeSw547QN1A8QbeEkBgu4HGlwbQtkqWUG/7ThwxYc=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d0a:b0:6ae:4475:bc48 with SMTP id
 006d021491bc7-6ae96ecd66amr3716387eaf.22.1785944761784; Wed, 05 Aug 2026
 08:46:01 -0700 (PDT)
Date: Wed, 05 Aug 2026 08:46:01 -0700
In-Reply-To: <05be9bb6c5609ca9fc503c25596c9c9e411591d6.camel@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a735ab9.41e285c5.91630.006b.GAE@google.com>
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

commit:         bd2b92fd [NOT-FOR-UPSTREAM] repro: pfncache HVA-invali..
git tree:       git://git.infradead.org/users/dwmw2/linux.git pfncache-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=10362bb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=0948c82180d475ad24e2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
