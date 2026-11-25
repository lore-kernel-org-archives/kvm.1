Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641682;
	b=xmIjIDXUIC44dV4cSebeRpRIJ1B4u3FSfXm5eftT+ysLuPXR93b76nQVdyvMqrNkgBHf
	 Dx4IcY3UDrQwXVcon2otwNBYdB4MxT0NTKAEFEhrlMTXqFYBejkRe9/nfZCtwD3QKGo7r
	 W2jaPTQpGzdMcm+QwnHAI/ThU4v5uZhst4J35eTy7DWXaw9MbH0EkmfWRJ442p6hOIkSg
	 C1QdvIMJAMCoGHcL5ed+Xu5ZvIVrlAIYn9n+TWEJcGWjijt30xDDTh9gL4iHxeXe9fhWV
	 UhxkbdiMcqVE/7tEYpDpPZbmcVDyAgkTHkqc85Z3MoW7Q+xj34PdeMp0wxsey4IcqfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641682;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=vfLZQumhvisvpmzurTjKPkeiD17r56G5HfxylZWgS5c=;
	b=mdedN2X2OIRplnTfO64RvSWJijawTrSw6jElGe7LG+ocRVsja1sNd+UoxcuTrcqiZ1wn
	 xrSH9qlQA5Ey9M1zCIyJLFKP1s5/DF83vgnU5GRWFRoL8ak+LtFB/4wMQeY6gORvqPujo
	 YJFleVXOKI1De5/AE2v7HQzjqkjx20qcNAG4RT3tc5EDh9LTLSJ8JlN0S1r5MeOcQu5Tb
	 /SaMQ+wkZ+6nZvykKYFriSrSBsgiVugGDZMAqBV+jgUCA4q98X+iGV25rJPDS5FmjNpZG
	 HLKeXUpQE0S6+4pTq9zpqcYFrOagwGFzJugMP+ZCvGsB0hDYGB+FKjeXCd+UgcWrvhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b="K6HH/md3";
	arc=none smtp.remote-ip=109.224.244.20
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DBE606A323;
	Wed, 25 Nov 2026 21:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0DBE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=K6HH/md3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1795641671; x=1795900871;
	bh=vfLZQumhvisvpmzurTjKPkeiD17r56G5HfxylZWgS5c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=K6HH/md3pBKFeCn6smvdxo3PrAftyS8IW5f6xh7qv2uIyYwqd0JUpPVm+2xPbYHM6
	 Qt4RHM9I1ScB7leWfeEwOKuycQI14m1Yu27mEK32Pwav3AvcUs/F4gOiv8qf16nDYT
	 gV9QP4ML4lQI3mOQoHb4nLKK4SydwrwztGVv3R6P4/cbx+w8hpdEnDe2TURO5ESzXl
	 Ug7mnZv6y4G0sb0p9JoiOTLBP6e9CH3eI5c4IGE4L+pEwdlgGruVSx1yRIC3r0XC0Y
	 RIsWJOZv9uQomc20hXludvz8FgWNuU852aG+w/saQZVLOh7zl1hzkkOzTLO8UjcAF7
	 F26BT1Tv0vmAQ==
Date: Wed, 25 Nov 2026 21:21:01 +0000
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: "chenglong.ma" <longpareto@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 2312891301@qq.com, blum@kernel.org, co+6dcbccedc9ec6452@bugs.sh, eperezma@redhat.com, fangxy@xiaopeng.com, jasowangio@gmail.com, kmehltretter@gmail.com, linfeng.sun.dev@gmail.com, lirongqing@baidu.com, oss.patchbox@gmail.com, phx0fer@gmail.com, physicalmtea@gmail.com, sergiiushakov@google.com, shubham@octane.security, stable@vger.kernel.org, stjepan.poljak@gmail.com, syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com, tavhadia@gmail.com, tjdqudcks0424@naver.com, tz2294@columbia.edu, xieyongji@bytedance.com, xmei5@asu.edu, yuz08559@gmail.com, zenghui.yu@linux.dev, zhaimingbing@cmss.chinamobile.com, zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
Message-ID: <s1xGKGqyb3Uk_gDZmeWG7nVEq4_m00HsO9pS1RL3cUnIdr4GMgH5OEBifQIl-30ZdUu7_uUoe-TxhMQd2GuW2sWKzY6UUGSWXKaqMz_XeEE=@1g4.org>
In-Reply-To: <awbTgufgR4Uge1kJ@gremlin>
References: <20261104081535-mutt-send-email-mst@kernel.org> <awWOpS3HR_2FTN3I@gremlin> <20261125060533.1296-1-longpareto@gmail.com> <awbTgufgR4Uge1kJ@gremlin>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 4a2ea5626cc74c6da271abf63e2ead6a3c9e8c0a
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

There appears to be a recurring problem with how previously reported=20
vulnerabilities are being handled in this subsystem.

Yu Zhang publicly reported the VDUSE VA/PA confusion on August 7,=20
including runtime evidence and a proposed fix:

https://lore.kernel.org/r/20260807022657.11318-1-yuz08559@gmail.com

Nearly three months later, bb2e6f166547 was merged with attribution to=20
Claude Code, but without any acknowledgment of Yu's earlier report. As=20
Lorenzo has now pointed out, the accepted patch also breaks the driver's=20
mmap path.

This is particularly concerning given my own experience with the vDPA=20
netlink double-free.

I reported the issue in March, submitted a patch at your request, provided=
=20
runtime evidence, and received repeated assurances that my patch would be=
=20
applied. Nearly eight months later, a different Claude-assisted implementat=
ion=20
was merged instead after I reported it to security list a second time.

I acknowledge that I eventually received a Reported-by tag. That does not e=
xplain=20
why a known and acknowledged memory-safety defect remained unfixed for near=
ly eight=20
months.

I have no objection to the use of AI-assisted development. I do object to a=
 process=20
in which previously submitted security fixes remain unresolved for months, =
only to=20
be replaced by AI-assisted implementations, particularly when those impleme=
ntations=20
introduce regressions that basic functional testing would have caught.

Why was Yu Zhang's earlier report not acknowledged?

And what is being done to ensure that previously reported vulnerabilities a=
re not left=20
unresolved until they are rediscovered?

Thanks,
Paul
