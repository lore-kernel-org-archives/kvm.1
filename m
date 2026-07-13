Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C7357CF8
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783972616; cv=none; b=c0hyQRuKmzOB1/EMxFxjR6VKtpnXzXLD701IDGUPwwpVjjlPaSSFrD0dq+qQucMDwtdsmnvjOVZ4hmV2uiqH/RyehVm6rruvfkTgwumMjqS4/+8D6Pe5TZnBP3X1CUjGeMEST2q9H9Xnof6eSg0Zg446sxNX4V97Ivof5F3uB/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783972616; c=relaxed/simple;
	bh=s0Y4B1pnA9YteH+Zg5F0xsAI4/mtsGCoTOE3uyu5kXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ix02KxL4yO/MNs9Mv+fahkIl49No8IQQ99KyRKbFlCfCGQXHexHNAcJU8lYVkYBS6rXDXbTDnmvai2m68/Tw0OlJyBRVYUwe/4/HqD204OmiX48U+eU42strrgoLnl3dAqpNw7W5/vdxRC6D3kyvPHuvSVqdUz2V+z7ZQKJ0xrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ov85PF1h; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ov85PF1h"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ccd1958e8fso1901905ad.2
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783972614; x=1784577414; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KbftFgU32sFJyzTTCK2ciqKa+kJhKYSaoYgRRfgYlz8=;
        b=Ov85PF1hA43DT1kkeDnklOyIYJg6XtmaydzcuU3LvA6LM42gfbI919T+HHOUzJ1ml+
         mrEOodXeqka5Im5OoAaJLx4vo0lGEzSxzdjJm/qoITdQwMO2/SGw/Jg7kokIC1ogx85+
         0jCeDW1XyPEa5z20AkuO805XbMNifWwsF75FuvSWsV35sx5p1kL65CGh78D3MAZXmEDV
         a/fjMgL/8Pgrj2J7L4nPcvnhhJ9rXA4Gz7ezzHll7HlZ3qN3mymZq1k3/v2G2fWDfJVD
         xaeZnTqVX2knhMSPNVGRptkJu/LqfgCEhiFDaRxNiX7MyBoQwytucEqO6xw3Abj+7gNP
         qqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783972614; x=1784577414;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KbftFgU32sFJyzTTCK2ciqKa+kJhKYSaoYgRRfgYlz8=;
        b=BVDq9+4Zs3NCiyos6wmwbWsUOJYe/fc0pS/LMKhwfKbtyAgtWojoJKMkFamSxMhaHF
         UIHqqwtx7kukhrcpAXkb8j9WbhtHyNuqe7WgPHCYp6N9ZzTffQ3Pwgvow7wdWnTOB77D
         sGHczsLB10mUKgQDrP01j0wMDQXMB9LIN8cG4azm0ct347AQgi09GAp+M4vstb0MTewB
         3GEkLEZxKK6tZASYBnzuIFS2XXXh/Cy1gYvS6w6QPPvHO75/yoeRgAe3fsIR+CFXk1+a
         AenzGDJZ1Pme2Mgbh5DC+MtoICpEdrggHJdO8hKgHbzWm0mVv5d9XveW8eRWkMR85O9d
         9n8w==
X-Forwarded-Encrypted: i=1; AHgh+Rp7iHsJd1UuIGruNIM381Z/leYA2sYF+Ahty4w0vODbZQY960AbN2xjDR+BZ+2YZl5jxNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNSRWBn/QO6z+cGSj4fT6fk5IQZB2mZSCdWI/dz5SSW/0AtrY
	uMg9Al50uJPZnbVQV2PJLlNDIOHYzdmdDY/GLXhs/7h6daEbcQ9zmzB+cvsFLVu3fGuS4p8TjVe
	/F7iGLA==
X-Received: from plnm6.prod.google.com ([2002:a17:902:fda6:b0:2ca:b48c:5a92])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c405:b0:2c9:dbdc:c0e
 with SMTP id d9443c01a7336-2ce9ee11445mr108519855ad.26.1783972614175; Mon, 13
 Jul 2026 12:56:54 -0700 (PDT)
Date: Mon, 13 Jul 2026 12:56:53 -0700
In-Reply-To: <CA+EHjTxLKvj-qOQFgZ66Pq+ULQ0D98QU65gGe_2wWnR5_fTa0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-19-seanjc@google.com>
 <CA+EHjTxJMfiGoJGetvsOWXeHjFQexFh=sdQ_kvSQT86uztAaLQ@mail.gmail.com>
 <CAEvNRgFgaDx9OivkKteksk36OvchMNmAk=i8CZj31huxqXB-Pg@mail.gmail.com> <CA+EHjTxLKvj-qOQFgZ66Pq+ULQ0D98QU65gGe_2wWnR5_fTa0A@mail.gmail.com>
Message-ID: <alVDBWOl5tGZb1Wm@google.com>
Subject: Re: [PATCH v4 18/18] KVM: guest_memfd: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Roth <michael.roth@amd.com>, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 13, 2026, Fuad Tabba wrote:
> On Mon, 13 Jul 2026 at 16:41, Ackerley Tng <ackerleytng@google.com> wrote:
> >
> > Fuad Tabba <fuad.tabba@linux.dev> writes:
> >
> > >
> > > [...snip...]
> > >
> >
> > Thanks for bringing [1] up, I didn't make the link when this change was
> > being discussed.
> >
> > pKVM definitely needs a callback when the folio is released from
> > guest_memfd's ownership.
> >
> > >
> > > free_folio is the only to_private=false caller today, but the cover
> > > letter sketches the other one, a private->shared conversion through
> > > kvm_gmem_make_shared(inode, start, end). Once that lands both reach
> > > the hook with to_private=false, and as far as I can tell, the only
> > > thing separating them is kvm == NULL / INVALID_GPA. That isn't
> >
> > On the folio teardown path kvm has to be non-NULL so that SNP can find
> > out which VM to unassign from, so you're right that INVALID_GPA won't be
> > sufficient to separate conversion to private and teardown, for pKVM,
> > from the arch perspective.
> >
> > > documented as a contract, and nothing in-tree reads it on that branch
> > > (the kvm/gpa check is under if (to_private), and
> > > sev_gmem_make_shared() doesn't take a kvm at all), so nothing would
> > > catch it regressing. The sketch is also inode-scoped, so I'm not sure
> > > the conversion path passes a non-NULL kvm at all; if it doesn't, the
> > > two aren't distinguishable.
> > >
> > >>
> > >> [...snip...]
> > >>
> > >
> > > The Kconfig now couples them too: an arch can't take teardown without also
> > > taking conversion. pKVM wants teardown and not conversion, so that's a problem
> > > for us today, not only once the second caller lands.
> > >
> > > This is the same ground as v8 15/46, which ended with the two split under
> > > separate Kconfigs. Suzuki confirmed CCA disables both; pKVM wants teardown only,
> > > since our conversions are guest-initiated and EL2 has already done the
> > > transition by the time the host runs the generic path [1].
> > >
> > > I'd rather keep the free path on its own callback. If you want a single hook,
> > > passing the caller explicitly instead of leaving it implied by kvm would work
> > > too. Merging the two conversion directions is a genuine cleanup, it's the free
> > > path I'd like to keep separate.
> > >
> >
> > Is it okay if later, we add a .gmem_teardown callback with a new CONFIG
> > flag that pKVM can use?
> 
> That works for me, and I agree it's nicer to introduce the callback along
> with its first user.
> 
> Sean, is that the plan you have in mind as well? Two things that matter for
> pKVM when it lands: the new CONFIG needs to be independent of the conversion
> one, so that free_folio fires for an arch that selects only teardown (pKVM
> wants teardown and not conversion), and the teardown callback stays distinct
> from a private->shared conversion. Good point on teardown needing a non-NULL
> kvm for SNP,

Converting back to SHARED doesn't require a non-NULL @kvm pointer.  SNP needs
the ASID and thus the VM when assigning memory to a VM, but converting memory
back to SHARED, i.e. returning to the host, doesn't need that information.

> incidentally, that's another reason keying off the sentinel wouldn't have
> worked.

It can work, but it would be all kinds of gross, and arguably wrong.  To pass
a non-NULL @kvm for the true convert-to-shared (not reclaim), guest_memfd would
need to iterate over all bindings to get at the @kvm instances.  That's "fine",
but wasteful and confusing because the SNP conversion is a platform-level thing
(as above, unassigning from a VM doesn't require any information about the VM).

> If that's where this is heading, I'm happy.

Yeah, this is roughly what the total diff will look like.

diff --git arch/x86/include/asm/kvm-x86-ops.h arch/x86/include/asm/kvm-x86-ops.h
index 6091987860bd..1764bad03b17 100644
--- arch/x86/include/asm/kvm-x86-ops.h
+++ arch/x86/include/asm/kvm-x86-ops.h
@@ -146,7 +146,7 @@ KVM_X86_OP(vcpu_deliver_sipi_vector)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
 KVM_X86_OP_OPTIONAL(get_untagged_addr)
 KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
 KVM_X86_OP_OPTIONAL_RET0(gmem_convert)
 #endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
diff --git arch/x86/include/asm/kvm_host.h arch/x86/include/asm/kvm_host.h
index a70e734af122..08c4af487fa1 100644
--- arch/x86/include/asm/kvm_host.h
+++ arch/x86/include/asm/kvm_host.h
@@ -1724,7 +1724,7 @@ struct kvm_x86_ops {
 
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
 	int (*gmem_convert)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 			    kvm_pfn_t nr_pages, int max_order, bool to_private);
 #endif
diff --git arch/x86/kvm/Kconfig arch/x86/kvm/Kconfig
index 52e75d83a4d2..538ed1e80332 100644
--- arch/x86/kvm/Kconfig
+++ arch/x86/kvm/Kconfig
@@ -161,6 +161,7 @@ config KVM_AMD_SEV
 	select ARCH_HAS_CC_PLATFORM
 	select KVM_GENERIC_MEMORY_ATTRIBUTES
 	select HAVE_KVM_ARCH_GMEM_CONVERT
+	select HAVE_KVM_ARCH_GMEM_RECLAIM
 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
 	select HAVE_KVM_ARCH_GMEM_POPULATE
 	help
diff --git arch/x86/kvm/x86.c arch/x86/kvm/x86.c
index f0c49a92d041..11017f49b94a 100644
--- arch/x86/kvm/x86.c
+++ arch/x86/kvm/x86.c
@@ -10625,6 +10625,16 @@ int kvm_arch_gmem_convert(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 {
 	return kvm_x86_call(gmem_convert)(kvm, gfn, pfn, nr_pages, max_order, to_private);
 }
+#endif
+
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
+void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
+{
+	WARN_ON_ONCE(kvm_x86_call(gmem_convert)(NULL, -1ull, pfn, nr_pages, max_order, false));
+}
+#endif
+
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	kvm_x86_call(gmem_invalidate_range)(kvm, range);
diff --git include/linux/kvm_host.h include/linux/kvm_host.h
index 9391ffcc90ff..fdbd697d0337 100644
--- include/linux/kvm_host.h
+++ include/linux/kvm_host.h
@@ -2614,6 +2614,10 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
 		       kvm_gmem_populate_cb post_populate, void *opaque);
 #endif
 
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
+void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int order);
+#endif
+
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 #endif
diff --git virt/kvm/Kconfig virt/kvm/Kconfig
index 53803c5777a4..c3c0ee253fc7 100644
--- virt/kvm/Kconfig
+++ virt/kvm/Kconfig
@@ -111,6 +111,10 @@ config HAVE_KVM_ARCH_GMEM_CONVERT
        bool
        depends on KVM_GUEST_MEMFD
 
+config HAVE_KVM_ARCH_GMEM_RECLAIM
+       bool
+       depends on KVM_GUEST_MEMFD
+
 config HAVE_KVM_ARCH_GMEM_INVALIDATE
        bool
        depends on KVM_GUEST_MEMFD
diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
index aeb765831c32..173a7ed008d1 100644
--- virt/kvm/guest_memfd.c
+++ virt/kvm/guest_memfd.c
@@ -516,13 +516,11 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 	return MF_DELAYED;
 }
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 static void kvm_gmem_free_folio(struct folio *folio)
 {
-	WARN_ON_ONCE(kvm_arch_gmem_convert(NULL, -1ull,
-					   folio_file_pfn(folio, 0),
-					   folio_nr_pages(folio),
-					   folio_order(folio), false));
+	kvm_arch_gmem_reclaim(folio_file_pfn(folio, 0), folio_nr_pages(folio),
+			      folio_order(folio));
 }
 #endif
 
@@ -530,7 +528,7 @@ static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
 	.migrate_folio	= kvm_gmem_migrate_folio,
 	.error_remove_folio = kvm_gmem_error_folio,
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 	.free_folio = kvm_gmem_free_folio,
 #endif
 };
