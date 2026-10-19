Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23A4F5DE7
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415826; cv=pass; b=DVEm1mn60iGbsqdgPQ+eWc0QZX2q1ldRklPQakwnu+xtovOrx8Tsh+TLi/0niKVq+SrH1kwebdYzUMgtWWdCa0KXUnxOnixb5syYSjzIoZiFtdWgHEvFYbX6hSlRdRPfwpX4P4v7v8wES0hHXvjr0BsbVcg/J7/U94yHcWSjhUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415826; c=relaxed/simple;
	bh=U4Na9/OiaM5rlZK71twM/zPx8zOQve5CjrR7UMSuXK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QK3ukqeZzP4ay6Z6qspkrdqoBQM1/x+v32vRO7pheH7djgwMwI2ZBQtwyI1NkIOtGmwdTTVndXXvwHUBVd3dwj7AqOS3BArR/6skfkGNfToADNOQFYF2dZs+z5JCuLGeOSSR3TjXuYK9ha4FVDECtDRmIlfU6r3rOqpmUpRQK30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WaMJDDhM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RELat6S0; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaMJDDhM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RELat6S0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792415819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xBkohv+gPNKQHhtoyYYkfZmGP4uS8PMnVqPnpwCMyKM=;
	b=WaMJDDhMs0cJMkxwgbFIxHGa0IK0mf/U8juyFrdki5rWQBRkd9l01CP4itmvaiwX4OQLZr
	omORpTJB3RG52z5HcPqH3ltVT+BzCWIpVqQGWSWMyeYky9p2NaOwPjFij+eyldD8gOAAlt
	N5QZ33chIUU6M2MEop/YyNAP8pzScoU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-wCFS8idrO7aUcPWjNMZs7A-1; Mon, 19 Oct 2026 13:16:48 +0000
X-MC-Unique: wCFS8idrO7aUcPWjNMZs7A-1
X-Mimecast-MFC-AGG-ID: wCFS8idrO7aUcPWjNMZs7A_1792415787
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48afcecb035so686437f8f.0
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 06:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792415787; cv=none;
        d=google.com; s=arc-20260327;
        b=Igcxy8/DPhp3HNAAyPuDzSwKaLsuR4ynFfx9SliuRj3W5XXNWAXOmqeW7Q0OQFKAvJ
         6a9SErxcME03nM8Zf6kENZ8OxpKMvxF6WETTazo4ycKHVN9T+T2WZQhd+cj+q7iKNmUC
         u2zjjsvH2Jjzg4DmU4q7/UbaqyxbL5Y4O8EpyDpaBB1CtelOkEzUnpYmRvelytB2TebT
         /ZVSZHDbg06wQCsQ6hFrKA9z6yrEtLXjdm+85lDtA2/5qIwRmeffUCgPeqYqI4nZ62up
         d88p5QQCIUyyYYKTaZjSbTKaQDGcO2NnKpJ08jZf7Uncebr9V7+JtbdKA1NK256QuD2o
         Hk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xBkohv+gPNKQHhtoyYYkfZmGP4uS8PMnVqPnpwCMyKM=;
        fh=TOklTg7DNryhADHOVf0Wi2UausE6UaKkoYHNDy59CCw=;
        b=ILZ5bl5+S5PECj2NsbVa2LvU+VEPgJJmEcggSJpDSMzDPvCqC4wRgcyW/dKzhJBTBh
         8JG76xVU8L7iwAnBaIaRE/FV60AoDri4wy7IlNc78ODrbFX9MmBD5j1oViWVAxolENjG
         BrcEGXqsaU24W3SEbMD0M/+c1SRNAqDoesGNG9w9u4f3xiSvRTNbFIlZkOs6ITKcO+ZF
         3BxrfERgh9vmyHg9thMlZbMIZzG3iO+2PyEjpp3XV7jScnMQMCedh9RnEMckU5N+UVGl
         DsIhsz7vL3kZHKsDTw41Zxg40NKBZRxxsTkUbK3OE0MOV0g+xv0x88lcaNfR8iYDzEIg
         SNCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792415787; x=1793020587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xBkohv+gPNKQHhtoyYYkfZmGP4uS8PMnVqPnpwCMyKM=;
        b=RELat6S0kucO+mfC52Cc3dr+xvlf+H2sNczMqCflYUXzoWzJN4GWT/xr8n3ubobzdg
         kiAhyVxYdaqDz2wZnE4GGCz4mYh5R+GgcXsq50JESSLJ0ySb52BjIBqtUOSi0z8bGcyz
         2nzJjHeEZwU3W4ka1yoQReagRcGuEsfCN9xBRvo8W090nHHyqObeetgG7Vz49lH6xafl
         3Wvxj8mbhfAwvpTaJm5voDstmZ44WM5YvglGIWM1anwPl3B36hwaigZDhKX778Xjcd0A
         td15ReDhjZU6x/I+2pH+cawuVYxj8q1yPyXw4IbrJ22SdiTsqrxxQ491MjEWrluyeJoP
         4ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792415787; x=1793020587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xBkohv+gPNKQHhtoyYYkfZmGP4uS8PMnVqPnpwCMyKM=;
        b=FXgxEZHgF0+sj5exME1zbMPNgwMHInosxExQMaolapWllzEHkPxa0eadeHbBSbJjwY
         qzI4xvf0x6heEPNsy1twtlE6kS5d6D8k2tjuGtmrRuyBhAi67yXlhKrth0gIKcMQKS23
         oXeY7QzHtNdZlkRxE5B8YlzfQPrPwpDyOXWcYYcv5iynyLbVuxpmRTGHDcjBUJ3fQsk1
         +n4ycVVkvXr+dWKxRBrxCZghfS0+lUOBbmnImKHNEPutBAM430NXjCdbaZAQRMa8DvYK
         ObMuuydbA88tpAZo3X7VRMcnYF6FSS/N8tv0R/yLMXCmsR0iDjHzLcAhvyM6hSaAoHlR
         nKkw==
X-Gm-Message-State: AFq9FYJ8yhgdBvcl9nbe9EcXJ2t6/5Bm7HRWsCexKvlrt3xM/caBIb43
	1hIqTkYot4HgTMYOtUAzWz8rNJuT1LbLxaJTizklJhlpnGGeveYEfj4K0uLL6wcCZveKrpt4MnL
	q4KMZg79yQ15hMGKknx0jjNVbird1YsCfPBdRKURnNqX6fTpHj7+bIyfNOq/2a0LugGKhH6A9tM
	TTpEid2OImRMr3dshoOF0AvCWKLLc1
X-Gm-Gg: AYBFou3gnfRtTL0OHq82wBNO0QSvId2ZAiV9F/TTSZ572LWPpxopa8ptv3mv469RFtJ
	QvbfeaUXhp4jNj62SR5KXwF1O+tR4TCfPek3Iu+rDTutPn5pJfZlvN6N8cj+Sw2u48ntGqQk0Or
	5LE4oIJJIwMUzNNDobvc252qP9JkWF2u55VP/ehtfqVylrB2XO3FtilPkS/zZqaKxbtEn6736E0
	DDzGRBkAgnFWHNeaCMMSCqm0w1ljgRZwuCLLfFDC1Ko3dey8ca/8AAP3yr4WQ==
X-Received: by 2002:a05:6000:26c1:b0:48b:946:c1f7 with SMTP id ffacd0b85a97d-48dfaea3908mr26103720f8f.31.1792415786521;
        Mon, 19 Oct 2026 06:16:26 -0700 (PDT)
X-Received: by 2002:a05:6000:26c1:b0:48b:946:c1f7 with SMTP id
 ffacd0b85a97d-48dfaea3908mr26103660f8f.31.1792415786039; Mon, 19 Oct 2026
 06:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015171140.262334-1-borntraeger@de.ibm.com>
In-Reply-To: <20261015171140.262334-1-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 19 Oct 2026 15:16:14 +0200
X-Gm-Features: AclHuK_4Ll6JOpljIfXvvXJWmctQUuadLrN7i7MvIFCuMBzlZiVOI0tMzhaLmho
Message-ID: <CABgObfbdTsAMHC0hqdV6kC4V6kgfVQ4eSyJV3xCeLuPdEVcm=g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: s390: Changes for 7.4 including arm on s390
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Gabriella Seifert <gseifert@linux.ibm.com>, 
	Hendrik Brueckner <brueckner@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	Steffen Eiden <seiden@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Christoph Schlameuss <schlameuss@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 7:12=E2=80=AFPM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> From: Christian Borntraeger <borntraeger@linux.ibm.com>
>
> Paolo,
>
> The following changes since commit 439d8f9cb01cb04f9b31910efd0ae8dbdfa4ad=
97:
>
>   Merge tag 'kvmarm-7.4' of git://git.kernel.org/pub/scm/linux/kernel/git=
/kvmarm/kvmarm into HEAD (2026-10-14 18:26:28 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/k=
vm-s390-next-7.4-2
>
> for you to fetch changes up to e93fb70b748982fda5e6d97721df35194cacfc4a:
>
>   arm64: Use proper include variant (2026-10-15 13:38:43 +0200)
>
> The last one line patch is in fact a cherry-pick of b64f41a7ace1
> ("arm64: Use proper include variant") from the arm tree, but necessary
> to build.
>
> With that we have the initial arm on s390 support.

Pulled (to kvm/queue for now, will be in kvm/next as soon as my x86
tests finish).

Paolo

> ----------------------------------------------------------------
> KVM: s390: Changes for 7.4
>
> - rework page allocation for secure guest variable storage
> - selftests
> - documentation
> - replace get_zeroed_page with kzalloc
> - fix floating interrupt inject for corner cases
> - initial arm64 on s390 support
>
> This also contains the patch
> "arm64: Use proper include variant"
> as a build fix. It is also part of the arm tree.
>
> ----------------------------------------------------------------
> Eric Farman (1):
>       Documentation: Add missing KVM s390 crypto attributes
>
> Gabriella Seifert (1):
>       KVM: s390: selftests: Add IRQ injection selftests
>
> Heiko Carstens (1):
>       s390/uv: Rework page allocation for guest variable storage area
>
> Hendrik Brueckner (1):
>       s390/hwcaps: Report SAE support as hwcap
>
> Janosch Frank (2):
>       KVM: s390: Improve floating IRQ injection behavior
>       KVM: s390: Kick PV cpus at the right time for service irqs
>
> Mike Rapoport (Microsoft) (4):
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for sie_page2 a=
nd CMMA
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for the GIB
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for the STSI bu=
ffer
>       KVM: s390: Replace get_zeroed_page() with kzalloc() for the STHYI b=
uffer
>
> Steffen Eiden (14):
>       s390/Kconfig: remove PCI dependency from HAS_IOMEM
>       KVM: s390: Use dedicated function for migration mode
>       s390/tools: Use arm64 headers
>       KVM: s390: Use arm64 code
>       s390: Introduce Start Arm Execution instruction
>       KVM: s390: arm64: Introduce host definitions
>       KVM: s390: Add basic arm64 kvm module
>       KVM: s390: arm64: Implement required functions
>       KVM: s390: arm64: Implement vm/vcpu create destroy
>       KVM: s390: arm64: Implement vCPU IOCTLs
>       KVM: s390: arm64: Implement basic page fault handler
>       KVM: s390: arm64: Integrate arm on s390
>       MAINTAINERS: Add entry for ARM on s390 KVM
>       arm64: Use proper include variant
>
>  Documentation/virt/kvm/devices/vm.rst            |  18 +
>  MAINTAINERS                                      |  17 +
>  arch/arm64/include/asm/sysreg.h                  |   2 +-
>  arch/s390/Kconfig                                |   5 +-
>  arch/s390/include/arm64/kvm_emulate.h            | 130 ++++
>  arch/s390/include/arm64/kvm_nested.h             |  11 +
>  arch/s390/include/arm64/ptrace.h                 |  11 +
>  arch/s390/include/arm64/sysreg.h                 |  13 +
>  arch/s390/include/asm/asm-prototypes.h           |   1 +
>  arch/s390/include/asm/elf.h                      |   2 +
>  arch/s390/include/asm/io.h                       |  12 +-
>  arch/s390/include/asm/kvm.h                      |   6 +
>  arch/s390/include/asm/kvm_host.h                 |   4 +
>  arch/s390/include/asm/kvm_host_arm64.h           | 209 +++++++
>  arch/s390/include/asm/kvm_host_arm64_types.h     | 124 ++++
>  arch/s390/include/asm/kvm_host_types.h           |   4 +
>  arch/s390/include/asm/sae.h                      |  49 ++
>  arch/s390/include/asm/sclp.h                     |   5 +-
>  arch/s390/include/asm/stacktrace.h               |   5 +
>  arch/s390/include/uapi/Kbuild                    |   6 +
>  arch/s390/kernel/asm-offsets.c                   |   1 +
>  arch/s390/kernel/entry.S                         |  22 +
>  arch/s390/kernel/processor.c                     |   3 +
>  arch/s390/kernel/uv.c                            |  41 +-
>  arch/s390/kvm/Kconfig                            |  21 +-
>  arch/s390/kvm/Makefile                           |   1 +
>  arch/s390/kvm/arm64/.gitignore                   |   2 +
>  arch/s390/kvm/arm64/Makefile                     | 110 ++++
>  arch/s390/kvm/arm64/Makefile.gen                 |  28 +
>  arch/s390/kvm/arm64/arm.c                        | 754 +++++++++++++++++=
++++++
>  arch/s390/kvm/arm64/arm.h                        |  58 ++
>  arch/s390/kvm/arm64/copy-arm64c.awk              |  82 +++
>  arch/s390/kvm/arm64/guest.c                      | 135 ++++
>  arch/s390/kvm/arm64/handle_exit.c                | 161 +++++
>  arch/s390/kvm/arm64/handle_exit.h                |   9 +
>  arch/s390/kvm/arm64/inject_fault.c               |  21 +
>  arch/s390/kvm/arm64/mmio.c                       |  15 +
>  arch/s390/kvm/arm64/mmu.c                        | 210 +++++++
>  arch/s390/kvm/arm64/reset.c                      |  71 +++
>  arch/s390/kvm/arm64/trace.h                      | 101 +++
>  arch/s390/kvm/gmap/faultin.c                     |   5 +
>  arch/s390/kvm/gmap/gmap.c                        |   4 +
>  arch/s390/kvm/gmap/kvm_mmu.c                     |   6 +-
>  arch/s390/kvm/gmap/trace_gmap.h                  |  13 +
>  arch/s390/kvm/s390/intercept.c                   |  32 +-
>  arch/s390/kvm/s390/interrupt.c                   | 130 +++-
>  arch/s390/kvm/s390/priv.c                        |  19 +-
>  arch/s390/kvm/s390/s390.c                        |  12 +-
>  arch/s390/kvm/s390/s390.h                        |   1 +
>  arch/s390/tools/Makefile                         |   6 +-
>  arch/s390/tools/Makefile.arm64h                  |  55 ++
>  arch/s390/tools/copy-arm64h-full.awk             |  50 ++
>  arch/s390/tools/copy-arm64h.awk                  |  83 +++
>  arch/s390/tools/opcodes.txt                      |   3 +
>  drivers/s390/char/sclp_early.c                   |   1 +
>  tools/testing/selftests/kvm/Makefile.kvm         |   1 +
>  tools/testing/selftests/kvm/s390/irq_injection.c |  74 +++
>  57 files changed, 2883 insertions(+), 92 deletions(-)
>  create mode 100644 arch/s390/include/arm64/kvm_emulate.h
>  create mode 100644 arch/s390/include/arm64/kvm_nested.h
>  create mode 100644 arch/s390/include/arm64/ptrace.h
>  create mode 100644 arch/s390/include/arm64/sysreg.h
>  create mode 100644 arch/s390/include/asm/kvm.h
>  create mode 100644 arch/s390/include/asm/kvm_host_arm64.h
>  create mode 100644 arch/s390/include/asm/kvm_host_arm64_types.h
>  create mode 100644 arch/s390/include/asm/sae.h
>  create mode 100644 arch/s390/include/uapi/Kbuild
>  create mode 100644 arch/s390/kvm/arm64/.gitignore
>  create mode 100644 arch/s390/kvm/arm64/Makefile
>  create mode 100644 arch/s390/kvm/arm64/Makefile.gen
>  create mode 100644 arch/s390/kvm/arm64/arm.c
>  create mode 100644 arch/s390/kvm/arm64/arm.h
>  create mode 100644 arch/s390/kvm/arm64/copy-arm64c.awk
>  create mode 100644 arch/s390/kvm/arm64/guest.c
>  create mode 100644 arch/s390/kvm/arm64/handle_exit.c
>  create mode 100644 arch/s390/kvm/arm64/handle_exit.h
>  create mode 100644 arch/s390/kvm/arm64/inject_fault.c
>  create mode 100644 arch/s390/kvm/arm64/mmio.c
>  create mode 100644 arch/s390/kvm/arm64/mmu.c
>  create mode 100644 arch/s390/kvm/arm64/reset.c
>  create mode 100644 arch/s390/kvm/arm64/trace.h
>  create mode 100644 arch/s390/tools/Makefile.arm64h
>  create mode 100644 arch/s390/tools/copy-arm64h-full.awk
>  create mode 100644 arch/s390/tools/copy-arm64h.awk
>  create mode 100644 tools/testing/selftests/kvm/s390/irq_injection.c
>

