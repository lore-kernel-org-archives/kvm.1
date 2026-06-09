Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454413DA5BD
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039701; cv=none; b=mlTb6QElvOAZLOykNNuJE32fuK+vteGtrU+ohAO+retDyQSCwmOGYDAJ+FlPU/TI4N/wl9priQ2ecHBIcLq9O4NLWqz4IVkd8liF1b3r+YY6hwk0zbpIUimBi0Hwyxr4xhAW50RpkljIfVabPMAGfmdpSVh2zR69QBt9Whl1HFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039701; c=relaxed/simple;
	bh=7wx/dxAdd1u1AUsRpIVgK0Xty/RNsritsHmHYSiHYCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FlHE4ZWSGZTzGbc5Hfesi0LtgTyYBJR6mS+FGPayNOtjxr6cFOVBGerMmoEvYj4Qt6n95tGrlofjPNoGxkWrxJj3zDi81pwAQLgg88/EzCIP7fMnqZvfKpgimhaJgdUicPYbnYh+6CII0Ea4yMKecYa6bx92jEBV1rpsD7w2r/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KijfhMX/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KijfhMX/"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2a4babe45so6400065ad.2
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781039699; x=1781644499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aP6Y+fD/sI0lpubZCz3MeHaUTq/3QLbAestX392/ZLw=;
        b=KijfhMX/amhcnkZ5ABKsGfj60GC0ITC298Cb4iS0fbGhFQJ/J5+vzZ0tX38LboEV6I
         iFdYy+0wfx7KizJdzPc+ysvGP/WkMkEjbhFAQeWEVrY148Vqnw7c1C1i9WERcjak7cWO
         qLLTajfAAnoSqQsM/O7PK6mEg43UQDZSzdE/XHQZc3VJ323cMYyVF9QBwV8ihu01LV36
         e6mx6MSSLA1KJdwYtVaKJC/wfnmkcFxBGVk9I9fp+qt4b4K0zaVvO9CQNLTpXroHgS6n
         wHy9/lqZrXgum2SU+ExDBaEo3eRhHS+jTJkJwhr3GAzOkJ2+aSVEI8prcXOKmZdrW+le
         BtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781039699; x=1781644499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aP6Y+fD/sI0lpubZCz3MeHaUTq/3QLbAestX392/ZLw=;
        b=EAencvJpCHfuVA75iIgH9EPMWI2Ea3KreM3fs+ar2cjLoYHfcFkgWFeph71cKHMV/x
         uj7kXdolwddUVb8cNl5j2oaAqnMJGfHdKycDcvmI/SEpNguIsASy0u/+yxTVXFMxrxjT
         inTNuHAMN6qzHTI0oiTlwQbvC9+aNkuHQ5UB45Eug25f9fzqOu+yxizaH4wJORvuZxT/
         8bVMnUPUrftTFNM9a33VtOs5V9e16gj6QPO8UKekt4cy5Y9744pYJTIOBdd98aEkVlSW
         Gvcka3g9HSZ9i2bIKeduypqlvxPKbPsE0nQ7LaDnyaCCKk57R8yU7dxsBnvq9tyLfxaA
         NMJg==
X-Forwarded-Encrypted: i=1; AFNElJ/vfkqV+nQ+KqdnFz5zgBD5i+z8qQFHcv11ZkD1QdVTArhC6wfYitpvoRHa4XvaQRBgQXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQthhoQ6Y1WGct43bt3zbcLB7zsg9e83KnfikaFwRexow07kp
	7dPRGFVAaBzxugmExYCsJ1yvZR6E3I28e3CDKeTAU0mBTZgkr09iGBLoW0xgjShsuh5nHT7oLgB
	7DUE0gg==
X-Received: from plsc21.prod.google.com ([2002:a17:902:b695:b0:2be:f9c0:8cd4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8f:b0:2bf:1e59:d99
 with SMTP id d9443c01a7336-2c1e80f9ea3mr251802065ad.8.1781039699168; Tue, 09
 Jun 2026 14:14:59 -0700 (PDT)
Date: Tue, 9 Jun 2026 14:14:58 -0700
In-Reply-To: <20260609154046-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com>
 <178102235481.2735841.1203781071933134475.b4-ty@google.com> <20260609154046-mutt-send-email-mst@kernel.org>
Message-ID: <aiiCUh7sMbzb56Dk@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: fix NUMA interleave index double-counting
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Shivank Garg <shivankg@amd.com>, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 09, 2026, Michael S. Tsirkin wrote:
> On Tue, Jun 09, 2026 at 09:31:29AM -0700, Sean Christopherson wrote:
> > On Wed, 03 Jun 2026 11:57:33 -0400, Michael S. Tsirkin wrote:
> > > kvm_gmem_get_policy() sets *ilx to the full page offset
> > > (vm_pgoff + vma offset).  But get_vma_policy() adds the page
> > > offset on top of *ilx, so the offset is counted twice.  This
> > > causes NUMA interleaving to skip nodes: for order-0 pages the
> > > effective index jumps by 2 for each consecutive page.
> > > 
> > > The get_policy vm_op should return only a per-file bias in *ilx
> > > (like shmem_get_policy does with inode->i_ino), letting
> > > get_vma_policy() add the page-offset component.
> > > 
> > > [...]
> > 
> > Applied to kvm-x86 gmem, with a heavily massaged changelog to explicitly spell
> > out that ilx == interleave index, and to try and explain the role of the index
> > (it wasn't at all obvious to me why using the inode number was "correct").
> > 
> > Thanks!
> > 
> > [1/1] KVM: guest_memfd: fix NUMA interleave index double-counting
> >       https://github.com/kvm-x86/linux/commit/48dbe4732198
> 
> Thanks!
> 
> Sean, what is your take on interleaving for guest_memfd?
> 
> To the best of my understanding:
> 
> Right now IIUC kvm calls __filemap_get_folio_mpol which in turn does not pass
> the index to filemap_alloc_folio. That uses NO_INTERLEAVE_INDEX, so
> MPOL_INTERLEAVE uses the task's global counter - effectively
> unpredictable placement. This looks like an oversight (the index was
> available but never threaded down), but it's been shipping since 6.19.
> 
> Should we fix it to use the file offset instead? Or GPA? And if so,
> should that be the default or does userspace need a way to opt out of
> NO_INTERLEAVE_INDEX?

Honestly, I wouldn't bother fixing the issue for guest_memfd.  If someone wants
to pursue a fix for a different use case, then we can piggyback that effort, but
I don't think it's worth the effort for guest_memfd.

In practice, I doubt anyone will run guest_memfd with MPOL_INTERLEAVE.  Maybe
when we get to the point where guest_memfd is usable for "normal" VMs?  But even,
splattering a single guest memslot across multiple NUMA nodes is all bug guaranteed
to provide suboptimal performance.  E.g. if the user cares about NUMA policy, I
would expect a given guest_memfd instance to be bound to a specific node.
