Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793400299;
	b=cjo6MjWwFsZYhjnTaETqIWhUtGWro0drb01harLfMrq2hLOyOLomysLlucBGQSv8bRPi
	 uQWxycYHNUnHK7EdKt7FyARpRSWymF4vyGoGccTx9QSX00/URgg5GjgCAL7I6T/ab5CfB
	 Ase9ufH9trkKPcESIOLpWiUlS4UtE8OBKMXCni7BsIQRhLMsKKFEmbbommYKiGxaDKP2g
	 mgd1VLbLydHNnJ9zwHrGfXZv9nNIS/31/pbXEy+ZcaSb+k0qQ1AFEUARmT6+o/4RkGPrb
	 KGfF7dnzc6cCv/yH8H/iUlD/jN2wHAnHdQw67jGDwDkodp3Yf+6MPsS1GkMLCGBMKOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=NYbItPhQApEJbZKga/APWqgHEBqrEwP9FLrG/rlKxD8=;
	b=nsOBVT/cVVD4Htu0CVgpo1KFCeqcINHGato0Nw4NfHA/06rtZol2WBxi1KdUt8zJ5L8q
	 kQBD/nkiVW/7Qqhm5iXTT0E0JnNCIJu+sKkFJBfMKb508kv4mr2sVeH2p+tcjzKkVMHm2
	 4HSX2lzmFt3ko3NBleCUSm90T+zmYdAruGIYkjWuk5cp9/BxbYSWzvlmbTpVhDhdIvXXT
	 ALAi683eEmSn3WPiUOyIHX6kM6SkDNd3FapWEF+vCtHPcoK4wgCGVl060wLB6f/NOy2Hd
	 YZcuxUj3ZQ0WWSO5FsKQouK9R8Q47pkfWrkFP0B93V+BzuwhtZxqlO9gVPp08BWP8Qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lPsZxM2n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270D606A31D
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 22:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D270D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lPsZxM2n
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f079a63b8so122148585a.3
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 15:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793400298; cv=none;
        d=google.com; s=arc-20260327;
        b=S9Bpq5sk7j3kp9H8naBFPYgjnYMUMBQEhmzODCaD0W+wZWhojcZluNiQfs4OWB5QIr
         HKegVpzRyu7+UYaOF0M4QsIp14k0o14Dch9r/o+bIx/ZvUVf3cBCuC2ZHcnCwpOND020
         cAfh5BeXn7Tk06Tppg8MRrm4Z+vkZBblRdsiNeJ0KVMKCn0RJxVy2x2PaJ5fHBf0HCwO
         iwmE+nr23vJFVPO8RuRhVRWrxtmKom2/KY2YkakAL3Cxrj+sdVHXUF+l9SNFqkrs3MJI
         f9IX42xQ8MGuTELHABPWnP3KGCR8zjRn5PvPf04E9W02Jr5b9p1256NC2avJbhrvnCy/
         28Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=NYbItPhQApEJbZKga/APWqgHEBqrEwP9FLrG/rlKxD8=;
        fh=fsDmYe955utqMqND7/NtMJFaLMshqdaoqhBA0HdFph0=;
        b=ZW3PaRJ/FNmqlgiMBCUh9Cy9bpN6FHr6wSCV4G/5Iy+n39Bdx2nWwzwdBSC7mXJ98R
         ViKvFFt1f+1dwDXXNSbA6E7Fp+7+Gp+qZc7+cBypUZmsF2P3vrR/t2gM5chkQEUxqvLP
         0XzM6nmUxsCpO36dly848S38uiahJ1Ugv4OnySLwGKXI7i8Gd/ndwv2r4ING90LGapQB
         BZYuMb6HUqydvMP9VHfOYyJL/Puhu6eKKmm7FHju++m2VJelD+q0BYijp34h3L2DQSOU
         x0vpd+tP52szN2peZgHgdGntcrX7h9W2mI2zds43unz27arVLPNatjqUQ/VLNkxQD1Zv
         5AUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793400298; x=1794005098; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NYbItPhQApEJbZKga/APWqgHEBqrEwP9FLrG/rlKxD8=;
        b=lPsZxM2nkyo5ziRdiR2R7fmILZH9rJlYsc/IrC+J9zkhOXmXVt/15nupdI9iYKKavx
         0zVrQVjyM74z+rkK5ohmwWz/Ie6j5V7LlPyOGxu2lxlUF2WcEM0bBJlcrRT5t44rDSai
         m/BLKbyqFMTxJMt+VCtkpOjTbvfzzbU4KJHQJnqRq6gzZ0PpSqHnn+txSCHvOaymTQDk
         Qr8x/vWsSa6UkA+aWIrPhMY01OnW2V3+KIJfJpoWzV6lkx8zoDL4ugXTiTwoBYhEWH28
         rJ8It6BCA/YbvOHI8NZR8lfj7dldfE8hL3tb2C5Y7D36/HLayT97eu2Ycctdg7X0IxJg
         hvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793400298; x=1794005098;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NYbItPhQApEJbZKga/APWqgHEBqrEwP9FLrG/rlKxD8=;
        b=bgx8/RbOeQQ2u6BBbbIpkfQWKcJR2ai6RN6y5NUVM6cd4qoIQLFI6La6Wvj/uqWWi4
         VJcHTA6hoAMuv7qST/8TKKIOK9J5kO80/rawofWq0+iIni4Xrzdff+WcfkeCmy325lWI
         GSHPqua/NSX6sgaDq9RUh9im74LxLOtR9/NVK2JZDIqulAXalqdcX7QqSrhZCA1Xq1ut
         qVHcyPk2gIEeGAhz06/cRcqum2dj+Hhqd2kEZFSHtNkLmj1X6l/4+2rvfhD4zFjO5alM
         Z8FZp72/zyYMIxtSjuuG0Wj6nQHoAOa0KNVmWFAvas7H5uIQ8CN9Xdb2EjJeSBWEy7/M
         Dfmg==
X-Forwarded-Encrypted: i=1; AKwUvBwKUm6571iYnZfe+hV07iKUUk3MRtWB5kfmI0nZKnw8ZXLtIEhXOa5x/mE4IPlZAq+HsS8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLimeqQdEllZKe0MLG84/0u0YcqdRhR1yidtd5uLrFtEn/FgUIv
	o2PMYboNMLUiY+KDnlGyCVKgnNxPTBDUtTzrm0J6jd0HTBesOkeP4X8zAzyQkuVSgi9cj6lwgCQ
	lrq9wFYUtz2FflGgffblOHCaLofcbVSR+ROiCEdPY
X-Gm-Gg: AYBFou0ttEqvMBLyZ0WprVPWqxV2K4i/SPbg5MNUNLJKq7hM5whM1b3oVg72qAZwFeg
	sBDymO2m8KKRO3yZ8S0Nn4jxrBM1WW/cVyB40TKTRqjc01vK4GQxkPNMof2GFN3EG41h7EcM1rf
	dlWSgIYbsXQAsthM6o/sWeUiwMa/dbFXE/lgE3nemWG2LBppKSA7uX7pbzw/Dt8X9YKea4NBnmg
	FncI54Sy6dbP0C7XCql7QO1DlLbcQtD+YCqRS0HEDC5xTKit5iXBjrTYmuhvUddX0NRtjlBzYXJ
	r5lN5zowry7l9WEtff+9Nv5i7mX1F+8IlOVFjd1KbuNIQeXEgMtRK+XpaWiEkwppH/lFCZgaNvN
	nxH4dsoyXf0ljkPVarQueLCbHdwi5gNUGQvDbSLFsLkhP//EZza2QoQflurmidF3AuFK3+eMAHB
	K2LzWYb/0HXCbeG74j3WnYImo=
X-Received: by 2002:a05:620a:4594:b0:93e:c12c:4409 with SMTP id
 af79cd13be357-944217cece5mr652996085a.69.1793400297298; Fri, 30 Oct 2026
 15:44:57 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 15:44:56 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgFEKqVZcNYCL0LpB6BTyBFe+ot1x1nFfEqOrSTsu134PQ@mail.gmail.com>
References: <20261017073149.1303738-1-aneesh.kumar@kernel.org>
 <20261017073149.1303738-3-aneesh.kumar@kernel.org> <CAEvNRgEh3E7NBc5_3Wq66Fss-mAYT6+4FWP5+=Co6+OVfVnQQQ@mail.gmail.com>
 <CAEvNRgFEKqVZcNYCL0LpB6BTyBFe+ot1x1nFfEqOrSTsu134PQ@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 15:44:56 -0700
X-Gm-Features: AclHuK9AHtuqcVSSdHgG8WAhHla8voZ5Eh8lYfAwHP3Alygt10O_4piQhjU1tlA
Message-ID: <CAEvNRgH5TH8MDaRQaVczv4m6fJZKVmf=MtKzhmHs_px8+r=8bA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] KVM: guest_memfd: Support private/shared
 conversion of device memory
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev
Cc: Alex Williamson <alex@shazbot.org>, David Woodhouse <dwmw2@infradead.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Steven Price <steven.price@arm.com>, Fred Griffoul <griffoul@gmail.com>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

>
> [...snip...]
>
>>
>> Is there a way to avoid making private from within the conversion flow?
>>
>> kvm_gmem_device_map() below already does it as part of vcpu_run.
>>
>> If we do the above, we'd be aligned with regular conversions, where
>> to-shared conversions eagerly update arch state (make_shared) but
>> to-private notifications to the firmware are done lazily.
>>
>
> I was a bit confused above. IIUC to handle
> RMI_EXIT_VDEV_VALIDATE_MAPPING, the conversion is not done from outside
> the kernel, instead it is done in the vcpu_run completion hook.
>
> Can we make the flow that userspace is required to do the conversion
> request from userspace after an exit due to
> RMI_EXIT_VDEV_VALIDATE_MAPPING, and then just do the delegate + map +
> validate in the vcpu_run completion hook?
>
>
> The rest are a little outside the guest_memfd field, but I'll make the
> suggestion anyway.
>
> It looks like delegate and map don't need the vcpu context, only
> validate does, so validate has to be done in the vcpu_run completion
> hook.
>
> Delegate needs the host physical addresses, so we'd need to translate
> the IPAs to PAs, could that be a VM ioctl? It could look up the memslots
> and translate IPA to PA?
>
> RMI_RTT_DEV_MAP also doesn't need the vcpu context, IIUC it does need
> the VM context so it could be a VM ioctl too? If it looks up the
> memslot, it'll also find the guest_memfd, where it can find the device
> information.
>
> I'm just thinking that the vcpu_run completion context is doing too
> much, and there are so many possible errors that could be better
> communicated to userspace if they're separate ioctls.
>
> Or perhaps at least delegate + map could be one required ioctl call by
> userspace before doing vcpu_run to continue after a
> RMI_EXIT_VDEV_VALIDATE_MAPPING exit.
>

The delegate+map actually seems really similar to the
KVM_ARM_RMI_POPULATE ioctl. KVM_ARM_RMI_POPULATE already calls into gmem
using kvm_gmem_populate(), which can do delegate+map, can that be
reused/extended as part of RMI_EXIT_VDEV_VALIDATE_MAPPING handling?

>>>
>>> [...snip...]
>>>
