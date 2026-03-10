Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151A26C39E
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104781; cv=none; b=o7Y83Pjsz9xcUyR7qGUiV6jAOw0f1DSOkJTqMnT4QsIenGaiT8TI4qLgEhCZ81jHVR7akO1I/2G+AVNPFABKd+Ps/L7+KsjbirxsbPP6wR7CBx2m4vDQucpa3rjn7ltu+do0EgAtLuhdgAau7jFEdDXoUqgoVjHv6L53u7AZAa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104781; c=relaxed/simple;
	bh=Ps/B2Z4YbD6//yK0FTkoaGlvSB+kH3TEFIAsJhiHCps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o8YI16aVnp076yEGth3yjizkIsfhQyyFcG5bTeAWZ/qg5cST2vpG9jXEOaTNSSzVSmFHX4Bhm4jz9ssQWxSQMUBCjCsCSJty6ujUZ6T0EeZnyjBz/UbTsoMXCgmUgyOtE4ZkUd8Cidj1mY2d8tdXuu3IhUvjdpYD0UOAcjgvDl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCdCasmV; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCdCasmV"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6097ca315bso54315139a12.3
        for <kvm@vger.kernel.org>; Mon, 09 Mar 2026 18:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773104779; x=1773709579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/pJjCJQTxqUtKgBQ/nXqQmMajRmz8+Q8yoKiNddz8s=;
        b=YCdCasmVb7hZfq0q1E7i+qOoXnasgWLJJCsBBBY3YhG6VdJ8x7uczFdesdQ3nn8LOa
         OY/D8zVdl9Oe+HR16c8hwj103vyW5gjGU+RoRZcM5FjGlPWsq6ajc1GDMaPOe+TIqMrq
         9sl+AGcfoqQnQ5YChJNxrXlOZnaXQ0RKHCMZJHuk352zQB8ryB+sJVN3mYuzLcay90op
         UOZbqfyDE3cMRnZUKOOHW1QokP2iq4WajIo6Eh/BtfHiV5Eh13r4Ngc/zMLRbHPzEZKI
         1T4AR4tzXKXeHyTQa9TigT+I1vfqiWEWB3Lbd2shUhCEiUw1vjAqMhBddiC/9FD1pzbi
         Qe8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773104779; x=1773709579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/pJjCJQTxqUtKgBQ/nXqQmMajRmz8+Q8yoKiNddz8s=;
        b=vm6YCGy5FQ2rj+CTI8eUz3eFdkZugAt42BILHplLRa8RJljC4dtPu6xA/jZti+7O4B
         BAVsQ0XVv1qVQn8868v1I4DCSwrnHsKdBri0Up7jg9jWqHicpzFAvy0nkf7eFuRmjVp9
         ro71POOIW+zHe60uumCJ46jLS1Mzdf+0XNtVX7KAfKKH7ENC1cTQMTbxwlLSC8ERjuTA
         ymDgL3qrmFCgm4rUtw4wf7mATY4jo7yKgv5ZP6y2vO9/ih4T9t33E7NZNzZzTYBSjHr6
         WIM8u3y0VE08h0VD5GwvJdvwecCU1aZO9LLyJ+ztg0NxQbZw/W+b+ojg2vM9cvjeMOVY
         avGg==
X-Forwarded-Encrypted: i=1; AJvYcCWyAMrGPPCb7/i6egWAw9jEafGaRt031MNECqgqn1OpPCApwhGQoS/W2BM77mz2a9uWmU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLp40PhehGfJdMgRo0l+rW5t8JMIJFldGMuyJQG4eTWYamAuPh
	0j01Mcm9L86lfVwflr+lOhmbgetv06BG2r9NdIoGa6nbT1SYQV3wqSB16v0FO4zWwH/uMPZlvJF
	Es3ob/w==
X-Received: from pfld9.prod.google.com ([2002:a05:6a00:1989:b0:7dd:8bba:6393])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d98:b0:827:3307:170
 with SMTP id d2e1a72fcca58-829a2eaad00mr8915615b3a.37.1773104779156; Mon, 09
 Mar 2026 18:06:19 -0700 (PDT)
Date: Mon, 9 Mar 2026 18:06:17 -0700
In-Reply-To: <20260309-gmem-st-blocks-v3-2-815f03d9653e@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309-gmem-st-blocks-v3-0-815f03d9653e@google.com> <20260309-gmem-st-blocks-v3-2-815f03d9653e@google.com>
Message-ID: <aa9uiQ_KBcX7X0My@google.com>
Subject: Re: [PATCH RFC v3 2/4] KVM: guest_memfd: Set release always on
 guest_memfd mappings
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	rientjes@google.com, rick.p.edgecombe@intel.com, yan.y.zhao@intel.com, 
	fvdl@google.com, jthoughton@google.com, vannapurve@google.com, 
	shivankg@amd.com, michael.roth@amd.com, pratyush@kernel.org, 
	pasha.tatashin@soleen.com, kalyazin@amazon.com, tabba@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 09, 2026, Ackerley Tng wrote:
> Set release always on guest_memfd mappings to enable the use of
> .invalidate_folio, which performs inode accounting for guest_memfd.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  virt/kvm/guest_memfd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 77219551056a7..8246b9fbcf832 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -607,6 +607,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  	mapping_set_inaccessible(inode->i_mapping);
>  	/* Unmovable mappings are supposed to be marked unevictable as well. */
>  	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> +	mapping_set_release_always(inode->i_mapping);

*sigh*

So... an internal AI review bot flagged setting AS_RELEASE_ALWAYS as being
potentially problematic, and I started poking around, mostly because I was
curious.  I'm pretty sure the exact scenario painted by the bot isn't possible,
but I do think a similar issue exists in at least truncate_error_folio().  Or at
least, *should* exist, but doesn't because of a different bug.

On memory error, kvm_gmem_error_folio() will get invoked via this code.  Note
the "err != 0" check.  kvm_gmem_error_folio() returns MF_DELAYED, which has an
arbitrary value of '2', and so KVM is always signalling "failure".

		int err = mapping->a_ops->error_remove_folio(mapping, folio);

		if (err != 0)
			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
		else if (!filemap_release_folio(folio, GFP_NOIO))
			pr_info("%#lx: failed to release buffers\n", pfn);

I _think_ that's bad?  On x86, if I'm following the breadcrubs correctly, we'll
end up in this code in kill_me_maybe()

	pr_err("Memory error not recovered");
	kill_me_now(cb);

and send what I assume is a relatively useless SIGBUS and likely kill the VM.

	struct task_struct *p = container_of(ch, struct task_struct, mce_kill_me);

	p->mce_count = 0;
	force_sig(SIGBUS);

But even if that's somehow the "right" behavior, we're doing it purely by
accident.

As for this patch, if we fix that bug by returning 0, then filemap_release_folio()
is definitely reachable by at least one flow, so I think guest_memfd also needs
to implement release_folio()?


    
Full AI bot text:
--
Setting the AS_RELEASE_ALWAYS flag causes folio_needs_release() to return
true. This correctly triggers .invalidate_folio during truncation, but does
it also unintentionally expose guest_memfd folios to eviction via
posix_fadvise(POSIX_FADV_DONTNEED)?

If userspace calls posix_fadvise() on a guest_memfd file, the core mm
calls mapping_evict_folio(). Because folio_needs_release() is true, it
calls filemap_release_folio().

Since guest_memfd does not implement a .release_folio address space
operation, filemap_release_folio() falls back to calling
try_to_free_buffers(). Could this fallback cause a warning?

fs/buffer.c:try_to_free_buffers() {
	...
	/* Misconfigured folio check */
	if (WARN_ON_ONCE(!folio_buffers(folio)))
		return true;
	...
}

Because the guest_memfd folio has no private data, folio_buffers()
is NULL, which will trigger this WARN_ON_ONCE.

Furthermore, try_to_free_buffers() returns true, allowing the folio to be
removed from the page cache. Because this eviction path bypasses
truncate_cleanup_folio(), it never calls .invalidate_folio.

Does this mean inode_sub_bytes() is skipped, leaking the inode block
accounting?

Userspace could potentially trigger the warning and infinitely inflate the
inode's block count with:
    struct kvm_create_guest_memfd args = { .size = 4096 };
    int fd = ioctl(kvm_vm_fd, KVM_CREATE_GUEST_MEMFD, &args);
    fallocate(fd, 0, 0, 4096);
    posix_fadvise(fd, 0, 4096, POSIX_FADV_DONTNEED);
Should guest_memfd implement a .release_folio callback that simply
returns false to prevent these folios from being evicted?
--
