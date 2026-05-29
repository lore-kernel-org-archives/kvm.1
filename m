Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A70F3F7869
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073720; cv=none; b=mrYM6mn1WkuWULK5Ia9tQ39A5JfvLbnMrFPuxI8bjt3qdub77fei/VnMr3W5sVjoZXwetv1llxrHxLNG37M3NwPI3U/Ty6jERNfmCHH5FV2IcSvMvsc/xEDKKG8Ff+yXeYa6/qBzgIhEKoG+YVw21W+y4osfA1rHb9f9e+QvfXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073720; c=relaxed/simple;
	bh=llW4OxFvtKWFyEC9eRxy9VUDdqj1IBqiGVZmNBrPlP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+zE4mnRGN4MUTceEVgv28WzPHEGanx+4n1dNumUngi6ytsXicK58+r3fFIUi6AvPCKslB/1aMPwOdkkYlwOqqgPFsdqZt+EIZfHvT19EYs3tdahcUQKgdxpj5f9GlSlUDSu0CZRH27SlIod4H2rQmdRUuf/D1Eyn1H3+N1tS+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiTUy1Op; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiTUy1Op"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-459bf19e87bso8572195f8f.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073718; x=1780678518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kg88DDtH/8BXfFFdiCpH0Ax+iqDzN9Cpw3OqPjVLSd0=;
        b=aiTUy1Op+lYKoApuLxe7JXrRYO2t/I3uULvMmUsOHz0HkpZGDgZ1iZf97sCp1yHLvu
         0cFlLa4hBdMNEMS4IppVax/VaoCcuiXYFrV6iUupCMRo/7pxUNM/J+AkB9L6yFWBIlvx
         4kJUlQ2ZaPeZXfAqqoyHLvTfRguwpAhCKAPNdV3UtuA8HC7FicRQQM5lUwxOop3dvql8
         loAh1Y6Sto5lfxtAQjA2G+L48fYNc6emeJoUO+JT8W2pvC7jgZA4AzH9qC14GWoU8kgq
         b2VFTb5VW3ECBBPZv2CpkIPqkoZ66dzgC+dQvzLlYbqnAl6H0GQv/2LAdQnXvp7M36bY
         Kepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073718; x=1780678518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kg88DDtH/8BXfFFdiCpH0Ax+iqDzN9Cpw3OqPjVLSd0=;
        b=cor2r7Sa6DrWoj1hZbEEAfLtemzhVxV2L2W+RxJ4DrFBg4fr81hDn6G6gc8q4o/AUk
         8JvP5d06IcoqrA3l/xktiOKIPbgjo9BxbGV4uYbus2qiwnkInJLOiZiAkYVHbE63UUXe
         S1UyoHYpTo6VkxAaNdhJVqTFyB7UEpm2bUMUo6Jm8Pz6C7LOOX577Bkvg9HOEwZygW7+
         +0rU/vOimHmi8cWy8tbcIoaZ16S/yZEU8XJn5Z2o38lBoubDdqzmY6wZDaId0QtBSnnp
         GRc1qop8Ti/6fBQ/JovxuFe00B8bDeKCWZ2jQw9IxBpwIsVsTY4PfLI0eQ1YPkWqv3y1
         mdrA==
X-Forwarded-Encrypted: i=1; AFNElJ+VlCPVfR7zSG1rAn27PUI2RJ6Upw5npfGlEl4D8nmAziOlz70Xa0hHKilNImhp0xFYk2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV6MaQrkEBo/7venrfWlStrjTRXuzjwf1ZMuk48TDtKiVK17Yq
	fd2tX06BXQ6+8zGbX92cgiKTKnPJUtQfOF26+iKTEiToy67RDBjpDxMf
X-Gm-Gg: Acq92OEr+mb9yksry3Qb/Q7X+yTA6vBJK+31082SI7OjSs/VSNEohT482W77d80fUjo
	aOqicfT+5WmH0BL/zh3GKgBbs/F8htGWIbHrx0dJJJMVdudO2ugXYgejI21xIqx45guD7AO+K9R
	RvE6FLzQ41qn5Ew2O2sxW1wUDOX5o+ML5yne+50nFz78cjp8ftCuM4/3o/MJBVUhkKo/0zMJ2RC
	KiZWtOG1lPEoYQNBSxFBaq2Sz6OOpeQ+u68FWXzwegQT6AU38VxZUTRdaQ0eX9irzmZ7DQtCl5Y
	3e9Xs8kmLc6IRPcGni+3RVOlkywHi2Hiv+wSChPUQVDhO0eAPFCUSBpd54LXnxVZEe9EwlmWAwJ
	XfVGzqfBNqOZ09BANyDCm/PyOmso8FGcMikYx+EXMWTAA3uLCZriqRTdE/CFTOHHID7sbiB8c3J
	L0/pViV5m21PjyFa3RoKTYN5K0X0N+HavWllxeexTTZ1EmT8Z0qgHaILCB9sz73hkXjsBqrJw=
X-Received: by 2002:a7b:c3c3:0:b0:490:5191:6e26 with SMTP id 5b1f17b1804b1-490a2941d7emr4738915e9.18.1780073717867;
        Fri, 29 May 2026 09:55:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6a0a89sm68444645e9.7.2026.05.29.09.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:55:17 -0700 (PDT)
Date: Fri, 29 May 2026 17:55:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
 kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org, Mark Bloch
 <mbloch@nvidia.com>, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 06/11] selftests: Fix arm64 IO barriers to match
 kernel
Message-ID: <20260529175516.06d5788f@pumpkin>
In-Reply-To: <20260529134947.GA128816@nvidia.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
	<6-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
	<ahiFxtmspbETiqWw@google.com>
	<20260529134947.GA128816@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 10:49:47 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, May 28, 2026 at 06:13:26PM +0000, David Matlack wrote:
> 
> > Let's put these in tools/arch/arm64/include/asm/io.h so that the tools
> > headers are more aligned with the kernel headers, and so that the arm64
> > io.h overrides are done in the same way as the x86 overrides in
> > tools/arch/x86/include/asm/io.h.
> > 
> > Something like this (untested):  
> 
> Okay, the disassembly says it works:
> 
>     1db8:       ca080108        eor     x8, x8, x8
>     1dbc:       b5000008        cbnz    x8, 1dbc <readl+0x58>
>     1dc0:       f9000fe8        str     x8, [sp, #24]

That looks strange, I suspect the C didn't match any usual pattern.
Normally 'tmp' would get thrown away and 'v' would get kept.
But you seem to have discarded 'v' and written 'tmp' to stack.

I'm probably being stupid again, but how does that work?
The cpu can speculate straight through the control dependency into
the following instructions.
An 'eor x1, x8, x8' may not even have a data-dependency on x8.
(Most x86 cpus just generate a zero for the equivalent instruction.)

-- David

> 
> Jason
> 

