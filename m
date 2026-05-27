Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A303E92BF
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899715; cv=none; b=ouej1uYmgnOPz0QaYrW4wymP/JrQQNFVbILvO5gLcnINkraqYdK7IfIOU+uDjH0UpKKJoHS5xvhqSBON5Y789dHxRr3ItUyFwtWHolKBW8TsEL4cPqP9LxOJfnSjPg0vFQRVoUFm2xpkK7vohO8BykVEQsM9GMlm6/bdz7Tx2XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899715; c=relaxed/simple;
	bh=QDw8Jsuw+6AP8iu7lgfzYciOXYThi6tQVsbGIJHSjOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rd1qzQpc91x8A2rxkhsps56Bn/VPFQ2l+h2pzeZ8KeVeFM1KdwtE6VxACtXt1G87OsqbpbLNVAGZNUHPuwyPDKD7574CDn9xwuK5m8xfg1aHWrinILahwfCeFPgjq65xblR7QXnSdXqUfeJtZ3QdsDLGfz2EbLzWGQ+M/Dogk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OljyIpPW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ffNUjPE9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OljyIpPW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ffNUjPE9"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RG0bYK2152267
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 16:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3o/qC8F03FVtWvVL+To0ZZ8G
	ZQPvSZaDhCCbgVrIpSk=; b=OljyIpPW1Bpt0pM8Vh+sEa5MvLEqha4zmw6RCVwi
	21zDtiVA67hiZVBT63mzSLd71m798KJCmzz7Cb31jIh2FIDkxXrBHMc+l5sB4RtO
	UYUoKMTW1TJERhd310gbTIiI2uTZcazPB+oOedZ94Kl0yN3mjmPOXQEB0C2vw/zP
	ThGhorK1HP6NZB7dpThJKIS2iW3vQ03ZPDC7smO/GG2cAKAmJWEv7QY7Rw2MZKqO
	JA1vqLu7t+k6/9LibvGr+YjcCi92vj1FS/gHIbDNmIZfeJ9qUc/E8pwXycGG+sgH
	TvEovUyhF434EdvWvxzbGJ/vrcaUENG6/J9vpRGIMb6NYQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edu6rjc8y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 16:35:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so1243982eec.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779899711; x=1780504511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3o/qC8F03FVtWvVL+To0ZZ8GZQPvSZaDhCCbgVrIpSk=;
        b=ffNUjPE9FhYa2qVY+gJUSEGVFWJYmdXpNGEYQFS6gUBsjeBwiD6GenczwtveRJEnHQ
         3fnZnBPCvjvUCP4EOkBgwXt6j9mOMaDi5Oj5s+C2TVogehlAzx7DONsY3kCHOKpT+Z+T
         QtX0Wn97EA0fnblwgKVbPqRUWLLIULaM9pJpJTlJ8LHqVPs+gL5ZmdYV48YqM1CAfmwj
         BliJMi5PdYXTTtssWujaOajJN96rsZ82YjjqGukrpTUsBpdQZXj2wBPzki9GUz+E473Y
         5H/v3TChGl+6aBSs4c6rTXk1Nd8KZLly62EwN9BoRJvWWUe3EfD7P/9G6MGUvyaHazxg
         toCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779899711; x=1780504511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o/qC8F03FVtWvVL+To0ZZ8GZQPvSZaDhCCbgVrIpSk=;
        b=nvwGS5eaLVrEYdNbYbU1Z3lzsBreODt8dDYv/PJWJBOH6S+LU+wHc5dxPIGgAHSNEM
         QV0ha2jXR3yScJiYJ1sbQiYSqwsiPgqii9Vn587/eEVmQG46Yw0DERE+RcpUUaN8m0HE
         dccAAGsZ8qnT9tuNsG8I37qrqznq+xmwA6cPTHWyJFEfFkrqMw52NnmUXG6DlA5eTySw
         Wy+8O2D7fd35YbogzAbWufax9DnYpKnplhUVWtUfD87gIYLJKevvEWMSwDovgKQBwUJX
         RYVLYdma1+onxsIcFPvI4ID05zgkKENwSpDlZzsXVMKvGtsBPXIWyFao1zzWhAP4jsyb
         BMJA==
X-Forwarded-Encrypted: i=1; AFNElJ8YAERzc4eS7hzJvJLrKZB/w7xZjNioD6LT8wK7Kd8cC1jUWbt6TyjcaSg36b+y8HoKKFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxchLCVtxCVJyvG3tgpRSP++lfHIJi6K8vashUiofsob8FKKxY3
	/ed/jJDkScFn6BoZ6SdvBv/tg0EzSwoFZcVH0QMEKqLOz3YMt+8/bGILnDqM7VYsyQVYAwcN9ir
	vG2nMYHY1PS1i8fIcOcmRuzYf3f6GZ8jpI6VE4GjgfQb90M1p1KV4Ym0=
X-Gm-Gg: Acq92OFMjIs3UR5eDiUfgiXiz8y8x0RqOKNQavHDA3veBqFHlg4QZgOQkCmNhV0MJrZ
	CFRgMhepX9k/rWubjTXqkdY2RTy4zQSme41lCRNnwe4ud5Xa5iacttQ1PcA/tRlT/nu4LENquGy
	Ra28AU+eAcOhX15ox6fQNHoacetw5kUtKrhVyPDLWrHSqSkJHFewYJT0Q3P/7KS+tBURXOfYyrm
	i1MMoMduP1F75Ig6K/H7nve79T78Xq110NuPILGoYIwAhybw5bdQ0IU4TTvyrGE/oIvdiHSTnYE
	Rsy0rIDN+6GcYs5eSHxvRvArKfzyqbSpCAkOFHdCisae6mVB3FIbCKD+2MV+JbHnI+ePNJOYIu9
	kkf5wC2kn8V1IrafEnQe5dywPa/2VeYw=
X-Received: by 2002:a05:7022:fe09:b0:134:ff2e:a71c with SMTP id a92af1059eb24-1365f600b14mr8303630c88.9.1779899710836;
        Wed, 27 May 2026 09:35:10 -0700 (PDT)
X-Received: by 2002:a05:7022:fe09:b0:134:ff2e:a71c with SMTP id a92af1059eb24-1365f600b14mr8303599c88.9.1779899710070;
        Wed, 27 May 2026 09:35:10 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aba2b9asm13381153c88.15.2026.05.27.09.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:35:09 -0700 (PDT)
Date: Wed, 27 May 2026 11:35:08 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Guodong Xu <guodong@riscstar.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Deepak Gupta <debug@rivosinc.com>, Zong Li <zong.li@sifive.com>,
        Christian Brauner <brauner@kernel.org>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Samuel Holland <samuel.holland@sifive.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 08/10] riscv: cpufeature: Introduce ISA bases bitmap
 and rva23u64 detection
Message-ID: <5tjmypgyxbhgxfjub5q6ne475uysse6yl473sxisjoammkdvbu@yebejqbiy6e3>
References: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com>
 <20260511-rva23u64-hwprobe-v2-v2-8-21c5a544f1dc@riscstar.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-rva23u64-hwprobe-v2-v2-8-21c5a544f1dc@riscstar.com>
X-Authority-Analysis: v=2.4 cv=MoJiLWae c=1 sm=1 tr=0 ts=6a171d3f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=c92rfblmAAAA:8 a=ee_2aqc6AAAA:8 a=EUspDBNiAAAA:8 a=4F2392DG074ZRd-8RbwA:9
 a=CjuIK1q_8ugA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE2NiBTYWx0ZWRfX5Sa6x6fQZFTL
 XmWOjFFsnRs7/7CSG0NR5vartCgxg9F0TqAADEYlglzYoCbjZ1gjQhK5xf2Vikmsgp7eds3ZPps
 0LxhiWGwxEVNDjjx1oiQgudMH0WqYO+7Q53rCS6AY/imU4hIVAWWc2dNo3Eeu5f7DKycIkPa2OO
 03N6dJiUJCjJU1MKDATLf6rAlAUXT4xMN8AwdYMBlfUCvKoUqVZi1G+snRH8ixhpVTJ2NZj/b3z
 1NwIF/ItOZB3e3/FQsWh8ANJStEL8B22cIcRi9NxqEsI/7Sx/HO2206LPNs1tkcrLdYg3GjATZD
 Z1+CeJKMDi5pSJTBZ+UhKCUgFQSIUA1gKoVJueD0cV43xgp6IvLXgI8tOIk+OMf7wAzyDLWN9Aa
 6uPWSnrmD8riw7J7LbN8DYxkKVJYoOMozc0piHridTfPf1ctranBtvwn40rQwTr5BB3SaIMNErN
 WXhrLXGYZounGaoVIUQ==
X-Proofpoint-GUID: GSBNHYF4I5HSFfa3LaKWE2ggr3wVBzmp
X-Proofpoint-ORIG-GUID: GSBNHYF4I5HSFfa3LaKWE2ggr3wVBzmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270166

On Mon, May 11, 2026 at 09:34:53PM -0400, Guodong Xu wrote:
> Introduce a per-hart and host-wide bitmap of conformant ISA "bases" --
> named profile-class sets such as IMA and RVA23U64 -- and compute
> both at init time.
> 
> This is the cache that subsequent consumers (hwprobe's
> RVA23U64 base behavior bit, /proc/cpuinfo's "isa bases" lines, etc.)
> read without recomputing.
> 
> riscv_init_isa_bases() iterates over all possible cpus to populate
> each hart_isa[cpu].isa_bases, then computes the host-wide
> riscv_isa_bases against the AND-across-harts riscv_isa bitmap.  It is
> registered as a subsys_initcall so it executes after
> core_initcall(tagged_addr_init), which probes senvcfg.PMM and
> populates have_user_pmlen_*.  Without that ordering,
> riscv_have_user_pmlen(7) would still return its default false and the
> RVA23U64 detection path would always bail.
> 
> The detection itself is encapsulated in riscv_set_isa_bases(), which
> takes an output bases bitmap and an input ISA bitmap.
> 
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v2:
> - Implement riscv_init_isa_bases() that runs at system init time,
>   after tagged_addr_init() populates have_user_pmlen_*.
> - Split RVA23S64 placeholder into a future patch.
> ---
>  arch/riscv/include/asm/cpufeature.h | 14 ++++++
>  arch/riscv/kernel/cpufeature.c      | 92 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)

Sashiko points out a few things about this patch which I think I
agree with

https://sashiko.dev/#/patchset/20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc%40riscstar.com?part=8

Additional nit below.

> 
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 739fcc84bf7b2..facc31b2960c6 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -25,10 +25,24 @@ struct riscv_cpuinfo {
>  	unsigned long mimpid;
>  };
>  
> +enum {
> +	RISCV_ISA_BASE_IMA,
> +	RISCV_ISA_BASE_RVA23U64,
> +	RISCV_NR_ISA_BASES,
> +};
> +
> +/**
> + * struct riscv_isainfo - per-hart ISA state
> + * @isa: bitmap of ISA extensions this hart implements
> + * @isa_bases: bitmap of profile bases this hart conforms to
> + */
>  struct riscv_isainfo {
>  	DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
> +	DECLARE_BITMAP(isa_bases, RISCV_NR_ISA_BASES);
>  };
>  
> +extern unsigned long riscv_isa_bases[BITS_TO_LONGS(RISCV_NR_ISA_BASES)];
> +
>  DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
>  
>  extern const struct seq_operations cpuinfo_op;
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 81145621dc378..6e8dd33aa3888 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -41,6 +41,9 @@ unsigned long elf_hwcap __read_mostly;
>  /* Host ISA bitmap */
>  static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>  
> +/* Host ISA bases bitmap */
> +DECLARE_BITMAP(riscv_isa_bases, RISCV_NR_ISA_BASES) __read_mostly;
> +
>  /* Per-cpu ISA extensions. */
>  struct riscv_isainfo hart_isa[NR_CPUS];
>  
> @@ -1305,3 +1308,92 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
>  	}
>  }
>  #endif
> +
> +/*
> + * Compute the set of profile bases (IMA, RVA23U64, ...) a hart
> + * conforms to, given its resolved ISA bitmap.
> + *
> + * If @isa_bitmap is NULL, the host ISA bitmap (the AND across all harts) is
> + * used.
> + */
> +static void riscv_set_isa_bases(unsigned long *bases, const unsigned long *isa_bitmap)
> +{
> +	const unsigned long *isa = isa_bitmap ? isa_bitmap : riscv_isa;
> +	DECLARE_BITMAP(ext_mask, RISCV_ISA_EXT_MAX) = { 0 };
> +	DECLARE_BITMAP(tmp, RISCV_ISA_EXT_MAX);
> +
> +	/* IMA */
> +	set_bit(RISCV_ISA_EXT_I, ext_mask);
> +	set_bit(RISCV_ISA_EXT_M, ext_mask);
> +	set_bit(RISCV_ISA_EXT_A, ext_mask);
> +
> +	if (bitmap_andnot(tmp, ext_mask, isa, RISCV_ISA_EXT_MAX))
> +		return;
> +
> +	set_bit(RISCV_ISA_BASE_IMA, bases);
> +
> +	/* RVA23U64 */
> +
> +	/* Zic64b and Supm with PMLEN=7 */
> +	if (riscv_cbom_block_size != 64 ||
> +	    riscv_cbop_block_size != 64 ||
> +	    riscv_cboz_block_size != 64 ||
> +	    !riscv_have_user_pmlen(7))
> +		return;
> +
> +	set_bit(RISCV_ISA_EXT_F, ext_mask);
> +	set_bit(RISCV_ISA_EXT_D, ext_mask);
> +	set_bit(RISCV_ISA_EXT_C, ext_mask);
> +	set_bit(RISCV_ISA_EXT_B, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZICSR, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZICNTR, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZIHPM, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZICCIF, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZICCRSE, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZICCAMOA, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZICCLSM, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZA64RS, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZIHINTPAUSE, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZICBOM, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZICBOP, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZICBOZ, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZFHMIN, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZKT, ext_mask);
> +	set_bit(RISCV_ISA_EXT_V, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZVFHMIN, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZVBB, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZVKT, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZIHINTNTL, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZICOND, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZIMOP, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZCMOP, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZCB, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZFA, ext_mask);
> +	set_bit(RISCV_ISA_EXT_ZAWRS, ext_mask);
> +	set_bit(RISCV_ISA_EXT_SUPM, ext_mask);
> +
> +	if (bitmap_andnot(tmp, ext_mask, isa, RISCV_ISA_EXT_MAX))
> +		return;
> +
> +	set_bit(RISCV_ISA_BASE_RVA23U64, bases);
> +}
> +
> +/*
> + * Populate the host ISA bases bitmap (riscv_isa_bases) and each
> + * hart's per-cpu isa_bases.
> + */
> +static int __init riscv_init_isa_bases(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		riscv_set_isa_bases(hart_isa[cpu].isa_bases, hart_isa[cpu].isa);
> +
> +	riscv_set_isa_bases(riscv_isa_bases, NULL);
> +	return 0;
> +}

Missing blank line here.

Thanks,
drew

> +/*
> + * Registered as subsys_initcall so it runs after
> + * core_initcall(tagged_addr_init) populates have_user_pmlen_*.
> + */
> +subsys_initcall(riscv_init_isa_bases);
> 
> -- 
> 2.43.0
> 
