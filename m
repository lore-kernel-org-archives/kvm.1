Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB663EF641;
	Tue, 17 Mar 2026 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766522; cv=none; b=YvHu2g8b7pEsNsyi55L5/k9kXztosUDY6mY8seOkuW3lS/ZBwlN0kq3JrYUgOC42CWf1nrnVZpmcn1l2kep3GFS3jlon7aD+PRfDqcU00stvb/RLbKQyUHsTi/wfrqH4j779sZ6c12uGqY0MaTPXdsrldE2Ki67Pg5ZIQhy24ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766522; c=relaxed/simple;
	bh=Ub9ImilSuugFXyBTyI6Mu4PjXKbV/2wt6hGDyCbuTec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFo5fZYXXwtcvBYE6bvWso/sTpTVOJo4L5e2kWnSjyLc2fpcbVpOStAd8LEOYYmUBl212ARdREtAyaIgZ+CgLT2jIZhQtr06+XRkCS1aENFqLIB3DhS+D9w1YvO6D+eg6wXFn3a227pRUUMyKzNlhocMe+EgTGaju9H8P1BEDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NJK+uk2X; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NJK+uk2X"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F24B240E0223;
	Tue, 17 Mar 2026 16:55:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UE-DsSD1wM9b; Tue, 17 Mar 2026 16:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1773766513; bh=5p1mrgf1+J/PUxuFux+1/oxkPi3kjUj/sS4CFTlOodo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJK+uk2X3vh+GKP1itlbHGlGi9CBDHqhLP/rt0Eg86lQGTfVeD1fBgClRVqtAqJF4
	 t1T/aQocBli9uLaKwKhn3HP1MN1bqyEM3cpvLz8Atmh2/cw5g0rxCGFwZvG54T9GZL
	 Eyw3Du48JQxupJXE1/dVnJLuLdR/UYMi40ZTQCGnniYyel+FfFw5Br45I1bPuxQB4i
	 zqJsd5c7WbWUXzkyOKJ64JhUsarQ4eWgQ3KYDuvp7b7SBmVZs7EiDln9Z4znCm9+dO
	 Z8GyTGgbflLfFY93eJy8Sr1gc0RLmxpOvP0Wo0w67CAwALeZdlMwBeKmIYrPYpMGWJ
	 Lxt0szA3fJPnwYn0wUbaHU+8ZlHyIfe8S5nN1J6rPk8Wb1lACGdD+x7ZEL7SbthWxE
	 JrsEpVt5gfkPWrl0Sns4ZYku4ivedOef22s+Dk01PloiD2oCkn/7+3fbKUUXN8eIQ+
	 S3lTXX5cQaNJI76vY4t4HRzfAYO4Z85bzU0YWB/MpjCUY5YNABhpfL3dW7MuwWtFLs
	 gKbjbaEeyrEzo63u5usjy+nn/pK5VOgGTT7+sx29++B9P0WubFTgGtYOjs7q3HgXOQ
	 PPhj9pusdj4t5nzJqezym1iReVYkruUvbb4rj600X34tk5shaP9iAvnN9eFNwRzyJj
	 i613NrWOoAy0npPD4Q3sfW0E=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4732040E0163;
	Tue, 17 Mar 2026 16:54:57 +0000 (UTC)
Date: Tue, 17 Mar 2026 17:54:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Nikunj A. Dadhania" <nikunj@amd.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, tglx@kernel.org,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	xin@zytor.com, seanjc@google.com, pbonzini@redhat.com,
	x86@kernel.org, sohil.mehta@intel.com, jon.grimm@amd.com
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
Message-ID: <20260317165451.GCabmHWxU5MaMXthDS@fat_crate.local>
References: <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
 <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
 <cb492a37-3517-4738-b435-73311402e820@intel.com>
 <ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
 <ab5bf7bb-6511-49dc-a65d-86911e0f7091@intel.com>
 <c13736a1-3151-476b-a91c-035383d2a29e@intel.com>
 <541cddbb-22b3-4865-a374-49ba3ba48a5e@intel.com>
 <2b33bf8e-5f19-46c7-b1eb-89fcf74d74f8@amd.com>
 <515d2fbc-f771-4aed-8706-e8ed20d3dbc6@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <515d2fbc-f771-4aed-8706-e8ed20d3dbc6@intel.com>

On Tue, Mar 17, 2026 at 08:31:06AM -0700, Dave Hansen wrote:
> Please resend this with a full changelog and so forth, and I think we can
> move forward with it.

Patch works on 3 machines here, should be good. I'll queue the two once I have
them and we can hammer on them some more.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
