Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3C41F353
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829844; cv=pass; b=BgjWmcSOgG2ydotefZlfAziOqBPcniqg7SkyLNVIOV7Jwn79H8VZT1GffOeXjVYJ4Rg/yc58yj5i7xvqVJThOhH/OkIQNyG8LJyJ3MA+WqywLFHuxtd20J01LQevuWTeR66rUH7WPA548CU/MYXuUNgktw8OTV8EXq9D1YyxEQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829844; c=relaxed/simple;
	bh=rrWIVUHqX1aTWPEdjHJhagxc6L1zuVCCqMoCE+Y7dZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmhiwnP8oCsvH9VkZnxfXy3njUjbeO0tz4QKveGvufntI8EDgmH5491a/pO3HjMscg5uqgkjw9v5DA3fALZqY6h1fT5InC6zmwRwbApQzgHSngRzIUg8jyA5DuDwM7XDF4ZSS/RB+E+pqY56aj5aBU+SA1o2+Uh/ojQgW56MkTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BGE3H9D7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRqbMoPb; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGE3H9D7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRqbMoPb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785829842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrWIVUHqX1aTWPEdjHJhagxc6L1zuVCCqMoCE+Y7dZ0=;
	b=BGE3H9D7OeUn+k2DQlmIPjBr8ONXeau2rx5JoJ/Re6CvSoOQlMmO6okceCTMs5b4GAnsR9
	eLoGDULfq7b1I2MBn455o2Zpq7UIzU183eMcVqrHVVjU7Axp0Ki7Y5nON+E8Ct0IQ2rNri
	TBSamEPabPMMrnAhEuf7VAc4A1nqyW4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-VvturYnaNHSDBvu8PsA5Ow-1; Tue, 04 Aug 2026 03:50:36 -0400
X-MC-Unique: VvturYnaNHSDBvu8PsA5Ow-1
X-Mimecast-MFC-AGG-ID: VvturYnaNHSDBvu8PsA5Ow_1785829835
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f8398ed9fso3873913f8f.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 00:50:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785829835; cv=none;
        d=google.com; s=arc-20260327;
        b=OOJ14d6o7RWxi6V4rD8pV5iby3JanUZsnoCb+O/hvin+4syxsSQu7CGc+3DXWTEaYM
         6ht3z9txEnOmeN9CyNUzd72yeQXNRdn1gvpmhwxWpAYXZh2o6sQXW8jfK+z8goCgo2dP
         zG0iBnpTq3ZZISAlzHHQkgaV9oorQEDZV5btR//+zdgDKbPJz1fAngBJVA7KlTQ7kYoh
         mPM/JFLz6vQkfDTLbBHivuxnY6mTiex0AIZO20WkQ83Y8oPRFEd4V+ewEqJm31PGGotN
         xaZqTzikXOwQ+1LuY2AkXovgoaZePeMgMo8FEQvItzS+kHtZFA1M9DEQsoG0TXFHFwZz
         EunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rrWIVUHqX1aTWPEdjHJhagxc6L1zuVCCqMoCE+Y7dZ0=;
        fh=iVFSQy7EGJXOoOTJ23qFK3KhiLM/D15Rirvgxdz2NlY=;
        b=lf9nw3MxE0e7GBQhYGe7ghgPHrdnY5Q1n1URFMeNro/HdjbwcocQBG+f5BFpxgmccc
         hebc70x3hrz5mfNIhovDGqOqWyoIJCLYV/ARUPxALr1tLDqdAO8VZftnHN+WskaipRl/
         1fQBODL7nQVIodRZBLWIOXvnir2xwS7w+pe6P1u0MHWFjcGyhGdzj6StVcE1F7fdTXNu
         0PR1phOgfN4PIW00k8I/KUcN+mNmvWdt+YvGjdOUx2AytgsOtkrsG1dN6di2NfmiXyWI
         1FtSoprp8ThXJUIb5xDo3f1L71E8PP/UjgDRJ7y+caw7URP/zQU98Nn2oapKBB0PMqCr
         kfSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785829835; x=1786434635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rrWIVUHqX1aTWPEdjHJhagxc6L1zuVCCqMoCE+Y7dZ0=;
        b=iRqbMoPbfq3LZzroHWy42oGW09aFKL2J6iqmJcQ/kQ0Y0daFiJIbdOzrEa1ZO1TMrU
         bi3WSPAonaxn3H6I4GvD0WpAbBRATd5UXFsZjEB2WGkxU1UGga8bVuiS33l6TWf3lDMR
         VDK1x51jvHhTt4ne/FGhT46HL4KR2/deG58pxe5E8XFU2IJys+zySxfg0YRMf5GnsgOt
         hi7unZlGGKuHivHO0iQcDFH22DmxVxFHlMBzUh0tgTlE87V48zS0zjjK72eoDG4kDSgz
         FrMVl7OjqfMCWQTKY5ZEwgJ6mfTNnNXF4dwCv9ZmEUJ6M6C5trW1QKlhvUeWWpmtZ7xF
         nKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785829835; x=1786434635;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rrWIVUHqX1aTWPEdjHJhagxc6L1zuVCCqMoCE+Y7dZ0=;
        b=MVdtvFR/GiTgGOERtkFiM1dBLGaHpYDfr7bIBCqcTsQWAPBAxbpiGEOpJJt/BRQ1Ri
         wElaOnkKuobdGGjjTA/jDh2XFrtXC7RtxrxWr41/Yi1ElHXiLQzc1FLrrS31JznkXagC
         0y5/wnKcskv+SPVNh5TbG1iVlYfNqIP8zilXNqDsCWY4mjEy0kkITp09hozOx2G9SRFi
         yhnj7mdhdYXxk6iDSemscPXDaOtl39pn3t3LhXygWJ6A8M7cUeRxkzJDI5dcnPQ+WT9J
         8y+VqBqmKqc4qbZOd+V2Fiv8Z0yNrAiz9/lPDkRj2EhYEySuZX0PnEX9ZO6yUe0sWk3J
         V7SA==
X-Forwarded-Encrypted: i=1; AHgh+Roen3iazJJrsQM1HXQINgzMljGbHTHPNaZMA4NHKLqovpL7RoO6LtO/G4+rnrSxqs4fCQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqyxN+LH/np+izy3peyaaCVyCr6cTHs5Q0mn/czQ7Jg/z6dKDb
	96U0ctyVvQC3X2BnkeK1X9PfoQh0wViE3Ar2Fy3Ru3xSBfTK4vbeQ7xKCOzPNj48eOJ9DsCLC3e
	28RbvWAZLuQ5PmOISv9C43fAq1+CTXrmIlz5ZaX8m1F13kqLd0tCJWiv05AD3DJHe9v3BkbOR5K
	sGKta2O1Kqda4+fSTOaNo3QWU4CQS9
X-Gm-Gg: AR+sD10G9LmSUKzW8klMLu3tjyPM6Gbv1sg+Lrw6p0c8yULfoPi2rJxdl2qgvNjy1fL
	oFHV3almyRyIlFfTwdfs1qRSEusN5Kpxtv9WWpmfY6k3aW8inTggXm8gfnUnyBuif0RixZ7d1C9
	+Ei7t6xkoZAXZZload8luy9q2KmiKZd9vFyzJUMrzgD93AQyAjAo1ClzEUOKBszUUoGu7gZIJ7K
	D6S09xA53UoxuYB3Lriv01BcbGtGUkuOWcMjBP8/lRvrcZ3gURu8uPWTiM=
X-Received: by 2002:a05:6000:1886:b0:47d:fc20:e7ab with SMTP id ffacd0b85a97d-47fd729e70dmr34032579f8f.4.1785829834752;
        Tue, 04 Aug 2026 00:50:34 -0700 (PDT)
X-Received: by 2002:a05:6000:1886:b0:47d:fc20:e7ab with SMTP id
 ffacd0b85a97d-47fd729e70dmr34032521f8f.4.1785829834408; Tue, 04 Aug 2026
 00:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731164341.1109827-1-pbonzini@redhat.com> <8d94897f-0f56-4ecf-bcc8-50bffd6750b2@kernel.org>
 <58fc5ce1-b6f5-48df-bd3b-054443c60cdf@redhat.com> <f556ae97-efaf-4e7e-b4f0-0f90087c8555@kernel.org>
In-Reply-To: <f556ae97-efaf-4e7e-b4f0-0f90087c8555@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 09:50:21 +0200
X-Gm-Features: AUfX_mzf_XARvVJuWyc5ctX7YzblMVOKgWg8l40HxuptWU1WxUk9kwBguF_a_eE
Message-ID: <CABgObfaCTroScRykMHRk6fLktzG7CT2Prp2f-CCCANfuagv_MQ@mail.gmail.com>
Subject: Re: [PATCH RFT 0/3] mm, drm: ensure .fault() does not have to be
 followed by .pfn_mkwrite() for write faults
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Boris Brezillon <boris.brezillon@collabora.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Michal Hocko <mhocko@suse.com>, Sergio Lopez <slp@redhat.com>, 
	Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
	bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 5:18=E2=80=AFPM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
> >>> Handling this in fixup_user_fault() is problematic: the information
> >>> about the presence of *_mkwrite is only recorded in vma->vm_page_prot=
,
> >>> which is an opaque pgprot_t, therefore only follow_pfnmap_start()
> >>> knows how to retrieve it.
> >>
> >> How is mprotect() supposed to work in that case?
> >
> I was wondering about the following:
>
> mprotect(PROT_READ)
>
> followed by
>
> mprotect(PROT_READ | PROT_WRITE)
>
> You'd similarly end up without the writable bit in the PTE, and apparentl=
y there is not really a way
> to recover from this.

Why not? mprotect_fixup() calls vma_set_page_prot(), the PTE as you
say lacks the writable bit (unless pte_dirty(pte)), and then the next
fault calls .pfn_mkwrite().

Paolo

