Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65513BF662
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550617; cv=pass; b=lGBftqv1+FprbcGhlcxNV7lIPMjeEZ3Xc9n0FNWfp2bryfJJrAGzu3Pzo8adLgYRNd8pG1TutZrSUNtq7J3jV6NJipr7mApCmY32mHzPLXj94+zPuM9cCwvyb8sxybjE35y/VMw+HVpabEp1tHkzNXXzunNrFK1miFNflPt3v1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550617; c=relaxed/simple;
	bh=4HC8s43tFJbSgyaqkLOVyH2ryMUhq+vDGxIzbU0F9vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2gVoWq9U4TbTGYUx4Kqs+0TSy2tLburpvXLLlyeTcYYrLNrKL52uFR8DrP2DTfgqQ52EzIIuMu+cjzfVRkeRsCIg/KxMmVRqqxdYjzj2qjpVofNdIWUB01CKmH4iCW1kZSklwvv7Eb3Oo6fC1g+RuJEu2TqRKPJJHo4VDzaRxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=osQ1CtVh; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osQ1CtVh"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e6deacafa8so866923a34.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 22:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780550615; cv=none;
        d=google.com; s=arc-20240605;
        b=TY3aX1mRgTJ1gtZrvywSbd7pAn7zCTmfEAkY3OfrIZ5r4OL6mWWEljKVdE9wbXdQIR
         O3Xwgj9Z+NuyNxSu3iEv7KIlc925UPcKSg3DJjPBd4duwtxbjLVOxrgn27PlB/CQL9EN
         ANbffdYtN4ufOtEmV7gH7cpLRP1KasFhxpht9N9KiafSv19LxZPlGmCvJOpSrGcLvUtL
         SrU4qtIZzMrSfU54J1pNHnPeOFUuRI75zSPeXp5vwJtVAxpuDxz2v85Ct5AebJEP0oNk
         jHUoUmh+zIhjRFDWxAIo/6EXUbyja0zMjgJdmlMjOgebOv0pgiHzPv2KC4OTEkyvVWz5
         W0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4HC8s43tFJbSgyaqkLOVyH2ryMUhq+vDGxIzbU0F9vo=;
        fh=+3+XuaFuBaapdlSlZktHDNUX6xYm/zBKL1Ec1wrMDrA=;
        b=Vt294Wvi+G67PCBuWtT3J0SYkLglmBn8p4+ETKlMKiragD3XGy/SvB30rseqGRZOLX
         GyCsmY/aEFEFL10tQKU6GvXiN5Fuw80m2k5ZKJak9arr4gfFVjN8+c5FB5j0DAnxlufz
         S43dzlo6JqsR16c+8PcxgDinFCoR4UNxkEMtAdtXW3UBodXG/SzjORPBv4EOA9cz4OwK
         QPe3kuYx2ns3H7GJTQ7BU6P1qRuD9kWRIQB7hcyeJ5r6E8RpHK6t1ICEGpV3mYg5sJ5/
         bd4Gcyuu6ac7WvoB6xgsRs3He/eLCfYHuD0DFTk+hBJD483UNHK4GZqMXEmtzin6PrAv
         4SOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780550615; x=1781155415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HC8s43tFJbSgyaqkLOVyH2ryMUhq+vDGxIzbU0F9vo=;
        b=osQ1CtVhcrS1F5zIUEc+lDa6/mST78Xghsj/4zh53QhyxbiAuWbkTGYF8+jQfv4TKD
         NW8ZUtTtntl6OzeWSJgjg4tUCGHi20I0BLP0lbmHwvO5l6yCNtAkNnUtrXBQ6UMhh5dc
         wtCrUNbjHMYDRX/uBRLyUtFdBhgnxend/3dQxSeqj/vcW+EXZpdv3hLBqPu82L7crSmM
         eFVsVR4AIucOyH5sQ0nnnOYR99GTWVZFO2zwP92NBr3pc4GOl23zxITF14XoJsVX8XCn
         yz0+qkPhBaDPJBtUckFMOXp/e8VoAVPQJhfimw+j0v5tY15itPubgdZwcBCTcdubcmPA
         70jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780550615; x=1781155415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4HC8s43tFJbSgyaqkLOVyH2ryMUhq+vDGxIzbU0F9vo=;
        b=sWXKHhEWaSdGy1S8r168KywbGF22NGcVNSGOb9rPwfiIKFfrH2KT7r5SyT0geybUha
         NF6Ihx6qEZAJXULvtE6qFePUm3lQHzlZWaLYscjFNjSvjwQwlr/ry7onfvP/bsxpC+hN
         QZq6ZJAkng+TMVzPQW6X5kLnBUu4oa7qdjvikcD1T+ZMs/9r5cNUldSFEWSYYysd/j85
         NUVA8rEcnr58EMXWyX6frVdrcbtNaLQ+N6DCrXMsVroljgEgpVefCDFsM+wlSsSE+ubf
         sktUaJoewkZ+NGotaaDdAdHSOeOBTMUK3xdXHP0KCVIStDu8dUBvQal0Gd2KwMY923wG
         acyA==
X-Forwarded-Encrypted: i=1; AFNElJ8EeDnAlXY5JjkdFODuo6LqWWiBB/AJun28t0G3BOp130QKoiWFYUzq0ZXOtug4lNXORd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd4oxQfjsphd/TaafajRCUSTEzrOHlXEDNF6etTcZEt7OGLdxi
	TglFyVyYK07tPFhs3o5C7d0iUGIgMeDXsZnoyvR1BxQTBtAGstQgUiAl97V/XxlSBmBdIaXQEBV
	yeczpiYzoGulNU9m99ed6eAxQxibS0+s=
X-Gm-Gg: Acq92OEw0iUp/bU87nUS2w8YaWcYYxVU3zyiJYsBOMT4Gih7atot3WqxOtFJKk8dFDj
	6VXlqgM+eCM2sMf2Xjwq6lyTjzv9o9SHZh+GbWfimnQj/W9TLzclzbu96+9M0kmLPqpwZHZ4+WW
	Ll6iYll4Q+MAbQUAI0tyfdiJIkkBmhOEyexvPa2WHvqKpBvAy7aGYgrEapvG7qkBBBANPInadxN
	Re7AOEnQOLIm9MAFs30fZdhoOaxkQQC6WKGnWvSuR2nUmrIb1ryYrr9yP89Hb7VOm/BLwB3CwXu
	RN1ltl8e3+lmanTqBtpuM4U=
X-Received: by 2002:a05:6820:c2d0:10b0:69e:5e9b:a47d with SMTP id
 006d021491bc7-69e5e9ba739mr125726eaf.5.1780550615598; Wed, 03 Jun 2026
 22:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-rva23u64-hwprobe-v2-v3-7-5529a7b28384@gmail.com> <20260602232859.3494A1F00893@smtp.kernel.org>
In-Reply-To: <20260602232859.3494A1F00893@smtp.kernel.org>
From: Guodong Xu <docular.xu@gmail.com>
Date: Thu, 4 Jun 2026 13:23:24 +0800
X-Gm-Features: AVHnY4KMEU2WhD0nvjMwpU3NMXUXsI7Ox3Ri4eRsECUeb1hKlU4cqSpj1AHXzbM
Message-ID: <CA+Ck9FYWCbHO6-BU48KLx_Lov7pJiSbAP8j3Te_uqFFq81rUjg@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] dt-bindings: riscv: Add Zic64b extension description
To: robh@kernel.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob, Conor,

On Wed, Jun 3, 2026 at 7:29=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> The properties block requires multi-letter extensions to be sorted
> alphanumerically. Because '6' comes before 'c', would it be more accurate=
 to
> place zic64b before ziccamoa?

On a double check, I found here Sashiko is flagging a real ordering issue.
(Although it exists before my submission.)

In current riscv/extensions.yaml, zic* entries are split into two groups:
one (ziccamoa etc.) sits above the Zk* block, the other (zicbom, zimop,
etc.) sits below it. This is wrong considering the rule says "# multi-lette=
r
extensions, sorted alphanumerically".

Would you like a standalone patch that re-sorts the zi*/zk* ordering
properly? It's purely cosmetic.

If there are no objections I can send it as part of my v4.
Let me know what you think.

BR,
Guodong

>
> Does it make sense to place zic64b in its strictly correct alphanumeric
> position, rather than continuing the out-of-order grouping of the existin=
g
> cache-block extensions like zicbom?
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-rva23u64=
-hwprobe-v2-v3-0-5529a7b28384@gmail.com?part=3D7
