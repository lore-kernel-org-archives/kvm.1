Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095B7274FD1
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308815; cv=none; b=rzQzCxKaD7rHI2+JKr8u1ZRepMVfv2/caRWjYtkuHMf4ZVzrhWgLt3Sl2JnQnJG9UIP6TGwTDKyvjtQzEN+FzUZAvgsaeCkKlVyWbATWcQrb+p68WhYFpINegMLBlGnCHGauB6mLUnOW4dQN7r4+Z36JcnVjcifOFD1tDeljht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308815; c=relaxed/simple;
	bh=vQiPto57O9dkdl+XRVwjetNC4JB2ICzm6c+0r7erA18=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CC9v4DbVtBgGlDycLngq6bujPmljmYdAscTSc8nFP54qj4pIKr+xLhZBAvxmRlqE0PwlHIcfcpPL1LQxPZ8OKvBT4Wy8luqWdORngaCTnfYBY+CZCfKTSt+KBewpaldsLaziKPL/X1BDSgG+wRwjkV5fHtj3pgm5AJKwgKgcn00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC7kT+Tt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC7kT+Tt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E031F00A3A;
	Sat, 13 Jun 2026 00:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781308814;
	bh=9l+mNRqboOtRgfhPe+mmuhZHWZensQmKvoxFdS8+hD4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=bC7kT+TtwePUo48FvNvwFV5jsmHvHGUG52IThC6EmMGiX0vA0LlPJXjJN1+BRg8HO
	 36q0+xYa+j2DWtlaG7bMH9RMfV+bWjuFL4PE0Y0zZ1eBJZ/5VPGm7auGCVu5BGc1I/
	 eSfIWyxUudjZjJKXRpSWlBuF9e1M/bdWB8+5uK953hlwlvO6/X8bc1Y+2d0IBGk9kk
	 9KeeLq/HduXUyjab9sQokQwukZk6Q2baGaMq4jx3NzpyMxzx6fdo07gyUKaUxNjT8b
	 jbysyyZwQpIN8DrUfOogKXNNYsubV78ScYkYxAC3PWEQUhkA7KP+l9c4/z2LcH6L9A
	 rfgh5fQHTylBg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 912A4F40078;
	Fri, 12 Jun 2026 20:00:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 20:00:13 -0400
X-ME-Sender: <xms:jZ0sahvkVH-grpqOoU5ciQCOC5gWepJIkVWv0TR2L8CLNVTClBXEcw>
    <xme:jZ0sagDBrOIlR4wTreYByvufalQ9PE-bn92qU54NLM3PL207Z9OV2zbD6c0ggTHXT
    lRn8bjWGz8ZvkWpaz-nNH3JfNHsUzpUzm7oDnQpaDWEawiEEgpV5io>
X-ME-Received: <xmr:jZ0sauW0RbmeC7CGt4tiGo6o1TClaSkRe7LZjfEu_M4txsCc8X1qIZ1sey1YxkZMeVz8rakHCsF3zTC29O-tbNI2TFIbE7MWZQI>
X-ME-Proxy-Cause: dmFkZTEyH7ZgW8x8zWOOs3YLqCsd8vM/giRH54jmDva/ATX/E8RWtKsfgjPbMCIM5ljXtE
    /iQxleIhbhZgZI660CPAoOPVI1CY9xqXvrqeJQsTuzRNWphptjXfP08d874134vN0oO9H+
    eoJrTtGiYw3ZVvJN0m2L/3s9JWb1KZCPBVcaFL3V4W5hxqDs35AxCtKlQ/dReZ+C6szqBn
    tMDPPjEzKiCt0H+oGMQyryfTjB5oOhWeKSHlUHRlhCp9q2QZKebtbijnFa+SsLqvLLUEiz
    zFqkALL7i1mz4H7fGnxaJY/uQyY9Bf1S0g9FxCGgmuyPm7ELY7SzVs2eYFRtXv7MwSctf8
    wbj2wEYAC9SNw9hpN9ReCJjUeZhv6/Tp3AHXoZzZKMyXAg0IAxdPp3jM+TfUXRkQd+kGgc
    ZxM/JRmCmjGOo5ZtYVDRpSJemNBufmiqZLOjNdcUb/XIt+caqoY3x7siqzwHu03mctbxJW
    uEcQoaL7G0Z7LThrDQi9ueGAG0IQzCu/UvrwlIYpe6RWXIPUNph7d+HekX2uRC38tDjkNu
    4Cp9Y4tQrLXwD9ph3ml/YeG1BpUBdHjCbiIM9XsPsMkYFjScFuIZT1v7XA4RsxZ3AOpj50
    qXpOXv0Y3ui9Xh0Jk6rEOdJ/mdP+3Tyb35C6xPYmeRY7T9dwODLFO2HShlpg
X-ME-Proxy: <xmx:jZ0sapEB1rtGYjmuSCZCvtv-frYy0oBVPaRQJAHutPsP8FT3uwl_kg>
    <xmx:jZ0sapMML-XUkOeMAlZ7lxAVdvJJQL3Peqvyv1Wn7jOp4dXDuUxs1w>
    <xmx:jZ0salW4Pr15u6vO0ACfJ-FxsNTkOLwAiGDS6Ex_UhoWA1Cgw-qwTg>
    <xmx:jZ0sagwYrGGgXKTOwmWl4bwT0xw-CS-w373Zsv-2BZ6EnORIl8PNnA>
    <xmx:jZ0salODKQOgHwgz85pf_oOrrSt50zktJx2H0wAwg1RhgcpNVsSMp3i->
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 20:00:12 -0400 (EDT)
Date: Fri, 12 Jun 2026 17:00:11 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>, 
 kas@kernel.org, 
 djbw@kernel.org, 
 rick.p.edgecombe@intel.com, 
 x86@kernel.org, 
 peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, 
 sohil.mehta@intel.com, 
 yilun.xu@intel.com, 
 yilun.xu@linux.intel.com, 
 baolu.lu@linux.intel.com, 
 zhenzhong.duan@intel.com, 
 xiaoyao.li@intel.com
Message-ID: <6a2c9d8b8bfe9_9b85510018@djbw-dev.notmuch>
In-Reply-To: <20260522034128.3144354-7-yilun.xu@linux.intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-7-yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH 06/15] x86/virt/tdx: Initialize Quoting extension
 during bringup
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Initialize the Quoting extension and fetch its metadata during TDX
> bringup.
> 
> Because Quoting is an optional TDX feature, do not let its
> initialization failures cause TDX bringup to fail.

Is this micro-optimization worth it? What are the classes of quote-init
failures vs just make the policy be anything in the module must init.

> This patch does not include the opt-in portion of the initialization.
> It mainly lays the groundwork for TDX Quoting support. Opt-in will be
> added in a follow-up patch once the feature can be properly used by the
> system.

It is unconditionally calling quote init even if the feature is not
present. Is that not a problem?
