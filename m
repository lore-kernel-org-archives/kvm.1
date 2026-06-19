Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD48E331EA5
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863842; cv=pass; b=mIm/NggOVCErly81iQz9lndufOhkUMqpD4YEd/TXT+5gw03NIm2tJlOqKQtWrVteI1pW/ZRbONLwmaZk5TqibMoOSXrFkjr7eOPe3u0bR3yoLCyYGE12S0meFEC90h9yELR6NoTHx0N4KObzp1E+ekGwR4GTwE9/19OG9ePzWdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863842; c=relaxed/simple;
	bh=BV+WJdPUZX7SWJL6VMcYgh6IoDynAjqVpnJR9RDV5JY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLBLCRMKn7DVXWVBERPyGfuVfrCoGIjSEtZSgaEga7sTAlQet66ZsDqndYkqxH9m6KcUjqkTplzUtBbUendTyCwDSgdlHJawSVNsV3hXumROaSpi7c4eAoez+6ASlxHVtDhE+QueAqRG3V6jISUBj2Knl4H7rzZ0ei1W6OvQ2a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wRylDAur; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wRylDAur"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51765531803so224351cf.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 03:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781863838; cv=none;
        d=google.com; s=arc-20260327;
        b=VInoVwqSaOJqiIQDCBTPFyNgpxppOGDATRCngy4y4j2SPedBp69YwIw3/+QuTYbPAT
         ITyMDDHo9UP8R/vdMAq9qBDbqmTeMW3EFB3UfcXXdV8ttGO9+CroUoWZhXAfJUxeKDjf
         YTMwcrXebQsKdxsoYAeYTw8OiwQXlhHux0ogRivZNTNCpJhFVm04mdzh8grTqPm2u0RX
         5Ap/ZQEplFO9fNV000K+wOlT6vUAUVjeGfjp6RD1rOk+fbNqjSwJXxNA3gMbLf/NsWqW
         zE9wUuWSVzcJE9WoKlPm8Ks/W2OYuDStvmVkpgkkjQg7MGI/W5/vl1a8DNdgz42I406W
         1K4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RTbB12VLXQ7u+hWMaqy6RpdQwZfV/8Fq+ivaXV4AweU=;
        fh=QInoLhNsOpWb8PaoCJxHcYvOEBkDG15by9Ck1XZ7bNI=;
        b=kifZuT6YTCO0w5liSG5jb++R6Qyi0qPv47XzNWv+mhgCSn7rmkdbFz2gtIva1A+MAn
         qDuudHWWh5Zc1dv1chc0MwlsZVE+TPiHfibvPet+7DodzUAWk+1YPStWG56jccRWSm9g
         3jfWnTi13SaRkx/8o7ZshpTbNeBuHbIOOX+E3ce2orGYbVpAUESn/l1yO2fXdI0OmHAz
         mc/JWFE0VW9DMKDvICd3w8CWi1lH2fBjpByfEvi4jnzeIvOOrOaZFpSv0qTmb9r7Pdnt
         PW/7spRqzyEgBRXe2iFikWBsfPNUQfCI4bNqbUzhtsGbvGdrAfLxBtjsC47MkKzAIOQ3
         WF6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781863838; x=1782468638; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RTbB12VLXQ7u+hWMaqy6RpdQwZfV/8Fq+ivaXV4AweU=;
        b=wRylDAur3F7Z4m64R5MYoCOVFjm9HnYTxfqBffHxRCg3Clh0abeRnjnAYrtK+d+4Hw
         nwrChDXTmIpU42pvkzmf8KW4Ka/z1RBN8GhzqkN4+WJNlYPyhgGdoDLA2VB1bpKwSn/1
         vVhVp/5gqUVbWGHtzJSbqXh5J4PePTiZKjRHeNasWnkSZqP4N94sUXdqlmIMB4ScdwU+
         72sx6qD8qbKmWxKOW+TJPOrTo9rGDwuWv48MT+zKHYfMG8AGXXy0JZB3lUPanfYO4YbX
         26nX7pn5VEZhLQRAT3YzCu9sOaMk6kFYrWyPHNjT4/06BQndanoTPoeuCBfwCnN249Qg
         HgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781863838; x=1782468638;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RTbB12VLXQ7u+hWMaqy6RpdQwZfV/8Fq+ivaXV4AweU=;
        b=o5/1aX/8mATnA+/tZjZMGt/VlUMv+h9ixYwjm6DIscqLpwVJPHZ1pumerANRRemX4z
         K9Ao5AUKgr6XrssRtaUWXNICVingrgLB5dp8B6fMznF2D82dkspF06/9+K3NyEXcmzBu
         8GTKYGqkqjTIu7OePBlv8PVbzatBh4WicdO5UycB9y1cR6LCmiTbvbJArIb6cObg/M+b
         HWj2rvgOJN0xWuEpGLFDs9wMjbNWEO1j3I7WUcA7jnInaKWsPqQyTjCHVqebgrI/cSxH
         ioQDdnKxToN92xhVGRZ+80s2GoKZhPGdMnxyU5a46FKRV2FE2a4eODT8Zbl2RdyEXJwT
         vONA==
X-Forwarded-Encrypted: i=1; AFNElJ8v4eGvLQHTo1sPv/OIawnSqXR5WUOnnwTQe6Or3hRdTpnVO8NRtpMx3oaJlK5XIChZRJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrvGf1AckMtFKx/4pYK5FXYx3LW/g8r5p9y4RDSxkKEJ2vaeSO
	RpZkNcr7SnICZyX9cXP8dK+c5LJlzIMMQ1lUc0NlCHkcS4PO8tpXSIIDhvJFFuO3C+Rlk5qeBjP
	wRbNcq1XSQTze/VlgaPOoKID1t8paRdD6sDXyynuV
X-Gm-Gg: AfdE7ckQN9YIkgbul9/eqteIe2G0GfXCTLUUpzfR2gMNNFHsuiiN7ZrKYrwj32/Vsrk
	qltqWtYSISFvAsBqpZEfbBitKWKjiMSYLOrsEq6iif7cm6VqPTnPklifvEn6SWRuezemJjIPnq5
	wmcu74mQbDoNdvNzAwjuj0DUPOBQ8P1mDE1o603QkjsNh5DC5ZiRT9jzYv7fI0VxgLSI8V2yB3+
	7TMzkEcpR7GFN81w+jLe0He3lCsLokq59UzhrU+rNHjvasrmSvmGv7i3EnEKdHzIjY7efpv/g==
X-Received: by 2002:a05:622a:353:b0:517:99ea:ab79 with SMTP id
 d75a77b69052e-519e8e7516bmr5933751cf.25.1781863836675; Fri, 19 Jun 2026
 03:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-15-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-15-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 11:09:59 +0100
X-Gm-Features: AVVi8Ce16E31U-w4-XubBsflwMOtK_nv4nwaxzfJhxldigbujwW2ZBTzRORImb0
Message-ID: <CA+EHjTx+3U++dnhGEkwh2SO82xMugAvvJ9ee1O__sxZCKL_X5A@mail.gmail.com>
Subject: Re: [PATCH v8 15/46] KVM: guest_memfd: Call arch invalidate hooks on conversion
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
> From: Ackerley Tng <ackerleytng@google.com>
>
> When memory in guest_memfd is converted from private to shared, the
> platform-specific state associated with the guest-private pages must be
> invalidated or cleaned up.
>
> Iterate over the folios in the affected range and call the
> kvm_arch_gmem_invalidate() hook for each PFN range. This allows
> architectures to perform necessary teardown, such as updating hardware
> metadata or encryption states, before the pages are transitioned to the
> shared state.
>
> Invoke this helper after indicating to KVM's mmu code that an invalidation
> is in progress to stop in-flight page faults from succeeding.
>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Coming back to this after working through the arm64/pKVM side. My
Reviewed-by here is from the previous round and the patch hasn't
changed, but I missed an implication for arm64.

kvm_arch_gmem_invalidate() is now called from two paths with the same
(start, end) signature: folio teardown (kvm_gmem_free_folio) and
private->shared conversion (here). For SNP/TDX that's fine, conversion is
destructive anyway. For pKVM the two need opposite content semantics:
conversion must preserve the page in place (same physical page, the point
of in-place conversion without encryption), while teardown must scrub it
before returning it to the host.

The hook gets only a pfn range with no indication of which caller it's
serving, so arm64 can't give the two paths the behaviour they need. It
would help to signal intent on the conversion path: a reason/flag, a
separate hook, or not routing non-destructive conversion through the
teardown hook.

arm64 isn't here yet, so this isn't urgent, but the hook is gaining a
second caller now, and it's cheaper to leave room for the distinction
than to change a generic contract other arches depend on later.

Cheers,
/fuad


> ---
>  virt/kvm/guest_memfd.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 433f79047b9d1..3c94442bc8131 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -607,6 +607,42 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
>         return safe;
>  }
>
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
> +{
> +       struct folio_batch fbatch;
> +       pgoff_t next = start;
> +       int i;
> +
> +       folio_batch_init(&fbatch);
> +       while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
> +               for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> +                       struct folio *folio = fbatch.folios[i];
> +                       pgoff_t start_index, end_index;
> +                       kvm_pfn_t start_pfn, end_pfn;
> +
> +                       start_index = max(start, folio->index);
> +                       end_index = min(end, folio_next_index(folio));
> +                       /*
> +                        * end_index is either in folio or points to
> +                        * the first page of the next folio. Hence,
> +                        * all pages in range [start_index, end_index)
> +                        * are contiguous.
> +                        */
> +                       start_pfn = folio_file_pfn(folio, start_index);
> +                       end_pfn = start_pfn + end_index - start_index;
> +
> +                       kvm_arch_gmem_invalidate(start_pfn, end_pfn);
> +               }
> +
> +               folio_batch_release(&fbatch);
> +               cond_resched();
> +       }
> +}
> +#else
> +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
> +#endif
> +
>  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>                                      size_t nr_pages, uint64_t attrs,
>                                      pgoff_t *err_index)
> @@ -647,7 +683,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>          */
>
>         kvm_gmem_invalidate_start(inode, start, end);
> +
> +       if (!to_private)
> +               kvm_gmem_invalidate(inode, start, end);
> +
>         mas_store_prealloc(&mas, xa_mk_value(attrs));
> +
>         kvm_gmem_invalidate_end(inode, start, end);
>  out:
>         filemap_invalidate_unlock(mapping);
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
