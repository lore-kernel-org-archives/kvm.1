Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794570756;
	b=JRTsdsQj3VRYYLnx5QILDpmFY8u92QgTuC5+d05deIMJhAXSr4ylTcybNJpSCqlXg51w
	 5sLry2R0FPWQxrdYL+SADKPFMbPh4rS6PmUvhd9Yzh2gRidRqFIsR2X6Orb//AW7oBuc6
	 8ZzOqAUefKnYJoCUBEzypQc1aKqLN9qHkb4QTQGf0crH5CstiRzdQdKKp2fn4D1Yn6zTp
	 RnErZxhZOiT3MQuD0b9coQ9o1NgiiRyUJhjGxme2Fya/jPrvHfZ7lMwQRxNtkzSyRaSar
	 SXlzOJpIWreIvBo0GAw8mo0ockCbztU6uDsymuavdgHTwOtI0GSyIuM4IJ9STS95Zfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=rFJV8f4SaM77hiC2RgsHSVyvllFeY8X5U8hH/4aH3VM=;
	b=3SZZhAgq1DOFvU2AWAiAK0OqBmR7S4RD7++dlganyO4ya0CW6SXX/Ts4toNVfQzQTLuc
	 sRwXI68ji5SbYEyqgbSBTKiBdJXupMeCMm6q7Rh0DxBYKkLy7DLN7AgVmUDdIniJZjVxS
	 BsD2KeOEZ2n5eKDfpuTduDoT8BSJb7faJ75cE1Ohbp0LVbtcJIu9m2/TSm1ykd4REnmwV
	 ZHDbgIoyZssXYlKa5ygVYLs/Ec73Jw+M/oILjR4eAR0Wej1xlZx2BOZGUI1lKLcXTu8fc
	 SEQy4/zWQ6zka6g+IGy/6cOgqf6gMk+4jqym6cNnhSBI8KvMGhLwx+OSzXymb1lZNpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=r6Mk1tx2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FAA606A31C
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 11:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0FAA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=r6Mk1tx2
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4922dbcee23so380662f8f.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 03:52:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794570754; cv=none;
        d=google.com; s=arc-20260327;
        b=S9jbpcxw3zFzvOZg5og/m4IsSlpcrWv9OKR5Ax0NIeByORuhk7cTwxNy4ZuflM9aAj
         gPIxawD9l6+owUfkx0JLXcGddQtqEy2h+XnY0sV3kGmkuVFm3PkOZG0Go3lTyvtzDpZv
         AUdaNU4f0n35f4trKRLUlPFOMkD5h1qrFBX/vIEN1n0vzPXbfliOe2set1D72h3k1fKT
         oRffy9KttMJHMe2UbijVPZuEuZDlFdCqfQNzCbXjXeMuQMecBvWJ1bu5H/tKglw6BgPi
         8OHLfAGR0lb0uvpa23vRbCivs2YpVufH3U7G5/oIfOMKaKktcufySoAcIUt6OSsSC+X4
         FrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rFJV8f4SaM77hiC2RgsHSVyvllFeY8X5U8hH/4aH3VM=;
        fh=2BBu8/w49qcf3k4awXLJsqBoZ7rpaycHGCHup3qvw6s=;
        b=Qo7xFfmafAN0H2Db5es4WgO8TnUoSQzx9B2d/kuJhQPNpaP0f1Ge6g93SXhRgT8vSh
         B+07r9lIYUggCBtWcsbmd3darKNpT/unQmEXAJE8poDTV4RNn84Unwqa4Zji9cg8QW1o
         CXnlsNo1j2UEPfeWo2D+OJAx2S5AmnnppbCJsfNVbh1FPiu2xt9KcmJjI690afn3Zelv
         6aAbC1MImigQEATBSAMy1+s8nFneBf5cbejwLPKmfa7f/TQMoKH96zA1xT4xAlj2lcel
         YEy4JI32aziIHyvJN6FL+89V/jXBKjBASYR3NRxEy8wChyXEF6NRnnffCqsqyYS6kwcG
         /2UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794570754; x=1795175554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rFJV8f4SaM77hiC2RgsHSVyvllFeY8X5U8hH/4aH3VM=;
        b=r6Mk1tx2/B+ecQtn9CuegQutx+fRha2cP4cQ9vrpNkRiP/eDR6++QMXyJOUo9DZoBu
         hpdndWRMcI8b2tx2TtJeo0ivgWq7PG42mSq650M4w3pMVgyFC965z9Xtq3a5OLCVlFA3
         XLd+m5fuR+AQwBIwWCU1D91FcJfTQc6L14+uH4yln0vStJI+NTPnJ3yNlNHtISPHwLDL
         E9akdERw3Jab58s7A+z+oVMmKftJldI/nE+9yrOU3hZagEygG0qcBCELJkGq7XOY3Y8L
         KnA/lJvNi61XdUG4TEu56njTC67KhxBChnK/KQae8qfXRTSAZpdYqwcq9Z3sV6wUKC1P
         C1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794570754; x=1795175554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFJV8f4SaM77hiC2RgsHSVyvllFeY8X5U8hH/4aH3VM=;
        b=WXcM2pv2eoB50VVDLNo+y0uCipeznAiGiNlOsE/vo5EMm2RDCfNWyVScZGysOwf2nJ
         iWbR/z1vSwZ2U3wQ0Z/Lr9XBSPumfoZrLpEUXWbOtVdOIFJ9J04ay3YwhCAU7+/ShlyB
         QXG98UAB/uAbBwxeddutuKLh86dWszG4PF0HmMKIyM7Wd0A0OzhuS19t71DvnK2FQ4ln
         smccy7SbDdx0Ss/OoLn5REAKlJi5ma6cGaNrDHFzamSoR09MSMoLyU/KqPU0/0hN4Rx7
         eFSZid/S/E9ijMTpj4saluaWLF/EZNRSRyOlKMJ4b6LfWFRyJjBtYYtwBy6FdQOQOXQx
         DRaA==
X-Gm-Message-State: APuU4Z/QMwyxNokeoxv8IOG07SvU7rnKIZRHIw77jlAHUf+MHz6LDIQT
	b3uirhQS775Lns28QGwyrMJSDQoM9UxfSSnCMF1Y7pynV1hfxTxUY/jcIidVd1Hi372ytq2HxNj
	tMGk3wPykMVTn52Fqp1DYJi7+dLhfPB3eU0h4iMSBPQ==
X-Gm-Gg: AYBFou2FLQv6NUSdeerIQmm7z6RGvyCv8h6sijGAL2M7O0eKkshJNWUNY8/B1IYGNmz
	jIkQLunNrRsvtfvZyJPcotQVQ+7TWxHmt1s7kDYcpOgczCi8Ys+3Q2/BKNcS1TkWGXgGSPVAXWp
	/4VVq5PGOUKILhaKI+YJcIiyMeMVAJarjzzMtsk4TLBkl2lGdYQz8XB27Epi4/krXNzFpw8dZjp
	EyyXnlLxNOw5HDFN2izSwIPropnsWyabCBiCdJ/M4rXsFDh98hXxKzexVxvJg/RXU90ygsHmdOq
	xKEoTMmoyIOJ+PMff0eDrjZPJAuDI2HI1xelEmksUSf1vuBtMm8oxrVEO9Nct9xMJ/yCnEQ9DD6
	gBv1GMYEcOKymUnvYf1KYaN9e8qHL30qqWW79zdsCJNfTTwMQWoPknCYZICZebqEi8BhvQlT5xl
	Jmk+kuozHspp4J6+JtvghQNHJ5tE5EI0k69QzbMGYv+TICZWK5/OCDOS8=
X-Received: by 2002:a05:6000:27c6:b0:497:9e2a:b27 with SMTP id
 ffacd0b85a97d-49c72e85cdcmr3456559f8f.38.1794570754020; Fri, 13 Nov 2026
 03:52:34 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019144304.2678066-1-andrew.jones@linux.dev>
In-Reply-To: <20261019144304.2678066-1-andrew.jones@linux.dev>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 17:22:22 +0530
X-Gm-Features: AclHuK_B-tIZNaWaX5qAf23plZzHsb0LvkBpo6TqDvhSVaG0Z1182jGHh-coKtQ
Message-ID: <CAAhSdy0MhPf9qrBBSJP+3EExmc9vRRe07gdHHv2JSYnOmWRvkw@mail.gmail.com>
Subject: Re: [PATCH kvmtool] riscv: Place the FDT after the kernel's image_size
To: Andrew Jones <andrew.jones@linux.dev>
Cc: kvm@vger.kernel.org, will@kernel.org, julien.thierry.kdev@gmail.com, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 8:13=E2=80=AFPM Andrew Jones <andrew.jones@linux.de=
v> wrote:
>
> The FDT is placed relative to the end of the kernel image file, but a
> kernel's memory footprint includes its BSS, which isn't in the file. When
> the BSS is large enough, e.g. with lockdep enabled, the FDT lands inside
> it and is wiped when the kernel clears BSS, leaving the guest hung with n=
o
> console output. Use the image_size from the Image header, as arm64 does.
>
> Signed-off-by: Andrew Jones <andrew.jones@linux.dev>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  riscv/include/asm/image.h | 40 +++++++++++++++++++++++++++++++++++++++
>  riscv/kvm.c               | 26 ++++++++++++++++++++++---
>  2 files changed, 63 insertions(+), 3 deletions(-)
>  create mode 100644 riscv/include/asm/image.h
>
> diff --git a/riscv/include/asm/image.h b/riscv/include/asm/image.h
> new file mode 100644
> index 000000000000..0deb74ddd9d4
> --- /dev/null
> +++ b/riscv/include/asm/image.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_IMAGE_H
> +#define __ASM_IMAGE_H
> +
> +#define RISCV_IMAGE_MAGIC      "RISCV\0\0\0"
> +#define RISCV_IMAGE_MAGIC2     "RSC\x05"
> +
> +/*
> + * struct riscv_image_header - riscv kernel image header
> + * See Documentation/arch/riscv/boot-image-header.rst for details
> + *
> + * @code0:             Executable code
> + * @code1:             Executable code
> + * @text_offset:       Image load offset (little endian)
> + * @image_size:                Effective Image size (little endian)
> + * @flags:             kernel flags (little endian)
> + * @version:           version
> + * @res1:              reserved
> + * @res2:              reserved
> + * @magic:             Magic number (RISC-V specific; deprecated)
> + * @magic2:            Magic number 2 (to match the ARM64 'magic' field =
pos)
> + * @res3:              reserved (will be used for PE COFF offset)
> + */
> +
> +struct riscv_image_header {
> +       u32 code0;
> +       u32 code1;
> +       __le64 text_offset;
> +       __le64 image_size;
> +       __le64 flags;
> +       u32 version;
> +       u32 res1;
> +       u64 res2;
> +       u64 magic;
> +       u32 magic2;
> +       u32 res3;
> +};
> +
> +#endif /* __ASM_IMAGE_H */
> diff --git a/riscv/kvm.c b/riscv/kvm.c
> index 1d494792de79..fc192af34435 100644
> --- a/riscv/kvm.c
> +++ b/riscv/kvm.c
> @@ -4,9 +4,11 @@
>  #include "kvm/virtio-console.h"
>  #include "kvm/fdt.h"
>
> +#include <linux/byteorder.h>
>  #include <linux/kernel.h>
>  #include <linux/kvm.h>
>  #include <linux/sizes.h>
> +#include <asm/image.h>
>
>  struct kvm_ext kvm_req_ext[] =3D {
>         { DEFINE_KVM_EXT(KVM_CAP_ONE_REG) },
> @@ -100,6 +102,22 @@ void kvm__arch_init(struct kvm *kvm)
>         riscv__irqchip_create(kvm);
>  }
>
> +/*
> + * The kernel's memory footprint, including BSS, is the image_size in th=
e
> + * Image header, which may be larger than the file.
> + */
> +static u64 kvm__arch_get_kernel_size(void *kernel, ssize_t file_size)
> +{
> +       struct riscv_image_header *hdr =3D kernel;
> +
> +       if ((size_t)file_size < sizeof(*hdr) ||
> +           (memcmp(&hdr->magic2, RISCV_IMAGE_MAGIC2, sizeof(hdr->magic2)=
) &&
> +            memcmp(&hdr->magic, RISCV_IMAGE_MAGIC, sizeof(hdr->magic))))
> +               return file_size;
> +
> +       return max_t(u64, le64_to_cpu(hdr->image_size), file_size);
> +}
> +
>  #define FDT_ALIGN      SZ_4M
>  #define INITRD_ALIGN   8
>  bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_=
initrd,
> @@ -108,6 +126,7 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int=
 fd_kernel, int fd_initrd,
>         void *pos, *kernel_end, *limit;
>         unsigned long guest_addr, kernel_offset;
>         ssize_t file_size;
> +       u64 kernel_size;
>
>         /*
>          * Linux requires the initrd and dtb to be mapped inside lowmem,
> @@ -132,9 +151,10 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, in=
t fd_kernel, int fd_initrd,
>
>                 die_perror("kernel read");
>         }
> -       kernel_end =3D pos + file_size;
> -       pr_debug("Loaded kernel to 0x%llx (%zd bytes)",
> -                kvm->arch.kern_guest_start, file_size);
> +       kernel_size =3D kvm__arch_get_kernel_size(pos, file_size);
> +       kernel_end =3D pos + kernel_size;
> +       pr_debug("Loaded kernel to 0x%llx (%zd bytes, %llu in memory)",
> +                kvm->arch.kern_guest_start, file_size, kernel_size);
>
>         /* Place FDT just after kernel at FDT_ALIGN address */
>         pos =3D kernel_end + FDT_ALIGN;
> --
> 2.56.0
>
