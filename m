Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556442;
	b=icf1Y3wtVxEVWcs+DEigPGvPBfK8tMkE/K4/rcgsNaCTMslnapdUHswq0D/mkcrttOwz
	 ka+EqGpw4igKRdJ4LNn/XflpswiuxLotMp+++sZKrQeYYdsQidTWZ24gyt/xijeCqZ0WT
	 w4WsWqi6/gVAiMuzLeg6rCZ7xzmCkzHYBVq1C8NBIYEHAtwEm7W/0ncS4lTJPfBt4rjXj
	 UdcdYIEzbqOhjOqQySQCac0n5k9+JQgLs8xkIMgxLcFiIMjSLVuLZmtzk16LcHqvPbl+R
	 7Wnc78Jf19IKKz/ftISaw9Zw1kknXPt/jWNukBh9wdy05BK+pxRMpcxY0Hui6nxXYUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556442;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=phiuX5Zb8P8aFyzSkr8Lt0LpTmJabsik6/9jkby6ebg=;
	b=Z9filozunvAS3KHy29HHT8hh0cSlZgmKgmdt79QVkmcfhDGR/QHlPlMnh/PpPKmG+hcH
	 xqVY0roadpD/xkdVg872lO+xbCWRLW/so0oa2DRPiv7LwwE0/QaRBrToQxGYg3SitvBh5
	 Op5YH6KIsIWc8eVolockKriA3FzDQc8wcdhTrUFOntvmRc1aqeHBRqdudGNNC6UQowJAw
	 AjCL5VouZgD0uLFA5/AYaprVXrUY5OpfTOqWQocBqQufQZSJUaZcO8wDEKUsbA8wthto1
	 flLVKdCdGkswKUivEGJklfOp7lSth4DCj3eDii7te/ekzOe0MW92crQst1RSCWV8WFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlD3i1n3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B9606A691
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlD3i1n3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006FF1F00A3D
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 21:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795556442;
	bh=phiuX5Zb8P8aFyzSkr8Lt0LpTmJabsik6/9jkby6ebg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WlD3i1n3u4fTNxFSHE93F9suawNf/wd5zgjxW0Bhg7bnCAtmXf1/0RcbiOnW3O/nh
	 O50cHHfMkhjVDzkAfNi5ehY5ymP61FNWnYuKt6FanCmRn2ycsN4qziHKllbYD4h0ph
	 EME8GjIQFVS37hsn9cqUN6lAIh6pSlcu/JFi5fPxs3VkhNqzZfKCp/ToLXf686MxIy
	 KVJ8pNdnadVOIMraG4ZT+UwgMbAuIBVxGBOCbddANId/GIwx94jAsNcR8YTmDeskjA
	 49bYOjbrS/zfkQ6oNWixORhJIarXUHLKPr5kjgnLRUbSktrfiVkHGxalMgf2TyuPhh
	 TlBCDZ/SI98oA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5c14f3dab66so4527058e87.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 13:40:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEYvHvUpIlCUO3RMcywJrR3vlNYPI9B3UT1MkxK8GimtVBgJERSCXSyHaW7k99Z080KRwI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/d8jXbdrFF3eaJA4wChh4pfE4sKPvTlLd0rpXFzSFNurt7bbIa
	Wm4AfbxLAyNIMdq68g4V24NMo5pXWGlqDoHIwxgyR0WL9pz8kojyZEJr4X9jEu2fTeSUZrkbbd1
	R5PY6MRWtve+XtYQQxxYfmyJ5bBN4vEU=
X-Received: by 2002:a05:6512:32c8:b0:5c1:46f8:913c with SMTP id
 2adb3069b0e04-5c1b7c00f96mr4380577e87.20.1795556440465; Tue, 24 Nov 2026
 13:40:40 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015142552.4128028-1-ryan.roberts@arm.com> <20261015142552.4128028-10-ryan.roberts@arm.com>
In-Reply-To: <20261015142552.4128028-10-ryan.roberts@arm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 24 Nov 2026 22:40:28 +0100
X-Gmail-Original-Message-ID: <CAD++jLmnVpGm9pG_g777yz6XvbyAgTBCM5moYy=gAeenhjQSEg@mail.gmail.com>
X-Gm-Features: Aa3M54pcwQV3xdAu47_dI0b9w902bsdzijUBVbDcdwg2QkzqqV6jsuD637lp5XA
Message-ID: <CAD++jLmnVpGm9pG_g777yz6XvbyAgTBCM5moYy=gAeenhjQSEg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/15] misc/arm-cla: Add userspace interface
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jean-Philippe Brucker <jpb@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan, Jean-Philippe,

On Thu, Oct 15, 2026 at 4:27=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:

> Expose CLA devices through a character device so userspace can enumerate
> the available hardware and map accelerator register frames.
>
> Provide ioctl interface to report device topology, CPU affinity, domain
> membership, mmap offsets, architecture version and attached accelerator
> masks, together with the IIDR, DEVARCH and REVIDR of each accelerator.
>
> CLA registers can only be read from the CPU local to the device, while
> enumeration may occur on any CPU. Validate the supported CLA
> architecture version during device setup and cache the CLA and
> accelerator identification registers for later ioctl queries.
>
> Support shared read-write mmap of one or more CLA register pages. Create
> a context for every domain covered by the mapping and resolve faults
> only while that context owns the domain. Queue unassigned contexts with
> the domain scheduler, drop mmap_lock while waiting for assignment and
> retry the fault after the context is woken.
>
> Co-developed-by: Jean-Philippe Brucker <jpb@kernel.org>
> Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

This uapi is very simplistic and IIUC only provides a mmap:ed view of the
accelerator memory area, without any details on how it is actually used.

Since we don't know much about the usage it is hard to say whether this
is a good approach compared to using e.g. an arm64-specific syscall.
Whether to choose one or the other depends much on the error
modus of this thing, how a CPU or a context should recover etc.

> +       /*
> +        * Cache some standard accelerator registers that user space may =
query
> +        * via ioctl from a remote CPU.
> +        */

If you're caching these registers for efficiency, a vDSO syscall could
be more efficient as it could return the cached information without
a roundtrip to kernelspace. OK kludgy, I know, but efficient.

> +#define cla_for_each_mapped_domain(_vma, _domain)                      \
> +       for (unsigned long __pg =3D (_vma)->vm_pgoff;                    =
 \
> +            __pg < (_vma)->vm_pgoff + vma_pages(_vma) &&               \
> +            ((_domain) =3D cla_lut_pg[dev_nospec(__pg)]->domain);       =
 \
> +            __pg =3D (_domain)->pg_offset + (_domain)->nr_devs)

I like this macro. Very helpful.

> +static long cla_ioctl_validate_param(struct file *file,
> +                                    struct arm_cla_param *param)
(...)
> +static long cla_ioctl_get_param(struct file *file, unsigned long arg)

Looks good.

> +static int cla_file_open(struct inode *inode, struct file *file)
> +{
> +       unsigned int index =3D iminor(inode) - MINOR(cla_devt);
> +
> +       if (index >=3D cla_nr_classes)
> +               return -ENODEV;
> +
> +       file->private_data =3D cla_accel_classes[index];
> +
> +       return 0;
> +}

As you mention that this absolutely will not work unless the process
(task) is tied to the current CPU, this should be verified and enforced.

Obviously the task is running on the CPU it is running on when it
gets here. What we need to ascertain is that it absolutely cannot migrate.

Essentially it needs to execute as a userspace version of a
CPU-local workqueue or other CPU-bound kernel daemon
that uses kthread_bind().

You *can* of course pin a process/task to a CPU with
sched_setaffinity() in userspace and at a minimum this
chardev should not be allowed to be opened unless the
process has already done this and the affinity is set to the
current CPU and the current CPU only.

You want this to be enforced, but userspace does not provide
a way to irrevocably bind a task to a certain CPU. Interestingly
the kernel does, PF_NO_SETAFFINITY which is used in
kthread.c. The only thing (I think) that can affect a task with
PF_NO_SETAFFINITY is CPU hotplug.

So I suggest that you might want to pursue some syscall
extention to sched_setaffinity() such that PF_NO_SETAFFINITY
is set on the process inside the kernel after creation, and then
cla_file_open() should verify that the affinity is set to the
current CPU only, and that PF_NO_SETAFFINITY is set.

(You could of course hack-set the flag here in open() but I
don't think that would be appreciated.)

Yours,
Linus Walleij
