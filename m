Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2325391847;
	Sat, 21 Mar 2026 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774107762; cv=none; b=PoNUKO0YMjESPRpj8vjQzr/svuPZcYTMRzv6HvbossA+iigaSjatTuwlIrpKuOtnMeMVQ8U9dP6mpmmbh4bLI/O+DZioxjmngfbotbs6pObcGjtFngA8nwfUEWUKeK74EPoL/rUnO+hMAeGOFLsDeYBOyW3PWAA38BDO/AAcEQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774107762; c=relaxed/simple;
	bh=qTpKfeN5FoYRfGDiyq0+egDm9wZakQ443ww4cFVtLUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILDAZ6rz+eb3ZbpCW6mhIJmh7OprZpAOkPMDXyViusAYd4MqGGzwy3J0J4EmJvlzozot/zUlaGuJkzkAy6lDDDdmNRLcwySWsgP20XATWfcw352+UkdsPyvDznFpXJ2JZbKykRN6qTcqYTd3d1TyFRFATOhNHB+BX8Y3rGcuKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=etlv104c; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="etlv104c"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B550540E0294;
	Sat, 21 Mar 2026 15:42:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PNDOXsMLGCtO; Sat, 21 Mar 2026 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774107753; bh=xCz79W6yBDYuB3yAfYjv6+yE163LgjeUZFJjvnSRFe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=etlv104c9qfYUj2MWtT3v6v8/C15roIA9SDpqar9I7ON9RTtIV0/FszlT0umswrxk
	 8aWL4hVPvaom29gKYaTIKR1YBM9drE60JlrsqgO4ZhZn/8KpKg+Q2EbNB/ge9eyjhx
	 KyAhcV3tiffPa+7nc23GojQUK4E+9sFNu4Gnl1/mbNFhClgj3PrKxCGD/OQe32cnne
	 zTA0vODAWi58xpQ+U5VJfOLZ8kT/A4urVfqNM1eh8T98ge3gasSwws+LoHtt8KbR8o
	 /qfFuxlXXk/3EJpFhwxUIz8C3ZL0zIBlXfRT4AHzvG0LW8Zl3XjoDlmYHfC9DYEqG+
	 9dVn1t6V59e7b3Y9EGBWxb1xNbkb92qrDWdSLqYTc6VOYZek7PmzQZtcTIon/u0zQP
	 gQbJO6npSexLIVz7A9HyS4l53fr3+Rg4YXKGKBow2Diz5CKhbgwA+rBi091gsLaxy3
	 EqFmF05j03xvTfvI1KwzBBvHvijqEFy0MKn+Pfjxivou51tUPNLpSuuJy/C3BGnVKm
	 EpnlQerdUJ5PRVNour9eJDw6Pj8iNO0A9C+hw8MoKkCng0Ma90GcMqnUSHVZdiIjap
	 vdullciujZB5XKb2X24VDtmS2xQQuKAaIpphoXn1U74HUNIsa9BKMMHdotDHVMWkHZ
	 RdqCGhe6cVg1cagCngTOFmsU=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9E8EA40E019D;
	Sat, 21 Mar 2026 15:42:25 +0000 (UTC)
Date: Sat, 21 Mar 2026 16:42:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Jon Kohler <jon@nutanix.com>, Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 18/22] KVM: SVM: add GMET bit definitions
Message-ID: <20260321154219.GEab68W-ln67dqTB5x@fat_crate.local>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
 <20260321000931.1947084-19-pbonzini@redhat.com>
 <20260321115826.GCab6H4lNYIih_g0B0@fat_crate.local>
 <CABgObfbGxJYO0iXvkduFR=q=gyoF819pwkgJSke7SLr+6zCVZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfbGxJYO0iXvkduFR=q=gyoF819pwkgJSke7SLr+6zCVZg@mail.gmail.com>

On Sat, Mar 21, 2026 at 02:51:47PM +0100, Paolo Bonzini wrote:
> I prefer to be consistent with all the other ones in word 15.

Sorry, no, /proc/cpuinfo is an ABI.

See Documentation/arch/x86/cpuinfo.rst

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
