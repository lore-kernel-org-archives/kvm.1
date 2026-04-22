Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E983DEFF1
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861410; cv=none; b=GzjN+68YAxV3bEyXPNSSQJRAeqhIbaNIE2+XhGLY0qkbdxwh1LS/IpqGd5c1fOujnVAmFLfhTt4hhFVH2VKXcIN6iNoSy38t8v2YfGFm/MI64W8I09smNfebNeJ8tQscJopyekx1I2jtcUCmquKUT5JIXOgAbOrAQBHs8hjIlZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861410; c=relaxed/simple;
	bh=GRci3Ps6TOnDQU277EdMiL7Fyn0ArsGYZ4aCWByhIXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TY3T6+dgpMgu3YFJKcueBsCmvd0Fog4Q3vvwNYP+zSAwOWT4OMqBapmKLOqMvdTw8+MNSboc813U/n5tdDs22bzd1mivQkBl7vso2uwKoDmZ6BVxTL3rM6XiHHXh850ve5nAZJsEPHhqbQbj8pfulPcQr8WnEC/OGiumTDHMErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVgWHVwL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcyaPDx7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVgWHVwL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcyaPDx7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776861392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/87qWMjmdqk20+dY4xcLoxNd/NvWXE/CewiI5GysFx8=;
	b=SVgWHVwLq5VPR+Q7Ig3eV82cmj0e8dFlzH36FXdYg6ZHskh77tkM6Fs1WWZHzHSCu+uhNq
	fKL57Xofo+Nb7CjcJZgadefb2AfAxfiBUx0LqZHDd63Rl1LLZacTjed6ofidz/azY4xJif
	mImzXPHgaTYmkvcjlB7yhm09Ov3mnOg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-EB5YvIyWONi5cHfKIzPoXg-1; Wed, 22 Apr 2026 08:36:31 -0400
X-MC-Unique: EB5YvIyWONi5cHfKIzPoXg-1
X-Mimecast-MFC-AGG-ID: EB5YvIyWONi5cHfKIzPoXg_1776861390
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82d40278103so3638580b3a.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776861390; x=1777466190; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/87qWMjmdqk20+dY4xcLoxNd/NvWXE/CewiI5GysFx8=;
        b=GcyaPDx7cedNVMaK/tZGBH7XaxfkEi6PkhjPp/dXbsRfftimWO+1xDBO9mWm3C4whz
         GRiamSZPv3zJIJdcKVv7S4Fdpc0+Y5EXZtTSMsjrEYYXBmXxkQWCuZ5yLMYZ42+eQwy5
         jAyAh3nNEmt1ZFlwX88ay0GaQbke+86qNS1llNfiNsJbVWAuPSNHGDW+5PXZ+EOoE1I9
         VzwldsyMfVJnwt68FVnrojr4MmkfyYjF3O8LKYF85tA4kU6pcWX97ATCa6c7ItqANi9Y
         jOqeKL6OoCLPx/iOrlPpxKZlc4Tn0zpxLmvUA5Q+A2tqD6KRD1/B7K0pGhwa/77SdJTi
         YGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776861390; x=1777466190;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/87qWMjmdqk20+dY4xcLoxNd/NvWXE/CewiI5GysFx8=;
        b=GQmPxA2WF1qbhaMKpBOdU5aumPWag4Cuj8mYSinlguESpJvvZ3jVB2GPsW0H3M9B7U
         3cckVxhyX95vtL4M6ARBxVZeP1PHR+m+MI0Ugt8AcnqtsUYuGdNm6w9E/T4MKkZTTOd0
         Mtu1nhjxYTileqw34UkkwmDK8cfIULkRME5aiEd9eBEyvknDqFVsYB3IRYH6VFULJzaB
         yNegTCGL7HCIHXOXVKcEkapOZS1uuCp15Kv9p79qszsYpjNnbi11H9gkbBGFsIAkGFxI
         WMzLBYYL87ChBoggX2ITegxfqJmlgnnvoWA6n3UI9CowHEkuU+G1/hzQKNIS6yw+YKwW
         ky2w==
X-Forwarded-Encrypted: i=1; AFNElJ8LN8/qTZvyHMtDCk1ItEGvINDr/9PDdpjuWRiTfJMi+AY2pGWgpOJUcXZcMwJE/gI6zo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysN1Y9VUmga2ZnI/dp4qHQkyoFuXHtj80CdldnC6tHN559IBmr
	ZLT5CESmdg/0M1eBc44+S8TiNgQfUqWABDlkWN5rwD65DDdZ98K2O1TblHjqoG7xJYSFLtduGFI
	uj52wIo91KJ6fkfylPX59FSg722SlfMjuO0QrUzF5ZV0iSTdAyVVofw==
X-Gm-Gg: AeBDiettFDAJZo0wffkImbw4PkcJyd9NrbhQdaNvWtl0juhEuU4ID9bZji8QteReJcI
	NNPeJiw2P400Kmo+gP+P5GoZwlnCdPRpUxJF/xkmwWR7Aet0BeFsiJ+xRiyfwq3ML+9u3HgnBeI
	2/oGRYUD5hPGKDm7m650OJiz4/OdbiFi5Oj9fjehRyHVBtEaFVMmA7DmUa7Dodyk3TGcOmZAvGm
	LywYzr00BAb9iZ87KM9c7/0omxd9U6/j/1kNzpSEK8GpuwHkRLSQSJJf4GwePp9teRJV4/fDYzl
	MiKguhXOK/yfW4CffcCkor8+7iXhhs2iFllapSKa6GKFgmGGO2UmU1Pf7OK/cbFE5AJpa+ixZDl
	6VzEAt7/a++z4JM1K6YUSxtur4mKK
X-Received: by 2002:a05:6a00:1a0b:b0:82f:b519:a5d0 with SMTP id d2e1a72fcca58-82fb519a776mr10942181b3a.39.1776861390360;
        Wed, 22 Apr 2026 05:36:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:1a0b:b0:82f:b519:a5d0 with SMTP id d2e1a72fcca58-82fb519a776mr10942152b3a.39.1776861389901;
        Wed, 22 Apr 2026 05:36:29 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d35acsm17671348b3a.15.2026.04.22.05.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:36:29 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Piotr Zarycki <piotr.zarycki@gmail.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Piotr Zarycki <piotr.zarycki@gmail.com>
Subject: Re: [PATCH] KVM: selftests: hyperv_tlb_flush: replace NOP loop with
 udelay()
In-Reply-To: <20260421172953.191345-1-piotr.zarycki@gmail.com>
References: <20260421172953.191345-1-piotr.zarycki@gmail.com>
Date: Wed, 22 Apr 2026 14:36:17 +0200
Message-ID: <87v7djgoji.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Piotr Zarycki <piotr.zarycki@gmail.com> writes:

> Replace the open-coded NOP loop with udelay() which was added to KVM
> selftests in commit 6b878cbb87bf ("KVM: selftests: Add guest udelay()
> utility for x86"). The NOP loop is CPU speed dependent while udelay()
> provides a deterministic delay regardless of host CPU frequency.
>
> Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
> ---
>  tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c b/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
> index c542cc4762b1..68ebd790ff41 100644
> --- a/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
> +++ b/tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c
> @@ -141,15 +141,9 @@ static void swap_two_test_pages(vm_paddr_t pte_gva1, vm_paddr_t pte_gva2)
>  	*(uint64_t *)pte_gva2 = tmp;
>  }
>  
> -/*
> - * TODO: replace the silly NOP loop with a proper udelay() implementation.
> - */
>  static inline void do_delay(void)
>  {
> -	int i;
> -
> -	for (i = 0; i < 1000000; i++)
> -		asm volatile("nop");
> +	udelay(100);
>  }
>  
>  /*

Oh, I completely forgot I added the TODO :-) Thanks for the patch! I
also gave it a spin and it looks like rdtsc() from udelay() doesn't
hurt.

Personally, I belive we should now just drop the whole do_delay()
function and use udelay(100) instead. We have only two call sites and
there's no strict requirement that the delay time should match. 

In any case,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

