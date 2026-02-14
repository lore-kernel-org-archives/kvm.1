Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EED1EA84
	for <kvm@vger.kernel.org>; Sat, 14 Feb 2026 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771029422; cv=none; b=ikdB5/mpYlfL7Ujn169ZJqs/bbExXNyvz/uefZu5+drJcUdjXeJ1mXZQHWcslI9kfeKkMnwcqgTQBKuhg7ck9JCgzdmOlUfsOeGaLMdFiTioCuVNjdKakJPBzHQ4VYQmnjS98Gln6H1NJotbiA1YZzs5Fw4U/nOA5iXDjFZOwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771029422; c=relaxed/simple;
	bh=1w4LM5PQVG67eF+3gc5Zf2pndgawG4E6tIyekorJjJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PpqqaBAkWquQX4JTBXL84EVr5xClJu/6j/ZPIJpZU9rnpU3vuLQsAPZev/FKd6CcPit21Z3k5btjCVUEeK+j4gsm8YEkd0MP5jJ99pBny7gItWE834HZIJb9PVccgOtVwJg18VwXq2TMoHKWaD/hs37dgve9pFyOlh9l3MFlswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXvKzHv+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXvKzHv+"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3562370038dso1383408a91.3
        for <kvm@vger.kernel.org>; Fri, 13 Feb 2026 16:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771029421; x=1771634221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jw4NOzYyu3Tg6/nySFD7/NaG43nHhMvkjR2BPJOGgAY=;
        b=IXvKzHv+cRp+u/FNTg1kIJaFlLBBuMS13dcrh14oLlun2bqDETpgzkRtgX+KKfOYYn
         laD737Iunwxjbv+ta5K9pk/7UmOh2sH0STxaLSLk6Na4MypaLLXZOWoSbkKpqWVFOVGP
         VuXMGGwgOgG5SWll72obBk2IjdtPtYTe75UmeC1yzZ72NRkTU1b9IBfgB8qJ9eGzR7Vd
         T1Sayu2gNoKLX7S8tUUvjiu4rCgAc4o3uoM8jr/+BZi5UWeeYqPD7kGvbqYS+o7c4L6G
         fVXxvR7bgPIcZK2Ux4KUif6X0SdNwusA+xbqOCpTcWcbEyheKd4KeSRJZ90YHWzDuZWE
         5r5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771029421; x=1771634221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jw4NOzYyu3Tg6/nySFD7/NaG43nHhMvkjR2BPJOGgAY=;
        b=gI4rFxzF24lxuSU1s2lxQCXkBuPf/wmncpSemnJbX76oA32OGAKSdbj2tkwLxk2xNW
         6YavQzCIjRAEd5AmxxSb7O8/C6Fjlg/k++OERV6h4PIkDVjN61B+X7ScF84WpbjizZ61
         xHxrOPg9GvEMLfU8fCl6iTyQ3GotwgXslvADmnqcQ3aDA3gWNcbc6gKCL9lhu8rU87tD
         Dfp/IMjIQTRkkhI6eHpy6V8PVFPwBNQGVkVnTStqCYypttFLsxRYfy+EZzfSawSpovoI
         +aq/25SBLbzBDLsDcepUb1IuX7BgKyIN6fgPTk8/ux1g52ytyfXtydufBR1CqltX93c1
         UwSg==
X-Forwarded-Encrypted: i=1; AJvYcCWfyCx+F5VEJzdXlBvqdOmuLTeSOrREYfjsOWAeNup2byuchtzDLrOeCK7ULe/hFkTWOx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9bD3Ym2NHu956nYv5bPyD+8qqJl4qRZCeoi/RymCziy2G2PKy
	Gs96GA2o0wQWkYDQL04SYdex3JmZ+QvRw6BrEzqSSIYAAd8SL6rr12qONxFB+FiVD2Z87yCnpHg
	5fIJXVg==
X-Received: from pjtl22.prod.google.com ([2002:a17:90a:c596:b0:356:3749:88e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:578c:b0:34e:630c:616c
 with SMTP id 98e67ed59e1d1-356aada85c7mr2731474a91.31.1771029420911; Fri, 13
 Feb 2026 16:37:00 -0800 (PST)
Date: Fri, 13 Feb 2026 16:36:59 -0800
In-Reply-To: <aYvmlBb6oR3lfWn2@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129011517.3545883-9-seanjc@google.com> <aYMMHVvwDjZ7Lz9l@yzhao56-desk.sh.intel.com>
 <aYP_Ko3FGRriGXWR@google.com> <aYQtIK/Lq5T3ad6V@yzhao56-desk.sh.intel.com>
 <aYUarHf3KEwHGuJe@google.com> <aYVPN5M7QQwu/r/n@yzhao56-desk.sh.intel.com>
 <aYYn0nf2cayYu8e7@google.com> <aYsOV7Q5FTWo+6/x@yzhao56-desk.sh.intel.com>
 <aYuMaRbVQyUfYJTP@google.com> <aYvmlBb6oR3lfWn2@yzhao56-desk.sh.intel.com>
Message-ID: <aY_Dq3riRLUNFZfr@google.com>
Subject: Re: [RFC PATCH v5 08/45] KVM: x86/mmu: Propagate mirror SPTE removal
 to S-EPT in handle_changed_spte()
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Sagi Shahar <sagis@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 11, 2026, Yan Zhao wrote:
> On Tue, Feb 10, 2026 at 11:52:09AM -0800, Sean Christopherson wrote:
> > > > +static void handle_changed_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
> > > > +				gfn_t gfn, u64 old_spte, u64 new_spte,
> > > > +				int level, bool shared)
> > > > +{
> > > Do we need "WARN_ON_ONCE(is_mirror_sptep(sptep) && shared)" here ? 
> > 
> > No, because I want to call this code for all paths, including the fault path.
> Hmm. IIUC, handle_changed_spte() can't be invoked for mirror root under read
> mmu_lock.
> For read mmu_lock + mirror scenarios, they need to invoke
> tdp_mmu_set_spte_atomic() --> __handle_changed_spte(). 

Oh, sorry, I misread that.  Now I see what you're saying.  I think I'd still prefer
to omit the WARN?  Because there's nothing inherently wrong with using
handle_changed_spte().  E.g. if the caller can somehow guarantee success, then
using handle_changed_spte() is a-ok.

> Besides, __handle_changed_spte() contains code like
> "kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);", which may have
> incorrectly updated the stats even if kvm_x86_call(set_external_spte)() fails
> later and the new_spte is never written to iter->sptep.

Oof, now _that_ is an actual problem.  This is the least-ugly fix I can come up
with.  Note, this will mean the trace order is "wrong" when removing a non-mirror
page table, as KVM will zap the page table before its children.  I doubt that'll
be a problem in practice, so I'm inclined to take the simpler code.

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index d395da35d5e4..4ba789f2824d 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -493,6 +493,7 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
        bool is_leaf = is_present && is_last_spte(new_spte, level);
        bool pfn_changed = spte_to_pfn(old_spte) != spte_to_pfn(new_spte);
        int as_id = kvm_mmu_page_as_id(sp);
+       int r;
 
        WARN_ON_ONCE(level > PT64_ROOT_MAX_LEVEL);
        WARN_ON_ONCE(level < PG_LEVEL_4K);
@@ -524,8 +525,6 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
        if (old_spte == new_spte)
                return 0;
 
-       trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
-
        if (is_leaf)
                check_spte_writable_invariants(new_spte);
 
@@ -554,9 +553,6 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
                return 0;
        }
 
-       if (is_leaf != was_leaf)
-               kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
-
        /*
         * Recursively handle child PTs if the change removed a subtree from
         * the paging structure.  Note the WARN on the PFN changing without the
@@ -567,11 +563,19 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
         * changes to the external SPTE.
         */
        if (was_present && !was_leaf &&
-           (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
+           (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
                handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
-       else if (is_mirror_sp(sp))
-               return kvm_x86_call(set_external_spte)(kvm, gfn, old_spte,
-                                                      new_spte, level);
+       } else if (is_mirror_sp(sp)) {
+               r = kvm_x86_call(set_external_spte)(kvm, gfn, old_spte,
+                                                   new_spte, level);
+               if (r)
+                       return r;
+       }
+
+       trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
+
+       if (is_leaf != was_leaf)
+               kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
 
        return 0;
 }

> > >   3. set *iter->sptep to new_spte 
> > > 
> > >   what if __handle_changed_spte() reads *iter->sptep in step 2?
> > 
> > For the most part, "don't do that".  There are an infinite number of "what ifs".
> > I agree that re-reading iter->sptep is slightly more likely than other "what ifs",
> > but then if we convert to a boolean it creates the "what if we swap the order of
> > @as_id and @is_mirror_sp"?  Given that @old_spte is provided, IMO re-reading the
> > SPTE from memory will stand out.
> As my above concern, re-reading SPTE in __handle_changed_spte() will just get
> value FROZEN_SPTE instead of the value of new_spte.
> 
> > That said, I think we can have the best of both worlds.  Rather than pass @as_id
> > and @sptep, pass the @sp, i.e. the owning kvm_mmu_page.  That would address your
> > concern about re-reading the sptep, without needing another boolean.
> Hmm, my intention of passing boolean is to avoid re-reading sptep, because
> in step 2, we pass new_spte instead of the real value in sptep (which is
> FROZEN_SPTE for mirror sp) to __handle_changed_spte().
> So, passing @sp may not help?

It won't prevent someone that's bound and determined to introduce a bug from
re-reading the sptep, but it most definitely helps.  To get at the sptep, someone
would have to compute its index based off @gfn and then look it up in @sp->spt.
At that point, they've earned the bug :-)
