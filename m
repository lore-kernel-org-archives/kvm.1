Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A154734C7
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056160; cv=pass; b=LBFjJe33OkEEc5rgsSaCqkv8drsy/G4OhnFMVyH6mp7HLaEQ7MO/GBXBgtkZE2zlwxNqUgy754vl3Exkx4oP+u2bVPMhmlas5ccE/RmALmiT3xOhINPrNwEXPJCV9r8XxKDxTAe10xIFzdCietj4pFk9Aj7pbtKLXPwJeItCH3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056160; c=relaxed/simple;
	bh=TyA6n1X+YsqsaNocsZd2DWoJKnuiA+PiCuN5vaV37+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpdcHch209IFQegyMnbr3hYXpxOJpERVLEABZKl+vkh+D7QEAuPiSfMO/vgePT4I4ngodZ9No6zdMxYrP04vxW8FH51ZjIbFrtZlUjgWca573PqSdGXIPpg8UIAdL7XPtFE92r3lblE27N3TGJD/xFy1xZ2mkAlqGy4wajG0oI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ba/Wq2Fh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EaIcVDtL; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ba/Wq2Fh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaIcVDtL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787056156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TyA6n1X+YsqsaNocsZd2DWoJKnuiA+PiCuN5vaV37+o=;
	b=Ba/Wq2FhU395NKuYvsax3HgLCRDgLjrfh4lXw8fUkT9iO+9O6iP7Maez5COqpnt/5EJz8l
	Yn1D3LsCpYiGtxDF9J36Ff7ffNl4pqZsQkwQl42Aj9USpOv846Q1BMX+Y4T9SxiZjgV12P
	fKLiuPUBFCjva3R4brezGz9PqNRfVkk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-uZZHZgcsO0eMQyB1iP4Q_g-1; Tue, 18 Aug 2026 08:29:14 -0400
X-MC-Unique: uZZHZgcsO0eMQyB1iP4Q_g-1
X-Mimecast-MFC-AGG-ID: uZZHZgcsO0eMQyB1iP4Q_g_1787056153
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4814718d124so2729066f8f.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 05:29:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787056153; cv=none;
        d=google.com; s=arc-20260327;
        b=KFf74xFna41oYB/Xp0MDNxrtY+XdWsjzO/LflmdDrzOgp0JFE575lcXPM7BvFpDzGb
         x9nbmrYq4wdwiSG96TLFLZaAx3Lb2YVnVvOnY+YD+RBhDWIWDhUjdVjtSQb867vacs6j
         ycAjHTS0dTLwRx/eEPLpGYKLHWVKuPDh4he6e4s1Wi8KFbpMIbl4dZhOUDCFgdGl5YTY
         eqcytO46GAibd1xNjnV9l/lvT7OD/xbfDQHjSI92QahsDttDIk3L0FW3POkRrviH/csW
         dVHdpQ+jINSkvcJBoK9hRjawAQFmBWgTh3OMJC6kaT8h83dUT9dvkjLVTD5PrHhqrvvr
         yX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TyA6n1X+YsqsaNocsZd2DWoJKnuiA+PiCuN5vaV37+o=;
        fh=oh76THDwip+UQ69qiQo2va1IdHfjw+VXVT36vpPYt0Q=;
        b=sTayTZJCl+ehfEyzPoQz6P6ZgEqO2vUvY4Qxg5oQJ8WBKbOHFeqIqGSGd6Khqg6+Hp
         ypz+D1NxnJExEKte7putVVb+o5a3xY6PAIU2zCFMZw9z7O5/eSXkS8hENA7CxSbYK7lx
         IwSo6wD7xuIxty/Gas3s0VWPspckEvVyyUgJMf9yEGC6L+gIfkDLnu6NGLLB9ybzZ7dz
         RxBF51P5upEhLzbFbmlzXNrZ2gIqlte1LnvN6aBGWGoIsUDqFjJ+JPdKBfepGdUrg6q0
         5WLxXBd7gCzs29B6F9oYZ8Vn36e5fXdza1znI3HsLR0/UoPEHrA5uyxvteXWvA+tipiQ
         ut5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787056153; x=1787660953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TyA6n1X+YsqsaNocsZd2DWoJKnuiA+PiCuN5vaV37+o=;
        b=EaIcVDtLniYqiaPMf/JUlGHyNg3RmL7UKSpX0ebc7q6gOKX6fURl9dZQ44YsHmHIbZ
         PmSSCjmilHMaG0SLU0Ot8wYzF8cKjydye0HHpMHItJTCra+0J943HmsMHg/8jljuW+lA
         Ed/KfqoRGj6G0YJ2ttN24EvrBRk1RvFYIYRPVbZ9XmeD/mxMgGpZ94JQzP8jzd0ES3fP
         PCgCOn9BC66PZoHAsec7+TgfEobXxyqdxOcWHJ5oWoLyEcQmBWft525lgSlJkrXhrUrd
         ouRvZDxFtOTMFpFq/ohDAtPwpw8ohZ0E/uP8+XcdsidSR+v0TjG8xHiFqNNiXoD5rbsB
         oMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787056153; x=1787660953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyA6n1X+YsqsaNocsZd2DWoJKnuiA+PiCuN5vaV37+o=;
        b=W0WKgLQ3wMDAlMWPRTAk1FXQo9Pk0+1YgS/yr+gxt5mxMVJteJMNGizpMPibExukH5
         aPvTltGzJSyx1iXhUUt0Na+rzLVE6lYDnJzYrdqTy+HJPICkyT3K1pU8+/rGJavClVOp
         APl/jtTgCQRFWFcHjwAnrramSCYex9ASX4r8eyYH7dnxgoO37TPpTMQp1XbeUwJBgUX3
         Fr+k6IE9h3eNEhRuLX69QTS1i7KaTtU8IRD3N6hjYQXVr5zdyOwVNVlEvp8K1C47FXu2
         EtdWDo3XPPNItOEmI2VzeygYLDAyAsn+pzh1nxvQovcIILzKmSp5iO/lzK7JGiafcqUb
         3+vA==
X-Forwarded-Encrypted: i=1; AHgh+RojEIJ1Ct8sHwFeJQ8UOpHQxU8fpKLC5ggnIb8xbmtlaF0+J0BebeFDYCUzTu3zysr0Lh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiEzMNLUn5QmTU7uytOS1slDPT+cA1PJWuN0IImrgcGDBLCu8O
	WaLmV456a05UyC7bRfT0UjDcowH2ZgCFSul8MFtSiF8SYeMjeZftL/h/t4yZFgJ4ffflj+dhoh2
	7AayN04aqB92LBlkFyVIz3en4mXK1A8AYfemgUYOk0t69AfrgB3erd/RNx+7JMR+Z2yHUiu2qwD
	z61QIYnMPP9DpjLhjnUvtEHTt6kao2
X-Gm-Gg: AR+sD13xQf7q1vE1cR356moDU5SLvXl9Vk0rpXIYHDdTnorAB7jLJOXjP4pJlvw7yAL
	m4ih+kdtXoalcizLpGD/wzXxEwTJmoKPx7fw8jQK79gAM0IdY9MrbfbzSKg1Ry8aP8FMZJ1jDkr
	3jbbu8efiOSd56qiKkt/ULJGKmmqRlEcv8dVLwEVtDNb3i3IObkEYg1ne6cdtMFV+7Bktan4nu/
	Kfy+edfBoooK5Y3J1nCvxhTiL4SkGquw7/XEgywHlexTRPxUgarag3x+mY=
X-Received: by 2002:a05:6000:240c:b0:47f:e9fd:80d8 with SMTP id ffacd0b85a97d-481607947e2mr49347399f8f.21.1787056153048;
        Tue, 18 Aug 2026 05:29:13 -0700 (PDT)
X-Received: by 2002:a05:6000:240c:b0:47f:e9fd:80d8 with SMTP id
 ffacd0b85a97d-481607947e2mr49347316f8f.21.1787056152663; Tue, 18 Aug 2026
 05:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com> <2c501584d34eea17016d39c9a5f78ca3d60861b4.camel@infradead.org>
 <CABgObfanoHLfdfNshuLCHkWgtsP5Km9G5WsdwfGBcLsJ_LKD8A@mail.gmail.com>
 <d28ebb09666f7188d0390fb7f877c5584991ef3c.camel@infradead.org> <aoMdUlCCvYqdw91B@google.com>
In-Reply-To: <aoMdUlCCvYqdw91B@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 14:29:00 +0200
X-Gm-Features: AcwNN1W8q5B4FH2qkU1WO0WJlJMlXkCDEvl8fBGL6CUw3dSleLFmrL7CQoWOdhU
Message-ID: <CABgObfakU5Q5zt4v0Zxpg34US_7OCqfH17gR-v6c-kCWF-muTA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86 pull requests for 7.3
To: Sean Christopherson <seanjc@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 4:40=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Sat, Aug 15, 2026, David Woodhouse wrote:
> > On Sat, 2026-08-15 at 09:55 +0200, Paolo Bonzini wrote:
> > > Il ven 14 ago 2026, 21:25 David Woodhouse <dwmw2@infradead.org> ha sc=
ritto:
> > > >
> > > > This was intended as the safe stable bugfix part, split out from al=
l
> > > > the RCU and rwlock RT fun that can come later:
> > > >
> > > > https://lore.kernel.org/all/20260811094829.98794-1-dwmw2@infradead.=
org/
> > >
> > > Ok, I will take a look.
> >
> > Thanks. Although that nudge was directed more at Sean than you.
> >
> > I wouldn't necessarily want it to go forward *without* Sean's ack, but
> > those commits were deliberately split out as the ones I genuinely
> > believe to be simple uncontroversial fixes, with the fun stuff held
> > back for later. A couple of these ones are even actually Sean's.
>
> Those changes are very much on my radar, the latest version simply came i=
n too
> late for 7.3.

Since they're mostly cleanups and bugfixes, I think we can add them
for -rc2? Or if I don't get the Arm changes in time, even for a second
PR in -rc1.

Paolo

