Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06E382299;
	Thu, 17 Sep 2026 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789631486; cv=none; b=jyL/TZ8oseHZa+9lW3B6xxplVuirvRf3yEaJGi5v7MRZzwLmPIbXJg6GfbezUZSsWpOPPJqUnbHraBnBMT6l3JXoXb91Pmy6CBsCkpWRz7bN49T40anWLUhZU6YkzKIUxpa/INUloXne8XZ6hWCgGzbJLisqLGE7Qf+QvpVYoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789631486; c=relaxed/simple;
	bh=/QJLjEEFUSfP01bZFXaO00kTEnPjIfUKzqB2JUqvkJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odPhW17sz44E+i+VRLPA0K42RBURyHdqidCucIjKjtnAalsOtCc/FXAhdzf/NmSjCZB2yaHFNCFZIOHV7PCNOJ3yiCOzl3tDi3wB/biF/NtHZP5Dwt5CTaaZby/DD06henp8jcR5Q+oGthIMV2syvR/X0RMmpfrNC0Ex3BoCHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3xwywF1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3xwywF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58361F000FF;
	Thu, 17 Sep 2026 07:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789631485;
	bh=gnTwlE8vXLouBpo3zgoY8WtBR+qNusYyWfPZr7YNzr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m3xwywF1x2dNxru/88y11Jm0HWHD1B/6Wwuw8lE+KPMVIo+xdkMnfJB99wlL98z1B
	 ycrANUp/YWFNcoeDY49fP27elybl+V3a1ox+5GWpmXlGpPJeR0wWOHn7BrAMM3kKH6
	 AWtvNopbVC/e0fKHODRAI9g5LILH33nLB0Tzu6PZGx1oXeJS9x62xAF6um5MtgkJzD
	 ZAT/+yrU/4+jARQeGadxY4AYcJ4BuEwgduQO0DZNaE6WJWco4iRxYc7zBAg4tslFga
	 a+VQF+h5AK6WplXcMmz4JAaeH4ikbTY/0GgR2pDzxr+JcLElty9iyKD2+ff8+gxwus
	 w+eQBJufdlZOg==
Date: Thu, 17 Sep 2026 08:51:15 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: syzbot <syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, bigeasy@linutronix.de, dwmw2@infradead.org, 
	dwmw@amazon.co.uk, kvm@vger.kernel.org, liam.howlett@oracle.com, liam@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
	lkp@intel.com, llvm@lists.linux.dev, lorenzo.stoakes@oracle.com, 
	me@brighamcampbell.com, mhocko@suse.com, nogikh@google.com, 
	oe-kbuild-all@lists.linux.dev, pbonzini@redhat.com, rientjes@google.com, rppt@kernel.org, 
	seanjc@google.com, shaikhkamal2012@gmail.com, shakeel.butt@linux.dev, 
	skhan@linuxfoundation.org, surenb@google.com, syzkaller-bugs@googlegroups.com, 
	vbabka@kernel.org
Subject: Re: [syzbot] [kvm?] BUG: sleeping function called from invalid
 context in kvm_mmu_notifier_invalidate_range_start
Message-ID: <aqubuvR_2XCNav28@gremlin>
References: <aqrZMReaQPG0M9oV@gremlin>
 <6aaaecd6.4e05fbd6.392abc.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aaaecd6.4e05fbd6.392abc.0003.GAE@google.com>

On Wed, Sep 16, 2026 at 12:24:06PM -0700, syzbot wrote:
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> error: corrupt patch at line 7

OK let's try again, aping
https://lore.kernel.org/all/b434f7828a4d7b24de76aa5609dadda2871a932a.camel@infradead.org/
as I see this branch is still there (David W - I hope this is OK! :)

#syz test git://git.infradead.org/users/dwmw2/linux.git seb-nonblock-rt-test

>
>
>
> Tested on:
>
> commit:         9b87fdc9 Merge tag 'sched_ext-for-7.3-rc3-fixes' of gi..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
> dashboard link: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
> compiler:
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a16bf9580000
>

--
Cheers, Lorenzo
