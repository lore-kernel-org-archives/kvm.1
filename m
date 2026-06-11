Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64923D170E
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199160; cv=none; b=Mc3SFN5VVTzNtRLdaRPpTCt/BWSTN84btKdTxc7kxF/2JuZ+E/yngASXk+tSlhju3uSaajEjZG0m7Wza4PHPQGgOTGvVX60HQzuMFrNQoW2WoaV0ll15B0I8rm4cIEu4QdrsZa1bZSSdvM8bEunoQuS2aHub4VgfiRQEYO03WgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199160; c=relaxed/simple;
	bh=ZC10N5K1Uf5Gl2W9Tp7DBs5Dm/gRd+rCKOsZdjSHo4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t6RMB1Lg46cuaUeJ/5X9+Ub1WXp7jwhAi2MqEvl7XlTm9SNaHbWZ7PON6x5QzDnGPz2aPg3cEEkpN7euaEcc+/MY2a6DjUXqJq0UTOlJYJ1qlNqNQ5hB3SmG8xTnnxhuQhC03opcS5rDwc88UBVx9jV/kQG6tLYJX5WTNFMsQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5BME0s7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5BME0s7"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso167786a91.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781199155; x=1781803955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYRkuayTuL16Pkn1aO5SDd0TBkg98VgTJSGck9SOjFs=;
        b=n5BME0s7VcusLYycII/hEedKFbR6ALHL7qYVJUSjAErnNnbCT+n0+QwECb/1vmyamK
         7tdt3b+Q79o9xPpbz+WvzMfRI4AtmlWbgfdBi/+MrD0PfqTxpuGWRZiZ4R9wR7RpDTKG
         m64rjoMJ8qsBr42nMJz28J0Tum+rQ384pUMJKBCv4e8zaMGKFzcy/jzkZm1kTiOXN+5f
         KMfgXM4Zu3ILVH4VFISHcMNKBumrTdsYHChf2ZDaIDj9/ZTtLODlsRuX5h8VB2GAEHH3
         VOCBgjQXrA1AKi6OKzYT9GDSvgsim2/tJdymEjNWfHm0vNea62LG5FyNPVsqnuRaHQ+V
         T/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781199155; x=1781803955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pYRkuayTuL16Pkn1aO5SDd0TBkg98VgTJSGck9SOjFs=;
        b=N6IEBjnwXS8105uwSSCll1+y5h95Ety5yIeKxK51QyFCruwErPMxw5va2EvqF/aQX7
         RL3vOIy9uHD/3E4twKDV+6MBzmhmg0xV/SOjaxksCi5VahS7/5u3U410FY4wpBoNDHXP
         JVuAtyU99A94oyVUQN8fPwCHE9Q23UuOdqGFX9XBgjGFFzf9Jw3k6YpCqNzf6zbnl48N
         EFRIYM7ZoMKtB96CYQCSJ9gCaZV1sL9VYj09ouOrZnlPdrGO8SZWtr6ERXoDx48x4nLx
         ioJ4DHqTHI2L+RQanIa+7HbrJvOVnagg77CpL4d4WYiV+jLTwtaQ7nEdiiLrUbrY3joj
         6MtA==
X-Forwarded-Encrypted: i=1; AFNElJ9LRBJABhGFOWYRyvYEtA2AR8Qq7Xhme8Rk7PUG5jjphNV7Ve99FeAlWegCtjBwVZ+mLoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyEjTtjmhhnc9kWtrMBxd4DpZyPTu/USmWbDHs0bXrsuOAVLIs
	GCKwiAQ5RwY/p9vul/SDp6AzDKQ6QOErKv3DWToo3Bl8E1sz+P9qf6T3oERkyfL6yTdZq069PDn
	PuWbCQA==
X-Received: from plrb2.prod.google.com ([2002:a17:902:a9c2:b0:2c1:adb4:12f0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc44:b0:36d:7a76:827b
 with SMTP id 98e67ed59e1d1-377a73e2769mr4371820a91.14.1781199154819; Thu, 11
 Jun 2026 10:32:34 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:32:34 -0700
In-Reply-To: <airrbMQafcuxoVkg@v4bel>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aimMWzAf5b3luM0b@v4bel> <wxamg6zqn2qmsci2fwfepbqou5vtgydqmonr67mu7b73nkakbe@zedss5vzeci3>
 <aiqNPBQzoU9f8RwI@v4bel> <aiqueNUndQsbMNud@google.com> <airAthcKDZeDfzXS@v4bel>
 <airS1G23atiuWdTl@google.com> <airrbMQafcuxoVkg@v4bel>
Message-ID: <airxMoy44ZxkbioH@google.com>
Subject: Re: [PATCH] KVM: SEV: Don't return a still-assigned gmem page to the host
From: Sean Christopherson <seanjc@google.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 12, 2026, Hyunwoo Kim wrote:
> On Thu, Jun 11, 2026 at 08:23:00AM -0700, Sean Christopherson wrote:
> > On Thu, Jun 11, 2026, Hyunwoo Kim wrote:
> > > > > To handle this properly, the folio would need to be taken off the LRU
> > > > > before leaking, with something like folio_isolate_lru(), but that is
> > > > > mm-internal and does not look usable from KVM. How should we proceed?
> > > > > Please let me know if I am missing something.
> > > > 
> > > > I'm inclined to do nothing.  rmp_make_shared() should only fail in this case if
> > > > there's a fatal bug somewhere, no?  Either that or do BUG_ON(), because at some
> > > > point these types of errors are simply unrecoverable.
> > > 
> > > A guest can make a gmem page a VMSA via AP creation,
> > 
> > Ugh, the bane of my existence.  Can we kill off that feature yet?  I'm only half
> > joking.  Not even half.
> > 
> > > and if that gfn is then hole-punched, a page that is still assigned to the
> > > guest is returned to the host in sev_gmem_invalidate(), which looked like it
> > > could lead to a host RMP PF, so I sent the patch.
> > 
> > Yeah, I suspect you're right.  But leaking the page doesn't fix the underlying
> > problem, which is that it's possible to free a page that's being used as a VMSA.
> > 
> > We can't simply pin the page, because IIUC ->free_folio() is called when the page
> > is removed from the filemap, not when the folio/page is free back to the allocator.

...

> > The right way to handle this is to treat the VMSA "mapping" like an MMU mapping.
> > I.e. this is fundamentally the same mess we have to solve in order to not pin
> > pages that are mapped into L2 via vmcs01/vmcb02 for nVMX/nSVM.
> > 
> > Something like this, sans the actually handling of the request.  The simple way
> > to handle the request would be to invalidate control.vmsa_pa if snp_has_guest_vmsa
> > is true, and then redo the mapping part of sev_snp_init_protected_guest_state().
> 
> Understood. This looks like a fairly large change, at least for me,

Heh, definitely not just for you, it'll be a large, painful change for anyone :-)

> so would you be able to handle the patch?

Yeah, I'll work with Mike and others to get a fix landed.  Thanks much for the
bug report!
