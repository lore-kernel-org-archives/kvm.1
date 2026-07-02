Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E832C21E6;
	Thu,  2 Jul 2026 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956999; cv=none; b=QQUUIyFue7r7BkbMhcCbYMH2h83TovIW2wgxAQDJQ+3omFnVwGsFoK3N8Vek4hUxvSnSCn2DZHAgMtgSR5ftFhnjT0IAW7TbWbjwXJyclbOI0yxLLvY/zvpqlnfHGusYehouKgfImklYx1f/Fx0Odvri6HN3gk+nWdkMBFydnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956999; c=relaxed/simple;
	bh=1rGcI7fXbkQIPE7C6T9+LpdAByVIQ+easgUPCd4wZWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIGX2KtX5utWnEd0FIhsScFwnArk66JhNqwnbiJFWo0DPAFYMe9fpSyIoHxgSEUzL3BwgErywUrDMTEn8XkjiOGQfR05kT7sxEDtBmcC9TQN7btjKPR/myeSRRF4vMT+VXTr5UI03lenasOLAqr6rx7+4HIF0c5dIUIoeYoWyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dnxVzo65; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dnxVzo65"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BB41840E00C0;
	Thu,  2 Jul 2026 01:49:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GYoAw8GN6Lr2; Thu,  2 Jul 2026 01:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782956983; bh=1LRcVhkrrnkjExAkus9/VzYWV0Z1F+xlmYHjExOUDZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnxVzo65PEOl4ZF8cYigILzky7noHFVFiTTqRLLoJOC2YeECZcTXhLu4q9stI0OEE
	 ltD0Oo62CNSRUZeVR46RTfe2D3c4hbX2DbwjuJ+KdR1tFUssx3QbtYNGuwDU+IpIss
	 VqAi0/MkqFs4yfb+HbC7GepaZYjVvYdc0rqxiuH8K+tPeyNyalikwTGCwxo5HvrViM
	 aXIJAjEAZ0568Ctyjet+GUEHsZAsjb2RYiLkzcw1n4HXvuEuSRAgKh8TPmgwKhpA+2
	 nmWTvqev8EYU4Osk7WPxUNYula+vNXyDFzDmT6gXE3Qy5A4h52wI2ChUS1bdEe0215
	 N/64o49GwbwZdZH57KOy14t6ShzehCSl8A7ci70XJv6mG+aHVniTMitdjvPqiti1gz
	 MmGV0EJxoljk/GYpQk77qBYG4kVx1WZeTKu4N3ib0iUK9/44onJEmI8d2BTw0HrlX2
	 9HqIn1Tp4lxLw9X3gvAR0e7G5M29v6crgAJbGypiSNJcemvdyDg4E5HeDXF7GmiERK
	 hQWsKp2I+c1Jo3UOJ2T/dLE/8HdGiA1Esi1qDiY3CQrUh+kMxvQT+8S4CLbXwHhNSu
	 O0Qqzloyfom1VcgoPX7ddWmVN46ug+//WbdYhNBZSwhZd6VrbQ9HLbHgchiYO4P7Li
	 +Dm72jvGxd36mbTjrLg12Hao=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E31F240E0140;
	Thu,  2 Jul 2026 01:49:29 +0000 (UTC)
Date: Wed, 1 Jul 2026 18:49:26 -0700
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>, pbonzini@redhat.com,
	tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com,
	cobechen@zhaoxin.com, tonywwang@zhaoxin.com
Subject: Re: [PATCH v3 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX
 cryptographic features
Message-ID: <20260702014926.GHakXDpsIK5srVj0Mk@fat_crate.local>
References: <20260610023512.3690734-1-ewanhai-oc@zhaoxin.com>
 <20260701024521.kffehv7bxcjc5f3y@ewan-server>
 <akUfrLPAAUuD8zRZ@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akUfrLPAAUuD8zRZ@google.com>

On Wed, Jul 01, 2026 at 07:09:48AM -0700, Sean Christopherson wrote:
> On Wed, Jul 01, 2026, Ewan Hai-oc wrote:
> > Gentle ping. Any further comments on this series?
> 
> LGTM, I'm just waiting for -rc2 to start applying anything for 7.3.  The only
> question is if Boris is ok exposing all of these via /proc/cpuinfo.

My canned answer always is: Documentation/arch/x86/cpuinfo.rst and I'd suggest
to the Zhaoxin people to think twice before exposing things in /proc/cpuinfo
and burdening themselves with maintaining this forever.

But I don't know of anyone who has that hardware and so testing on it is a bit
of a problem and so that leaf is a bit of a don't-care. I'd say.

Btw, Sashiko rightfully mentions:

https://lore.kernel.org/r/20260610024350.F13471F00893@smtp.kernel.org

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
