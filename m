Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005271;
	b=VwHHJIr8jj8NypnXccOVCVajmih7NrlRgOFwLZwDUPedcHKJWc90I/xwh/kKkzHPFEY1
	 fAZy7vnpJx8zPxCXNyt0joqthJKPz23xrMeTFI2NnMatsBXuKhfoLaG1J3X9wR7wDhJAJ
	 7V+EoWNqI5OuuUnoUe5GJYC3A35DHXdnYnKMQ6rCR8a+P4zvjUEqwr3unlmSd20SNH7Gj
	 56525SExXqWfAY8ZIBeCVA6YrcwLRiao2teBYthO3wCHT8ceh1IfhbMuIKqHe6m+GRdY+
	 6ROJVKzoQkZvpOGXjrdAUhq6bxPUWM1wRXWdNMmcaYEDBEQSymCkaMeXHE5ifmJKUMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005271;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=BIokrW6dBSe7+DSoMXOn3ohQYcJwX5c+NY7lmM9Zk94=;
	b=WYvyz2itcCqa7X23LwBKIBkvqVW1NebqLN92bYqSgiMvJL+9KAzHbQk9jgn2hI30kPut
	 7aRHIUzUOs66AuwFZOmvm1KAQxmrP1v1B4F2erNZArFJqxH+ksMDe9+/AVahpjhF5w7U6
	 K6G9oafA0TnRF/oFqQekiaDn/XxsW7utKl6oBniTytmPwGOg7a1PleIYbfkaJxPDPNiKn
	 i3J0exwN91bsZe4w+s0ildzzBrA5S21AZrFZ9xmP3qw0XnMy4A/amZX3JbFngY9AKtqHp
	 y/9sOwTsIMi1ein/HWahogyeo95wa0Prop0yDgLVRAgXtFiscAO2n5c355BnfhyRj6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OePPmOGs;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EZcsIlGc;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F21E606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 09:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F21E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OePPmOGs;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EZcsIlGc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793005270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BIokrW6dBSe7+DSoMXOn3ohQYcJwX5c+NY7lmM9Zk94=;
	b=OePPmOGsFnSAe2euc72KcxOkxC5CP1I1QD2YvUCGrlq2rH/E7oBx2vB03KDYadI2IOPBuy
	ypb8fxPeQSMucmJLRB621HNZC8x17gsxVAE1A0wMka0XjoIg6kEVAPr9MNIrHsxXCFHBNr
	9LfgijZh+ds9GerCSRd886+dl3gnLEo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-iHpMvn78OTCKAmbtV8QDzg-1; Mon, 26 Oct 2026 05:01:08 -0400
X-MC-Unique: iHpMvn78OTCKAmbtV8QDzg-1
X-Mimecast-MFC-AGG-ID: iHpMvn78OTCKAmbtV8QDzg_1793005267
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48af4046a3bso2874104f8f.2
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793005267; x=1793610067; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BIokrW6dBSe7+DSoMXOn3ohQYcJwX5c+NY7lmM9Zk94=;
        b=EZcsIlGcbWe3r30dNGRIhAK+gJR6rNlgMa3l7BDqkOgytfDi9vfeprNlxKJIajRCmM
         iJvHMO4uBvCzSLZvc9NSW2lqtt2pFx05N91htyTb5N0aYnAvVXZvNPvg32+JT9OetuYN
         3lifqrgk8ta0Z0AscWtpAx/bklFL2t/RsyiJYbZmi3UyEa3xdm1+Ay4hgk/holBrtgOI
         1BkGAfJaCUxHZrDdEiRrde7rfEVmlPwlTalC+TvUcPG7ntT/0OzuocqjnQpVEXBqeC5a
         66clCavC+yiVdeuERd3xRZzXS3Hp3ng5yuXNcHK3bfkiXBSB4aEvuBzHRjEBuSv6FpUK
         GCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793005267; x=1793610067;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BIokrW6dBSe7+DSoMXOn3ohQYcJwX5c+NY7lmM9Zk94=;
        b=ByVX7SwlIrlinkoCaUrlfzBAmWjC9luP2D/gnyXtCUP5MTbMYuAJ7t/b3B1e4s+5n3
         C2V3YQ+T1uWUGalHspfgRjJ7PlC0RqLxQAzUhMCemHdmz/OnVwjCKGp1xPjFHisKBYDU
         acnPuICRWTrTXnqhe+tbH8ELqavhyTOsoEOW6LgIW4LO00bagROh9y9OeekcwD3w+T76
         DK+0qEcLCIgeFijWnYTN1FX3fg5UwZT7vdsCQJi9jYTvoOrfcWP70PWt4m++Q53P6c/f
         zfNFqT/F3gbNwY6s4zRmJEUAfbK7IR4fVz3vNJdgLOXvAxnAauLc0wETSD7GBsbE+d48
         om1Q==
X-Gm-Message-State: AFq9FYIc9ZD12Do0QEgItug0lC9kmOyzzQBHSe74mBDwzyxAaWAvpdh5
	/2xhEbnZoJftmWFCZzKJBL37VFuLYPbESLYFM0oqHznGbCxgNB7vpF6nW3RCMvWzthX6z5XsFrm
	229NrRdJwfwA1a+HePxldpNncdjyEuEino22mkpYG3G7H9e0koPj2Wg==
X-Gm-Gg: AYBFou1G/6ZKRMC07CxnRWYnFXkwOX/XqYKhPxpFUm/ASA2bm11r51YMOVAKhAHUGRt
	D4PPc7uz+dbH+7LnBVoHctEqIM+8LgfbcxkZ1jbf4jd0KmLOF7NHPPm+wahEjk9tYenRtAk5cpV
	RhMVqT2Ya0hNPOWmRc+Own6YRSBpz74tSR8ftIRYeulM3s0hTW3C4R51l8f9EW41dyb12v1Wsrp
	OkSRbp1UiMM8nmzvw1xTXF5aK/c/8/MMb1Q0toxSl3PqiRADDecpCmcbCdx2xqHxMpw/s9Xv1Iu
	g/kZAs6OgkXK2I4FOX6HLzVIu1SyR/+7qTR/jSXw6jCxONe5ixpzMgd+M8d1+tu5lwun/a+RmIS
	cQZpusdxcDk+62YqPJBHXmrVzv7tIL1r2ENFDfc+f4w==
X-Received: by 2002:a05:6000:4011:b0:48e:37e:470f with SMTP id ffacd0b85a97d-48e3ebb84bcmr13705202f8f.51.1793005266782;
        Mon, 26 Oct 2026 02:01:06 -0700 (PDT)
X-Received: by 2002:a05:6000:4011:b0:48e:37e:470f with SMTP id ffacd0b85a97d-48e3ebb84bcmr13704486f8f.51.1793005261390;
        Mon, 26 Oct 2026 02:01:01 -0700 (PDT)
Received: from vkuznets-thinkpadx1carbongen12.rmtcz.csb (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4bc5sm14925277f8f.34.2026.10.26.02.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:01:00 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com
Subject: Re: [PATCH] KVM: VMX: Add array_index_nospec() to evmcs_field_offset()
In-Reply-To: <20261017093016.32348-3-amirmohammad.eftekhar@cispa.de>
References: <20261017093016.32348-3-amirmohammad.eftekhar@cispa.de>
Date: Mon, 26 Oct 2026 10:00:59 +0100
Message-ID: <kuph5i8x2d0.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de> writes:

> evmcs_field_offset() bounds-checks the guest-supplied field index against
> nr_evmcs_1_fields and then indexes vmcs_field_to_evmcs_1[] without an
> array_index_nospec() clamp, unlike its vmcs12 counterpart
> get_vmcs12_field_offset().  An enlightened VMREAD/VMWRITE from the guest
> can therefore speculatively read out of bounds of vmcs_field_to_evmcs_1[]
> past the bound check (Spectre v1).

I think your concern is valid but the changelog requires massaging.

"enlightened VMREAD/VMWRITE" is basically the guest doing just memory
read/write and we can't do much about it. These reads/writes don't trap
to KVM. What the guest can actually do, is try executing 'normal'
VMREAD/VMWRITE instructions.

Note, Hyper-V TLFS states that

"Any VMREAD or VMWRITE instructions while an enlightened VMCS is active
is unsupported and can result in unexpected behavior."

and our initial implementation was completely forbidding
both. Unfortunately, it turned out that Windows itself does not comply
and does occasional VMREADs, see 6cbbaab60ff3 ("KVM: nVMX: Allow VMREAD
when Enlightened VMCS is in use"). I think you need to add corresponding
Fixes: tag.

My understanding is that VMWRITEs are still completely forbidden while
eVMCS is active. So I think you need to say something like

"""
Regular VMREAD instruction is allowed when eVMCS is active since
6cbbaab60ff3 ("KVM: nVMX: Allow VMREAD when Enlightened VMCS is in use")
but unlike get_vmcs12_field_offset() evmcs_field_offset() does not clamp
the index and thus the guest may be able to speculatively access
hypervisor's memory.
"""
Note, 'offset' is short and thus the exposure is somewhat limited.

Other pathes using evmcs_field_offset() should not be under the direct
guest control but array_index_nospec() should not hurt.

>
> Clamp the index with array_index_nospec(), mirroring
> get_vmcs12_field_offset().
>
> Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
> ---
>  arch/x86/kvm/vmx/hyperv_evmcs.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx/hyperv_evmcs.h b/arch/x86/kvm/vmx/hyperv_evmcs.h
> index bc08fe405..052b62b8e 100644
> --- a/arch/x86/kvm/vmx/hyperv_evmcs.h
> +++ b/arch/x86/kvm/vmx/hyperv_evmcs.h
> @@ -136,6 +136,8 @@ static __always_inline int evmcs_field_offset(unsigned long field,
>  	if (unlikely(index >= nr_evmcs_1_fields))
>  		return -ENOENT;
>  
> +	index = array_index_nospec(index, nr_evmcs_1_fields);
> +
>  	evmcs_field = &vmcs_field_to_evmcs_1[index];
>  
>  	/*

-- 
Vitaly

