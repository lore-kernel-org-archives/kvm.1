Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C324A49B5
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876777; cv=none; b=SFOGryxsetM69PxTl8FQkKhd06rHbs9sUsK0ILaLrUqI0IqVROYuGxl33fY0/JRy3sklu7WLCCVSO4onswcxspIfOaQr8b/v5tVjTk+gVEbR1wSmV2pTGAJpVuS2dNBrTyScG7jfGTD/k6Up3avaHBEvR/vZocNLT9IkOcyqTsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876777; c=relaxed/simple;
	bh=rnxeMZYf/9z+Xb0KkANecvdRglyjwp/CtJHPxz2f1UM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3uo4d92sTll4WGTpAo5XDGpMilnjH62976YU4o7C/WGJlaJfn6XYAP6nB2nJBTyJSvzwjqXDMggTlS+PQ245Df7bsMGrcbvZhYlw4j1jcxUKTZcANn59AyLGPz3DmnZpKrhSVcicchVb5gFFESlt7q/XSkbWz7nzE5jXFmJPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=56a7garZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5rQo7gt; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="56a7garZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5rQo7gt"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id C34A61380328
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 13:46:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 01 Oct 2026 13:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790876768;
	 x=1790883968; bh=CtQ3WPdADjRa24hJ7cOX4tECd7fd+Masma1XcYGDjzc=; b=
	56a7garZnY23HpMfZVeSIX9qiczOMX9EtzEqL/bYGbLv1Vr4cGrVfzhP0xXFVYOY
	/COP40NWJF3UZoWRIJO0+jKtBivI//YLwaCoYcAjRCLws59VsxHy3GaiGVDDLdgm
	mdY6SLClRvNJ8H+CDd5gL9Qc4NQxfV5ABx57W1BTwjDdjjJC/hqKUcr+HpuuUWd6
	JtRwF2bCaR2jGb4raqhxqUyRyCaNspKU2nwjPcRt+rVsHJj4Bx9MrPWrEPLWAkwa
	kIVqLck1aC0Kfl5On5e5Ua6x1jvuTA7/9ooiVSPV90dyHLMe0ZBwbNuLYlb74YuO
	l3TYNpkg4STm+crf7cdSbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790876768; x=
	1790883968; bh=CtQ3WPdADjRa24hJ7cOX4tECd7fd+Masma1XcYGDjzc=; b=W
	5rQo7gtSetJyyr1A8ZXKvTECrD3bt8TVfZn+Vm2hQhMK736mtLuEvBMp3kzBScrG
	7N3+NsqGlDNoCukWpYhieOy6eqWoLguwr/lfJbrbaq2L9RB3c0ogz05YVboMJ8Cp
	zlxv3qrHNiaRt8D36f+V71Tk36Twl4RF5TDrOOwagSqAOq3bpRwNDPhAUf/7fszP
	kjt/CiCAx4RXA/0NyN9iEH+jmBGdOMm6MfSFcRAHTskhVZEYVtptETwHjqo92Ji5
	YeQywd04OiWDZQZq43/rmvf5fkn6GcOHyySXRBWnSJY71Df8onseeE4yEBJoWyH8
	NXtrXvfOY1UspHafNvhgw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790876768; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:d9Bq229pT/QCawItvqqnFJ0aiEvONLZ67AADtJigvB41wnn
	/kpmgKCE+Xot8VShpTIQ/N7wi+iFosIr3U/2EJLGmu/pw3Qe4wx9tiTYNHggYKDM
	OCyhDWZ7m6TVUEIk3p2705619BRAHVBYig0P9nNn65ewEVkksLwT9zsmQVSKuHy+
	TNoj2D9Lg2Q2i/ezFN9SiUao/vXgvnvhJnyKoGJINBQ0u/n3opr35pn3oqgo8tZk
	OTPIS1oYlkzS8YXY49vH5SlZe5hD6aKzDg2qs6JNvyfFK87A93vre9E+yM21Q4Gx
	LEOO6Z56PJKsqzHkq/W7VnhNsYvdhD61Q/dVvFA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mzoQOsQeOsMe7yu+QchXp1gDZTMc9yWC8jTVvXYHafE=:rnxeMZYf/9z+Xb0KkANecvdRglyjwp/CtJHPxz2f1UM=;
X-ME-Sender: <xms:YJy-apJ9FCs-iuch36jfRecXTc5pxl4kBPcbCJkBwnQlotuZ_w3w_A>
    <xme:YJy-aiiaonWddKPd0lbc_Zi9-_5NQRyZvuHQri_r61On4tfeVkSUTI-N136uDfsNG
    ggBBGoV2lwXkWUKkK7BPIHI10dBQLSJeV-94yMyJodkKkIF_eInLXU>
X-ME-Received: <xmr:YJy-atuHfc7Y4LZn6aVxLEWlITZtk7GeYzO1lfG97ycwxWG06Otpt82GKrI2-w>
X-ME-Proxy-Cause: dmFkZTGeFOiYRSvqQRzaU9O5PYqcmDoxeyZGLAapC8+oi4sRpdZKAY+lSdXnsz87R/LRsN
    OAwD0Pix9/dGlidb6OpIQUYllU+qPGUmUMr9RtZkzLhkG8QfXKxnuAfSx+he7ZiQliUm4p
    fS19xhtT7B0LTzhA7nGIdVYTJY8rISmFadgjpkz7nJ5cCS/ofG7/mVnhD/Ogq1cJO4Bq5v
    HzaOqDG6yarbzEKNQU4IzTVdy1NR5OGboNIioUq7ivHUWWwQeeI8eVLfBMc+iNHOHR+8Q9
    rd1bYCqkvxobZISxhV/wnQGymuUJtWZ+DIreaBjkK9eX9AhlsvIQsdSJTzeXBPpLAbClMg
    kAMQ508m946nM3uG04rxSR/HFEGCsaOuixFXRWmi91SdHjx0fLlp3EmjQuFy5eOJOsXL2P
    jcD4flgmr3VEOaR4p2M/EftUQ8mUuIsTzlAn5IftslRhcy7LufPXoame2M1FSVdL4SYu3X
    BnQHIsMv77I6N6JCGPINyuFkyabKF/eAOF9oCy5pkXzjhXkdGsUO7S3gH8CHS4xbUaOdOe
    wwBrsncYU8LTOihBOIW1WUwkcXuetEutTc1uPN0+zqmINYOLAbdXeOv1C7D+JNu47VjZIO
    xfq8SngKR0vz7b6Epkdu8SHnXk1OgXkrnVQA7ZTWYxtwWn17Tw8IDCOTmqjA
X-ME-Proxy: <xmx:YJy-auEcMH1yFAmmedCA70c1CKmTdCqctQhwts2jJAbVsYmEzW-iGQ>
    <xmx:YJy-ar-9doEDGvIsB1qcb8iBPN1fUXS04NK3VamUPXHJ2nqwrnqVhg>
    <xmx:YJy-aujJPABC2q67rzOhqGbVXnsbuU_aVeTCg28X-__B6fEkdLl81w>
    <xmx:YJy-ah_-teYB6dF1k5KZ11i3KFTVcwJ1oAz7OwmM6HIdqwWMs3kgfA>
    <xmx:YJy-auAkQ8bouM_WLRsuqtmRPbPVO4drjEUgJf9pMILUTDBXtWjZGw8V>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 13:46:06 -0400 (EDT)
Date: Thu, 1 Oct 2026 11:46:05 -0600
From: Alex Williamson <alex@shazbot.org>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Steffen Eiden <seiden@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Holger Dengler <dengler@linux.ibm.com>, alex@shazbot.org
Subject: Re: [PATCH v4 0/6] KVM/vfio: Use file-based reference counting for
 KVM
Message-ID: <20261001114605.4167fa97@shazbot.org>
In-Reply-To: <0c5fe5c2-4ab8-4d1f-a36a-84a8fd136160@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
	<0c5fe5c2-4ab8-4d1f-a36a-84a8fd136160@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 13:59:49 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> Am 28.09.26 um 15:07 schrieb Steffen Eiden:
> > This series switches the KVM-VFIO interface and external consumers over to
> > standard file-based reference counting, eliminating all external KVM symbol
> > exports.
> >   
> 
> Paolo, Alex,
> 
> I assume this will go over one of your tree? If you want, I can also create a topic branch
> for you to pick if you prefer that.

It's a KVM focused change, vfio is collateral, so I'd defer to Paolo.
I don't believe I have anything pending that conflicts, it applies
cleanly against current vfio next branch, but a shared branch is always
a nice hedge.  Thanks,

Alex
