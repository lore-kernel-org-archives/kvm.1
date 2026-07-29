Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9877D3DCD96
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363676; cv=pass; b=U0DAAAqo/bBmc8i2yic6MePbrpNg3AxUC5K5V1AaT91AG3/5scnHuIsoYP5srNt2I4eQFtZpWb5ViCcQGOde1wuIsSnrW62NjStXF1qo7GqELczbrHW9iyriWMHJOuSXVtgwcfqLbnCsUfoFpPawN3IbtXffRJL45kmznYILnVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363676; c=relaxed/simple;
	bh=IKhB8+i2CpFK3T/BlrXLUDKbv/FSqDkVyYQ5Mc4RjYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGmJ1nwEGxlAJEV7Jf97bi7V9Jo8VXaQefmHumcRDzhL5YvxlLjBzwzuEmyOqX+RRBkQ1SN7Mbj1k2hiE4sR95RMAn+RuVMOHwA6svf8wCZB8T5jYRwWH+dt6YZFYw8esbbSKx804pcrF9vqJ5SiQ/FUNP4HShPCLpgW5x2z0Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzrrZ6Mi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jj+aPZKH; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzrrZ6Mi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jj+aPZKH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785363671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRMe1gcoYiqmBeNR5vKRg54P23wOOoNCf6X284VJh8Q=;
	b=VzrrZ6Mi9o1tPbfSedpeBnTd8A/lMRY8OoMRQg/GiULQUZecUE5eUUsQ1nO1BhGXuU41I8
	qrxomw9XzuSBbifCz7McOC3sWso//OVqoybsjbwvnctIwOFizcwrEB8hmmAWpOPMT7rsma
	oH2pQMpoBbMXa0lV3yJkGyE7iqAWF4s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-g79fM_jqN726ucHaUrepdw-1; Wed, 29 Jul 2026 18:21:09 -0400
X-MC-Unique: g79fM_jqN726ucHaUrepdw-1
X-Mimecast-MFC-AGG-ID: g79fM_jqN726ucHaUrepdw_1785363668
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f83450a8eso1285861f8f.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 15:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785363668; cv=none;
        d=google.com; s=arc-20260327;
        b=OZbeCyfDtCKY5UATUvDqkNDY6D9jzfYIfiOSkebdlscqBrEY9bYl7tMtg8AWYY/tDK
         JrEab/aBDuQceNTK4MArOwO5ONVLnzB3jUhOK9iXUUhNQvaYD5OzdDTtdbH5aA+5d3G9
         qMKj7k5Sm4UJNrQme9En8mg6VP91u8jpsft0WQJRBQpKr1yvjlelCxII4YlnqonfT2ax
         M6xIf+4FZgYO6Wb6YTGm7ADrkVPaWox8oqdTnB0Hkn1s1YDIXkAQ0Y5TN6wnqH9p6bns
         vKjoPIcNHGYy/Z99f+yvv3Qb6I/SymsD+BUu4vKoEwjeQQ9AHh2Kgx3GyiR29K/mZuEf
         oJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BRMe1gcoYiqmBeNR5vKRg54P23wOOoNCf6X284VJh8Q=;
        fh=iYdkCxoZYcXgBWx6aRa0xNYNS65Z8Ujc0t3ZzG6HVNU=;
        b=EqNwtPrZFkoJgMKai5augScHr0pc5GBu4cuLvoxLxvWkMOdjhY4lhi/zSEwhKUWMj/
         Fhoh4SrjPgP+24/DCg2dpKZzup1q1AUuFfDcDkm4H5/21Ju2sGd/MosRddiREwop4/nA
         X3OGjTcvH9ruZlq28S6ECJ09FSVHPK/3ZSJ5nFiieinbfZQt6uZpYyPohRAmnyBULi9K
         16V0k4JrSSDC2nS63OVowylss1PR07elexk2MZFV9egqzJbzmfT+DUq7hDOHL+AN0i3t
         asjcgFHXbib2kY7eQr3pqgiNPJvnuXxUT3dYUVWG+KDaDAujkks3nJocQDrOG/IL6hRO
         EtGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785363668; x=1785968468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BRMe1gcoYiqmBeNR5vKRg54P23wOOoNCf6X284VJh8Q=;
        b=Jj+aPZKHrXMgU4ZfnusNlAOJYnCY1mG2M0pP+VtH6IMhMgYmDwY/lxWFxtLxSiMDYA
         TXHDxYTZVz9f3DYOFqHGEDtzIP/5d33VoBzhZhWs6kPzdnMPTIy7HRGajtP569tfT6QS
         GbnVpSc3nWvuONSSjxdr1Wd9W21poeDNFuqDXjTaX73Dz9JH7vx7xKulq+eTcPpqfA9a
         Ju7QD017f8pgT36Y4wcMytEApTDIRaWOcG+IrLzRsTQFlmO9cMr1lBkN9evtbRZTE75i
         yhvYBZBBrDGBZF22oG7X9cr2hLZ1Ma1Hy3Fkgo9aXI9pBzbFgsMaSNoFI0DRml5yd3pS
         2LIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785363668; x=1785968468;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRMe1gcoYiqmBeNR5vKRg54P23wOOoNCf6X284VJh8Q=;
        b=C8UnHrPtxbPOuSyJHI5Vvs11kVM/SiKRXoKBDVJkW/KiYCJyvQpaPEX3SZez2kvbKX
         RGJwqNbHSBm9TuNuQZOlXu84BlvGEbT6qPQCi/3S4YDKFXYuZvvM5xo8UjZOvWPBXY+H
         sh8XNvmK9LwEahlDkxNsmeB9GJ2jaAk5JBiB8gW6LUUOMzGf6V/v3LWuJMFcF2R2vQQ+
         /BABoHpZgvv14D+XHFL2zMNlyar1Ovi/V76ZGtjlNS5voUrE0veP4SmXTF4duZ3iReTa
         VHLa2RlRzs29BVYoirGJzM2S3OJ2VilgdzCdNh4SAPqFPX7tkG4ZwlR3mSDItEE+EPVk
         bQfg==
X-Forwarded-Encrypted: i=1; AHgh+RrDKsPpIClFfR5k/NZi/QIsErq/jZ9KyMZ/KWanUvHxIj6W33WSPUjw7eurpT6JWpBUrsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVNob11YJJ8ajTjMEw/5ejbTYLUx4Ub2X3FQI+cm5wTBvwrNBx
	z8AtG11oJNv1rvalF8x88kqVESWPGwLaYC/zgwM1rqwGQlAkjrwQQHjFgsIGq3nGx4Lqq59DNmB
	bbubdUUX/yTCAi2X+IoyuUe4gWez0+Nz4sUXpZi2rWX2q9kaoNHWmDAV1O2KkTR4lQ8eDo/qbOf
	4Uul6hLf9XeXudL2xtLGcaudVOqTHK
X-Gm-Gg: AR+sD13PJYT3tTbWC27sSGJeaE4Is35diDCRH1uBiq/ov6tTg6vGWbhUFPyNehtCNnf
	tHLR3pKVLhURIBMCPCw+1figcgGxtxYiQMgPuHCnIltj8r05iTZ2JIi5Da7Jm5rDMdV0HNv2wzi
	9rIGEpPb6o19nH2A1Wmp9DuI8FDV8SRJueuFnAQL3MXdKNW6sn3JLRtYqAGhLpTM/XhegDwTNXe
	hZwrpJYpxFrdhXholp+mwurogUMrXnWT9FZsTtWnprw6Jpcm+9CRhsncSo=
X-Received: by 2002:a05:6000:25c3:b0:47f:7261:3a58 with SMTP id ffacd0b85a97d-47fc80c1423mr199744f8f.1.1785363668588;
        Wed, 29 Jul 2026 15:21:08 -0700 (PDT)
X-Received: by 2002:a05:6000:25c3:b0:47f:7261:3a58 with SMTP id
 ffacd0b85a97d-47fc80c1423mr199730f8f.1.1785363668311; Wed, 29 Jul 2026
 15:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729214500.651377-1-pbonzini@redhat.com> <CAHk-=wiK2vQfiex3JG0ZiBPfWqc=JnTOyyJBF86+GoEcKJ=3Cg@mail.gmail.com>
In-Reply-To: <CAHk-=wiK2vQfiex3JG0ZiBPfWqc=JnTOyyJBF86+GoEcKJ=3Cg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 30 Jul 2026 00:20:56 +0200
X-Gm-Features: AUfX_mwAC0trQwsVYQwIMnaVTSPJG4d22UtoqXE-t2i6LHZaLxVI0Th721Kzovs
Message-ID: <CABgObfaLZzBsC2B8xdbW6pds_UyaBRmXh_eBNrn=cBVAPrj2jw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM fixes for Linux 7.2-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 12:02=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 29 Jul 2026 at 14:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > - Add memory clobber to asm for VMX instructions; without one, the comp=
iler
> >   could reorder them in troublesome ways because "asm volatile" and "as=
m goto"
> >   only protect against removal of the asm.
>
> This is simply not true.
>
> "asm volatile" is not just a "don't remove". It is an ordering
> constraint too. It cannot move wrt other asm volatiles.
> So asm volatile is very much a "you can't re-order this asm or move it
> around significantly". [...]
>
> But at the same time it does *not* necessarily protect against the
> compiler re-ordering *other* things - like regular non-volatile memory
> reads and writes.

Then I was mistaken that reordering of asms could still happen without
a memory clobber. I agree that the commit message overstates what the
compiler can decide to do.

Thanks for the explanation,

Paolo

