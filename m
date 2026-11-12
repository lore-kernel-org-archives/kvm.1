Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794442462;
	b=ekAcCi3SRej+LoRCcTfuXkm/4OftXkSlsvroahjGJQwIXI4la+YtjV/cxjIep+h5vSzF
	 1gy674q12I+8tYEu+tMgccF8cSUcptQsHnLiup7SAMBNkWKji+4IeZ/1pDy71Wu+nMXm7
	 EBg8T3j14uSbuypbtMnZbH1f9O8Cm+yqimUmk7yQlRMXIZRXrigR0Y3fiKv7aFh3/rXxx
	 7iAIZKZeRBIErfYKz4xvdj+aMmAe4SpkJaKma/3poJlPLsMk7D0Dm5jk8IR+racbct1qP
	 xEvBr50CtitNfB4qIlq1JnR6IAnKPZwt9tpXK1FzNzHh2wEDaAolgFNiRqnktCCUTNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=38yqiB2sXmOQNevupAUQiKNneKLB/boGfQXhDS/dCY8=;
	b=KJKZmvtDi7TthhsmxQCdZJoSF4aohmlkeatytUfbCo9CCZ0SqO4w2fiHguyEWqj5sRjN
	 PDBnWnJX1wn+g0465cXp6kCfUIAbKg+nzbYKoXDuCQlTY3tUH6LZMHrI1Y75LHxxJp+25
	 L4X1nmO97uKXdVuHpR3k+Uym2hIwzGSlrDJcKv7Zn948GCFZDNgUQM1dPIemK15mf9Qlq
	 Zv83KhHgNsgz65G2tZcwsfzWC+FuazBSvFdwNH9cGeyA6TWW+eNUyI3Yd/gHLuQjq37B0
	 9GjnvRt2rEXO8A1llX7NcQetOj2oD1sYYXPl7wRb5v1fR+uqE8SsbFLN29rIcmlLXFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SDyjaxyb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9B8606A324
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 00:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD9B8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SDyjaxyb
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso2492a12.0
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 16:14:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794442460; cv=none;
        d=google.com; s=arc-20260327;
        b=r35T7BerL2daiya9nB0KhEGnkho8gOklCcx3PHDRWPlsAKZF8R6pv8jjqAVH/WV7lk
         VQY3TMPsizoPXC9Cx+ZnfkLZBcYvFl04dfh/ybyfbKqE85+KOhayHrTjJ8SAGExRFmsP
         NpAhdZ7SEsobyaWektiFEEJyr2/YbGyrTEfSKOOasvgXPOHZz4aX/LMyaY9Z0ZqHp3k6
         XCM6XGACQ3QVKpuXHGAOX1aFSDu2x3qAYbFn1Yb3qRXq+E2SqYTZwHf+k4zlRvTX+85q
         9deHzcjlO3vGUqkZPddoMaVGM/E8/mbxnMjwJAlZfOhR/++jj07faLsU+in1QQuoVmfD
         IQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=38yqiB2sXmOQNevupAUQiKNneKLB/boGfQXhDS/dCY8=;
        fh=by93oJayI/HZYT/cv0YqVsWx4YriQJdg4mUAoPmkLSM=;
        b=icO10aB7/SOIxqFXovWDzKTowbaEu7bs5zjh+wpcLaq4/S669yMq+c1E9ydIrIccsU
         Xf1KyrUwCLrQBchq3icnck+M66J+upNnunIEFeAMkdK+dvJJ/SyL8plHVvGdkhdFzMiJ
         WPd/Uw73aPKDclTNgQzjnfR/WW/8+hllzl/bbYqTbJuSDrRjJbWNwuYRapG5Z0MMWZVn
         Mgmc0gfPynDuBi/+H5LM58gGYJ0fn3AUGdm0eQd6S9039ZIRfV2UsuD/8XyJPrBiKllP
         Ml8QesRv7vo3F8Fh5QVGDEgiqtHIYbmGlGv5PC2uYnFNRlyVHDEe91HcNwMeu9z2Pl1R
         xq+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794442460; x=1795047260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=38yqiB2sXmOQNevupAUQiKNneKLB/boGfQXhDS/dCY8=;
        b=SDyjaxybfpDZ+GWIRXwXHRgNXxO+19SgUyPxzBxooYLTFpYqLIiTwWA4lKfCpMdefA
         ADzdSU7SYgKFDnyosvW7whHJ6ZFRKXJswAkYa/ScGcEVt0/cAWuqiv3shn7VsTJdDFUH
         Gayd79YDMjQ+hlLvmp7jtusCjGIeemXeOBh+dZChDXwF0xZfsjg1vt8sxm/z1dT37fAG
         uF3sXlwYAzk7LBljJaLhKboJHyc+MrKQQ7jJPuxiBPYP/Kc3RHhWIvNS7kCumAqjAxJp
         kZjJlWqbexuSuxva3sF7tsLWP3si7+ok/PkDEwCBrX0Mr98Trfvvel6FVCg7CdOnTBwX
         dKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442460; x=1795047260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=38yqiB2sXmOQNevupAUQiKNneKLB/boGfQXhDS/dCY8=;
        b=pCnC8tdgk+amSp4ZByZkH4tJtMBxz9AfTyhL5P5a9zzPQOrpQn6LUQsM1R6K23Rcib
         9K7Q53jt4f5KD7BJDAmVGa0bInenHt/tW/bk7FKj1XFuMsemdSbmgCv+qHZDu/AWDrLg
         d9WO0lFQeP6qdACU9566T9WlKzb2wmpvmuwiMlhEez96l+UnDvRi48JNlWHHD0fyoLze
         HNmLjNpq7p3x1v0P1XGaffZCP6Bt9g8DZijy0o0YLodfmNdELYXKo3UA7heG7C0P9+QB
         HJofvGoboneCjzYXeJUNrKjUzqag5LUYZzwsrkJcfuDTLYvME3arcmqA6okOvSkG35AE
         Bxmw==
X-Forwarded-Encrypted: i=1; AL+hErGhwfh/pRhim5bkNGf0mjjt8yG3xRXsk5AnwZN3ss+Pa/VvbdOpBLA1a/G485iZ4GZUel4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3h9CRCagjhcmR3AAoLy5KLrL02K1lDz+FDqo+Ualpt7JInRwA
	7bytj1jmCVxUp2lObUsG+k//AyhkSTf+6NxiuuX2+kVoh2Iqa5KqQW2TtduwxYRuu+Ycg7ESlkp
	zUv/NXX7QtV/tksnCcOLYho2H2wcE7QzHI0k+E7P3
X-Gm-Gg: AYBFou24KwEkQrDNQHEapBbJiD0YtDiWZKsBf7YTz+FaNHvUlLydfnIb16ZvYOpc0vZ
	S1utpu7Kz9QnOcOe2p6+DP+ueXzhTCQYmHQX1/Cmq7WAlVtpd4/m0H2JIJaXKZi5tyJFADKG6Ad
	/CFbbJmdaesm6Ni26utbuvl0UAIcBLzxnTdXjesh/26cDeHKUXUpQL+Ou3sDzZ7Gi4rgM+pgApF
	z3k66AQYO3G8myzNAeep5dZFSqhU0AiuQPa9PMrN+T6JVI9MjFT5O+9VL58YDkoeTPNZCZ4YLqO
	A5VdmDHMJhtuvavHFf7JQ3bFdAIHizvm+oeSPJGEj9VSz+MvobHf73gZ3KW+JKq649ovTmdN+rR
	4rkTJln3DJh5n1pGb6eN8Q5zUlFYEXKnJcASL2b9pwK5F+r8G5pmoQmeSgwqML+tbFVewcnyY
X-Received: by 2002:a05:6402:911:b0:6a6:8513:7e14 with SMTP id
 4fb4d7f45d1cf-6b7a29d3f71mr25280a12.9.1794442459610; Wed, 11 Nov 2026
 16:14:19 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794374897.git.zack.rusin@broadcom.com> <07581ff5998d40092c2f171ffe1fb05ac48f9446.1794374897.git.zack.rusin@broadcom.com>
In-Reply-To: <07581ff5998d40092c2f171ffe1fb05ac48f9446.1794374897.git.zack.rusin@broadcom.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 11 Nov 2026 16:14:07 -0800
X-Gm-Features: AclHuK_DBL8YBFb4m-FcpIKCAISr9plqpjdioafs2WWldumLjrzVfpqUvhMg3BU
Message-ID: <CALMp9eQ8ihM7LKSUHHOf-i=R+Gx=7ETZ3r_83P3SGovBEFX87w@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] KVM: x86: Move VMware backdoor support to
 separate files
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, Xin Li <xin@zytor.com>, 
	Francesco Lavra <flavra@baylibre.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Liran Alon <liran.alon@oracle.com>, Arbel Moshe <arbel.moshe@oracle.com>, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:02=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
>
> Move the enable_vmware_backdoor module parameter, the VMware backdoor
> port and pseudo-PMC definitions, and the VMware pseudo-PMC and opcode
> helpers out of x86.c, emulate.c and pmu.{c,h} into new vmware.{c,h}
> files, and add a MAINTAINERS entry for the new files.
>
> KVM's VMware emulation is spread across the emulator, the PMU code and
> x86.c, and both vendor modules read the module parameter directly.  The
> following patches make the VMware interfaces a per-VM setting, add a
> userspace exit for VMware hypercalls and allow compiling the emulation
> out.  Collect the code in one place first, as KVM already does for
> Hyper-V and Xen emulation, so that those changes stay local and the
> code movement can be reviewed on its own.
>
> No functional change intended.
>
> Link: https://lore.kernel.org/r/aIEgVpjXDR0BXgHq@google.com
> Link: https://lore.kernel.org/r/aIEwOToiAkKfQA-4@google.com
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
 Reviewed-by: Jim Mattson <jmattson@google.com>
