Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793920342;
	b=kTBi+KR7z6bhFTia9IUkciA6cpHBdb4N+hDooLgbBPBs5z9bmX7P2mDzeck7Y1RNwwXP
	 6YzeJvLD+sclY5SC9aSlLVJl4cjxfFtbeTho3TLdsZSRmnh9WjLgL5rWtNG95JO4iWuWT
	 PS3ZSAauQ5tI7o71IEGWudNaTJvslVIO4yMEnhdSXqyAjjWprTR/orSRGkZeYreUiCl75
	 ZIf7riGWhSci1hGB3dT2EXwxV3RDlwCjz+KI07EWnHRGeAa42IHqT7cKWjl3JworkQLLY
	 uXBlIuU+gOJGY1INmmiw+8/kAchenwY6W8Sbn8xDiToazvtaGmN9lkifgWva1zhcUfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
	b=SWezY2fQkkHa2GuWSHePZ1NnapKyHWrY314alwLfpFPKxssgogiDH3CS4pfCkB1NSHpx
	 8OYU3D+nCcH/OtN4Ko9qy87Nj3wpeUGOFnOwxn3fQprOr1ZE81IOCxi+HZtnB0LOJtJg4
	 tk8253YpMNgoauGNi0WaX0uXdlnCiAM/56jwyJa/Ux8WLMvaAlHenht4wfv9DLD8uesa/
	 BfHBcyEqU9O1FWzp/wo/LRAZSqhfa4ClxE8ULsAcZkgS8t/aaEpmyJLtTbqDFuOj/WoNB
	 EM24V+o89MhSOp1omhTPc3bNMVRFzSRgTwPpOZBo1hOIjk1OavyXR0S/DQgHMBjerQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ePSbskAw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171B606A32C
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0171B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ePSbskAw
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso37365a91.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:12:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920341; cv=none;
        d=google.com; s=arc-20260327;
        b=Odyf5Biqh64B5+zqAQ72iPJYrzOKxO90tJqnqeYoUv6E6h3b4swVqYGVeLpn2Qdibt
         fdbp3LYfpRIRrBBC0c/lUST+x1Anly+N5Zai3pADiOSrzGQXz4BQSkmhKEzNPylNNlzF
         Pbcy86FLRLtob2+YZUDRY6skDY91DpmHTVT+5D9B/XwyA7MFD8s/ooWhrbg0gl9DKYq8
         +te9YIJZIBRv1qeyhbCJFbqnBX5npfSIrOapUM5N8uzChookoeKkw6zZYUY4iMX/9Gak
         bNTcd6K0qpMowUbcQRGIaeARaNGlWAX5l3aJeCbstjM/f3WaSfyNmn9rfervbK+Yd0In
         Uepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        fh=9iRP6CT6u5bjwjv0zjL+TZlzV3Tr2xNZwV/w/g+pZZ8=;
        b=QWealAgHJOxzwvNDZfDMkxXUY39Slk7CXfOPnb3IbNh+6SmQTQpzt1DOadPG36lddj
         qEJ+Dsi3EYm+P7KLof2nlVUkabkYQ0K/aBOd6SQ+v11szVXNf3jaECa72RGDZzb+mu8p
         0NLJT4KnqujJ9IYUPe3kQBa2EhA8ITnUSxCBparpoWlDnDiO07K/IYnK5U0dlFg79Neg
         zhopfF6dp1+HAkD15BI57Yxt0cH2vlIEZ4+T81vpoAPm6fwO4cJSLUO3H9w+iD3uIzsh
         /zbIYQhBHCrYEc0OTCFLCuofTuA0IM2yxVM8CAyBo/VyXpo1QJpqNEoLjrpmPcn2o5II
         w+FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920341; x=1794525141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=ePSbskAwea0d9B6NpBdXuFYsWvLDCToKGcxFrN9C/fQLJKxAOsbctr8qBrrZUslJXJ
         9CLcMCSIkKD7ZW5JSZB/FlpnXL7wVvbFlxAaV35NsJbH9Ct+Vj1AE0PSCxPZMXuxmspf
         S8DzKorUUKYgddL+oYJfDiSPHAXfQ8DdRb1gIJCpXWqjafW5TeuSLk2tBK8Xu5u2Toof
         wmqoUSerZIxxVmbDxgyvtDxt3hKRgQ27SfmnssLj7BFyrZUgbmKG7qeTDPokQzsw8F3e
         sMOi8Cm8Fp7SxcfGGOrWu3vbz980QOeeJXGWbY7zrPoyxcb1MpuMc94aw2AmHxsi0GQi
         jm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920341; x=1794525141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=F6Tv99BxKwgrFynnCnmvCnlPjETkEExmXDUaralEPQHE7MSNRG2ihVqGHIc/foYU1n
         40YYL3baxsbicSWXTNfYxQoy5W1kqpgOf9H9QoDVKYiaMIJOzUp04zaWRCyy8mHc8y9C
         KLIuZGNXPKVaMNw8Epw1lWw/jh9Ucb6vtR8nJKrs+AxxzN0/I77NITu6NEgNX2Sfgj67
         gmXrCC46CSKJQuIgsP6lNwE2MtDRHXVSpIZSPqglII7eGYZJ4CYAu+tt18wBFngc5PQb
         IMJTVvCDmJ1Vu1OPhzgUF0nY2gXk2lrPFTLJERtvMY/RGjZ+AWrXPzL/AOo4zw0TO+CE
         NxfQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfVyH0hYMSoZcadtLIUPnarWggPBX+a9CqX9WFLrN19sF2NKQjdpdfftiqY7w6YBOwm6s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VfZaJdcbCWFaDwQO9sewq40pm2rXZSm+E5BFJ3BMsd3R+hZ/P
	sFb+ryMSGDL4GicGYyNgz+mIExAooridlBXzUk/nsgllWwkFShIu6pP/BFSBYUX+k1QXxfdwEAI
	5iZFRi1fPsCxK7o7NcGdRDEk8X5s+kkG0wiEI6vOk
X-Gm-Gg: AYBFou1HPXW549VtJ6vxh7127baLVZXEcA39xTcemuEm6PBj5/jU+jQR65jvvUDqJIK
	5Nnt17An/GVwbLISpWJicHBS/TGXGvs3sJZBBNGKlZjWMW3rNI7GyoDJj4ONAy7EGBN5VdxvZih
	u/2qM69fkzZ428yWppE9qYh9QIy83W7Kzxshx8WxgEy24WpGFWDjxz1kCZhwDvgKt9pFWkLj2o/
	5H69CuAUffAzF1YELFGRE+vW2VHl2Mu6obStdqgQgD6qtxXWw7oSVfeLCXwnHsLY49xG+yu0m/R
	wKTQYVYp7aISuGBZW3v+D8mp1SfKhKGjtN8rbBrM9crZ53ua4EtPgfagYp2Q0OeKkHTPM5ocJQe
	R7OK8/uziar+efqrnLDmSTXwhi7M6FrLTkvMMNzhlNVKfyIl2g/3iCNLeIpIlFEZ1BBuB
X-Received: by 2002:a17:90a:d88f:b0:3ac:b867:81df with SMTP id
 98e67ed59e1d1-3b0db6fbe69mr555739a91.39.1793920341210; Thu, 05 Nov 2026
 15:12:21 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:12:09 -0500
X-Gm-Features: AclHuK9SAmQ1s59IzUj_GoyUW49QmobrDei9zDR78OY4d10Tcv8mWs8d-l1JUg8
Message-ID: <CAHC9VhQvpFeEJaEyPDaqj8_S752puSaNe0Rn-hxjh=ugCoFsxA@mail.gmail.com>
Subject: Re: [PATCH 00/14] mm: convert further simple mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:06=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Continue the conversion of users of the deprecated f_op->mmap callback to
> f_op->mmap_prepare. Keep things gentle this cycle by targeting simple
> cases.
>
> No functional change intended.
>
> Build tested on x86-64 (allmodconfig, each patch individually), i386,
> arm64 and ppc64le.
>
> <<>>
>
> David, Andrew - I wonder whether one of you guys could take this series
> through your tree? Since it's kernel-wide it seems sensible to take it
> through an mm tree.

Granted I've only properly looked at the SELinux patch (7/14), the
rest I've just skimmed through, but these are all independent patches,
right?  Is there any reason why individual subsystem maintainers
shouldn't just pick up their associated patch?  Yes, perhaps chasing
down individual maintainers is a bit more work, but isn't that the way
this should work?

> Lorenzo Stoakes (ARM) (14):
>       xen/privcmd: convert mmap hook to mmap_prepare
>       KVM: PPC: Book3S: convert spapr TCE mmap hook to mmap_prepare
>       mshv_vtl: convert mmap hooks to mmap_prepare
>       vduse: convert IOVA domain mmap hook to mmap_prepare
>       x86/sgx: convert vepc mmap hook to mmap_prepare
>       udf: convert mmap hook to mmap_prepare
>       selinuxfs: convert mmap hooks to mmap_prepare
>       xen: convert xenstore interface mmap hooks to mmap_prepare
>       soc: aspeed: convert LPC and P2A control mmap hooks to mmap_prepare
>       soc: qcom: rmtfs_mem: convert mmap hook to mmap_prepare
>       tee: convert shm mmap hook to mmap_prepare
>       misc: bcm-vk: convert mmap hook to mmap_prepare
>       ptp: vmclock: convert mmap hook to mmap_prepare
>       vhost-vdpa: convert mmap hook to mmap_prepare
>
>  arch/powerpc/kvm/book3s_64_vio.c        |  6 +++---
>  arch/x86/kernel/cpu/sgx/virt.c          | 15 ++++++++-------
>  drivers/hv/mshv_vtl_main.c              | 14 +++++++-------
>  drivers/misc/bcm-vk/bcm_vk_dev.c        | 20 ++++++++++----------
>  drivers/ptp/ptp_vmclock.c               | 19 +++++++++----------
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c    | 20 +++++++++-----------
>  drivers/soc/aspeed/aspeed-p2a-ctrl.c    | 22 ++++++++--------------
>  drivers/soc/qcom/rmtfs_mem.c            | 22 ++++++++++------------
>  drivers/tee/tee_shm.c                   | 14 +++++++-------
>  drivers/vdpa/vdpa_user/iova_domain.c    | 12 ++++++------
>  drivers/vhost/vdpa.c                    | 23 ++++++++++++-----------
>  drivers/xen/privcmd.c                   | 11 +++++------
>  drivers/xen/xenbus/xenbus_dev_backend.c | 14 ++++++--------
>  drivers/xen/xenfs/xenstored.c           | 14 ++++++--------
>  fs/udf/file.c                           |  8 ++++----
>  security/selinux/selinuxfs.c            | 24 +++++++++++-------------
>  16 files changed, 121 insertions(+), 137 deletions(-)

--=20
paul-moore.com
