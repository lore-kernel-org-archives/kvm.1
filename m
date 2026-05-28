Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1193B4EA0
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961520; cv=none; b=HjQzS/jeDD0Os/HYDnLoT7YWC0RM1MaTqXBsaupujawkNZxXBgt1ron1b0ot6vaagtZOERnCK7/qyLms5Me4MJW3jM53Ee5l3h9lWTYiwuqHWLq8KhJFyTJ/VcEDZrHw+a26O6Ab9jFcBJGyXWoemuHa54GpQL2Ty5x1jsS3LY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961520; c=relaxed/simple;
	bh=aAxjtdxJ6r1CP4Z3IDgAZpRSUpL+wMyFZJH7GiXQ4iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLAjeQDJ9ARUQmhvzJ5dqfiDXV2EsgCDtZtknmMjY3UJ9ucQE0JnbxczSutEmYeJ93lUnRyvj43wlmc88FtmseHErTbj9+FzO7oje5sgv4riFZhyTJTTffcbYuErfzF5ZWnRqXgHU1VvzqNrQi/kbgEkKkaoMGrIykiC1duvKB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5KE3C2k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5KE3C2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76701F000E9;
	Thu, 28 May 2026 09:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779961518;
	bh=24KtZet5bNtxE/kz3ESLDjWR/8+B0zqHRym7ghogGko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f5KE3C2kT5DPmE+38+WW+USaYcnj1bBXzI/++IbGy9OgJl9RLIVhVzLg05LvCj3Hr
	 nTTfjEx4V8VpR5kXEytYdrNyQZi1eXPeP8HlWcTYDDfRN1/K9S+x0v/38NJReaE7L5
	 1W/wP7wP/9+bGHCof1lLIYkS3q0ddTC2bWVUzR0YOYfCGgEAlbHvPFckoxhzcDWRTw
	 avC80wKAo9BDjReZdG6CrKrdqNxn16rM5/hzIPCWqnXxML/pvzv8Xpg3jo8xFwsINL
	 i295PK3dkGE13XdFig73JhObpz7QKc/zkJQstq4F88Azxh6E1yi3B9iKkHCGY2Nh9h
	 Cwg6eZmnl6z3w==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3A430F4007C;
	Thu, 28 May 2026 05:45:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 28 May 2026 05:45:17 -0400
X-ME-Sender: <xms:rQ4Yalb-30S2wTAlZWzDn6YHPkBfV48Lst5l_rYwMmjTdJmBQhLGPg>
    <xme:rQ4YarWTUzEre8fIXLz9GHeMLIIlUHGVqfg5DOf2yUmnoAxupS-GXrZytC7swvsMd
    YrPJJdQUGUejA7TfCXfx5CpGP_axObkk6bSbUwasVSfPSL7W7fB6uY>
X-ME-Received: <xmr:rQ4YakD10GsVqfXiWzRV6hZ0vtPkYmiNhK_oThtw5Gp0MldXFgUoaO8FugYi8Q>
X-ME-Proxy-Cause: dmFkZTGIABqz5JrsRfWGM2QWd4mfSrGlRGGw4sK8tceuGzEiMjpd74J6+evRD8XyrDDv9g
    fLqQ/LLZCgxljT2lkm7eyQ0WmobREAYEYgf0OCLhIbODTvXP8Ocx4qaeHFrmkcvnfPSct+
    bZg4qB2A/xoDG+Xzjog/WDQMxqYEzges53bhoRDw5ezoUB1c6TuIw/nBHfol/gHLUBYGr6
    ovRlheURHTgetz8CEEPsBGi1ZkJlyg/8zQzco6ZWQlagEl7YtwPAdtTZLnCAon8P//ZK6i
    b0FYVhjHP+Q19N3C3NxxiQtbIRBMIDDLYooIy8NnQ6GpEmXRf8R+fPbWQ9HWD6LHYn0Uh8
    VCWjnq/D1YlaDtr0XTFWcDh8QjCuIAXk7kGX1vHsBS7eTR1axmbd+89Qf1HbTcRmmYfKwu
    C44FhaWNYLz0NpLCmfc9Zdw6D92itwKm8Hx+HaRsNsk6ZFjhd/bXzpnTK0LAsLKEcNp7se
    JszAzn6oxeWw0P46dqOwn4W9tUuFxkTWzi8dbkcV1FS8pOiio018HvDeeB5cYjYIUkNbyM
    gewaMy+fQGv3GBbAAKTGeObYYWTTBDKv42BaJBEdWS9ULxh51e51P7kmnX+LJMsqEFXouB
    cpoenYXpX8Km8xn9rBNdIRSUDe8dLeLode4NVC7TFRQphXkqQQVOpuSCOLMQ
X-ME-Proxy: <xmx:rQ4YanJcM5yvIVB_kZN2YvB465RxMlmwd-QXpMLbhS1rHfKtf8MHfQ>
    <xmx:rQ4YaiuYlhLbZrtivywz2l3CD0RfA_lxRnqNEJZY6jWJK9qDA-P-sQ>
    <xmx:rQ4YavV2JONoGGMwusx8tSkpsO1RvFQX5hiu4dVhbzZNLH7YnHmMQA>
    <xmx:rQ4YatIj9kzkUtbs0VhT4g_qWNyF07Igh1Uo3VumM1NLN7dFViP4pg>
    <xmx:rQ4Yak905R4QBGwDcblmyl37lNwgjbp7CAlkd3OLLlSmOANtgZRf-u0D>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 05:45:15 -0400 (EDT)
Date: Thu, 28 May 2026 10:45:08 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: dave.hansen@linux.intel.com, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com
Subject: Re: [PATCH] MAINTAINERS: Move Rick Edgecombe to TDX maintainer
Message-ID: <ahgOHFuYD2YIP3Q7@thinkstation>
References: <20260527221342.415814-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527221342.415814-1-rick.p.edgecombe@intel.com>

On Wed, May 27, 2026 at 03:13:42PM -0700, Rick Edgecombe wrote:
> Per some offline discussion with Kiryl, he could use some help on the TDX
> host side. I have worked on the TDX host side for the past few years
> including wrangling the initial KVM support, and can help with this.
> 
> I am already listed as TDX reviewer. Move it to maintainer.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kiryl Shutsemau <kas@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
