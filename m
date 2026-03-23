Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F8639C001;
	Mon, 23 Mar 2026 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268255; cv=none; b=s+iKLdQsMv9BpAsvRUaASaKbmmp2OBwVlBG90RfuAoZ3+rnny6e+muR3gNhiRYujQtE4t4N7jcZlFxqnK3Zz9RJhFxQn7RBSZAxA13wz2LJNuyE1mJP1mlcpPUDV6fG+pV144oXpDY/trTwRxJr4r+FBVFblH5qjuSDlb5C3o1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268255; c=relaxed/simple;
	bh=2o9t91MAFkEEC33gJK2BYO/b2oCktQ5ZVRUEjJeP8Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dewwr0gFVhO2AnD5FEbkyRpNlNL8Q71mZJyWUfvIT1QlpxDtamR5BKUZVdHLNv7qQvCerRadcEJJi+sS2PYrOKe2fEUgA6TjFH3JVDfA/JVoZAG2lztCq4qTzjZDxdBkGndPbHL5Z9Md7bkKVPKrOeGZLYJKuMtXzINESKD6yW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Sg9ithsY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Sg9ithsY"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 80A3040E019D;
	Mon, 23 Mar 2026 12:17:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ELMIRdKi8huZ; Mon, 23 Mar 2026 12:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774268244; bh=f738n672SoV7BVsc9oVqYhfWXfRA4kWj+hTcFk69Th4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sg9ithsYbaS952b3lKr4QIpqjR5Z6xSJA+S+Fgv1dDR93sv5j/GtHSV+gqdlNVdeI
	 JevPbyz3diPKaL5Cf34yLUZq0lbIrLT/s+ku9HjSbSFOftOf3dH8gqyq4PR+irWUDx
	 2m/NItVJ4vGJ6jYA/YYFXnVAO5k9ehwrlRDmh5vZKfsvgbrQ3m+aXNc2qNDWHlNY/E
	 ZavgEuzz7j6M8UJ5N696oa0IGtH76JAuStf0Vg6PBkpCxL48YgPOMEo8yf0A0dEq8v
	 5ZYmmj6g/GwB5I6fOGGxFd2L97tFWtk7tGLrrIfeWfgHYXY0ZF+uX8UdbzVfHfx0eX
	 Lyac1tBMJM2hWbqB+KzFdeE64ZFjIg9kAVAvpEl098DqFiAoaXOcgH4V8FLMuk41EH
	 qxvpBhgtDD7F41ssl6VvVw7nuh/xpTj+TKtV2WopFrTHtPM5r8uCteM69DJdxzoZgq
	 TxCqhn9rcZGtGe+uervtNN1ueizekHLhePZi2zNs1Sz1RT29EjSo++pHLK+pzbk4R8
	 h7iqZHlHyQAJjR63PflEdjlSh3Ddyp1D74CY3on+3e8z0/BDqIqbIloRdSPZvKUYm0
	 c0IASD9FMdXlev6+qrnmz2t6SdYdJPqZMbh54SVumYEoh65NUmdk9hbBqt2TUVxVui
	 fh4QfmqrPq27ujqF9MaRWKW4=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id BF9C040E0163;
	Mon, 23 Mar 2026 12:17:16 +0000 (UTC)
Date: Mon, 23 Mar 2026 13:17:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
	kvm <kvm@vger.kernel.org>, Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 18/22] KVM: SVM: add GMET bit definitions
Message-ID: <20260323121708.GAacEvRNp0sFRf8dA-@fat_crate.local>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
 <20260321000931.1947084-19-pbonzini@redhat.com>
 <20260321115826.GCab6H4lNYIih_g0B0@fat_crate.local>
 <CABgObfbGxJYO0iXvkduFR=q=gyoF819pwkgJSke7SLr+6zCVZg@mail.gmail.com>
 <20260321154219.GEab68W-ln67dqTB5x@fat_crate.local>
 <CABgObfYHtUJtw4pykQ=cw3aJrc_KneG92GgG0dyaXhhKw4qHSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfYHtUJtw4pykQ=cw3aJrc_KneG92GgG0dyaXhhKw4qHSQ@mail.gmail.com>

On Mon, Mar 23, 2026 at 08:53:32AM +0100, Paolo Bonzini wrote:
> I am not sure what you mean by ABI in this context, maybe "there are

It means that once we show it in /proc/cpuinfo, we're stuck with it forever
because something in userspace might depend on it.

So we try to avoid that if it can be solved in a different way.

> rules for whether to add stuff to cpuinfo.rst"? If so, GMET matches
> what cpuinfo.rst says:
> 
> * the kernel knows about the feature enough to have an X86_FEATURE bit
> * the kernel supports it and is currently making it available to userspace
> * the hardware supports it.
> 
> The bullet that applies here is the second from the above list: 1)
> this series makes the feature available for userspace and guests to
> use it,

This is the key question: what in userspace is going to parse /proc/cpuinfo
and look for "gmet"?

Because parsing /proc/cpuinfo is the silliest option available but glibc does
it and for some things like, "did the kernel *actually* enable this?" it is
the only way.

If the above applies, can this be solved in a different way? CPUID,
guest_cpu_cap_has(), whatever...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
