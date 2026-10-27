Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793098910;
	b=tTqFLefAsw0DsMyKYBmN84oJ+AGDuOreYK91RIEvIw/18QpCRaT9W9tX7p+d865zLtbx
	 33OeJaTJsbqpmtC9TTirYYLLVIRZGtb/INu2m4GrCIC8xd/5zsOCIQ5nNQoSrIizVBWVl
	 EkiQyf5O4FgzcK8zQWAtxynxA0ELV0+1/150630eCupO2tHyOcYPX/DrSKrugmXtQ+7W1
	 B5YZrSbZghbrFLpd4lvZG/wE3YkRukc+pNkjrmuRPT1tPGnBC4FK2jMV8r9ltIA4HBgjN
	 tEBywkZ1bP7rOHcpeWcs0zVY8ql1zeJL3llooV+VX8rL6wDYma/YlEc1f05xeNHflKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098910;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=mswFdaLeZadM3beKHgTV0+pA+8tp/9smRtFllvNXA0g=;
	b=u6pahhLQhIN80MlK/RBGaxIy7U+v+N9xG4okBZQCjq+Yq5dQbMEDZMh/RCrJvq0nriEZ
	 dCbO4raTZUMdvGkV11T5izosK8x7kFFfYTNp7Tu2RiX7OeAimVnmyrlIIxaA8+DcQBkL3
	 wmsHuF9K94/tKHe0Az1uJWZ/VvjqZDiwW5aAs7TsVU3WMmWr7hqSVSV6XkojziED8A8NT
	 UdSUNYVQjmoSS5NM55LbKUo/A/e9k978DVnsCiyZYLu7qq77Z1f9Q/H4wsTSSKeG8fnwW
	 8XT+RpWjehvi0LVMwa2xauy1hoT3w1HEGnZ75HduPo2c7OimbDMji24L0DHZswfYxVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZcIFm6+K;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MyCJDhh4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14A606A31B
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 11:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A14A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZcIFm6+K;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MyCJDhh4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793098909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mswFdaLeZadM3beKHgTV0+pA+8tp/9smRtFllvNXA0g=;
	b=ZcIFm6+KMrPqs5XTHWruxYF/YnpQSS13+DVpBxh0cN85dlwzjzF5GcdWwaNUFTnKMCkXeR
	uuQjm1+bI3UVwfaBzt2W+rLWBnPEH0jJFlIbmC+jQLEBxboHRHWMfb0cg6cbsxzmEmhBx5
	3I9FK9SuT7qBvxGfxYsIrWfVC6mAqDI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-D4KKIO_UMDK60NWZMgRECw-1; Tue, 27 Oct 2026 07:01:47 -0400
X-MC-Unique: D4KKIO_UMDK60NWZMgRECw-1
X-Mimecast-MFC-AGG-ID: D4KKIO_UMDK60NWZMgRECw_1793098907
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a77c1cbd15so11363495e9.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 04:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793098906; cv=none;
        d=google.com; s=arc-20260327;
        b=evPmuYouCydzSw6xB4VhF3jaSSOQhTkcvnsFQst/mUx8/dIEzgbIYxqf1tTtR2ypux
         6QdYBtZxwlz7GSMWKvBupPtnAKojID+hYPXka7/cqYjKL1Q91HWO2VF0QA+IoNna9daO
         OcChw7ZDC1vWEqi2yEiWdSgeyv5xjtt6ub51l05z9zYLY16rLrKpIIonAHiKlSfKKQJb
         dvHK7mMRULRotHx3p7v/eljhJ1RODnCwCa/TLiu/ieqtB9oEyvaLb7axIOpLKV9WAcgu
         /9tzTu9QChisTzKXuGoEhj9fT95Qd7AfWnCirKjsrh4RDMNwUMpa/CY1jF4VCLA/5MPD
         jggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mswFdaLeZadM3beKHgTV0+pA+8tp/9smRtFllvNXA0g=;
        fh=xwspe8h2338NRKKvGrkhwjDwjENdHSKJmL+KUYnTXwI=;
        b=E5vi3vBCEDinl9igGGJKe2gj0tGfgMI7aYhCNKmEvaqGNfQXeHndUdcN4rH1AZzif4
         bU4G0CCGkIHDf84ZPBeSo9uTeKkrI5rApTf24NaWpMJXo7zbh2aHKjzF7lLZroyr+1ig
         QnUaXhzeYkjFuO50aB5fVRWEONGMDVKzggeXz7hGasSCUoGtL9KFGzv4gkVDIWyiMJuo
         dhhx9OWjKFCCu16uUpr379IFtlSiqQ/TdKae+RI5wVw8cQiy+NDZ9Jp8ULDk6LJ7G+lD
         xlhy4oY9P17xlofZS94A9RFnA9OFjQez1Mha6daiiufvOpBaSXS930htmG5hw/rU2OR8
         pheg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793098906; x=1793703706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mswFdaLeZadM3beKHgTV0+pA+8tp/9smRtFllvNXA0g=;
        b=MyCJDhh4t0awaj5ua+PfViuasF8XsJnahPe+pBlR28q7tHuIuUStaR8bdQCZS158LT
         ItliZF+jla82QJvCswfC0cTiPS+xwMKf80jEBIQ3fZ75MIOIw6vSaHkEZg2FzQNPM+kf
         lWJHWK0OInwhV5PdyUGpkSVl5Q1UapZ8O/uY3Lp6vUbmeVu4ItKwTrKm3pVA/gkP9qun
         Rjdn1CqceEWVKyGmpGDbBSq2g8IX6TEkHh1wfGCKu+NcqsdowN6ExFGwVfKQqXyrGQBU
         aiZtcSB7RAerVWoPaeZiytHtQLqgrKvVTyoyMv6lsFXjwWissUXi219M3SnjisyP9UoJ
         tfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098906; x=1793703706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mswFdaLeZadM3beKHgTV0+pA+8tp/9smRtFllvNXA0g=;
        b=T2GIR3tTA3jq5QVGw4G7i5iftXN6tmWYDjok7rUE5teJf+mIyoFWECTUKrSjrXeTAt
         T3Hn5R64xYksFXbB1bN0v0IphFkqvj5g/+Eh0R+2yP/s+R+K/+NKURFPX0Fe7zQ6KRnV
         3JoIwExxF241QhifqPdRpfutYxgg+2fQNrrkM3TIAF1fq/SHfSd4u56iDounvvVStqwe
         iAHhdcDGec2Z7aj292mQ535ZnD+ZyEPW2DQPy2z9bLUvtB4xeCcnA8Zwf2FYnQWRUcDS
         Z0oUty44PLF/XUuYHvo1RjSCfEDoR7ljkZMNGFV2qkv7ebt0nZgEy24Qh0sfUuowwO8g
         j9YA==
X-Forwarded-Encrypted: i=1; AKwUvBx+zdsc+wIRST1wRzuGwkVol/8q1kGYMoOJADOb/5TinLu20XoFtj0et8yuKY0aJyx0qEc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlIwmG+Q2Yaioi7IumThdTjDVTflLR+Noba5HGTodqOTRSWmnu
	Kxb8Gye47bgo2SnmDWJ3TxXNRp4x0WGEwh5jXmmfeGLQTa9wlfzYy3/I/T9HRWFhq96yUkZ16pe
	mjVDlpBe4+6fbj0TX/oIPlDULOGwz5EeX6j9AbGR4cSJGC6Rzxrl/699G4JguEOq+MmHXk0qY4R
	EBlS8I+O1DSPc/wNyVFTkj+A+wNGBo
X-Gm-Gg: AYBFou1cIc4/Z89wFv7Rlq6AopefQGlls0P3uc+zkkiiJ2k7YMcqqC7R9+CALRJeaXi
	+ywefizbGunT2T7l8JRrPsBzOlyorj9Ys4ms8Er6MMC1vYAI1MqNz8kq7oFfxJ7X4dQMJR6af1g
	nlYI3UMq3NaKOQi6zJx47vRzlM6Eyfs9xcijjoQfl0zXs01gLquhA1tPMReGsfheTc3rMlemN/L
	gADnLl7exk0QLIpxiVXwa1sA0R1TNMweyuwdUmRgW3IcKB8p6hdMsSCqo6tFw==
X-Received: by 2002:a05:600c:8b6d:b0:4a7:669c:c988 with SMTP id 5b1f17b1804b1-4a7669cc9d8mr64989155e9.23.1793098906387;
        Tue, 27 Oct 2026 04:01:46 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6d:b0:4a7:669c:c988 with SMTP id
 5b1f17b1804b1-4a7669cc9d8mr64987735e9.23.1793098905407; Tue, 27 Oct 2026
 04:01:45 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <at9ahKiYsVtH8kpU@google.com>
In-Reply-To: <at9ahKiYsVtH8kpU@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Oct 2026 12:01:32 +0100
X-Gm-Features: AclHuK_gMHxkpSkqtzZpmI4E9n3tRQVDE0ExdUQ32JdSX7MqnvWed3WEPGPoNjU
Message-ID: <CABgObfYgZ87=W+6E=N=WwTuyYkaoKU3hqd84JDTSAvT3_9dh6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm, drm: fix interaction of .pfn_mkwrite() with fixup_user_fault()
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Christian Koenig <christian.koenig@amd.com>, 
	David Hildenbrand <david@kernel.org>, dri-devel@lists.freedesktop.org, 
	Fei Li <fei1.li@intel.com>, Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, 
	linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, 
	Sergio Lopez <slp@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 2:50=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> > To sum up:
> >
> > - patches 1-3 introduce the new MM API, and use it in the DRM .fault()
> >   callbacks to install writable PTEs in response to write faults
> >
> > - patch 4 is a preparatory fix in KVM, eliminating inconsistencies in t=
he
> >   handling of !VM_READ and !VM_WRITE VMAs; these would return different
> >   error codes for a !VM_WRITE VMA depending on whether the PTE happens
> >   to be mapped (but with wrong permissions).  This needs to be here
> >   because the next patch would introduce even more inconsistencies.
> >
> > - patch 5 moves the check for writable PTEs from follow_pfnmap_start()'=
s
> >   callers to the function itself
> >
> > - finally, patch 6 is a KVM addendum that will have to wait until
> >   the next merge window; it removes yet another inconsistency in
> >   KVM's handling of !VM_WRITE but is technically userspace-visible,
> >   and therefore it shouldn't be included in stable kernel releases
> >   unlike the rest.
>
> What happened to this series?  It seemed liked something semi-urgent, but=
 AFAICT
> it got silently dropped?

It ballooned a bit and getting acks from everyone involved is hard...
Either I or Sergio will get back to it.

Paolo

