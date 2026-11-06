Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793926517;
	b=E/nm9iBNcDAE8YVHiWorYVYzHiKWCy8/sYHU4+sAY34/9wLWyak4APW3AXhMClBARBgq
	 ygF+sZ9dEt0BSQb7GclDPYPoW6zXXUk1xAr8vQ/W2HJ9SzWdTLicXOMDwxR4ozCa90kfI
	 k5rrEXlVUYoFHBwVfChWyhIrI5vagoK0np7CmnAT1xIp8T37kTEnF50S9WCEG7J1wTZe2
	 Px5UyUGzzwVp8UsZqkvikWaZaQKtdjn7mPAyizSqRDoYGM/SxKf6QqEh6bjtuCKtVL8C9
	 dltEzzPlHJx46O+JZZG7sVgMqUeZ+Cqj/Pp2MM6HOdohTeGnRZcysKQY7QxarJe5Y8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pvie7FxBEE4F5TaOVTDF1PFxgKTWTgEZbktYHKnnLNE=;
	b=iG5c5F+xllYwLvh1vOJBoZpGbZL5Ff37CAEoOYW7/hRLpSBi1sSA0vEnBU0QGTjW4GOF
	 HcZIWNLCBM6mCgJcn75xnN+80/CGMYVyrmQprxYr5dXjXtTTVfO0J4JTZY8K40f4pzdwE
	 ITF8U8/iuq9e0r0fHWegm/mFguFeVM1oOYtDoR2TwoGA+LGRbfSRmSfoTpHKHABi1EvmU
	 bketoIZULZS/sgfmGfsvEM7vbSxVE6OWs/oF55TT8HmRlS1XpFKh0WpyCMXTp+QhjYcEv
	 mv7XVhFi5q5rCZXgv/sKXVvTvkHwR30zMxP6NSP2AkC7bVMIE+Qaq4CFI1TViHEMpHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ISO2iGUb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F170E606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 00:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F170E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ISO2iGUb
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso508a12.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 16:55:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793926515; cv=none;
        d=google.com; s=arc-20260327;
        b=BCfYOKkj/Gc4nClS1UyFc3aUILDbDDDkc+a6G13o872vQQfI/iKCWtzohGOlw7dmDb
         WUbuBYnDqUWtjfnQf9mBvTZnX3wpxEqd1O2aYl0RK7BJIA8eVEKRHsZj4ye587blpMY2
         4uad4cIsGCUi5p3yAV7t3sG/P0tuDIFKmlT84ZY+rglhQU6yXzUIJvOlKxEiG86v6i7i
         rRt3yZXkehkMfhrbT4pzvI18Xd6qjlxo4WmZzDtLfWXE4TXEwfkZ2PlBQkasiS4vWaXP
         GNfGvDLnKfV5jdZ7r0FyTBkVUHdPW5vROPprhBt0avAAG0lwSuwd61LAxHFpef7bXNaq
         P/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pvie7FxBEE4F5TaOVTDF1PFxgKTWTgEZbktYHKnnLNE=;
        fh=1gMKAPzbNvNQZRJuvZ5y52yZsPvFajyvIII+6H8+5ZM=;
        b=U0Vu22dm2hRfNUAzlCit+Q+4BFKSqf6/fMCRe1ddA3VYn66zZqnH+I0UeEOHkdn1ok
         tMg2MoQcaASso1oHmMw69o7aTFqeR/vvdJzRdwscEpRJzyxI0LCv1XvQScPsZ2hAK7fv
         fetHVO3aNNTTS0feV59Bz78+8VU6q58ia8IxV9B4Ed5gWI/8F+VmE1zJHzx8opmCjg2A
         E8XTmOOYFCu5M4aLUAlLjGq1OJLLO0f1/bu4dbjCXnWCm+pC40gD1KfapSpbWqk652Qn
         5IHuZJZL7IuojaaUUFJtJ6QgeuUlyw0l5Zg/PVO+7+tKKsbrtXmRvoPr7Qn27LUXiWfm
         1ikA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793926515; x=1794531315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pvie7FxBEE4F5TaOVTDF1PFxgKTWTgEZbktYHKnnLNE=;
        b=ISO2iGUbJyNCA/wAEq2qLo6dBg6+FoJRGf/RmqnIrc2+/+FPoequVAO2bp5ik4hdgM
         W8N7cUWtI8lVif1u4+kXZMEIdjFnexn7Tegch6r/orESYyzoHEwxkdjFXvdUP6EXWeC2
         TZ+gWacoD1uuP6mRC1awFQ1bXQbX1CM9xvTSQEQGZqibX6iSY2k6+4Lw6T0PqEir0DRP
         p3IDHjpVoaaJx6Hg995ZuhualWg/j/zgW+JzpRf9rmxh82X2zP7R8j/P2p2aHuHY09QN
         bTOV+phN7ROVnF32m5+kgBpUViZ/y/naJhljwWpI2/8JDMcvvHSJYU4imAS/jk9EXO/J
         t/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793926515; x=1794531315;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pvie7FxBEE4F5TaOVTDF1PFxgKTWTgEZbktYHKnnLNE=;
        b=EIK5ReM0puJUQQ/M6GmvqScn0VHxErkMXtBJZSN6UflsVbu6eCh9BCrh9YosNE1zHz
         CJzMWcqpRJEfnC4LzUGmpWJ2YFYJ3cfhNMRyMnUNEnTq/x99luo5zWr3qBf3PaiNakOU
         s+qWzR6O0DGWHiy+deb7cRo/XZqQYC+Lefi8M08BW7j9+FBkl8gwTPh+JZ1qVkTKla6u
         H1rYEQDzJsPIuhKeMknuSLhpKVkB6WaIoWdp4u/fnmUweNhRpAAni9N+cOZRxGAtXSUz
         jWBPz1atGcJFslayjcgETzHqEm9yeUfAMvAWBhPefsimW538PeB+vJTjHDyllSd/lPVW
         gqAQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+THBRScR7fQrV/u+IobR4PuvTR049yRGL0IyOf/wH75ym5aCuIwW7syAERuw3zuUMpsY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9iJ+ksHnrvvLWdy9hpfr4zZ5paCgDWXlL0KoHCfXU7wJWfrseo
	/bFcLrVFeYew8D4z19eUgpMcZ2cj0X8UkMtYAqikTTMLg4tmHPl+o0fos20SDUsRrSXXhleEaar
	Wr0lBZoNq8KpH+s2AiShq9PvDx3W6fLrEyKFjgEHdiQ9wGBu7jylwYy/7F+g=
X-Gm-Gg: AYBFou0PE7ymLBipbh4yFmoM2aJ0p8z6w195A7SeXZjDEA9c1vSc+lHHa0qoNwutLlu
	CRbYSJNO1ixeK3PFXPJRxuXf5IcWgyCMXJwCX4jjY+24Y9eyllUH6nbB6Ivq3dEW1hAHeX+dRiw
	UAea2m+9O4tF+pk3tmU03Ehd+QToGlPOQl2k3ZTpsNWGyP455ykLdksF6O9aHYisHh0mj9lr8sm
	5KSy/MrKlZlY8HpF+ifDVTBi5aq17gKmPQrIM94T3gX9pNkqkVXLKQY1pG6Oh2aihm2HuEp+DpV
	iAKANdX0jUXKPhwre7VWdH5Z+2nCwMZWTeDCTJnRJ/GtQWJiK4E79DZ4hVrrOw095F/trAPda9R
	t7v/gcqs9tv46gBrkV3EHhjMthvv3wgYOQA5v7q7PuPgDq+Dot0XtkV2QN20yLJZTX68q9EaQEf
	yMtzHMzUnB5n1+50DiULxEV5hL
X-Received: by 2002:a05:6402:c522:10b0:6b5:76b2:5e18 with SMTP id
 4fb4d7f45d1cf-6b5977846e0mr49036a12.2.1793926514814; Thu, 05 Nov 2026
 16:55:14 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-11-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-11-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 16:55:01 -0800
X-Gm-Features: AclHuK_-OK6EgfRmV9tzgyyzokHRo1Q__Zmpl2-kwo5V2xZOFJ29vYCt0VgLuqs
Message-ID: <CALMp9eRwVfSCkcZ=hbaPO9Xp261wCSKbB-rHYHxbNtdxCGm-Hg@mail.gmail.com>
Subject: Re: [PATCH v8 10/20] KVM: x86: Support EGPR accessing and tracking
 for emulator
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:37=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Extend the emulator context and GPR accessors to handle EGPRs before
> adding support for REX2-prefixed instructions. Like VCPU cache, the
> emulator can uniformly cache and track all GPRs.
>
> Also replace `1 << reg` with `BIT(reg)` in reg_read()/reg_write(). The
> former performs a signed 32-bit shift, which becomes undefined for R31.
> BIT() instead shifts an unsigned value that is suitable for all indices.
>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
