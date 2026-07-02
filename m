Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A73C1979
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001242; cv=none; b=dVzD1S1Ntqc8S0IPWYGO9jCyd2S16libQIMjBbxyut2PhUtLGX44SVm8LaSgbn91UOYNzdI7uBvFEDftvHoT8f0n5GH0G4XadEoT0Ysx/svWCktsV1nIpxuAKTcYY8t3z1+5toUoOu5fG9m0eeEyrVCJm7TDdb7tSgJZlz0UhLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001242; c=relaxed/simple;
	bh=Mcy2l8Ak5QnfHc6U+494XBnpd6E/K9FucMu2tYmWpfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+tkxJOY2DVKKqtPCW6y4LNOJcH/oQmpwt8t63gYalcX9RZzgVcmq1GoyW0apDxg3VLgp82fzcpt20yqnwaSQree7UQnaHLGjc2EuOKTnzHEfI/0gFZBC7Z0gQPQ0xIbNF75J1Qe3b7txXg4F+7p/iMOLrIsY91Ri37HNfHHJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSSXjRy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSSXjRy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E341F00A3D;
	Thu,  2 Jul 2026 14:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783001241;
	bh=J4TDctaT9B+X+zPqki1x9fmk8MLNfGToi4HsS7g0NBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PSSXjRy8wM5BCUB6QUnHL0gGBAsAFbYa4uhrhW6hQo/3aVF1NsaClsPuO/KgLf+n6
	 XjGzN/ODONQWuOIHI0XrbjZFXuYv/rilrd0LJYWSVVy7fU/RIN6gXcX2OH8i5ockYb
	 PXnp//bzLzHvHgjlINfGtkd1p1LbUpjEQQv6ECqP+lnvndJsOwLbxE067VfCbmy0FO
	 B3P3wgG9ogk6QcdwDPhP5v6truCiqjtv4/BJi8LXk1lSDtrTOvZ3HWPCm4RuFVpo+n
	 06FY3S0C/32fJ1G6SJqnMupRim2pKrnyYx4ilbxX6FZXNn3pm/6QhtDxFs6JbPtCte
	 zDmNT6db5NyQQ==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 98BC3F40073;
	Thu,  2 Jul 2026 10:07:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 02 Jul 2026 10:07:19 -0400
X-ME-Sender: <xms:l3BGapTbkW3X0VhH6JqW2c2QtkAZIAlu0Bl5V3-mNnLiJjDRa09rVg>
    <xme:l3BGai5W2eQQoArKw1kvPticcFPeQ_c0TMuYNkDZhfF_VWSXn4hJJNmYWzMRrPF30
    kqzhqz6xFL-Y8sE20SKpSjT_TH0LRLbPQBiADOg-UkWXycHJkcfEA>
X-ME-Received: <xmr:l3BGaspjNQWTZeKdUPyggtHx0WhCR8GQQcVNcIowcGvPSRHxAp2DprsoeD8S3A>
X-ME-Proxy-Cause: dmFkZTFUM6GxX1Kgnzd8GV9GokXanMJuwqfF95TXt1vel74GIqYnWXFVd3EMFZzaIif8uk
    dNQtx264nUI5xZufMVbneeLsugpVtMYDGSnAYAELWyRr7iw5/nTcdQKg+HBdW4zN04PVlM
    Gf3BjHaEl/XbSY2VNc7yrNih+eQ3mfhMl3DCeHDleYks6SsmZ3aw5o3ax3OSzSj7zshtfs
    XD6QvagOSUKlM6ijjNjXdlA2I9Kyp8/20SSqgTchbmexu5a1d/BpLCj5zUgtVEfRlvw+TJ
    rPwuhdxfo+Nt3T7ctVXkXu9AoiV331aCMrb3AoW6PCx6oSnC+DTKvw8eem2dh7HTKGKAj3
    lEu57zCoDf/obB/ZQTotfyvUctelXPHnCV8mbC5xhUSaR4m09uJ3ryw8NTb5A1S7ZlIyAf
    zwwbeyICzCgMuGtGR6L9cQsebUGGM1ArV53xusl48+T7C1Nbt9RLxQT0Al3J7dRf6iiyqL
    /G72XgQj3+/f1aV65O7hDqNT9eXZbRZxqTelNtZPL9sXgThww/84HebwqswkwgBTi8VHL0
    v0MI8TrtpinGCr7jdNlcn6f4uoff0n7uBD+xpqJMAIsylj7oZeWhQEKC4ll7vsKwhXsO+u
    2G1+qWsR66CYLxFg3m7qEJRB6LNI1TBMJymrzw0q93vy7MmZk4ZLewEArd9A
X-ME-Proxy: <xmx:l3BGalQ4kO3THBtghPQ5tfbED_ccqF2ImT3ASTf7rFy1MyrgbpHAdw>
    <xmx:l3BGagsijdjZDYrF0Cc9AzpFc-PfVip-lYVJzL-07ZzJBS2_d1Vm1A>
    <xmx:l3BGalNUV5zI9YiC2hJvzgwjfSMhQufVmbQj9Hvx4Z_5q0NQM8SKIw>
    <xmx:l3BGaqWf56AqHPkOJ948KPrIHMPankW0bxAd_G4JWGw9geUZ-6vG8Q>
    <xmx:l3BGatg4vNfQxJGuFrnQj7t3XhhztI9f-hIl3iOMpXj_Kw2xBRdY2Too>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 10:07:18 -0400 (EDT)
Date: Thu, 2 Jul 2026 15:07:17 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: seanjc@google.com, linux-kernel@vger.kernel.org, 
	Dan Williams <dan.j.williams@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/tdx: Do not print error message on non-present
 feature
Message-ID: <akZwaHqZZzES793F@thinkstation>
References: <20260702043204.81741-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702043204.81741-1-jirislaby@kernel.org>

On Thu, Jul 02, 2026 at 06:32:04AM +0200, Jiri Slaby (SUSE) wrote:
> Before commit 165e77353831 below, the kernel did not print anything when
> X86_FEATURE_TDX_HOST_PLATFORM was not present in a cpu.
> 
> After the commit, this is emitted to the log, with the error level:
> virt/tdx: TDX not supported by the host platform
> 
> This is disturbing as it is not an error running CPUs without the
> feature.
> 
> Drop the error message completely to revert to the state before
> 165e77353831.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Fixes: 165e77353831 ("KVM: x86/tdx: Do VMXON and TDX-Module initialization during subsys init")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Chao Gao <chao.gao@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
