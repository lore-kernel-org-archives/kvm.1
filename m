Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37127559C85
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873892; cv=pass; b=Zcs0xQVNVlLWQYdMt/1f8/eJGJcXyGquKpEw56lws5zzPTup+NpbZ7X+UaSrn34aspjfF3dTrszDMF28lsKcVJXfFbYHb7W2EYIqYKiNfWAk0ejq+K6mQHLaQQ/OJcHjINijP6mMpCSEoA5nV/pC6D/C+p6qDiiX7ISqT7nyeoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873892; c=relaxed/simple;
	bh=dFLlZT2EKlWaeVKULVaXRWxesk0XaHf+l2unzbTleo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZkjz1Rrl51e4Kws3sWL/Nm8uHUSSn6FBH3mgjLVC38wii7SUIort7AqC4DCDgsN0j9Y/2pJ0pmJihliMPt8YEST9CsloetXketE5gc1Eiz83K+ITeML3D40oZPtJr+597UYRA73iQmuz9zvH4j6Iz5VF6W5y3+gZFATBJBREnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDrM++yP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pQcX0h+2; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDrM++yP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pQcX0h+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788873874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVuYzY9Z1mfYnQAxkGLzzI+Omnfs0bqwXzGAsofBzpw=;
	b=FDrM++yP1mdlh8m0HHEHachosBEsNXqlfWlTC7/SsjdQwj0nMwIBufFaueLzLfW/gD2po6
	E+mYIAMV5h3jjeQFa8Ms+U7fpzo7+uN3KfBPbsN9bhqr0z7UxeedWG2U/sKy8GUoIUTIhF
	tttTx0ZXP8BT5Zq6fmB3+5zZ/6TRSbo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-YNFfZV62MSmU0zw8gN1Neg-1; Tue, 08 Sep 2026 09:24:33 -0400
X-MC-Unique: YNFfZV62MSmU0zw8gN1Neg-1
X-Mimecast-MFC-AGG-ID: YNFfZV62MSmU0zw8gN1Neg_1788873872
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-484357599a4so3160320f8f.3
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 06:24:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788873872; cv=none;
        d=google.com; s=arc-20260327;
        b=PSOLVmy40oqZ/glVz/8J6UczlsHKzNFMs/zy3kpOJ1CTrs12Q+uipOaI6zMRda58ss
         /rqcYgSQqCIZsr42ao8LRwfff65Kud6Y3o1+2I9s9YjTtF7DsHIJin7ISQ3OB739szum
         ooDj8FVZwYlevYMNZBQHoNdXsNau75QYo81h68D+CSoYHNR1v9bziHkuX9cgOb+ftQOU
         RjAdbxTpWDVGo3SHm/j2h9++uLZhWrEmc9bu4Bir64Yzl6SjIrjr39GhVwW0V0z8/Y9E
         MaXTzfdWRh13eDJ73grsB9+xJJ1tiLlakhMrWAA7si8qK3pkJ+km9Xu29i3baKJqJ7bf
         h5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XVuYzY9Z1mfYnQAxkGLzzI+Omnfs0bqwXzGAsofBzpw=;
        fh=jjS2zSl3KGcX+egmSptUcRq2XWnf2NANG13YzqPFmag=;
        b=EGhTYU2bpsrDtJeJXuFvxPb8hmxZlHcf1zYOefJkkxYZsd5ctGP2yQMtt8PXEKfmAG
         QEvBH1pmCn/EORGEQwRlU8lAVN6SQ9u9d1hakBqYrqU1d7M3XSdcTGlGriRNOkKUVVV1
         ozAd5Slb4kETVvJd/4um/NWJ3tsO0gyvTi9t5+Dv1YS61X4FRCNsPcaPSLmAPkXK03pR
         diUl40Hu0CevZ+rQB21MeKTAtZoNUIZ3JhXvxGkjl1QCBSDkr6E46zokDnkKYXZdE7ZJ
         OFDNdUwnzNWQOA3m6YYwjSsfVSJBP6D5+neIDKFaqKBD+TrWmlIf0Y9jdS11o1GobijH
         qnpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788873872; x=1789478672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XVuYzY9Z1mfYnQAxkGLzzI+Omnfs0bqwXzGAsofBzpw=;
        b=pQcX0h+2cxCMbyYL0LmQ/Wf5tPgiJZZw2T6Tw1VGBRYKO41dLzHTKBX3N9WNDexuGE
         /SKE2Y8rm6eM+o4stZyzJOBaJQXnpN+nIUl4DpkTUWkOCnMpLrCpUknZCOcEErFuRENc
         s4TRsVINWfkjn6NXkltw0EvYtkoo0jCdQiComQ7yMSx1/15yb8lO0wHzpTDaFVOUD3WE
         13jZ464lqre26COKvVRg2JHLtlXIBMBnbPTqAmVFxL79SoEcMab5jyKYpxZbb6bupbQy
         vElAKXe8fOWMB3/OJcsj7muPAkTU9HBM/ukh/kcmHXyjv1R9/WeraSWFIl5cdtbVgyl2
         2G8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788873872; x=1789478672;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XVuYzY9Z1mfYnQAxkGLzzI+Omnfs0bqwXzGAsofBzpw=;
        b=VaH77I+01QuVq53eiXHBUqtv5Xq/IiM+8jb5DQWP+HVaysSUAc0uyC+gERGfCDugha
         Qs6rZADHXmZzl85BSoEGWpkP6mNsgQm00/n2P9t9VEjgAwpebG+dA6ckLow5SldFCrfd
         suF3FJwEtt/ysYF58wnSrsSuA9zUbDYmGYGtDjHu8V1bpLI7jnAd5hKYIAsiSbNz29OA
         0Y2dmzPXyd/ZQU0br9dSrTcrEOTScZzohC813F+UMBR8coFLPji722kZQxIwnqSb9M7f
         CrObu//9rjSU8CEZjxH54PsnIiUeITXw+bTsg9yixfxQUuzghJMpcR4OdVlumV+2nNFN
         qGQw==
X-Gm-Message-State: AFuF++lSClRE+jaWGaIgqozM/fXH0SunIQ9WuAnt+k4amnVB5p6my4sU
	nytrXNn4vcoh0n/CddvuQ0nZCznKPwrVV8wManUyd8CoCSLRDpetePBQ7n6QblMncMBda2mJdam
	w6pNMnNlmPEDtYgoxqU169X//PInUOIDFgLG7kuDT4t1MzArF8HclmXtKsYMBO1eBFbwRGzDI/c
	dFZuW5c6XzhSPjh6EEiw48o306W5Cx
X-Gm-Gg: AYBFou3CZYuhYpZkePxPaKg9peZdYvHNnPg78HCU1mzYWRXT49lbVh3lv3tfOXkY2qd
	ISCpZbAYFhqzcdGOqp1hy/NVuLC+KkZNKuXFLwHftGmWEwImn9C1RdMw3hljEEGgN1DGuUCXthI
	LepKqVw4oTd9DMVVJj7eJiT5kzHCzK7+QKK0ffTOiNjnc82xASeNUfzQwuVoweRa0Q9uVgxQ9Ip
	JcLeRPcaJ1sH9gqPlyAzhRNYcZmNH6YEv7/Ncwl5B/pRzE+HEONWy5zEbvwIA==
X-Received: by 2002:a05:6000:470a:b0:485:8101:dc40 with SMTP id ffacd0b85a97d-48587057037mr50259787f8f.9.1788873872087;
        Tue, 08 Sep 2026 06:24:32 -0700 (PDT)
X-Received: by 2002:a05:6000:470a:b0:485:8101:dc40 with SMTP id
 ffacd0b85a97d-48587057037mr50259731f8f.9.1788873871739; Tue, 08 Sep 2026
 06:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707070240.78295-1-xudong.hao@intel.com>
In-Reply-To: <20260707070240.78295-1-xudong.hao@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 8 Sep 2026 15:24:19 +0200
X-Gm-Features: AcwNN1U7uCR3unIJLpYVgti9xV0PpIps4nb9UUonhba8JZsSzlrAPCDAuSt1mlk
Message-ID: <CABgObfa5gkLKDJ532a_Nq2ZcZ6UJCnnJL9u=77nZeeAe8dAitA@mail.gmail.com>
Subject: Re: [PATCH kvm-unit-tests] x86/vmx: Skip LAM CR3 bits in 32-bit guest
 reserved bit tests
To: Xudong Hao <xudong.hao@intel.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 9:03=E2=80=AFAM Xudong Hao <xudong.hao@intel.com> wr=
ote:
>
> According to Intel SDM 4.4.1 "Linear-Address Masking" (LAM), CR3 bits
> 61 (LAM_U57) and 62 (LAM_U48) are LAM control bits, not reserved. Skip
> the LAM control bits in the CR3 reserved-bit loops when LAM is
> supported for vmx_pae_test and vmx_pse_test.
>
> Fixes: 55b77db1 ("vmx: add a test for 32-bit guest PAE paging PDPTEs")
> Fixes: feef9d92 ("vmx: add test for 32-bit non-PAE guest")
>
> Signed-off-by: Xudong Hao <xudong.hao@intel.com>

Applied, thanks.

Paolo

> ---
>  x86/vmx_tests.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> index 16f8a648..2c0feca0 100644
> --- a/x86/vmx_tests.c
> +++ b/x86/vmx_tests.c
> @@ -5896,6 +5896,11 @@ static void test_vmx_guest_pdptes(u64 cr3, u64 *pd=
pt)
>         }
>
>         for (b =3D cpuid_maxphyaddr(); b < 64; b++) {
> +               /* CR3 bits 61 and 62 are LAM control bits, not reserved.=
 */
> +               if (this_cpu_has(X86_FEATURE_LAM) &&
> +                   (b =3D=3D X86_CR3_LAM_U57_BIT || b =3D=3D X86_CR3_LAM=
_U48_BIT))
> +                       continue;
> +
>                 vmx_32bit_guest_init_common(cr3 | (1ull << b), pdpt);
>                 test_guest_state("CR3 reserved bit", true, (1ull << b), "=
bit");
>         }
> @@ -5979,6 +5984,11 @@ static void vmx_pse_test(void)
>         }
>
>         for (b =3D cpuid_maxphyaddr(); b < 64; b++) {
> +               /* CR3 bits 61 and 62 are LAM control bits, not reserved.=
 */
> +               if (this_cpu_has(X86_FEATURE_LAM) &&
> +                   (b =3D=3D X86_CR3_LAM_U57_BIT || b =3D=3D X86_CR3_LAM=
_U48_BIT))
> +                       continue;
> +
>                 vmx_32bit_guest_init_common(cr3 | (1ull << b), NULL);
>                 test_guest_state("CR3 reserved bit", true, (1ull << b), "=
bit");
>         }
> --
> 2.52.0
>

