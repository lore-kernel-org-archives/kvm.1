Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D344A3D41
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366027; cv=none; b=mWS1JEfqhtMlR6tcp4kSJ76Eq4y7PmK1W9XTDoa2d/metqWZQpdSB01ra4i6ygL8fpX+pbDXpPD+fp2s5F97rCtBSYU66/08Kkn7m7yTZ3eYIoeDiTVyXE9wvkPzI20oHuXxqoNGVb8NPWWzp39YByMoMG2a3njnu43ezppMjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366027; c=relaxed/simple;
	bh=kirF1Z6H1us8C+w/nRlLFHvxONxvS/UzEcyYUHsaSLA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p4ghqo90cYDYJ1+85PYL/4Bg8qJn6bMmud7x8l8qx/iKTtkXfMOXKvI0sdDuUJuU5q12JD5Q6T5BMhncrJDEVECB6SPm85ASLxd/iYgnPvMcgT61WI17oILpTG+pHcPxhIag/ebzb+Lf7fJ2mIumpA2Qs5GCZars4UtUz2DBOec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=APn0ZqVf; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="APn0ZqVf"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c89704da8c7so1740052a12.0
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788366024; x=1788970824; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nmUHQDRJovGy5euybNv8U4I384UlmmpWUQBP5c7RHzY=;
        b=APn0ZqVf2NzKu9DA1ZSd4dyGrIK2gNQc4BG7tco9uyQFfl+YByZN4lUWNNOKve94uL
         Ne3yu95UWyseAq2Np15elhcPv4GPk9fiLo37iKAzQDxEtKJnnUTSGWjE1bZOLUwv9hIm
         ZDX4o41/iNPSxhGSEgrk05bJ2DdPypsB/DJ7DQ6l9efca4KPldLXUczRCvwja4881+V7
         CS72tggD7ty30ZmcUF+IuUVpWUU0aMH6fvlNwfPtjcqT0AWDJrOG+EC77PJoJ7UXuGgJ
         pYe5thrKOyXG1y+THPqGmBIS7RC5ZPQwsxjXNy1tjClnVHK21tcaP+CYIak59R9K3jvk
         MZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366024; x=1788970824;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nmUHQDRJovGy5euybNv8U4I384UlmmpWUQBP5c7RHzY=;
        b=LgIZ2fa5GZAXTGD8UDsXjEoN+QBtKsVzI5QSNgJJqgKxXsefRWkgogFFKU2HjJN+pw
         YxI6PwnVooJHEwRdeLNEr/+7rSpg4l4iPxYIg+a2B8oP8XkWTFoc4855JKuIlsuadd6K
         BJYGv66hZV8PXtk3uOS+7VwS8pAVPzrBVAqT//wkvAeR4ZY9wxMz54IOzmpiMEvLYa/U
         UX4r60gfpjvnMjX+AzBQJgc40HmiHOtPjJA0O/5FwxHbg/b0CiPIYm8ivjyTxomR8cRJ
         2kiGe7HQQ85gl0L5x+Pmwm7HLAbrf/lU+sRVMtU9qrdsH5FE0PdD7pUPf0eGjRAKma/4
         iZWQ==
X-Gm-Message-State: AFuF++ljKX745hR6c8t2vDcOpFYXPZvuEkQsWZsLbn8N29aaDtAvLoka
	AssveWJHFAd6x6OHek9BFzGAa+Ud9N9ISL+34ca7RJ4Bg4IOmzG6Zv8CnXnqNHzzqn8mVTQnC+4
	Pv7Rr/Q==
X-Received: from pgp27-n1.prod.google.com ([2002:a05:6a02:62db:10b0:cbe:e120:3788])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d22:b0:3d3:aec2:4dcb
 with SMTP id adf61e73a8af0-3d9b051aa7dmr10390341637.23.1788366023624; Wed, 02
 Sep 2026 09:20:23 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:20:23 -0700
In-Reply-To: <20260831144802.834315-24-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-24-seiden@linux.ibm.com>
Message-ID: <aphMx5hsoXwIpNjt@google.com>
Subject: Re: [PATCH v7 23/23] KVM: s390: arm64: Add KVM_S390_ARM64 Kconfig and Makefile
From: Sean Christopherson <seanjc@google.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 31, 2026, Steffen Eiden wrote:
> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> index 8d3ee17a1bcb..9c69ea16031e 100644
> --- a/arch/s390/kvm/Kconfig
> +++ b/arch/s390/kvm/Kconfig
> @@ -53,4 +53,33 @@ config KVM_S390_UCONTROL
>  
>  	  If unsure, say N.
>  
> +config KVM_S390_ARM64
> +	def_tristate y
> +	prompt "KVM support for hardware accelerated arm64 guests"
> +	depends on HAS_IOMEM
> +	depends on KVM

Is this actually necessary?  I.e. does kvm.ko need to be *loaded* in order for
kvm-arm64.ko to be loaded?

If kvm-arm64.ko does indeed have a hard dependency on kvm.ko, then I think it
makes sense to not have redundant "select" statements below.  As an outsider,
it's super confusing because the KVM_S390_ARM64 are incomplete, e.g. are lacking
things like VIRT_XFER_TO_GUEST_WORK (at least, I assume those are lacking), and
makes it hard to see what is actually unique to kvm-arm64.ko.

If kvm-arm64.ko doesn't have a dependency on kvm.ko, e.g. to initialize hardware
or something, then this "depends on" should go away.
