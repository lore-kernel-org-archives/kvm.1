Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890723;
	b=odyHJ2APMj684xYdBgTAb7DkB2VJRc3npb3UbcpEdwDk6UDmbhguSFBHOj+R0MVDLIKE
	 jpcP8xhZdPa5io7Z1EYO2cq6qr/eGRhWNfXOzQmI6irzzSuabNIMvXw5eRwkj4YaXlqzB
	 PA+lWGmaOjJ81TCQBMl+2sjwhpfF5sGy46GDGot9DBtvm5d/xuun6UGzy4BQRwmUIWql9
	 EX/JZ/2itv5L56pJnE+oh3XD0gLO2x3/3pmpg87+ke7dlpmrfqmSJoG7U8dl8DIrFmG/I
	 G05ImYZU/Z4RrUFpl/40Ogai2W4oEXdm7hSfa0AHwgTUoyiI65FPc040isT5MQuXK0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890723;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=YkeHMNN6y1G7/zXanJ/Atw+CKT/AoijUs//DrchVQLI=;
	b=n2J8wHTNm9Ho+hhXOavomPzeR+SuZBpEe0Cunbs2slfkAQNzJZnyNeRTfluR4O/KrYrl
	 UZgkw+47k7/Hats6lOCUJTrO0uPh+B7vWdi5BN3uT4tTG6KOGLF0WTEKittm/G4is//S5
	 Uaq3jcT0SFuIKP80HuhMVHd1uHvNVkBHY8YRiIqWCcgaq/6z7d/4fIgx5ZPFk/xSlIW8s
	 lO0JJwbrdidTdgKRckNrRxjL1kW02ti3OpQ6aGSP+PsmNLak1XNK2CbZbb+0fTLuI5nWL
	 4cXQCh7rZtpw8OdtMP4kf1I4/BBOQI5lOdpvEFZegqxHLwqq1gzWzgS8i8C29e0LElA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRu0mLh+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A627606D82A
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRu0mLh+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AC31F00A02;
	Thu,  5 Nov 2026 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890722;
	bh=YkeHMNN6y1G7/zXanJ/Atw+CKT/AoijUs//DrchVQLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MRu0mLh+fr2178t2C2nFYeb4n3loY/6Eqd4vejbNcqkQ6xZxdBsffyVLRwV3wUYhi
	 +htA+9GuJPqLNybLbCwofBJiiZmPW8HkZ3e/YiY/L32y7EyZavq3enDMTwwxxQRZHf
	 gJeFrs5Kj/dQQAYgztbikAee4K2UfJzGch5B25H+KDZMywFe9Ah+6sWS3No6F23v5Z
	 ur5kAjgW3uCVyBCis98MGm+UxcJf2jkLd2JLzNCRRf3Av7dV32UHEgzoDeTw2K2R2k
	 CySE2MTIUhBFGiqunvJbNBRwBPxxQJ50cuVECLlbJGXncbadOde/8WiNmWE4sVjwQs
	 LHYDlkHjBZsAQ==
Date: Thu, 5 Nov 2026 08:58:36 -0600
From: "Serge Hallyn (AMD)" <sergeh@kernel.org>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Peter Xu <peterx@redhat.com>,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Kishen Maloor <kishen.maloor@intel.com>, kvm@vger.kernel.org,
	David.Kaplan@amd.com, Mathias.Brossard@arm.com
Subject: Re: TDX migration model
Message-ID: <auyZnIfxMnxYD8rT@shallyn-amd>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f4f34bc3dd22c0e47b5ee764b1a4db8940cbbbec.camel@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4f34bc3dd22c0e47b5ee764b1a4db8940cbbbec.camel@gmail.com>

On Wed, Nov 04, 2026 at 03:51:45PM +0200, Artem Bityutskiy wrote:
> Hi Peter, community,
> 
> Here is the TDX migration model doc that I mentioned in the CoCo migration
> uAPI thread:
> 
> https://github.com/dedekind/dedekind-share/blob/master/2026/tdx-live-migration.md
> 
> The doc focuses on TDX only. It does not cover CoCo in general or
> Linux/KVM. 
> 
> The goal is to lay out what the TDX module offers in terms of ABI and
> migration flow today. Hopefully it is easier to read than the TDX specs,
> which are much more detailed. Feedback is very welcome.
> 
> The uAPIs that we suggested were modeled around this flow and ABI. But
> we kept general CoCo VMs in mind as much as we could.
> 
> The TDX live migration PoC implementation that we mentioned earlier follows
> the flows and uses the ABIs described in the doc.
> 
> Thanks!
> 
> P.S. From the ARM talk and hallway conversations at Plumbers, I understood
> that the ARM live migration flow is very similar to TDX. For SNP guests, we
> have not heard enough yet.
> 
> Thanks,
> Artem.

Thanks, Artem!

So, looking at the section '### How the Setup Session Works', is it safe
to assume that you are using the qemu migration fd for the message
transfers?  So basically qemu loops over KVM_MIGRATE_SETUP calls, which
is directed to platform-specific handlers, which in the tdx case calls
TDH.MIG.SETUP, and this loop continues until TDX_SUCCESS?  If so, great,
that mirrors pretty exactly what we were looking at for SNP.

thanks,
-serge
