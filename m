Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794262813;
	b=A9a+Z+STNlilQL+U/VHtl8q8DdD2fA0HW+1E3SZPalAg9PCk8Oapi5r7/4tmUMeqiuLa
	 3wS1twZy9c6WrD2rSrUx/L1/bK0t/eVQvfIWxT0BQjjeb5f9tEq/FCscJ1x79aLw4ncmR
	 jeKi3FzrRhI23GWZPL+tGFkRB/A1dP5GsKhPc9U/aywfl/ystoIawLq1xm7lnEoJ6trjV
	 B7y461rfifbjyOwynchiF21k/HwxJ3CVX0mCC5zF0fJHmgS5m7lB35zRPHaAPCeow1wCm
	 SVdc+zQu0RiUKPHWRwQugBRBL8FRONYirsPHno+dc39gwO+ybN7zPmOac6YmJbWcHJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=KfoXHxmDBEItkaa6hcxF0A8t0fZTG3DLVeoM83AlVUQ=;
	b=g/rA+9ScFASvOzXmt9+UocN4mXDPauzQPNzQN7FMo1UzPnxmQbUBwv7dJN+VQ0mgpH42
	 VtqxkQKxL86GRA4tGgnRDzYxCw9XHO2v801nYiEmGMPmOHY6GP3nmAJD29rpZDnidGqYi
	 x34lpvpZqeNU47ZBi6gaVJJX8DfRk2tLqv2tOop3xIvdGqSmFT50Qz9X4FEYDF3MNRL6b
	 2I6e9Q0w7MY+LW9GnShCeQBlJUnobwpz4h0+4WE3un0dFClK+Zd1uo7trTYLC7Xi7B2wN
	 +Gj4XJJluOnXQq8ea25O947sfZM1J4TQ++8JXcqsPgo9CSq8zRFR17zRuoIgrC8Pwiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LRB+gJ8P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282C606A334
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3282C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LRB+gJ8P
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso18095426d6.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794262812; cv=none;
        d=google.com; s=arc-20260327;
        b=rXycY9Kr/dGQfv6PzN8m3rQ8h4r3pdUnTbgIpQuwiimPC3BvdM/hEX1So51l5RHPQL
         VvyLEJh8pXp8O2oFLJNOBUkvjWssgMQaviCznm/+7zUJBnsFY+TUD/V5sIQ2sTVG7Lnj
         Jx7swh+C5+2z6Ux0Djl8cZQM8Vqayl+k1usvEPvkaMt11dvFZIVxCXZjy5FlUmgsJBV3
         frHm8ANBYBj8EFhoIm6ZJTor46zDReLxixLnuUNIRqm5eWKJuphqKye1BcKWQOLKadsB
         XCpudwzfM7dTvg9YRfHOKtjhZHaYlrB7nQhtwAQyLDPTMlUnIy3LTNDDU9ewIywJ4XP2
         1a/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=KfoXHxmDBEItkaa6hcxF0A8t0fZTG3DLVeoM83AlVUQ=;
        fh=5XTSPwVFRD7fmLHjjZS4E81vgUwqm5DJgJpa956Yv34=;
        b=Hp1qJUbf0Oj2gmrOeu3d0JCNxKyxrzK/VxG5f5Oxv39ZyJDz3eAyfFty1KuGt6UIhL
         VoFol7CeEzTnp863SEhRzurijBQpQETvIALAxGQ47glMJcGYcwyAlw5J0l0Lvf5Dk2Bk
         BIdS7ZCzpqgQBwRw9L8rmQb3Es9aWaW8H4kiIy1qcKSR1mKsbIGFc5gqPTzD6M52mn8C
         1qy+9s7DoC0fedKUPXx04bnnLE9eFfkuCm8FJfBbcvROk7xJto05GS302e1x2c1Ar1lW
         RhKo6BsGohFKWLrNMDND71x9vP6AQgKgVzUmcXYTwkZs2OgfxGWh21a+sP4IU/h+sRdM
         670w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794262812; x=1794867612; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KfoXHxmDBEItkaa6hcxF0A8t0fZTG3DLVeoM83AlVUQ=;
        b=LRB+gJ8PiH7bfRLCXOWS+hylx9TC5bFeUiQ/BxrEDGsxFh7k5kZb1WpZMjKJM/gmg+
         X35VIFZxkMY64fN4Kd7DS8HkG5CEv9T8Y0eXm2xLXyl9EDR/t+DhgJRCBHOx/LcmRu2J
         a58RLb2+kc2+09T7M94RtmZjGvmO+li3yKOqmRh2nX+SLdnH+jaKrf/zWzBMh4H6GmGG
         NXAv8D+1prwzYKpOZ767m2zZoQXuqHPCB9ZfNniwqr0arKqSDO7uPhoGUBjrfodzU4ub
         kj3vIF73rYOr3rOoO6tobjlWLK5ihzQ7waQEuEwQ2SGI2MUT2unRv9AKO1I6OpmqvDNj
         g3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794262812; x=1794867612;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KfoXHxmDBEItkaa6hcxF0A8t0fZTG3DLVeoM83AlVUQ=;
        b=uDWCoRJEh44r7qz+K3lJ3VS3dSipZFe61CmAvW4rAKljuB5/MRJZ5h+KTO7cZSzf3P
         h+dI0r00i2Zl3SNSs/+iiJsg5nwByx6hIvcOp2BFysGsC9TSv9odHLjmibGcUAl9czPz
         t3A7bMdtrI5gOicQ9IwNGs3EEoiMgvZujUzK2MXFxe2/0zq7emBuUBcu/uW1Sd658AC8
         KN0tLxoPRxRFZjyZhhP2FL8KXyWBjUoTH4tIsFWH8Vx+azZu7gI8XmfgUxL1NMcKf2fE
         gPHZDVTUWzAQN+3esylK4mpHLzpLXGG6blj70euv5ytk5ISd3PxZEds9L6ocq1NA40+K
         ncCg==
X-Forwarded-Encrypted: i=1; AL+hErHFGs7lj6BtBIn3KGRwKgz3KyJCOsBcjbKe+0HWJdlroHC21a+M7LNwsZF+GBezGtwMML0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hFrIxBneea6xziNoxhBiR4QdDIlFXrLyTkrEjjCgMbCAj3/cZ
	j1VHoC0GKqtiVpYyhInPTrrLPtO5aBjGW8B5dNVwp9b0KihzU5PviVqssiuRHwooarYuRvmbOma
	hCQGchJf5CMsvm1zS72DobgBF7NIb/MerB4BAHZSJ
X-Gm-Gg: AYBFou1cmCv3gkicfcQRVSEV5GC05QwlNrjkalxqLm5wvp5Ac1zFNE/jRznn4ZHW49k
	UxJNIoNWNmV2ENWKCYv0Ijk9CzQlAjvg9ESnBzzVVCT6Rah4fUsVjBvfO5wfXuHstyIfSl1wxtj
	yuI7/A5kHZqcgU010yoTlntjqLF2JFWgfcMXOubOkYtjPNXOz1sBi0BgRLzhmFB4OhYbotBMLw5
	O38VY+QW1vV2ULRyjGYLapPvrkdulOtNzmavSeTkxHZw6Xl8541R6a4fGDTYsCxPQSE9zX5ldw8
	bWbDMrUWAZbZhhGg9yINN686H9bk/pir0KKUr9p2xelJTt7KOMz6+aiEKutPmzzzQ5gx/jtjha3
	q6cYolTYH7bIqkJxd8TC35eU/GVnPMsnyFFAv6tMmQiXjdbjCsDrxWu6JsY/CyC24Vp3HedsTVi
	8rJTWdQaAtocq7Qm5HJ30ZpMI=
X-Received: by 2002:a05:6214:519a:b0:91e:a3a7:eabe with SMTP id
 6a1803df08f44-91eef7ed59dmr16998506d6.31.1794262811011; Mon, 09 Nov 2026
 14:20:11 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 14:20:09 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <yq5apkwettbg.fsf@kernel.org>
References: <20261104150322.3516320-1-aneesh.kumar@kernel.org>
 <20261104150322.3516320-7-aneesh.kumar@kernel.org> <20261104183754.10457-1-griffoul@gmail.com>
 <yq5apkwettbg.fsf@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 14:20:09 -0800
X-Gm-Features: AclHuK9yaZZX5RqlQUphUJAHyVgMZuWE0tyCGC8w_purOOnnuK3ITj8aYHc0AWs
Message-ID: <CAEvNRgFE5=u8Q+fCUxLT7M_gAjkgNddSVrM3axuTUxBScffcbQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 06/25] KVM: guest_memfd: Support device-backed PFN providers
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Fred Griffoul <griffoul@gmail.com>, 
	linux-coco@lists.linux.dev
Cc: Alex Williamson <alex@shazbot.org>, David Woodhouse <dwmw2@infradead.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sean Christopherson <seanjc@google.com>, Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Steven Price <steven.price@arm.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> Fred Griffoul <griffoul@gmail.com> writes:
>
>> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
>>
>>> Device resources such as PCI BARs supply PFNs directly and cannot use
>>> the folio allocation path. Store the mapping owner and device ID in the
>>> core context during attach(), and use them when preparing device
>>> memslots. Keep device memory separate from ordinary PFN-backed RAM.
>>
>> The device rules you wrote down in api.rst and locking.rst helped a
>> lot. If I read v4 right, the device backing differs from the RAM PFN
>> backing in these places:
>>
>>   1. PFN mode calls RAM arch hooks: kvm_arch_gmem_make_shared() at
>>      conversion, kvm_arch_gmem_make_private() at fault, and
>>      kvm_arch_gmem_reclaim() on revoke and release. The device path
>>      has to skip them.
>>
>
> I would say that the VFIO provider expects the conversion to complete at
> conversion time, rather than being triggered by a fault.

guest_memfd currently does .gmem_make_shared() eagerly and
.gmem_make_private() lazily (at fault time).

Technically conversion time spans everything from guest exit to request
a conversion, including the guest_memfd conversion ioctl, then till the
vCPU run completion hook.

Can we move the mapping out of the conversion ioctl and into some
dedicated CCA-specific mapping ioctl, kind of like KVM_ARM_RMI_POPULATE
but doesn't actually perform writes, just does mapping?

The mapping ioctl should check the necessary prereqs, same for the
vcpu_run completion hook.

Here are some advantages I can think of:

1. Decouples mapping of VFIO addresses from guest_memfd and provide more
   understandable errors for userspace, since the mapping step has a
   clear and separate error (conversion is complicated enough with many
   failure points)

2. Better aligned conversions in general where marking private at the
   platform level is lazily performed. In this case, doing it outside of
   the conversions ioctl is not much lazier, but slightly :)

   Not quite mapping, but Suzuki did bring up that for regular memory
   (not VFIO), ARM CCA requires vCPU context for SMC_RMI_RTT_SET_RIPAS
   in .gmem_make_private(), hence that's done in the vcpu_run completion
   hook, so that's kind of lazier, relative to doing
   SMC_RMI_RTT_SET_RIPAS in the conversion ioctl.


> This is also
> required because, when an MMIO validation request completes, the guest
> expects the range to be mapped. The current flow is that the MMIO
> validation request exits to the VMM, which uses set_memory_attributes()
> to convert the range to private.
>
>>   2. lookup_pfn_range() only feeds those hooks, so the device path
>>      does not need it.
>>   3. The host mmap and stage-2 need a device memory type.
>>
>
>
> Do you mean this code? vm_page_prot is used for the host mapping created
> by mmap() on the guest_memfd, and its setup follows
> vfio_pci_core_mmap(). I think the only device-specific difference here
> should be pgprot_noncached(). Shouldn't the rest of the protection
> remain unchanged even for device PFNs?
>
>
> +	if (gmem_provider_is_device(gi)) {
> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
> +		vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> +		vma->vm_ops = &kvm_gmem_device_vm_ops;
> +		return 0;
> +	}
> +
>

What do you think of just forwarding .mmap to VFIO to figure out? This
makes VFIO less special of a provider, since I imagine different
providers may want to have different page protections or VMA flags.

guest_memfd just enforces VM_PFNMAP for PFN-mode providers.

Here's my forwarding setup: [1]. In my proposed control/data-plane
split, the vfio_fd undergoes VFIO_DEVICE_BIND_IOMMUFD with
VFIO_DEVICE_BIND_FLAG_CTRL_ONLY to become eligible for attaching to
guest_memfd. Data plane for vfio-pci == BAR supports mmap, so in this
setup, the vfio_fd's .mmap() would always fail, and the gmem fd's
.mmap() would just let VFIO set up whatever it needs.

[1] https://lore.kernel.org/all/20261106-gmem-alternative-providers-v3-61-8484dde66a7e@google.com/

Wrt the page protections, in my setup gmem reports the cacheability so
the KVM MMU can use that information to set up the stage 2 mappings.

The provider can now set up different cacheabilities for userspace page
tables vs stage 2 page tables if it wants to.

(At least that's what I intended, given my limited knowledge of ARM)

>
> [...snip...]
>

Let me catch up on the rest later :)
