Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794975232;
	b=1uXHJSYVSUZs6i8BqVMk2VW1L66x6BL7gWsS6V86wmNdnF0/A4e6PgKB+ud+bOYjQYWv
	 dYPwvFctR19/UhBK+u5+cLUoile8DlEdJFuJhjhhGBP9Ypu/JeABVRGAD0SiXLCWQfaR+
	 K7yydMGJn6e4JnTCk8Iup7KYxWRXgTN92TRDiBXUqCZI70xDkUhmYW2JiOZlbMIzvgllV
	 UViMS+lQPfHDGeYIQfNEKY/d8g9xfZ2NH3lMhzc9Bam+H1ZfW3o/pBlpOKzbW0fGAanSG
	 5hRyQwhOH7W7Ep3YBg7T853n+Ch0KiWG+Jz07VVsaK/BAc/QgqO8eHacX5E5DoclAGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794975232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9/n7bNHhI4mAu4n07g+LOiXJUPBrwLMib4F/XWShiOs=;
	b=I3y9xL8jdCx+f3sf5+9L/b2kVWybxiUOimXMvKW4o4zB6Hs1jBIGu7g/QCIj3InWR1Ar
	 i1rt2g9Txd4AkxgoVXwl0kZ7/sL+wQCj/x55SVxsKUx0Oif1L/mR0uI3kSpuQucQBsHgD
	 IClZmrFq5Ff+PxwgwKIbY6Iy0T/Z1HoRHt2NHAYMydauE0wc9Y4gXDMjF5nL03vDFkteb
	 2BKXNoVBoly1FzypVhHtiEE2gO5gBPCYsGxt81B5YjpyUIDgPNmy5xlEAlDNIlZpXLUHw
	 tWb1Uj2Ra2j/ZfMAGQaMD8WipQ0ei59dKFp6+dJQGo33D979X4KZEy24L3hOemGs2vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cjwbJ6dg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3C606A325
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 04:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00D3C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cjwbJ6dg
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso8194a12.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 20:13:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794975230; cv=none;
        d=google.com; s=arc-20260327;
        b=sEaIZd9OHBq8fbqhQ7r8f4Stji4rXVI5AdwkCVHWBaK4TFMeGuf+UH4Tu47D/F8Kzs
         2AH90dUAKVRC/aNbkGnWvjqPJVVFmBsTP0soWjtmReqh/1KiTFkyiq+YCF3cyp8HWoKx
         Prxvw6OJSLYiPMhSYuXDY/Ear2xP8xZa4OZh1kjSdwv3ck0nR+zzgUf8YWAtrb99NMuB
         ApEsq92xOqaqkHE/S3PwFuO8wPaIyIaCZasPUGfBpODlOlYByDrRZ/RPqwMh2nFs6GOt
         NPJbPTBmwR9fG6xTznm1q0pyIAj8jGQGWH5RIKCgfpDqaQxW5JvDv+yP9CicnTxvBV+D
         6Ydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9/n7bNHhI4mAu4n07g+LOiXJUPBrwLMib4F/XWShiOs=;
        fh=CyD76705gy2eOSpTcE3yiGeajMuSLUkcWSGnjEwR7Vg=;
        b=Xs/XPtPubxRrZIINqGtRYugvqhLurRboKFK7PUhHwa8kqDcLU/sNt/0OgcukjLik1X
         mOTDo6HhkECVPqeSTrx4DsmBPz5tHolVHfVb9Z8LcnAX4xi1AfQ50Yl8vAhf2JONGH/m
         Krh0cWqRMh3BV/UEZHSdRd14HlrbGQwFYWGhEhcqlwzEqkWs8ZZTUcuVDi0Q4OqVynAa
         CekAvD1kAL0i7IVAWnYMZ/VngMh8o9O1sDNZk7xGIatpzmXB6jxil1NzkhEWmG/2i3yC
         Z8QmOv/ceo38zQs51GPpqlF5TCO254K3N04ghtDs5gcvyj9OVIayezxnuR8qD2h5JjFz
         UZ1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794975230; x=1795580030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9/n7bNHhI4mAu4n07g+LOiXJUPBrwLMib4F/XWShiOs=;
        b=cjwbJ6dg5FxOlD5tWwt+lPw14GBpXLZIzfqMZID/M8OEogQqOiZJ9ytfTUMATMjBjd
         0w2Nq8qXY2SjhmA91ocfXhn5ACeEvPeh+HVioOaUWhGTq8Yu3iCIIGZXStCTs2NeCEgN
         6VqFQdtOSX24wlrNHx+t4Z8OxcLjpSLYxO0U3J/STa2yFY02fzvZATIgYH6OgRIpSzYl
         F/bl2D4l1RduzOW30deKY0/t9WwgRenyeJvgLfky1lTFM31aJEY/H3jMuVBk+2YrFzq0
         nBOjt/smy8bNzn9Tx+0Dq3e2P65IWNZtkM/nBxh8JTQvfNWdEy5uaj3vGAx36Xuo36AL
         oBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794975230; x=1795580030;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9/n7bNHhI4mAu4n07g+LOiXJUPBrwLMib4F/XWShiOs=;
        b=wQOnMmeKW1KaP/ltvyqScabO7vfS+/TxWCykuCse85gtHdIuSbnklp1Im24tLxLryG
         afJwTbRfh62dcqlrqVukX+BnUPET0xY0ModujQCaSqE2O8XsxSWCxlQWjV808TUAwVDJ
         yv34Zt0KoTxtQDoSe7TTFnEBTi/ml5fi8N3CHegZ6mnhwLbFgl53WA/DSIgQa8pLP8e6
         AX+27ZjzyIgGkab/9RfCzRom5tdZav6/xdFSYx9DqvPawbfcr0lMJ27NmRaLIM5fozpc
         h72a9JqAdxYlLvpd1qPZYMauFisUXhTvKhtY6IJn8tYQ6nsSl1HxwWq8JZBGIL9z0i9h
         lObg==
X-Forwarded-Encrypted: i=1; AL+hErGvoe8kEfOzvt+a3/2T0Z3guuy4U9NHWcOxD1NLcVzyleT5UZ3uWBe1Ml+YEayTfOorHwo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+c8OPcwGuD+EoAynGc8VTthCNaiv7JvNebRhelf5gzx/H0rK+g
	TsxcNSuL4CaUNLzdSk4soJvYhkTf/5HCcNFS+ESJA9LQGMltDZ4g5GDkbnzdZefKfQFpg7NWnkM
	XCJDkTyEoVspFpfQoxWpsH/2T88GjyxmLnk8TcpEB
X-Gm-Gg: AYBFou2fNxKZYn66c2VLDg5QiEq6tp3QqoHUKaB2VxwKCJ4V6vCcnV+GRaD8/Jf12p7
	ucFQDU71vuZzFC30pf6Tq1uBAKqhRDWdHfsL9VR01ZADndVSPC5wv9DMCqsrHiD9hcG7Yx9grdQ
	jx4+P1AkKj7KW7QBdcFmG2iHBv5OCr8qsp+2+tJAvt7EtPuw7naV+IJNncxP/9U9FP7ukY0Q0B2
	zWu+bqRQopQ0CL7ksoe4hgWy1N86Y9jr7SchncP69Dopl5xI0ZjWo42zgYPg43N9UpnhreOdJOm
	CdEnF4iovYucQ/40YofpcM1D0bz4qluoQBou4E09ih8ZqUr+aoU2E0/xmgGzbV23yIHyWGzQIaq
	nX16XyxyOrW+Af4ka6f9Ui/ETYrvI9zBp5fRxLpEqPlV6/27eOMt5yPYXl+NZ6ZxlMWbOw/fTB1
	9EeQsVHSiLJdAbrpmsOy/N1AaHQmKQwH5vW1n/xBY8OMCTCwZI3ImqG2KT4CbLGT9a25pqNPaLd
	kI=
X-Received: by 2002:a05:6402:a514:10b0:6b7:b033:b489 with SMTP id
 4fb4d7f45d1cf-6b891f61ae5mr35791a12.13.1794975230020; Tue, 17 Nov 2026
 20:13:50 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117180310.921701-1-chang.seok.bae@intel.com> <20261117180310.921701-10-chang.seok.bae@intel.com>
In-Reply-To: <20261117180310.921701-10-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 17 Nov 2026 20:13:37 -0800
X-Gm-Features: AclHuK_rboYqgTKdPhlI6PDF9EIfp5hVCnG4G8MclhgUoUlvM_c427GmBpqJiDs
Message-ID: <CALMp9eQ4uM1gV2MTu6mDh9O-ia5G-WYy3-MP-KoP65CKcN-KQQ@mail.gmail.com>
Subject: Re: [PATCH v9 09/20] KVM: VMX: Support instruction information extension
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:32=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
>
> Define the VMCS field offset for the extended instruction information.
> Then, support 5-bit register indices retrieval from VMCS fields.
>
> Although the APX CPUID enumeration indicates that the extension is
> available, hide it when using eVMCS, as eVMCS support is not ready yet.
>
> For safety, do not assume that previously reserved bits were zero
> on older implementations.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Link: https://lore.kernel.org/aakEsXJgO-3m2xca@google.com
Reviewed-by: Jim Mattson <jmattson@google.com>
