Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58A381B10
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780123578; cv=none; b=AV6wCliN4gbeyYlhYcjryWXIirNdLYVVC7y21hc/oXJWwjdrdEYNVdg+GnNB9PEEvTkxkz/7rHzYVA7EaU0118GpED5kcPWHOEfA/XQMu30+fWiuDUS71mxnLMraiPpRQndn4myaDftbKjQiv+OdhWYug88PTcjQ5oK9T4k57GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780123578; c=relaxed/simple;
	bh=JlhzhyIyAyb5RN8jjB8RJ2EKC6KO+ZV5tp0WOxdM00U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LxaZx2bSYEAI1l4RI+XlwNE+721zo1jYo7yJV7jxkihLH/aanbFePND2nfzFbSf10pzW2glFn3lzkExXymrrvd8CTXGPaX8jgGcjbkCWquBTbGU7YWPysH6Pi5gZSMJURstDKxBDpIruo7752PkXvK9Npi/LJ8ZNfrCRX2NZDQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGlCi/ba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGlCi/ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759921F00893;
	Sat, 30 May 2026 06:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780123577;
	bh=6Vch0h9A7xUeCyk28hSpxcRmPTt13ASoP3YG3nsaFQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nGlCi/babQTSy0uR3+elRddQZ7VG3xWszUY7YiU7E3wqIN76YhHfXE2DSNh3cllRQ
	 N7Xi2BpDqpdMkYFglfBTd7oYOYENvCqcp/ORv6QomNwjOuX/c+wDDFssb0axdUP5Ds
	 jUc5JNG1jniDGGrZ8Kn/Sw5LsdEvZntd2fj/xBzxJ6ydSqZvH0R90IB9oWqOlLQF+6
	 5KsMgY+wUCapIDS7VkHjohyqUtMEgxfqa/jTxc2SLLubU/nn7pz3zvvfGPteQf7c1f
	 Q6hTBbowwy/UUsNXI4wM9qr6tUpizj6z952PAV+2ynbdf8zsJzmu9d9dtLh+LP5ECg
	 80Rpuf57RnQnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/27] KVM: s390: Move s390 kvm code into a
 subdirectory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-15-seiden@linux.ibm.com>
References: <20260529155050.2902245-15-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 06:46:16 +0000
Message-Id: <20260530064617.759921F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] VFIO_PCI_ZDEV_KVM was not updated to depend on KVM_S390, causi=
ng VFIO PCI passthrough failures and potential host memory corruption for A=
RM64 VMs.
--

commit 18673c1ce56f6036c29d750f15a7a93d3693b423
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Move s390 kvm code into a subdirectory

This commit moves s390 KVM guest code into an s390 subdirectory and separat=
es
gmap-related code. It renames the main s390-kvm file and updates headers to
prepare for a second KVM implementation on s390.

> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index ecbcbb781e40a..5583529918dbe 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -837,7 +837,7 @@ config VFIO_CCW
>  config VFIO_AP
>  	def_tristate n
>  	prompt "VFIO support for AP devices"
> -	depends on KVM
> +	depends on KVM_S390

[Severity: Critical]
Should VFIO_PCI_ZDEV_KVM in drivers/vfio/pci/Kconfig also be updated to
depend on KVM_S390 instead of KVM?

Leaving VFIO_PCI_ZDEV_KVM dependent on the generic KVM config means it could
be compiled in for other KVM implementations, such as ARM64 VMs.

If KVM_S390 is disabled or unloaded, zpci_kvm_hook.kvm_register is NULL,
which could cause vfio_pci_zdev_open_device() to return -ENOENT, breaking
VFIO PCI passthrough for those VMs.

If KVM_S390 is active, opening a VFIO PCI device for an ARM64 VM will
call kvm_s390_pci_register_kvm() and pass it the ARM64 KVM instance. Since
the ARM64 kvm_arch structure has a completely different layout, accessing
kvm->arch.sie_page2->gisa reads a garbage pointer. Could this calculate an
invalid physical address and configure the hardware PCI device to DMA
its adapter event notifications to that garbage address, potentially causing
host memory corruption and kernel panics?

>  	depends on VFIO
>  	depends on AP
>  	select VFIO_MDEV

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D14
