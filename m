Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7213C0A0E
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555615; cv=pass; b=Sq8ouQLUYPt+uiCdeQRYLyV8UXT7G6pbJvVVQHJXvBeYxDJ/r7jcXYTnIGDb5p+G3T2fZPOhHXyX7bJ3+bMadcVel09Hb8Zyp04SUa++pPZZOwFj6K67fyh2U3xZiVbW6lCIzTWnwjQIum3DGPx/GZAt/Xq3UtTZfqhTFP4AiUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555615; c=relaxed/simple;
	bh=I4yDMq8ZmDr5oaZiEBM9CEqvD/HRefTgkgtwWuFh/Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HsAw3zhR8RNRk3LC0GWqyPEYx8cJ4hWjiQb7mrEES/u6oiHKtFE20xcl2MOl8kAp8w2kc/d9C9Nwv+jUYClGhQWEC79RZQRCZc9ZjSWUj9IvndO6WluCGZecjHc6xcCmpnLMlrbrlxLpkRDoed8VDLl+8aNYo393LkFYeXPP1Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTJ7iXH3; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTJ7iXH3"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69e4af5a411so262097eaf.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 23:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780555609; cv=none;
        d=google.com; s=arc-20240605;
        b=k8g2qTcY7TNMtXOPEzhZXF0JyW7bYwQ0aVLWTEAKVux3TWJ+sF4wSTdmyxQmABgr9o
         Oxlxw4OmZ5LugyNIWWptjoDOQ7JJXM5FgTM8lEuxCHJ8Lb+T5g4BDrJveuWWwimQXWFN
         pvsXaNlskeVu5YqoznMSbbp3b88ez1RFp10Ap39Xw5CiEb2DKYtrhjmOrJHKoAYWC9xv
         wFRrIt1HcC/XIgJjNO9DmOxXkbi5nHhBgtoKCl0IillpY8xQ88b5kC0sSL9zKICQc+ac
         oxybNlmvN5mayAVEEj16xJA8rjHyWsqwS/szOeHI7TOflcQMtXSarVTdZzWB2aSa2BZS
         ciWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I4yDMq8ZmDr5oaZiEBM9CEqvD/HRefTgkgtwWuFh/Zw=;
        fh=un2eqY7TgyzRTLSHSqWoobd8rmCtYpoA5i4od7Hio0o=;
        b=iK/eB3SI7yNwBHyyCyUebmAhMpM5rJqF8MvzcQ0CFPXomo1PzwhWskqdl0wdIN7fG9
         CWud/DBeVa6D7JZMVXkdzT8Xp5aZlt+GTcUV662Nxoxhmi7AeSSPUEZml5NaLCCSxm2C
         esj8KbihgsyuxLdPjCEoiHXvUiQzRw38jo0httcDXdfzAhijmMXjRyZH0HuOOcmJoGYQ
         jgT0Gl9JX2wY0neeC19a3GL7npDzfVvfKxjsLRHdwpkPQpFbWxBfEfqGzefn/LHD7rTB
         pc/p5d8R97Dll2GVCBLqTumDpDz9BB+s0RZ2tgfG+mpYee+hUHzvIWgc+wBoYc6inBk9
         yfyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780555609; x=1781160409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4yDMq8ZmDr5oaZiEBM9CEqvD/HRefTgkgtwWuFh/Zw=;
        b=qTJ7iXH3fpLRVkDgLWSAmiwTtySq+sothIi6klf91JW/42bxc8iSb6ymdyaiwF4vgk
         JT2GSuLyAjZ81YHVw8sMg8iWgCeiMJRIRPJzCK+GtvxadiZjx6gRzKJx0A0u5sCiKr9O
         d+TbUpKj7jIM9t97cQ0sYNORwoyUfL4BQed241+xylVlvQT0cgy4jdN7JO3TdckrDb+j
         5DyYDp9BbSpiZUTWrTcan2gaaN1ZWxsRNqgc3oRBYPj+u4dVM1e8D3P7RVb/Fwq/WrbW
         42frYqLErRUvz0B57ukY+yjmieIGRwBJ/horXkYMMNunpmkbttMdkEK2x15BcWbPNA88
         VmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780555609; x=1781160409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I4yDMq8ZmDr5oaZiEBM9CEqvD/HRefTgkgtwWuFh/Zw=;
        b=pwCmiRdapK5DaOPUsPOuCNJyjMAhYN+ozO/aJUXIFT5x/CoFUfki85RdEB3snK4Fe/
         hR7yR7YL6RskI5c2k9qgmRtl9pnH2wA52u47SEWhzSd6qyzThXx2fQ8ZVQoLdaKAmJ1Q
         K95WLAOyEvFr73d7WVfaRbzfypRI34jlwKaxQILK/QWdSsE1odZvfkKYmS3SCRaHYWTq
         H1n7gcln9x0SPReMsgp5mG0sATTJPQaVdwv5IJ5bssNyYp5nS+oSUUCqH7d67ZFkNzwS
         wv6Kttw6XrnGE80CQVlO4YS2tnP9rgdHFLOdgGCQ4o6FshuaV9cxJJJ6NjEDdOu/H+Kd
         n4BQ==
X-Forwarded-Encrypted: i=1; AFNElJ/hziJ9wYYrhgKa7J3Bz5yE2532cxApbNR4WxA3CqPePW2nfIjm6/xftO00CSA7wDCFzLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy13u2vSwyjMk6n6dmuqKiWyfaBuisAEsJUg23fWZrGR4RX+kQE
	H64uDHGof5tqQhqXINPtY8KEKRKxeS/S3i8jQNdo9Dh1VrMNOR+7R0Y8sSO7mxOr+eNGLuSeYC7
	i4CiFVaFpMUACOUceM374Aap4vsJGqZs=
X-Gm-Gg: Acq92OFmK8sK/FVBK+dG9hT0Q8qJd4MS4fxPpx0wVzGlvPpWUXwBDUQc4XTXsPNHixs
	z4b3XKAgfoucrX4GhhAqFisFTqvLDvMEr1IbNdEq4vwmZP7ZawJIdIjIF2qQJlh04zGtY7t7u9y
	mGfvJbCPkmiUHK+dwINdS+puo3l4Pic2a1tV1h5qyYGs2GSd5WLLUJO9FSDNJeHXhUNvik8Xvot
	Mebjt+KYtQDIdiGt8uamvpn0bxMHX7gxr/1X2FTf8T9gGesn+FLoLJ/SDdFe9+iSDwqa6Gai9HA
	v/Ljl6ij9uYO2d8d2MDp/5Y=
X-Received: by 2002:a05:6820:2d45:b0:69e:1a0c:123b with SMTP id
 006d021491bc7-69e47ec6971mr2637278eaf.24.1780555608862; Wed, 03 Jun 2026
 23:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-rva23u64-hwprobe-v2-v3-13-5529a7b28384@gmail.com> <20260602233750.B03631F00893@smtp.kernel.org>
In-Reply-To: <20260602233750.B03631F00893@smtp.kernel.org>
From: Guodong Xu <docular.xu@gmail.com>
Date: Thu, 4 Jun 2026 14:46:36 +0800
X-Gm-Features: AVHnY4JQnjs7_bMYHUUcNhOXOgnpJynf1huEM1b6suF6X2cIO5M1zEC4xtBl6pQ
Message-ID: <CA+Ck9FaHADhss2sV=Z-vX4zr6VL+X=goFX_vznYE9JWBGCjwZQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/15] riscv: cpufeature: Introduce ISA bases bitmap
 and rva23u64 detection
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, kvm@vger.kernel.org, 
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 3, 2026 at 7:37=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Detection of the RVA23U64 profile fails on compliant platforms=
 because it strictly requires the unratified `RISCV_ISA_EXT_B` bundle inste=
ad of the formally ratified bitmanip extensions (`Zba`, `Zbb`, `Zbs`).

I disagree. But I would welcome more ideas.

My reply is threaded in v2, FYI:
Link: https://lore.kernel.org/linux-riscv/CAH1PCMa-5W9PsX8cDLUk6-MkcM53HOz2=
QtaxCHd+XOr7DgH5+w@mail.gmail.com/#t
[1]

Also, when Sashiko says "unratified `RISCV_ISA_EXT_B`", this is wrong.
B is ratified.

BR
Guodong
