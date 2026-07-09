Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654F199D8
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555568; cv=pass; b=QXPwBRj6xWf6lqX3TNBKBePS8fgBem04WiOUENsZjVe20m1GkRTTv6NxF3CkyTKv9nOAumXp7EKIFIZsgUxW1dLb8IdfytZwfvuhBiflfxB7t45CBmGsbnz/4Xz/tR0CsyBanZ33osLTbyW7gwKINQIPhIZWiJz6UI0e/zHDGAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555568; c=relaxed/simple;
	bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xr8I7gO+FBZwTiL8OSr00MP+2+VWZooOFx912C0lL86rIGo2mBSyp540K2GSgFj8qb3BhxqLjFM0s/A8e5kA9Mu+WIO4IgR5FbHTESxTpmY0WZu3Evb69KzgQiwJ7rjJN+fIHul5UObb8eal5IhQe27HjmpuYpdAmm6PauxsI6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=km73nMuQ; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="km73nMuQ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so68822b3a.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 17:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783555565; cv=none;
        d=google.com; s=arc-20260327;
        b=Qj0IHG0XGraGX3bw+nP2KvMOQssOkxOyF1nV+R+mvCeBIPwNt8zVPGcoXBx3Re2jJa
         dtAPrGVTaIL3EMQDsigtevxPtHiLdnqdVgZ3XNIRQln2oamOjCZrbaq/h1YRMz2Mlacv
         FTW6VdsMLEDzQhwGjTdREBk5OqRiSkc3MSa/todtS91QAWfMZOk9JrRjvwNo7HLoy0qQ
         XFaP7Y3tWgN3PKQOCM2B90ssVu7Dcbn6cSOwrnrD6W1H6V/A1Z52pIVEJNaWa/TOlbWB
         4gPkeXMz9sGvIsE27fAbbG9iYe2IHt7JF7mcnqUWi0UeYgQAtY/ZuQ1KOEFE6FzlTInk
         sn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        fh=Ook2oyEsqWd+mLsxFgu38ptctj2nq+JfpjZmSNaNeHc=;
        b=jgfcsByiZKVxmvVWNDtxwTw7agkADyT816TuqcY29OvmhIfr7nfGOTOqWR4abVEUHF
         kO3VWUfZHyBF+S2ZU/D06viyxbAXmB60Wrrjaq9nDjfgAOWpk0e2GhzCiMw+5L+mkj0C
         hmphtVOzRMmdngxYAszdGF1XYyTO6x+DjRtyDXgO74vL5WDBNdA3zroyU6K3TPZYgQZ5
         8LMJgS9AyMHVnHoXTqSAm5eXo311WhPYa8J6ND7OiwlqX6mPY4rp7Rt0Zc71kLKaMsiO
         Ip5XEzt1cF2wbh/D1SUOIgkirEfBmfNIwTTALMGACygBv9mE3LF7DJew3cttMbKgJ7E0
         T7SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783555565; x=1784160365; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        b=km73nMuQirX6WkgaiDewtefUUpLqHsLA9lhojmRVu/O5GWXI+qspHLrIcP28hPedd1
         IdrQ4w2WUGkGZnfsvZbX4i/0vv+f8zy6UYrbx+r+6VAltUS4BsKAcMEEAqGPcoKiR6RJ
         oJPaYYcMOCkbcbYn6DUg2jPj6RwRgKn8b5KjbPN0LTaLwabP3wAFOO6JrbWd8+/V2xJm
         8qmB+NxqEb/SagF5FxCEtMVuCK+ov8IPbs0gvdfNk2TGZa0FvtOnzr4ElVQGCDXTFRjv
         zpPIU07tYAE6O/XcExlihB295hDnRUteCnX4/vklcg+GnLTnFl9WQaUB6cAitmsgQsSS
         bmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555565; x=1784160365;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        b=fUiukRlG5usF9qtvhIxPwDBlYA5+CFf1bHyBSuKiwanc4SnDvAiB7fK/rtz1ccIdsN
         3oy3o7EpPJfP4JDVMFvAmGlgAV0CqekXbWv3lHAV8XRj8Bzrjsn3UzrrFjzaH/r02BUH
         PDqsMhO5T1fmGrc7tL2tqjVkCmSKEvoFLsUROPA5vWzTwfvFjqMYEcqPvBr0krXdcBhB
         nXmCe5KbV+Jm/v4cm5n727bxUXCitEvVuMkP7t2gyCneY84IYJWFi8TJW6vdkosNs/5i
         KaenV7eId95VA0DRBorBZKbXpnjuMHJHTkiOlbaCsqrfpjf+HHwf9nEoswMsZEE4gsrq
         dKEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBawumcfBgGeG8YgFa/HNwv/fjHExasB9owymb1gaGyGfK1YXt+nhSccYFC19zGzJambs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy66sFzToKbYTyCJ07CiiXrLgJNBEty4cKOy7Z8E+n7hAGGc60B
	D9P1WY4qyS095NagwHuhg9xMN/woneSqI8j+aTfGujSZb8sWzovQhZ1WlwFRj6ONSvl9xl16uXQ
	tZJh2h2xC2AtkZRTuFVMGWCYAaNgm2NB7vPF76TSP
X-Gm-Gg: AfdE7ck8/cNhN9I3DhszvpobRg7gyz4JIKE86kVtSSoKjLzckuDcdWNQ7oz4nU7BiUA
	Wx/ykphugt0L6xV/tCau2W1BjVcdGi2khEeAGAPq3z/mrTcvwqBQO51kfOwtw6M3BJjDJf8DxlW
	0hsJmg8iLlyRlzQHi2xFrmm8Ac+0Unshn4DjFm1fHNIM1D70HjExG/f/PUHFPDHTpCYnRnZiwzA
	+KPCUCaRt8C/js7hqb6fqtVEGIUwfjnyH9RGhQk/g2xQkT0ai8zANP8dGfiRnve0Kbi4vidTpZx
	3ZLhHiuHxTZX6owsRPQUxjxi2jh26Nx+Db6P4wBiR81rwX8JeR+S8GZIrjEPrHR75CCcJw==
X-Received: by 2002:a05:6a21:7482:b0:3b4:669c:ee32 with SMTP id
 adf61e73a8af0-3c0bcbc1353mr5760887637.37.1783555564841; Wed, 08 Jul 2026
 17:06:04 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:04 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:03 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
References: <cover.1782735110.git.ljs@kernel.org> <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 8 Jul 2026 17:06:03 -0700
X-Gm-Features: AVVi8Ceg-PSWltTScKU18ZF0mdbBsNHDv0s-VKhIaqzjwQ-q80D6zfZMKk_VWII
Message-ID: <CAEvNRgE-JJAzC0jp+bY8+e1+gYSH+MjT6JqX_DfCcpaxOM-Dtw@mail.gmail.com>
Subject: Re: [PATCH 15/30] mm: introduce and use linear_page_delta()
To: Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>, 
	Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Christian Koenig <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, 
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-mm@kvack.org, iommu@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

Lorenzo Stoakes <ljs@kernel.org> writes:

> It's often useful to obtain the number of pages a given address lies at
> within a VMA.
>
> Add linear_page_delta() to determine this and update linear_page_index() to
> make use of it.
>
> Add comments to describe both linear_page_delta() and linear_page_index().
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> [...snip...]
>
