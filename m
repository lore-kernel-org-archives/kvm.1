Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304BF377AB9
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115392; cv=pass; b=Hl1ly3q8jB5ggLTDxuZsrLrn378WNoRYMBChzZEnONxP0kg9q41BpXlh2ZihuGU8YfhfA1k/Oyr0EHsiEwpkPxCyBJglh26nFpKRkBzbDLJjSEGsXiEhJlrRZy0S6cGLZUanONeh/+rWDXh89csDImOAdHBfbFUN5p6oqs85Uhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115392; c=relaxed/simple;
	bh=7ZEtkZBQmdX0etetnBFbvuoc6k7xP4dTkloxYVpfa9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNKCmiCgMZEmIvSfgaDqCOU/hmQdCKy5sbHNZTd+PPVP6iJadkjF7gOsPT+qz6lj61HXYi/b/xOf7arKYbOshxHhYukirP9+ukubfdCeQoarx42qNtGxHt317fuOoC1bc6k8B84JdAjWp8Zmz21NS8ea0UG8wuNnkhq8lqYzczM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Js7j0C9P; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Js7j0C9P"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7ec1e9d3359so1869282a34.0
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 04:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784115389; cv=none;
        d=google.com; s=arc-20260327;
        b=I+SaClPYI9TqrajfyJMENXo9fmZG5qQNha2n3xAHrr0f6r69VEmCC8u76Lxpx3NZvb
         +eLVBgn+jIQcnhtlBqU/haW0TZMS8MSLuVN1qgjBm2mpwbP5MNpA58Dhk0wVPsQ/GZLo
         +FXEm1tio5EgTwYw+TV5LBMM5Op355eYkw4KB/TDkbLfxDFJTrz/vuMiDpsUdvFPn4bU
         SbESNlD5f6HKFr/n2725ECdjvW0Ao/LpFUVgj8tcXh0SjJzuCcrq6qkiaZNsdDzWdCUv
         7CJaoE8iGik9QdafoXbXy5+xRORWsOiRGCoV8HPYwMvXskbx3IoWuCR49yAjgS7pFoja
         8zMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7ZEtkZBQmdX0etetnBFbvuoc6k7xP4dTkloxYVpfa9w=;
        fh=DWfejou7BJAZgHhEj6EiilnJoqcR2Oj84zsw1ajT+2Q=;
        b=G1/QZEXfyGjnEtx5/cd2GFjbAYInX9IENDxFDGA/JMSg3e9Y4E0K3kXrkgQbMXZ2Rd
         /rGjOC53Q7jm6+pYn/s54bKKbr00/O+wHQIcnZb75cTqpJ16/9Xl71WKgbOdJ4Gc7niN
         Yx7JoRdSnW4hIG4wNd7aq3G4oEVMjd7rkjDFm7p+B0UxuKYsmpgiYruOVxhIiDJvL2Va
         tVecXO4V+0VynvxoQWmmbt6ODAgus4YVL1bmItjWNm1lX7Za78CDS2nYg6JOFXq6MZg6
         FIewJZl86sLnpwLc0h79ykQl/biWSlxNTE1RnrQVkzqcX07+jTeIfrOZ7YR2fB0eFVQ5
         WnkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784115389; x=1784720189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7ZEtkZBQmdX0etetnBFbvuoc6k7xP4dTkloxYVpfa9w=;
        b=Js7j0C9P69DMl0Yz8gVeC6BScsJ92/IevL2d6M3FTmvPKTakVuTZXdW1mQ0B3MTBH7
         61bG+dkByME74DswURQMirDXuINylsitsRbRtclkb59TYn0yot1REnffkwOL9NvialsV
         01+fqZAeXs5ctswZZIe6AL4tst12mxutq+hXG1RGveMAyMkcoxxu3Pt5Dlzkpn0BFSra
         ItzTgnXJFt7+v2jXPVRqEM3Y7g+EyPOe3oQeenph2tG+SbTb0Z+OH/c+KT5fw/tXQA08
         90Auq/4UaIahdCGyOVyHQAn//z86PF4tLq5KnpBzWIp5UG0kXriIQoOTLN7ir1ISd7My
         8TTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784115389; x=1784720189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ZEtkZBQmdX0etetnBFbvuoc6k7xP4dTkloxYVpfa9w=;
        b=FnCVQoCUHUI95sWexevIzSJPyKT3enn6otPKK8QWyJKGcmOEriwbr/EFwQXK1dbWMw
         /PAHC4hBz/oBYXUxkvZukT9P0eJ/3MrFaCxU578+wEmQNAmNJCKgm8azDO2xCFkL86J3
         L6nm9V+3LFEVgRh6mJhK43jW/3u/wzukkAJCMktjgxNQKJi/+395jEzN/fX8JTOFbWt4
         nQH9jRkjVARJGWoQXMm6Uf9C2FRFiXXF+JOfLyp9NVdSLjySxTdQKzzHVzBqTi9bvU9t
         eXgSzKxY2+bOjlyuvUNLaqx1kEPYrwNVE1OP2kcRpZuQX5Jah6njcvk9HAQgDBKs4zFl
         rjEw==
X-Forwarded-Encrypted: i=1; AHgh+RosYHHPm6v+nEgNQ8xVdB+lOKK7+6Y1cNxdWYk1QSRdGqqQ4L1r2L03dMpCZrt3AXpBHPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHdH+UvCyK7/1Wof6XnEvWgst/bF3syOT9d+PQOwu8TS3k825+
	U1jTqBQbu0z3bisgdllj4ljU+SlnNMRsMgDGpF7XKOwYelpKENid8ZMNzs7TB4uV0ODyILFYkV6
	xULmYhIVz61hxOKR/ZuwUCp8tpBK048G6LsgvoqbTdQ==
X-Gm-Gg: AfdE7cmKkHBecKYhyw79XY/2I2TKdCgzy2zenuNLYHjvF5wi0/ldy+Aqyhdn0J1nYjA
	6dYf7L96fl7WbnZtAjxLnnhL/Ufv8Ae6XwyC1ZLFWJ0ilEXhSnfmQC0bKs30r0Gg5jYJAAbRYI8
	5RNwHV6tW/luPVorQ3nnXAzXRo6M+qMPw/6UcT600SD9YQ8WGSIpK3IB8x7dNheXRfHzYFrev2m
	8PS5Nil9P1IEY9XQqwFoObdy/8w2HtyBUJ8SfzQTRtdf2wl80z1Sng+f3keFg+JFuX7bQSzm/8=
X-Received: by 2002:a05:6830:6d4f:b0:7e6:e1d2:3bd0 with SMTP id
 46e09a7af769-7ec420f059fmr4345745a34.10.1784115388897; Wed, 15 Jul 2026
 04:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421092457.37649-1-cuiyunhui@bytedance.com> <62c418bc-082b-4ae2-a889-f63dd2b7f503@kernel.org>
In-Reply-To: <62c418bc-082b-4ae2-a889-f63dd2b7f503@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 15 Jul 2026 19:36:16 +0800
X-Gm-Features: AUfX_my7GduNMyP3_qMrw3wVYCX4eNM5Te_gdOiwtTrcP35i3khqzqzTVVZ3zhc
Message-ID: <CAEEQ3wm72=CKNxXsSszZqiWDSHDZcAUgppxXxEAXyCy=uB+zaw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1 0/7] riscv: add Svnapot-based contiguous
 PTE support
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, alex@ghiti.fr, andrew+kernel@donnellan.id.au, 
	andreyknvl@gmail.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	apopple@nvidia.com, ardb@kernel.org, atish.patra@linux.dev, 
	baolin.wang@linux.alibaba.com, debug@rivosinc.com, 
	djordje.todorovic@htecgroup.com, dvyukov@google.com, elver@google.com, 
	glider@google.com, ilias.apalodimas@linaro.org, junhui.liu@pigmoral.tech, 
	kasan-dev@googlegroups.com, kees@kernel.org, kevin.brodsky@arm.com, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	liu.xuemei1@zte.com.cn, ljs@kernel.org, namcao@linutronix.de, 
	osalvador@suse.de, palmer@dabbelt.com, pjw@kernel.org, rmclure@linux.ibm.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryabinin.a.a@gmail.com, 
	surenb@google.com, vincenzo.frascino@arm.com, vishal.moola@gmail.com, 
	wangruikang@iscas.ac.cn, zhangchunyan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, Apr 21, 2026 at 7:28=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 4/21/26 11:24, Yunhui Cui wrote:
> > Hi,
> >
> > First of all, thanks to Ryan Roberts for the work on mTHP and
> > Contiguous PTE support on arm64. That work provides a very useful
> > reference for reducing page fault overhead and TLB pressure for
> > large but still PTE-mapped memory ranges.
> >
> > This series adds Svnapot-based contiguous PTE support for RISC-V.
> >
> > To achieve similar benefits on RISC-V, this series introduces a
> > Contiguous-PTE-like mechanism built on top of the Svnapot extension.
> > The intent is to preserve the core-MM PTE semantics while allowing
> > RISC-V to transparently fold eligible base-page mappings into
> > Svnapot-encoded contiguous mappings when possible.
> >
> > The series splits the low-level raw PTE helpers from the public
> > core-MM-facing PTE helpers, so that:
> >
> > -the __xxx helpers expose the raw hardware PTE encoding,
> > -the xxx helpers provide the semantic view expected by core MM,
> > -and Svnapot-aware handling is centralized in the public wrapper layer.
>
>
> Just curious, is there opportunity to share some of the code with arm64,
> factoring out helpers that handle something like
> CONFIG_ARCH_HAS_CONTIG_PTES ?

arm64 contpte and RISC-V Svnapot look similar at a high level, but they
do not model contiguous mappings in the same way. arm64 keeps ordinary
base PTEs and adds PTE_CONT, while Svnapot encodes a naturally aligned
range directly in the PTEs. Because of that, this series exposes a
logical per-page sub-PTE view to generic MM, while keeping the raw
Svnapot encoding underneath.

So the differences are not only in the low-level encoding, but also in
the public PTE semantics and in some of the fold/unfold and TLB rules.

>
>
> --
> Cheers,
>
> David

Thanks,
Yunhui
