Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF61045A2B7
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516099; cv=pass; b=Glsff70D1/2Cq4QVRqlwjkTpK/CgUTB9kFs0XGXkyI68eHxGXi5+Vywbtkp5NCfqeH7tQTlcDSwgncD18u3TAVmj2K3LA7ehso3b/d/hC4Uwxs2ocycwFnQY0z8qrgyU53KSzRQ7o0ypKUi4m2zbQt+DgRyrsevHK+2GEXIFdlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516099; c=relaxed/simple;
	bh=F9xZYVz4ZEkB/YY1VXAwOyBTHT4hbBho8L47fEJ29BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klDUS24duOxMwxbCtChpRuKXfki1dyiBwsVqTXJPFmjvAkPCrZTyglcWJbGfHM2cUk8No0k+/tKN2z57cZWwe6dEx+axvZiUrgtBYLb39UVwA6QO7z75jCg3YWa7LX9SnJpPMx+5bLG3KUvOhJDaxnKdNOIrkWUUH5M801/Ffkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJp120P3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rl1VaN6F; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJp120P3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rl1VaN6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785516096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UHIITFZPqPQFJOriq8QiSbWl+sX2qBlUH+qmqlgn/Y=;
	b=VJp120P3CYTqKyfOtbsCca4G75pxy54yuMnknUWvSMxDWbePz1CPOlBfEXQp63md2zwNYk
	Vyq3Ai6dehAkyAYsxrIG/NIsO6k/QzvHIpqiPAhpqnxVvsPwWxZ8Jv3EuCh+t1Vwz2ZUwt
	YuUT6C9XRL3e20hJRVjW108NXKLrJPs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-wKUM4BkYMHqRvCO0dKFkSw-1; Fri, 31 Jul 2026 12:41:35 -0400
X-MC-Unique: wKUM4BkYMHqRvCO0dKFkSw-1
X-Mimecast-MFC-AGG-ID: wKUM4BkYMHqRvCO0dKFkSw_1785516094
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f83a59e5aso1677355f8f.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785516094; cv=none;
        d=google.com; s=arc-20260327;
        b=JmpupY6SNzPD20WSo9VXs4fyyXAK9kQww1PeBkqkg36+PZVza52SDeWjNO0siQDWtP
         /LKUfGlZQ5ObpxtrlCFlk938cuBhQcM6Gn1EE5qd2fUfmkQjZ1Y1HyoF5fN6lgllPW6z
         AAOAK/u8FmuSIM6aA+JPopK48AqgZqQAOCyp8gHZ6OZerbM8tW2BJJOuwpnloEL5JxLL
         m0pPeZZQGSrU5Mdd8pPzO3eHY1sG2ZrFhdRGW9asOtEqAwfXVqc6TSeI9s2+kgj/dZI7
         nTZs1HhLdWmfUO+cl+FNr1P6+Z28snZQswyk3mZ55KNWXFJdd5RHFqMtR1cqXI2KaW18
         ve4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/UHIITFZPqPQFJOriq8QiSbWl+sX2qBlUH+qmqlgn/Y=;
        fh=YZB4i75kqbtaEq4bW9eWNClh7cuXtBSHGo5PDjzQxnc=;
        b=IiNCAVF5tcxhCXoWH+hM3Rf66gfW29ggG+fcqC7OqKR8mh2YcFUfvFKVrtXpQWoGkz
         isJIBxY/0gddVZGAMnwOvywJJMovMXIuMsgn/ozS2ifAH7iyeUBjVurHS4dwEzsgS3dt
         H8Uh69ZtcsPD12By9e9cEdwtE5wqJVrodLbxdGO9yuPXquxCSaiXxeLKSFLGBsC+9bni
         Hux68bNABMESD67yS4fPOk6f7PpHu11N8HRdA5aCJLVTkb1v40uNriDlbLkfPnc3IWlV
         5y7hOanz+Kx8pf+FTzcbleNFUoEuhrj9TWyIuEZCIpYw7rO/lODLEpl3yZadUi1bmd3W
         Mr0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785516094; x=1786120894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/UHIITFZPqPQFJOriq8QiSbWl+sX2qBlUH+qmqlgn/Y=;
        b=rl1VaN6Fn3EjsrsytPgDAJYqNv5B9sFw5H8P5xqhbugduEGuKm7uRzjtn3aw2n6zhP
         Nw8tHWq7vnHfNs3x0LsQKCxAms7O50gI4mFBNtLYX7V/feSjFZzhgD1/xUIgIGWBS07T
         H9MdcxZJDNq7DYmyecKLny0Yyahst4H7zmGofqjCBUIqZD1GbXm3hEwArEkSW6uIc2wO
         X6gzP12LVfSBdTgNBnTQsCQMmIUhTrghXJhXz8nWtNBDE+Z8SeJGqV5k2M/TG22MTBrc
         9vUDlH+Zgy/l+F28PFcOE67Ks++8ioIgHVHLbU7doPgcflOJPSPdfmSUIWnm/0LQE+h2
         +XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516094; x=1786120894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/UHIITFZPqPQFJOriq8QiSbWl+sX2qBlUH+qmqlgn/Y=;
        b=ZyBEdDRrcRvAOX/kx2pRrWo+8/NsWDXVFq+6i3MBvH+TUsG0gXoGYoadOsLtMxwQ7G
         +Oxrp89bK8hFgxx6+Zs7uRVpJdZ/81C/hGEfIRfW/wUrjhAqXas/o3NF21MLiofAQaEt
         ZGbm0IwHVuryn+h/AmlNVePW9UkxpWDOOeH5LNIFBI7zxkTsHM9XoJd2pL2f81XGJRML
         HpiKoV8P/2YiaEMiDkrE3rVvZkucWLIj8s8MACpQOjhMbUpxBZh2qkRL4gvY43L3clkE
         UjyjEw/2/SsuBuuZFEGv9FWjIZxLfDAOMouC5wL5vRqkMYK029fpS19wPWPqZPUZuSZf
         BiuA==
X-Gm-Message-State: AOJu0YzWPsZhm6EBZ5255YTVlM7KEsWyJSJGNRlGDSM2rlhWf/YX178I
	CnpBhDbxbCiV0ycKnHY+0yBX0JaS0rBpXi99gHZde+oNxoX32zjcTcEDweRPxy4Ln624KpXfUQf
	IkGk3GC9LM+gmXUFtsu6wTyDwkP4NR6gNeoqRruPo40Y07tp26yDPiEFtnBU7J8J4FHtIj5scmN
	YZgcvIt4qcXtki12kdFyqR7uRD+Ift0lLUUvcfHik=
X-Gm-Gg: AR+sD13lUrPJmybsBH9N1opGmyv6qkgTS2r+a5A7w2Bltutt2WcdzSOQ4JfKlBWge5b
	Vy/099cP8cBX4DG8IEhcWisEqY2R96jxyZsMAFPp4rOuQSfwNunRgjHFK71AeSI45MDkmXynMbQ
	oR2TXQPlf+ldq0MCOnJOGn8Yb6+dyOb1pTq93U7zDsckEzOB2CBrxjkYLoW+eUKEPEhBh5tG56M
	R9SgWerEKpgnSI9yL3CDReyBZOE84OLk8q3UZLv2zqVVYU2UQxZz1DbDkw=
X-Received: by 2002:a05:6000:25f3:b0:47f:6fa4:58e0 with SMTP id ffacd0b85a97d-47fd72f15a4mr665695f8f.35.1785516093959;
        Fri, 31 Jul 2026 09:41:33 -0700 (PDT)
X-Received: by 2002:a05:6000:25f3:b0:47f:6fa4:58e0 with SMTP id
 ffacd0b85a97d-47fd72f15a4mr665651f8f.35.1785516093659; Fri, 31 Jul 2026
 09:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731160514.1101989-1-pbonzini@redhat.com> <20260731162036.1FA1C1F00AC4@smtp.kernel.org>
In-Reply-To: <20260731162036.1FA1C1F00AC4@smtp.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 Jul 2026 18:41:21 +0200
X-Gm-Features: AUfX_mwboGSq7mPSFXQ7e5KxQ3OYwhupahjJ5-r1wrcYmDVpP3Nemd0IWm0sYoM
Message-ID: <CABgObfbkqYNsPQnKxK1_4adXF_tSdtScPU5-Xrg-sXyeWfMVfQ@mail.gmail.com>
Subject: Re: [PATCH] mm: pull writability check to follow_pfnmap_start()
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 6:20=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] KVM fails to return KVM_PFN_ERR_RO_FAULT on write faults to read=
-only PFNMAP VMAs, breaking MMIO emulation.

Let's look at the bright side, I only messed up the part that *I* maintain.

Yeah this is correct and fixed with something like:

    /*
     * A write to a VMA that isn't writable can never be fixed up, as
     * fixup_user_fault() rejects it outright; report it without even
     * trying follow_pfnmap_start().
     */
    if (args.write_fault && !(vma->vm_flags & VM_WRITE)) {
        *p_pfn =3D KVM_PFN_ERR_RO_FAULT;
        return 0;
    }

before the first

     r =3D follow_pfnmap_start(&args);

Paolo

