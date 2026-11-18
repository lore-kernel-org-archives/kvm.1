Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000062;
	b=IvpdE2io8vHeeSCLVHAClv+a9FZLdPZoN9f4bObqJURl4cizQPM0U39nXcAA6+rad5VP
	 QYNesdHIvgWWJO/An6u+aUWYYeG2qiivdMemF+jcD/4OBpmPiTp5QxxIaL0ZMdwLqT1bo
	 1N8HPPi+G93VmyTTrn8Pf8ywvgDMVZ2aJsja2iFUEVL43PS/QVqC2Oj/QxV3/nSn52muG
	 pe6834toymtzhHE0vm5fCLagLsflb76hVn2jUbfXO4C0t5EaKnxKrS7LYNU2Bs2vSy3EX
	 FNk43nzoCd9LUfNPzrpe73bgqwtgaM59hpuWXwVdfHT1W2KPqnQ7siXwRxpnM7FMAiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=2Pa6D5jNmLHkxjKk3dgAW9SP7lKs94RaoWLtgWbGlqU=;
	b=JHk1htnUW2g1kmiGbx/G6/RNimZZtEN8EXEhOTNhoTCfRaF4VDblIy2YdPq7t83Zu9kv
	 mBjjseWWUHNM2v7uUgXPqi/B+ENEwORFxQpbMI8f49GrTfkNfDXgz/UqONtvCxJa1g1Od
	 wCauOE3wkOibZL0z7Y+IwN4glIMBJN5oxyh2SexC00kZqlhle69z79IZ/51EzVSRfwdK1
	 deoiGwpG5Kdr/ZVp+IbzT/kW/fmThnrLeIr70us3KYXHNviP2qfPBbDvV+HuG/WVJM9zs
	 3W68bLaxv9bnUXpzXp1WoMkTlpFmqkbu2PTuqqxPdkE4UJvuRni2XHShpCfkdpI0oqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ihbZp0kn;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC19606A31C
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 11:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BC19606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ihbZp0kn
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15dd124bbe7so223409c88.1
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 03:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795000061; x=1795604861; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2Pa6D5jNmLHkxjKk3dgAW9SP7lKs94RaoWLtgWbGlqU=;
        b=ihbZp0kn1hi/160Ef8aO8WEjkDW0xfx4dHHZBrSC4ft9WJOgGZYLrGjCwz5RsI3Zmc
         bCaOMNKUslPvT9UeZlH1WA1VrLyPszR4474lABqlrJzNg+gIBnnxkn8vAgOviQfMttla
         CIvVKjT5377ww28/due7WbJdWyURLc1f+fLqYzrPU8HH1AYc7F4ppjAGsJnKRwWME/TQ
         xsoM38tnsmRerMqHYCAeHDhk+vhfq82bDWDVUkhpCrT9UOXbYiYqIiHSlN57uYelFsII
         JSMCVFpWzxh2CdxI0mheIVN40Lv9C4phl/PiWUgUSu6lTsmnllSCTDI6ptwp6IS0TE+U
         DshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795000061; x=1795604861;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Pa6D5jNmLHkxjKk3dgAW9SP7lKs94RaoWLtgWbGlqU=;
        b=MdgNERCHrjotZ4eZO3KloWVXZTEKy9mQeyjIN2z8IQlLyCYG8TtOGksGthAvPgvMse
         Vhdj//wps2OSautmbIy9NiL2W86iHO8m3R81gG0VbE9vdtYenHE/yIxi77YHVyivFaQb
         w6RvHPdQTwR6emk07Bc0N3u1qBoZvJshXlnfvGWWt0ejZhQvGVBQIYk9nWLLPyh08d9U
         qSXsPEm/tEZQmLx9NgWLGPYDA7tN8iyYcFqVZl0KUhXTh6VzheiRktxwVZ9AI9RJFljp
         PEZzaVXQjIOr4MvD59lX1dzh8pVnzTmtKNHexnyUoWFBsEE+Y6hmQzGBUkIT0UzW0Vu6
         J4NA==
X-Forwarded-Encrypted: i=1; AL+hErHPsJKoyLubyr9S534s7tI98G9heKATYw76FZT7xAG/7U3zkoi2kYKOpqGAVMOXSat8pTk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Y2beqcyAedrthe1lT3+klyWizb8uxD/56MIAlvEsc43rQlqck
	5b9vphAOCuI4R8vg/++N7O0PegTroSQX90gvYbYNKnCsrYrvDPISgmWb
X-Gm-Gg: AYBFou3xKcv9QH7FdWmX6fxJjQ5WmTieHDDJZZUutmp7nn/cCFVBBIXUqZG3r0qs21t
	UujHvNuECFYsylT31km1XmEvZt0Amn2/8KjPc5FXurSWWbaFAAEUkPDyXipfIUNywm3dlmsoMtU
	4gzjhObiJGNB8gNW2Xxctx0ujUw5IElkXF0SnhAvscU5Gt9Ak5B+arxSiZMrOFn7XzSdKfYJNzx
	vpbus1sLX7umabCmtfzLNvMnNUj41wY0JMXA13ItOt+6AZaRH51dBFfFZcEuGfjpU1SwHc3+DOy
	e8zZ5DHtro8BBgLY7DHrUHEx0hLIi/xXLe0KKfw5I4u0IagygmQbQXcxHUZ6EELxJh5o+h0G7jK
	igm95wRBM7wQbfjAlEEXZDVUZSzoL/Y9jprjybsDwKuHQUtp9XiaKDGGCMU6obuD41FSo2XFjYe
	ADSQzOq+J2I7TEFSvHEnElT354TclTLUO9lBxp52rEwd8LU/DKU6SDejkBIkBLS7a9t+leriepV
	zI/G2QM3a4X5xnGVnkUgVJ7St9RnVmk3UgbivtByR21WKumxChSB9UpnKcyWWdjDLcprQDnnjic
	mOVhgRdtIedzk0hBJN047cHZ3+Q=
X-Received: by 2002:a05:7022:ea8a:b0:1b5:1a5a:1dc with SMTP id a92af1059eb24-1b543be9b64mr2272814c88.12.1795000060528;
        Wed, 18 Nov 2026 03:07:40 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447c1193sm5805783c88.7.2026.11.18.03.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:07:39 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, jniethe5@gmail.com, gautam@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Haoxiang Li <haoxiang_li2024@163.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Free nestedv2 state on vCPU creation failure
In-Reply-To: <20261118101008.2242596-1-haoxiang_li2024@163.com>
Date: Wed, 18 Nov 2026 16:33:48 +0530
Message-ID: <o6bm765n.ritesh.list@gmail.com>
References: <20261118101008.2242596-1-haoxiang_li2024@163.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Haoxiang Li <haoxiang_li2024@163.com> writes:

> When nestedv2 is enabled, kvmppc_core_vcpu_create_hv() allocates guest
> state buffers and messages through kvmhv_nestedv2_vcpu_create(). If
> the subsequent vcore lookup or allocation fails, it returns without
> releasing those resources.
>
> The caller's error path only calls kvmppc_subarch_vcpu_uninit(), which
> does not free the nestedv2 state. Call kvmhv_nestedv2_vcpu_free() before
> returning from the vcore error path when nestedv2 is enabled.
>
> Fixes: 19d31c5f1157 ("KVM: PPC: Add support for nestedv2 guests")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

The fix for this is already posted here [1]

[1]: https://lore.kernel.org/linuxppc-dev/082c338c69773a73a48cd4e0d0885ee0f6ef5326.1793546707.git.ritesh.list@gmail.com/

