Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377052;
	b=yo7N3MiXz4BIc5WY8oHAXyIUwtafVln4Z+Ha/iiPR1ySY4r1Xch2MZjUIsyQIZgxMMhN
	 JBGTwBslKQ6OWyuXfo4g2dPsZOeVoFcy10o6O6DvvZFWT6GLosSEs0mmRoZP81NutrXQM
	 MvIvYb1hsj6+oaoaeV4kyHX9R4Q+bQeI+tH6HyCg8vokHLHGCfPOIWOi0JlYK8XtW0Uiq
	 hGiAg8kxw6b3DKMqXYmSyzfSRE+Zy7AuKV7Jk59gtPc28zlwB5C1r/h7zbeqAH08Kr/MF
	 V85fcWidaCtNEmngVT/llzh0R7ijk9Y+sKIV94MB0/3MYXnaZc3ZlsSKSy+TWmqN7Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377052;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2uOq10yMMLhle29ctikza3QlQPUgCB7HGNNZNg8weIk=;
	b=jEmQchKVaeqqA9GAOkbpy0bOecY2uUFEsnUJuAOlZB5z2YAwea4GNmlOqLYXFoCwTYTh
	 nNjYys2eZVGAquw5c1fDXNEJJ0d2T+JJ7a0nPuFLVv5iaqkJBeeuzS5xS49IAf3Kadoza
	 W7FeFDkEYaAQaurDD9s8mLwxwooR66Wrd3GWybk/r/rKkviuzIz7IWtLdMyIbPMtv8v03
	 fE0eY9i0HrbLVNZRsmiqbgJjt8v+46gB//bpMVdT8WHmf5VTZqsMG93ja1E5N2AzERbRr
	 NFJbGUMz2IrPEgP+4EUXk+drgVrXoTQR3pqr9k07+yTt1jgtrdLUhLisd5sQDuCYemw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=DVPZJPam;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nyT58qKv;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232B606A31A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 16:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3232B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=DVPZJPam;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nyT58qKv
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 562D51D00095
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 12:17:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 30 Oct 2026 12:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793377049;
	 x=1793463449; bh=2uOq10yMMLhle29ctikza3QlQPUgCB7HGNNZNg8weIk=; b=
	DVPZJPamzhe2ZLjftDx+4SqbVWJb6A7JjsADMVlzlJoqeYNU/saNCKQIu+TH3u05
	c1/qzMjcQ6tcQ64sup/7+K6coMh58pcGGrhaNd0VS6nHw47CpCMSq+PU8G+ZTLwS
	zTVgcQPPNkmZZkGWkJW60iE2BaCImN8jj+VDvbIvnbWU7bMjzajsMklAh2LfLqpU
	91DiwEwHv0O7NhE0z2wu1TuCNeoYKW02cHA6j6PtYd9yOt6Wuf844Kv5iN2WgNK6
	fewmV3YiGQ0hP9OZG6CCmv6Hqhwv6LUT/mWj6OslmM3sDYt2KHtVHFfSmtBdjylp
	eZ2tBltswQTBLq64Oidmqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793377049; x=
	1793463449; bh=2uOq10yMMLhle29ctikza3QlQPUgCB7HGNNZNg8weIk=; b=n
	yT58qKvBQJuFZ23t5KFSmqQJel91i4tWtwWrjwN42xNoxZKlM+otoRcIgGgjaQTm
	vuxtUCAuhAi3XlRViuyjpONRdDwAxjN44lsJl/TaWEWjvFX2RYoZUAmSSqHNfvTm
	KwRmSX+kcAaZjLI/gK7AldFSvNfA7l7V4wSUk9DiVG5ndVrcx9nlTZDi4KgujR4y
	eEIM8qS64kdxUxWjDwFE8lXbSDl/XC0jZecSPDqQGdYiWHC4z2vx+c8a4/365kjU
	PM8BbL5UumS5miqpo+pjmgxEs5vsjvMsmgaVINoo6GWsaX3ZdQHcD5/AsE99ujAO
	B46I0fwIBPZji92xdzxew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793377049; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:tvgE02Zvk3jf+Q0JHB31jX1lXL7i/OVJb/MVoHW0fBFLbbX
	nfRphWHffrpjgSuO2Nkru/sTm9kpxLXjkrBRXFfP3g9biBGMT9Mfv8an6oiO8Lgg
	jfh0Z4gSOuZALINbxKhlxapnb7PhEhtDDY6pLnDf5pBLd4CavCQEWlc8wxK1nxzc
	eqo4qz98Y3HaMNPwx1erufhCSG2KTD9zC9AS1kaK0j7ozTfEBja2I2Qa5DTSB07l
	DIUwOzBLiDyJkFN3uCi3Z5LodKULgJcCfpGN5WykYgWIEWy65La1hydKdsPuX5c7
	2upsloq4M2+x7QvdVrr0zzWbchR1FkCbXzkWGrA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tRrZfRtIza3+gJUWxsd9mYE5BvvNH22G//9Zy3FVyCw=:hRD2H4pExrLt9ycKVLu1nKhPqy4cDLyP7T/BftbSfd8=;
X-ME-Sender: <xms:GcPkaoFFFbREG2jZLaIBpBVOvbFxUdMzDtr7wxJ-nWaimUjzyn629Q>
    <xme:GcPkaoU-mx28Y260EbkJzB2fvaGntuC-kj9bCoWRuXmeaSS1tNJXkDWZ_qWzU8l08
    bcXI3tI_3mhInf7F36pqnry_D_w9xNtcnDKD12Bi7aislTPGt-zuPA>
X-ME-Received: <xmr:GcPkanIqy3tGDHVBFgROVURs9EfHBBRRvSmeEvIh44xj98aPUR2bnQOlaAIL1A>
X-ME-Proxy-Cause: dmFkZTGRRet89JNWWzh2rBfSrH+G3d8tEp1ZRm/+qNvQ2Io9Hq3KdwPbHCFBYnJOpju+pJ
    8/6dpm+m5JG+u3CEcvFJ38VNW9NUa/HMy4TUNJ65M1eI/e943edrc3WUMYsL9W1ED2KnGw
    rlZJBiQPX3F1+/ulJmkcwb32Ktu7PhJX5WR9l0aAbXA5h9P8ikn1DC6rxuEW7RPxfWLQv0
    8pbXl5BdOBrnF4xKiRYTc7zrU52GZE2+SIFvzTvPEbiFA8SBD60MZnsi/DHPWtLpNguFel
    auF2aEvF06Kti9Iu3AersFY5jNcumJpvgRFEQdcFsrJ7DjMeySdZfkZ1Az1gjIzKuXCeH+
    pG1/7X+3OnIHOiuSHee19W30yswMotGFJP2TD0CSfCEtXacTjImPvc2cYuGb467jOqE9SW
    WIyPqqnmdBcPDZb0Mvm9QVB1BIPJaZuZCgdxT2qoaIDr/JmVTdj7pVQE3evBJVnlOr8pxi
    DYYxL57F8iZ4r/05g+0XwTWTrlV3a4+6aNgSBgwYp3iwlQdyKkvEmU8ZTWc9S62tZWWB8c
    CWcMGRF4VzKWyukOYmdWfZ/i92ZdYmt9JohFq61h+/mhr2Y00ffsh8p+Fu0U6acVSq5H+E
    mzcJyZ2GXfK4C1S72YUtbfIRyk/damaU4Bqz29PjlGhBR98JNAavGjsnXNFw
X-ME-Proxy: <xmx:GcPkao-M2xOFEQgM6By2s6i-31AqmmKaQTYC4ChhvmEj2m2Cma5iDQ>
    <xmx:GcPkaqKI2Pe3TBZv9U97ilIFHS-B9JNzq8COjjbPARcK1dzqzJKTMQ>
    <xmx:GcPkatkG4tE5RhzUaT0qUi8AtZM3zAyyXjVueEJoRT_wmQTJv0fDug>
    <xmx:GcPkauPzWnUsOqRwoSaCS2jqHga_-JmjzC5zZX2xcl03bmqVqYDe4A>
    <xmx:GcPkahKhVJyx-pon0DOGCH8CyPtacxdr2WoUqRaDBUoxQh3Xf4XMnlNd>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 12:17:28 -0400 (EDT)
Date: Fri, 30 Oct 2026 10:17:27 -0600
From: Alex Williamson <alex@shazbot.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 alex@shazbot.org
Subject: Re: [PATCH v2 0/7] vfio: mmap()/mprotect() hygiene for MMIO region
 mappings
Message-ID: <20261030101727.2dcb33ea@shazbot.org>
In-Reply-To: <6ae0895c.42cbc100.1c0cce.9e1e@mx.google.com>
References: <20260929094848.7439-1-suruurism@gmail.com>
	<20260929143621.540f0024@shazbot.org>
	<6ae0895c.42cbc100.1c0cce.9e1e@mx.google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2026 04:22:04 -0700 (PDT)
Abdifatah Suruur <suruurism@gmail.com> wrote:

> Hi Alex,
> 
> Thanks again for applying the vfio mmap()/mprotect() series for 7.4. I
> have one process question about stable backports.
> 
> Patches 1-3 (vfio/platform, vfio/fsl-mc, vfio/cdx: prevent read-only
> region mappings from becoming writable) still carry their Fixes tags.
> They are the same VM_MAYWRITE/mprotect class as CVE-2026-68445
> (drm/vc4) and CVE-2026-80724 (ptp/vmclock), and I am tracking the class
> as a security fix. Would you like those three to carry
> Cc: stable@vger.kernel.org so they can be backported once they reach
> mainline, or do you prefer to keep the whole series 7.4-only?
> 
> I understand patches 4-7 were deliberately framed as hygiene (Fixes tags
> dropped) and I am not asking for those to be marked stable. I am just
> clarifying the intent for 1-3 so I follow the right process.
> 
> If you prefer 7.4-only, no change to the applied patches is needed.

The commits are immutable now.  They can be proposed to stable, but they
cannot be amended to include a tag for stable.  Personally, I think the
backport argument for any of these is weak, thus the framing as hygiene
and hardening.  IIRC, none of them have any exploit path and largely
guard against future work exposing these vulnerabilities.  That
theoretical future work would largely be feature rather than fix
oriented, so the demand for stable seems low to me.  Thanks,

Alex
