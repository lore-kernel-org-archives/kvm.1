Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792627033;
	b=XC62UsdSVtGj1Y7R+YboSEdyrBHO10SiHyJ2xOUoS4dCtWaOrMbN7eg9qp219MjcRQWi
	 FICyS7aNp9QRHjnetYtJuoXdX00seUU9f53vO6OMN2Gyjd2GCSDTSwDFnVkMH/Pl/SVlj
	 JGNoD3T1o4UsJkXUFaGmkUuGqyz76gXjcW15qY7Fc+TYtKHaoA8v6Q618y/2PgTGxM2xi
	 vCeNPQksderDs1V4Cw0CA7XCVQzn4b1a7tc7sw6AkQ5x1OZ+n39d6fWmf/xhtWG8Szi/x
	 fowKkYeg2ipSI4YGp2zZPFLjpT44RNmJEv7+n7Ktd1GejQHUjQc7BIeCdNhiiqFqtNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dKiU9kYJMpFdCUEcr5JeqY2iSgmVa88T1i0ZI4p1sQM=;
	b=ISYD0A977u6XrYkqwd04BUhsqi/Xw3ihbpIR7QtkmW2kqymwOiCAr00RgJXYUwK1Xj/W
	 577k6ZW8jjme1XkTLJ7Rpx5ieWmikjSBzLPfUeBvmjm9WBgADykwBm6DpXG53+IX22BGE
	 0Mo7vBamptp4HTGSDpRhAl4EdGQWKAsj4UoUqGr1TgianZ1QUPl3Xwq3NC6g6cHfn9sy3
	 VEem7uCCuyLQF4vsZj3/3a9Pund5bs1nhE1dkc79i8kiIwktFu8KOr0Zx28loE1a0pZD5
	 QYJ5Z5kv9giIegJhnCMzALKvEveZFAmlGIsWY8Dgnjx9k1Zu7X4n6pcFjjVOLlLSr9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uH3wTHo6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A23606A319
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 23:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84A23606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uH3wTHo6
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so5685a12.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792627032; cv=none;
        d=google.com; s=arc-20260327;
        b=KhP9iSbj0LnehpLwibMvp/i0ozFXIfxcHM9pHC36k9aU1CCaxaL82TJiGopRZofouE
         yYlJHtOONtrxiED/npWdvqJDZwUvUlud5wCQpNcXYVOHv9+dBALlLHL0EHvpvSZAWFba
         ZNxlUSVLQBpfkco9Yteqz+NJ/A2qvrOugILVIrIh+A0b27K+qH6amyZF5sRK/oMmA3AI
         UT7n5mR4MBBfDeYo7fnY3tLYjTdxAJTJbKz6LYZIozXf0knjFTGSSqoa2hKdLD5wBwtN
         6kxXWk/rlzbW/NWKBKDcRBdyHPVajvFVKaCX/vetNM3xEpc7gcGi1iBuybaxtO9sx7rR
         Jamg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dKiU9kYJMpFdCUEcr5JeqY2iSgmVa88T1i0ZI4p1sQM=;
        fh=URnhNFBeYW6q3B0lXStnattaY/O3fjhJZb0lkzreBLM=;
        b=lI966qJhdmc/5+5Ezs+8ZdJbQyI1UzfpDOKPlP1k+gB7p3JHeprfdZpJvKZF/eosLg
         dty/qL/sV+AaGNDQp2ZGV1x2p1Br34SzDnvPAgdOOgg6tYooKoyv1P0GnwJ+7apA6CqR
         j6BAtuLRdF4xiQiGW6WGDNdTo4Hzxv1VzQbERnmtHzBjiKDQ4WRUB032S8kDZ4BnmAeB
         Iaz6dRi2utpQSgtDeOTF9mbe+VKANehDbk5cl1j5eFhsRRkLgtz7V+K6X6PHlmRl+C9N
         Cvc3mfo7oO+UXZse++ZG9l32m59m6mWxtbHoMmftBPN2PzbPPYJXxStQYz7sY5hPFr3c
         pQvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792627032; x=1793231832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dKiU9kYJMpFdCUEcr5JeqY2iSgmVa88T1i0ZI4p1sQM=;
        b=uH3wTHo6hkC3puToNbVrKQ/Njz2PaBewsGpg/7wba+QaivJJnprrKtqpS63wy3UTC6
         teGRk0yRuElhmT51eF3kJ+cKdnqDbsZSn3gAnrKllgGBIXilsr04UG9kqLR9WRFdl3TH
         uSMCtDvRnU4/SfyHLkI07lTWzG+qTc6CxQ0564OLVtsBChHrrw4uAU3LYaRf2VEE0aPA
         uaCkE3SR9ZaeBQBFymhUU0euqnrQDb3+f8K33FYcXC/wwO6oXSTquM/LYGTxjhLsAWUY
         sHw1oXJHVsPuL+4ASVLWh561CEibBjbDv/kZw8norr9bDCLoHQoXIoZvEAP+3zpfgok/
         yI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627032; x=1793231832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dKiU9kYJMpFdCUEcr5JeqY2iSgmVa88T1i0ZI4p1sQM=;
        b=UnpPtCYbH/Ox5/dLOll9tWs1oLqy3ahdKA05WijvhRhKn+ktGu1jq0uzq+KHx7pMfZ
         KtJPLu7x0OPuWOQvqUauLV/PNldtWJ8m+Gbjq1rpE7r0IGkYIMVk2hcDUUruy74KQioU
         Nhh4Fnb3/NRtsRNENfm0HhbfwEexeY5NEC0ou69GJ84576O5/cgwYX1FyyjJZtX1FfmE
         4buTKbV1Zrd3N7L0d5KSQrVfcUgZLX4IV6Lyw0UHA1ECFLpHqElFC9nsgVEsAN8XGb7s
         4H+zBATarX5Q3o6zJt3GkFTmwciB6Z9Ouwic7abAGu584bv0Ad6ux84Se8dwN5jW5eDO
         ULqg==
X-Forwarded-Encrypted: i=1; AKwUvBxIRUTo4xJ4myBhaeJszQD2es2WhCGpXiy95xPMrCny5SiwQILao8zETZDWZhBYisvXTAY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKV0oH9kY5xzPn1Y0XtbYnz78FZXpzT5U2VtC34nAoav/cbi+eZ
	gE0akxJbdg0GjGoIUZmCSR24xq5wx58lK4h1AkcW7RwkBnlEXv7uUx21GQEvKhmf5RNRkZURVMd
	zh5OEBLpr1sDeP5/5iH/D08/B4q42UI6sDziJYLXD
X-Gm-Gg: AYBFou0pBGLosHVWEgcPXwdof/JZm0M5UpozOq1xVYtgSni5eTs1ANwhPmyGhtiezbd
	mqX3thU6jpiXI1nNpUJcQ3lI+oLCNvAXibK6q0TVszu/kruDGyH2mdz2BLHx7Qk60/1O2BHKXM3
	gzBDl/NHsxMxwEPeZfRsclEa8qeMSaRMO6GrWZrzcNega2SI8GxtROgofNOS2f6tR3I++xY3+eL
	HCnwkWPYL6px+Tdo7cjfsobFlNCq2TNqnCQACo1kV42ztjPvwmrS7Ul4HEwq5aa1SZJf+3S1qXg
	0ZuxA68kT0Fqc4caLKBDUCj3/zgRHLq2VaRTxF+XWNFIr0h1/5eH6NHie5TV8rNtZmmBh8yLyY1
	tqniMkyKdnnAuJByDJDPlPA1p4893B5a5afpM
X-Received: by 2002:a05:6402:1a38:b0:6b4:2d6:cb9e with SMTP id
 4fb4d7f45d1cf-6b41dfbf7cemr18938a12.2.1792627031419; Wed, 21 Oct 2026
 16:57:11 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com> <20261019210532.378628-13-shivansh.dhiman@amd.com>
In-Reply-To: <20261019210532.378628-13-shivansh.dhiman@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 21 Oct 2026 16:56:59 -0700
X-Gm-Features: AclHuK-kPtdOx3vfpr_-yQlDocsep2bl1QSaDC4jvXaZpUQwsTqdOaPaxtDFnhg
Message-ID: <CALMp9eR-Vym2SkG=v-bY=sq1+MBd-=u4VqNZt12OmqmO5AX+3g@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] KVM: x86: Use SCATTERED_F() for PERFMON_V2
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:09=E2=80=AFPM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
>
> PERFMON_V2 is a scattered feature, so enumerate it with SCATTERED_F()
> instead of F(). No functional change intended.
>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
