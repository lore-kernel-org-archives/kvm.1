Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE22D8391
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235312; cv=none; b=r1Y8xsZg1nWOzHJpGhAkP5/P34qTQKpEP8yg49LtK7LOJ4QFmv/ttJo6b6KC4NhPW4UsZLAbTYH2IWYgn62lVduTXaH5n+MT8Ms9AV5U2bSPqhBOB33gv3VursXixBRhpMmtLjB8CTXrbbCgFe+0pNuIG9XG5K7INgXttE/cgyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235312; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M++/f0fokHelIs/jI1wO76KjVbLWEEaK4mmRNg8nXEG01nFBDujeHddZ0oQTGk3f0TRoWdlEUgOINORn9PkpukVo2Ve/7PyFWamNcWNyglQ9iEAqqd5U8qAeZNpTWF9h23fznlSV8/ZmZQVwEejIGi3lfTMQCL6JTkvkAWcQzxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56739adfa1aso10528853e0c.0
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 06:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235310; x=1773840110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=Ig9DW/6gIRnuc+boTe8wjJ2bIA4qRdPHnlb88XWds2FR7OSCDNb4vxosI8925wHBf8
         p7/+Y3FSX4Q7/K4ijEHJfn5K+d2KhBKIsKjF9mE/DNEIbXeRu4Hg/XXJ+6HnSk11v2Ty
         DTB7aIa70KJp8nWZVg6qEANnXKy7nYvaQFlKzJaOT7a+eMZ2KEtfJB3O6LbC3ekYaqZD
         mjUI1Zcta2CVOTStI4xD1HEA0fERDzaRK/I6Db6LcfIng1XkRtQx/JiDpeuMn+S5kIr7
         SMAdYZkWwTJAcYY04kmAno88kz0A8u88a0BahvHm5zZN+nFf2SArSQiide+DOEJPlt+Y
         +fYg==
X-Forwarded-Encrypted: i=1; AJvYcCWT3lprvE1qw7ohwVwdTwCbxA8U6qFb8qX+Rq942gmrDN65wJDwBXZBqicgHClWORvfbfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6HKtvsCs6HmODRVt8d4d4yP5rF+7a18aPx/tVKiAfLX1i8OGy
	XDIqXuppw8HuDzb9hjfPIArOyeKJWo9CVVcAsDLk+Se8Ck/Wg5+SH4Uzz+IwfbRQ75Y=
X-Gm-Gg: ATEYQzyLCFpOMTlrLFlm4ScZ7JuA8hNdSW9JtxvUC75BTFFfeLIDb7mO7Uz3RYYsm7j
	sw8QO5oMR6FlpK4jYxboJBN1x4OLOhsMoDGQxPc0mZRIJktUZD0NiteBCgVi1D1fH5iR1uwchP7
	uuAwr6CwVqrS7cVRIoKiYaCntZhcBvlWJcMGrQ1cJo9FtUyI4OPlQl+92k4hL1NWfV871COc9Bk
	2UM7i1ZuI0ui7terf3z6Exf+FA377fQAMt1Zjs9bXeLd7gzPmOgdqlxbRPq8oj8bnpwGOC7JA9b
	VcsZE60ytT7pQE9Ehl0hE5ZTQyfuC3LEbyS9aEVZ52J+IhpKoF1BmfhYVe5IKNUim+xcqzp9Re7
	ere7MbfVzwIDy9n0ngBLUAZh1s1whGfWVw0J7qb0oLcoyB9lV8b4uAXARLhAP11X5+Jdo/pTxqW
	K1w9CUOyq0sGJPktQcjmxYUYd1PZoSrSZOewG4KqVOryKq8IvaznxzLNxp5iFtjOY+
X-Received: by 2002:a05:6122:f09:b0:55a:ab0d:bf74 with SMTP id 71dfb90a1353d-56b4754c994mr950406e0c.13.1773235310164;
        Wed, 11 Mar 2026 06:21:50 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b464b3291sm911156e0c.18.2026.03.11.06.21.49
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:21:50 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56b18f05f49so2422948e0c.1
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 06:21:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEIuyriFtAbnoXNeto+KDu47BzBve12xHbe4IY4T8EjLd9SKz0ziQyYJP8e7to8XcYhj8=@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
