Received: from mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EFA4C9DE1
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767367; cv=none; b=A7zCFR2DvI9HYZYtYpe9oPhdpNt39EuZNLV5MYzY/vdiWyeugfmNTLa2b03GxgST12UWE7PeRjoLHS+eB3NcAudEvFWXEle4E/mIEzMWSzQNuzsaLNPD4QxSlrcl9A6HgJGO92T3/5vaJnrYZt6PsQfdnoZfcFHb/TR3xTp5Q0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767367; c=relaxed/simple;
	bh=UHLwJq9G2Je32qOBLOc93Igc9xV2UHXk7Mx5Wr1HmBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK+Bwe2gCQMY08priNXX/weUYFiKwSxn2zZ9NCR4FmBzbM54CAdf4pGznfUmMZJ2zI6jshNvEjNwO6rVB3NJpZi6Iy4RDF2rVard8eIRM/XJb/+RbB4HJfhYc+Zuq8+BkJOnEvGLI1m0bZ+YArjFNTTumxn59jSdQwJU8mDjPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k0yWT1sI; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k0yWT1sI"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UHLwJq9G2Je32qOBLOc93Igc9xV2UHXk7Mx5Wr1HmBg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790767363; v=1; x=1791372163;
 b=k0yWT1sIw7L8vYjUN0BUAA5lVhDnrqVvMPpVUqPBbosxcrGTV+IioRwiurcSprXAf56l77tr
 kuWvvGmlISih2Yh6KwrR3fob2pe7Rxyebx7sTKpSSKe44XiYXbz6jBmkGIPSwIjGzn8BBEc+Ll2
 phIc17/z0vJogp1GD3+wDA4k=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e83f20bf38db337e;
	Wed, 30 Sep 2026 11:22:43 +0000
X-Mizu-Trace-ID: e83f20bf38db337e
X-Migadu-Flow: FLOW_OUT
Date: Wed, 30 Sep 2026 13:22:42 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com, sunilvl@oss.qualcomm.com
Subject: Re: [kvm-unit-tests PATCH 0/7] riscv: ACPI boot and BRS-I SBI tests
Message-ID: <syzvrpkpdg5gjo4q6fgeypshwc33vzlzy3r6bvu5pqwm5iogl6@gewf5shwul3k>
References: <20260924033945.176581-1-wangxiang@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924033945.176581-1-wangxiang@iscas.ac.cn>


Thanks for this series, Xiang. I'm glad to see kvm-unit-tests getting
used. But please make sure you work with the RVI BRS community to ensure
your work is aligned with their plans.

Thanks,
drew

On Thu, Sep 24, 2026 at 11:39:38AM +0800, Xiang W wrote:
> Hi,
> 
> This series lets RISC-V kvm-unit-tests boot on BRS-I platforms that
> describe the system with UEFI + ACPI instead of a device tree, and adds
> a first unit test for the SBI rules in the RISC-V Boot and Runtime
> Services specification [1].
> 
> The RISC-V port currently assumes a DT for CPU bring-up, timer
> frequency, ISA-string parsing and console setup. BRS-I firmware
> typically does not provide a usable DT, and often has no MMIO UART
> either. Without these changes the existing tests abort in setup before
> they can exercise SBI.
> 
> Patches 1-4 teach the RISC-V library to initialize from ACPI when a DT
> is absent:
> 
>   - locate the ACPI 2.0 RSDP via the EFI configuration table
>   - parse MADT RINTC entries for hart / CPU bring-up
>   - read the timebase frequency from RHCT
>   - parse the ISA string from RHCT Hart Info nodes (match by ACPI UID)
> 
> The RSDP is left in EFI_ACPI_RECLAIM_MEMORY; the RISC-V allocator does
> not reuse that region, so the table is not copied aside.
> 
> Patch 5 splits CONFIG_SBI_CONSOLE out of the UART driver. io_init()
> becomes a no-op and puts() issues SBI DBCN CONSOLE_WRITE directly, so
> EFI/ACPI guests no longer depend on a described MMIO UART to print.
> 
> Patch 6 drops the EFI runner's EFI_USE_ACPI=y early exit. The runner
> already omits -machine acpi=off in that case; QEMU virt defaults to
> ACPI enabled.
> 
> Patch 7 adds riscv/riscv-brs.c for:
> 
>   SBI_010  spec version >= 2.0
>   SBI_020  HSM required
>   SBI_030  TIME required unless Sstc
>   SBI_040  IPI required unless Ssaia
>   SBI_050  RFENCE required unless Ssaia
>   SBI_060  PMU required unless Smcsrind + Sscsrind + Smcdeleg + Ssccfg
>   SBI_070  DBCN required when ACPI SPCR Interface Type is 0x15
> 
> The new test is in group "riscv-brs nodefault", so it is not part of
> the default run_tests.sh pass. DT-only QEMU virt is unchanged.
> 
> Based on kvm-unit-tests master (5a221342).
> 
> [1] https://github.com/riscv-non-isa/riscv-brs
> 
> Testing
> =======
> Build:
> 
>   ./configure --arch=riscv64 \
>               --cross-prefix=riscv64-linux-gnu- \
>               --console=sbi --enable-efi && make
> 
> EFI + ACPI (BRS-I style):
> 
>   EFI_USE_ACPI=y EFI_UEFI=/path/to/RISCV_VIRT_CODE.fd \
>     ./riscv/efi/run riscv/riscv-brs.efi
> 
> Please review.
> 
> Xiang W (7):
>   riscv: Initialize the ACPI RSDP from the EFI system table
>   riscv: Add ACPI support for CPU initialization
>   riscv: Add ACPI support for timer frequency discovery
>   riscv: Add ACPI support for ISA string discovery
>   riscv: Decouple SBI console from UART init
>   riscv: efi: Allow ACPI boots
>   riscv: Add BRS SBI requirement tests
> 
>  lib/acpi.h                |  67 ++++++++++++++-
>  lib/riscv/asm/isa.h       |   5 ++
>  lib/riscv/asm/processor.h |   1 +
>  lib/riscv/asm/sbi.h       |   2 +
>  lib/riscv/io.c            |  50 +++++------
>  lib/riscv/isa.c           |  82 ++++++++++++++++--
>  lib/riscv/setup.c         |  55 ++++++++++++
>  lib/riscv/timer.c         |  37 ++++++---
>  riscv/Makefile            |   1 +
>  riscv/efi/run             |   5 --
>  riscv/riscv-brs.c         | 171 ++++++++++++++++++++++++++++++++++++++
>  riscv/unittests.cfg       |   4 +
>  12 files changed, 424 insertions(+), 56 deletions(-)
>  create mode 100644 riscv/riscv-brs.c
> 
> -- 
> 2.47.3
> 
