Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C92ED154
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621075; cv=pass; b=ZxAmUycN7C4y75WEWzM2R59oTwxMW1c3dMnuiJTCFpPbuyJeRPqLr9bxl4QQUlkdc5oEDR++dMo01uJDLIh0DOlSUbfijvS9mU2Hj/t5wkTvl8n268wkbKJVo5oZP5BunHLt8BCMwx4bfJMiyTSm0Hmeys/mhZtUYt5nLBFtMVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621075; c=relaxed/simple;
	bh=XDMt5BuP0nC3+0ZI9ihou9OW+7M/539nNG+Zd38/LbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtEeJecKKpLugLQ0N7hb/N+FdLDozZNsYBvourwcKlusL/ZetMOZ11nQJxTBbUKvERKAQix/0Sxr6mTg+7WuyhDpVyOOg3JnnGVIBxUl4BaMgofzhQucNIVf1mH01OGYX521ftvWeMR4utkcNagI1I++D9/ATctJukSKVp5Uf9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a9u4H8Ym; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9u4H8Ym"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a46ebe2beso21080537b3.2
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 07:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621073; cv=none;
        d=google.com; s=arc-20240605;
        b=YvjJQPxbO1Qst0wulb6qHXS/rcUEdG+JLPg0afYoC4cltFbWzs0TZJ6JICzLZJEexg
         9NlTm+IGJlHlVH0LWdmC/x07oD1UL0pqzApVmQS2tASQS4WN7UldfqE9kbI+ahPKwHnM
         cNUM6ubctxjJ0/bmejNjH5Mp3w6ayy2Simqv6m3dyBIznhqrw+/EeD9uCw032DqChmAW
         j7AtjUJEw0WKJSBV5EmwcQcS2AXlBqIsdgoWE8p5jqLSY9nvf7ciQoLpa+NYsKyJDXQR
         cWlGnwLvSesA0e3BI2zXF5G2cJ/SDUctm5oimyk4WbG7lCdG0/FPCAAFAfGu4GrvW/AI
         VNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MEShb315a/WqubF6hmDoT8f+2MwTWDMAyqGOip7+fjw=;
        fh=cnJHrdkARNnSvghaNy0VMI7MkNxxMRBOCBmcrtJ8TzY=;
        b=ULgZzUaCyWI/1PWfr0reVxlNUn+YunMZUHlymN7Ac86f0VSNZVokIVF6r46WEcAUKV
         Eji0Cj24WlbSFiUXGKqZRHmgAAsWqkd1opOpCqSAQ2000M9RNtCvvNq2dGWtswh/dL1C
         iJfvGQpTznHk3MfixRS/X2RSHvNlO3cOEbqViRLYrEbRIlOzSTMEDh62HYHjAbyGplkF
         G+jocOmQYkyrcnXVUDQFRZyNJnVbMDG57yEEShceLPBBkznmBTowtFrc+9oEwO/QtCdL
         I3j6tnmnSTgfJE+TwoMdhj+/AWMSfmNY9LKbtBkaQQ9JmaPpusbKKJWufEOXur0sdvMB
         6lFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774621073; x=1775225873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MEShb315a/WqubF6hmDoT8f+2MwTWDMAyqGOip7+fjw=;
        b=a9u4H8YmY2L7oIgT1UCCV+m6SooFy6y9UEntQbQ3/4dn34Qz7x8DSqXI6/Twh6NSOZ
         mDJZc0phgc7HmCs43wOq8Zq4OYpfgkZeU3WuAn6dpfDQDCQLtn9dMqoey02MTygVc183
         /hJs7np9jm5Sm1Wf5pKec8ufWhawhHg0Hzwe/kV+0ON31VBy46VNwlkbUJnsiT8ITLME
         wdzKxEMPCHSTCpLM9NUAR98nz6eQ/XiGtBhpGxMgGP/u+AOsElmp71fdVQLGlTF2DzF4
         vAWIHJ0JLODFI3RI2vubh1imGiXF80kvsDBEYJyrKWpkV9P+RBYPJEPeIRjEx7zVgSYU
         Q61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621073; x=1775225873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEShb315a/WqubF6hmDoT8f+2MwTWDMAyqGOip7+fjw=;
        b=Ne2tQFBHwvY5mOaA1NAI4vJ485K72Fp5rmS3cfVOU4POtsrCcSj/Tc9yVQiiotWQEZ
         OoINHKY5DCPTQ12sl1bSbVCJM1ejkyj9yulOsVbKDFolUu4BOPD6S0oOZsuY3IoQ6w3U
         5KYf2qRYe5Sn5MNJ2hJ00rYVKGl4sy9xlCoF6Y3fpFc3bHYdslBafac7UsnmOgsRU8Lh
         jmEaVykwrAndvbCQ+Gq/mkQj/b6/WV6mE22G21c/VhqpbPEq/c5GYXqA8/EpUp38g6HB
         uWQ0to6klOwcjZHgOaEMW8Im6P8nUHCtkHMDsHL6Pv9C6jFKERxD+ClKd2r38p03oPNy
         BhyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFsoToktLs4Y9QVC/pK79rJgX/tnWyaV3fo5SzU2pP/YNiym4OyDIdiil9O3VuS3+AJ/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8X5unjLP3IEOs1zf/mLojn8iJLOAukU79xMZvFdyeHpI48Nsp
	XRCd/IYFL1+XUtffZ8AjM4SUfye5TVbYofgL2nmJoxQKqhe9AgOnEK+KKuGNUKwFhoE7LjvJ/sc
	yt12HUboF9sot7RPXRAI/epkW+JEWyGzKJeIowNqHWA==
X-Gm-Gg: ATEYQzxi357n2rMhNwBiY3S8o09CIQOQTcGTklc4UjG25PzvDTfJUezQBP/pJ0wo/Dy
	isQF/rySW2prGMrZKCd1MBYl2dASUZBLa+BeS0DhnD2lCnqeNo9kuMXIGtnTZsavOihjES36JgP
	evtwqv/BjKCzWGZx7kuTr1xjCDX5jv8kIt51fKaRb2wtNTMzNfQAfNy6MK1RaniQX2H1jmaqK0F
	JZWVBOv0YOv3qsi1HaFZL5RnBE6C60hH8a2GVPnba0aJI2dQa/RN2WFlbxbbLTdqhKtgsg2g9AE
	MJ438g7m9hK0bYDvbq6eYf2IRRx7BFhdJModLejAMtmgdlMHJc7ztEj4YmoRs5faCts=
X-Received: by 2002:a05:690e:1c1c:b0:64e:f712:4301 with SMTP id
 956f58d0204a3-64ff71d888amr2694629d50.18.1774621072659; Fri, 27 Mar 2026
 07:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com> <20260327134401.270186-10-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-10-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:17:40 +0000
X-Gm-Features: AQROBzA1x2iZV0aRuSLuZIZdL_8QMnXQgU2W8vy-AEPo-qqdgbcI30apQvxGOXQ
Message-ID: <CAFEAcA8b_18LNshyvOR1cfvHDVVBbA_=5SjOUJ+kxu=Jq2X7fQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] target/xtensa: Use glib2 instead of strcasecmp/strncasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
	qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, 
	Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	=?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 13:45, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  target/xtensa/xtensa-isa.c | 4 ++--

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
