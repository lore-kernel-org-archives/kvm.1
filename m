Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794570966;
	b=n6oFNtyIccs5N/O1+N6TpzYVDTWuGTLGMCmA4ITZJn4dVn1YAsyWHyMdXiFlmm1uf6z7
	 vQgk49YfKvBV9wYxM6D6796Ct4dA40I+qtGzFD0n3/guo/qP7fy5pzJTTGlKZizKMO4PN
	 9SIK3O//zaL0T/CgTuAboSRtVfA25P+K1p/WyWPyEEvpqlbWFveM3QGRQUwLb3MfZK6No
	 ROupHBTuMfu9BjSicrGEYeeSbJw3hTKkuK/iDd8ar6QuphOHU++xp9mkHxYGukfdBfm6T
	 98f+UiGT20rhDIZRf1QaYQCID5i/kL8xWEucmYlyYlSLoW7OaioLOIiH4/k+9/sXcXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iQQDL3pYNGN1ebIB9amik4UbHY4EdHlPUDp6txsCFwE=;
	b=xmKQGjvM9Rg4pUWOBauU1GF2gO3JSubuZsuXQZyPz5JIQUeqfHY2exc6qONibWWe/h6a
	 tWaKVUHi6ntH85jXz+A6Kh8fM2lJYklqrL8oTBuJUJIcypzDkhneezzbKc2B2MvQZIB30
	 0xhZnQwjjvITDrQqlK8QLqzpQg6neD3hflr7cBbJwzY1YCejRgRBFVpEsAflRogJSHulp
	 Mo/ee7aBGTwbtJ2pLSQnZX1KLanVKNyCAaD0sp8Mt8b0MVk8U6BQLgAbilYVUqIQUBF87
	 Vb50LXJf3J3D6nEHJWwrX9vCsuzNBPJf6F7zkUSAddQpOJPOo78+6UO0Isu10qHS2yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=f48kRXZH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEE0606A32A
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 11:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BEE0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=f48kRXZH
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so362156f8f.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 03:56:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794570964; cv=none;
        d=google.com; s=arc-20260327;
        b=mdvi38hcPziyvL8/fFImkS6m0di27HIKZ+qGifnLgRf+QNA5QlVjVsRgfOnxZAttLC
         BVPqR1e7Zkqz6Wn5+IbEwBPUiPTdaeC7dM3vEqSmF5aW9a1HU5U5HRPFaZ7ZisUpFKAr
         UPc2erZI8J/QFWERYSQzv63kneE1frZlARDBj9UMljA8zKbDSB/sebRMSGLVdat3Q7/G
         iLWFGneCjDnqSMujb7APYSxyN3kt7iJCP8TClbjMG/jrCc0nfzcF9g2zgQiqtcYgUzut
         yL3cnJxg6S3n9htHspsWOUIwBJ1zrsYgYAQqrFYrdu9OfsypWhWKKaZoFEmWDhU3rSBB
         g96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iQQDL3pYNGN1ebIB9amik4UbHY4EdHlPUDp6txsCFwE=;
        fh=h16DG5TL6bYnNB0fBmrmitbERaVMzOTqpTvnK0hzoa0=;
        b=m9CUuklTh6jn59om5/16FTgV/njJzbbPYfWyDQwuUbzhGx4JjsngijmNvYTvANUuqe
         CoP2PM7gcw3g0/hIsGyeZmhCn1y0TfrphtP7LUvum5mup+SJcQuyX1g0CUa1mrVvc1f1
         sY+Oa63DZUR47p83MLchul2nAivm6rhQUsNqiyimPNndqRmViLP8mVUXUbCZNubF4tHZ
         MKjKHn8gQNE9QdLKq5rX3E5UmiYtmSGdAO+1gfL4y0jioIAzaRqFSOhFx+SRw8LzjP7a
         sQt48vJ/wQmGGzyYw3Iwmrh8q8bvFMdK6uB8WjGcdi1D+CK/FOt8zdQSyTP8jT4ZVLFO
         aP7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794570964; x=1795175764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iQQDL3pYNGN1ebIB9amik4UbHY4EdHlPUDp6txsCFwE=;
        b=f48kRXZHXYBn4L48TN2tsgLPZWk8qzrvRVT6MeXoqP3QK1xlFg2NdFsdBUrmw8XMDR
         vSqP983TZv0wgkKdrdC9vvGarZu6VnjnegJuOK3wiULXZRDkZ3go0KvTe54P9KJ0v+G7
         ixYOziGE4lRfXdBfeQxvJttM9bLP6es5pVd46xWkSCqQyfwDhyBBqSbo5gEiub7njuz2
         i3bom90Sh0mur8w0CAJgu2Evci2ZirbPWoOPPop/tY3F5CU0ConnkKFCtL9MvRK0c2QO
         TZ2hU8JdXExZ44qmN15VCeAYXb4ZYuMTo8oo/m3DvFAgUWEkrRUI+2UCI5OZTpmxrvZ8
         I06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794570964; x=1795175764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQQDL3pYNGN1ebIB9amik4UbHY4EdHlPUDp6txsCFwE=;
        b=sxOmqbz9I7+OHhwr3FrKcx0fD+cEZSdRgHmNDNvaSG7FION6/r8uJz2J8plN16t3Wz
         D0DKQqouaON9nXCftnbg0z+D4cO2dp/UA1eR/5eiHcubMkkTwY/wfpVgSUT9QoSq+w3O
         qOp11he+wkQtOlGayjHChFJYnBFcLnT0TSlpTsQWP6HlbBDxMudMJzvWsNjt4ugV2Fma
         htMWA+YGfjlaRfvLTMA4P1YDbKjuWdXCwRbfiawRa52iW0VvOefhlV94zKjW+/7RZIMU
         N0l2KN27k3iEb48yLC0Wbeoc8ItvjHGXa4C1xgaK8eU6aQ9il04nS2O04AvPu817pIfw
         xgFg==
X-Forwarded-Encrypted: i=1; AL+hErHgd5X9FbwI+B4+OXP2Ag/yARUWHC8F8UBrxPJPfhQ9Aiu1Y+Cii+Wyp26qg7nlNI9/Mt4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Nvs5J9DrypOPZXiMJZRpM0RnQoFGpd+0pv0/P1EWs2dLxB7kb
	tYJqkQ0c+2/SYQJR+uTTFn3juCQqKLZVZ5DKcOUzNi9jPB1pZjNSs8Ili3YIOcocyWsIEAkpfIF
	BzZ2M27nhqOUf93/vDA5oHqUfahp9ZZhFP76cgxXmVQ==
X-Gm-Gg: AYBFou36h1Fz69wKMv6fj00TLua13dH28Wv6kymrdLKBsgVafs8UveF4D/3nVRm9c13
	Y2XBJAAxpi3NMu6fEvEe74zB8SrrGSWfx+gfYuRL/vmZmybCQvssubYEe7AXy0U1oOjwScbddO/
	H2L2uG1RJOQPH/6eRCAsPQjyUC5Z91a6PF2pkJmihNkJPbxhKhmBShKPRVRZb32ajZlutF4RcQt
	5NvQnTh3lPyH0z1OSw3qrIFfZnYGyBcW9j1m4HRJJLHzp/jBC60jENiuwe0JbXqa8CFiljW50+F
	tNDAb4qTKVyGUa5ge2iAACSitNEwousa8s+c/7KvhDVm7Tjw7KXg3hq5oWlzf3hT68sYgYAhuc6
	2HgRTgdB8rDgb6Ug2VvOt9HTifvtoWdY+RdmAxypDuZ/vqtTlz184VG9/BwthCqgAOjY4b0d/kN
	p++qMYEWigEORVnGspAh1EOLjawVslbLxxaYXBR7dix/b5DoLgkmVFn6o=
X-Received: by 2002:a05:6000:184d:b0:48e:e98:8b64 with SMTP id
 ffacd0b85a97d-49c70ed94d3mr5665274f8f.19.1794570964467; Fri, 13 Nov 2026
 03:56:04 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028190531.48302-1-mikatammi@gmail.com>
In-Reply-To: <20261028190531.48302-1-mikatammi@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 17:25:53 +0530
X-Gm-Features: AclHuK-4iNBUWXSJCnX1Ef0NFWzcQb-T2Pd21cO1oNlOHRmmN8PuRx7zLiPDtnY
Message-ID: <CAAhSdy2fp-JBor--AhNoLzpjjis_wopPY4ZTRpEvABu0SHvzsw@mail.gmail.com>
Subject: Re: [PATCH kvmtool] riscv, arm64, powerpc: Align the FDT staging
 buffer to 8 bytes
To: Mika Tammi <mikatammi@gmail.com>
Cc: Will Deacon <will@kernel.org>, Julien Thierry <julien.thierry.kdev@gmail.com>, kvm@vger.kernel.org, 
	Anup Patel <apatel@ventanamicro.com>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:47=E2=80=AFAM Mika Tammi <mikatammi@gmail.com> w=
rote:
>
> setup_fdt() creates the guest's device tree in staging_fdt, a u8 array
> on the stack, and then copies it into guest memory with fdt_open_into().
>
> The Devicetree Specification requires the blob to be at an 8-byte
> aligned address [1], and libfdt has checked this since dtc v1.6.1:
> fdt_ro_probe_() fails with -FDT_ERR_ALIGNMENT for any other address.
> The sequential-write functions don't call it, so the tree is created
> without errors and fdt_open_into() is the first call to fail.
>
> A u8 array has no alignment requirement beyond its element type, so
> whether staging_fdt is 8-byte aligned depends on how the compiler lays
> out the stack frame. In lkvm built for 32-bit RISC-V with GCC 15 and
> musl, it isn't, and lkvm fails every time:
>
>   Fatal: Error creating device tree: fdt_open_into(fdt, fdt_dest, FDT_MAX=
_SIZE): FDT_ERR_ALIGNMENT
>
> arm64 and powerpc create their device trees the same way. Nothing
> guarantees the alignment there either, though it hasn't been seen to
> fail.
>
> Ask the compiler for the alignment that the specification requires.
>
> [1] Devicetree Specification v0.4, section 5.6 "Alignment": "The
>     devicetree blob shall be located at an 8-byte-aligned address."
>     https://github.com/devicetree-org/devicetree-specification/releases/d=
ownload/v0.4/devicetree-specification-v0.4.pdf
>
> Fixes: 7c9aac003925 ("riscv: Generate FDT at runtime for Guest/VM")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mika Tammi <mikatammi@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
> I used Claude Opus 5.5 to track down the failure, write this patch
> and its description, and run the tests below; I have reviewed the
> result.
>
> Tested with QEMU rv32 and rv64 machines with the H extension as KVM
> hosts, running a guest with lkvm built with GCC 15.3, musl 1.2.5 and
> libfdt 1.7.2. Without this patch, lkvm on rv32 fails with the error
> above; with it, the guest boots on both. Build-tested for x86_64,
> arm64, riscv64 and ppc64le.
>
>  arm64/fdt.c   | 2 +-
>  powerpc/kvm.c | 2 +-
>  riscv/fdt.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arm64/fdt.c b/arm64/fdt.c
> index 3cbd36e..ec83caa 100644
> --- a/arm64/fdt.c
> +++ b/arm64/fdt.c
> @@ -115,7 +115,7 @@ static struct psci_fns psci_0_2_aarch64_fns =3D {
>  static int setup_fdt(struct kvm *kvm)
>  {
>         struct device_header *dev_hdr;
> -       u8 staging_fdt[FDT_MAX_SIZE];
> +       u8 staging_fdt[FDT_MAX_SIZE] __attribute__((aligned(8)));
>         u64 resv_mem_prop, mem_reg_prop[] =3D {
>                 cpu_to_fdt64(kvm->arch.memory_guest_start),
>                 cpu_to_fdt64(kvm->ram_size),
> diff --git a/powerpc/kvm.c b/powerpc/kvm.c
> index 7b0d066..fb374dd 100644
> --- a/powerpc/kvm.c
> +++ b/powerpc/kvm.c
> @@ -296,7 +296,7 @@ static int setup_fdt(struct kvm *kvm)
>                 "hcall-splpar\0hcall-bulk\0hcall-set-mode";
>         int             i, j;
>         char            cpu_name[30];
> -       u8              staging_fdt[FDT_MAX_SIZE];
> +       u8              staging_fdt[FDT_MAX_SIZE] __attribute__((aligned(=
8)));
>         struct cpu_info *cpu_info =3D find_cpu_info(kvm);
>         struct fdt_prop segment_page_sizes;
>         u32 segment_sizes_1T[] =3D {cpu_to_be32(0x1c), cpu_to_be32(0x28),=
 0xffffffff, 0xffffffff};
> diff --git a/riscv/fdt.c b/riscv/fdt.c
> index 1eb45fc..4a2c456 100644
> --- a/riscv/fdt.c
> +++ b/riscv/fdt.c
> @@ -341,7 +341,7 @@ static void generate_cpu_nodes(void *fdt, struct kvm =
*kvm)
>  static int setup_fdt(struct kvm *kvm)
>  {
>         struct device_header *dev_hdr;
> -       u8 staging_fdt[FDT_MAX_SIZE];
> +       u8 staging_fdt[FDT_MAX_SIZE] __attribute__((aligned(8)));
>         u64 mem_reg_prop[]      =3D {
>                 cpu_to_fdt64(kvm->arch.memory_guest_start),
>                 cpu_to_fdt64(kvm->ram_size),
> --
> 2.54.0 (Apple Git-157)
>
>
