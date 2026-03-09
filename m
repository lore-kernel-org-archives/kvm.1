Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93C8217659
	for <kvm@vger.kernel.org>; Mon,  9 Mar 2026 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096818; cv=pass; b=lteBSE4Hd/SECzYiEtFJrqWq7HYoIzK9IxCsOL+VZMxgxWlytIWtrYZbnk92UzgSTkS8tx7q5/FEjTcE4tsboFFqBsjr70BpCF7FJVnmwrXZRcwWMbX/I3Jrk6qXmqM1RzXK/CEwQlJNb/lZ6mpCzMoc2amLcKlc1piOX6vEJWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096818; c=relaxed/simple;
	bh=q2w4hH754zt9HNN6xhYqQlu8wGNsJth+nKvF5WyWk7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUYgjLbYjKbhFexisAXVIVUiKCsYMQbWhEmwiqd9EoMzitX/lVQ8KVc3lg5TCY5QlQ7Z9T3zzIRRD33RTYPrbD3vcCkL5mJznXtXxmnFxc/LsmuS9J7G6CsKLraAThQYkNpr73MywAuIPZykfV60L7mr5T61+y6+OlwF+LZ740I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hHfm18XL; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hHfm18XL"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c73a5473bbdso844904a12.2
        for <kvm@vger.kernel.org>; Mon, 09 Mar 2026 15:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773096816; cv=none;
        d=google.com; s=arc-20240605;
        b=LuHWOj2rsG8sMK8uU+Xnj8AP68qMI47xT71Mj9jVydgDPlrA+P6PxQnwEdhQTgVgt0
         in3wHXMF4K4WQ8WR2iQAutldfQjm6rHgp/CwUwIj0MSnwrpLXFYQnsh7Hn+uUiHxOU0x
         XxxIflWkYsvowDuXbC27SCHeXkC7hR2YqdKRhKcPWjuVSPthO820hdYNWi2iu1ngziVR
         tD2HvgySQ1Hx26NveJ5+tcxN12uBnioJTE/BgpiYNtFkZCyI9bdWIRciA2lnw0p4Kn1m
         bPhgsy3bqMOuDjuM8/uApRjfkqnSTnCzRtZ6Z4chrlSH0bf95lO+gJrmBX05a+iSkuHZ
         jYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QvV41XeFEw10F2wL6kGciRjV5fBV2gYyjdKUcejekgM=;
        fh=NwyDxWJBNHMxfZasGFJ3CQfK4Mnto1vIMBbcvfYpEjw=;
        b=el11016XRkDLg0AVSKCidwUQ3phWeDsdEvzwpK92RctLbP6+xQv+HgDjv4Hx9Z8A3s
         pgFZZNb3fQsalGVeSEcDjEVS3QvWaGe6WTC8V21tG4BuPqlxjD5KYjnMSQaY1ynZt0O+
         I+Qz0ZwufcVliOnu2g3lWHjFgKmUU4aasyxWmkVd+4oKxARASfcPokU2qIfDyswpOGQI
         UDosSdn98wBc6Dwl4pP6MVcAxepmnvMsgeyfTUE3nPcUiPlyXMsKTObYyv+8IpUtefhg
         wHcKGcA7DLXu8Fg1Gk5tZuhThZ1GenNF57OfH50HHhEIncAyAAB5UYc6BZa5EN9skW2v
         TcCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773096816; x=1773701616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvV41XeFEw10F2wL6kGciRjV5fBV2gYyjdKUcejekgM=;
        b=hHfm18XLvDz3DQQA7MjJWto/teFQf0T9x6M4X10R2fDijFXluH0IfwQQE7xMhQ3HwC
         kUjiJcTPV4js0W947odmoAKjxGImxd3TBbIKGGDsLv8UR48dy6+BYV3NTjs6Ipv/B1El
         TD9Mzx05/ypq3Ve1QpzuTBoYcwtZpOJtqhnCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773096816; x=1773701616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QvV41XeFEw10F2wL6kGciRjV5fBV2gYyjdKUcejekgM=;
        b=NB/Y9+hc8BtVSMKWYMvMIsrNO58zlIo6xfJWBBYV5S+FUN9cmaQDdWOoE9vPta8Ut9
         uPVqyPMpwLiCkmSzAR0X9eFC3QHGIz/Az8NFqwFEVHxAaah+Hf8KZQRMy2AM/QklRcje
         e1RC0+Rm8MTlKO5TcQqWSfuobQyMhv0FZ/Zw9qr+X6+D0QfE/r5E8LKLHzUdcLMk2P9l
         Y53+OCbbcYWoBHK4MZizi1MzpkoWCeSaDS37whNZbCI9tXd6WtTuZQbccs8Xb5sVG3tU
         9tJrueOOu5zFEyG9tGZveppGiUT2QRg8D3jwo58hBiP3Mf/Y+YsghCZKbXGDzs4YfGmu
         4aEA==
X-Forwarded-Encrypted: i=1; AJvYcCVMW439zicsYHG1Mlf3Kpao9XOCKQG05hB39sGz5r4EB+oU+oTexGo7tWYw8MHzsmgFnnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtXsoN4BDGU5mjDuQ890niIyveegYRmCE9myDURd2SbG+WJErV
	ldlomRsIrC76DzGosFpSvaZY3vUbhkCq11XqB0vdui+pzGOGmshwd/p0j2gUzCw6TafDRj8SZUm
	flBT3Ou+mCpxM0gow93nkGq2mDTIibMaoZmxccpKi
X-Gm-Gg: ATEYQzwmngsuKz29/mDKAick8WeTXE9JDDKi2PV5AbOMVGnnNacgjwasKdEP/88z1T0
	DINUF1//NMnRPi1wFSFPvjCuprSwR71m3i//+Bf9ZEEp+bTMzg4pUh+rKbmyBRbx46OQYWZyt55
	zTBIlVDh+1nIAlm47RP8ZqT4XJRNvaiZjoN71nxQiavJcQ2oWTWAkksoqnSfoCiQ2HF5eSjq5CV
	Egh2OpHlN9tvMKgWkNmGwmMA6CNJLGyk8UsG5Hi71zwW1rEC328cbCyrT4R9scn4IucuvWsjckH
	A0EsrgI=
X-Received: by 2002:a05:6a20:d523:b0:394:5463:7330 with SMTP id
 adf61e73a8af0-398590b1ebcmr11616921637.51.1773096816308; Mon, 09 Mar 2026
 15:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307011619.2324234-4-yosry@kernel.org> <34cbc227-f01f-4d4b-b6ab-19bcb02d7e3c@citrix.com>
In-Reply-To: <34cbc227-f01f-4d4b-b6ab-19bcb02d7e3c@citrix.com>
From: Venkatesh Srinivas <venkateshs@chromium.org>
Date: Mon, 9 Mar 2026 15:53:24 -0700
X-Gm-Features: AaiRm50hy9_dhgvOfv0mnqtvIhNx4HhbczsyXYdm5Cyxe4ZtebOmUF4k4KW5Sio
Message-ID: <CAA0tLEoXuoOvwc5dOmdRAJDsUw3bfbvFiWji9vjjcd6TQrc8Sg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] KVM: SVM: Advertise Translation Cache Extensions
 to userspace
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: yosry@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, venkateshs@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 5:54=E2=80=AFPM Andrew Cooper <andrew.cooper3@citrix=
.com> wrote:
>
> > From: Venkatesh Srinivas <venkateshs@chromium.org>
> >
> > TCE augments the behavior of TLB invalidating instructions (INVLPG,
> > INVLPGB, and INVPCID) to only invalidate translations for relevant
> > intermediate mappings to the address range, rather than ALL intermdiate
> > translations.
> >
> > The Linux kernel has been setting EFER.TCE if supported by the CPU sinc=
e
> > commit 440a65b7d25f ("x86/mm: Enable AMD translation cache extensions")=
,
> > as it may improve performance.
> >
> > KVM does not need to do anything to virtualize the feature, only
> > advertise it and allow setting EFER.TCE. If a TLB invalidating
> > instruction is not intercepted, it will behave according to the guest's
> > setting of EFER.TCE as the value will be loaded on VM-Enter. Otherwise,
> > KVM's emulation may invalidate more TLB entries, which is perfectly fin=
e
> > as the CPU is allowed to invalidate more TLB entries that it strictly
> > needs to.
> >
> > Advertise X86_FEATURE_TCE to userspace, and allow the guest to set
> > EFER.TCE if available.
> >
> > Signed-off-by: Venkatesh Srinivas <venkateshs@chromium.org>
> > Co-developed-by: Yosry Ahmed <yosry@kernel.org>
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
>
> I'll repeat what I said on that referenced patch.
>
> What's the point?  AMD have said that TCE doesn't exist any more; it's a
> bit that's no longer wired into anything.
>
> You've got to get to pre-Zen hardware before this has any behavioural
> effect, at which point the breath of testing is almost 0.

Interesting, I missed that. Do you know where AMD said that?
(If so, why did we take 440a65b7d25f ("x86/mm: Enable AMD translation
cache extensions")?)

Thanks,
-- vs;
