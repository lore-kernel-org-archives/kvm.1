Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB58EADC;
	Thu, 19 Mar 2026 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948556; cv=none; b=XY39fqEC4vC3p+zsDJ5D9lHyvXuiHl/PXS5WwIUUNxsHrU3mOfmpc7ktsi8Vh8m2TZXOltys3rXWM0nv1lCB57KLJWwxYmzm8mZkt7mhnWjqhVEAOLaBtI9ZZEPBQveojKeaoJjpE9evqsZiY5BEoCW2tPyHitwYVQCUtO2EIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948556; c=relaxed/simple;
	bh=yq3zxI19tT5GteEgqQGLeJyn+K7goQZP7VpCEXx/voo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZ4FghsZfFljqC/9/Imj2RFc6YcGzG+ZZiI1uBXeSP4WywrSw8FoXsuhucaxRI6yOUMrXoQzkVnGC34qNYeWb0DZZtodUJ7L8jG3EySbpEnCE1boppLYminuQTnKWjnktmZ8zMg9hLcDsUvjQSg2mxBTDfq3Lvb6pJC+amoUzlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=mwMOI3mO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QOBRvytB; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="mwMOI3mO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QOBRvytB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2C4737A019E;
	Thu, 19 Mar 2026 15:29:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 15:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773948551;
	 x=1774034951; bh=xcFNgkGCAnWZk9DgVPl5Hi7NBgdWQbFUAL0NUxHwbVg=; b=
	mwMOI3mOcNeKMIOU8hqPIGYUy/5YQMYte3eRGaSYVpj62a8Wj9Vs0/+kPFm+c8DL
	SDJxrId4OPyvWW6PbdtCPxGOqISsQtZwtMzQNtqX2xEEgGRrxqFhY2g6vy1VYdMD
	ZXCr2Cv6yqlH4xVCW/mL85PcGeZJltW/ahXncvGLeuJQlT1BFhEcOUVYJH4uDJ5E
	jVvosit+3RLcgMOm5qdyft+1y6wXrCxtJqAEZF2xZwr5tAgUlewrzHWO70JavzS/
	tA2dy/Nb+HdL1f+SyQmoCX3EJpCMlK7Hl2PgE3eysKd92Z2k5EAe2QJWQLuwNqI0
	Esj5Hbho0d824NJEzt+pmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773948551; x=
	1774034951; bh=xcFNgkGCAnWZk9DgVPl5Hi7NBgdWQbFUAL0NUxHwbVg=; b=Q
	OBRvytBueXE+LPk59X/GxM7lzW+c2RfHC2FvXQLCgzsQCVv4XRzGMnSQoSEhD2K5
	WGcA1ingnZxDTPagt/A47RGvoWzirP19+Klg5Q3QJLB3Vi/4trbtVCMwWbfJVPLc
	e8gtRlUskgWERtPG8u3XU6/Yy4BnChaqhp4g65kUSXIpui8gKLqf54ZLVQKB3IV/
	DYW5I+pIPVyP+6zQeO578NCHFQ9qhsoYceG+JwlX/PxYxS+E1+ClpsSqu9AtRgZc
	UgJlxFlZsfoWwqcfJOQEXz4plxA2/KzvMmtjpLa6yeESCfH2rQuzi/lVS6HBkctL
	I1/6vZoFu3Dp9SmW7TD2A==
X-ME-Sender: <xms:h068aVyXXUNoGVsEHKGPoXQST-5fVNQYC7udH2sK45aSSugztEtoRA>
    <xme:h068afV582dT_SayaQGWlcYnJahMPHmI2YpS0ulyraTSAAR3MAIpu8vgz2wpiDaTw
    4EvEPmoOg2IcMSPCsnbkYismcDk3PTziECsP_UZYAvnaXOOxxzOXw>
X-ME-Received: <xmr:h068afNm81kCyShzDJRR_GfhnORhzJB2bULuVpD1VwJnRlpf7VaagAV79F0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegumh
    grthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhusghinhgusehnvhhi
    ughirgdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:h068aZAijisjkTFMTHS7_fo-zRdVpOFVQMgFsmRCveQn4LQASyfWjA>
    <xmx:h068aUfV3o6bEGlE9pjd649L1boQJzOnYzf21r9qY-vOTEuq42UDOA>
    <xmx:h068aQO326z61qhgVh4iGSE2VwmLl2qZtUtO8pbKJAXUHhjpnPDFPw>
    <xmx:h068acIs_HhbyXBDNo3PSAM_vBMIytkmkA5vhQoHI9huDizjzF9Vjw>
    <xmx:h068aQwC6wiCcrJeDKZaa5xPMh03Kn4IsqqzKVJW9raPBO_d9UYGPPxH>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 15:29:11 -0400 (EDT)
Date: Thu, 19 Mar 2026 13:29:08 -0600
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: Rubin Du <rubind@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v9 2/2] selftests/vfio: Add NVIDIA Falcon driver for DMA
 testing
Message-ID: <20260319132908.662a32bb@shazbot.org>
In-Reply-To: <abxIxa910ddkAiLm@google.com>
References: <20260317214239.124857-1-rubind@nvidia.com>
	<20260317214239.124857-3-rubind@nvidia.com>
	<abxIxa910ddkAiLm@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Mar 2026 19:04:37 +0000
David Matlack <dmatlack@google.com> wrote:

> On 2026-03-17 02:42 PM, Rubin Du wrote:
> > Add a new VFIO PCI driver for NVIDIA GPUs that enables DMA testing
> > via the Falcon (Fast Logic Controller) microcontrollers. This driver
> > extracts and adapts the DMA test functionality from the NVIDIA
> > gpu-admin-tools project and integrates it into the existing VFIO
> > selftest framework.
> > 
> > The Falcon is a general-purpose microcontroller present on NVIDIA GPUs
> > that can perform DMA operations between system memory and device memory.
> > By leveraging Falcon DMA, this driver allows NVIDIA GPUs to be tested
> > alongside Intel IOAT and DSA devices using the same selftest infrastructure.
> > 
> > Supported GPUs:
> > - Kepler: K520, GTX660, K4000, K80, GT635
> > - Maxwell Gen1: GTX750, GTX745
> > - Maxwell Gen2: M60
> > - Pascal: P100, P4, P40
> > - Volta: V100
> > - Turing: T4
> > - Ampere: A16, A100, A10
> > - Ada: L4, L40S
> > - Hopper: H100
> > 
> > The PMU falcon on Kepler and Maxwell Gen1 GPUs uses legacy FBIF register
> > offsets and requires enabling via PMC_ENABLE with the HUB bit set.
> > 
> > Limitations and tradeoffs:
> > 
> > 1. Architecture support:
> >    Blackwell and newer architectures may require additional work
> >    due to firmware.
> > 
> > 2. Synchronous DMA operations:
> >    Each transfer blocks until completion because the reference
> >    implementation does not expose command queuing - only one
> >    DMA operation can be in flight at a time.  
> 
> Asynchronous DMA will be important for testing Live Update:
> 
>   https://lore.kernel.org/kvm/20260129212510.967611-23-dmatlack@google.com/
> 
> That is why I split memcpy_start() and memcpy_wait() from the beginning.
> 
> Would it be possible to add support for it here even though it is not in
> the reference implementation?

I'll leave the can-we questions to Rubin, but do you see either the MSI
or asynchronous issues as blockers?  Currently our driver tests are
limited to a very narrow range of Intel server platforms, whereas this
is a plug'able endpoint we can install anywhere.  I'd think that's
sufficiently valuable in expanding the test base to make some
compromises.  Thanks,

Alex
