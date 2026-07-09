Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F5E3ABD8E
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578208; cv=none; b=GIuv1ZHGHgSEbkHuJRcgk76Htov28QdqLb23NWzDk4HSaqOBzUv/aTP7Ad5fjRUULZ8J/LBr0lIeEOyaQPVRcegsLeziMzynGeG3GtQATEDKGWyQOWBI/ln4IpsQTZdvIKR5lt54UMqAgYdJ89D4NU75HDxkszr9VFVCj/3oa6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578208; c=relaxed/simple;
	bh=6k6AH65VQcAuAOD73lLD7Vqip7/izHhjjVD41X/BMAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjEy1yQgq8srzPlfY/uStSNuqjowXLLjh1UVeTXmfkDE2p/F1w7UKEnnAQo6JhRt0cOm9D4tS83gRMNNt0IhivFt9e8WD68ZpK634JXI76sftO7fdHLN/i8VYS9YlK4yPYOLM1soUQ/+tk1nq/ofn49w160WzrGRyqsz3pjxzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIRZCWAE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIRZCWAE"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc8e87f29bso12369315ad.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 23:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783578204; x=1784183004; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mGK5PpdkeG1tH+ZhJlo9owU3s33aNVf8/NpUKSn1gO4=;
        b=CIRZCWAEDZKxY4BeGZpSdPNKq4CiCba06fWDje+1YXrPjdFxlCXYjxdXPrXj8nlcTl
         N1W1ehejd8DLwNq8ZzXz4mzyeP5oyjvjLI/eqeFqPsuftP+vftqqafxEZm/teqEjgq31
         WWCKXXaNh/OygEay7aeK+y3WeNKLzfvEYvwKzC4KMYu3yBnf94OLQjbaFpmjxiN6aMIG
         cNwPBde3mlwGyKOZ+IaY9Umm+T70cahXJm3MtyOHEy6MGE0sC/zgDTRcuqp7FrrI447Q
         U/dj2BzxIrjodV4ey8obwByD1x8J0CiKsyAGn+1HWaAtK7wUYHg4mjO+6ncOuSkdjFMY
         /1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578204; x=1784183004;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mGK5PpdkeG1tH+ZhJlo9owU3s33aNVf8/NpUKSn1gO4=;
        b=U82VU21pvS4oeBunmXB2GoM46IB5sBIOHbjtA40SqFL0bBUjbaCCanxDOj3jA+CuCq
         jQx7sDOYOdYEK/eu4v65U/e/ZxXqY7yR4+IVFuV+m67zUCtiPqiGMRPt3vPYKov05bqY
         dqz2spU2/xjdPHXvTiJJWFQo6CIXn4OUbPqjZKKpCiWUqnO/1bV27ye9TSS4eeVHD2ZP
         vC8HAiVVHFBzu6v4PDAx1x/zua/lClHzMLaSmybfIQ8oDgYj4t+zDFZUH4B7Z6bYyyIy
         5pEZ3wL641V2MpWTYapzCddJaWkUEzlTegl0QH7HU3M+6NuofegmmPP80e1tWkydfpdI
         GR6A==
X-Gm-Message-State: AOJu0YwgqmZWxw/YeoKBAjXjpGlWrJVsdp0F31gG4VDcNmIveaJKRzwI
	n5pDAreFeFoLY1xCP08cKpcYoYNxuMu9WBM/j8adiILmfwnD0vf3fVn6
X-Gm-Gg: AfdE7clJs0J5jW5ksf9t3c48zhbQ2cPv0/tztJbNhz6tXsdAbscss00dhdtWSqZKbMv
	eSOIBuDAinaJFjg5rPkxDinXy7LDoeRIJ1zSHOoqLdbdgatiehaEPzl7DYFJVjBKWv5y1lM8K2S
	9WlDWU/uGQtIl/Cjrt5O3XqhPnELDR5opQufdugowGvw1omeVbr8qt/OcN6aNXF2yS09rNZpIbr
	cVKw09HB1Wot/m+6wd2cAudXlADLCgD+Mey21952vtoYC0QHu7D5NsQTV0xBFHecYR0OaIpcWMX
	6pjlTwNiF7XqcHUVIDiLHIISidNWdDC6q5CwPTZ9+rUdt5f+eDJ1CgnVxmeJbHXU3EVma0tp8Yh
	z3oMaOyx7FOI5Ln64i/WgJ23El+I7ZkqOTDIlTlO15WWvK3a95hoDoUYcb6Zh+4rgXrssb26qU+
	K0H1x+3VNKHk4e2+zblY19FxN8FsTqGcFPng==
X-Received: by 2002:a17:902:ea06:b0:2c9:d277:2cdd with SMTP id d9443c01a7336-2ccea2f910fmr61268075ad.13.1783578203614;
        Wed, 08 Jul 2026 23:23:23 -0700 (PDT)
Received: from blinky ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1eea1sm38618355ad.46.2026.07.08.23.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:23:22 -0700 (PDT)
Date: Wed, 8 Jul 2026 23:23:20 -0700
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v3 01/17] riscv: Introduce instruction table generation
Message-ID: <ak8-WCPFEGGvLubX@blinky>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-1-3f8e5f75ba97@gmail.com>
 <20260708035048.535251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708035048.535251F000E9@smtp.kernel.org>

On Wed, Jul 08, 2026 at 03:50:47AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Zcmp compressed instructions (e.g., `cm.*`) are incorrectly generated with 32-bit sizes instead of 16-bit.
> - [Low] Unsupported instruction extraction stubs lack a return statement, causing `-Wreturn-type` build errors.
> --
> 
> --- Patch [1]: [PATCH v3 01/17] riscv: Introduce instruction table generation ---
> commit 893d119e65d6edd9ce9e98809ffad3450c8d6a8f
> Author: Charlie Jenkins <thecharlesjenkins@gmail.com>
> 
> riscv: Introduce instruction table generation
> 
> This commit introduces a shell script to auto-generate a header from an
> instruction table for RISC-V. It aims to replace hand-written instruction
> macros.
> 
> Link: https://github.com/riscv-software-src/riscv-unified-db
> 
> > diff --git a/arch/riscv/tools/insn_tbl.sh b/arch/riscv/tools/insn_tbl.sh
> > new file mode 100755
> > index 0000000000000..f09b93951cde5
> > --- /dev/null
> > +++ b/arch/riscv/tools/insn_tbl.sh
> > @@ -0,0 +1,258 @@
> 
> [ ... ]
> 
> > +        non_compressed_insn=${name##c.*}
> > +        invalid_inst_functions=""
> > +        variable_params=""
> > +        constraints=""
> > +        match=""
> > +        mask=""
> > +        make=""
> > +
> > +        # All compressed instructions start with "c."
> > +        size=${non_compressed_insn:+32};
> > +        size=${size:-16};
> 
> [Severity: Medium]
> Will this correctly identify Zcmp compressed instructions like cm.pop?
> 
> Since they start with "cm." instead of "c.", the glob pattern c.* won't
> match them, assigning them a 32-bit size instead of a 16-bit size. Could this
> cause the generated insert and extract helpers to wrongly expect u32 *
> instead of u16 *?

I'll make it check for "cm.*" as well. It looks like "cm.*" is the only
other possiblity but there are some names like "czero." and "cbo." that
prevent me changing this to matching on "c*.*".

> 
> [ ... ]
> 
> > +            printf "static __always_inline void riscv_insn_${formatted_inst_name}_insert_${variable_name}(u${size} *${insn}, ${type}32 ${var})\n"
> > +            printf "{\n"
> > +            printf "\t*_insn &= ${insert_mask# & };\n"
> > +            printf "\t*_insn |= ${insert# | };\n"
> > +            printf "}\n"
> > +
> > +            if [ "${only_base}" ]; then
> > +                invalid_inst_functions="${invalid_inst_functions}static __always_inline ${type}${size} riscv_insn_${formatted_inst_name}_extract_${variable_name}(u${size} ${insn}) {\n\tBUILD_BUG_ON_MSG(1, \"${name} is not supported on non ${only_base}-bit systems.\");\n}\n"
> > +            fi
> 
> [Severity: Low]
> Do these unsupported instruction extraction stubs need a return statement?
> 
> Since they have non-void return types, omitting a return could cause a build
> failure due to -Werror=return-type on supported architectures like RV32.

BUILD_BUG_ON_MSG(1, ...) makes it not cause an error when not compiling
with -O0. Adding the return will add 4kb which is not a major addition
but seems best avoided. There does seem to be a handful of other
warnings that are emitted with W=123 set though, I can fix those up.
Most of them are about some type inconsistencies between casting.

- Charlie

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com?part=1
