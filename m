Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2250535677C
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613516; cv=pass; b=npKnhqZvZRYRUu4+nCtBQLw9MeyjQ+AlzTEtreHKHHVzWtUuwa0Oje8Hhz7d085louWvTuI7KPVQJvwD+lsiJBpvlZcb5QZaAHoczlSnRWSA42HXrxNBUvc1tnQbF9xG+k+9/Y7enxNyRhBm8IkDeVwNSX9fkon3Jm2GO11AYqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613516; c=relaxed/simple;
	bh=0P3vVxz8gL7rCvQ0tZabWBtBKT5WGz1e8j8OWX2R4Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSJVg459pDxlqj25hmBD/kCyV2YUpK9hMz+ShSZjOPDSFdeW/IdwnxS+AB807SjA6pWeH5VUsaCi2bIwWRka79PdBD1Gwwuu4R2Sdxe1u6jll7oV/no4jG0F4F8bpa3FiOOmui68f+jyjcg1LpybMkRgXJ3S5alve/Gbg53Lp1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhqUVn+a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M62BtIKM; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhqUVn+a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M62BtIKM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781613514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fP4KNBPXal0xYsNQqxjqO+YJzAsH0o8zuMkqZPzvj0U=;
	b=fhqUVn+awXGy4Pc+zBbjZtMsWHLdXgyUMlFGJq3Cy8ah+WRrsZWmVVsb8BWkcaRp+XjNti
	+Zn6TS1gwoXGoM886fdjnB4KlzXVD1023az+cFMpwSbESy/J0pdLhEEpKDAKv9kTfDLWTT
	QHFTaKO82Jmej0lslYiDtAvULelqInI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-SAim4_u5P5ayZi9GFk7FGQ-1; Tue, 16 Jun 2026 08:38:32 -0400
X-MC-Unique: SAim4_u5P5ayZi9GFk7FGQ-1
X-Mimecast-MFC-AGG-ID: SAim4_u5P5ayZi9GFk7FGQ_1781613512
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8423f3e4728so3287225b3a.2
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 05:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781613512; cv=none;
        d=google.com; s=arc-20240605;
        b=JTdLfmNAm1X8EdrFdeZtanerDnj9CzdAUWuEdQCygZLEpoqKNHCX0IWu9iiS1vREoH
         gIDC4HfoXl7CJf6CIS1KvPlT4XZK6/+g6cQgyNgUxDQWmCdgNXlYj8M/ALkvBkXR9BUs
         lH8tRMlXn0l3WZt1pXHORp2UmnKFFuhrZymgSXXpy/SzCZFWsQJU0QTOfjdHJGp0eI2v
         xS3Ydz+aAiBy3moIsjlnQnDzGPRjMCPrZLYpjub3PSzxbXzlLhOwN4BVRxs7VXDBmMZe
         ZVIvzJQBAEL1EnsFG4vFo6FLxGM/8tXSW2vWM+zM+IHdg8cNKBjtY3ga0YBjfdQjLNQx
         Fk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fP4KNBPXal0xYsNQqxjqO+YJzAsH0o8zuMkqZPzvj0U=;
        fh=zKtIGbAB+VwJJ73yLtoho8EFZ97zUyTSNeKKjAlf5ss=;
        b=luc4+y2C6+4+Sc8bvpXQnLRTB5/T+uRND9Oxv/ZR+deu4i4IFrb+0NxIY34tgTDuRG
         s8LltNM0WtfQWUQa0jruAW2F3en+QgHoReUCNshhs4tvUnNIH0qoIdBE1+OrhAor8e81
         dr6fT9PElxpUPCjVWFdCgxjvgNGqPeEroL0kTFPytVpI+P6DJHwoD52Tj4pQDEbQDRzC
         O57gfT4+B6ZgdUBDjD8JJEtlXitW5AHC9M7FzoK4FMFCWtwgF/TFsGkBm2dMCI0Ldj7R
         6QZhH/Jjyeos4c7/Mi9hnmLhPVXIHHaXD5HQmw8vrhB77B/eh9NaTfZHqgNQ4nkMT+LN
         HB8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781613512; x=1782218312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fP4KNBPXal0xYsNQqxjqO+YJzAsH0o8zuMkqZPzvj0U=;
        b=M62BtIKMIFHABI1OzS5jbNV8i3KApbptxXFho72SCWlXvtyyL+dClL2T9vEOndOQu5
         3EkO5Mxhtua1hQPwV19gTsDUKy6ETt4r9Bp0evZj15hW7KI4SCMTUrcGaCDAq8y0XG9S
         AP/vOT8lKiwxroxKk2q2GWBWcVHlMFGm+wvY7WS6dBEg4HoHAIzi477TnuAZqKs7yvQp
         OMH5U+fnIpAk1PB+QcQd7G/rxxV2shPzz0r606vihwkvQ8yn6HohRY7kM3ZHHOxjBYxM
         5zgbHea7bgVBVQMFLYC4qceTo0cqnbbRFWAL+AuYZVQty7WJhqMm/wAv9uDWA6pl/4LQ
         g2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613512; x=1782218312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fP4KNBPXal0xYsNQqxjqO+YJzAsH0o8zuMkqZPzvj0U=;
        b=YymIF/xWPImFde9uRu2rq8CHDxMgkqHAHQrxM7w5yX0h/fku7yndvps+TXv9mkkuIr
         RjMtF9iq/Bqv7fNNvlS5F479UH90CvmiBEoeYH3LquXLlIrRjXpD4LJLQ+rlM2lPczUL
         1fu98GPE8jQs8DfxFfwNVEkdDneCQGYAuV5ok7VXE45YMJv9FBMdCeq0UjaLsdUBFlFj
         Sjr7xETt9pLcGAYRoZYcBdaFA0OL+24Q9uE3Gr+FJmx39/WETT5klbqnIrhmuOcRk0qF
         iH712d0mt+rbun2VB/No1YJXMicuoXNGhL8Bd6jkVtMTywYRZuN66egCISRZeae156Sc
         Qw8w==
X-Gm-Message-State: AOJu0YybM4BtoTjn+8hd4bGwuSxTMcqyKZbGMh9l0KH2UPpHrUKHwnrg
	/9PqtQvECyQFM7gtZD9XpGqOkZMyA+aAxKKPKIeqzamNHd5g7Y9ezd/9lKrBtNv7lGyshiBODys
	T0Wd3ssSENc8sualgu3Ct5vSCvQhX6h7+s0ZCVHxpWklXaeB4mp1u4gprYqOhl0yDEhBpr2RX6M
	W/5l6dykd/Q5TT0FJFp9Y9dpZqfL8D
X-Gm-Gg: Acq92OHqa0QnRvp/XgPfx5Xe1C5B5D+n92u4WKbWi9D+jrTaoHE667AqRrP+P56/X+Y
	IDbTC5LXAxY+3V17hnAzAHSXfftAP8Ypx4596g+Wyiy38ToDJsyfVbKc9sbEQo6RltKuTwOO2oM
	IpmaiY5cgbeGTEDs9RgymBsHI/bp0ZQ7oD/hXSentRS3zGuVRIUf0IuMq7X2mjaHEJ6NhhuAaFH
	BfY
X-Received: by 2002:a05:6a00:6c94:b0:842:4387:34c2 with SMTP id d2e1a72fcca58-8434cd428e1mr20194413b3a.10.1781613511744;
        Tue, 16 Jun 2026 05:38:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c94:b0:842:4387:34c2 with SMTP id
 d2e1a72fcca58-8434cd428e1mr20194377b3a.10.1781613511216; Tue, 16 Jun 2026
 05:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613000953.467473-2-tavip@google.com> <20260614001033.09CCD1F000E9@smtp.kernel.org>
In-Reply-To: <20260614001033.09CCD1F000E9@smtp.kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 16 Jun 2026 14:38:19 +0200
X-Gm-Features: AVVi8CdJ3xdYYtix7Dwx2xqbauFvL3xBLBVpRoZ9oXe-9Rk1Z5stZZPwcYGezI4
Message-ID: <CAGxU2F7TEKS_Uo7Ank8W=itbx-FgaQa6L3jTV6_WreCP-0Crpw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
To: Octavian Purdila <tavip@google.com>
Cc: kvm@vger.kernel.org, sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Jun 2026 at 02:10, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Exporting iov_iter_restore() and using it for generic transports is unsafe, as it fundamentally lacks support for modern iterators (ITER_FOLIOQ, ITER_XARRAY) and corrupts state.
>
> Pre-existing issues:
> - [High] iov_iter_restore() contains a parenthesis error in its WARN_ON_ONCE condition, causing it to spuriously emit a kernel warning when called with an ITER_KVEC iterator.
> --
>
> commit 169d794e6c649159c82a4c128f4edf768368df54
> Author: Octavian Purdila <tavip@google.com>
>
> iov_iter: export iov_iter_restore
>
> Export iov_iter_restore so that it can be used by modules.
>
> This is needed by the virtio vsock transport (which can be built as a
> module) to restore the msg_iter state when transmission fails.
>
> > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -1469,28 +1469,29 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
> >  {
> >       if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
> >                        !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
> >               return;
>
> [Severity: High]
> This is a pre-existing issue, but does the WARN_ON_ONCE condition have a
> misplaced closing parenthesis?

This seems a real issue, right?

Should we fix it (in a separate patch/series of course)?

Stefano

