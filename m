Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E691F192E
	for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773865877; cv=none; b=XG4c5/6ejWVrVY3DVPmXgA0vH/3/x38EPnRd7N9BIVGya7/AbOfRhsFa5sMzjPPlBjFenBwdtR+tRNaT1bwaH2x8x4WMURst9Zu0BnXlFn18u2XJYOUYT4ngr8yryO4mt6B9vsY01fDFVSKPwvtT2HrQdmkyjAkDm3Exi3d9JCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773865877; c=relaxed/simple;
	bh=ZuO7VbukMShAkiWXmqPxfd8HTQhtzlVdzxxmtGfL5BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcXku5etu+3JGX0OSHnlg5VfWCHVV0UzIaHlqHhcZ11YiON3WJS9D39s9ZqOzsZqmgLjnUbfdvIbihVKy//cJoSKycuCxgsWiUobEj40N07t4ASnMyqtVk+MhlhoBdjGFUfIPeNeLiBujX3cIk0jlCPo72IekLybW2URV5P7Gro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=rzQ2+bI/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DVmTfJC9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="rzQ2+bI/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DVmTfJC9"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D3CF9EC01B3;
	Wed, 18 Mar 2026 16:31:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 18 Mar 2026 16:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773865873;
	 x=1773952273; bh=dLkggwkzahWHNR67Lhp0vDzf1WAGYfDxXYXJT93DX4U=; b=
	rzQ2+bI/ArGPEfwUAiJgFuXx7Lse0ALPiylsa155EQT2duHmj6qrLuOl2vMNkeqQ
	DEJ9JiW3WvyrnAB2cj9UfiiNhxenfKKK5L8tg665Peb2x+tz6yzFDHIfD8wln/aS
	x1f/+JHNVwWxNU+sG8uHqQS6QrW/MYNTGIMPNYDIvJzkCMAvMukyOCxwwlC/sGE9
	a4H9aRN8mzi0eoULd0fBeW1XoSJXBxccFW8k01znvA+YHrjy2nu5gayf06ULMWzZ
	pZKEfr5ttkUmGXdf5pCZW7lwZGfIgU6QGaESNy28YnGt7CtwWjw3HG3Nk0bXxI4c
	BWMeZ2X6uL0yBq3dWkpHYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773865873; x=
	1773952273; bh=dLkggwkzahWHNR67Lhp0vDzf1WAGYfDxXYXJT93DX4U=; b=D
	VmTfJC9JLGKZiMBCVmDBEjh3WWLqi/TNL0por3CdYtCasU4qXJaHqDB74S6P6Xid
	MGotmpMKI2ODcA3ZP5MarFGTiAwLLN1ScvYXMEIIRNRQMsbkMbPm+l9+GiY1IC8n
	qGRkbfl9j+C+ekIq1Sc/HvZn+FHDtcrkpQss7LSzwFB3T9gD3skezc8LuB0lU/lR
	7G+UD2Jz/tHjXrh6pGkG893dQQBLY1IT3TWOHIbAuvprXsDuKnv2sXLOxuwmJB8q
	6OIiKmFO4wxVaeh9O8pdBu5SdogS7DBRVpX65wSkNY79jXYOnoMHXhT9O++qHivg
	SCj6G2V5IMqBuNtX0IBBw==
X-ME-Sender: <xms:kQu7acWDy51F7_BJp2uGBanK9yWfbvTJVidqwqeoRKSmpKmywtJTHg>
    <xme:kQu7aXf_0nJYIA0fnwAbMpI9IvtVc0-8t9pLgwBVqtWbQdQFDPkLm8hry9nc3fBTR
    5DycqM3S_YxXLANmjViFvn17ffoNQRkqNHRquNoxCFzao-ECqhyABQ>
X-ME-Received: <xmr:kQu7aYtCIsxnpeHDPDMcfY7TpvxDfecuqvkPe2MHSd1TpjmMEIo7Y6V1RGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeegudevhfejueefveduieeuueeifeettdekveekhffgvdetfeelueehgfdt
    heffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghlohhpvgiisehsuhhsvgdruggvpdhrtghpthhtoh
    epkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrfihi
    lhhlihgrmhhsohhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpsghonhiiihhnih
    esrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:kQu7aW9hJBqw6w09AazAiAJdRaU44VFSB9BbRGG5KiayPJ3WaBHc-A>
    <xmx:kQu7aT3zcBogOkLriSKDP28mEg2GvbtIhQ4UvF_XRNn1CcGT2aU35w>
    <xmx:kQu7abC42OLpqiTQx8SI42MjKCkswEAgnRLyq7dEirbrmfCh8UPAzA>
    <xmx:kQu7afcKroTyrlvK__1ycp8lZ5iTVqK8KyzHeKKGQRWcfbSXCTknHQ>
    <xmx:kQu7ae5D61c_QYqGgga_vix89SO3bebJZncZ8x4Zzzy91Vl7CH8nyq2a>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 16:31:13 -0400 (EDT)
Date: Wed, 18 Mar 2026 14:31:12 -0600
From: Alex Williamson <alex@shazbot.org>
To: Carlos =?UTF-8?B?TMOzcGV6?= <clopez@suse.de>
Cc: kvm@vger.kernel.org, alex.williamson@redhat.com, pbonzini@redhat.com,
 alex@shazbot.org
Subject: Re: [PATCH 0/4] KVM: VFIO: use mutex guards to simplify control
 flow
Message-ID: <20260318143112.4ac13424@shazbot.org>
In-Reply-To: <20260313122040.1413091-3-clopez@suse.de>
References: <20260313122040.1413091-3-clopez@suse.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Mar 2026 13:20:38 +0100
Carlos L=C3=B3pez <clopez@suse.de> wrote:

> Replace several uses of mutex_lock() / mutex_unlock() pairs with mutex
> guards, allowing removal of all gotos in virt/kvm/vfio.c.
>=20
> In this series I also include a small refactor that allows greatly
> simplifying kvm_vfio_file_del(), and skipping an unnecessary call to
> kvm_vfio_update_coherency() if the list of files managed by the KVM
> VFIO device does not change.
>=20
> Carlos L=C3=B3pez (4):
>   KVM: VFIO: clean up control flow in kvm_vfio_file_add()
>   KVM: VFIO: use mutex guard in kvm_vfio_file_set_spapr_tce()
>   KVM: VFIO: deduplicate file release logic
>   KVM: VFIO: update coherency only if file was deleted
>=20
>  virt/kvm/vfio.c | 97 ++++++++++++++++++-------------------------------
>  1 file changed, 35 insertions(+), 62 deletions(-)
>=20
>=20
> base-commit: d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf

Series looks good to me.  This is nicely isolated, so I assume Paolo
will take it through the KVM tree, but I can also take it through vfio
if preferred.

Reviewed-by: Alex Williamson <alex@shazbot.org>

Thanks,
Alex
