Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794975149;
	b=SHUJADmsYcUYqe/KmK+tqBe2f8Qoqy/YYIRQIdMWUKNesJ9KhkQLYItBplnq8LiyvPZX
	 ZKXvKQFBYckqsTVtlCiysjNd5LLRkkRC9TwKunOSbwagmunw37bgq3r+UezNbt1lmW0KA
	 VBk+9ohifn6sW34nbWS48RJmN7FTP0yamNgr6PBRgVrHaXWcw/Ks0cgH1lCFSEIpiAdWN
	 U2Ace/PjWpiZ2+BQZFqfVikYCPM0L2AhOaxZMSNQdPxJ/U5me/BIsiHbsra1ZcWrX5Ner
	 iGZvQpZJxIocZdKmun46CvceW9nEqCeOZn8kovPl4Wj6w8W8wnKJE5H1dOIOP2raqtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794975149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o15E8VBznq3OnSKwZKdmsdReqhurd8fmzVNrgoC/tOo=;
	b=yBaJngo6irWlQ85vrsTpAYJ9Uk2qcNxMcy44fGQLEFoukDciqdgGERoaQ4AyhEDn6Bf8
	 XqX6RXo2cpDIkHZsNWvKRRJSu/1AB0S+VLcad+uGwAfuBORXs8pJFpUATI1iR+Zui8X6z
	 8EuKc4NOxw+N5HwpeVC2ltSPdSN0O3Nh5cXJ/SEGPJjlcnfcEsHHDN+HHVBpCXDslKHLR
	 w9glxpENfXgQi5QVHfnu6wOm1Z9GfDnAyjBbcBEPxRDxL36pl9KNnha9XqVZmas2mjkvj
	 3wQ3TAMTGLj7z/LJ5OXeWJLOgE5lnJ/CgmRvqS1AfB5zwTbsCHy6fGYYQUffMEwC75Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GREU8QmV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB83E606A325
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 04:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB83E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GREU8QmV
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b71ee00f0dso3958a12.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 20:12:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794975147; cv=none;
        d=google.com; s=arc-20260327;
        b=qklaslCB4xsRp56Z/bRAxNgQQlPlu3nBBFCyTar+0DUKS4HuxdWu/wZhfeJnCJVY5k
         ahn9fJx31fHdQxnwkhrCZY1vwMPY+nvEMNa1hz9eMgqJdUjhMafnUGFpkUEKx0TYUkRs
         6lcYZvvgeU4bCkK7p75R7KYFI2geWvYxxKf8kxY6r8SNOBEAE20j3kKg/ebeU8ATO5Fz
         nu2RjiY3wZETYT1fb7ST1OSztF4SCYN1uMuL1Mi48TaPivSRyoh+raPG5x1m6sKcIeQz
         vVCv3ZeCefc7gWuIqtCqgdETb+QiiVmbniArqaQcdpuBEAys3tbrBCzoK3g0R2NPoS3Z
         NVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o15E8VBznq3OnSKwZKdmsdReqhurd8fmzVNrgoC/tOo=;
        fh=5pbhKGcRoftsEZQtdb/nKZrBSNC6Zwr37Xt0EgOG8oI=;
        b=mWOL4zQMDL8wvQ+jmWsPWL2hlKNDNQlBryvHpOSqb3M3qemuJPG5mGzduNNZO0pzhW
         rn5S1yebSvhMOK5MNQGvy2jchKnmfHhiYKiaoGA7AEMI3OMDG7YFtexkWfZzpQsegYvS
         fhNZGBCGHI0dv4R9p4o+XKXh97JDGYrMc20T+CK/h2wO+zUhmsxu9YsPbnPwJW75ij+K
         cA2HXtNFHjDWTaTtYq9vqF77BbsbZzvXZxOkFL9olwvHzpV8nD+cvDA+CGk6UK+e4cCD
         cVfgwH7Z1IPS4onRmlgk9pSqRLWykE3TdbpHpav8jkONaWnaUJeB2CyVFn2bJhAsApyB
         KByw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794975147; x=1795579947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o15E8VBznq3OnSKwZKdmsdReqhurd8fmzVNrgoC/tOo=;
        b=GREU8QmVAmeDCEVBFwNXN7MTiYaKSv5JM7liPvTgd1rHAK10tVhyIRjpvYMYqyRSzj
         BlAuNNqBEkl8oTezNEGjdvjnfYh8fIhkgxH68zkKFc4JfNmgjS5q9ZzMgN5WaS/PISAq
         KGMf6UqXuLGPVmawKclIVN2OpGHAZFXnx+6HxoVJut3Qvhdv6buoCtCt1BJ0gxlCtX/P
         l9I7USGir/HiPtIAjNUuxiIpxpI0K5G4r57LMkXB3zoVSluMTICjsnn/SlacPJVtdBnb
         IDaSzbKexvOrk7EfSAdbxz4jwzkRiPYxAWicnRHgxJhbbm49ZZ65k9BvDjQ3+hCqmzxh
         pVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794975147; x=1795579947;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o15E8VBznq3OnSKwZKdmsdReqhurd8fmzVNrgoC/tOo=;
        b=L7jIMOx0Nr34uhMQzngtbzeCI7ScaHnOkRY1V06pKhcDEEie+7Q1jW1XjkBl9jc7WX
         I9FRyir27/6hulEobTprPnYI33L91S/fp2YTuZg0cjlmnyrWUrv1Qf5HgCKlNuo7HKTe
         0lLQ79EMh1YRAIG8X6cS0xdQeFxBBsCdooQJpJKe6sNFgtNV2XKcDvJqZXFD/qrXOn7n
         DrQEzVcbnoTY34yygxBsr72ZRpmvTYOtT3+VtjZ4X8VHAaclkRBFd1vnGw0Gm2OfJwK7
         D7uxm5iQTCsEOdinIBJBFobOaHbp9VTJG5e61RVuQaUr9TUGdyuuYwx6UIzqUidB4cKQ
         aMCQ==
X-Forwarded-Encrypted: i=1; AL+hErF/HkkSIRq1GWDl/37AisAGLQLI6V0QYgSanPMD8ynZyLw5cXY0LSu5n56Rt8bnBf+D59g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2e6ckr768lyvkTwrT+UKCCs9wxDTkuJ0kZDbPCq+2Yl43kAoN
	u5FVH79akW0LQiJOTxh5FU5ZSu+CAQSsZzP4cyVIK7b88XpmATo2PpPj8cNSB5fPlnoAehNhKRv
	Gnczs96uMyOEjbSMeI1ytTf4XLhAmixnUaG+ZEYFa
X-Gm-Gg: AYBFou2j3yImCuilDdCUQg2T6Qv8v9OGfel8Dr9PCeZySO9lT8YUmNctvS2j3gqPA0o
	TaddUeDDYUxaH79SXY8stSdDRy5mWTOesAf/vanmCw50TqtUWcaKgBvx7jsnLuN/G6e+seBxFY/
	lweb3dhAxyI/I5yV+k7e6YqkL+CCzK1S32hlW6Vqbysg0bT2HnnIlh7GirYIfp9gPDcfGwRRHqO
	uNaALlZPdT6YPjoSp8QxdIYdwml7MqUuOmwWrtMzY3+gDfL5RIUKGReRzJOAGUMTFVImuI73Cr7
	wgciyKW3J9ocXNCrydJUPbGlMcyB4xgxpxYzM/oIT/whs+a5c79tN07PbqEyiz7wSUPAZim24za
	HQzy82Cwq+y3sAUbRBQ1iuPao393FIJO5xD/bPhlY5RJcNJHTRxwP+AXrCPC8BUUAIdcERc5FKh
	QJdrItmSSjTswYoA1Xz0fxDJo28GhP6FjMdhw8YohBgCnNStM97ouy0g==
X-Received: by 2002:aa7:c513:0:b0:6b8:7775:5154 with SMTP id
 4fb4d7f45d1cf-6b891f64c29mr42260a12.9.1794975146788; Tue, 17 Nov 2026
 20:12:26 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117180310.921701-1-chang.seok.bae@intel.com> <20261117180310.921701-2-chang.seok.bae@intel.com>
In-Reply-To: <20261117180310.921701-2-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 17 Nov 2026 20:12:14 -0800
X-Gm-Features: AclHuK832QlDuaLhtggvyOdF46C2kT2L4KwGf1A_pjduHGRx-LZ-dnp3OGA1SHI
Message-ID: <CALMp9eRH4d0mKKTfE3H1Di2KNWgy++Yo4LoM+wZMydGAUijc-w@mail.gmail.com>
Subject: Re: [PATCH v9 01/20] KVM: x86: Extend VCPU registers for EGPRs
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:31=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
>
> Extend the storage to include extended general-purpose registers (EGPRs:
> R16-R31) when CONFIG_KVM_APX=3Dy. This option is for VMX only.
>
> Although EGPR state is XSAVE-managed, and thus could be stored in the
> guest fpstate, VCPU storage provides a more convenient and efficient
> access path for KVM.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Link: https://lore.kernel.org/abL8SW5JS1aV5goa@google.com
Reviewed-by: Jim Mattson <jmattson@google.com>
