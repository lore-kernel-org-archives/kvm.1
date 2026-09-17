Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F845FFD3;
	Thu, 17 Sep 2026 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630776; cv=none; b=AX3PfZ1f6n0ZXqG72MDxV/Iaa1x/9tnPxfJDeGNkk2Tc3WsHU72mLHWBExBwjda+HuPqg/1nB5CMhSgMp0VdoBYw4cudTX3DABZ0uYdowIDUop51dY56/XeQP4y9NYZ0zgjx5Ud+jtHVZV75DUkRGuwSCJ4yZvC9EtgB2HWKnwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630776; c=relaxed/simple;
	bh=WZv+KO4tNtUG1yij60OhMLNffrpj6RJac9KO6/2z9I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSmbgKx/puaxFz3buJesRFJLtYKMpK/DvlcYsUAIh/qATS7P+lGo7eyxhaXuma7N6UpHMKyaZRCV6WHtBx+0lD46QucELhSaZ9/9nE1gCQjOhhx8BZrWxBXXXsh17OqzlieaNY3OyIoo8hla6pGBTvo/BSeM18/WNTL5rCyUdSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u63kw8gg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eRMxAfrK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u63kw8gg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eRMxAfrK"
Date: Thu, 17 Sep 2026 09:39:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789630773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0igQin304nP9DurEyIteQCtX8TEHH4rBGYmjaSQfzyc=;
	b=u63kw8ggDgGCYSxjvQA2v7fDXEW2lPCH1T+Q07Q/QeLn6cQV+2QAkbF1Os3VH9gwTCzR+R
	DRXDoGuV32CuTSNNju1d/A5BghGYPzHzw4YMYCFo2e8SDD3M1RE5n34J3WZ0sGrO9/foyO
	sILJ63OAVoUFhFEAkLwa4KaR6gC0S/wMvhL7c2LXtwg6Zo7opY24flhjzCSYnpSfWQh6Ce
	iRbmIfJieVUHkKigmQm2fVMHRdcpaV8XEXLTZp/sanuNNneWMw++bHhaTQpqKkHNBUZ/ED
	pdIlgdPrcbBFUm2ZUa78mX1xwOF3m38Zw2ggeQaP2LG9tUGGODaKwt69aX5XYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789630773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0igQin304nP9DurEyIteQCtX8TEHH4rBGYmjaSQfzyc=;
	b=eRMxAfrKdQDwv6Ea2Fg6UimVRKEms3XXSHbs5tePWbDxnZDFePCEYBq747W5wzcm1chwGY
	+LVsn/6TxAlf2KCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: syzbot <syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, dwmw2@infradead.org, dwmw@amazon.co.uk,
	kvm@vger.kernel.org, liam.howlett@oracle.com, liam@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev, lkp@intel.com, llvm@lists.linux.dev,
	lorenzo.stoakes@oracle.com, me@brighamcampbell.com, mhocko@suse.com,
	nogikh@google.com, oe-kbuild-all@lists.linux.dev,
	pbonzini@redhat.com, rientjes@google.com, rppt@kernel.org,
	seanjc@google.com, shaikhkamal2012@gmail.com,
	shakeel.butt@linux.dev, skhan@linuxfoundation.org,
	surenb@google.com, syzkaller-bugs@googlegroups.com,
	vbabka@kernel.org
Subject: Re: [syzbot] [kvm?] BUG: sleeping function called from invalid
 context in kvm_mmu_notifier_invalidate_range_start
Message-ID: <20260917073931.iggMficE@linutronix.de>
References: <6936812a.a70a0220.38f243.0090.GAE@google.com>
 <6aaaa2da.86093f18.33004f.0001.GAE@google.com>
 <aqrZMReaQPG0M9oV@gremlin>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqrZMReaQPG0M9oV@gremlin>

On 2026-09-16 19:05:03 [+0100], Lorenzo Stoakes (ARM) wrote:
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac

> Seems like a false positive and an RT thing?

yes, it does. The proposed patch has a matching reported-by of the
report. dwmw2 did test it via his tree
	https://lore.kernel.org/all/6a8d9a7e.a5a502ce.31d34.0069.GAE@google.com/

Sebastian
