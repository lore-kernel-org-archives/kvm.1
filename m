Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4642535F614
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238318; cv=none; b=lCM2MT3I+l87qzs+9imF6uP0tSaF/Iw1hvrPywyxMIbYwGRk9gOCWy52KbCgqpqm5+CA6Tj4Ro6PGnZ9i6oo0TlRopdD6V5h1u3x+pyy7/j9RiBmyIQ8btTq4skNUCzlUllDg4pPOTu+n14gcqJ+o50ty09+sjw5mgYmYxqegBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238318; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ws/gmBb2vGX6W7y4UfAdIr1BFf424xG7Ma1IJ6PS4BfsImb/nRmbEIk5fgh49O1dD4bQFwaMr03IwWM78Ii0EnkujEI13Cc4HU+StUOFZXGCKDzKq3nUnQfVna784iUzJchHOJlKuBc/F4C5x++QzuzsNjyYcYmD3pKsKROwk1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66325f30570so981746a12.1
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 07:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238315; x=1773843115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=TK2oa5vHxEpGyd7T7SSRzLd6H1hDKU6LKkP7cycBolPnjjUUz10uplwlDYzmco4Txr
         vzPasahE3UjgdFn9dqLzvct09ZLjh4m3zUu0R+TqiRhG7cA6PG9/qd98lVc2MF1iZDh3
         j0yOelcQ4hHGR9hNEWqgNibrp9f3mIunZEqAQnaqvpDF892saQgYv6b7m74cgpOqKvYN
         pg6g8psDx37Zda5XzD34Hlhu57JNdExphi6yvxDPr+32tCIvvfzeHcTobEu/LM3mijI7
         8Ai+ZZviW0BWGJB2mMB1+7awjZGLbbMDL8rwm/7IZDCjA130dZbPsrd4WZUtawRY/NEP
         XMGw==
X-Forwarded-Encrypted: i=1; AJvYcCXb2z+qZkwnIMvIb8vGj6mBwjzV0SIRTIbAQgFChkKhS199L1evCkpDqnGD+1xTwwt2E7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz8t90zbio0Pv+lm81xKSCZc6pet46qOMv7faZK3HTcodFSHJZ
	Oi97QzTVC8QrHT0KZVqG+xbux4qCf1514cjBTOyN/DemBGtq/x8dDV4T9hDGiToK4a/LoA==
X-Gm-Gg: ATEYQzwWbmyweg/QY/zTkCKUnaMJ3LyrpMSziwkHMVXvutSKDUYLvWGOJTJFhfWFjXP
	iIJ95Hg7JRm+88T0nsalUrMyyDdeQW5qDAYpA4LTALn0lAqsMuUkGr2XjgOmba6os2dsIaCWIEV
	a35ZiYJMBvJLSFInbF/b22ecZ9DoRqtktwED7osf61T0z7z3R12t5ur2gF03anI0FzfH7pRWVCP
	9Pi+4hqS1Z/3uIG838L6PKCI6ml882xHEZrrQNejSoGeLsx3XSGbJJXu8hhAAMoQJVFECjPHMKf
	gdLYOeeG1Mqd7o3PIc7AtP0n6knZ+1mzkqzeS9i4n8jQ+Y25v5DLsQtvHhmRJhsMauWPLTUwJnJ
	eo3vcyJiyGSpa7Y4XiK/rr5Kk9JQohTy7UHfIJSQpUtlHr554fxusezfQiWX2x9YjysonIYV2Qk
	GNEpHpIEptrogdUP9YZ6Ocy2kRy66h5BsMtQD27Wwg6ohBibgIaJClk1FmFB8U
X-Received: by 2002:a05:6402:51d1:b0:65c:b71:e69e with SMTP id 4fb4d7f45d1cf-6631798dcb0mr1453478a12.8.1773238315478;
        Wed, 11 Mar 2026 07:11:55 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6631503c5b2sm584997a12.16.2026.03.11.07.11.55
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:11:55 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66174cf4549so2112213a12.0
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 07:11:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWc3E1plvATa7gXUiD/PhB3jCjq0sdiJRh/fw878Y0AFnI7WAWuQ6c4RZSg6bJsOR6O1Pg=@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
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
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
