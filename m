Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D4D33D6F0
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935157; cv=none; b=l65o1h8dxXEOsuu4jRfJaXIkKrnHEoOEzI+IbYeul/XIq2G2jo1pwW2SwFEm9qSmaVCxjebXiariVIjwh/mz5E7hPalfxPttTmaAMObvwhnsNbmcYMmYsXop+KM4hs6g+BiIqpu3NvX3Cjt0YgldNLJUV+aAXeaYewiPZHQ30qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935157; c=relaxed/simple;
	bh=QK2d+EFkM2Jtcy3rK4m4tmFaP/iY5rpk9MkUsFv20kI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJX4eiAlM/3tA6CNElHtztgOedsmu5XOCk/a2/ha+H1q/wVXgi4qZplMPZ/iTbxfaKjqXZp88e/2OHXj/ctm+3PIJg/0KDm6pSn9DjlVjMUYw75imNXboU6jQgFUulexG9nbTc/4riSaerl6kC0hAuMjUD8UrkhDxJO+0EsCh98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ios92L04; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lbviphp0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ios92L04";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lbviphp0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780935154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Vd3ZUm0dCzJ/8uu5rCwpPdtB8pbC5Kh3pUk3hRwNB0=;
	b=ios92L04N2pg+sO9MrZcDf3cW2zQLKt1GLPmRjNqQ7N4nUvl/Q77ZfUzQmZfc2NGqgEvMz
	oxcyq9IunEOYApOtTCdVVgSN6GGnqAnv1cq1eLGxgYOVysLwYsvxeUwgIERNYuUDz4mKuX
	XZ1+oCoj5iUrO7d1C5SXyrJcyMAtlqc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-9Ol5wwGMO4SsjifkeEIwrQ-1; Mon, 08 Jun 2026 12:12:33 -0400
X-MC-Unique: 9Ol5wwGMO4SsjifkeEIwrQ-1
X-Mimecast-MFC-AGG-ID: 9Ol5wwGMO4SsjifkeEIwrQ_1780935152
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef9f0af71so3412599f8f.1
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780935152; x=1781539952; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Vd3ZUm0dCzJ/8uu5rCwpPdtB8pbC5Kh3pUk3hRwNB0=;
        b=lbviphp0DoQPv1e9fNAnYoWbVCHmRe7sDFD+y+Ebf8iRu6jMg+aen/qafuxZItmm+N
         qqhPU8cb/G21NUM8e1Itzz3sQ0H3qwS2C61GiwQmAApXZx8UdJ1AS9tPpvYTTmygRXVo
         B0AOmRu3hYzgY48UJxzOwU0bqfUbixbV5ETE4T/mkiLFJVyPz9x3JNeCszzznqrk0PtS
         8B8NAFbaoMlzcnEmnT+F/22XJXRtE5DIjC3quijKCKJy2Xh752kQWK6036oJ46Irn+uX
         SuBUxioFI5nufxHHDFJSYDG3sgRTLANXyfLvtWLqv+YhrL89g7H1luCAQCzLh2Aj9zsZ
         97hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935152; x=1781539952;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Vd3ZUm0dCzJ/8uu5rCwpPdtB8pbC5Kh3pUk3hRwNB0=;
        b=PMb8pbjXBS6aMEZQ/EScTJ7clB77RN0e34JSM7dlM+WG4mm2/kNjwlzxqLHmJ34PVM
         7ZHULgux6dIwFmbVw/ucv7j4CU8jGo3iB0HnMFrBov+Fs5keOvQxmMimrceQYV+0py5a
         XQDhTiOyNkFllM1qWUerESbagu1vg1palmQfvcsyqVtNsATXbCqDB33wHIqan9n5Qqno
         Na2G3fr/E6mwoamdlBxCFFioDrKqiq+Kd46f0YVKO00BhCKvwQsBoK+abRc3IlsdF7wr
         nsQu+nLnQYBvcJIS7Q05DmLb8D6MIOf20V+GobzUDlMEsIKND9NOMmeUmq92nHtarVq1
         MGtA==
X-Gm-Message-State: AOJu0YwUU9SajD5nHbp0TGgGNvLB37xBKen0e8fEzA4M6NiQguElt7u0
	uUolp67zKbEOwkjXf5FqcCKbZ029q1pR/OCRDg1ZLsZ4yprX9IvhjIedxL81gVMQomGZheCnWSa
	YEAqAE+Ghl97VpqRaKn5T2WNYPVIJea2MEvx4UdDSeFbQETrnXMakhQ==
X-Gm-Gg: Acq92OHfLScksWy2ZOFCTnhvzIWoAsgTTJSLPUI4qM0/PTF55CJ7jdJxfGznTp10+N5
	B2U+QJvwSxkU3jUCVq7BkwGpVpGfXrNUSnw5mbYNo8kM64ciUzxEfIkFJ6nRPQS/Dn4tFnN+pK9
	LDJnEz8QYKsjjtygY4rN3QR5JU/u2y60RzdxsWTqKdbUhIVLEOZQzOoF+4NHMH/IlrtO6KOiBuL
	yAKxJKV703NvNw85Qik8+P6Hp9nEsKS3JeL8Ld3x0zw8peC0x3/4Xw+L0gSDf9pql+CBrEunuMj
	9moqFyDKmSsIPk0X8YVX9J7mXEHbVNZMOvoQaN/WxUzpedSXf7A5vZoQHgaG47AVOZYVDr/QthJ
	1yVypUYipZH6PBDzL/gWbnyv6
X-Received: by 2002:a05:6000:4802:b0:45e:f3b2:1228 with SMTP id ffacd0b85a97d-46032b611d3mr24384802f8f.3.1780935152152;
        Mon, 08 Jun 2026 09:12:32 -0700 (PDT)
X-Received: by 2002:a05:6000:4802:b0:45e:f3b2:1228 with SMTP id ffacd0b85a97d-46032b611d3mr24384745f8f.3.1780935151643;
        Mon, 08 Jun 2026 09:12:31 -0700 (PDT)
Received: from fedora ([91.219.240.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm54249702f8f.3.2026.06.08.09.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:12:31 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Hyunwoo Kim <imv4bel@gmail.com>, seanjc@google.com, pbonzini@redhat.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc: kvm@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH] KVM: x86: hyper-v: Bound the bank index in
 hv_is_vp_in_sparse_set()
In-Reply-To: <aiQyZIJtO-2Aj_xN@v4bel>
References: <aiQyZIJtO-2Aj_xN@v4bel>
Date: Mon, 08 Jun 2026 18:12:30 +0200
Message-ID: <87o6hlhuz5.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hyunwoo Kim <imv4bel@gmail.com> writes:

> hv_is_vp_in_sparse_set() uses valid_bit_nr, i.e. vp_id divided by
> HV_VCPUS_PER_SPARSE_BANK, as the test_bit() index into
> valid_bank_mask. valid_bank_mask is a single u64 and a sparse vCPU
> set holds at most HV_MAX_SPARSE_VCPU_BANKS banks, so valid_bit_nr
> must be less than HV_MAX_SPARSE_VCPU_BANKS.
>
> The caller in kvm_hv_send_ipi_to_many() passes kvm_hv_get_vpindex(),
> which is below KVM_MAX_VCPUS and therefore always within that bound.
> The L2 direct flush branch in kvm_hv_flush_tlb(), however, passes
> hv_v->nested.vp_id, copied verbatim from the enlightened VMCS
> without any bounds check, so valid_bit_nr can reach
> HV_MAX_SPARSE_VCPU_BANKS or more and test_bit() then reads beyond
> valid_bank_mask.
>
> Return false before the test_bit() when valid_bit_nr is not below
> HV_MAX_SPARSE_VCPU_BANKS, since such a VP cannot be present in the
> set.
>
> Cc: stable@vger.kernel.org
> Fixes: c58a318f6090 ("KVM: x86: hyper-v: L2 TLB flush")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  arch/x86/kvm/hyperv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 4438ecac9a89..d8782cb7ba02 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1839,6 +1839,10 @@ static bool hv_is_vp_in_sparse_set(u32 vp_id, u64 valid_bank_mask, u64 sparse_ba
>  	int valid_bit_nr = vp_id / HV_VCPUS_PER_SPARSE_BANK;
>  	unsigned long sbank;
>  
> +	/* A bank index beyond the mask can't be set, the VP isn't in the set. */
> +	if (valid_bit_nr >= HV_MAX_SPARSE_VCPU_BANKS)
> +		return false;
> +
>  	if (!test_bit(valid_bit_nr, (unsigned long *)&valid_bank_mask))
>  		return false;

I think the concern is valid, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

what I'm not sure about if we should also deliberately crash the VM
which does such a hypercall. This way it would be easier to find buggy
L1s but given that they are most likely Windows, we need to do some
tests to see if this is not actually happening today (e.g. Hyper-V usign
VP_ID or '-1' for something). Let's have this as a future TODO item.

-- 
Vitaly

