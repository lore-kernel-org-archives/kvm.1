Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376062;
	b=SQ3YAOCYA6RW2bqgbMxT0oBFXKqomuYXPu/VV/hrGiQBOBPQxYTLNsY0pmEp3rMcaxpL
	 /2N81df9x2rkGf0GojGyF3QtbOU9g4mUZ43VWlJIwGJ1ARgIIaWswXq9opCdX1uh/RFIa
	 hKDLL2H6xDsxC/7geb8pJXGYTU3kqL2SmAfYHXij6pTHdoNVNjDz2O9CIWCBE7g3nTDzA
	 pHfRvZvHJekd/+ewQRlDjj5KWSn7oISZzujpHNMaIss51J4f1J/oIkcbnhROUrxcVglZy
	 GRzonWvc3cJuDWHfRUQvrp6DGVwG4iKj0rc+kcaRZvocT6VHivI9jXc7cXAqHjqdxjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376062;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=L89tyukt5b5c8qkH2tYN/al1Q24Aux8kILau79H19gs=;
	b=CGm/WB+1jQoQBo2Mytq0+LQpHe8v3IhvjvhfVdVb+1MIh5ilHyxwB6ndB3ThXsFfLe3b
	 25MdTXeXmp6z3keOyoD+Y/ztD5vu/wEjWXrJGdLDJtjLymPRnjrM9/ZawJLzT+Eins1BH
	 XtrdIV07PUhHArhNDkgBvqGsUkeQc1l8p9ZS8AqsgazAAcLW4uDbM9tz8Ie65IhcL79Q5
	 EkCA3oqTLLYzyUj4XkOabfBF4eToHKskBiDjO+q8zMTwBDHKAVvxfbJbhwvMHpLTZY167
	 fxmZlx/Gj4LJRrxTicawSz7obAOo3Q4C5k8lbuLAV35Zl7TdkGY8vafIydd4gR5LDKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=tieSHTdP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nvCOJE9o;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9583606A31C
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 16:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9583606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=tieSHTdP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nvCOJE9o
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A6167A0139
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 12:00:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 30 Oct 2026 12:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793376054;
	 x=1793462454; bh=L89tyukt5b5c8qkH2tYN/al1Q24Aux8kILau79H19gs=; b=
	tieSHTdPsW858t4IdRNruGMMvspjyjZiF94vc/xGEHiHcfWpeDldeKwA3NPeEPxc
	DVAeUQHx2zW7j53z0j2ztJG9dINVLq974CgIP6ueY6zIiij4OMeVN2vn3Q+eho0X
	47rr+8fVr5gwLPlSdCMhrboU9w3UMgk9U7/UKJ9yHTsQBvju9Yf+t5eJggSMmG1I
	Auyu1Wjl+z60vuPeW8LxSOuTZNk4eHVPv3sDyx2AK53k5rE6azrIy43VIfQYdBkf
	HyBvn7xqjW+gJ6OYiLp22FzyJsErNElwJHCbGsqxNPjMW39N0EIvsJtYbVzaSVB/
	d0cVBTHhqSdrZFEEb8fBGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793376054; x=
	1793462454; bh=L89tyukt5b5c8qkH2tYN/al1Q24Aux8kILau79H19gs=; b=n
	vCOJE9opVcfH82cuieLrQLRdliOw9Fq089ErTs/2t4FftKHTJaqQtHZzYpPWRjBk
	F9rfX3tvwwqufQ7Ac2FT0za+ed4tjA4EBOCWFXEEmg3xoeZ3evNknENdBa9uJGH0
	AyIUHsROqp9f760BrgE9TPmUAYCeuJ0rFfSrpbkZwQhZ0A1JnF9G3WnYzcH6f/N2
	nn5TPg29zJq2SjwMYNwtZJoRPVwmA16/xtpM6AW6sRXff1nel1pLhZohOqmpZZYa
	kQ03KDvNQ81GgCWmYtPpo4kLYToQQMAnifW82OZS7rnIg/vZHLPKRATQyPzbyQxs
	9uxPLrOBpIif7UcJKhnfw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793376054; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SEAbDlZe5KiddB29hnP9GKdYCFAmtkowAvn5qfR4ZM31Z3N
	G2gy+o3SAzzrIwi4Od78flC5rQxga0hZ2otwTtLorJBBakT5qh0avSr2pp/DY8yg
	Vd4N3k/v2sO2DGWxdXTXDCM1Fkn88MkLjbQyWOQqNOK+9QNApgPHZ6d/iK+y/tSJ
	B8tlvJ1oPo0G8t9pXtuuRemzqA2ZvrVY9h1YAAuCNT4a9Hjt1NAwVhu43e/E+GuG
	NUTYXrvbL/3VqiwzFaGxiG8FZzFym1XFj+21xKOJFkG2sRYW81pb6QfPIeMqYoMQ
	LCqj++uESBI/4SiGmjub6koEJYyISu0a7tQwz7A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Dywa0nh01Y4KCxYkiW9uTIaWIurvgzJb6i3EZHfmuls=:EYti1+L3wqJp7tckEjY8frIqelFuOK5JGtGnvfzp/ag=;
X-ME-Sender: <xms:Nb_karLSMRKdcX4tpOZXpOr7TocodofaJd_rPCZUollRuARARhY-Yg>
    <xme:Nb_kagvfSE1rCpWjdaSba6WqUo16oygPWF-D4F5jA5Pte5yr_Xx0ZhmxrkmPU3mXJ
    HQPMFQygSqz6zaFKZHCj_JhjHdfVv_x0NX_troNMD8lHdgswG5j930>
X-ME-Received: <xmr:Nb_kai9wGc-XrbcA1B_o4M7r3twsLfhIcwnaQkugOLxaroRMgH_2W19HxYOycQ>
X-ME-Proxy-Cause: dmFkZTFJuiyPAomletbDV+qdH6dBvCjjAz52xg4f2daCyYxnm8YZgRg1ZLSbQlEUf2J6lm
    ye3poX44/VWNiB0kcC9J1/qYYuQ2M9buv7uyYDJjj2+CIe6iQU4eT7aCWiyjzzgxexCMWq
    8NKiSE292ktHs7OSAM03zbX7Vhm/uElw95rbIy1RBU+rl3y+RbGpYLbP1HsQzbWnfybCpk
    h5TjEaeYgL8peSmIAuQy81sXA5aCIdAbBHDSYRJbY4vdOkAj9t1VJedT7Nfuc5Gq9F5S+K
    QPZm0PqI1HAk/9EsPAQ/c3g/mnp/lJIjzCEGAcVTxZ4tKusllUXQwGDbUN0rGB1xSpKkcF
    qzJwMAUXn1HSqmTQhmy3ohqGNlzp3qjRrbCSX92d+LhCSuVsdX6BclgCZlao7qMo25+JJr
    3IYil84YlCCZ3ch5oUA8/usswpis26GiagRmz6SOvgwgF5lygL76CX+TNky6fIM1HEz668
    eqGtz54PFR9foDfV3/Y427dLXwoSnLn7HCYOnqLlw3IIf510Vxq/aQCpBP7hucLPEDZeSt
    Es/El7PPfGcjwrTn4RpBe6dluaV4mBz9sif2832STlC8dyOkgumLsp9ibbrW4wJ+sDvTGH
    lBsTbHJ09L1XrYWMuuMWXGNMrX2gdNwgOba5TiGN/VCh/Ce7MTj0n20B+wSw
X-ME-Proxy: <xmx:Nb_kaq3P8WAIy1qhUSrVDJekxRfmz5DGMUwIm0zAV0B_MHeAwHJnXw>
    <xmx:Nb_kanjon8o0RnLX5pnD8xo61PYqJ92VdnlLhsnVMoMfwsn90Ai0xQ>
    <xmx:Nb_kaqZJ_KEmWOWshc1052AngHXPJM8MUlNyX5jTl8Kh-NtdBCuHwg>
    <xmx:Nb_kajWhjvjPOCcbMDb1H1h1IpE3hMu78J4V2VKPBYIf4Wbo2HH-hQ>
    <xmx:Nr_karhBIABsOoYbOLALuXmxJrooHnH_P-uJF302Ku2chN85y8G9prxP>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 12:00:51 -0400 (EDT)
Date: Fri, 30 Oct 2026 10:00:50 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>, <linux-pci@vger.kernel.org>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v20 00/16] vfio/pci: Add PCIe TPH support
Message-ID: <20261030100050.16df202b@shazbot.org>
In-Reply-To: <6d86dd9c-83ad-4884-915e-6509995c5ba3@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
	<6d86dd9c-83ad-4884-915e-6509995c5ba3@huawei.com>
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

On Wed, 21 Oct 2026 09:43:05 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> Hi Alex,
> 
> Quick follow-up from our LPC discussion on the VFIO TPH patchset.
> 
> The P2P TPH path carries significant verification complexity, as it builds
> on the PCI P2PDMA stack which is still under active upstream revision.
> 
> Meanwhile there is clear real-world demand for the device-to-host scenario.
> AMD recently posted their debugfs series exposing CPU-to-ST mappings [1],
> and we also have strong use cases for D2H TPH enablement.

You might be working ahead of the industry.  The debugfs interface
provides evidence that the feature is coming, but is perhaps still
working through implementation pains.

The lack of community participation in the vfio interface actually
suggests to me that there isn't a great real-world demand for this
feature, yet. 

> I'd like to propose a phased upstream approach:
> land device-to-host support first, and defer P2P TPH to a follow-up series.
> 
> We can add P2P support cleanly on top once the interface and verification
> are solid. This way we can deliver usable TPH functionality sooner, while
> keeping the path open for full P2P support later.
> 
> Let me know your thoughts on going ahead with device-to-host support first.
> If you're okay with this, I'll post v21 accordingly.

As above, the demand is not apparent based on the lack of community
participation in these threads.  I'm reluctant to commit to a uAPI
that's largely been proposed by me, as the maintainer, trying to fill
gaps in the narrow scope of the original proposal.

This needs support from the community and validation across broader use
cases.  I think that's the actual barrier, rather than ordering versus
Zhiping's series.

Despite the LPC talk, there still hasn't been much engagement on the
question of whether device ownership grants the user the ability to
target specific cache levels and how we handle cases where the
driver:cpu association isn't static.  Thanks,

Alex
