Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BEE46F48D
	for <kvm@vger.kernel.org>; Sun,  4 Oct 2026 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134587; cv=pass; b=lGnI6MGFVT2CUBym86hyo6ZSpskg17btprD3U61s2EdPkKP8OhEDSoKfJp9CcBh30dNDJLdq43ap9fnSuzGRcv9rWeyP6mXIY4nRf701PBLI3YVTkAVNF5s+p0GW38Dptf0dh8b4jtfadQdT9Jik1NJWZnSZws/HdPxrA1agtho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134587; c=relaxed/simple;
	bh=5YwE6gm7wg0FWDw+d5L2a31cmRORmzOWrTnpytOvhqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrvXstifSgtM3RR4aR/DOdTB6Z5dXKA9sO8l9+OatAPlIJyBHJXAdTHfLuajx8w92O4LTAXNWr2wWWvVxic7wFujsFd+im0jOnY+X27okYbS3vjYrBrG6NyjrzlnuvXabTqAEyzumU1sqyL+vJpGd0l0bDUnEVW0jhgByqGdRdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ev/NnSUV; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ev/NnSUV"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5337fa12431so181061cf.1
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 10:23:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791134583; cv=none;
        d=google.com; s=arc-20260327;
        b=LkQz1ffXvXadDUIYaRvFOmTeIrN4riQoLftYvP99Gnq54d7LuAPe++tN7swu3WuEmQ
         s9DSYtjNIyKdFhPr/ed6e5UG964T3n5Xh4uNTQ8eccCFRGgfHB7KCq4robyJg2zgEaHd
         ira8UY58cBO+cs/hYk0F743+kx2ui/QPlj8ZHz60hLHkhzUp77yJYyAmqOZubq7RzeKp
         545UtvhmIXiFphffuIa4LoAsbUA+YLPXgltlr/kDzzIAFQS88Z0Z9v4XkOHwpYAK1Gq3
         xPmCzjNsVpnhgEBovKrXrlSw5Mc01uZz3/htL6FK+MvRg14M5Dw7iEomJYtnPPi3EZ/R
         gNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bqiCaT+6hB/MlQ3EgaRNQmjR57IQALnN7KoYl50i5vw=;
        fh=qoVPEYYSPm6T7OiszgradEGB8ln8wzmDg471si9cC1c=;
        b=Gr540J+qHIqqz+Jx4ExqXl26RQNWiaCWMRUQzzkAz1Ie9nZYSKxf8Jpb2r3JRz0wFY
         mfKEZRTwoWwkzHky8Hen3k1pEfbQFZOA/NyyqLWj6hNUao6swWRtHsFj4a6zd5ren61j
         5L0uWCNUYekEhRrFtK8PcWrpWfV0RDtv/KhekI1qUA2l+eBYjR+9CrNt0uubBKbD/L44
         bVsjg+d/ovMJvItDYTWVBuKeeul1xaNFrwUM7+pBcDbPBuvaa5cynELJ6atPCF7qLuwG
         0iDP0z6J06jA0wE0lHdt9Wuyc4PQHidnVA7Tm4np4osih8Y/GMNbeAjqa3aQJMOM0Fs+
         iUSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791134583; x=1791739383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bqiCaT+6hB/MlQ3EgaRNQmjR57IQALnN7KoYl50i5vw=;
        b=ev/NnSUViOZ+ATajuN/BHEOpjCgrxKI1nt1o2XQCuN5h7KpRGDTtqS2IKJN37vT8R6
         IbuBrgwBCixnrX5DYs5zuSpVaN0v5SBvJXggFwQVQeKiRmVp7c0/zqEuo+mf9hQYE+ap
         XREirLdhnpqRqpG6A+D5jtBOZgfp+zeKZylZAZ4yJTfDpftaH0fV8uU4OqxMdwqT+x/O
         aKbyGDnO34Q8OmZXgttyU3B7s5pjk9WcC2we5ktK5gynifeEucE6Om6Sq6OSysMfD75o
         AjLX4rLLg4//L2FGOrssLIPqc+S2KZ2Y7d9tVn4emORbQv0AmSNSfDGfDi5GXB6+4Vjj
         Ym5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134583; x=1791739383;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqiCaT+6hB/MlQ3EgaRNQmjR57IQALnN7KoYl50i5vw=;
        b=uXWd5sT/GU0FhFAED4tdHDIr8p+9SQ5vZI0OV9CTFv6QJGW5tG2J9hNHzqZKQJlbZi
         1VVhW4LABjPcnYWKBy8ZqwveEV+EmGwyZuJJJ4x6xxH0IuWFgfpLrFdMzmlPITwEFd2O
         X1DL0ZN2Sr7OIQ02KGnBIH1yUdSx462ZaDYamf2pSWNtD9RupWqNoe13JL4e3xVZ8ava
         xxoTwQMioW6ntgQvIwUDRFGEzr+0FbedPmDki8dz/e6McL4QOH2BIRTEdnqr9vb1Hun+
         ZC0xoXwVIB83wM+eb7nJ2BSYOHwozZs+ToXfz+a1Yqnz3Lr8lsH7pIu8hk9/RnBzhwoH
         eVBA==
X-Forwarded-Encrypted: i=1; AKwUvBwfwaNHj+s12xUNGZwtXG2I/J8W9kmo11clFIqMpVnSmSqD2zA0xCMAgVZJf5wr07U8pxM=@vger.kernel.org
X-Gm-Message-State: AFuF++mWbYzhTfhCEG5jMLQiyGH9OTAgJG9AW8sEPyHZZuz4ssHmkXl3
	4l2m0X6OCCsW3uF9ME9/B8EDEX637lgDAzf2I6hJX/PV9+0WNVzO9Sy7t1xTk96QFUdLfM/8JIx
	bypSD37b5Jhv09WNGQfbEU3sT8MW3LUCnjJntbrdX
X-Gm-Gg: AYBFou25W6D4w2Z1GXa9Hn80cDjaA4Dz7i5x/ILNvQ9MvIBUwDpBpNhRv1gW5qwa1Wa
	QJYbaXb+MilOE3jZ8W4aeRrhLKl2v9absH3J8Ch8ow21bnIO0EolC6vZUuetYOkEk23anvPIw7l
	1SJrmjCxZ2Lcm27g38siQFX4HNq1YgJDzbsMGuMUp2Rly+mmeZ3x0R+Eccwc6SSYOnSMlPFhIE+
	uieyp7OuGedd1B80N985XXTe2rhTMrFLry5fbfc8GeborClE68T6WawxTlCZvL7Mt2rga5DYoXP
	vt3tStfS4Pv1dURa+EnasAq2OI1X+4eCVWBtaGHo3eUmbnD3kRF7nz+cTEvBsPEOOtM=
X-Received: by 2002:ac8:574c:0:b0:531:475:4ce6 with SMTP id
 d75a77b69052e-535131b2b85mr16362481cf.9.1791134581910; Sun, 04 Oct 2026
 10:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-12-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-12-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 10:22:50 -0700
X-Gm-Features: AclHuK9b8f-m7wgF2pmH0VTlVxkwioKHBPR714nLjuu-GaXS_Vt3fJyAlsba0Do
Message-ID: <CAJuCfpH8GeLKqFtfC_a5i08dQ2ZyyROSrYqYP6Btq03xbF_nXA@mail.gmail.com>
Subject: Re: [PATCH v4 12/38] ALSA: pcm: use vm_insert_page() to map PCM
 status page
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 6:37=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> There's no need to keep a fault handler around for this, instead map on
> mmap.
>
> While we're here, rename area to vma to be consistent.
>
> This correctly makes the mapping a mixed map mapping.
>
> This works towards establishing the invariant that only PFN mapped or mix=
ed
> map mappings may clear the VM_MAYWRITE flag. The status page mapping clea=
rs
> VM_MAYWRITE, so it must not be mm-managed; the control page mapping remai=
ns
> writable and is left fault-based.
>
> The assumption is made that the struct pcm_mmap_status structure is at mo=
st
> a page in size, which is asserted as a build bug.
>
> This is safe to assume, as the size of the structure is 56 bytes at most.
>
> Acked-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  sound/core/pcm_native.c | 38 +++++++++++++-------------------------
>  1 file changed, 13 insertions(+), 25 deletions(-)
>
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 62324282fcae..c98fb3df14f3 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -3760,39 +3760,27 @@ static __poll_t snd_pcm_poll(struct file *file, p=
oll_table *wait)
>  /*
>   * mmap status record
>   */
> -static vm_fault_t snd_pcm_mmap_status_fault(struct vm_fault *vmf)
> +static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, stru=
ct file *file,
> +                              struct vm_area_struct *vma)
>  {
> -       struct snd_pcm_substream *substream =3D vmf->vma->vm_private_data=
;
> +       const unsigned long size =3D vma->vm_end - vma->vm_start;
>         struct snd_pcm_runtime *runtime;
> -
> -       if (substream =3D=3D NULL)
> -               return VM_FAULT_SIGBUS;
> -       runtime =3D substream->runtime;
> -       vmf->page =3D virt_to_page(runtime->status);
> -       get_page(vmf->page);
> -       return 0;
> -}
> +       struct page *page;
>
> -static const struct vm_operations_struct snd_pcm_vm_ops_status =3D
> -{
> -       .fault =3D        snd_pcm_mmap_status_fault,
> -};
> +       BUILD_BUG_ON(sizeof(struct snd_pcm_mmap_status) > PAGE_SIZE);
>
> -static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, stru=
ct file *file,
> -                              struct vm_area_struct *area)
> -{
> -       long size;
> -       if (!(area->vm_flags & VM_READ))
> +       if (!(vma->vm_flags & VM_READ))
>                 return -EINVAL;
> -       size =3D area->vm_end - area->vm_start;
> -       if (size !=3D PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status)))
> +       if (size !=3D PAGE_SIZE)
>                 return -EINVAL;
> -       area->vm_ops =3D &snd_pcm_vm_ops_status;
> -       area->vm_private_data =3D substream;
> -       vm_flags_mod(area, VM_DONTEXPAND | VM_DONTDUMP,
> +
> +       vm_flags_mod(vma, VM_DONTEXPAND | VM_DONTDUMP,
>                      VM_WRITE | VM_MAYWRITE);
> +       vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
>
> -       return 0;
> +       runtime =3D substream->runtime;
> +       page =3D virt_to_page(runtime->status);
> +       return vm_insert_page(vma, vma->vm_start, page);
>  }
>
>  /*
>
> --
> 2.55.0
>
