Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187B3932D0
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717451; cv=none; b=LY08ct3IMAGMumT6C4x6bH3h/8vqPLTiW14KyhgD97b13K5+k7MyVdIj8i8YvFP/mbDC/ZfTDHAII7pJzbtaWyNy2E8618e6+GrLEB98B3qR/mvRJRjsit0fTK8C5ukRrTXRe/ct0Rxp8foGTX6QBVewPP/v0XuuLsdHERmiQC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717451; c=relaxed/simple;
	bh=2Gu7794NM37tAeRC1T+cOMES75vIKzE7urqHPy3L3qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfZXvrfhnTcecaev6hSqvrixCgaDJbmoy1xoDD5NUkdNQabuEdI9kNqmFb2Ol0JH57mD9eZInJn2Vtw3SWADFRd1OsGQsKpHlruaLRm3ZysvPwExATIEBM5sEMFXwwE8fvmrrqkOEpvHXjP9QQiBTw6UTToiqkTNB1SyV34Q1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lBvWm80Z; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lBvWm80Z"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ff5d1b0f91so8161036d6.2
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783717449; x=1784322249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OhI7UcJVN9EaMSo9cM31eWAmb7Tf3pcvHFHtAkV4RLE=;
        b=lBvWm80ZKrpTlXiNp4GEU8sSXeFn0kDDZQsu2kQPU4ELlyE7sUch+ixBiculQRIBz6
         98fjNmbZfXcFA9lqohtHnytU20+56W0Y0pRnyFEi5duqJC2z7q4V64zBnN+QHrVrCGL/
         ukYi7TBLxnTlEDT2OjhVX9PuNocoIcSUqS3milrwenYSGffD1w1JWzaJOIzclL8U6Xaf
         42xPz1rCkL0UCS0CG+J6mpHa/XN0ghBpRKTvxK4C2AczrPrbcJx1ST9zzif5afW2RjUF
         iKfd7HbuvG4A9s2E0lFjqnktiJ0+YfW3NIMgX+1saKzKJNEB6B6PDL2MDYZYfMHG/d8G
         o6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783717449; x=1784322249;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OhI7UcJVN9EaMSo9cM31eWAmb7Tf3pcvHFHtAkV4RLE=;
        b=GIDJg/xyEmFr9+q+qwFtW4uuDYugOD5d0vfFCUGcjwRRrL0xyNTuRCE/DoeYRdFpem
         MRJBYTQMCDaMGhAGTvkQOkHQXAkepIMEBLB26iaa/Qh8V53elioFujwvo+/9djhBsgMj
         /4XAlYLRLeugAchjSrrtTFU56MTP+SyWl/6c9RlZx8KTm+ZT1p25kI4wzbQQrl3l5DEs
         /jqKpz8J0zLbYiclvQqHz5wQquqs5l3wAJp5PDtwGrZNSQvKIcQ/bDv9zHh9tH6UOJYp
         LRLPDesM7YiLVYybVBlIXFHbpl2t1dxd0Y4gdDje7NE6pZJHdg9w1GphFa9L5MXAq+3j
         Q+Hw==
X-Forwarded-Encrypted: i=1; AHgh+RotVp0hGbxT0Z7C51D+wpBPpFsNOByiJFX4ri+Lmou4D1AixOjcu+oMFj5OJRTGoj8XZTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqn72hhCRQFVgmeGJ7118u53gJ5xUglL5f0c6kkspyESGrTNMI
	EHjXyQNq/9ERZv0u2unImEdzWneSOukwAsdbtjf0wq1B+C2M1LRxi5pKmtUcKKyiInk=
X-Gm-Gg: AfdE7cnGD/hXXpRXAlndmXb8XjQupsrlG7NNduhAVi4BYlVm8mq4d1XEWvlqfzbBW1F
	uHJQVmNr1lGBk+a0ZzGfit5kJeOTmAbjHHp6yI6BfHU5QiUeAst7oEbj0vONk0MoFMNlgje31X5
	4pOh7YDu9iu2Lc/r5s8s7MQEEIR5ewS6WRwjbzJQAjWEKUkse/vzqZDYtne0shJF1W9jnGpnRRu
	sguHsLxjPxhsm8vV7a2vr4ckjGhpZtzvjCJnhW3xegqcrRzjIqkEmKG5htM2Qh9ck15U0o/AyDY
	SafANTN+6hvFTQMYmYHIXpX8BwqL8QkTbBQ7nzK2oShi8W548XdcjmFAymK2GJEnSpzJEMpQjNj
	Pt13PNcAEk0OqUqPVtCcL/r1OShVpn5m4eL5oAn/CkTYxfVweT2ZKd57g9EC0DOAUmft+J/P+oX
	t0jzliCBED3EtyI+/GtbV3t8d3BaK9XKGl7ESyMk0ghqO3ZONwu4Nw0AChCxd34CnI7ocz
X-Received: by 2002:a05:6214:3bc7:b0:8ea:10f8:ae87 with SMTP id 6a1803df08f44-903fe450f77mr10485176d6.11.1783717444207;
        Fri, 10 Jul 2026 14:04:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50df5e2sm50655596d6.4.2026.07.10.14.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:04:03 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:03:58 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Dan Williams <djbw@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
	Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-mm@kvack.org, iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 27/30] mm/vma: correct incorrect vma.h inclusion
Message-ID: <alFePgFUR52GgBS7@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <22d0f4e3fe11f6fd1312734e242d008267ad142c.1782735110.git.ljs@kernel.org>
 <alFHR3fg8K1-SITK@gourry-fedora-PF4VCD3F>
 <alFJUfaGHVnKd-Nb@lucifer>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alFJUfaGHVnKd-Nb@lucifer>

On Fri, Jul 10, 2026 at 08:35:43PM +0100, Lorenzo Stoakes wrote:
> >
> > Do you actually need 3 copies of this comment or just one copy in
> > vma_internal.h?
> 
> I'd rather have it at a glance, it's a bit silly but C headers are silly :P
> 
> BTW you're kinda racing against time here as I'm on the verge of sending v2
> :P

:[ i don't refresh my inbox when i get hyperfocused and now i am sad
