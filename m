Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14C01D6BB;
	Thu,  2 Apr 2026 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112134; cv=none; b=nVeESAJrQJREhcYCozW4/ea2M5EoKWN/gnH1cAIZm2J6WtXH2d+zwRZc2BgTyz4d9HkkiwcHpX+ZQSIX57HsbU3EWptXbpGHmJDnIT8Pm2wFNy/WSXnGA34CVRhAe/CZtSeeSin8ywKWV+cgg7hG7Dng8pdk3CSFVkTiu0mHJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112134; c=relaxed/simple;
	bh=S1O8HaI8EaNch4fIxBRBeg8PXroD/AZZZf9ITX8ieJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVotTbyVyQTWXMzXt2rY1s/nt944cUcHUwuWBW/jtqU6AfnQjsh5UEsQVpKkwdbRlFW7PfrQHIBLa0pfsfeHNbJz3BVHn808FiAA2elDTB7GD6CMyQOv6xiIMerWPlBP5mLbLn7Skqmmbj/Ya6QX25Nc3p3kyIcHQ96P4vqKNGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QNiRKDBO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FEaTuD25; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QNiRKDBO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FEaTuD25"
Date: Thu, 2 Apr 2026 08:42:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775112130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S1O8HaI8EaNch4fIxBRBeg8PXroD/AZZZf9ITX8ieJI=;
	b=QNiRKDBO8UeNhswCpjncHwqbY4cX7WxwSeXUSq8ED+K5Cxg1KaTYyNxdweOpE8fV8ja6z8
	eHmozn66EOCb8gc2QXLLdJx09CBf9LJslDAW8EIEsxcuXww8Tt5vJICTI5Ng0zPJxXVTMe
	tAqYgdaAupY2ahwaGrNWg63XRKSuOgdvuVYvM6IAaBOVe5TlZGHNIQVFS3JA5Z7fmRao3K
	1JuB/03FmpTLVVyvpLPuDvRlDbo+99jwiwA/PpD/flMVcAUz+zeHnjsslpushl8m0rrndW
	A3VOTYYMlYZdz15NyslTxxjoLvedL45/3CpBYSBSQUWsaUGvz8uH5+fCf++8RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775112130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S1O8HaI8EaNch4fIxBRBeg8PXroD/AZZZf9ITX8ieJI=;
	b=FEaTuD25yB5fdfwCKhlMYFdmyvsHKuMFsBKkx87xMyMVjawpaklmr3FqCidvv8uLEcvWFg
	fw5AgYR2nWhx6vAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sean Christopherson <seanjc@google.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"shaikhkamal2012@gmail.com" <shaikhkamal2012@gmail.com>,
	"syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com" <syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com>,
	"me@brighamcampbell.com" <me@brighamcampbell.com>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paul@xen.org" <paul@xen.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Subject: Re: [PATCH] KVM: x86/xen: Fix sleeping lock in hard IRQ context on
 PREEMPT_RT
Message-ID: <20260402064209.8ba7wrBI@linutronix.de>
References: <20260329131543.91733-1-shaikhkamal2012@gmail.com>
 <20260330101814.7fa1e31e@gandalf.local.home>
 <bb7b66ad99097c5326196b61d644cff255e30394.camel@amazon.co.uk>
 <ac08V4TaM2yh9SY1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac08V4TaM2yh9SY1@google.com>

On 2026-04-01 08:40:07 [-0700], Sean Christopherson wrote:
> Re-reading through the thread where you proposed using trylock, and through
> commit bbe17c625d68 ("KVM: x86/xen: Fix potential deadlock in kvm_xen_update_runstate_guest()"),
> I think I agree with using trylock for "fast" paths.

Has bbe17c625d68 been applied for PREEMPT_RT reasons?

Sebastian
