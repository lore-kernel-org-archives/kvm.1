Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD003B6BEE
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356314; cv=pass; b=YAj8da5hMKbMq9DA2KK8VlSgALYJJX/lX1pl1Kz7QJr7Ua5vPG8RtdvuUwzp2GKUfK78e5PPuhV/jYm23wbqNMgZ7LZ7+ndQwO3+KYag2o4tfRJMNLeVbckX1mP8ffp2QilJx1ojhQ3EMBhN2DnQPI/yu91F2DucnEh41F8PZpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356314; c=relaxed/simple;
	bh=4LdAx9fvvsBB7MjnkYBLZN0nPHxZGz7WnwP8m1gHhRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwLa81PED/n+/eb0K9o/te+25pNuSUVIP8eP/YqbwDy3V/PBG2zzuan8Y64iyRU7MDmWgXRNIgHJohavY2P4CmvohJfShDOnL453f3x7KEkoUJHsOA2Z6zWg3VOxiX0fvWYDk5lwIUFbT6E3W55lPEVCH+pD/NsxBxVDwqyT0mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6eBGlE/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C550Dx8Y; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6eBGlE/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C550Dx8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786356311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTE9q723VNHgSKbOmtVFOArX1damMhZ8BQEArvWAKkE=;
	b=U6eBGlE/41LwwK4jPh/BeD0iNMAsz0J08ylvRx+vevO9fzM0eiHz7F1Ur8LqXvY+PtZ7K5
	a2ySYeA58ckc1qHmK+V7r+RtGCmz+NafjLtCaGWJPVw0+2eypzrfxrDdZzjV8IIZ9O/yUd
	Ws1cCSUflYd2+eJVW8zhe+CJHzpFEmo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-PzVYTjFfOriMwAO7oum6Pg-1; Mon, 10 Aug 2026 06:05:10 -0400
X-MC-Unique: PzVYTjFfOriMwAO7oum6Pg-1
X-Mimecast-MFC-AGG-ID: PzVYTjFfOriMwAO7oum6Pg_1786356309
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49955a9dbcdso10290965e9.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 03:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786356309; cv=none;
        d=google.com; s=arc-20260327;
        b=m4qmC9ITHVfjCiV/sMEoD6OeARG0xrdQxj8UArhza9c0U9Vf8JatB2Rk1hZkXJMWSg
         IELtwl31Q+ok/tPULcY/v1eeQZIYBouwYZZmKRTZ3xcR8GpQpvg/5igh1wkK4Q0r5TmD
         CKOn05RE8y7SlTEQoUZUFRsppwlZKtKkrXlZ9HZ9nlyjVFGH76HdChysmmBIaT4Z6eBD
         kecddTqTTvgtxcqkQoguNA/VYv6R3o1b3C1d3zJbwugE21pdw/YNtTrBjdypuJboWSIu
         ToiGtB/c//JaTa+Oa8+MjDSN8MLWB50D/dS8Ru2yiVbSUcBYO01mfKfzZzoyVwh+RVvj
         iPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KTE9q723VNHgSKbOmtVFOArX1damMhZ8BQEArvWAKkE=;
        fh=oaK1tejvwS0+TNSZQy9Z927lo43xjqOJIoOhwLoRbxw=;
        b=B4GOHbKvRVqYtYxmdg9JlGQkwXLfkBZgW6zLRFEnn/ifyCBJhM3jRpqyHlPIbZfMuG
         iWWiCU/21od+ahJEOqS0czduerHjtzgkIaEZ/VNDL+BApGw83JMh/6bJ56jHPf/644Nt
         Bj0gqCkracYydstgyiseO2loju3BpathabLUxF5vKjn41i4g+A9k9b7fjOTLCNQtum00
         JiWX0ql+LTcakuwkE5bA7Ql9BvFehHQnVbKq+CB17b+vGmSPr5+1u3d5K8DO7A05OCZ6
         wi6xZkUH9Ki5ydU6hKxmREQpcmfNJ16GrVPOthE8Q2r2k3pLLjan2JbA8GxT0qZcZzD+
         aF/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786356309; x=1786961109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KTE9q723VNHgSKbOmtVFOArX1damMhZ8BQEArvWAKkE=;
        b=C550Dx8Y4F8LdeHXnN+Nag7AvjpSQKSZJigSZZ96cHQU/4uJlKENkqe3evapvfrPWy
         /Bgzihvkp04i/sbEHSMDONR1oyVL8+nFQH5ixnxdiSihyS6EArcRGJV56mV6bDgg9k4w
         6uIIYgRkr6suElCfqPTEAi4PKGRNkpV72812R7c3cyIY3wB2RSXG7xRgOAZQDZRkchIQ
         VR9XVvBbfaGDa7goWuCZgFacuejAawigokyVHlUq10v+yPIGSRcKZ/urTa+iw1dBt6x7
         UO3AiQSynCtHlZ8o9jtGKNDT/cEcFktSxu3Wka254ps0arMhAEzif2FxWaIn5AH9Lg+U
         oQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786356309; x=1786961109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KTE9q723VNHgSKbOmtVFOArX1damMhZ8BQEArvWAKkE=;
        b=hUkUGNHydUSzmyFu235LlumSBnrKm80z7IkahHSOfYpytnw7tL+kAX3C72SAewM2Zf
         Y+GO8PHAj+r/5svg2rCdszKiDZVsusICMnvlaUIxGdy2AR7Mxrj5pgws91nRPg3EtDKp
         x+vlrh/wYRwZbQu6KGoNik7w8DFUWf48hyJjyYSleAmExzB/7BdHnnBx+tTJrVdHUklE
         gB6AEFIX1HZhYITSKEwicmzUSgZ/LSTMVXCBphOx4vj4O1v5pKg5ZKd+02Bzs2I/6jaP
         jrH9AUjMOivLPI/LqFL6Gf0Ew/s4B38RtrwXDUtJcjBPLEIfG2Oa+Hcgcvt9hkWRPAVS
         a28A==
X-Forwarded-Encrypted: i=1; AHgh+RqFsZ3DqhOBUO47U/rZ4fkY+r5E5JKJoYqHq6lBoxzR1XjSkfnYJqWRcPYhhFoJMpL0u4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59z7sj/JkDYh+OSAMUSQpkPJzKmFKIyL5nMeLFwhuz18t037M
	uMfIUSVDIwgmRVBbrDS/lID0KRKg9q4a+4gBFIFQSSjAR6pli1CBNY/PPcrYpFYmGMkp/APomyO
	nt5+b9xu9j4npESeDUpqMSgoZGA39YEUQTp2swyS1PX3s6EU2PpaYzbZ2QgBWiYUPDHi5PROmOG
	jewKfwHh1RpkYC1RbF2QATDM1vkj/V
X-Gm-Gg: AR+sD11gzsLwnLI+nfmhvaZeSQylDC5UKcn2ReLKeVF90ZplCAAY7E23w4sq6bhXdMZ
	2UCjTG92Plh/BWPRaIdXsST7Mwdoaf79K0nhQqM4ihBkApu2I9JXiRlMv5KS31qdsF22Wltm4+G
	AbIMEWfNz8IgNms50cw1sSm6edQFqwt6LbPx9lByYKTcp/M29WnjopJzjBbNQ7p4SZitk9zNqYh
	7VCHoF5sASm6net8DKlCR4tgqNGLPtbq2KTxACwirm4Hcr9Kb91RilpiTs=
X-Received: by 2002:a05:600c:3226:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-499727a3b84mr5344215e9.13.1786356309213;
        Mon, 10 Aug 2026 03:05:09 -0700 (PDT)
X-Received: by 2002:a05:600c:3226:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-499727a3b84mr5343835e9.13.1786356308812; Mon, 10 Aug 2026
 03:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-4-pbonzini@redhat.com>
 <49840a84-6d73-4a15-adae-800eccfb1c7d@amd.com>
In-Reply-To: <49840a84-6d73-4a15-adae-800eccfb1c7d@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Aug 2026 12:04:48 +0200
X-Gm-Features: AUfX_my6VzuSeHJgh3uVKaTYyn_VnWzP5xLi-qQ5sWEuv-5l4TAmINZeor_-704
Message-ID: <CABgObfYvz_SrBBXmzJfiW0VsQyRa8OWQdP7myfY=WAws63oguw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable PTEs
 when mkwrite is in use
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, David Hildenbrand <david@kernel.org>, 
	dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>, 
	Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, Sergio Lopez <slp@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 12:01=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
> > -             /* Never error on prefaulted PTEs */
> > +             /* Never error on prefaulted PTEs and never map them writ=
able */
> > +             mkwrite =3D false;
>
> As far as I can see that is a really bad idea, we do want the prefaulted =
PTEs writeable.
>
> The whole prefaulting is essentially an optimization for cases where taki=
ng a fault has massively overhead (virtualization for example).
>
> Wasn't vmf_insert_pfn_prot() making them writeable before?

In general yes and they still will be, but not if pfn_mkwrite was used
(as in the vmwgfx driver). I'll change the comment to "never force
them to be writable". Setting mkwrite to false is exactly the same
behavior as before, setting it to true is a superset.

Paolo

