Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793643710;
	b=Vq3OgKYRxyi8ySRRpegATFQUxwsL/Yp2Ui/AaTPb3VhZfo7jxCJDFlLJkbm3ZL+046W8
	 AbPHZjZTXqTjKj/m9KT+xNgohz5Csx//GIVV3b9Qwyu5Esw/bI95r4zqbAUkSPTYY2bXY
	 od14PNkD8IHkPKHkUNuCeGziAS8V8+UnmouOP5DxJHjqFQwP+AiHCxycjYjVS4nltjdi6
	 5/p49mtHcGbtjNhPZuXPYnF9C5BYhMl42GW5SWLFNwFsO0IDqNCcLC8THLghxFU5Midwt
	 ZiI9OmxlYsbKgBEM7fwBX62yrDGEP7lx93bdmmTBVeMHF3rQzoiid4W0rb6VzhcbY3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643710;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=6odvKjJX5uaeX8gp4PjtCpDvxv131iO0vErthI5phGU=;
	b=ZmCPJ/2/2dCFfwewa3QebHJ9x2JHkJOJ2govpGW3eQkzJ5zvlZE7c8Y3nIYOnfLmKiN6
	 eY/bd8ERzUZ7r1uZ6fv/+JQTpbk3aabfg0wsi2Zc58NOWofXxtL+YGzVolK8PPHJFPfb2
	 2rK8PAlrVfPkBrYEEy/ZiD78Th0j8NDvqGqALsC8PLPWgNcSpJ3J1aZKzaKTza1TqzO67
	 S0Gz/UelqBdHoa5ySYi/k/IxE/zdaqUfA2LS1hbzCLxRVh/pP60ztUCiXSA7rXX16YM4b
	 UnepcPJ6sTTWkU19QMvLLvL4leJ9+FPmBIsc3w2kLEizhgimyoqu+8AeOqcYWtWapow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLvyEPiI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AdvNFd+Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70686606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70686606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLvyEPiI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AdvNFd+Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793643708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6odvKjJX5uaeX8gp4PjtCpDvxv131iO0vErthI5phGU=;
	b=RLvyEPiIC6XxUI62HLhY5vn8MF5RdNTuLVHcZVkETa91e8J6/3hVROK6CqioUpLQ+blE3v
	TTaYVdhdghbP2OfYBmVye0zyuvgEyhjL/mns08jWFvfFEPWtAD+Wuhftu9pdGva/ilM90O
	4pW+mtlXznd8dH91Z1eNwJqUcI8K6LM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-JUdcf0cTOa-XxoA0BJjioQ-1; Mon, 02 Nov 2026 13:21:47 -0500
X-MC-Unique: JUdcf0cTOa-XxoA0BJjioQ-1
X-Mimecast-MFC-AGG-ID: JUdcf0cTOa-XxoA0BJjioQ_1793643706
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48df5b058ddso2218859f8f.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 10:21:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793643705; cv=none;
        d=google.com; s=arc-20260327;
        b=Lc5NmUuZuBRCaAPuUUNt9HeiaE157V3OARMDCm8VYUP2CcyIQR+1NsY991Hpcfs+E0
         9r/81zcTC6FO9v6DuKZv/vbAUCGzU1NEyXqmUVA/hLTBipbeF5BuX+Krmz0vSEX62t5v
         H2g+Xxkdp6WkwycCpAgb7KSYuIe7wXkEJKUsk0ElzZJL8SpuiCbEjAhNymrb2RcdZFNH
         WqJnl+3bGHeFWI1a0/8iTNNTstEDXgLnXdewLXRjXlSqMTxdFR5NaTosEi+OH1ITrlY2
         Lt2o8gs9cZa/jhm2PVQ6tfqV2KvolE6h7yQOpo/sGAZvz3Y/nOK80J353CpXeetWKKIU
         2wcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6odvKjJX5uaeX8gp4PjtCpDvxv131iO0vErthI5phGU=;
        fh=dSMssGXK1RsiqZjydXQmAH1Rrz2KdEezlgLVNB+1oaY=;
        b=Pgf8I56gK4Et8DlkDRzGsb0obPb7Qwyxp7nP7elNc+OgMN/QQ96+dsvqE0y09SZaCd
         1q6CAgyc//3zL6N0aZvEShxfO1ai51yFgVATdWnGfQpWEh2bfpWfqotitkhWO1XQTrY6
         nmYrnu6UB/8aggfnsHAB+25EYZttnuFKcodvjJRNw9YCMiWNOrWwmvOFtJOp/3S3WFo/
         SwAeoq5fIy5YTz7bbNTfe608b2eYMdmIhRkZk5xhPTXi9JaVX2n5OU9nFik24lPa87CW
         NL0yjMShn9tFkdQBQ1+3EJCcnm9lTmKgS0G50OxUJs/Dp01doNOtiaJtcw7/83CPbGUC
         npgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793643705; x=1794248505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6odvKjJX5uaeX8gp4PjtCpDvxv131iO0vErthI5phGU=;
        b=AdvNFd+Qp5s56ThcrRXPY51RUzsx7WTKHs1dZxlWqOvdJskt8ls5VuDJpN8MxxW4ms
         yu9nb3NceMKlmZBWv/2nyUcPw5ROysQ3zZOEy7G2Y1qZjnIRE/Lr5lu8JtU4eAoOUQst
         g2nGOUi3YDwAsNbrU/QkxB3hVdDkEoe0IC1D+0Q67intbztlbduUjiy4TMA4bdXd5gHI
         eQZluXMjZgD/2X/relRb0cqd6yz286g+9998yxW7SG0iO8BbRiQ+xcH8Iy+etqLQubEj
         UTAwchB+pnGlVOaq/d6o3nT1fHKjFImkwBxnkPADSnYjSvRnBNyOul7xcDlNOdEwlLJd
         lz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793643705; x=1794248505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6odvKjJX5uaeX8gp4PjtCpDvxv131iO0vErthI5phGU=;
        b=FbcduOZ4n1gYJNw4yg4usaD4zp5fxSbCaSOUPSDBqTl9OfSB4cWZJg6tSl785T7gE6
         wa1PbeOhh2NfrFYtTr633A39TS0iHs8jKKECnLJEO7RwWyvQnMkh1uwdhGCC3mps2dSz
         oA7Ie9+v6vTjJIvs/GIxA5oTt4QFPrB3AMEbqlHPh4JDQv6Nms7o02mTLHhtGcVDmPag
         xDPLYSfIzdrmWNjtzHpzKuHS2LU6Tq8wy2K63sfZ9UIbDM5Bh6og9FcopjqBhqMDq93u
         JsW+88YIZphZd2mbUeBfqU/OwB5bUekuhDVCfroyS6nVVDEFEy++gBqggAvmfnYVEKF+
         gWSA==
X-Forwarded-Encrypted: i=1; AKwUvBziBCeoja+nAkIesLjDjpHiYrWgI4RNlB2x2MT/4v8b+EV9SsEsjzQZrDXmIstCWB0SjDc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vbnlaE6FVUYGRz4pgjsnKEuxCnnsowBM1ALfD4QtBjuw5aOYe
	2j0A1s4/xgACNW+PXriwLVCJUgw3QaMR6yfe0f5RaHSWSAq+xG5RauiWV8vjUDuxliYoboLw1C6
	KEXFZyJVSB6pOdCxo4mJPtTzjhwM0wPPFi68N2jPXZUbi8G+8RhMqzu31ScbLLwGYOT6r3s9bLk
	dqCvQlSUo3L64M+GoHdyn/PqfLWXCX
X-Gm-Gg: AYBFou2dk0nLAdj+B5sn9Y5/KIeYanrRPVVLyGP3hOWL02A8CSJfx3KTafBQD/UPFvg
	cweqLNh093QnGEDzr/5//JNwKXLRjp27u+uJ0movwMN5jIsQMcW5CVhKkaDayIdhYyiNdUb1vzx
	TfMsICXHN9s3Z/wO04il6WB9OO3x+hCMk3uijtilmDV4vZbaCiCG8RolcQpwmuDzsK7klaRgHEr
	3ZfSwbfAZIE7IhdUADvoq18ouwRkezogtvFHE6wBwZ+4g3mLDk+f32qgGAA
X-Received: by 2002:a5d:64c4:0:b0:48c:6fa4:fc89 with SMTP id ffacd0b85a97d-48e6e3072d7mr26355762f8f.12.1793643705692;
        Mon, 02 Nov 2026 10:21:45 -0800 (PST)
X-Received: by 2002:a5d:64c4:0:b0:48c:6fa4:fc89 with SMTP id
 ffacd0b85a97d-48e6e3072d7mr26355729f8f.12.1793643705320; Mon, 02 Nov 2026
 10:21:45 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016235221.33726-2-amirmohammad.eftekhar@cispa.de>
 <atpGGKVAL3bAnmnk@google.com> <atqdBFgoztW0nhoC@google.com>
In-Reply-To: <atqdBFgoztW0nhoC@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 2 Nov 2026 19:21:33 +0100
X-Gm-Features: AclHuK-M5UTgxV4aiMUN9HCDx78On7qRFnJSTS_KiHaFMNraEqE7Xlhs5LdbZek
Message-ID: <CABgObfb0=KB-TvSWJaerc6ZABB8-tjyxBdFwwnLNDjhPsv_27Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Reset the virtual VMLOAD/VMSAVE bit in vmcb02
 on every nested VMRUN
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 1:45=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
> Actually, looking at nested_vmsave_vmload_test.c, I make sure that the
> intercepts are honored (in L1) *even* if VLS is enabled. I also *think*
> that in that test, KVM will end up setting both the intercepts and VLS:
> 1. nested_vmcb_needs_vls_intercept() will return false because the guest
>    supports VLS, has NPT, and enables VLS.
> 2. KVM still copies the intercepts from vmcb12 anyway, including VMSAVE
>    and VMLOAD, see nested_vmcb02_recalc_intercepts(). KVM (correctly)
>    doesn't clear VMSAVE/VMLOAD intercepts if VLS is enabled by L1 (but
>    it does the opposite).
>
> So this test case passing should be confirming my allegation that
> intercepts take precedence over VLS.

Yes, absolutely. The APM is very unclear but I am pretty sure I tested
it on bare metal too.

The only clue is that the "attempted execution of a VMLOAD or VMSAVE
in the guest will result in a #VMEXIT with a VMSAVE/VMLOAD exit code",
meaning that VMSAVE/VMLOAD vmexits can still happen and - like other
intercepts, for example IRET - the hypervisor can turn them on and off
at will.

Paolo

