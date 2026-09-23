Received: from mta0.migadu.com (out-50.mta0.migadu.com [91.218.175.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C898456DF7
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157843; cv=none; b=X3OT+yvWOMjHMJF/VyQUndas3XVSZl32UHwDoyVhvs3iJi5sv8K0JAqwdiifK7bcTfuAQLPduCLMzT6jg2w7+W6iNpDupHT//Mf3LaoSc7iR1fHavwwv4b6JaPoP6dN2lWpfc38U38rwr19MeRNvwO08NKlZy4gMAskl8ndDau4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157843; c=relaxed/simple;
	bh=xyyxgX6Z2IBzQdllFbMd3l1KS0QkIUQEnt09r+FTDSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RvFO6T67TDhGxlQjs3qJL4fwuRVvblaq4mL0Y+ta2CxrLjRQXNazRjvfiAN0N4jUBnj32VFo664KTWT1fJvaY0ELyROFa7+gw331Q3+rLWMiTR4Mn8OtNguV+yM1QZLzFB7Z9tGqzfAhSJPLNaHTvdNeVKkNzUB9tcWQ+P86AeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vIKkxjY5; arc=none smtp.client-ip=91.218.175.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vIKkxjY5"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xyyxgX6Z2IBzQdllFbMd3l1KS0QkIUQEnt09r+FTDSw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790157840; v=1; x=1790762640;
 b=vIKkxjY5LAHsErKLdxCHOt4LyJ/DcKdUjsQiuNy0Yp6Wpxfsnx3Y4NPLtRl8tRLI/3FErtZ5
 KwManWFEd3qmTVEGV5pZwk0bdHMHIwy5SgN67bE/Wd0OSI4eYMVG3mm5JmqaJppzcy/WUWGDwX3
 5ZQxYJ59GQ8k8ZMgdmMgEt1k=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1e89cfa395ab3179;
	Wed, 23 Sep 2026 10:04:00 +0000
X-Mizu-Trace-ID: 1e89cfa395ab3179
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b5e5aaf7deso4717e87.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 03:03:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzhXq+Mc0skCYG8ONbr7AfR65pNVieGgp2vAts9A4C8IS2zaTJ8IY6DYlG+kCXgv4tNevs=@vger.kernel.org
X-Gm-Message-State: AFuF++ltUlbW7RvboxmjTKJ8eK4E2fwTr/keeFuheSFBAIn4gN4NXHm6
	wUEw6kuqSPO44XFzKHp6zoXb8WoDfIcTjuEGIr31UPS5sLP3RZxP4rCS9Gted7tMaYiMB6keBiv
	hkk3TzftJ4+Tiumvn34Cgniceo/vmxB08sb61Ay6f
X-Received: by 2002:a05:6512:ba8:b0:5b6:bcb:26c4 with SMTP id
 2adb3069b0e04-5b8d885c755mr142676e87.16.1790157835308; Wed, 23 Sep 2026
 03:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922-kvm-arm-prefault-v3-0-787bd3bc7e3f@kernel.org>
In-Reply-To: <20260922-kvm-arm-prefault-v3-0-787bd3bc7e3f@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 23 Sep 2026 11:03:19 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzpYRu2xq5VdoxodyDqLTJrcoaSrfGq=DXh283TYPJ-OQ@mail.gmail.com>
X-Gm-Features: AcwNN1Uc3FNAcNduJiv3v9IEKpsaLZzqL8bqap-uQ6FOvMoC3rZk-evpRR8tlZg
Message-ID: <CA+EHjTzpYRu2xq5VdoxodyDqLTJrcoaSrfGq=DXh283TYPJ-OQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] KVM: arm64: Add KVM_PRE_FAULT_MEMORY support
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jack Thomson <jackabt@amazon.com>, Jack Thomson <jackabt.amazon@gmail.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Vincent Donnefort <vdonnefort@google.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Leo Soares Passos <Leo.Bras@arm.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

On Tue, 22 Sep 2026 15:17:54 +0100, "Lorenzo Stoakes (ARM)"
<ljs@kernel.org> wrote:
> This series implements the KVM stage 2 page table pre-faulting feature for
> arm64.

There's likely going to be a respin for the arch hook, but FWIW,
tested as follows:

QEMU/arm64 -cpu max:
- guests boot on VHE, nVHE and protected-mode hosts, protected guests included
- pre_fault_memory_test (all guest modes, anonymous, THP, hugetlb and
shmem backing) and nv_pre_fault_memory_test pass
- pre-faulting an uninitialised vCPU returns -ENOEXEC
- dirty_log_test, demand_paging_test, mmu_stress_test and
stage2_block_transitions also pass

Apple M4 (nVHE, 4K and 16K pages):
- pre_fault_memory_test passes on the five guest modes available
there, with the same backings
- in protected mode (4K pages), the cap isn't advertised, the ioctl
returns -EOPNOTSUPP, and guests boot

Tested-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
