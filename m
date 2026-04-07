Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286F3126C17;
	Tue,  7 Apr 2026 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592999; cv=none; b=uOdL/oHusYWcTcxNyv2twr5jsGNZ0LKc8MkH1itxCPJE5Ip/vKzZ5IpBWW0F9SdvzEriHo+xZkGM+l0XGmwUvDOTLAjQxILBj7DMkdZGpgX6AQNLqEOPhndQWKrYMKg85hLaLVwVJ6SLP8ZGLESk0FS9vn388VzfcQURPixlugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592999; c=relaxed/simple;
	bh=LwFY1mVQ24/KusfYZIAhDC7WKNarVcmcLrCFoKLCSKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhGh/jdA37KONx/0UPRxdN+8k7Gws5T6NzOcfWCCyc8PS72tYmR4xEBp0uaO8IAUYWfV2dE+7nsumyXX6xscda06Qtgl/xkqJ6qp+o6j2RkDsh4C3NpK7EosiIbniTrRPv1DpgGmn2mp2uSgtJlmCqVanOE4Y9bydV2NfKoujcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=dtlKI2Tj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQ+TpB8k; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="dtlKI2Tj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQ+TpB8k"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 400EC1400220;
	Tue,  7 Apr 2026 16:16:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 07 Apr 2026 16:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775592995;
	 x=1775679395; bh=oof9miOzpJB+K+GJeE52JxyJ49VY2FQD+2dPrLz3gcc=; b=
	dtlKI2TjCvcVPqaNA3/qYH7T+ILNhxq4f0JhKIbWs0mi0eluTFLCbXX9d+KWNNyO
	mw9DgzKww/MnJDbOIAEnotOM+WRppdPM2QkBwd/iRm5esHWtT3E+B0UtsBYnWneJ
	k1x3mimVCyyAsfaA39ZiSwCiV0V5rnX+HxuL+4poUqKIzf0qzQQWvqFC4I/+NIPU
	RO/vtjTaAyHWe/Hwu1igGhCBN0g6aDM4MUJIhaCzyPJrA5JTYNqZ5YaIKc7X2DdT
	qAzLevcRphwDCC2IpUjpj0iJkNNntUZE7AeV5mudtA+M2T1DMcRr96pw1AEkb25P
	wGVABUcg3CwcvCLNQYCl2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775592995; x=
	1775679395; bh=oof9miOzpJB+K+GJeE52JxyJ49VY2FQD+2dPrLz3gcc=; b=V
	Q+TpB8kBCdnRiMimc/aXiDBNDg58prSqDRuV4fwy01iu8OGJcfcbacp8cnjQgkgG
	0WAJ704wMxxcQHdxH3o0lAmWz0FHxnNfPMpgSBjVm7z0ULC4Uz/Omel+gXcysubu
	iJfoSjF2UVvx+K3d5vtEwTpywZDv54DfeHkp6h2knKhid/rfUvpWjnb9h42kMmaj
	1SFb/U2VvDTkoHGmkAFGk0gpMn2xN1fxnmxLdxkPsYbeuI5ZZ74d5hyPh5fm0In7
	QoFsdB/dZVGjszEf/f4UzjUW9WtYnM7ddqim3oMipIiJRGTnp7vcsvFyKoYTkhIH
	pKUSyEWAB4BueBbqAsOgA==
X-ME-Sender: <xms:ImbVaRW-90TSJI6Hmp6zhtdy8AAPo4vRJUySuCyE40RigJSUOWBYuA>
    <xme:ImbVaagmm2dfzFUVaenm9A2-5TJ2Suo35AvbThJk7eEASKMSbhgSW50tHxCIp-qkb
    aRf6AI8qztmo6DCogN7PwFa1u7kbXAAR8idniVF_Pbw6u6n84_c2N8>
X-ME-Received: <xmr:ImbVaY-t4yrDtRf15-q8MPP8YrvtjwE-jKBtpgRYtNcZ--prkk-JkW6ZqwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrghdprhgtphhtth
    hopehpsghonhiiihhnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhvmhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsvghiuggvnheslhhinhhugidr
    ihgsmhdrtghomh
X-ME-Proxy: <xmx:ImbVaUahJMrcSBgLtGAB6GIfUzEYmc49N0q_PYJQP2WuKDQQn-HRqA>
    <xmx:ImbVaX3pyKNcPkXh2et-OPLoXR1ePj7tddksJWeBobNfO9OnSAPSrA>
    <xmx:ImbVafYne8dUcS1GA94GS5hgQVmVJsF0NWtlDKoiZKpDMp4L7S8Jkg>
    <xmx:ImbVafLWlCYw7Zcv_PWS8C013BTylmEQwTP2ZJrtc4Jy461SK9q1Iw>
    <xmx:I2bVaUGj4M9kb6Us5rg22LdRLgwXCZBhEo558AujNoje_bUkWobkTW5D>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 16:16:34 -0400 (EDT)
Date: Tue, 7 Apr 2026 14:16:32 -0600
From: Alex Williamson <alex@shazbot.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: alex@shazbot.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Steffen Eiden <seiden@linux.ibm.com>
Subject: Re: [PATCH 0/3] KVM, vfio: remove exported KVM symbols
Message-ID: <20260407141632.39ba9d59@shazbot.org>
In-Reply-To: <20260407180107.1603697-1-pbonzini@redhat.com>
References: <20260407180107.1603697-1-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Apr 2026 20:01:04 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> KVM right now exports three symbols for the whole kernel to manage
> the reference count of "struct kvm"; these are used by VFIO just to
> keep the "struct kvm" alive.  This can mostly be replaced
> by inlines, and in fact the entire definition of struct kvm can be
> made opaque to VFIO.
> 
> Besides the cleanup of removing the sort-of-deprecated symbol_get() and
> the bidirectional dependency between KVM and VFIO, this is useful for
> the recently posted support for Arm VMs on s390.  In that scenario each
> KVM implementation module wants to have its own copy of kvm_put_kvm()
> in order to call the "right" kvm_destroy_vm().  With multiple modules,
> VFIO has no way to do a symbol_get() from the right module.
> 
> With this series, that problem is gone because kvm_put_kvm dispatches
> through a function pointer, set by whichever implementation creates the VM.
> The main issue is that symbol_get() was implicitly taking a reference
> to the KVM module, and that has to be preserved.  This is the purpose
> of patch 1.
> 
> Thanks,
> 
> Paolo
> 
> Paolo Bonzini (3):
>   VFIO: take reference to the KVM module
>   KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio
>   KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio
> 
>  arch/x86/kvm/mmu/tdp_mmu.c |  2 +-
>  arch/x86/kvm/vmx/nested.h  |  4 +--
>  drivers/vfio/device_cdev.c |  2 +-
>  drivers/vfio/group.c       |  5 ++--
>  drivers/vfio/vfio.h        | 15 +++++++----
>  drivers/vfio/vfio_main.c   | 51 ++++++++++++++------------------------
>  include/linux/kvm_host.h   |  9 +++----
>  include/linux/kvm_types.h  | 30 ++++++++++++++++++++++
>  include/linux/vfio.h       |  4 +--
>  virt/kvm/kvm_main.c        | 34 ++++++-------------------
>  virt/kvm/vfio.c            |  4 +--
>  11 files changed, 80 insertions(+), 80 deletions(-)
> 

Looks clean.

Acked-by: Alex Williamson <alex@shazbot.org>
