Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D7C2D7DD8
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078078; cv=none; b=WKzkr3ifLhxMSEuMDzTWpEUjV4t/nIFq29+G2s16/faTBIY3WGv7dnAWQlMh9i38TOF7rD78x68OM+I/MJxgn/pbH85xk+4YIRgE8M69rcybpTM8XSEuCWRGEfGg5IaCeEeZFg+mHin3u1xtRSd6mtO83xSmolD0ml1h1Ep6Vj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078078; c=relaxed/simple;
	bh=+fckS+NgqRdpX2G15hiPC4ESkvDa6H2uMQzbbYaUcMo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vGsSld+cAmEZ+zEcLtAwEr2Sfbh1BUuAdCuXDnW+uq/h/8tErmCmPkpRkmu2kIvRtiIVoAtUiVapDQhCg91uwc3yoOwPRWVpoF9yauDC1tI25bBcnPRdQv2VCcIeD0kQ+pwPEMqFZ+3qq31Lku7egi4c27Bh4e2azfRSBT+wL44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pB1QMOGE; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pB1QMOGE"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so21011915e9.1
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 04:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790078075; x=1790682875; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1l/DDXi+ixsP8UR/xdW8/FdP1rFQ11pB/x0lVNBU4fU=;
        b=pB1QMOGEa8YHPqQ8V/D8DtPflXTgP08ev+uVm7aKF/PHl20MhRghw3FM8UiFXg4Ym9
         Vl2x7izYzIg1t/ntbGW3PMovsiDTWEQ1WsDFB+W7D0TkVNzB5tKoeM53/U/h4MCsgVCK
         sKKXVkCmoZgaUEn17xLbD4N1C8wz0l9y0cTiieRU/h60uW6A9TYDHssYdVU88DImiD6+
         bq53+l7Hc8LOL3+jzUqmr1p6rYzQbsSzUbzScjz7YEP8Nc4lky/p0UYyRocrHz6qfOgC
         cCRNwvT/C23CT4krds+tp1rDNuyD5xD+Ue9DH1dwsFtxwSioeiDPP9IbCAo1rfOCHV47
         qS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790078075; x=1790682875;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1l/DDXi+ixsP8UR/xdW8/FdP1rFQ11pB/x0lVNBU4fU=;
        b=FNEEyCJ/UpE9oRYSgSr/51WTbdCA4vdHMXqEWkUq4qrBRmw0aZt7kZA2CgW6fqpmJw
         C+a7olB3uL0K6fX46hwKtxcRshUg+AKlRsrNikzTSF1lu5DZLVmHv4WtjJc9Nx9Rc5zx
         2T+JKvW1Lv4dhBrkVH5GP1wv5xlPXIm3zznLBQamn2KCU75nnosp9Et1JSoRAEk2c/Qn
         ySa4DaI5hmFE/X+uKXOBAmca7pT5RDmJP2r1TG9hxOw51b+pPVtpS0rc0hklHivu+opB
         2F1mguhCAWnianSt8uH6MLM3hQyTEJ6N/T3NDC+rnJZJyQWvNlG5ztK5Onz0qYXIcW5f
         ByYw==
X-Forwarded-Encrypted: i=1; AKwUvBxeHKT4iOmM82/ejGHkGtSI/7/kjGGejuqMoMPeZhtTiH+gS6p5ZUf0+GyykeMgt/o/GF0=@vger.kernel.org
X-Gm-Message-State: AFuF++knSRReNVAjGJjXVgng2d7AsCCk1uc+dqJeazxyE4lBjGleVpyh
	qGkKFpUSbUSDppP7NWmgpdFTdMapgHGiHZ2PQEnP031rLSChIzTfLRmD
X-Gm-Gg: AYBFou2LK8LZpnIL66fHNQu3oouDvq/rc6a0pFFrfZ5BZV2N+M3FdfY/ETtvotbALKs
	NDGJaSSKwxWikwuFbsP/3b71jvFIuHwlgNNFrjagKRxE5z7kiaw9hTaIin4dCpDD46+Joxx8Rkm
	PglgSMIoJPWeIvn2CZv6oXwhRUJQoZLPJbEg3z3rAHQIP12EfnGjCRNbxujJre7nJ1d09Ar6I5Q
	WFWbFDTTRHff2L7/F4ii0xjGcu7NZgDwnHSlcKxAS7kODstM8J0ZV/W+qA72pjVB/04Tgw0yjzB
	8j4/BLm8CDz9CdraXXc2KCtuwbjG9+/A7rtp3yQf5xPvOf0DHg9fVBGJGEy3rrIasmnlivKHJQW
	amg1RIV5dfon58dQSwrvghN9aVbcDMhyMuSA/w9uwslVyQYsQvs5SD3jy619L9jAl9LLxG+FWze
	vr1/vn0gFzMmCgavppZpSvRYWbfzoN1M5r5GlnjWjLIxnF6YyRNx85SJFpnm3PqMq83av8L9fI
X-Received: by 2002:a05:600c:548c:b0:49e:6e7c:d895 with SMTP id 5b1f17b1804b1-49fc584fee0mr208055985e9.26.1790078074473;
        Tue, 22 Sep 2026 04:54:34 -0700 (PDT)
Received: from [10.245.245.94] ([192.198.151.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886277e185sm4706331f8f.16.2026.09.22.04.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:54:33 -0700 (PDT)
Message-ID: <d36468632f54e15c9107169af03b436f22e0a90f.camel@gmail.com>
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>, Fabiano Rosas <farosas@suse.de>, Jon
 Grimm <Jon.Grimm@amd.com>, Pankaj Gupta	 <pankaj.gupta@amd.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, Marc Zyngier	 <maz@kernel.org>, Oliver
 Upton <oliver.upton@linux.dev>, Steven Price	 <steven.price@arm.com>, Anup
 Patel <anup@brainfault.org>, Samuel Ortiz	 <sameo@rivosinc.com>, Jakub
 =?UTF-8?Q?R=C5=AF=C5=BEi=C4=8Dka?=	 <jakub.ruzicka@matfyz.cz>,
 =?ISO-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,  Vishal Annapurve
 <vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, Kai
 Huang <kai.huang@intel.com>,  Kishen Maloor <kishen.maloor@intel.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Peter Fang	
 <peter.fang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li	 <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	kvm@vger.kernel.org
Date: Tue, 22 Sep 2026 14:54:29 +0300
In-Reply-To: <arJNemNy_SK3mt_c@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
	 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
	 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
	 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <f2889dd6e44333b2a5bbd4bd32a4557c3b50a3cc.camel@gmail.com>
	 <arJNemNy_SK3mt_c@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 12:42 +0300, Tony Lindgren wrote:
>=20
> > Anyway, if I can get the TDX module to allow dirty tracking independent=
 of
> > migration, we could pick either mechanism, or even implement both and a=
dd a
> > TDX-specific ioctl to select which one to use. We could plug either met=
hod
> > into the KVM_DIRTY_LOG ioctl - both would work, just differently.
>=20
> Note that for TDX write-blocking is an older approach. The non-blocking
> SEAMCALLs were added because of the issues noticed. Both features are not
> usable the same time.

But let me clarify one point: write-blocking (the WP-based mechanism) isn't
broken - it works fine. For fairness:

- MMU-intrusiveness - valid argument.
- It is "older" - not on its own a strong argument. Older does not
  automatically make it categorically worse.

Side note: although I always try to remember that if there is a real need,
we can work with the TDX module architects on the  ABI to reduce that
intrusiveness. I do not see the need yet, though.

> If non-blocking is enabled for a TDX module write-blocking cannot be used=
.
> Also note that the dirty log scan features depend on non-blocking feature=
s
> being enabled.

To make it more pronounced: Tony says the blocking vs. non-blocking TDX
export mode is:

- Global for all TDs, not a per-TD choice.
- Decided at TDX module initialization time, and cannot be changed without
  re-initializing or updating the module. So in practice, it's a kernel
  init time decision.

So my suggestion that both could be implemented and selected via a uAPI is
moot in practice.

Good point, thanks!

Artem.
