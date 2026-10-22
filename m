Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653553;
	b=jMSSssrnfBS4BFjbevr+skbbSLC9Fs4nMRQdRr58Wp75pyX/uTP1TEBipP0pS6FNc1MR
	 xi9gdVqDUhKXticGBRTLiIhctt2iO6BANlbYAZ5Vf191+azoHSr0Ofa6r8bqcbEeNEabM
	 5k6vtdNfkeEnqEXQ+PDPP6myscOM0FOISSZh8hRLAOKzRprYz5V+yBlSuPaam/E2V6TZ1
	 +Ww3KE4OL+lVo/JahRIrCozArIl7UEul0Dqlj5uXEz8v8ByU/SRGJjgCZQRhAOoR5bwVV
	 qpTxCfJJD4fGTRr1rUFXPxmfZOk1A60choz0qjJ6bDu8D9PmrF5Bb50xZIhJO/aCvxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653553;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=pCGbRXaaCKhpFnqdJpERzrBbBhy2ekz2jJLuNljluiE=;
	b=5V9Wm0pEsRq3z+pqFswuG37+E9/sHv3sW1LJft/D6AzRtvoKl8ncNY7eK7PhYvc7RR8+
	 h016QnUCHNqei2+kqGTAd8yDKyOAJfD9EXPzQOAYKRw/l6NRDuTVaNxNpolFV5D+bW6QS
	 yhrgMSRmNkk+s+K1CYzMFT4OPlq4qYng20rTQv7cN0VqOWPny73SldvEKUhu6Gjf24tKc
	 pLZt+0EM1H86iuVaAffOyBH0eDZOuTaIHwkV4VI/RwMUN7CMDm056OwEZiv0nifZkIRRh
	 /Cd19qICKoiMso+qz3tJ+LPls9YnMiGlmZdb+RRzFoPI/vsCTp51/JFMSUdbMixWEHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W76EM4Ln;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=uFS4iDHj;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD57606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 07:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FD57606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W76EM4Ln;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=uFS4iDHj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792653551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCGbRXaaCKhpFnqdJpERzrBbBhy2ekz2jJLuNljluiE=;
	b=W76EM4Ln4uSRLyEP7c8NU/8W2F54tYM1uO4bP+9tAv+P9r/jZnloQGoXjO2aI3IFeM7UXc
	S13gXR7Mwp4TvCfa3BqveDDTITpWNOg5RkArVzUsCJKJezvrwow5CT12sAl8wtBIYU15CP
	VcHJPgTk+BltHaDKti24vFDG7YrScy4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-yPYnIAUrMrGXn8umw0Sxaw-1; Thu, 22 Oct 2026 03:19:04 -0400
X-MC-Unique: yPYnIAUrMrGXn8umw0Sxaw-1
X-Mimecast-MFC-AGG-ID: yPYnIAUrMrGXn8umw0Sxaw_1792653543
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so810203f8f.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 00:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792653543; x=1793258343; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pCGbRXaaCKhpFnqdJpERzrBbBhy2ekz2jJLuNljluiE=;
        b=uFS4iDHjq1WCIYSq9HdPgVFdyoBQ7ZZkODpIaf95JSuJ8Jj/R8QIXO6/nwA3cu6mp9
         A8kG1aWAo4q5T70EXc/bEnYmMz5QMQ2vgYjdWH3pRsFjypddPg4bMnFI2NYHMRA3m3SV
         DXRxo9qrWwV3LQhlA5tHuvSMTfDjFOYisrYv+/Ws1V1EeUWmnOVPMIBBP3CG0N65mv+a
         1zhjsNT/+NO57NNjZCbWfaq2ISpILRacs8DnwSOPZw0Q2zjYe3ti9PfG+CdGDC1rSuY4
         EFipAZFCauDJIVQvxoEh4VCyiF+VNjGxplAUeu0H3WQQXx6UFQtWnkWIjhloR9zPyt0M
         j9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653543; x=1793258343;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pCGbRXaaCKhpFnqdJpERzrBbBhy2ekz2jJLuNljluiE=;
        b=DWItRq+Jvl3NjOntVQQHwiF54Rg28HrHIYGqD12gQn4UOgP1k1LdEx3YVv8h5wRqrd
         EHNdQaM8jUwMCN7nw5WeaHEMf7WXd0MuN4ErwuA+SX2Gzp3brTeUe1xH3CbhH9/1VbKN
         VLk8sU8syzbPrqU2vE2GV/iwzE86yfRvNNjRL4o+Ki8POHOtU+e5NiiIIbhSp0NoGm7c
         o+mGn98Oq2Pcslx73KscJQ1G1Y5zTauhzdhs3szFH/O0UALggEGLeGK1htsjthhx2Seo
         uwr9qzd96+knIyj9gKuyMEu5u5/IXgeYNYwKydJMEpZLagb01Dxp0tRBJM9eRfdP4AAc
         tzpA==
X-Gm-Message-State: AFq9FYLrsj14HPtNWQUsYfrzfIB3wFUN/Trtb76KdvrutNOcBREPhQ4p
	uX5OQBESeZs7GD9NedTL7u7OUUQ4KAvkhYDOTgfVvG165L5Fm3Rd13u6LbOJvxlriUOp9b61La2
	qJNmqmgLS3k3bXP72HTLAT0Qc55lFsKFFGrmko+aWFZDEAomtO5UmPQ==
X-Gm-Gg: AYBFou0cbFpE9EesaiZQyPWr5LLlp7L0xJyYwBkS67VIDB5OhIygKQdWOmRqZXzfIUE
	s9VDdacyk0HEaytjhzg1rZUAeQ2xO9x9tRTsK53QciVfzVEzOYhgwN1aHS80qpHZgbk00PpY9Am
	PRjhKz0H7A8M6ve1cJ6tf0SiO9u4K3vX6T05698mHh5r1RUn/CsCSO33msmUQyKFDdACPBkVvri
	kmEv+Gl++1N4lfNAK7X7PqOedydDkRJfFGE4SCSQ3puFzVnol9A2/fq4TvlImqoo+s1ZGaHtYrm
	oMh4TQR64W6L4bfaLIldWA10q1f2Zc3v93isUKcwBWiRjs67eb0tzm9n3Kv7vqvyqA15wAigyFV
	9mntLVgait71Nw4qf4L6JFYlv6xoa0qCFD/CIbl2JnA==
X-Received: by 2002:a05:6000:1843:b0:487:2777:6354 with SMTP id ffacd0b85a97d-48e2650d1b0mr9235341f8f.48.1792653542974;
        Thu, 22 Oct 2026 00:19:02 -0700 (PDT)
X-Received: by 2002:a05:6000:1843:b0:487:2777:6354 with SMTP id ffacd0b85a97d-48e2650d1b0mr9235300f8f.48.1792653542565;
        Thu, 22 Oct 2026 00:19:02 -0700 (PDT)
Received: from vkuznets-thinkpadx1carbongen12.rmtcz.csb (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258420fasm11055933f8f.50.2026.10.22.00.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:19:02 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Amirmohammad Eftekhar
 <amirmohammad.eftekhar@cispa.de>
Subject: Re: [PATCH] KVM: x86/hyperv: Explicitly reject VP Assist Page reads
 if cache was clobbered
In-Reply-To: <20261022021227.295495-1-seanjc@google.com>
References: <20261022021227.295495-1-seanjc@google.com>
Date: Thu, 22 Oct 2026 09:19:01 +0200
Message-ID: <kuptsmerymy.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
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

Sean Christopherson <seanjc@google.com> writes:

> Don't try to read the VP Assist Page if the shared PV EOI cache has been
> reconfigured via KVM's actual PV EOI MSR, as trying to read 624 bytes of
> info when the cache is setup for only 1 byte will trip the sanity check
> WARN in kvm_read_guest_offset_cached().  Ideally, KVM wouldn't use shared
> state to track the VP Assist Page, but in practice no sane guest enables
> both KVM's PV EOI and Hyper-V's Assist Page at different addresses, i.e.
> not allowing both to co-exist independently is "fine".
>
> Fixes: b63cf42fd1d8 ("kvm/x86: implement hv EOI assist")
> Cc: stable@vger.kernel.org
> Reported-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
> Closes: https://lore.kernel.org/all/20261017093016.32348-7-amirmohammad.eftekhar@cispa.de
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

(I am, however, thinking it would be better in the long term to either
separate KVM PV / Hyper-V PV state here or even consider a 'big
hammer' and make these two (+Xen?) mutually exclusive for all PV
features.)

> ---
>  arch/x86/kvm/hyperv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 5d2e3617c952..c08eeaac8bb7 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -949,6 +949,15 @@ int kvm_hv_get_assist_page(struct kvm_vcpu *vcpu)
>  	if (!hv_vcpu || !kvm_hv_assist_page_enabled(vcpu))
>  		return -EFAULT;
>  
> +	/*
> +	 * KVM reuses its own PV EOI feature to emulate Hyper-V's EOI Assist,
> +	 * and rather stupidly reuses the same MSR and cache storage.  Treat
> +	 * the assist page as inaccessible if the shared state is configured
> +	 * only for PV EOI's single byte of data.
> +	 */
> +	if (vcpu->arch.pv_eoi.data.len < sizeof(struct hv_vp_assist_page))
> +		return -EFAULT;
> +
>  	return kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.pv_eoi.data,
>  				     &hv_vcpu->vp_assist_page, sizeof(struct hv_vp_assist_page));
>  }
>
> base-commit: 814607cd40df80d5727957adaa857e0feca43497

-- 
Vitaly

