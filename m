Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA453AE707;
	Fri, 25 Sep 2026 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354910; cv=none; b=A1E1YltgFQtZCTWa+WuOrXdKJuQzkeOeUbNAvxnJ+Y0yU7N8PVae34hiCgCCd+qb8IU2tbn7z7UKljaNdLblzUSMTp/DrFWABs9+P0PJGHsKoYmBfwQVmpblNRVD1E2n8O/iAyGO8N5egqLiiPdjCcqUsAPBXfvyfsJ5+r5QnXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354910; c=relaxed/simple;
	bh=e4bNro2X21tF+YZ1/Bwbzw8T1iQC6aqrOuNMIg8HB/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVcsR9Rk0ZhjMSKmAltg7MwzliyMv9i+CbVM1k/6HC/A0F7VsYKIESvVtnwaiUaChffR0JooohAb6xJ6+wvLdH1PNpva2Aa+BkkWpgQ2BSOInu/q399be0OYnOqjiS/SvMNvjiRCaUXI52POA9xXtcH1zspBlEV9zHJ0VE7YGRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=X7vs4Ffl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="X7vs4Ffl"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1BDD840E015D;
	Fri, 25 Sep 2026 16:48:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pTpcwLsaCmSk; Fri, 25 Sep 2026 16:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790354888; bh=yV5eIZXRVx/VnMpigs9MBnv0ybrd5AqZPTL7Q5MFX2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7vs4FflKGPKZRodhKoU7LLoOQvO+6/Ou4pCRmKVK3dv85bhLQe03Fajt1qX2GjFA
	 ZjvsKllDT73HGncSmZEcT1aDol7fkeLUgvmmR54V5+J5ExzdraIPJl2QTLkX8xSpNC
	 YtZanZXV4q0UXfW2WnWH8srD0h3YOduqCq1RKarcSmqBkruPSHLawHphi+h2J8pCpw
	 EXFXFBEvWnjiuMaGEBeRXiuo0cembBzmpKltZk3ykoGteDZLOnxBGEMKSlNdX5387o
	 WfGKEbNGIkgjfeog8Ztm37eu6NFLLsVObNP8QpSZuO+fguQA+DnyWjG6lGL5yvwFYH
	 +CB1UPkO+LC8/kNcUFBgT+TpUDB4DPdj0afh7NCIfozvJkMtfkEGT8czRSeeFSpK9G
	 R5MvrubhCUUC4pArOe7iSVuGoqrLAn+BVSuSIra89ez3yXtryiMIESuEsoNYSJlM62
	 jRAUKA4OhG59pUMA2Ch5GJx2xC0swKzattiQjkYdUFX28yvDeAkuxcCiCiVAdswYmO
	 5/mH15VVCcGKKsL29VvKbhW8t0eZVcq20Pweu7y8BQWPeSTCTxcA2R+OzsGtEMDwdq
	 wAwAKGXgnGAYjBmCwmz5JwboV3P+ovEAk27XvXeyehkRs3dPzVmRmbgvm+id2kQJTg
	 tHxMCcneEdZdaOn4iGbZQjTU=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 78B2240E00E7;
	Fri, 25 Sep 2026 16:47:51 +0000 (UTC)
Date: Fri, 25 Sep 2026 09:47:48 -0700
From: Borislav Petkov <bp@alien8.de>
To: Kim Phillips <kim.phillips@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Naveen Rao <naveen.rao@amd.com>,
	David Kaplan <david.kaplan@amd.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nathan Fontenot <nathan.fontenot@amd.com>
Subject: Re: [PATCH v5 1/8] x86/bugs: Allow forcing Automatic IBRS with SNP
 active using spectre_v2=eibrs
Message-ID: <20260925164748.GAaraltFwtJs59WAsj@fat_crate.local>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
 <20260826223510.3669875-2-kim.phillips@amd.com>
 <20260903040330.GNapjxkgMd2Ey38egR@fat_crate.local>
 <01b57e61-df45-44a6-848b-c19eae226ad0@amd.com>
 <20260924014517.GEarSArVM12m_ZshhA@fat_crate.local>
 <67fb182c-4baa-4b3e-b59c-64cec20839c2@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67fb182c-4baa-4b3e-b59c-64cec20839c2@amd.com>

On Thu, Sep 24, 2026 at 01:45:52PM -0500, Kim Phillips wrote:
> For a guest-dominated host that trade plausibly goes the other way, and only
> the admin knows their deployment.

Just holding down the current arguments here *without* AI:

We have had an internal discussion in the past about this already. It can
potentially cause performance disadvantages in certain scenarios.

If this is ever going to go anywhere, I would like to see:

- a proper use case which people are *actually* asking for

- have it properly documented in Documentation/admin-guide/hw-vuln/ along with
  the potential impact so that people can make an *informed* decision whether
  they really want it

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
