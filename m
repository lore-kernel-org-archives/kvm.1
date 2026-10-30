Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368631;
	b=ZOcAYdHHX//MB+GTvCYFqn8UDsxi7Az8lHHl6zyfFtp79g/ActMsJ5mOpmVIdY+V/6nI
	 YB5/lQeWC7YChewHaupcXdkwY4s8zgHkO6FxhcNrr1/ifo6M3AjWFvdnCgbQqGzRsIg+K
	 UnhMf/D5qgl8f9DGscEf+0vGV94lJzqUSqeO9RwYIznr3pZF4dfcLMQZwTUaa/MltmBzi
	 ErsbqP6sL4OqSSvdnaTy9WX0nuEqt+DeOE24vWdJpOeSZEd31xNwSdSWRahAcb83S/BDN
	 rbxPa/znEzP5YDuiKi9NZitj8LaQdH9zDkNm0HCQPzdVc4BbtwHKUYbmg+06o98dnCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=GNIOi3l2fXouiVMkzU5S0Fr0utCMy6QmwVq2E0otj7I=;
	b=HWtV2wsFjBkhgFNY1PtYzEFlWTpBp8SfroYV5MiKA3zb3Rp2GADqLiEboQB3+zJQb7yd
	 liPlytAyRZ7pQTadQFXuPZ3KdxdgLCVU2t/HNABdYs754LJGetIY4xxEl5waSHMcbRYJ+
	 2jU/HFbcmpTFVuBqw0f/loM82u1CNLNdrbzt07tirvgpGoToWBvRXxgrbYiILC4H8yF0j
	 bjun6Oast8NxFuLJtun3JqkLihXpMOd2SshoB/nEo5csDS0nM3my2cuwAGFwvtE9J3JGC
	 61HIqL6scGNPldKq1nlQTlPYvXrdkQb24SMDSuOouyRR2m3FjDpQKDdBGgbffpWnX/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ouxQTXuG;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F0606A31D
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 13:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 748F0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ouxQTXuG
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e946155442so6442605ad.3
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 06:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793368631; x=1793973431; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GNIOi3l2fXouiVMkzU5S0Fr0utCMy6QmwVq2E0otj7I=;
        b=ouxQTXuGY0sUIyzArMYPWSLzsXzGVK8/GwzTMGcquJB53F0z+mtYa0vwvFzX0mKKJs
         i9ovdt2l6t/blE1Ru8wzBGANzZ9/sLcVu0/ows9x2wlcFiq57bgyp+WTw6E6AJX2EBZi
         YCzj2GjuC2xsnthiGOJO7aWt3jhVWeHUuQx2Kou2E77dkaam0d1Qse/rrRr/gk8ua1yW
         5gPjLDAhsCaT7BEhY/MT8ntk1Xlr8z4Kirg0mu9p5A9qICrUq1oyAS5N3o27acU3s1v0
         tsrN1vzsNR+PMGud1ia+XH3+rfzbwzkJdTgI3oOVOubg8Mizsn7qYpFgAEdU0F7VsvJR
         74ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368631; x=1793973431;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNIOi3l2fXouiVMkzU5S0Fr0utCMy6QmwVq2E0otj7I=;
        b=J3FRN2RFaC+PetwMKlAPRar1MY6uePGbkgM+JB0ooKiA9fsDUwv3wyWxAfTFaL9LE2
         WEXoVSWF+zuxl35+BY/6t8KRi/06WdIuBBeWyz3W5nAdkJmWqHe8+FHfw0ebNJfeJIUN
         WFu79I+7lUSj4NLxrd2zSkRAkC6Om+xZM1RU1STxx91v8h125Fq6IXQOv2DMnTDW06KP
         GZNWnvfrQw8F9kSqHAzLCFvWQxsKEEAdN8vT5JxbQYIdOL6RM6DjfTRdaWoXbu6imajN
         wb2xmXb10S/ZeMP7bdt/3t4N0VU9M3gWILAGO1AANI5Lwx4CjN1fEFWYyIYR/aba+bzh
         0Bow==
X-Forwarded-Encrypted: i=1; AKwUvBzuCEzvtDhMAW5nbTxtXZLji/Y8CUNYiH/mRvatUaJc/zIk2UOaCFbpt4FkWGQmRAHq+lY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvKUIpjY+8/3Qcs7G+lqkKla3xL/RRGNXYmHbOT2T7LpMdUvHv
	IiBgSRS9E6hSvpM9n7cexcdGd/Ku0Z1KQGfosoHyIR4mWi4PC0qYhLkEWxNoNA==
X-Gm-Gg: AYBFou1fOcxhekGrOkC1B+Yj4XYmWzkwwCvYTnSuxni/3IfkqRJCZmwI40VL9uPG+sW
	G6fBjeqE+n6Ml3v77DP5jGyXyATUpBUwOacg410gWByXtTvhNqEpM2sOFOgURgQ3VwKMsNxsCs7
	7I7lggNlH2hNGpcgo/fxMjae+9KNAva1wN7MTPZs/aLzx9mPDF8hJYusKMbmxxZxSA/5/kNjpWJ
	bJqTZ8b1lbOwlV5tDrunme5Zi1rwZGixB5SoglJbJH0W1trRb5mNxSqI4xCk9xDaA8yuovAjITX
	wkMMnXmseiCdnv1Xk7MRjKBjfjptm1rSHHp0EvPCdZ17yeUuPprZj4qhyodUIfZ/KYrYWJe2H+n
	1XDBpEs8pXI/ZqZEMCKG5XIsXtEYp2rpJeOLvBGkeeWvGbTmOkt8NQUiSTrO3XwUmqfo5ArLGJa
	BQ40RHryugGozS548T/nIrA8h1CMGGLPkv9thYS6gImlwJavpGYA1aIOmq4Y2tTdIMji+OV6oCY
	SweCOsF2MwPByocatRGbclGoydOAAsPj8QIG3Wl2HMUFmmave4oc0hKKOwkbQgQzzvNElrp7x7Q
	BsSqlHBFrxuZJwHeVFvyhKDR+NY=
X-Received: by 2002:a17:902:c94d:b0:2e9:6645:e9a6 with SMTP id d9443c01a7336-2eb365363f7mr26307325ad.59.1793368630732;
        Fri, 30 Oct 2026 06:57:10 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3924c858sm7688305ad.35.2026.10.30.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:57:10 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/4] KVM: PPC: Book3S HV: XICS: Avoid NULL ptr deref in kvmppc_xive_cleanup_vcpu()
In-Reply-To: <20261012082922.218799-4-gautam@linux.ibm.com>
Date: Fri, 30 Oct 2026 19:26:01 +0530
Message-ID: <8q3fwavi.ritesh.list@gmail.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com> <20261012082922.218799-4-gautam@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Gautam Menghani <gautam@linux.ibm.com> writes:

> In kvmppc_xive_connect_vcpu() if there is a failure before
> xc->vp_ipi_data is setup, it can result in a NULL pointer dereference in
> kvmppc_xive_cleanup_vcpu() when accessing the MMIO page in
> xive_vm_esb_load(). Fix this by adding a check before masking
> the VP IPI before accessing the MMIO pages.
>
> Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
> Cc: stable@vger.kernel.org # 4.12+
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v3:
> 1. Add some more info to the patch description.
>
> v2:
> 1. New patch - Introduced to fix the scenario where NULL ptr deref is
> possible. (Sashiko)
>

Make sense. However, the order of patch-2 and patch-3 should be
reversed. Otherwise LGTM.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
