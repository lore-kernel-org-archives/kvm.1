Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592A306D2A
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873056; cv=pass; b=LeV91pEz/Vm5D97CjAKHn8mDRNHiFDStzO80tIqUbafPyQ2XrDVhpKdV3fs+evi7PvWvctZ6GQ6iHxRowbQj5KMSbzwmOuf7NU0a12mol2lnQLmEGk17Stz3+D/yejtnJLn/kea4H1j1ZNeg130y+85vMoAcNB2X2dzHV42jNtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873056; c=relaxed/simple;
	bh=ckJFhNb7kzwvdnqqS1RjoBTIurchpN0UBLUGxzqwVKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGlIpGw7ovmsSh42+vZToe5nC7gbvUGF/d4E0Q7INgUDwl/SenjDbRKoViLPmhweQl/1u8y0BBQxh9iuk8CJsFfH5Q3C+Y3VaybsJq8XcaqXmQXskt3Z//owxuTRWsOuVThIK+oGNqcanvP6gyxUTzbD0Rw26X9L2Wm1cTheRsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQINSiTJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJMeSpMs; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQINSiTJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJMeSpMs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774873053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3czNvgtQJ29XTaQ6e0CJrK6m6/6KHxyqrNxsiklN7mI=;
	b=QQINSiTJ92OA3NIwXvrafCym6dRPxVrjx8WnrzD9lNkJn3GW2AUpWmbviPuhbj1KGiF083
	e2u+Tx4aCuwWNx0Ru47ip/Ydt0mMHv3zSXb7wZWGAghQMuLg1epi4wuVlTjK1k2+HQ735W
	MfsK3TUEVI+/gw5dnbqaIKBUHw8aMNU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-wzz-KN7JMEyTJABhZ1oZdw-1; Mon, 30 Mar 2026 08:17:32 -0400
X-MC-Unique: wzz-KN7JMEyTJABhZ1oZdw-1
X-Mimecast-MFC-AGG-ID: wzz-KN7JMEyTJABhZ1oZdw_1774873051
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso4060748a91.2
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 05:17:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774873051; cv=none;
        d=google.com; s=arc-20240605;
        b=HpkoZ6xcbSKKSXIjhEsgkvb1gmEYyojuu8SstsR+UYNI/0vKnht8/G4fLC3NHp/fWj
         M7e/9UWBx9y9iaeN7onoN0OR7hv6dkPRSVcfZsz99EeeksnaUxsTTqNuv2UZLPF6WpGU
         KcWmmn9ZiZwOe5fHu3I4oXhJ4iZb9bDc0SyvOykp0MUBQwK6Qd80D2JNQ+VN2zQSukca
         +hrQqg3C/wDh4FePzGDyF0iLv8qbyLRf2vZIBimLtvLPbLC9tHTZV0SJgjAdR+Gmmj57
         JbMWmATrGhuW9Z6PShGegVBETnGSaxBfVgX1hfLNPP81wu8vOpWWvO0AyXIVbxTE+klB
         9BTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3czNvgtQJ29XTaQ6e0CJrK6m6/6KHxyqrNxsiklN7mI=;
        fh=RT8IK1mmEg8Tc0rmWXzFyGTfbHIqYyhG0v0iP36m4p8=;
        b=dr/eC1RCoMULyy2dVaVyyYEYQodaQtyWHXIRpYIcZhVHW3cpKdD1l0UY3tSC6F2r6b
         FPNTnMGb5eDArna3Xp4PRJ/KDeBijvzZUdPQ7auav55522SbpcFFKCrCyKDpJN1uqby3
         SJ35O4rnlQsZyT/RH8m1pRc/SkChmer3W9brPmnflOWRhJFevTAuNsx1Uc06TXjHPoAG
         YSk3ilO+dmOdpX/WNqtixN0TeJMpZ4hkswz172W1BSG9d119nnt8iLDIT59KHem4I0Qu
         tepsD/09htsYNwGbSTKtnGs2MVYMRLJ3Q09DO6smD+alqlp5dPwk6udqQpeA56xzrY9x
         iTJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774873051; x=1775477851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3czNvgtQJ29XTaQ6e0CJrK6m6/6KHxyqrNxsiklN7mI=;
        b=fJMeSpMsG3bQz6zZz6co32bBc9hF9CsS8mZho9xFP0jNRvYwF7EZijZWcG6GIC/itq
         imlQvyH0kmjUl35MaLjoCw68jI3l4EYH8+wwkw+SjMIIJxrE3Vm0zgbj9YSQFRGDleRv
         L5fWrRbbtskCNA9SZ8f6KDdGm99+EbUVD2BNik/9vN2lhcPgMZvVflzVqx+quVUh7hf+
         sBn91z0ndabV4ZEYiAB2gQWJBv8V1sCppWTJeT/qRnMG9BoYl+2lfHJ0g2zTQrU1coN0
         HCeWoA/d6rLS5+CU+y1phJM2jAtCOYE8OQneVkofpFnq3XIFQnh+P97qTqe+GLa6SDmR
         i7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774873051; x=1775477851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3czNvgtQJ29XTaQ6e0CJrK6m6/6KHxyqrNxsiklN7mI=;
        b=dvywvhE0M0J0KqcftDy6pL+nenX1dahYkgYKEiEUYN4QwLEFigWTeH75EwOaLgom8p
         duiLhRLDGN8+SY6EUwllWSENNlLH1Nfkbciqr+XZzsTbhtOPXSV1O+kRdTcEo2rcWLLe
         hllWYBt/rPyeYn5t3EXXcedG7Jlj6Al5ZYctBpXmsdI6+D6PIQ2oxX3gEBfqX2VqKv9n
         0vzXImeiiVlyvkgQkwn9q/f148QxeGc3RcipWcz7q+gLRfMiOxe/gwDAfyVQiHlZa3d1
         boOlV2btRRcBWe08F+/ArbsCV8H6uon4AMFfSYcSNEilIGovkOmMLhc7oLGuVsyDiBCf
         ouIA==
X-Forwarded-Encrypted: i=1; AJvYcCXln2pjA/HhxhyEOrXtyRwOAJRgZzCKBURJSSUEKFEE9RMhM0NNJYMnzfVemRX0oMPiUCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtO06ZGKTLpSayPwbG49hn8bKhDkUxRZe/sjveNso7z4AkEsry
	afmZ61u9ez8GJubzFHBBXElIss8vAEiGTJoWYkG4k3faCVW3P47g7YGiSdfWTFfZPcXiUJIFmkj
	CYkOlrDwq4hAvBpiJW9r1iAH/wbGjaYFOC1od0XNRC0dhxTXR3xyURcyS8tTA21YBmEwLCS+lEE
	UTyYAHnSibI6fKD7engBQcFw2ZOmS9
X-Gm-Gg: ATEYQzz6BFTp0fBLjmR6SDz6ILo2mQtHgdwcpG0Yt6NV7njrh0dEdoy4BGfUbZouvGg
	cQDQHrdNGfGkFoyIF5Ts0nVN4rQ6nS+eAVzWTtFXdKXdTyU9iHy9b4CSsdfYBGAuSTDE3+w25wZ
	EHNXwdFW8SPVD/7Xq0qViLL0aXV/zehD3b1wDyZkdyGS+/44Mmxdi2m80kWkb9LwziCWg0lokbG
	RJ6rbc+Zx/+BAG5VbMo1OJLk376HaV+42naDOX6TgtgWL+qJCNcDFeoenhZ2jakIuglNrG4fefu
	gQ9W+veCY8c22FrZYYA0Akg=
X-Received: by 2002:a17:90b:1e4f:b0:35b:e593:b1d7 with SMTP id 98e67ed59e1d1-35c3000dbc0mr11187015a91.12.1774873050880;
        Mon, 30 Mar 2026 05:17:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1e4f:b0:35b:e593:b1d7 with SMTP id
 98e67ed59e1d1-35c3000dbc0mr11186982a91.12.1774873050418; Mon, 30 Mar 2026
 05:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com> <acY/rr7g+gJmkXfg@yzhao56-desk.sh.intel.com>
In-Reply-To: <acY/rr7g+gJmkXfg@yzhao56-desk.sh.intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Mar 2026 16:17:18 +0400
X-Gm-Features: AQROBzCFzI_YLOmrGuKXWfMmV1P1xMrwTYyuuKfPwXwr99gqlL-4GhNiZZ8v_pY
Message-ID: <CAMxuvaxtNz_Kpxv4akgGEY0PiY+dAg10nAJU57RP-pSEVHVgDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Mar 27, 2026 at 1:09=E2=80=AFPM Yan Zhao <yan.y.zhao@intel.com> wro=
te:
>
> On Tue, Mar 24, 2026 at 07:21:48PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > In TDX guests, hotplugged memory (e.g., via virtio-mem) is never
> > accepted before use. The first access triggers a fatal "SEPT entry in
> > PENDING state" EPT violation and KVM terminates the guest.
> >
> > Fix this by registering a MEM_GOING_ONLINE memory hotplug notifier that
> > calls tdx_accept_memory() for the range being onlined.
> >
> > The notifier returns NOTIFY_BAD on acceptance failure, preventing the
> > memory from going online.
> >
> > Assisted-by: Claude:claude-opus-4-6
> > Reported-by: Chenyi Qiang <chenyi.qiang@intel.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  arch/x86/coco/tdx/tdx.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 7b2833705d475..89f90bc303258 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/export.h>
> >  #include <linux/io.h>
> >  #include <linux/kexec.h>
> > +#include <linux/memory.h>
> >  #include <asm/coco.h>
> >  #include <asm/tdx.h>
> >  #include <asm/vmx.h>
> > @@ -1194,3 +1195,40 @@ void __init tdx_early_init(void)
> >
> >       tdx_announce();
> >  }
> > +
> > +#ifdef CONFIG_MEMORY_HOTPLUG
> > +static int tdx_guest_memory_notifier(struct notifier_block *nb,
> > +                                  unsigned long action, void *v)
> > +{
> > +     struct memory_notify *mn =3D v;
> > +     phys_addr_t start, end;
> > +
> > +     if (action !=3D MEM_GOING_ONLINE)
> > +             return NOTIFY_OK;
> > +
> > +     start =3D PFN_PHYS(mn->start_pfn);
> > +     end =3D start + PFN_PHYS(mn->nr_pages);
> > +
> > +     if (!tdx_accept_memory(start, end)) {
> > +             pr_err("Failed to accept memory [0x%llx, 0x%llx)\n",
> > +                    (unsigned long long)start,
> > +                    (unsigned long long)end);
> > +             return NOTIFY_BAD;
> > +     }
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block tdx_guest_memory_nb =3D {
> > +     .notifier_call =3D tdx_guest_memory_notifier,
> > +};
> > +
> > +static int __init tdx_guest_memory_init(void)
> > +{
> > +     if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> > +             return 0;
> > +
> > +     return register_memory_notifier(&tdx_guest_memory_nb);
> > +}
> If I read the code correctly,
>
> online_pages
>   1. memory_notify(MEM_GOING_ONLINE, &mem_arg);
>   2. online_pages_range(pfn, nr_pages);
>        (*online_page_callback)(page, order);
>           generic_online_page
>               __free_pages_core(page, order, MEMINIT_HOTPLUG);
>
> In __free_pages_core(), there's accept_memory() already:
>
>     if (page_contains_unaccepted(page, order)) {
>           if (order =3D=3D MAX_PAGE_ORDER && __free_unaccepted(page))
>                return;
>
>          accept_memory(page_to_phys(page), PAGE_SIZE << order);
>     }
>
> __free_unaccepted() also adds the pages to the unaccepted_pages list, so
> cond_accept_memory() will accept the memory later:
>
> So, is it because the virtio mem sets online_page_callback to
> virtio_mem_online_page_cb, which doesn't invoke __free_pages_core() prope=
rly?
>
> Or am I missing something that makes the memory notifier approach necessa=
ry?

virtio-mem doesn't modify efi_unaccepted_memory bitmap (populated by
TDVF code when the VM is started)

