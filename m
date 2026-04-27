Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D22F7478
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325980; cv=none; b=OwU9uo6Q9lhhgPSnfyWDEpDqXSZFXV62zyNsp9gVAv2HbtS/bQbM5h4oZhAl1uJkx/xn3cpscMCzAE0Ug+xUZmQ3W0rBePGYYAk1+RWtX+lepPsBoP0DG3fEm3J/xGJMFGx+u3IywCI+C400picQL5Vt6egCJMs1OrJNViY/rXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325980; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDwC/x22qrWdaes+hfeAhyE5WwduuXCz0FctB7K3kKq5WTyorAHcnWEea1Mg6+xJ3pGsND6NRmxckNygwzf12QjLHtBeJror/eY7MC0rvSfcZDXuhTesfvSAskVqOpEuxhxhN7di/bbjW2LS9l4+4ma0xTfikr2YMRGKURIX3Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YikOQpWJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YikOQpWJ"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b886fc047d5so1920278166b.3
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 14:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777325977; x=1777930777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=YikOQpWJdmOW+SS9CVxF3IPBnJwQ1mV9i4FjFSwhEn3FpvoLQLvicbjtgLB3tb9MSe
         dAluK9Kdd6kbQbLOun6/evQqYwPoVPDc9OLP1gQ5IwLM3ShJTzviqyWp4bCDgN8TOx2x
         VPVLDyBtEWe57vcTlEuoGNXgfHNBaenUI5chM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325977; x=1777930777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=l23BChx8QA5sOKYn/j0ZUo+IQEBWasvsVfWaKyOcm/1pcaByYilszdlBkxjzrQFDKe
         8vuXpdPisrHJGP7EH/UX68jQXvQD8YoErTk3loOA5QBH6WPP0qOt6hfzanfSOgNe6A+P
         OuUClc+K5BvCR1DNcxs63HHVu0DcqSkmMSfD0SgJE1H5dhqp1u9NRMcN12NQKoCQU3ZY
         FeXkc9I5z8fH6kA3l3WexxZNoISzTysZuu2J7+5KyW8eKuwzdhAW8d7bDj0EdtmEukGg
         A0jN1nF5qqM3rZEcUH04DWz5iZirGS6lrfiArj5ee2wUIZ7ONRUYa9M7LA8+IUCNKqYA
         u1Rg==
X-Forwarded-Encrypted: i=1; AFNElJ9Q5ectAz66iZaEhgu4c8RZkjKBaFgHHhkMu2Z2BXpE2R02sXFvGodRAMz2B+d7L70S7VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6jdmiCUGK3k5G+wz8pVGReOkIN8fVEjJRAg/Q2hurkiM8qvDU
	Rk8nMW3AI/sjqnFClTb4PuB1s5VGazG1r+feE5KV9dJmZUF5Spk0pElHRraBsWibNUMqsRE+yhm
	5Wydg554aTQ==
X-Gm-Gg: AeBDieuMJzWDGPHug3NRev8R8TqfXkpGDoiOopqqSQUxemOEJWVmFB1TDRzUKY8QLh1
	Aqoa6i0Xv3bRVIZM4ROJhaVRwG5K17N4L4c/DSICVP6lqvXqJekyhtwSpROVJlo7xQspJgbwDtH
	5PFmXTYdymnZUAQIEhpVpOqsJ4IHdoqv67mYsUySRVTJVi3F9jpl165xw6gwhVfXj4R9D6yT2XT
	D6lsqxRNgGqoGJ/A6cP5aVbuRFDzSFXWS9TIpQYloF9NEIfp8InHwuC9RqBdBb5+LPLQiXZKZRq
	ZjEqOh7o7vV9hRPfKsaFQnym1x6wMUINWAj1rzQPtFMcB3EQa9+z0FGJ9H7eGgvuk0OXcAyQ99E
	iovZYaui1pyW280ChR5NkYNNB2330Lz4XRjoP7MYWLT3h9vZalZZfEGnUA8uQoIz73ZHur/jmKe
	8KgA8uZInYbYsMoluh/0zglahgpgxHPNpiYgTAlRrL990glqEfucKAUtdhgl7gHTZYWwkYqJR5Q
	Izwxk/Qk2I=
X-Received: by 2002:a17:907:d204:b0:b9e:8e4:8765 with SMTP id a640c23a62f3a-bb8020ca22emr30767966b.10.1777325977236;
        Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80bd91f49sm9132466b.51.2026.04.27.14.39.37
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so5624854a12.3
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/ZqWnzng3wg8nBVBM2rlzh9VCuCVBSl7GCNJh350tckCDxdCwBieOGjY1Zz9P5h8SK1yM=@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus
