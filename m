Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9791D42D757
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638574; cv=none; b=ADY3uckCNb+SobiSE9Pbpme42MfvCkNWO8Q6D1WbzmYw6eq15IVKv35+EQMfkwwWakAzaqK0NI7TCHiSb/jzlN01xys72y6fGpyyTtuIHGmP235PQEVA8qz6juvTkhuiaADjcyZ+aC/eFv2TN2ZgRxBUsue+9f6zTHCSX74J5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638574; c=relaxed/simple;
	bh=5l+ObaOP4QFOm0AVghqnPkrFu0FKYC7oE/ZEBujSQBY=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=dG1IYngCc6ceFH/iYnOsapETW1G/8Pi4xyD9y2bRcNRRncm0tidC9Nm/7XH/GWvOXV0fDvCIGk3hUT08nxCrQiPOF8HZkSOcdidFvpdvvrsp0/qYs09ISjFPMKDJ6ltcTHuhhMDPt0TKMMCvSkAlkvSx6Iv6jaSZwSKrgZ9SAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=QjyLqLMx; arc=none smtp.client-ip=79.135.106.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="QjyLqLMx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1789638552; x=1789897752;
	bh=5l+ObaOP4QFOm0AVghqnPkrFu0FKYC7oE/ZEBujSQBY=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QjyLqLMxOc9w0qLZd1CyDkE2UDxo285E9liYJZIF/4qHOBBC31e2E9Qun0ucIjNqw
	 OlDGgeB9nHIaG/2TJ4jatp22bwtmHfrIDfgJJha5xBA6kcuoEt7hcYkCMnU2XWxvT5
	 wtq3lAp62Odm0pn4S+w7rsdEXkKpyQS75hvigp/d1xuFKPaqhuQ0NJhcygcfH6IfSk
	 dvHMA+AkAzy6Bg6AgbO8VIRWcO7oin7Xvu5iPbvNmU56cwjbzqN6AiDIyf8gk31PFp
	 H8sgSd1uYyhW0lzkBdPTziUWodLiYj2tAn21tghElcECEAUvIpTggGWNGClzVSRHH+
	 zRVOnI1b/F8EA==
Date: Thu, 17 Sep 2026 09:49:09 +0000
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
From: Johnatan Hallman <johnatan-ftm@protonmail.com>
Subject: Network issues with FreeBSD VM
Message-ID: <nhSV5WWPZu21yYrzwtqxR_EMG1J9l5d33rxbFUTyWyc4qiXXNGO6PhKaFcdtLDJyBgojUjhNF5bp0NTMdIRkXva3mHysS98HZFZmuFLrd3g=@protonmail.com>
Feedback-ID: 44492887:user:proton
X-Pm-Message-ID: 1bd315091c8fda514943ab2e5dd3811be2689d25
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey List,

Not sure if this list is still active but I try my luck.

I still using many FreeNAS 9 vms virtualized (let's not get into it why).

FreeBSD 10.3-STABLE FreeBSD 10.3-STABLE

There is a weird bug/performance issue with the virtio interface switching =
it to e1000 emulated nic improved some but still far from good.

The setup is:

Freenas9 vm -> Host latest Devuan (wireguard) -> Client (wireguard)

Running an iperf test even with the virtio interface between host and the f=
reenas guest yields 3.31 Gbit/s so that is not a bottleneck.

Running an iperf test between the physical host and the external client yie=
lds 700 mbit/s so that is not a bottleneck.

Running an iperf test from the FreeNAS guest to that wg client with the vir=
tio is 16 mbit/s tcp (MISERABLE) even with the e1000 via tcp 48 mbit/s whic=
h one can say it's an improvement but overall it's really jack s.=20

Now here comes the interesting part if I do an UDP based test between the F=
reenas and the Client I get that 700mbit/s as I should.=20

I tried to play around all shorts of sysctl values here and there but made =
no miracles. Any clue what is the issue and how to resolve it?

Thanks

John
