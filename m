Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2953B7742
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357362; cv=none; b=NbySYkAElC2zuQXzxkOK+688lYjW55SWMs69j4lWOICPAK4epV73tGMxP7p9/9/JswWyWyuA5o5s6rfMqWojzoe2f2RyjUEQX+ZyDQnekchcbwaFziobrIoMAYMtOllgBZ5CAnM1SHTRzEoZwjdag17Lnt1pJlD5wczEBwgml2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357362; c=relaxed/simple;
	bh=FJRzbufEtBJAhLCkPlm5BxuuEKScVokDrohw9V0wWgI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw1/0nFMZwjLuOcUcSePvq52vDusWfBGduNX/52cdJN9Dlm97LywccfbhNMA3hObMTkJi6ug6yrivH4CrTAKbuM85cVCWD+tS7Di/dzAlj7a3OGZNwu3IBVaBBEayOZHCdaXZidRCuSNfnWGEEjYeM/3G5q0cB1Sg6UIygENwys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3cPWLjI; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3cPWLjI"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c7fd21b63so11411721fa.0
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786357359; x=1786962159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pYeuabCvSp2X+27QeVgnHc3kyISwurDqCe0A6joolwY=;
        b=j3cPWLjIBF5EubjaIeE5g7F2urbcTjnikWqnZfDp5l/0T5eoG2tYNeRctXcFomsgZs
         MeUEDx8DWSodxR+t98XUwXYNTx7qjWb4MsWEmLpCLSOAuKmkgYmJz8JLto/2lb6n7amn
         nkDGG4hZlsmRfJ4mA7btaPjIkI5o2vIWJJo3w4wP8+Jh5k/xGpgLwU0F89wJu5Ahv5dB
         Hf35earGUIDbd45Ksg+XVp6/Tf+uSP3tu6RDuUYD4PTEKZd8Iu+BEOabHFsA/+dzF4sH
         UymgeWQxNklnYHEK+RopZm/1/6ojLHSOCYkBI5UO+Pvg4tqe7T0bt4+xDH8FAeU1LNvG
         E2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786357359; x=1786962159;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pYeuabCvSp2X+27QeVgnHc3kyISwurDqCe0A6joolwY=;
        b=FOROAvY18oALXjewKeuss7MzzSul/xA2w8xp2eMH4OACQAPQ383LUys7kQajmFpXD6
         yT88M0TqdqrUJyUemudvGXIKUw0lLX3nEN4IiInL2mRUpUK9BukG10ZCCOfcixIYotbk
         jHINTyelPDUG8ED4n1JpnbYtbxfi/Dex+kAAyduwriy7SBtU5zF1+w8/BBsIdWkvRzbL
         4aBen6k4diYUQ41lwMgEtIfsOlwUJf3fK6mGHN4LQhgvGm2rTiR11LpFpcEhjGa53Elw
         PR8V1+2ePVjoZldM60DCzxnreZUCQ47UMWazG8+1/hOITqIy8psrj4rKYM9SAmvFfmlf
         Cs/Q==
X-Forwarded-Encrypted: i=1; AHgh+RoWP2kp4saGwO7Yj+WFjmBsCWYyinemWMZFY7Ahv6JsCDLeHltaVqUwJiXu7TE/yySVapc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0AplII9R26AcLEvLYgTk5jBHn1iSv5AvFA4y8kZi/Es/I7tTF
	VX3FAVjUsgYTqcEvKGOXXPmO4QNEm91gG0C9GRENhCyniBqMUi82qtut
X-Gm-Gg: AR+sD12IcJlDIrZ0RBZy+QO8t1t+F3IWndCy8J5+7IFav6GdYdtiEFwV+kqW5ct+xt5
	3lkdh8+4V7fD7u7uCjcqHTPNNx17AmCS+rK9ths7OSp/rR9WbEa9ZIyTZq4oLsY9am9UaeuucdF
	Kj6uT2jOL2UcuVQEapB5j2qKraXFW7A0jZ2jLGe3D4hr/l2MYum9Tnw02FSOFIP5y3IBz0M/R1N
	KZqn0QLuvGLJfxeLPbHeYYHQcWxRV8dGZ28SWOtO4fdeFlUhLdKv4s5VRNXuCGJhnfZjUURyGn/
	D/ZOmH+iptqsTbBpWLEj9ADQjXgEzIYdpvlFiEmvW7EUQZ0T41NR58q8htA6Dca1e+52KL4Lbd3
	fKu2J010elX8XOn88Ni8pGOnkb5S08mCMvwq5vj9c70XVjVSf5PL/lqUE/23G3kntFPMRhpnSJn
	Abr7M/6MU5qAR27drLHjqihSWUnQ==
X-Received: by 2002:a05:651c:1586:b0:39e:ea4f:4202 with SMTP id 38308e7fff4ca-39fbb262b33mr47691471fa.31.1786357358435;
        Mon, 10 Aug 2026 03:22:38 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39fddd67ec0sm22873191fa.30.2026.08.10.03.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 03:22:38 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 10 Aug 2026 12:22:36 +0200
To: David Woodhouse <dwmw2@infradead.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Boqun Feng <boqun@kernel.org>, kvm@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
Message-ID: <anmmbDqk5rfi_Gsx@milan>
References: <0d483855-4d2f-4502-858c-c88077aa0b94@paulmck-laptop>
 <d0fdf8aa4faa4e349cdc0e051b6e211cddd566b0.camel@infradead.org>
 <anibnhTYdwdn51FF@milan>
 <54244653-0825-4F1C-8852-003762176FE3@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54244653-0825-4F1C-8852-003762176FE3@infradead.org>

On Sun, Aug 09, 2026 at 06:44:55PM +0100, David Woodhouse wrote:
> On 9 August 2026 16:24:14 BST, Uladzislau Rezki <urezki@gmail.com> wrote:
> >On Sun, Aug 09, 2026 at 10:59:59AM +0100, David Woodhouse wrote:
> >> +	/*
> >> +	 * Try a non-blocking allocation first, leaving the spare untouched
> >> +	 * in the common no-pressure case so that it is still there when
> >> +	 * there really is pressure.
> >> +	 */
> >> +	node = kzalloc_objs(*node, rcu_num_nodes, GFP_NOWAIT | __GFP_NOWARN);
> >>
> >GFP_NOWAIT already contains __GFP_NOWARN. It is odd.
> 
> Ack, thanks. Will fix in my tree.
> 
> >> +	if (node)
> >> +		return node;
> >> +
> >> +	node = xchg(&srcu_spare_nodes, NULL);
> >> +	if (node) {
> >> +		schedule_work(&srcu_spare_replenish_work);
> >>
> >I am not sure but if there is a need in doing progress forward, probably
> >separate wq with WQ_MEM_RECLAIM | WQ_UNBOUND flags is better. It has an
> >extra rescue kthread to do the progress if no memory or high mem-pressure.
> 
> I don't think there is a *need* per se,  as all that happens is a few more less efficient grace periods before the allocation finally succeeds. And frankly, if memory pressure is that bad the efficiency of the grace periods is probably the least of your worries.

Probably. I was thinking about something like(example taken from driver.c):

<snip>
synchronize_srcu(&encl->srcu);
mmu_notifier_unregister(&encl_mm->mmu_notifier, encl_mm->mm);
kfree(encl_mm);
<snip>

i.e. when we need to free memory. We want a faster reclaim especially
when low memory conditions. From the other hand it looks like we do not
call quite often init_srcu_struct_nodes() from srcu_gp_end(), so no
strong opinion here.

--
Uladzislau Rezki
