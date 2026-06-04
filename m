Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86CA47F2CB;
	Thu,  4 Jun 2026 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593102; cv=none; b=ONFh59pOGjuT5kzfyEyO8I8aE+pafJSrOp8zyLebuCzisUmr23T/7ND7W7za87ZEynuBeRcxQaOndh55aU3Z7go8y4n9/Vs62I/yCbRTpFxe7a6DBBjkXyJS35JuxbxBGVDEw5tUYJeVMXhQBdvY4RpwWy3esLStCOfQH6OZptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593102; c=relaxed/simple;
	bh=GbgplKPXYa2UNbqZfHKJ/fZMS/5TFFGc0wikQnh6Ldo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxdbHhKeAuuGLH1kOLN53H1163Ng9HwRUaClSVKq+t5ADnmIJYpMH6nsVKCEBbkz6kC0au2+0eZ3hqKnqssoqA7YrtyTpGHvtNfHWwKD1pDV5m4Re6NcNn9ggfR5RtZbeAu405d7QkySRp8XeK+E1ARM4tFigFViRPixQ1rEO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5z0qsku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5z0qsku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98961F00899;
	Thu,  4 Jun 2026 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780593100;
	bh=jq5cp0aGYbB6/otk4wK3ZDWvNng/wiEoRgWQxKMwtA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k5z0qskuA8WEns0xazep3AUKazNtC+UDwdwdkdC5h3jZKQa4yRN65fPCiYlulXV22
	 A0yBKwV8HyCm1lVzyohm4qQ3/zoM0Es7MqwCwX2TayqU68j1gJfPbDWBS+qcUxYjVy
	 6X001qOX7iD0LdLr/TQ37nJFbGHG79lwt25E53RT50ciMKRv7BhAb79SLdx92N4kGx
	 hJc522YUdl6MXNXOkHgZgDgPyzrdk6KIekGeWQHaZ0Y47X0sTMN23/KKSxHRtpWmia
	 4NLjbHojN4aYlakLPsThu5idBU268TgXj32mP552+szloAxrBTX3xi5aNgv5DUjSuV
	 w25+IqSxthujw==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1E38CF40068;
	Thu,  4 Jun 2026 13:11:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 04 Jun 2026 13:11:39 -0400
X-ME-Sender: <xms:y7Ehap7bISS6ixOvAtzDEj2L48PEGb-d_5GC9fLeD-M2lLR1fKpT9Q>
    <xme:y7EhaiSVoWVUZR_2Fjyj-H69tvTXa2IwECnrMBNh0XGymIyo-M_5ksPnrdCr5Ex1j
    l1nsa4Xcpq6U0Laf7TI5OmBPEC2djl53r_Jb-mpU9nRK7lQOARgQek>
X-ME-Received: <xmr:y7Ehap3eq1PgrZ5DDa8pIeWOnPXD8DPS4kVDfO_XkTcjkT1mZzc3WZqb490sbQ>
X-ME-Proxy-Cause: dmFkZTFlW7VhwxWXq7tsON5B+6qGxNwxYgJP3Wq0DzpeO16wgX6wxI6pErtUcVLIvEaSgV
    G50EDo6SWQD98P091T97d1R9HH7OhtI5ZzbpaSgG88N7bLFYfNXPoe1a+vXqpDy47eRrj4
    3Raze2ZLgXeIKizbd5iLEzl1dxLub2GwSuGrA8HJLFzr3PCPojzwNmZy+PWHkG6G6rNGqQ
    D3549YZfGLyb6fz6O/zHwN4VKU7z6l2OWJ+YlH8JSlz2qTilaNin29xWbvIH6ynfsEX0tG
    SL6LDgtYFdXau2QKOjTmeiP7YKQMiWmFkRCBfgxhQgfNbpJ3SADo8Y1mGQ231h8xbpUApJ
    4RphbNfkCvmdArbicxhY6wB8XyiI5xpr8FbHOp7hpSrhSYari9To0IwGAKj69jvRUKPlQV
    8LE/B9EaYkoombNH0NJn4nv0JoOWy07jvuhwJ4PfGgfcUTVq+fhp0b+4YUU9Vq7LOMTsws
    RyZTWGy+g0Ruo1pl0SNrNQhjj6Ql6/rF67zGPvoGaGaMz3U5XA1lc6DE+/7dEHwYGw/IWE
    FqckvdF+7jtgISxkeE8pyiJnkBexhdUCUSzJPbCzGWDSHzrFvr+f80e5ph/FdXOKRyqQiM
    Yk03nG4IvC4sQFbMUYTih7pP5Wjgw7OwHB8P5pllaIr7MqWjsmM1sjb3apcQ
X-ME-Proxy: <xmx:y7Ehap4eVtzTcL8qYiWFdoLd_ojw2C9dYanGaiYmbyaJhtWCFqOkzQ>
    <xmx:y7EhaovofXMG0FLIiBoNCKRm5IzbTlRqWH5IWINtTbkw-kRDNJiz1A>
    <xmx:y7EhaiMPEtTfwh6VM03EeLx6dKgCAMPjALWe9BrAmE0ivrk4nshJqQ>
    <xmx:y7EhajWur5vqT6URAMpy3-fWliTH5vZ4W5PRD1558FA3rCikLpW-Tg>
    <xmx:y7Ehaj0lkYICjd5MQpm7CaOYLKo0r89xPNL7x0tH5YPEfBLlKRvrBC2j>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 13:11:38 -0400 (EDT)
Date: Thu, 4 Jun 2026 18:11:37 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com, 
	seanjc@google.com, tglx@kernel.org, vannapurve@google.com, x86@kernel.org, 
	chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com
Subject: Re: [PATCH v6 08/11] x86/tdx: Add APIs to support Dynamic PAMT ops
 from KVM's fault path
Message-ID: <aiGxr47ClKRwXYUo@thinkstation>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-9-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-9-rick.p.edgecombe@intel.com>

On Mon, May 25, 2026 at 07:35:12PM -0700, Rick Edgecombe wrote:
> When handling an EPT violation, KVM holds a spinlock while manipulating
> the EPT. Before entering the spinlock it doesn't know how many EPT page
> tables will need to be installed or whether a huge page will be used. For
> this reason it allocates a worst case number of page tables that it might
> need as part of servicing the EPT violation.
> 
> Under Dynamic PAMT these pre-allocated pages will potentially need to have
> Dynamic PAMT backing pages installed for them. KVM already has helpers to
> manage topping up page caches before taking the MMU lock, but they cannot be
> passed from KVM to arch/x86 code.
> 
> The problem of how and when to install the DPAMT backing pages for the
> pages given to the TDX module during the fault path has had a lot of
> design attempts.
>  - Extracting KVM's MMU caches requires too much inlined code added to
>    headers.
>  - A few varieties of installing Dynamic PAMT backing when allocating the
>    S-EPT page tables. [0][1]
>  - Using mempool_t to transfer the pages between KVM and arch/x86 doesn't
>    work because it is the component is designed more around maintaining a
>    pool of pages, rather than topping up a continually drained cache.
> 
> So don't do these as they all had various problems. Instead just create a
> small simple data structure to use for handing a pre-allocated list of
> pages between KVM and arch/x86 code. Model this on KVM's existing MMU
> memory caches.
> 
> Add a tdx_pamt_cache arg to tdx_pamt_get() so it can draw pages from a
> cache when needed. Not all DPAMT page installations will happen under
> spinlock, for example control pages. So have tdx_pamt_get() maintain the
> existing behavior of allocating from the page allocator when NULL is
> passed for the struct tdx_pamt_cache arg. This prevents excess allocations
> for cases where it can be avoided.
> 
> Export the new helpers for KVM.
> 
> Assisted-by: GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Link: https://lore.kernel.org/kvm/de05853257e9cc66998101943f78a4b7e6e3d741.camel@intel.com/ [0]
> Link: https://lore.kernel.org/kvm/aYprxnSHKHUtk7pt@google.com/ [1]

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
