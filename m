Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369976;
	b=bRiIy4y/zRoM/SwCCms6qOxSBRsY3+AN8DYaJbx/jLAlB7qquNn7EyqX3LMeMcAMwEVd
	 RXWyNlhElUrMG5o8U1s1lDkbNORwCv0TXqIW79epqN4DPDdyUbj+HdQ6C0HvHPfdJRX0K
	 nDKqEo9EUZpGt6hAS4gCufPiA+/UL5RPiYxa8gICt5bEOs8hzQeztRq2nE5Hwl5l3w3at
	 ianKBJlpoQVFVMPEbpzOjGuoYnp5PwtJqsJwq5fgeaD9J8PBXyU9MyQOhYBUXQNUq53Vl
	 yDv5w+htzSKsvAS3nlFAXz0+kXNiqqWga4cFpcfsadXqyeXxcYQh+RMa+JpqUaXSXiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=bA1fHQBlzW2f3EluTeJ2sASuPAQq8eJKTH0MCDp2mJI=;
	b=r3EXOEU6D2KsOsoCSFyCDcKOxKF39gHlFiN+XhJd25VhBg3kmoyi1Xd/C4DFUN03nKrB
	 tqXqxjRS4p0jndia94x/QthY2MWeprAUnvOZeWEof5erq0GtNPlPdduk+dAdOw4V+7qs1
	 xM1vKlQCdTzq4RXPV7/l0Crk1ebtd0En3NBmb7BXTdCp10R/BEWMiWvNT+zjBqOj3UAaI
	 S7lzRF+7vcdUSNwIzyDCO4ep7xFGTwhnn6o78JLjNVlN2S816r4l4OJNAlN9cGnPCcBOJ
	 v/3st3yXx/NtRKDb4U4PgBOjxuvfwHS+E8PBYRIbmUXhaGRkbAdcC4Vo26ahjxgBBrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Esi1kjmC;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C46606A31D
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45C46606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Esi1kjmC
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1925245eec.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793369974; x=1793974774; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bA1fHQBlzW2f3EluTeJ2sASuPAQq8eJKTH0MCDp2mJI=;
        b=Esi1kjmCu/mPRLNW6Cph+bFN0jarTDCCCrwoQ2TSZDwxIXb2wtL6LXW4OPt/ipy3t0
         /I2GAN+Bf3sPY0A2kspEkj/14Qc6h7BDjO4TvvKFPnXS80vbdfNlq0YcrffLZwXt3g8b
         toSERLnJ7zIqd9r8fNei1Jxy7U4LiXPRmfgqGFVd3C5wkH4Sugzvh4iPL+fS8qtcLsYl
         hIwWcdAvIXxVuSiQCNyvRGSseiNtUQNY1wQYB/vYC9cEEASCo5auPpCTsFsyrMVa8xlx
         R9YFYiIUne+OZP1PbyvBbJjt+sZhTT8L+9jwnBfTb01pm52RfnzoYV+vE4ZKepsLJ7ep
         Zszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369974; x=1793974774;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bA1fHQBlzW2f3EluTeJ2sASuPAQq8eJKTH0MCDp2mJI=;
        b=coUCci00UFYMX/WW1+vv6MfD2CfVCkmqzLSf3sQ3hdmG8rJ8ikC1kdrEi0BAfOuzD1
         SmVpwU70ibTeyqJXXPAqGiLnZGC39OthQ7XhgMWZsBSQxlhJUv1QXxZAnxk8l919hO5w
         OAVg75ltCr2Xhn/NpO0z2H7DLPe+Xm/7TZgBT/vlkjmXsc//LErjpVqnnM/TKKX/tdkD
         GygiE+NiS2Z6kraGVgq3cDaN+j/z0YQZ0P/KywF/WdsAZzFsjXC3wZZIfH903PRdVNz1
         xoqFcnEvVxQasmtQawZp23beveBT+9At9YuNYBNJRQZ4z4NGjHs+3d1EZjrmMk7gyDk9
         pjQQ==
X-Forwarded-Encrypted: i=1; AKwUvBw39hyKepLQhsZHuftUz9H0kmKMuXyvuQBGAxMsgKhqZIqAgMmqTSPvGmBKgoCK+0Pt5os=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjPQUYDgqXQfyqg6TWkn71oh3iD6vqzfHHi/puiLZUzVVlKGvD
	usrzjpgFcMtU7fGKgTHCXo0JFghVulkl0CxXPOBMypKyq10NQ2L2b3Dc
X-Gm-Gg: AYBFou0oP4ZYY8lHHm4jyloRSzXmfXp5XBIK1O1IRpAz5GCYm0/7vNEgVnYqaXYbhNd
	prffepTpMNCBNfg4uQxioIiEgaoYWS7Fa1cu/iRkNZ63DfLDShwVFW6pDjQM64BSSkNjHu8N9FJ
	FU+t4hwp+m8OWVWIGACo2nhpVJvJKSCHg9DJakTdWrXyfMg5XbofNu1JNs2riP7/m9vJgvV8qbq
	45sSuIYEcmJtxtvhxkxp1O1Q2KkFyczv8Xub4PKqRbJQvrYJLIvxmZN5LXqkttq9iDrNtBptciR
	8Qnze7vqYMqFM6jgFYZdggajChMIE+CL3Rd8eR1uv/XOcbVo+TGMZ+CwgPWsO/R+N0r2c27eioE
	sIw1f7WshKQyfyn99/vGxYE0mYqsKchI+bisjTMldXRjqlX5iTUUlR5cZfVj6TDPnWjwoCKdTw6
	ZpOuOCxX3S1TObLjw1vGVmKB1KsyOMQH5jL1gDYZcb5etgo3WbtsjGuW8tKuEnZor7w+GmeBADy
	+iOnTDtSfNqopRHOuHL8CB5vqHHBKDygoY4j3N/TMEzRWoa3NtHd5jKlNLypvjJLG0D1RGu/661
	MzGf39+qXlZrh+OE2kL2oshxIWc=
X-Received: by 2002:a05:7301:2511:b0:36a:1872:4b35 with SMTP id 5a478bee46e88-36a42203e6fmr3338125eec.2.1793369974284;
        Fri, 30 Oct 2026 07:19:34 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a426681aesm10406146eec.1.2026.10.30.07.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:19:30 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] KVM: PPC: Book3S: Protect TCE IOMMU table walks with RCU
In-Reply-To: <20261015120137.28843-1-nnmlinux@linux.ibm.com>
Date: Fri, 30 Oct 2026 19:32:20 +0530
Message-ID: <5wyjwakz.ritesh.list@gmail.com>
References: <20261015120137.28843-1-nnmlinux@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list


Hi Narayana,

Narayana Murty N <nnmlinux@linux.ibm.com> writes:

> Commit cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real mode
> handlers") moved the TCE hcalls from real mode to preemptible virtual
> mode.
>
> The stt->iommu_tables list is RCU managed. Entries are added with
> list_add_rcu(), removed with list_del_rcu(), and released after an RCU
> grace period with call_rcu().
>
> However, kvmppc_h_put_tce(), kvmppc_h_put_tce_indirect(), and
> kvmppc_h_stuff_tce() traverse iommu_tables using
> list_for_each_entry_lockless() without an RCU read-side critical
> section.
>
> A concurrent IOMMU table detach can therefore remove an entry while a
> TCE hcall is traversing or using it, without the traversal preventing
> the entry from being reclaimed.
>
> Use list_for_each_entry_rcu() under rcu_read_lock() for these walks so
> that an entry removed concurrently is not reclaimed until the reader
> has completed.
>
> Fixes: cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real mode handlers")

I am not sure if this is the right fix. On doing git blame, I see the
following patch introduced this:

121f80ba ("KVM: PPC: VFIO: Add in-kernel acceleration for VFIO") - Alexey Kardashevskiy


> Cc: stable@vger.kernel.org
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)


Sashiko pointed out few more bugs around this path:

Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
- [High] kvm: ppc: UAF of spapr_tce_table due to missing rcu_read_lock()
- [High] kvmppc_clear_tce: pinned memory leak on partial IOMMU map failure

So, even though these looks to be pre-existing bugs - do you think we
can address them in a single patch series itself? This will reduce your
testing/validation as well?
Also since we are anyway fixing RCU specific bugs in patch-1, so I think
we can also fix rcu handling for stt as well?

Do you mind working on v2 and addressing Sashiko review comments please?

-ritesh


