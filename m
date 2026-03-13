Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137E2282F34;
	Fri, 13 Mar 2026 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773429069; cv=none; b=KCi8qSy3L5lfJEi1dcinQLmhyfX3oKgu8+Cn0WBDzv0sRhi44/2AJ9vQXaPNS6lf3zTf2xR7+to08BEksk2tQQ2Km2w/3llORKwnedIiq6ugu2TrNsMRvM5jdaWyIxboYjNqcvoMG90duLLrPXoUrZ+cDkanquw7fEVcGP13L2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773429069; c=relaxed/simple;
	bh=jHwuWetK3m2BYbxAmG7kFAEH8RsyaiDLLai5vsZaigc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfNpe+yNv0de6szNNfJX/KmrsZjfX9Cp44sRHRroS/9YqyLV0Eb5e5OZ1V36OtW3yk4Frbu4fNczDoZE2TwnT/xArT+2BU7Wm6LyypINzhy8Jf0L/X+LY0/9OJ28sv9zJ2SyPuzdPgvIqItvz3WlC4KczvYF3L3Cxmq6wAK8I80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Y0nTPCIj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y0nTPCIj"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E92CF40E0140;
	Fri, 13 Mar 2026 19:11:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UoV2CKrGeKUI; Fri, 13 Mar 2026 19:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1773429060; bh=nRUur658Fe9vMYVWuknz5uw26WQD/b/sR7seEcxr3rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0nTPCIjoPkIWm1o271zD7b/nk9wTdSkPZMOZDWYbV/z0tnfRbyS2vyweG2mM/msW
	 4sjbnx0RWGND7F8SfaEAN4On1FFYsI+vsEfzQy4eGTAfnLfORJfvZS5FJ54z1zoFbt
	 xVcsZeb3PnsfNg51h+1rlpRuzHbF3mvpJnJlCeCmoHHpi1b3lXrhBhJyns3e46LFRG
	 MH9wFobcyAwgdfzA92mu6HUcTG11dSDr9X/ST5SIJ1AYzPZHE28SIVt6YN4Ohq8kvW
	 Tv5PCEF1eTRMi6zIlbC2wSv03zuF61K9DkGXuVYGNv/LRyfT8J6606Dque+0M6F8Mi
	 WTkebsXfnfTu/SS+iwTL1MAqzjQ+c/eNAAz9BmXshnRDnE9Ml5GJLdLy4fNYfihrp/
	 ltB4BCBCbnRXaLFKFrHwGwKAyDGwJp4Edn7wPZO5byw+hYmzL08OiyIke3QP6fP1vY
	 CqQE8gUcGgiYTON/uxpE3OfxklETGgHejlJwSJwkm4XdfHeZPZLMpJazHUbLXAF3zs
	 IpySq6fv825xaDAAWMdXEkrLQTGwVmT2AZqosBD4nvwozuoy94oMqBSJKFGhdpsbvj
	 Rz20I8dfONTPYAbGQW7HJRiQfnL5/xMWMnSlqKtomP2Bvkw9VGveCWuHR6HZhecEDO
	 MEMzJ9LZYsiRyb9TYrERfB6w=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E6C9C40E0163;
	Fri, 13 Mar 2026 19:10:44 +0000 (UTC)
Date: Fri, 13 Mar 2026 20:10:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: "Nikunj A. Dadhania" <nikunj@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, tglx@kernel.org,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	xin@zytor.com, seanjc@google.com, pbonzini@redhat.com,
	x86@kernel.org, jon.grimm@amd.com
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
Message-ID: <20260313191037.GGabRhLc82vQZ4GltM@fat_crate.local>
References: <7ca205d6-b01b-4ed3-959d-db31a6496d79@amd.com>
 <505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
 <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
 <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
 <cb492a37-3517-4738-b435-73311402e820@intel.com>
 <ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
 <13f67190-b51c-4719-a409-13d813549d7c@intel.com>
 <1439b4f4-ff0c-4b6a-ac86-5c0da2d26cf5@amd.com>
 <dc1c5944-934d-4203-8c9c-59db802e39fa@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc1c5944-934d-4203-8c9c-59db802e39fa@intel.com>

On Fri, Mar 13, 2026 at 11:05:10AM -0700, Sohil Mehta wrote:
> There is already a lot happening in this function. If we end up going
> this route, I would suggest moving this to a small wrapper function such
> as setup_fsgsbase() or enable_fsgsbase().

For what? For a three-liner, well-separated conditional?

Not really.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
