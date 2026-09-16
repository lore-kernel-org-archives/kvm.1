Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544C41B8C4
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586663; cv=none; b=khqXQNRwSNwZ3bJQrfIY7JJnTmojUpUPWGCUJllceJvF0WjLAZO089HiqpW7Ujr/eLqfPe2+tKhnJyLwaIUZq/4T7IoYjdrbZETSmoSQwImDBSEsnwzD8ZRcD1n1YmHN7HtvGUjg6c6Con1YG77BSrWokl1e/XjFmNSqIkVc000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586663; c=relaxed/simple;
	bh=T8e4qFcoWW/dNathKMvtjSc8MmQ0SvJgeeAGEMDyUMQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UwEV8rbHnSuJUO5jRvwUPlIC+vZzSJSO73n6P9oKHU3KLA3m2swJJ1Lr0M/CefkhWtntzrZm/Q7c3YW4sN7FaNDLxGqoKoFO41ISmTq9cbkkkfO5mcbcWMd6WxXMkGbNdqVv9vHCTjEulhsk0flBP5gRjmRZ5mA1FAD14L2BeSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4a45b3f0bdfso123642b6e.1
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 12:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586646; x=1790191446;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gGav+E6NmhUVSh9XUjVdcV/Auw85chnTv3eOmsCDzNk=;
        b=UmCTlIhNosHStHdjNY0JJy5HRV8WqiB7ZNnAcs7pJL+KJx/Y/C7+CHBftZGil/GZMx
         TDLcdiFreJUg+6utli7wdKbKg3M03O5fBhIi7voxCBuGiJW8uKCxxDFTtgqCj/7AaSkV
         fOJkQ4ekpv6B1AITCxmpDDVG1w/iSVSy7P5UEnajp5vdE2VfGpLpAy/ilzXuCSpbJ5TR
         VB1V1GkK3ELCecvkBmH+dlsFbpxmRgcjBrsn0iOHGeOk8i5pVTo40dupuNqaYWuSJfta
         9paL7m61+d2Bgdhbi/Fi1wXZi0Pj1I6Gi01a9jH+2kqS8IjvyxN65a2Dp8VPDqOIrQn4
         bsYw==
X-Forwarded-Encrypted: i=1; AKwUvBzJ4G9nD9NdsSrfvmJIkTo2qPpQLtdWN3R6w0aGuHFsM2fugspPfQNu0OH5MvPTsnuKJFE=@vger.kernel.org
X-Gm-Message-State: AFuF++lCiDK1WWjYufjvPe/dA1lFc50qYj5Ms1+9Bx1ysraFtSo2brvK
	sYlQWxWsBWE6m02MXCObVso3xgttrGf71+P7UdbhXHaBA8+GVU4kjdTwBE4czLJU4SPvZ4dmrel
	eUL5w9Laafgx22Lqig7r0bI8WJSjOs/UGdbfpnFjkzR1N9ajwGgxM6XSkLXs=
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a24:b0:4c3:7695:d30 with SMTP id
 5614622812f47-4ca4a1dc406mr4599160b6e.14.1789586646123; Wed, 16 Sep 2026
 12:24:06 -0700 (PDT)
Date: Wed, 16 Sep 2026 12:24:06 -0700
In-Reply-To: <aqrZMReaQPG0M9oV@gremlin>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aaaecd6.4e05fbd6.392abc.0003.GAE@google.com>
Subject: Re: [syzbot] [kvm?] BUG: sleeping function called from invalid
 context in kvm_mmu_notifier_invalidate_range_start
From: syzbot <syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bigeasy@linutronix.de, dwmw2@infradead.org, 
	dwmw@amazon.co.uk, kvm@vger.kernel.org, liam.howlett@oracle.com, 
	liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev, ljs@kernel.org, lkp@intel.com, 
	llvm@lists.linux.dev, lorenzo.stoakes@oracle.com, me@brighamcampbell.com, 
	mhocko@suse.com, nogikh@google.com, oe-kbuild-all@lists.linux.dev, 
	pbonzini@redhat.com, rientjes@google.com, rppt@kernel.org, seanjc@google.com, 
	shaikhkamal2012@gmail.com, shakeel.butt@linux.dev, skhan@linuxfoundation.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
error: corrupt patch at line 7



Tested on:

commit:         9b87fdc9 Merge tag 'sched_ext-for-7.3-rc3-fixes' of gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a16bf9580000

