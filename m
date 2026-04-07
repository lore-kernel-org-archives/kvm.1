Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70AFAD24;
	Tue,  7 Apr 2026 04:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775534418; cv=none; b=qE/wdVBQqQgaGGIhZmdfxfJxZyoOwPwllVqm8ZAvRBOFR5EAOcM8zcNM9ONg/76awua+FbkTrPBxJp7l1DVfR2OBobTwtGAFCB8sMj36q5nFGLUZhgKv65nxi6s0h3RhQCON8ZLa9T3ctfa0IliV1f6bj9P11Wy51a58x4bAOX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775534418; c=relaxed/simple;
	bh=GQx+hMgIqr7zA0+94AfeG+wbZFoob6PPhQFR+EHxqf8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BX4k2SaxkB4Syj7wi/Tael47W6tSegE36kepwPEV8YVoebDWBBqYcX/5cyZm3iYO53ueLQq4IAHuyGSbHWXw4hElz4OH9EwpYzcZNC767xABIpXthOi8AO1UFAT5MqiZq/5rSEX4Jpa02YDNRQq4Ijabp22NJSHseSSBnV7EvuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=DadhnSCS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ft/SOoRX; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="DadhnSCS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ft/SOoRX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C3470EC0423;
	Tue,  7 Apr 2026 00:00:13 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-02.internal (MEProxy); Tue, 07 Apr 2026 00:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775534413;
	 x=1775620813; bh=aatV8V+k0LQ4Vc7bOA3guzQZA13EdGjIujosVzaGGWE=; b=
	DadhnSCSGXq/BZK3E6cEe47COrg+ufOI7RuBdbektLYtL5CPkuJrRIc5cPUjmXuR
	GkYEd4XUBoaVarEqSO47ZnF3KxsWhElwoKWBSORzmg6mlExXbnyzKDoZ36oBK4gU
	szDwgqITLe7xpNr/q0biUpCailj2oMpmIyq9uCzx/4M7/bznpn0uBpiEVk4FGO4v
	+OiLMtU1pArl5D7bWYNthYxT3/Z+QreLPeOuNfeuwPEzmIswA1oXdciZtziVueDZ
	n4zoYDhCMkejrypMjqLRfzwVa6uP3Vt4/FaQFwjxKvUYfJuUXBLgm2W5xnFb7XUT
	r24gehyYv9FePOzdR0Gj5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775534413; x=
	1775620813; bh=aatV8V+k0LQ4Vc7bOA3guzQZA13EdGjIujosVzaGGWE=; b=f
	t/SOoRXylqLIbC/0FBd5MS0VJC5+JDLlrLfbeAy4WqlgECoBiXYfpPA3XSEvnTNC
	phIOivt8wX1EM1JvPs06wD8v2zWilJBaon5h01Z+ZYuGZBPy4QdZRlywib9w7rW/
	2RnJR6lmF93mrpF0ni+cfHdgAHnbE2gmRk7ewCN+CJWvCdkkp+3pBuDsvLHBo7A7
	qOo1E14ZB6jQVC8JrY7Zoqg/YQ/zvz172XYiK+WCIrOxfrHPx3/4kOWAi0A0IKbs
	UuW+PBYP6+ocWPMgPkbn5NBWCsbh4TTwq/Z32H9yOoEu8zE9Q/hJupSPuKkWeeCD
	sENea50stxAkCx9tlVEIQ==
X-ME-Sender: <xms:TYHUaWbfwVo6SrbWFkH00Uans0c_NR_ovvZNVZVbYaFO2JWGXeddAA>
    <xme:TYHUaUOW2BSb0TGX8wQ1FAlioZwhPzRF7GYf5NOiUAMx3gWJIV9YWwW_eXM5SWPZo
    kQ7Kwv2o2mnyu6lUjjfmvjSw-Kxq3yWMZ2tvwPZwaJ4E2672eBaHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduleeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetlhgvgicu
    hghilhhlihgrmhhsohhnfdcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrf
    grthhtvghrnhepgfeffeelgffgffevffetteeivdettdfgvdeiveefjeeffeffveetjeet
    udffgfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepjhhrhhhilhhkvgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgr
    nhgrnhhtrgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvhhiphhinhhshhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjghhgseiiihgvphgvrdgtrg
X-ME-Proxy: <xmx:TYHUaUCyRp4fwBeM2EPqBJH7SmFtCXZocGXeWs8xxnTz9letjH-M0A>
    <xmx:TYHUaQnFjA2wPiscsLmTc7AAkgj7GYS-nA-TW8XfzwLNHsp1GNQgyw>
    <xmx:TYHUaXdWHCRiLP16Q22LdaDXb_6s0qTlrtpiXPLDITHAxo78L0lpKw>
    <xmx:TYHUacS13EsWzt9MeMHfr8fJ7l2vENxpNHQoVs4qNMQ6mC8HjhFEWw>
    <xmx:TYHUaSoRx29_e6KKHLBmbDm7KSRONv9fWzX91omQLVfjWpHUhkfORuUe>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6883515C008C; Tue,  7 Apr 2026 00:00:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-IOGym1Ug17
Date: Mon, 06 Apr 2026 21:59:53 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Raghavendra Rao Ananta" <rananta@google.com>
Cc: "David Matlack" <dmatlack@google.com>,
 "Vipin Sharma" <vipinsh@google.com>, "Josh Hilke" <jrhilke@google.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Message-Id: <9eea53cd-77a7-474c-a552-92f3531f13b3@app.fastmail.com>
In-Reply-To: <20260406223428.GK2551565@ziepe.ca>
References: 
 <CAJHc60zTBn9xMksi-_UBK=W07rp2vGVZ9ToYhFyadNz4zCVHAA@mail.gmail.com>
 <20260406223428.GK2551565@ziepe.ca>
Subject: Re: [RFC] Observed lockdep circular dependency in SR-IOV paths
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Apr 6, 2026, at 4:34 PM, Jason Gunthorpe wrote:
> On Tue, Mar 31, 2026 at 10:23:06AM -0700, Raghavendra Rao Ananta wrote:
>> Hi Alex,
>> 
>> While running the vfio_pci_sriov_uapi_test [1] on a CONFIG_LOCKDEP
>> enabled kernel (7.0-rc1), we observed the following lockdep circular
>> locking dependency warning:
>
> This loos more like a class issue, the locks used by the VF driver are
> different than the locks used by the PF driver, and even though the
> devsets are shared a devset should never have both the PF and VF.
>
> Maybe shifting memory_lock into a different lock class for VFs is
> enough.
>
> However, I think it is a bad idea to hold the memory_lock while
> probing a device, I'd prefer to revisit f4162eb1e2fc ("vfio/pci:
> Change the PF power state to D0 before enabling VFs") and change it's
> logic to rely on a private flag instead of pci_num_vf()
>
> Then we don't need to hold the lock any longer than just setting the
> flag.

I agree, that's cleaner, only hold the write-lock on memory_lock in vfio_pci_core_sriov_configure() to bring the device to D0 and to set a flag on the PF vdev.  That flag would replace the pci_num_vfs() test in vfio_pci_set_power_state().  The flag is cleared without memory_lock if pci_enable_sriov() fails or after pci_disable_sriov().

It's a nice compartmentalized fix.  The lockdep splat is a false positive, but this would eliminate the memory_lock -> work_completion arc of the detection.  Thanks,

Alex
