Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8E74E50AE;
	Thu, 17 Sep 2026 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789631397; cv=none; b=Ex61eOaVGOcK+lxBi+wwChaFJ9APMrcoGHGy0HbjTUPwDj9jlVihwjYtLVrIU1W4K9bmctELShaMZAGiObx6F06Q7unPDhPRJftNfg6tbK7WoK2aF9Ji9K5XdvhOEUkDmHI7w5u3QEH4aNODK0Wt4ks8/JY+q5cPe+UZc64DFa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789631397; c=relaxed/simple;
	bh=Csn9svdRUIBhfL6XpLE7sgCf9d1GK+Z2GFz0pU1YrcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNTgeHbK3LvBiQAqWbELeMbR+e2HCsYOUCbr+Mi3fDivcGgSOXULz7lgvEh4ynGw15xP5YADn2o507jy68dzyrk1YpOKtlHJg+108NQloMvK9+7Mukz0GdjdfjuWKvOPupjTRrdCQLEuHdRJyLE1ZEOEgMuKIMg/Sl0S7K82FrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPrnrGDl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPrnrGDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26FA1F000FF;
	Thu, 17 Sep 2026 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789631395;
	bh=GCqSR8xT+K91LfjRnuBwTlwBBPOS+Tdfm5v39XYfcwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mPrnrGDl1B0O0DCjj5NSbukmuO+NaJ/CVMhVOTh8pz/dER+cyNq+5QbbPOYN5OoTs
	 CuHsuK9JrztoMrYyANJfzVPU6BdOM3vB1DYAvVe0RE2P3aP6MDSt7zHqQTj4h7+Vpo
	 ME/8jK0SEHE79sp2vlmJqtgVSstMCn/iT86UOBp9UKHfMnJW2oFRGnQtXz3dhcxNDf
	 5HXmthe8259/mMkoJZFj2gaHLA0T+/0LnyqaXOLkr/nFBpenGCE2/DduX+HQBuJYms
	 wtCASsQnZlyL/mth6PwCKBLbkxQM2O6yyHz0u2WEizQ4fEZ42FYu2ZHmZlhvziGKc3
	 0I9yPBG3NeBlw==
Date: Thu, 17 Sep 2026 08:49:46 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, dwmw2@infradead.org, dwmw@amazon.co.uk, kvm@vger.kernel.org, 
	liam.howlett@oracle.com, liam@infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, lkp@intel.com, 
	llvm@lists.linux.dev, lorenzo.stoakes@oracle.com, me@brighamcampbell.com, 
	mhocko@suse.com, nogikh@google.com, oe-kbuild-all@lists.linux.dev, 
	pbonzini@redhat.com, rientjes@google.com, rppt@kernel.org, seanjc@google.com, 
	shaikhkamal2012@gmail.com, shakeel.butt@linux.dev, skhan@linuxfoundation.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@kernel.org
Subject: Re: [syzbot] [kvm?] BUG: sleeping function called from invalid
 context in kvm_mmu_notifier_invalidate_range_start
Message-ID: <aqubYaxM1zQMdGN1@gremlin>
References: <6936812a.a70a0220.38f243.0090.GAE@google.com>
 <6aaaa2da.86093f18.33004f.0001.GAE@google.com>
 <aqrZMReaQPG0M9oV@gremlin>
 <20260917073931.iggMficE@linutronix.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917073931.iggMficE@linutronix.de>

On Thu, Sep 17, 2026 at 09:39:31AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-16 19:05:03 [+0100], Lorenzo Stoakes (ARM) wrote:
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
>
> > Seems like a false positive and an RT thing?
>
> yes, it does. The proposed patch has a matching reported-by of the
> report. dwmw2 did test it via his tree
> 	https://lore.kernel.org/all/6a8d9a7e.a5a502ce.31d34.0069.GAE@google.com/

Thanks! I may try that here then as my attempt at a test failed, but I think
v. v. likely this is what it is.

>
> Sebastian

--
Cheers, Lorenzo
