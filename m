Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84EB21018A
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752529; cv=none; b=PpjtF/um/316UxA+XosM6xm25V9AyTRVQZBTKjjLJEl5p0TxUqCThTu1+h5uUD5xfMeJR8I7vYjCa5Q4a/xnvzj637KHDUtnzInYWm+3xdItWqCyaZ1iKVoBNljj88+rF7EwvNTWK2BToFUu5gMjI6xlPMFMaeBuuYFqJnfNrw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752529; c=relaxed/simple;
	bh=l0IEa/Ygo4J7PUgMIQJEOxD6/ezBStUya6b5EqHG7wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hx3Rk6WIRLFN2Q2YdX8tKVui7iQvHXxgfhhS3CTi2KLDq0I2fO3LLwUSr42pitbGnnJo+BrvodVpa5a4YFb+fMyy4eu3f3Fr2kuabbBOAMgJbt9YXe+Ul86/3b56VrrwVLCL+WMe610/NXdwlN6zieLvb6gEmRw10ahRwZDMNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBc5Yvky; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTvJbOKO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBc5Yvky";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTvJbOKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773752526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X84dwyjbZoJMU1tLYMgVdKe9XEn4KqkiGjeoDFKXh0U=;
	b=jBc5Yvkyu/+Z2Vygjmww6fV+4jcT7AT0WJa0N6ovSqYh6LWy6pWB0/AhZ/UW+mW6oYF3FU
	Dq0fiTlhiCbbi+Wlv2GQdzJJtFnw8FkU/lsRfdrWTTnjGozdrwBHRqFst10qmlyuv8Ta6B
	niYwHU0oeWl03G5CA+2v5RYtEstHu9o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-obbIPXmrMrahFhPSNWTeXw-1; Tue, 17 Mar 2026 09:02:05 -0400
X-MC-Unique: obbIPXmrMrahFhPSNWTeXw-1
X-Mimecast-MFC-AGG-ID: obbIPXmrMrahFhPSNWTeXw_1773752524
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48539bda3dcso61558975e9.2
        for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 06:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773752524; x=1774357324; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X84dwyjbZoJMU1tLYMgVdKe9XEn4KqkiGjeoDFKXh0U=;
        b=XTvJbOKOqEt5QDjkq6jHGAoRKEPNNgwIly2DGkvMFxNYC7JPSsw/Ui8I6OEvL5PKvZ
         HMgKsoBnQMmtI7bO5OaHSBHfuZ5llYXRLySdAcRmu+fDHGbcReP/l93Q7J8ceVAqTHuS
         be0nsHX7N71so2LOXb58c/5fuzl9HIa+2Nlqb/cRsau2an0U0rQqIhk59fjgCnE9SCfl
         KpsnC2iuPsfrQ9VG2iBJHUgXpz79P7HT6TsMJU1EGr3UvwCNmsZKpzgIPt1yuRVrnoc2
         KPte/L8tr7Bmh4lP4StxV9MIKu7TvS0niFdE9kkYaNXOK7KWu9RbiQLY/ol8lWlIvrQM
         hANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752524; x=1774357324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X84dwyjbZoJMU1tLYMgVdKe9XEn4KqkiGjeoDFKXh0U=;
        b=GV1k2xqFEyyMUIKL7YvgEtazmJLzNAjsGD8p0+0g2VxUM/kjy9Zj7IzS8B4wusoUXn
         QvBIDIvTdpFeDhVwhXv/Q1S0wzHEeEweej67tfyNrwmfE2qkPdp2BstL5caEFcX38Z/f
         ouPv7P0aPPwbOkmbUcyHn/TatFH0C+NPwrn9OVZp6hSoDrBvfD7ATB4cwJgSeiZObpGY
         6+8+V9ESnPl4w1Zv2OheEQmb4DUWAjP1tOFp6Cp9FN0N18VE4TSY1AqFsUMCeZrzLSnX
         NjQI1ruPfJcv/NRy5fKp9Pv+WZJgnzA480Z8XqIn+daOp9sxcY8Eg1jNvGcp0AP5TNGE
         bqTw==
X-Forwarded-Encrypted: i=1; AJvYcCXs8SrY8GzWrTvms/2cvQhYXs1ZkDDjjGu/Bd0BINp0Zz3pM725mdbz8St74lm0cL3XpKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSEBwiMGzerr9XSVd1zOUkpWp8M7OMZrK3zlg5i3qMJsVAjOiP
	AQt5gnp40lcqHxkH509oKzouvtxUw38mCG8SGqczeOUXoPON8GuQ3tfc00EVV4kAASTueBKrSWx
	3RpJQjGapcwGa/i/7wcJXSMaLNjREFYsxSftPYvYB0Ko1/KlOHJTjlg==
X-Gm-Gg: ATEYQzwotaw23uEXG30OvYiP+5xdTCrZF1Ui1nX+xQ4XpIj3lruqiXzpnvzg5vnd85d
	WhbKxRN4Ime76DFxK6Mdp5rRlOCdm0bT3IP3vZkv/PK2blqalZ3+fh7OzbdkTC29rLocRkhm6ok
	32M9shfb26Z/A4FYQmlcs5Uw+gGkeJqntXATvdQzWlUjW1mrzE82dfL//Ok7DyDPP+jyQov2S/p
	gMqdnQt39W+AlqG9U40EVgrrIeLyTXwAxEKQBCWOItbSl2fAO/Jex9D/fvMDBiUv+myHNrwVFWq
	TIweYt5Ac+V1TjibDL5jBVJygWWTYSMtubewoJYZyidleUP2emV5gWqjEilqos22e4thS74by15
	8lYBNI4p8bUVb9on8eg3EHSYzVdk=
X-Received: by 2002:a05:600c:190d:b0:485:6e40:5584 with SMTP id 5b1f17b1804b1-4856e40559amr64189065e9.6.1773752524053;
        Tue, 17 Mar 2026 06:02:04 -0700 (PDT)
X-Received: by 2002:a05:600c:190d:b0:485:6e40:5584 with SMTP id 5b1f17b1804b1-4856e40559amr64188235e9.6.1773752523414;
        Tue, 17 Mar 2026 06:02:03 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eaee04fsm67125555e9.13.2026.03.17.06.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:02:02 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:01:59 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Tommaso Califano <califano.tommaso@gmail.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, 
	Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>, 
	Oliver Steffen <osteffen@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Giuseppe Lettieri <giuseppe.lettieri@unipi.it>, Paolo Bonzini <pbonzini@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/5] i386/sev: Add TCG-emulated AMD SEV guest support
Message-ID: <ablPsAJl1k1raW7v@leonardi-redhat>
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317113840.33017-1-califano.tommaso@gmail.com>

On Tue, Mar 17, 2026 at 12:38:35PM +0100, Tommaso Califano wrote:
>From: Tommaso Califano <califano.tommaso@gmail.com>
>
>QEMU's AMD SEV support currently requires KVM on expensive AMD EPYC
>hardware, limiting development and testing of SEV-aware guest software to
>users with server-grade machines.
>
>This series introduces a TCG-emulated SEV guest mode that enables SEV
>validation without hardware dependencies, focusing on functional testing
>rather than reproducing the hardware’s cryptographic context.
>
>The emulation exposes SEV from the guest's perspective:
> - Exposed CPUID leaf 0x8000001F to indicate active support.
> - Active bit 0 in MSR 0xc0010131 to enable SEV on the guest.
> - C-bit manipulation in PTEs/CR3 for paging consistency with the host.
> - Complete SEV attestation workflow for injecting secrets into guest
>   memory (including direct kernel boot support).
>
>The emulation uses a new QOM object "sev-emulated", derived from
>"sev-guest", to maximize reuse of the existing SEV infrastructure while
>maintaining a compiling dependency with KVM.
>Below are the pros and cons of this choice.
>
>In addition to inherited guest properties, two new ones are added (binary
>files; default all-zero):
> - tik: 16-byte Transport Integrity Key (TIK) for measurement HMAC.
> - tek: 16-byte Transport Encryption Key (TEK) for secret payload
>   decryption.
>
>Code reuse benefits:
> - SEV detection via sev_enabled() and TYPE_SEV_COMMON object cast enables
>   the required checks for emulation without adding new conditions to the
>   codebase.
> - QAPI fields for query-sev/launch-measure inherited from SevCommonState
>   and SevGuestState.
> - Identical QMP interface (query-sev, query-sev-launch-measure,
>   sev-inject-launch-secret) as real SEV.
> - Shared state machine (sev_set_guest_state()); override backend vtable
>   only (kvm_init → sev_emulated_init, launch_update_data, launch_finish,
>   sev_launch_get_measure).
>
>Trade-offs:
> - KVM linkage: sev-guest is KVM-centric; even if KVM is not used at
>   runtime, its code is required for compilation, so it is not possible to
>   use emulation with --disable-kvm.
>
>Example usage:
>
>	-cpu "EPYC-Milan" \
>	-accel tcg \
>	-object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1,\
>		tik=/path/to/tik.bin,tek=/path/to/tek.bin \
>	-machine memory-encryption=sev0
>
>Build requirements:
>
>	../qemu/configure --enable-gcrypt --enable-crypto-afalg
>
>These provide libgcrypt support for crypto/hmac.h, crypto/cipher.h, and
>crypto/random.h, used for:
> - HMAC-SHA256 launch measurement (TIK key).
> - Secret payload decryption (TEK key).
>Note: --disable-kvm unsupported due to sev-guest inheritance (KVM code
>linked, no runtime dependency).
>
>

To give maintainers some more context: this is part of an ongoing work to
enable SNP emulation in QEMU, which would be very useful for development
purposes (eg coconut-SVSM). However, it should not be used in a production
environment as it provides no security guarantees.

Please consider this as an RFC.

Luigi

