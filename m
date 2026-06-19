Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69663379C24
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781866918; cv=pass; b=Axh3HIfd0u2S2lnn2wng4iZFLti4m/JsOgWwWMf6LCPN1/yDeRREdrc/7ts45RYzqMmTaD8qEa3HFRMeTvUq01OYzZHl7Oc6c0r+v86V4xzbnRi0gka4lexKKglVh64kjpL7wchWaP+gYvIFAsH3WHDtwhFwtUxe8adoFxSps7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781866918; c=relaxed/simple;
	bh=N74x4oytNIsRYGMlMs20Ai2amlc5LbqjJhAeliuDLJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmX1XyMXnt0AobutKt1CX5EuOtzydclE65nfv8j8PI7WxlzroM8fIJt51/EX7yySWu/+pND8o8xI8H6d2ZEaoBX38oaiFG5giU47yuG6lT6zu7gK/CIXF8FtbIigCWQVYbBUsXtcGB3X5hmMacwRubwT7f0GMeO2njfBc4XVIgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9XAowfY; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9XAowfY"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5177d1ff061so148371cf.1
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 04:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781866914; cv=none;
        d=google.com; s=arc-20260327;
        b=UcKJNalRgApkpdZ9a/ZsuSr0CE/kSPneMdLm1PtYkKrBiQnPENswcM7z7k1juX1O/n
         CRRin+LFXU7t9AU/eyWK4EEh6Mv9n1E8eEi78MPaWwKd3hz9QSkoscnT0efkvLSamNMd
         ke5tPjZciuq+ZJwm38pqnWd0RmHUXc649IkJ0h9i9pPkCuovfR3kpbQAnmjJXtUwDmrW
         RNBMHmk0QhGCTdx6TLJgs0h/McoVBtpE0UDaabBiZluUuHmSAtUJixCq5QsX94U4f6vt
         5Yyjbei9jwCPDHF4ts+qW5AvIaHOGk29DlzXxxQWpoMgCuAhc5W7mvt+4RydF9hfsAAX
         ACyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U35NfwEOggAkTfTgF+7yslJDxFAl5ztmZY3G7iS5UTU=;
        fh=vKGcGAcyCMAPPYRZUvd2zjVBGHWKRkD44jswGoKpRG0=;
        b=SJbJTxOrv58hr9CsW9APOX1e16ulub730lNhXP9lWxzXhKvhUkTgvq5eAUOKwwLnWt
         QtBBCRxihxUJGh46OKwxYGqWrX2V1XOWzLwcczyvK9lv+ECF/eMxfZXfkMDm8Nr1HuiI
         24XQUWELedl+XZD2NrNtmW0Gk7mPpxQqZmuOf2VuLvVZb4zE9IYD1lsS+dXcTPxZrdvG
         Pat29QcJNYOhePfUOvg9+lGmzjAWBLzIJmLxPhXKbzie9MD1Edc7mYHbMvrSs0ipb7ba
         SDaWyUezZm7+C+FMkTflGacNdOD5ddRRI/udfyFRg3LBxHl2NrgTPpwjkMoxELfxAwNi
         Tsrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781866914; x=1782471714; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U35NfwEOggAkTfTgF+7yslJDxFAl5ztmZY3G7iS5UTU=;
        b=R9XAowfYchp9B/3z0IeVThoFWbiICdShhJqRZ88xXZwAJ6uAQEBBnFJS17IQmZV3iw
         eSliyUEPIbeD/ldS64H3WqIVFYtLmhe41eVuAtfUfrWZqz4a/n7UTQnA6WK20LNDoGWF
         B9fJ12GkPELkvY4gOQAFJ4ZlFodvJq4pZvIIdoHNcw8m9VpBNdDXI7hnzan46uTc3XJ4
         gsh7agZIdtFEU5Q3NLtycy3l50l3kIcW0H8bqCRf8bWhelwRpPbvoEhPHqXe4ViBOWKF
         fIrJTv4xNnc+DR04CRoW3g8VDh7fzAwDizj6Ja3LghFpfPZyXw3wYbf6cE2lWL121EXC
         TRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781866914; x=1782471714;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U35NfwEOggAkTfTgF+7yslJDxFAl5ztmZY3G7iS5UTU=;
        b=F9GftxS099fsZLZ8DVGI50MNHq8AOOdIPXdNlgpM2q+rgOrC9NdykmAfk2gX3o6BFO
         NROeWAfup0mPvURAQ41TBsq9rW5zEvCfzVIdrSq/7bTbSjmm8M1DA3eA4/VVv37QoQwJ
         vMm6H31xBs7V3XPOyoU2/oiwaTF2DddzhhzD6lyVJzlD75OJ2VvRIT4K3Wn50+TPZRDr
         HpSibh24tQGqIwyUYgzMceVrnE+uZqKlCX4lSSEUdPZANNmtV5xu6UcX0zxYWz6S8IzV
         hcIvUSrAJw7ShWbGiUXEOOTGvGuMi/swUauxGViaiLVlwPw72/p8QSlIRTeCrl9XFfgq
         5mPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+KW4s0OicgBx1zfkNAq1Y9NwSBZtSEVAlRpVPxvmzulBBK94yZ3zzP9nEKrp95jm7L0EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKckCAbQ5Z46QACEFSv2pfPG2D5WCj0grligXEa5nnZnWt4SKM
	4zAkm3tTsrvLUsU/A+nIOJqgtVZ5/mmebqq8nkc8iBZiZiZU2d8xoFtfCiWajTJttupCLVufG0q
	Lk+DpKw4KZTrBYYZPUMoHg9x7UZ1OyftcDIhitZaK
X-Gm-Gg: AfdE7cn5VhCQcVaZLGciqm4wcAcmxkkswepTYwcsncioTBcru2zrBoRX9U0P3aPM+G2
	NrW1n5g9kKgJXq0gPqXftsN3ScRlxCuhDMxV3su+pad4gMHgl8dTfh9+yL036BPjaYbR5mPRBVx
	gZdS2E+B6Qd60Tzfr5ndQJVaEqCa0iZxi5+QYCaqhntLV8C+Tm/5uciZvZSTjKqThA0ymVRFHFn
	z+QUQhjQJKzeAAzqKrRSKwfFfNR3vwb+qUzeGkevMDR2Aq1RZrZcWO1G0+7ISvZLu7fH+Db5g==
X-Received: by 2002:a05:622a:2489:b0:519:56a8:2693 with SMTP id
 d75a77b69052e-519e4a7350amr7631861cf.24.1781866913307; Fri, 19 Jun 2026
 04:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-22-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-22-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 12:01:16 +0100
X-Gm-Features: AVVi8CcGOil_aJVBQ43DfPQ1kHXf_SdVHaTxhCHT88DNVFNlliTMrSoTjQT32Xs
Message-ID: <CA+EHjTz3SW50EzxgXm8VysoaM21RReUVG2px_WUYU7zUwjXnpQ@mail.gmail.com>
Subject: Re: [PATCH v8 22/46] KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Michael Roth <michael.roth@amd.com>
>
> Make the source page for populating an SNP guest_memfd instance optional
> if in-place conversion/population is enabled.  If KVM can convert the page
> in-place, then it's possible for guest memory to be initialized directly
> from userspace by mmap()'ing the guest_memfd and writing to it while the
> corresponding GPA ranges are in a 'shared' state, before converting them
> to the 'private' state expected by KVM_SEV_SNP_LAUNCH_UPDATE.
>
> Update the handling/documentation for KVM_SEV_SNP_LAUNCH_UPDATE to allow
> for 'uaddr' to be set to NULL when in-place conversion is enabled, which
> SNP_LAUNCH_UPDATE will then use to determine when it should/shouldn't
> copy in data from a separate memory location. Continue to enforce
> non-NULL when PRIVATE is tracked per-VM, not per-guest_memfd.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> [Added src_page check in error handling path when the firmware command fails]
> [Dropped ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES]
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> [sean: drop explicit vm_memory_attributes references]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  Documentation/virt/kvm/x86/amd-memory-encryption.rst | 13 +++++++++----
>  arch/x86/kvm/svm/sev.c                               | 16 +++++++++++-----
>  virt/kvm/kvm_main.c                                  |  1 +
>  3 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
> index bd04a908a8dbd..29409297f1ef0 100644
> --- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
> +++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
> @@ -503,7 +503,8 @@ secrets.
>
>  It is required that the GPA ranges initialized by this command have had the
>  KVM_MEMORY_ATTRIBUTE_PRIVATE attribute set in advance. See the documentation
> -for KVM_SET_MEMORY_ATTRIBUTES for more details on this aspect.
> +for KVM_SET_MEMORY_ATTRIBUTES/KVM_SET_MEMORY_ATTRIBUTES2 for more details on
> +this aspect.
>
>  Upon success, this command is not guaranteed to have processed the entire
>  range requested. Instead, the ``gfn_start``, ``uaddr``, and ``len`` fields of
> @@ -511,9 +512,13 @@ range requested. Instead, the ``gfn_start``, ``uaddr``, and ``len`` fields of
>  remaining range that has yet to be processed. The caller should continue
>  calling this command until those fields indicate the entire range has been
>  processed, e.g. ``len`` is 0, ``gfn_start`` is equal to the last GFN in the
> -range plus 1, and ``uaddr`` is the last byte of the userspace-provided source
> -buffer address plus 1. In the case where ``type`` is KVM_SEV_SNP_PAGE_TYPE_ZERO,
> -``uaddr`` will be ignored completely.
> +range plus 1, and ``uaddr`` (if specified) is the last byte of the
> +userspace-provided source buffer address plus 1.
> +
> +In the case where ``type`` is KVM_SEV_SNP_PAGE_TYPE_ZERO, ``uaddr`` will be
> +ignored completely. For all other page types, ``uaddr`` is optional if in-place
> +conversion is enable, i.e. when the destination can also be the source, and is

Typo: "is enable" -> "is enabled".

"when the destination can also be the source" is hard to parse without
context. Maybe: "i.e. when the data has been written directly to
guest_memfd while the range was in the shared state".

Also, how does userspace discover whether in-place conversion is
enabled? A cross-reference to KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES
would help here.

Cheers,
/fuad

> +required if in-place conversion is disabled.
>
>  Parameters (in): struct  kvm_sev_snp_launch_update
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 74fb15551e83f..2b7569b6a8609 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2330,7 +2330,13 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>         int level;
>         int ret;
>
> -       if (WARN_ON_ONCE(sev_populate_args->type != KVM_SEV_SNP_PAGE_TYPE_ZERO && !src_page))
> +       /*
> +        * A source page is required if in-place conversion isn't enabled, as
> +        * the data needs to come from a separate physical page.  Zero pages
> +        * are exempt as they don't consume a source page.
> +        */
> +       if (!gmem_in_place_conversion &&
> +           sev_populate_args->type != KVM_SEV_SNP_PAGE_TYPE_ZERO && !src_page)
>                 return -EINVAL;
>
>         ret = snp_lookup_rmpentry((u64)pfn, &assigned, &level);
> @@ -2377,7 +2383,7 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>          */
>         if (ret && !snp_page_reclaim(kvm, pfn) &&
>             sev_populate_args->type == KVM_SEV_SNP_PAGE_TYPE_CPUID &&
> -           sev_populate_args->fw_error == SEV_RET_INVALID_PARAM) {
> +           sev_populate_args->fw_error == SEV_RET_INVALID_PARAM && src_page) {
>                 void *src_vaddr = kmap_local_page(src_page);
>                 void *dst_vaddr = kmap_local_pfn(pfn);
>
> @@ -2410,8 +2416,8 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
>         if (copy_from_user(&params, u64_to_user_ptr(argp->data), sizeof(params)))
>                 return -EFAULT;
>
> -       pr_debug("%s: GFN start 0x%llx length 0x%llx type %d flags %d\n", __func__,
> -                params.gfn_start, params.len, params.type, params.flags);
> +       pr_debug("%s: GFN start 0x%llx length 0x%llx type %d flags %d src %llx\n", __func__,
> +                params.gfn_start, params.len, params.type, params.flags, params.uaddr);
>
>         if (!params.len || !PAGE_ALIGNED(params.len) || params.flags ||
>             (params.type != KVM_SEV_SNP_PAGE_TYPE_NORMAL &&
> @@ -2468,7 +2474,7 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
>
>         params.gfn_start += count;
>         params.len -= count * PAGE_SIZE;
> -       if (params.type != KVM_SEV_SNP_PAGE_TYPE_ZERO)
> +       if (src && params.type != KVM_SEV_SNP_PAGE_TYPE_ZERO)
>                 params.uaddr += count * PAGE_SIZE;
>
>         if (copy_to_user(u64_to_user_ptr(argp->data), &params, sizeof(params)))
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 044486f128c37..dd1d18a1d2f68 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -103,6 +103,7 @@ module_param(allow_unsafe_mappings, bool, 0444);
>
>  #ifdef kvm_arch_has_private_mem
>  bool __ro_after_init gmem_in_place_conversion = false;
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
>  #endif
>
>  #define MEMORY_ATTRIBUTES_MATCH(one, two)                              \
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
