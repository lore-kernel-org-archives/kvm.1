Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8F83E8660;
	Fri,  8 May 2026 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271110; cv=none; b=KiJg6CMGjAzx5DS6hQqvV39JGQHl2KA3vZvVU+C6XU8VIcnz/arfEZcuVLZ5QqeKAeynimLnuspFXB27QISKmrxikzC5QfMquOJTZQhUn+g/AXpioSVRhdcgDVkgERbTIcaXwc1hMYYGAdtPcdQD/dgHwxg9X3Kl/x1fdHFKpfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271110; c=relaxed/simple;
	bh=fIIEW0/IUn/2/ctWXUpRhT3A8fBRrfiy8luOg71aJ4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsTJXG5UmhxkwzGrbKrZSmsRuHDQj76ilk7eKO4LwJpEYgkQzrRLN9ly5hmkJNhO2UuGDBa2J0s672p+RBfNp3Gi9jNtkEfCkcgx/ZhgCspFeAJPXtulV4hSX8dB/RJ7Empd3zkbbEP0Uq/tWTCOd1oJGBpNyexajMxfAZinOPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BgUSsQZ1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BgUSsQZ1"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 231D040E01A1;
	Fri,  8 May 2026 20:11:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hxj9EnbROTIS; Fri,  8 May 2026 20:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1778271089; bh=4v7UY35eRzE7KrUAOf4RCMfZPGmDgtf1RFgSpH8CwWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgUSsQZ1U2LSSLglUj11H3swb5Qjx1VXL4WahPKcowqSiE/dsQcTPKhZmoB889hqO
	 CuuAFfnIwnMV4/trq8W1yJNkRNqOgUUVAHHZDBdsD7RorTZ/nvENjyT3MxLqmysEbc
	 M8ru/1Xe83hCMHvPNMaX41BUYDQKL3OShS96rA04i9I/R4YLG6+oGVGXgDSUENMmTJ
	 dWr8EnO999DQkLdUnVUIap4p+Ki5LKcQQNTDzjKYi0gtcWHK8/8OYXx+1Pqj9/+gef
	 exfLhBynFcqWKc/RxTMZ2AwHhLUNm3CGsObwNzIvcesafDQj8z50ToG0VJWxSZh9v9
	 XqYsCVihb2cMNxVe8rnrOfNDF1XTtsDkN37081bhMECDgDIXnqigLK+o4uzsrgaFRe
	 EMC0JlMB+ToSsFROxlvjavPYHKEidO5ak3Pm/p5blOTJ2A87TAy6MIiz4NoPJUJ/DA
	 jG73Nd6Eh7DOMh2uRal1YRANjLGrBIKR2gFPfGG/VUsSxGEQkoH1aJFpIcItGT8XpB
	 66gLn1vHObxFJ7P3ivlGtObdzXE9hzLLtHbuEeokAJ5QbroLKHo344Oi6qlgBZcAue
	 132Q2D8BXRzUNuXDdZ0bkkjRZUxPe+vWP7qoECo6athVJnrUyCRFQhNj6GdyhPbkHQ
	 2diqaortuEe7Q/5I2jjCy5y4=
Received: from zn.tnic (pd953014d.dip0.t-ipconnect.de [217.83.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 69A7340E00C2;
	Fri,  8 May 2026 20:11:15 +0000 (UTC)
Date: Fri, 8 May 2026 22:11:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Kim Phillips <kim.phillips@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev, x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Naveen Rao <naveen.rao@amd.com>,
	David Kaplan <david.kaplan@amd.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH v3 0/6] KVM: SEV: Add support for IBPB-on-Entry and BTB
 Isolation
Message-ID: <20260508201057.GEaf5DUQPAbvWQPC6M@fat_crate.local>
References: <20260402202558.195005-1-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402202558.195005-1-kim.phillips@amd.com>

On Thu, Apr 02, 2026 at 03:25:52PM -0500, Kim Phillips wrote:
> IBPB-on-Entry and BTB Isolation are supplemental Spectre V2 mitigations
> available to SNP guests.

Sashiko has a bunch of comments, pls address them:

https://sashiko.dev/#/patchset/20260402202558.195005-1-kim.phillips%40amd.com

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
