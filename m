Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA27581257
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894107; cv=pass; b=aIofzIKTFVr3vnQtbXTuEqGJWkaN7DcF/8LV+gJTpqAvOmW1/mNRimM8FNCiNMOqsd8/hP67LA/O6d9y1nKAeakzRZewv/Vi4XfC55Hy4sfN7LYQdcf9dY3fVCIiT3OKv+LG9hGMUVBJ7BGZ/5zslr86MaVLDUPLF/C1qUPaJQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894107; c=relaxed/simple;
	bh=QhYlL6j553P0EUMnVDTNvdPvx8/iDvuOHmYwBLPXEvo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/q3tCsP5LC5fjrIwr39vrjmzAokMYPN/A3ARpNY1JLhM5d6qgwsYsa7deC0sjyPFeiL7gUvXDFv7jBqlSt77i+LUIcg2NzHy34CquZfznSQRclChOGvDyphExHDQBMb+w+/6/mtCpkRzOhBkcavzwHZUb8IZCNdJRP10J6QjCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HgQIpA1L; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HgQIpA1L"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66fa10f35caso4558347d50.3
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 12:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788894104; cv=none;
        d=google.com; s=arc-20260327;
        b=R52801A5qn12ljUzwvskX1zdty3MZm20YNy1r5GyIYMXXgpLswn/Vp9julBqnWmq+K
         thPPiAGjbNFhJKM86rNndRgCt05TCnXtFQyOKmJqfHjx33NZkPt/yQQNbazto8Bic/uw
         7v4xib0K1qmPGIexl86ErUFn+iGyCQ7TPAZ9mJqXLxhCovi/Wy38wV7i1zEwyW6pmeex
         aJUinRFIhZPpmpK+Mc65K1AXjjPCueaeRBV9oWbX2HxY6+XrMETZh4OlowS/z2XCH4Z3
         FSLvkuW3EkKiBM3jz0rl6Mhfr4NaZprrkQraSDs2iwNGz4KzQer/SgjbdVW7bFEx6bef
         RdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gj+VTCLaPatIDzN3Ce73g2FVjGbSlVQNZ2BBXiEP5gY=;
        fh=A0DAOYJSOmxNNaf+D4PYCIP63sl8BU4JbpyqkLUhBK8=;
        b=MBXPWvI8ANCljBk5vqr7kYPnMUAcZx8nn/JozyC4p3DIlqmHdIpLP9neKt9FlB2OoV
         TUJz+u4D+zy9wF+kZDi23OAFUgDziLTwamE9zjF6qVv8tW0m5mcNCuYESOQrUJrivSe7
         GeP/u5Uv1bTwMM+id18WoXpiTRbpDZX66UnfvEdheoVH/ZY6rBXpLl9f4EmUiqtFL22v
         9BeotgkWG4N4iKoBcTvSpTPniYbwGIf9DtiuE+Kcq8H/RVqsNfDB1bNfFweV1IhEozCI
         IBlJeabzBLVaMLCdPV/aD+SLIsJYy1BUzrC9wlCbnNjpMSx71XrulQ/h0XPtvBFzhDWg
         GxCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788894104; x=1789498904; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gj+VTCLaPatIDzN3Ce73g2FVjGbSlVQNZ2BBXiEP5gY=;
        b=HgQIpA1LJzj61BW2e60/ni93YanjoXQ3hCyxY+fox8cVBPp1N+NasshIJqqZA9m8VO
         yLV3mHy5u8s3WSd5n+bRAlaXLxJ/R9NA+ROHssYAFZ9dmxmwHexjh2fVAfq3KwmrExT+
         I5EJjiReXdX/g1aNuPQZ3GBRQ7xzly6pVPloRJWpKNkI9AJXkrkQJUC87C4Pd9CaK8DD
         g6X5NMeEop7evDpymWJ3X7ULUQcCSpDsXkzmov7WY2br9c+6BJL5zR7Sd65lc9m7ZT9v
         mopBNiSQLYFzWP+tQSTxrwJIyJamJDq2LFjam+XJiW8ewFEPcjsVCYEcBVyMfuc5BueC
         LDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788894104; x=1789498904;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gj+VTCLaPatIDzN3Ce73g2FVjGbSlVQNZ2BBXiEP5gY=;
        b=LCLfd4AgQrLF7UAtXInXlzR6gmdBLKkMtWrqLt/i5PhZxpvpMAzWBtNaqoxN5utbpz
         rUSH3tCzsAOjTKG9ipd0afJHX4mTN2si0OsinRYH3pnwmuMo26bVBMaDhjIF504Xx4nY
         k2kL5qzLsWnpAfDpfXXLmmYZhUNuPqk8d0P2ru/Ms9mQGLYsOhABUEJ0IX27RjU52vMO
         bRIebE6iNVajF/kPR9QA9jvBPmr+iPSCFf7J/yBupfzOO10sHs0sOHS0sLrLasEiKQbx
         +RrhOuFYHY/tuUV5PR7STktf/2D5QGjjScSjx2F7EpbUzfdqi/3FoZU27cfqyCLZUBob
         TPeg==
X-Forwarded-Encrypted: i=1; AKwUvBx0GI3TtIVS7d0cmEymKBq8wgU9WVHLw0ePhj9e6RArvU7ymLXwoVOv588Iz8eRwX2YiSg=@vger.kernel.org
X-Gm-Message-State: AFuF++kyE1Ad4sor1oeMNhbY2mZPFxSESMmKTog5c4/Ci4W8BlBKov05
	h8wIRbA0tAJA1p9CrrpdcEdTz3YLNfYZx7/F+/hlY57Kv/XMDoWCDob6WVmcB3F4ZMA20FFPpNq
	q8PYkYtR3Rz6Ri05OvEN9uPxovvRw/hfc3oNfXvwB
X-Gm-Gg: AYBFou3SZwHGrNDjO+W8EZJIXkaNqq45Q2heo0NgoLzm47sJrhz3hWNxpJSb+ZEYhrX
	RFr08dkWz3hMF/9ok5/iLPqrm2XYKe/uV1Ry3qkBU/quJNXbXXaI7Tu6QlgEfIDAVTNKykQOTD5
	9io0DaQtbO9qm32JB9/Sgu1CakfawrN3BBs3jZizXcm4dAgh0FGYrpf57W/YGfUOVknmVQKDIQN
	E/J2hi6srF42TX1BwaSmNcjwwlVaB8Sl6/Zq+VxZ0TNUqsaCkEHYv5ilOskMupnO5EqZu/0RGEi
	VS/l7yU3X+1pzy/lLreZkVde6j6wXGGel2q08RH1V5sh0xYfLMvR6E83TYyecxcD34GhhJGOnsB
	xbueKSs67EqNRdjPz94hg0MF4ePbVGDI=
X-Received: by 2002:a53:ac99:0:b0:66e:3e9a:9e30 with SMTP id
 956f58d0204a3-66fb5a0f620mr9359683d50.24.1788894103467; Tue, 08 Sep 2026
 12:01:43 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 12:01:42 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 12:01:42 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260722-tdx-selftests-v14-6-15ad654a50db@google.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com> <20260722-tdx-selftests-v14-6-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Sep 2026 12:01:42 -0700
X-Gm-Features: AcwNN1WPZ2uU8GfQmCXhnm2Xzg5FSQlgtEqA3NyC-GefYugQL38hpysVtSVZrlQ
Message-ID: <CAEvNRgGifoMQNRFMzmuGpChUD3YE6iUZbfsHAxaFEeTGfNfeEg@mail.gmail.com>
Subject: Re: [PATCH v14 06/22] tools: include: Add kbuild.h for assembly
 structure offsets
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Lisa Wang <wyihan@google.com> writes:

> From: Sagi Shahar <sagis@google.com>
>
> Add the Kbuild macros needed to enable the filechk_offsets mechanism to
> generate C header files containing structure member offset information.
>
> Tools depending on assembly code that operate on structures have to
> hardcode the offsets of structure members. The Kbuild infrastructure
> can instead generate C header files with these offsets automatically,
> allowing them to be included in assembly code as symbolic constants.
>
> For example, the TDX guest boot code requires access to parameters
> passed in the C structure (struct td_boot_parameters). This header
> provides the macros needed to extract these offsets from C code and
> expose them to assembly, ensuring the two remain synchronized.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
>  tools/include/linux/kbuild.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tools/include/linux/kbuild.h b/tools/include/linux/kbuild.h
> new file mode 100644
> index 000000000000..957fd55cd159
> --- /dev/null
> +++ b/tools/include/linux/kbuild.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __TOOLS_LINUX_KBUILD_H
> +#define __TOOLS_LINUX_KBUILD_H
> +
> +#define DEFINE(sym, val) \
> +	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
> +
> +#define OFFSET(sym, str, mem) \
> +	DEFINE(sym, __builtin_offsetof(struct str, mem))
> +
> +#endif /* __TOOLS_LINUX_KBUILD_H */
>
> --
> 2.55.0.229.g6434b31f56-goog

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
